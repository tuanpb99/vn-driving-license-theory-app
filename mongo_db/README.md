# 🗄️ MongoDB Database Setup

Thư mục này chứa tất cả các files cần thiết để thiết lập và quản lý database MongoDB cho ứng dụng thi bằng lái xe.

## 📁 Cấu trúc thư mục

```
mongo_db/
├── mongodb-setup.js          # Script thiết lập database schema
├── import-data.js            # Script import dữ liệu từ JSON
├── query-helper.js           # Helper class với các hàm truy vấn
├── example-usage.js          # File demo các chức năng
├── package.json              # Dependencies và scripts
├── package-lock.json         # Lock file cho dependencies
├── node_modules/             # Dependencies đã cài đặt
├── .env.example              # File cấu hình mẫu
├── README.md                 # File này
├── README-DATABASE.md        # Hướng dẫn chi tiết đầy đủ
├── QUICK-START.md           # Hướng dẫn nhanh
└── SUMMARY.md               # Tóm tắt toàn bộ
```

## 🚀 Quick Start

### 1. Cài đặt dependencies (đã hoàn thành)
```bash
cd mongo_db
npm install
```

### 2. Thiết lập database (đã hoàn thành)
```bash
npm run setup
```

### 3. Import dữ liệu (đã hoàn thành)
```bash
npm run import
```

### 4. Kiểm tra thống kê
```bash
npm run stats
```

### 5. Chạy ví dụ
```bash
node example-usage.js
```

## 📊 Database đã được thiết lập

- ✅ **Database**: `driving_license_db`
- ✅ **Collection**: `questions`
- ✅ **Tổng số câu hỏi**: 600 câu
- ✅ **Số danh mục**: 9 danh mục
- ✅ **Câu hỏi có hình ảnh**: 318 câu
- ✅ **Câu hỏi điểm liệt**: 60 câu

## 💻 Sử dụng trong code

### Từ thư mục gốc của project:
```javascript
const QuestionDatabase = require('./mongo_db/query-helper');

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
  
  await db.disconnect();
}
```

## 🔧 Scripts có sẵn

```bash
# Thiết lập database schema
npm run setup

# Import dữ liệu
npm run import

# Thiết lập và import cùng lúc
npm run setup-and-import

# Xem thống kê và demo
npm run stats
```

## 📚 Tài liệu

- **[SUMMARY.md](./SUMMARY.md)** - Tổng quan toàn bộ dự án
- **[README-DATABASE.md](./README-DATABASE.md)** - Hướng dẫn chi tiết đầy đủ
- **[QUICK-START.md](./QUICK-START.md)** - Hướng dẫn nhanh

## 🔗 Connection String

- **Local**: `mongodb://localhost:27017`
- **Database**: `driving_license_db`
- **Collection**: `questions`

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

## 🎯 API có sẵn

### Kết nối
```javascript
await db.connect()
await db.disconnect()
```

### Truy vấn cơ bản
```javascript
await db.getAllQuestions(limit)
await db.getQuestionByNumber(number)
await db.getQuestionsByCategory(category, limit)
```

### Truy vấn đặc biệt
```javascript
await db.getCriticalQuestions(limit)
await db.getQuestionsWithImages(limit)
await db.getRandomQuestions(count, category)
await db.searchQuestions(keyword, limit)
```

### Thống kê
```javascript
await db.getCategories()
await db.countByCategory()
await db.getStatistics()
```

### Tạo đề thi
```javascript
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
use driving_license_db
db.questions.find().limit(5)
```

### Import lại dữ liệu:
```bash
cd mongo_db
npm run import
```

---

**Chúc bạn phát triển ứng dụng thành công! 🎉**
