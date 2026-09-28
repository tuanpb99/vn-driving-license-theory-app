"""
Pydantic models for request/response validation
"""
from typing import List, Optional, Any
from pydantic import BaseModel, Field


class Answer(BaseModel):
    """Answer model"""
    text: str = Field(..., description="Nội dung đáp án")
    correct: bool = Field(..., description="Đáp án đúng hay sai")


class Question(BaseModel):
    """Question model"""
    number: int = Field(..., description="Số thứ tự câu hỏi")
    question: str = Field(..., description="Nội dung câu hỏi")
    category: str = Field(..., description="Danh mục câu hỏi")
    answers: List[Answer] = Field(..., description="Danh sách các đáp án")
    explanation: Optional[str] = Field(None, description="Giải thích đáp án")
    hinhanhq: Optional[str] = Field(None, description="URL hình ảnh câu hỏi")
    hinhanhqAlt: Optional[str] = Field(None, description="Text thay thế cho hình ảnh")

    class Config:
        json_schema_extra = {
            "example": {
                "number": 1,
                "question": "Phần của đường bộ được sử dụng cho phương tiện giao thông đường bộ đi lại là gì?",
                "category": "khai-niem",
                "answers": [
                    {"text": "Phần mặt đường và lề đường.", "correct": False},
                    {"text": "Phần đường xe chạy.", "correct": True},
                    {"text": "Phần đường xe cơ giới.", "correct": False}
                ],
                "explanation": "Phần đường xe chạy là phần của đường bộ được thiết kế dành riêng cho các phương tiện giao thông lưu thông.",
                "hinhanhq": None,
                "hinhanhqAlt": None
            }
        }


class QuestionListResponse(BaseModel):
    """Response model for question list"""
    total: int = Field(..., description="Tổng số câu hỏi")
    page: int = Field(..., description="Trang hiện tại")
    page_size: int = Field(..., description="Số câu hỏi trên mỗi trang")
    total_pages: int = Field(..., description="Tổng số trang")
    questions: List[Question] = Field(..., description="Danh sách câu hỏi")


class CategoryStats(BaseModel):
    """Category statistics model"""
    category: str = Field(..., description="Tên danh mục")
    count: int = Field(..., description="Số câu hỏi trong danh mục")


class Statistics(BaseModel):
    """Statistics model"""
    total: int = Field(..., description="Tổng số câu hỏi")
    total_categories: int = Field(..., description="Tổng số danh mục")
    categories: List[str] = Field(..., description="Danh sách các danh mục")
    questions_with_images: int = Field(..., description="Số câu hỏi có hình ảnh")
    critical_questions: int = Field(..., description="Số câu hỏi điểm liệt")
    category_breakdown: List[CategoryStats] = Field(..., description="Thống kê theo danh mục")


class ExamConfig(BaseModel):
    """Exam generation configuration"""
    total_questions: int = Field(25, ge=1, le=100, description="Tổng số câu hỏi")
    critical_questions: int = Field(5, ge=0, description="Số câu hỏi điểm liệt")
    questions_with_images: int = Field(3, ge=0, description="Số câu hỏi có hình ảnh")

    class Config:
        json_schema_extra = {
            "example": {
                "total_questions": 25,
                "critical_questions": 5,
                "questions_with_images": 3
            }
        }


class ExamResponse(BaseModel):
    """Response model for generated exam"""
    exam_id: str = Field(..., description="ID đề thi")
    total_questions: int = Field(..., description="Tổng số câu hỏi")
    critical_questions: int = Field(..., description="Số câu hỏi điểm liệt")
    questions_with_images: int = Field(..., description="Số câu hỏi có hình ảnh")
    questions: List[Question] = Field(..., description="Danh sách câu hỏi")


class ErrorResponse(BaseModel):
    """Error response model"""
    error: str = Field(..., description="Mô tả lỗi")
    detail: Optional[str] = Field(None, description="Chi tiết lỗi")
