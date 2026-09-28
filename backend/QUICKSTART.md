# 🚀 Quick Start - FastAPI Backend

## ✅ Đã cài đặt và chạy thành công!

API đang chạy tại: **http://localhost:8000**

## 📚 Documentation

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

## 🎯 Các API đã sẵn sàng

### 1. Lấy thống kê
```bash
curl http://localhost:8000/api/statistics
```

### 2. Lấy danh sách câu hỏi
```bash
curl "http://localhost:8000/api/questions?page=1&page_size=10"
```

### 3. Lấy câu hỏi theo số
```bash
curl http://localhost:8000/api/questions/1
```

### 4. Tìm kiếm câu hỏi
```bash
curl "http://localhost:8000/api/questions/search/tốc%20độ"
```

### 5. Lấy câu hỏi ngẫu nhiên
```bash
curl "http://localhost:8000/api/questions/random?count=10"
```

### 6. Tạo đề thi
```bash
curl -X POST http://localhost:8000/api/exam/generate \
  -H "Content-Type: application/json" \
  -d '{
    "total_questions": 25,
    "critical_questions": 5,
    "questions_with_images": 3
  }'
```

## 🔧 Quản lý API

### Dừng API
Nhấn `CTRL+C` trong terminal đang chạy API

### Chạy lại API
```bash
cd backend
source venv/bin/activate
python main.py
```

### Chạy với custom port
```bash
# Sửa file .env
API_PORT=8001

# Hoặc
uvicorn main:app --port 8001
```

## 📊 Dữ liệu hiện có

- ✅ **600 câu hỏi**
- ✅ **9 danh mục**
- ✅ **318 câu hỏi có hình ảnh**
- ✅ **60 câu hỏi điểm liệt**

## 🔗 Sử dụng với Flutter

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

// Get questions
Future<void> getQuestions() async {
  final response = await http.get(
    Uri.parse('http://localhost:8000/api/questions?page=1&page_size=10')
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Total: ${data['total']}');
    print('Questions: ${data['questions']}');
  }
}

// Generate exam
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
    print('Exam ID: ${exam['exam_id']}');
    print('Questions: ${exam['questions']}');
  }
}
```

## 📖 Chi tiết hơn

Xem file [README.md](./README.md) để biết thêm chi tiết về:
- Cài đặt
- Tất cả API endpoints
- Ví dụ sử dụng
- Troubleshooting

---

**API đã sẵn sàng để tích hợp vào ứng dụng của bạn! 🎉**
