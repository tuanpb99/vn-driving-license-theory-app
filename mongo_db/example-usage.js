// Example Usage of Question Database
// Các ví dụ sử dụng database câu hỏi thi bằng lái xe

const QuestionDatabase = require('./query-helper');

async function examples() {
  const db = new QuestionDatabase();
  
  try {
    await db.connect();
    console.log('🎯 Examples of using Question Database\n');
    
    // ============================================
    // Example 1: Lấy thống kê tổng quan
    // ============================================
    console.log('📊 Example 1: Get Statistics');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const stats = await db.getStatistics();
    console.log(`Total questions: ${stats.total}`);
    console.log(`Categories: ${stats.totalCategories}`);
    console.log(`Questions with images: ${stats.questionsWithImages}`);
    console.log(`Critical questions: ${stats.criticalQuestions}\n`);
    
    // ============================================
    // Example 2: Lấy câu hỏi theo số thứ tự
    // ============================================
    console.log('🔢 Example 2: Get Question by Number');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const question1 = await db.getQuestionByNumber(1);
    console.log(`Question ${question1.number}: ${question1.question}`);
    console.log(`Category: ${question1.category}`);
    console.log('Answers:');
    question1.answers.forEach((a, i) => {
      console.log(`  ${i + 1}. ${a.text} ${a.correct ? '✓' : ''}`);
    });
    console.log();
    
    // ============================================
    // Example 3: Lấy câu hỏi theo danh mục
    // ============================================
    console.log('📂 Example 3: Get Questions by Category');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const khaiNiemQuestions = await db.getQuestionsByCategory('khai-niem', 3);
    console.log(`Found ${khaiNiemQuestions.length} questions in "khai-niem" category:`);
    khaiNiemQuestions.forEach(q => {
      console.log(`  - Q${q.number}: ${q.question.substring(0, 60)}...`);
    });
    console.log();
    
    // ============================================
    // Example 4: Lấy câu hỏi điểm liệt
    // ============================================
    console.log('⚠️  Example 4: Get Critical Questions');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const criticalQuestions = await db.getCriticalQuestions(5);
    console.log(`Found ${criticalQuestions.length} critical questions:`);
    criticalQuestions.forEach(q => {
      console.log(`  - Q${q.number} [${q.category}]: ${q.question.substring(0, 50)}...`);
    });
    console.log();
    
    // ============================================
    // Example 5: Lấy câu hỏi có hình ảnh
    // ============================================
    console.log('🖼️  Example 5: Get Questions with Images');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const imageQuestions = await db.getQuestionsWithImages(3);
    console.log(`Found ${imageQuestions.length} questions with images:`);
    imageQuestions.forEach(q => {
      console.log(`  - Q${q.number}: ${q.question.substring(0, 50)}...`);
      console.log(`    Image: ${q.hinhanhq}`);
    });
    console.log();
    
    // ============================================
    // Example 6: Lấy câu hỏi ngẫu nhiên
    // ============================================
    console.log('🎲 Example 6: Get Random Questions');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const randomQuestions = await db.getRandomQuestions(5);
    console.log(`Got ${randomQuestions.length} random questions:`);
    randomQuestions.forEach(q => {
      console.log(`  - Q${q.number} [${q.category}]: ${q.question.substring(0, 50)}...`);
    });
    console.log();
    
    // ============================================
    // Example 7: Tìm kiếm theo từ khóa
    // ============================================
    console.log('🔍 Example 7: Search Questions');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const searchResults = await db.searchQuestions('tốc độ', 5);
    console.log(`Found ${searchResults.length} questions containing "tốc độ":`);
    searchResults.forEach(q => {
      console.log(`  - Q${q.number}: ${q.question.substring(0, 60)}...`);
    });
    console.log();
    
    // ============================================
    // Example 8: Lấy danh sách danh mục
    // ============================================
    console.log('📋 Example 8: Get All Categories');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const categories = await db.getCategories();
    console.log(`Total categories: ${categories.length}`);
    categories.forEach(cat => {
      console.log(`  - ${cat}`);
    });
    console.log();
    
    // ============================================
    // Example 9: Đếm số câu hỏi theo danh mục
    // ============================================
    console.log('📊 Example 9: Count Questions by Category');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const categoryStats = await db.countByCategory();
    categoryStats.forEach(stat => {
      console.log(`  - ${stat.category}: ${stat.count} questions`);
    });
    console.log();
    
    // ============================================
    // Example 10: Tạo đề thi ngẫu nhiên
    // ============================================
    console.log('📝 Example 10: Generate Random Exam');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const exam = await db.generateExam({
      totalQuestions: 25,
      criticalQuestions: 5,
      questionsWithImages: 3
    });
    console.log(`Generated exam with ${exam.length} questions:`);
    console.log(`  - Critical questions: ${exam.filter(q => q.category.includes('diem-liet')).length}`);
    console.log(`  - Questions with images: ${exam.filter(q => q.hinhanhq).length}`);
    console.log(`  - Regular questions: ${exam.filter(q => !q.category.includes('diem-liet') && !q.hinhanhq).length}`);
    console.log('\nFirst 3 questions of the exam:');
    exam.slice(0, 3).forEach((q, i) => {
      console.log(`\n${i + 1}. [Q${q.number}] ${q.question}`);
      q.answers.forEach((a, j) => {
        const mark = a.correct ? '✓' : ' ';
        console.log(`   ${String.fromCharCode(65 + j)}. [${mark}] ${a.text}`);
      });
      if (q.explanation) {
        console.log(`   💡 ${q.explanation}`);
      }
    });
    console.log();
    
    // ============================================
    // Example 11: Lấy câu hỏi ngẫu nhiên theo danh mục
    // ============================================
    console.log('🎯 Example 11: Get Random Questions by Category');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    const randomBienBao = await db.getRandomQuestions(5, 'bien-bao');
    console.log(`Got ${randomBienBao.length} random questions from "bien-bao" category:`);
    randomBienBao.forEach(q => {
      console.log(`  - Q${q.number}: ${q.question.substring(0, 50)}...`);
    });
    console.log();
    
    console.log('✅ All examples completed successfully!');
    
  } catch (error) {
    console.error('❌ Error:', error.message);
    console.error(error);
  } finally {
    await db.disconnect();
  }
}

// Run examples
if (require.main === module) {
  examples();
}

module.exports = examples;
