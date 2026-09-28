# Hướng dẫn thiết lập Database MongoDB cho ứng dụng Thi Bằng Lái Xe

## 📋 Mục lục
1. [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
2. [Cài đặt MongoDB](#cài-đặt-mongodb)
3. [Thiết lập Database](#thiết-lập-database)
4. [Import dữ liệu](#import-dữ-liệu)
5. [Cấu trúc Database](#cấu-trúc-database)
6. [Truy vấn mẫu](#truy-vấn-mẫu)

---

## 🔧 Yêu cầu hệ thống

- **MongoDB**: Version 5.0 trở lên
- **Node.js**: Version 16.0 trở lên
- **npm**: Version 8.0 trở lên

---

## 📦 Cài đặt MongoDB

### Trên macOS (sử dụng Homebrew):
```bash
# Cài đặt MongoDB
brew tap mongodb/brew
brew install mongodb-community

# Khởi động MongoDB service
brew services start mongodb-community

# Kiểm tra trạng thái
brew services list
```

### Trên Ubuntu/Debian:
```bash
# Import public key
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

# Tạo list file
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Cập nhật và cài đặt
sudo apt-get update
sudo apt-get install -y mongodb-org

# Khởi động service
sudo systemctl start mongod
sudo systemctl enable mongod
```

### Trên Windows:
1. Tải MongoDB Community Server từ: https://www.mongodb.com/try/download/community
2. Chạy file cài đặt và làm theo hướng dẫn
3. MongoDB sẽ tự động chạy như một Windows Service

---

## 🚀 Thiết lập Database

### Bước 1: Cài đặt dependencies
```bash
cd /Users/luuhoangtrong/Project/driving_license
npm install
```

### Bước 2: Thiết lập database schema
```bash
npm run setup
```

Lệnh này sẽ:
- Tạo database `driving_license_db`
- Tạo collection `questions` với validation schema
- Tạo indexes cho tối ưu hiệu suất truy vấn

### Bước 3: Import dữ liệu
```bash
npm run import
```

Hoặc chạy cả hai bước cùng lúc:
```bash
npm run setup-and-import
```

---

## 📊 Cấu trúc Database

### Database: `driving_license_db`

### Collection: `questions`

#### Schema:
```javascript
{
  number: Number,           // Số thứ tự câu hỏi (unique)
  question: String,         // Nội dung câu hỏi
  category: String,         // Danh mục (vd: "khai-niem", "khai-niem diem-liet")
  answers: [                // Mảng các đáp án
    {
      text: String,         // Nội dung đáp án
      correct: Boolean      // Đáp án đúng hay sai
    }
  ],
  explanation: String,      // Giải thích đáp án (có thể null)
  hinhanhq: String,        // URL hình ảnh câu hỏi (có thể null)
  hinhanhqAlt: String      // Text thay thế cho hình ảnh (có thể null)
}
```

#### Indexes:
- `number`: Unique index để tìm kiếm nhanh theo số câu hỏi
- `category`: Index để lọc theo danh mục
- `category + number`: Compound index để tối ưu truy vấn kết hợp

---

## 🔍 Truy vấn mẫu

### Kết nối MongoDB Shell:
```bash
mongosh
use driving_license_db
```

### 1. Lấy tất cả câu hỏi:
```javascript
db.questions.find().limit(10)
```

### 2. Lấy câu hỏi theo số thứ tự:
```javascript
db.questions.findOne({ number: 1 })
```

### 3. Lấy câu hỏi theo danh mục:
```javascript
db.questions.find({ category: "khai-niem" })
```

### 4. Lấy câu hỏi điểm liệt:
```javascript
db.questions.find({ 
  category: { $regex: "diem-liet" } 
})
```

### 5. Lấy câu hỏi có hình ảnh:
```javascript
db.questions.find({ 
  hinhanhq: { $ne: null } 
})
```

### 6. Đếm số câu hỏi theo danh mục:
```javascript
db.questions.aggregate([
  {
    $group: {
      _id: "$category",
      count: { $sum: 1 }
    }
  },
  {
    $sort: { count: -1 }
  }
])
```

### 7. Lấy ngẫu nhiên 10 câu hỏi:
```javascript
db.questions.aggregate([
  { $sample: { size: 10 } }
])
```

### 8. Tìm kiếm câu hỏi theo từ khóa:
```javascript
db.questions.find({
  question: { $regex: "tốc độ", $options: "i" }
})
```

---

## 🔗 Kết nối từ ứng dụng

### Node.js Example:
```javascript
const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';
const client = new MongoClient(uri);

async function getQuestions() {
  try {
    await client.connect();
    const db = client.db('driving_license_db');
    const questions = await db.collection('questions')
      .find()
      .limit(10)
      .toArray();
    
    console.log(questions);
  } finally {
    await client.close();
  }
}

getQuestions();
```

### Connection String cho các môi trường:
- **Local**: `mongodb://localhost:27017`
- **MongoDB Atlas**: `mongodb+srv://<username>:<password>@cluster.mongodb.net/driving_license_db`
- **Docker**: `mongodb://mongodb:27017`

---

## 🛠️ Các lệnh hữu ích

### Xem thống kê database:
```javascript
db.questions.stats()
```

### Backup database:
```bash
mongodump --db driving_license_db --out ./backup
```

### Restore database:
```bash
mongorestore --db driving_license_db ./backup/driving_license_db
```

### Xóa tất cả dữ liệu:
```javascript
db.questions.deleteMany({})
```

### Drop database:
```javascript
use driving_license_db
db.dropDatabase()
```

---

## 📝 Ghi chú

- File dữ liệu gốc: `docs/600cauhoib.json`
- Tổng số câu hỏi: 600 câu
- Các danh mục chính:
  - `khai-niem`: Câu hỏi về khái niệm
  - `khai-niem diem-liet`: Câu hỏi khái niệm điểm liệt
  - Và các danh mục khác...

---

## ❓ Troubleshooting

### Lỗi kết nối MongoDB:
```bash
# Kiểm tra MongoDB đang chạy
brew services list  # macOS
sudo systemctl status mongod  # Linux

# Khởi động lại MongoDB
brew services restart mongodb-community  # macOS
sudo systemctl restart mongod  # Linux
```

### Lỗi import dữ liệu:
- Kiểm tra file JSON có tồn tại tại `docs/600cauhoib.json`
- Kiểm tra quyền đọc file
- Kiểm tra định dạng JSON hợp lệ

### Lỗi validation:
- Đảm bảo dữ liệu tuân thủ schema đã định nghĩa
- Kiểm tra các trường required: `number`, `question`, `category`, `answers`

---

## 📞 Hỗ trợ

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra logs trong terminal
2. Xem MongoDB logs: `/usr/local/var/log/mongodb/mongo.log` (macOS)
3. Tham khảo MongoDB documentation: https://docs.mongodb.com/

---

**Chúc bạn thiết lập thành công! 🎉**
