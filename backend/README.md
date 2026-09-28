# 🚀 Driving License Questions API

REST API xây dựng bằng FastAPI để quản lý câu hỏi thi bằng lái xe.

## 📋 Mục lục

- [Tính năng](#tính-năng)
- [Cài đặt](#cài-đặt)
- [Chạy API](#chạy-api)
- [API Endpoints](#api-endpoints)
- [Ví dụ sử dụng](#ví-dụ-sử-dụng)

## ✨ Tính năng

- ✅ **Lấy danh sách câu hỏi** - Hỗ trợ phân trang và lọc theo danh mục
- ✅ **Lấy câu hỏi theo ID** - Chi tiết một câu hỏi
- ✅ **Tìm kiếm câu hỏi** - Tìm kiếm theo từ khóa
- ✅ **Lọc theo danh mục** - Lọc câu hỏi theo danh mục
- ✅ **Câu hỏi ngẫu nhiên** - Lấy câu hỏi ngẫu nhiên
- ✅ **Câu hỏi điểm liệt** - Lấy danh sách câu hỏi điểm liệt
- ✅ **Câu hỏi có hình ảnh** - Lấy câu hỏi có hình ảnh
- ✅ **Tạo đề thi** - Tự động tạo đề thi với cấu hình linh hoạt
- ✅ **Thống kê** - Xem thống kê về câu hỏi
- ✅ **CORS** - Hỗ trợ CORS cho frontend
- ✅ **API Documentation** - Swagger UI và ReDoc

## 🔧 Cài đặt

### 1. Tạo virtual environment (khuyến nghị)

```bash
cd backend
python3 -m venv venv
source venv/bin/activate  # macOS/Linux
# hoặc
venv\Scripts\activate  # Windows
```

### 2. Cài đặt dependencies

```bash
pip install -r requirements.txt
```

### 3. Cấu hình môi trường

Sao chép file `.env.example` thành `.env`:

```bash
cp .env.example .env
```

Chỉnh sửa file `.env` nếu cần:

```env
MONGODB_URL=mongodb://localhost:27017
DATABASE_NAME=driving_license_db
COLLECTION_NAME=questions
API_HOST=0.0.0.0
API_PORT=8000
```

## 🚀 Chạy API

### Development mode (với auto-reload):

```bash
python main.py
```

Hoặc sử dụng uvicorn trực tiếp:

```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Production mode:

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

API sẽ chạy tại: **http://localhost:8000**

## 📚 API Documentation

Sau khi chạy API, bạn có thể truy cập:

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

## 🛣️ API Endpoints

### Root
- `GET /` - Root endpoint

### Questions
- `GET /api/questions` - Lấy danh sách câu hỏi (có phân trang)
- `GET /api/questions/{number}` - Lấy câu hỏi theo số
- `GET /api/questions/search/{keyword}` - Tìm kiếm câu hỏi
- `GET /api/questions/random` - Lấy câu hỏi ngẫu nhiên
- `GET /api/questions/critical/list` - Lấy câu hỏi điểm liệt
- `GET /api/questions/images/list` - Lấy câu hỏi có hình ảnh

### Categories
- `GET /api/categories` - Lấy danh sách danh mục

### Statistics
- `GET /api/statistics` - Lấy thống kê tổng quan

### Exam
- `POST /api/exam/generate` - Tạo đề thi ngẫu nhiên

### Health
- `GET /api/health` - Health check

## 💡 Ví dụ sử dụng

### 1. Lấy danh sách câu hỏi

```bash
curl http://localhost:8000/api/questions?page=1&page_size=10
```

### 2. Lấy câu hỏi theo số

```bash
curl http://localhost:8000/api/questions/1
```

### 3. Tìm kiếm câu hỏi

```bash
curl http://localhost:8000/api/questions/search/tốc%20độ
```

### 4. Lấy câu hỏi ngẫu nhiên

```bash
curl http://localhost:8000/api/questions/random?count=10
```

### 5. Lấy câu hỏi theo danh mục

```bash
curl http://localhost:8000/api/questions?category=khai-niem
```

### 6. Lấy thống kê

```bash
curl http://localhost:8000/api/statistics
```

### 7. Tạo đề thi

```bash
curl -X POST http://localhost:8000/api/exam/generate \
  -H "Content-Type: application/json" \
  -d '{
    "total_questions": 25,
    "critical_questions": 5,
    "questions_with_images": 3
  }'
```

## 🔗 Sử dụng với Frontend

### JavaScript/TypeScript

```javascript
// Lấy danh sách câu hỏi
const response = await fetch('http://localhost:8000/api/questions?page=1&page_size=10');
const data = await response.json();
console.log(data.questions);

// Tạo đề thi
const examResponse = await fetch('http://localhost:8000/api/exam/generate', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    total_questions: 25,
    critical_questions: 5,
    questions_with_images: 3
  })
});
const exam = await examResponse.json();
console.log(exam.questions);
```

### Python

```python
import requests

# Lấy danh sách câu hỏi
response = requests.get('http://localhost:8000/api/questions', params={
    'page': 1,
    'page_size': 10
})
data = response.json()
print(data['questions'])

# Tạo đề thi
response = requests.post('http://localhost:8000/api/exam/generate', json={
    'total_questions': 25,
    'critical_questions': 5,
    'questions_with_images': 3
})
exam = response.json()
print(exam['questions'])
```

### Flutter/Dart

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

// Lấy danh sách câu hỏi
Future<void> getQuestions() async {
  final response = await http.get(
    Uri.parse('http://localhost:8000/api/questions?page=1&page_size=10')
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data['questions']);
  }
}

// Tạo đề thi
Future<void> generateExam() async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/api/exam/generate'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'total_questions': 25,
      'critical_questions': 5,
      'questions_with_images': 3
    })
  );
  
  if (response.statusCode == 200) {
    final exam = jsonDecode(response.body);
    print(exam['questions']);
  }
}
```

## 📊 Response Format

### Question Object

```json
{
  "number": 1,
  "question": "Phần của đường bộ được sử dụng cho phương tiện giao thông đường bộ đi lại là gì?",
  "category": "khai-niem",
  "answers": [
    {
      "text": "Phần mặt đường và lề đường.",
      "correct": false
    },
    {
      "text": "Phần đường xe chạy.",
      "correct": true
    }
  ],
  "explanation": "Phần đường xe chạy là phần của đường bộ...",
  "hinhanhq": null,
  "hinhanhqAlt": null
}
```

### Question List Response

```json
{
  "total": 600,
  "page": 1,
  "page_size": 10,
  "total_pages": 60,
  "questions": [...]
}
```

## 🛠️ Troubleshooting

### MongoDB không kết nối được:

```bash
# Kiểm tra MongoDB đang chạy
brew services list  # macOS
sudo systemctl status mongod  # Linux

# Khởi động MongoDB
brew services start mongodb-community  # macOS
sudo systemctl start mongod  # Linux
```

### Port 8000 đã được sử dụng:

Thay đổi port trong file `.env`:
```env
API_PORT=8001
```

### CORS errors:

Thêm origin của frontend vào file `.env`:
```env
CORS_ORIGINS=http://localhost:3000,http://localhost:8080,http://localhost:5000
```

## 📝 Cấu trúc thư mục

```
backend/
├── main.py              # FastAPI application
├── config.py            # Configuration settings
├── database.py          # MongoDB operations
├── models.py            # Pydantic models
├── requirements.txt     # Python dependencies
├── .env.example         # Environment variables example
├── .env                 # Environment variables (gitignored)
├── .gitignore          # Git ignore rules
└── README.md           # This file
```

## 🔐 Security Notes

- Không commit file `.env` vào Git
- Trong production, sử dụng biến môi trường thay vì file `.env`
- Thêm authentication/authorization nếu cần
- Sử dụng HTTPS trong production
- Giới hạn rate limiting nếu cần

## 📖 API Documentation

Chi tiết đầy đủ về các endpoints, request/response models có sẵn tại:
- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

---

**Chúc bạn phát triển ứng dụng thành công! 🎉**
