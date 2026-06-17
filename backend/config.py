"""
Configuration module for the API
"""
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

class Settings:
    """Application settings"""
    
    # MongoDB Settings
    MONGODB_URL: str = os.getenv("MONGODB_URL", "mongodb://localhost:27017")
    DATABASE_NAME: str = os.getenv("DATABASE_NAME", "driving_license_db")
    COLLECTION_NAME: str = os.getenv("COLLECTION_NAME", "questions")
    
    # API Settings
    API_HOST: str = os.getenv("API_HOST", "0.0.0.0")
    API_PORT: int = int(os.getenv("API_PORT", "8000"))
    API_RELOAD: bool = os.getenv("API_RELOAD", "True").lower() == "true"
    
    # CORS Settings
    CORS_ORIGINS: list = os.getenv(
        "CORS_ORIGINS", 
        "http://localhost:3000,http://localhost:8080"
    ).split(",")
    
    # API Metadata
    API_TITLE: str = "Driving License API"
    API_DESCRIPTION: str = """
    API để quản lý câu hỏi thi bằng lái xe 🚗
    
    ## Tính năng
    
    * **Lấy danh sách câu hỏi** - Hỗ trợ phân trang và lọc
    * **Lấy câu hỏi theo ID** - Chi tiết một câu hỏi
    * **Tìm kiếm câu hỏi** - Tìm kiếm theo từ khóa
    * **Lọc theo danh mục** - Lọc câu hỏi theo danh mục
    * **Câu hỏi ngẫu nhiên** - Lấy câu hỏi ngẫu nhiên
    * **Tạo đề thi** - Tự động tạo đề thi với cấu hình linh hoạt
    * **Thống kê** - Xem thống kê về câu hỏi
    """
    API_VERSION: str = "1.0.0"
    
    # Pagination defaults
    DEFAULT_PAGE_SIZE: int = 20
    MAX_PAGE_SIZE: int = 100

settings = Settings()
