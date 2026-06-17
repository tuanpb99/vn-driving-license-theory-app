// Query Helper for Driving License Questions Database
// This file provides useful functions to query the database

const { MongoClient } = require('mongodb');

const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017';
const DB_NAME = 'driving_license_db';
const COLLECTION_NAME = 'questions';

class QuestionDatabase {
  constructor() {
    this.client = null;
    this.db = null;
    this.collection = null;
  }

  async connect() {
    if (!this.client) {
      this.client = new MongoClient(MONGO_URI);
      await this.client.connect();
      this.db = this.client.db(DB_NAME);
      this.collection = this.db.collection(COLLECTION_NAME);
      console.log('✅ Connected to MongoDB');
    }
    return this;
  }

  async disconnect() {
    if (this.client) {
      await this.client.close();
      this.client = null;
      console.log('🔌 Disconnected from MongoDB');
    }
  }

  // Lấy tất cả câu hỏi
  async getAllQuestions(limit = 0) {
    const query = this.collection.find().sort({ number: 1 });
    if (limit > 0) {
      query.limit(limit);
    }
    return await query.toArray();
  }

  // Lấy câu hỏi theo số thứ tự
  async getQuestionByNumber(number) {
    return await this.collection.findOne({ number: parseInt(number) });
  }

  // Lấy câu hỏi theo danh mục
  async getQuestionsByCategory(category, limit = 0) {
    const query = this.collection.find({ category }).sort({ number: 1 });
    if (limit > 0) {
      query.limit(limit);
    }
    return await query.toArray();
  }

  // Lấy câu hỏi điểm liệt
  async getCriticalQuestions(limit = 0) {
    const query = this.collection.find({ 
      category: { $regex: 'diem-liet' } 
    }).sort({ number: 1 });
    if (limit > 0) {
      query.limit(limit);
    }
    return await query.toArray();
  }

  // Lấy câu hỏi có hình ảnh
  async getQuestionsWithImages(limit = 0) {
    const query = this.collection.find({ 
      hinhanhq: { $ne: null } 
    }).sort({ number: 1 });
    if (limit > 0) {
      query.limit(limit);
    }
    return await query.toArray();
  }

  // Lấy ngẫu nhiên N câu hỏi
  async getRandomQuestions(count = 10, category = null) {
    const pipeline = [];
    
    if (category) {
      pipeline.push({ $match: { category } });
    }
    
    pipeline.push({ $sample: { size: count } });
    
    return await this.collection.aggregate(pipeline).toArray();
  }

  // Tìm kiếm câu hỏi theo từ khóa
  async searchQuestions(keyword, limit = 20) {
    return await this.collection
      .find({
        $or: [
          { question: { $regex: keyword, $options: 'i' } },
          { explanation: { $regex: keyword, $options: 'i' } }
        ]
      })
      .limit(limit)
      .toArray();
  }

  // Lấy danh sách các danh mục
  async getCategories() {
    return await this.collection.distinct('category');
  }

  // Đếm số câu hỏi theo danh mục
  async countByCategory() {
    return await this.collection.aggregate([
      {
        $group: {
          _id: '$category',
          count: { $sum: 1 }
        }
      },
      {
        $sort: { count: -1 }
      },
      {
        $project: {
          category: '$_id',
          count: 1,
          _id: 0
        }
      }
    ]).toArray();
  }

  // Lấy thống kê tổng quan
  async getStatistics() {
    const total = await this.collection.countDocuments();
    const categories = await this.getCategories();
    const withImages = await this.collection.countDocuments({ 
      hinhanhq: { $ne: null } 
    });
    const critical = await this.collection.countDocuments({ 
      category: { $regex: 'diem-liet' } 
    });
    const categoryStats = await this.countByCategory();

    return {
      total,
      totalCategories: categories.length,
      categories,
      questionsWithImages: withImages,
      criticalQuestions: critical,
      categoryBreakdown: categoryStats
    };
  }

  // Tạo đề thi ngẫu nhiên
  async generateExam(config = {}) {
    const {
      totalQuestions = 25,
      criticalQuestions = 5,
      questionsWithImages = 3
    } = config;

    const exam = [];

    // Lấy câu hỏi điểm liệt
    if (criticalQuestions > 0) {
      const critical = await this.collection.aggregate([
        { $match: { category: { $regex: 'diem-liet' } } },
        { $sample: { size: criticalQuestions } }
      ]).toArray();
      exam.push(...critical);
    }

    // Lấy câu hỏi có hình ảnh
    if (questionsWithImages > 0) {
      const withImages = await this.collection.aggregate([
        { 
          $match: { 
            hinhanhq: { $ne: null },
            number: { $nin: exam.map(q => q.number) }
          } 
        },
        { $sample: { size: questionsWithImages } }
      ]).toArray();
      exam.push(...withImages);
    }

    // Lấy các câu hỏi còn lại
    const remaining = totalQuestions - exam.length;
    if (remaining > 0) {
      const others = await this.collection.aggregate([
        { 
          $match: { 
            number: { $nin: exam.map(q => q.number) }
          } 
        },
        { $sample: { size: remaining } }
      ]).toArray();
      exam.push(...others);
    }

    // Trộn ngẫu nhiên thứ tự câu hỏi
    return exam.sort(() => Math.random() - 0.5);
  }
}

// Export class
module.exports = QuestionDatabase;

// Example usage (chỉ chạy khi file được execute trực tiếp)
if (require.main === module) {
  (async () => {
    const db = new QuestionDatabase();
    
    try {
      await db.connect();
      
      console.log('\n📊 Database Statistics:');
      console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      const stats = await db.getStatistics();
      console.log(`Total questions: ${stats.total}`);
      console.log(`Total categories: ${stats.totalCategories}`);
      console.log(`Questions with images: ${stats.questionsWithImages}`);
      console.log(`Critical questions: ${stats.criticalQuestions}`);
      console.log('\nCategory breakdown:');
      stats.categoryBreakdown.forEach(cat => {
        console.log(`  - ${cat.category}: ${cat.count} questions`);
      });
      
      console.log('\n🎲 Generating sample exam (25 questions)...');
      const exam = await db.generateExam({
        totalQuestions: 25,
        criticalQuestions: 5,
        questionsWithImages: 3
      });
      console.log(`✅ Generated exam with ${exam.length} questions`);
      console.log('\nFirst 3 questions:');
      exam.slice(0, 3).forEach((q, i) => {
        console.log(`\n${i + 1}. [Q${q.number}] ${q.question}`);
        q.answers.forEach((a, j) => {
          const mark = a.correct ? '✓' : ' ';
          console.log(`   ${String.fromCharCode(65 + j)}. [${mark}] ${a.text}`);
        });
      });
      
    } catch (error) {
      console.error('❌ Error:', error.message);
    } finally {
      await db.disconnect();
    }
  })();
}
