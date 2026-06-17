# 🗄️ MongoDB Database Setup - Hướng dẫn

## 📍 Vị trí

Tất cả các files liên quan đến MongoDB đã được tổ chức trong thư mục **`mongo_db/`**

## 📁 Cấu trúc

```
driving_license/
├── mongo_db/                    # ← Thư mục MongoDB
│   ├── mongodb-setup.js         # Script thiết lập database
│   ├── import-data.js           # Script import dữ liệu
│   ├── query-helper.js          # Helper class
│   ├── example-usage.js         # Ví dụ sử dụng
│   ├── package.json             # Dependencies
│   ├── node_modules/            # Dependencies đã cài
│   ├── .env.example             # Cấu hình mẫu
│   ├── .gitignore               # Git ignore
│   ├── README.md                # Hướng dẫn chính
│   ├── README-DATABASE.md       # Hướng dẫn chi tiết
│   ├── QUICK-START.md          # Hướng dẫn nhanh
│   └── SUMMARY.md              # Tóm tắt
├── docs/
│   └── 600cauhoib.json         # Dữ liệu gốc
└── ...
```

## ✅ Trạng thái

Database đã được thiết lập và import dữ liệu thành công:

- ✅ **Database**: `driving_license_db`
- ✅ **Collection**: `questions`
- ✅ **Tổng số câu hỏi**: 600 câu
- ✅ **Số danh mục**: 9 danh mục
- ✅ **Câu hỏi có hình ảnh**: 318 câu
- ✅ **Câu hỏi điểm liệt**: 60 câu

## 🚀 Sử dụng nhanh

### 1. Di chuyển vào thư mục mongo_db
```bash
cd mongo_db
```

### 2. Xem thống kê database
```bash
npm run stats
```

### 3. Chạy ví dụ
```bash
node example-usage.js
```

### 4. Kết nối MongoDB Shell
```bash
mongosh
use driving_license_db
db.questions.find().limit(5)
```

## 💻 Sử dụng trong code

### Từ thư mục gốc của project:
```javascript
const QuestionDatabase = require('./mongo_db/query-helper');

const db = new QuestionDatabase();

async function example() {
  await db.connect();
  
  // Lấy 10 câu hỏi ngẫu nhiên
  const questions = await db.getRandomQuestions(10);
  console.log(questions);
  
  // Tạo đề thi
  const exam = await db.generateExam({
    totalQuestions: 25,
    criticalQuestions: 5,
    questionsWithImages: 3
  });
  console.log(exam);
  
  // Tìm kiếm
  const results = await db.searchQuestions('tốc độ');
  console.log(results);
  
  await db.disconnect();
}

example();
```

## 📚 Tài liệu chi tiết

Xem các file trong thư mục `mongo_db/`:

1. **[mongo_db/README.md](./mongo_db/README.md)** - Hướng dẫn chính
2. **[mongo_db/SUMMARY.md](./mongo_db/SUMMARY.md)** - Tóm tắt toàn bộ
3. **[mongo_db/README-DATABASE.md](./mongo_db/README-DATABASE.md)** - Hướng dẫn chi tiết
4. **[mongo_db/QUICK-START.md](./mongo_db/QUICK-START.md)** - Hướng dẫn nhanh

## 🎯 API có sẵn

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

## 📊 Thống kê dữ liệu

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

```bash
# Di chuyển vào thư mục mongo_db
cd mongo_db

# Thiết lập database (nếu cần)
npm run setup

# Import dữ liệu (nếu cần)
npm run import

# Xem thống kê
npm run stats

# Chạy ví dụ
node example-usage.js
```

## 🔗 Connection String

- **Local**: `mongodb://localhost:27017`
- **Database**: `driving_license_db`
- **Collection**: `questions`

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
db.questions.countDocuments()
```

### Import lại dữ liệu:
```bash
cd mongo_db
npm run import
```

---

**📖 Để biết thêm chi tiết, vui lòng xem các file tài liệu trong thư mục `mongo_db/`**

**Chúc bạn phát triển ứng dụng thành công! 🎉**
