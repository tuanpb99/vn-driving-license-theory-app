"""
FastAPI application for Driving License Questions API
"""
from fastapi import FastAPI, HTTPException, Query, Path
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from typing import Optional
import math

from config import settings
from database import db
from models import (
    Question,
    QuestionListResponse,
    Statistics,
    ExamConfig,
    ExamResponse,
    ErrorResponse
)

# Initialize FastAPI app
app = FastAPI(
    title=settings.API_TITLE,
    description=settings.API_DESCRIPTION,
    version=settings.API_VERSION,
    docs_url="/docs",
    redoc_url="/redoc"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.on_event("startup")
async def startup_event():
    """Connect to database on startup"""
    db.connect()


@app.on_event("shutdown")
async def shutdown_event():
    """Disconnect from database on shutdown"""
    db.disconnect()


@app.get("/", tags=["Root"])
async def root():
    """Root endpoint"""
    return {
        "message": "Driving License Questions API",
        "version": settings.API_VERSION,
        "docs": "/docs",
        "redoc": "/redoc"
    }


@app.get(
    "/api/questions",
    response_model=QuestionListResponse,
    tags=["Questions"],
    summary="Lấy danh sách câu hỏi",
    description="Lấy danh sách câu hỏi với phân trang và lọc theo danh mục"
)
async def get_questions(
    page: int = Query(1, ge=1, description="Số trang (bắt đầu từ 1)"),
    page_size: int = Query(
        settings.DEFAULT_PAGE_SIZE,
        ge=1,
        le=settings.MAX_PAGE_SIZE,
        description=f"Số câu hỏi trên mỗi trang (tối đa {settings.MAX_PAGE_SIZE})"
    ),
    category: Optional[str] = Query(None, description="Lọc theo danh mục")
):
    """Get all questions with pagination"""
    try:
        skip = (page - 1) * page_size
        questions, total = db.get_all_questions(skip=skip, limit=page_size, category=category)
        total_pages = math.ceil(total / page_size)
        
        return QuestionListResponse(
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
            questions=questions
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/questions/{number}",
    response_model=Question,
    tags=["Questions"],
    summary="Lấy câu hỏi theo số",
    description="Lấy chi tiết một câu hỏi theo số thứ tự"
)
async def get_question(
    number: int = Path(..., ge=1, description="Số thứ tự câu hỏi")
):
    """Get a question by number"""
    try:
        question = db.get_question_by_number(number)
        if not question:
            raise HTTPException(
                status_code=404,
                detail=f"Không tìm thấy câu hỏi số {number}"
            )
        return question
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/questions/search/{keyword}",
    response_model=QuestionListResponse,
    tags=["Questions"],
    summary="Tìm kiếm câu hỏi",
    description="Tìm kiếm câu hỏi theo từ khóa trong nội dung câu hỏi hoặc giải thích"
)
async def search_questions(
    keyword: str = Path(..., description="Từ khóa tìm kiếm"),
    page: int = Query(1, ge=1, description="Số trang"),
    page_size: int = Query(
        settings.DEFAULT_PAGE_SIZE,
        ge=1,
        le=settings.MAX_PAGE_SIZE,
        description="Số câu hỏi trên mỗi trang"
    )
):
    """Search questions by keyword"""
    try:
        skip = (page - 1) * page_size
        questions, total = db.search_questions(keyword, skip=skip, limit=page_size)
        total_pages = math.ceil(total / page_size)
        
        return QuestionListResponse(
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
            questions=questions
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/categories",
    response_model=list[str],
    tags=["Categories"],
    summary="Lấy danh sách danh mục",
    description="Lấy danh sách tất cả các danh mục câu hỏi"
)
async def get_categories():
    """Get all categories"""
    try:
        return db.get_categories()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/questions/critical/list",
    response_model=QuestionListResponse,
    tags=["Questions"],
    summary="Lấy câu hỏi điểm liệt",
    description="Lấy danh sách các câu hỏi điểm liệt với phân trang"
)
async def get_critical_questions(
    page: int = Query(1, ge=1, description="Số trang"),
    page_size: int = Query(
        settings.DEFAULT_PAGE_SIZE,
        ge=1,
        le=settings.MAX_PAGE_SIZE,
        description="Số câu hỏi trên mỗi trang"
    )
):
    """Get critical questions"""
    try:
        skip = (page - 1) * page_size
        questions, total = db.get_critical_questions(skip=skip, limit=page_size)
        total_pages = math.ceil(total / page_size)
        
        return QuestionListResponse(
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
            questions=questions
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/questions/images/list",
    response_model=QuestionListResponse,
    tags=["Questions"],
    summary="Lấy câu hỏi có hình ảnh",
    description="Lấy danh sách các câu hỏi có hình ảnh với phân trang"
)
async def get_questions_with_images(
    page: int = Query(1, ge=1, description="Số trang"),
    page_size: int = Query(
        settings.DEFAULT_PAGE_SIZE,
        ge=1,
        le=settings.MAX_PAGE_SIZE,
        description="Số câu hỏi trên mỗi trang"
    )
):
    """Get questions with images"""
    try:
        skip = (page - 1) * page_size
        questions, total = db.get_questions_with_images(skip=skip, limit=page_size)
        total_pages = math.ceil(total / page_size)
        
        return QuestionListResponse(
            total=total,
            page=page,
            page_size=page_size,
            total_pages=total_pages,
            questions=questions
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/questions/random",
    response_model=list[Question],
    tags=["Questions"],
    summary="Lấy câu hỏi ngẫu nhiên",
    description="Lấy một số lượng câu hỏi ngẫu nhiên, có thể lọc theo danh mục"
)
async def get_random_questions(
    count: int = Query(10, ge=1, le=50, description="Số lượng câu hỏi"),
    category: Optional[str] = Query(None, description="Lọc theo danh mục")
):
    """Get random questions"""
    try:
        questions = db.get_random_questions(count=count, category=category)
        return questions
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/statistics",
    response_model=Statistics,
    tags=["Statistics"],
    summary="Lấy thống kê",
    description="Lấy thống kê tổng quan về câu hỏi"
)
async def get_statistics():
    """Get statistics"""
    try:
        stats = db.get_statistics()
        return stats
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post(
    "/api/exam/generate",
    response_model=ExamResponse,
    tags=["Exam"],
    summary="Tạo đề thi",
    description="Tự động tạo đề thi ngẫu nhiên với cấu hình tùy chỉnh"
)
async def generate_exam(config: ExamConfig):
    """Generate a random exam"""
    try:
        # Validate
        if config.critical_questions + config.questions_with_images > config.total_questions:
            raise HTTPException(
                status_code=400,
                detail="Tổng số câu hỏi điểm liệt và câu hỏi có hình ảnh không được vượt quá tổng số câu hỏi"
            )
        
        exam_id, questions = db.generate_exam(
            total_questions=config.total_questions,
            critical_questions=config.critical_questions,
            questions_with_images=config.questions_with_images
        )
        
        # Count actual numbers
        actual_critical = len([q for q in questions if "diem-liet" in q.get("category", "")])
        actual_with_images = len([q for q in questions if q.get("hinhanhq")])
        
        return ExamResponse(
            exam_id=exam_id,
            total_questions=len(questions),
            critical_questions=actual_critical,
            questions_with_images=actual_with_images,
            questions=questions
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get(
    "/api/health",
    tags=["Health"],
    summary="Health check",
    description="Kiểm tra trạng thái của API và database"
)
async def health_check():
    """Health check endpoint"""
    try:
        # Check database connection
        db.collection.find_one()
        return {
            "status": "healthy",
            "database": "connected",
            "version": settings.API_VERSION
        }
    except Exception as e:
        return JSONResponse(
            status_code=503,
            content={
                "status": "unhealthy",
                "database": "disconnected",
                "error": str(e)
            }
        )


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "main:app",
        host=settings.API_HOST,
        port=settings.API_PORT,
        reload=settings.API_RELOAD
    )
