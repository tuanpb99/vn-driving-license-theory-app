# 🚀 Quick Start Guide - Database Setup

## ✅ Đã hoàn thành

Database MongoDB đã được thiết lập thành công với:
- **Database**: `driving_license_db`
- **Collection**: `questions`
- **Tổng số câu hỏi**: 600 câu
- **Số danh mục**: 9 danh mục
- **Câu hỏi có hình ảnh**: 318 câu
- **Câu hỏi điểm liệt**: 60 câu

## 📊 Thống kê theo danh mục

| Danh mục | Số câu hỏi |
|----------|------------|
| Biển báo | 185 |
| Khái niệm | 133 |
| Tình huống | 115 |
| Khái niệm điểm liệt | 47 |
| Kỹ thuật | 47 |
| Cấu tạo | 37 |
| Văn hóa | 23 |
| Kỹ thuật điểm liệt | 11 |
| Văn hóa điểm liệt | 2 |

## 🔧 Các lệnh hữu ích

### Xem thống kê database:
```bash
npm run stats
```

### Kết nối MongoDB Shell:
```bash
mongosh
use driving_license_db
```

### Truy vấn mẫu:

#### 1. Lấy 10 câu hỏi đầu tiên:
```javascript
db.questions.find().limit(10)
```

#### 2. Lấy câu hỏi theo số:
```javascript
db.questions.findOne({ number: 1 })
```

#### 3. Lấy câu hỏi điểm liệt:
```javascript
db.questions.find({ category: { $regex: "diem-liet" } })
```

#### 4. Lấy 10 câu hỏi ngẫu nhiên:
```javascript
db.questions.aggregate([{ $sample: { size: 10 } }])
```

#### 5. Tìm kiếm theo từ khóa:
```javascript
db.questions.find({ 
  question: { $regex: "tốc độ", $options: "i" } 
})
```

## 💻 Sử dụng trong code

### Node.js Example:
```javascript
const QuestionDatabase = require('./query-helper');

const db = new QuestionDatabase();

async function example() {
  await db.connect();
  
  // Lấy 10 câu hỏi ngẫu nhiên
  const questions = await db.getRandomQuestions(10);
  
  // Tạo đề thi
  const exam = await db.generateExam({
    totalQuestions: 25,
    criticalQuestions: 5,
    questionsWithImages: 3
  });
  
  // Tìm kiếm
  const results = await db.searchQuestions('tốc độ');
  
  await db.disconnect();
}
```

## 📁 Cấu trúc files

```
driving_license/
├── docs/
│   └── 600cauhoib.json          # Dữ liệu gốc
├── mongodb-setup.js              # Script thiết lập database
├── import-data.js                # Script import dữ liệu
├── query-helper.js               # Helper functions để query
├── package.json                  # Dependencies
├── .env.example                  # Cấu hình mẫu
├── README-DATABASE.md            # Hướng dẫn chi tiết
└── QUICK-START.md               # File này
```

## 🔗 Connection String

- **Local**: `mongodb://localhost:27017`
- **Database**: `driving_license_db`
- **Collection**: `questions`

## 🎯 Các API có sẵn trong query-helper.js

```javascript
// Kết nối
await db.connect()
await db.disconnect()

// Truy vấn cơ bản
await db.getAllQuestions(limit)
await db.getQuestionByNumber(number)
await db.getQuestionsByCategory(category, limit)

// Truy vấn đặc biệt
await db.getCriticalQuestions(limit)
await db.getQuestionsWithImages(limit)
await db.getRandomQuestions(count, category)
await db.searchQuestions(keyword, limit)

// Thống kê
await db.getCategories()
await db.countByCategory()
await db.getStatistics()

// Tạo đề thi
await db.generateExam({
  totalQuestions: 25,
  criticalQuestions: 5,
  questionsWithImages: 3
})
```

## 🛠️ Troubleshooting

### MongoDB không chạy:
```bash
# macOS
brew services start mongodb-community

# Linux
sudo systemctl start mongod
```

### Kiểm tra kết nối:
```bash
mongosh
```

### Import lại dữ liệu:
```bash
npm run import
```

## 📚 Tài liệu tham khảo

- [README-DATABASE.md](./README-DATABASE.md) - Hướng dẫn chi tiết
- [MongoDB Documentation](https://docs.mongodb.com/)
- [MongoDB Node.js Driver](https://mongodb.github.io/node-mongodb-native/)

---

**Chúc bạn phát triển ứng dụng thành công! 🎉**
