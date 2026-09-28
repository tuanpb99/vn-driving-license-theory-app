# vn-driving-license-theory-app

Ứng dụng Flutter ôn thi lý thuyết lái xe ô tô tại Việt Nam (B1/B/C) theo định hướng production-ready cho Android/iOS.

## Kiến trúc

- Clean Architecture + feature-first
- Riverpod state management
- Repository pattern
- DTO tách biệt Domain model
- Offline-first (ưu tiên local cache, fallback remote)
- go_router cho điều hướng
- Material 3 + Dark mode
- Localization-ready (`lib/l10n`)

## Cấu trúc thư mục

- `lib/core`
- `lib/features/questions`
- `lib/features/exams`
- `lib/features/bookmarks`
- `lib/features/statistics`
- `lib/features/settings`
- `lib/features/simulations`

## Tính năng đã scaffold cho MVP

- Học theo chủ đề
- Thi thử ngẫu nhiên
- Chế độ thi có đếm thời gian
- Đảo đáp án ngẫu nhiên
- Đánh dấu câu hỏi khó/bookmark
- Thống kê cơ bản + dữ liệu câu sai để luyện lại
- Tìm kiếm câu hỏi
- Âm thanh đúng/sai (service scaffold)
- Local notifications nhắc học (service scaffold)
- Tích hợp AdMob (service scaffold)
- Tải & cache JSON/hình ảnh từ server (`RemoteSyncService`)
- Offline hoàn toàn sau khi dữ liệu đã được tải về local

## Dữ liệu

- JSON mẫu: `assets/data/questions.sample.json`
- Có hỗ trợ ảnh trong câu hỏi/đáp án thông qua trường `image`
- Mock API service: `lib/core/network/mock_api_service.dart`

## Môi trường

Xem `.env.example`.

## Chạy kiểm tra

```bash
flutter pub get
flutter analyze
flutter test
```

## CI

Workflow: `.github/workflows/flutter-ci.yml` (chạy `flutter analyze` + `flutter test`).

## Production config examples

Xem `docs/production-config-example.md`.
