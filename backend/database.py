"""
Database connection and operations
"""
from typing import List, Optional, Dict, Any
from pymongo import MongoClient
from pymongo.collection import Collection
from pymongo.database import Database
from config import settings
import random
import uuid


class MongoDB:
    """MongoDB database handler"""
    
    def __init__(self):
        self.client: Optional[MongoClient] = None
        self.db: Optional[Database] = None
        self.collection: Optional[Collection] = None
    
    def connect(self):
        """Connect to MongoDB"""
        try:
            self.client = MongoClient(settings.MONGODB_URL)
            self.db = self.client[settings.DATABASE_NAME]
            self.collection = self.db[settings.COLLECTION_NAME]
            # Test connection
            self.client.server_info()
            print(f"✅ Connected to MongoDB: {settings.DATABASE_NAME}")
        except Exception as e:
            print(f"❌ Failed to connect to MongoDB: {e}")
            raise
    
    def disconnect(self):
        """Disconnect from MongoDB"""
        if self.client:
            self.client.close()
            print("🔌 Disconnected from MongoDB")
    
    def get_all_questions(
        self, 
        skip: int = 0, 
        limit: int = 20,
        category: Optional[str] = None
    ) -> tuple[List[Dict], int]:
        """Get all questions with pagination"""
        query = {}
        if category:
            query["category"] = category
        
        total = self.collection.count_documents(query)
        questions = list(
            self.collection
            .find(query, {"_id": 0})
            .sort("number", 1)
            .skip(skip)
            .limit(limit)
        )
        return questions, total
    
    def get_question_by_number(self, number: int) -> Optional[Dict]:
        """Get a question by its number"""
        return self.collection.find_one({"number": number}, {"_id": 0})
    
    def search_questions(
        self, 
        keyword: str, 
        skip: int = 0, 
        limit: int = 20
    ) -> tuple[List[Dict], int]:
        """Search questions by keyword"""
        query = {
            "$or": [
                {"question": {"$regex": keyword, "$options": "i"}},
                {"explanation": {"$regex": keyword, "$options": "i"}}
            ]
        }
        total = self.collection.count_documents(query)
        questions = list(
            self.collection
            .find(query, {"_id": 0})
            .skip(skip)
            .limit(limit)
        )
        return questions, total
    
    def get_categories(self) -> List[str]:
        """Get all unique categories"""
        return self.collection.distinct("category")
    
    def get_critical_questions(
        self, 
        skip: int = 0, 
        limit: int = 20
    ) -> tuple[List[Dict], int]:
        """Get critical questions (điểm liệt)"""
        query = {"category": {"$regex": "diem-liet"}}
        total = self.collection.count_documents(query)
        questions = list(
            self.collection
            .find(query, {"_id": 0})
            .sort("number", 1)
            .skip(skip)
            .limit(limit)
        )
        return questions, total
    
    def get_questions_with_images(
        self, 
        skip: int = 0, 
        limit: int = 20
    ) -> tuple[List[Dict], int]:
        """Get questions with images"""
        query = {"hinhanhq": {"$ne": None}}
        total = self.collection.count_documents(query)
        questions = list(
            self.collection
            .find(query, {"_id": 0})
            .sort("number", 1)
            .skip(skip)
            .limit(limit)
        )
        return questions, total
    
    def get_random_questions(
        self, 
        count: int = 10, 
        category: Optional[str] = None
    ) -> List[Dict]:
        """Get random questions"""
        pipeline = []
        
        if category:
            pipeline.append({"$match": {"category": category}})
        
        pipeline.append({"$sample": {"size": count}})
        pipeline.append({"$project": {"_id": 0}})
        
        return list(self.collection.aggregate(pipeline))
    
    def count_by_category(self) -> List[Dict]:
        """Count questions by category"""
        pipeline = [
            {
                "$group": {
                    "_id": "$category",
                    "count": {"$sum": 1}
                }
            },
            {
                "$sort": {"count": -1}
            },
            {
                "$project": {
                    "category": "$_id",
                    "count": 1,
                    "_id": 0
                }
            }
        ]
        return list(self.collection.aggregate(pipeline))
    
    def get_statistics(self) -> Dict:
        """Get database statistics"""
        total = self.collection.count_documents({})
        categories = self.get_categories()
        with_images = self.collection.count_documents({"hinhanhq": {"$ne": None}})
        critical = self.collection.count_documents({"category": {"$regex": "diem-liet"}})
        category_stats = self.count_by_category()
        
        return {
            "total": total,
            "total_categories": len(categories),
            "categories": categories,
            "questions_with_images": with_images,
            "critical_questions": critical,
            "category_breakdown": category_stats
        }
    
    def generate_exam(
        self,
        total_questions: int = 25,
        critical_questions: int = 5,
        questions_with_images: int = 3
    ) -> tuple[str, List[Dict]]:
        """Generate a random exam"""
        exam_questions = []
        used_numbers = set()
        
        # Get critical questions
        if critical_questions > 0:
            critical_query = {"category": {"$regex": "diem-liet"}}
            critical_pipeline = [
                {"$match": critical_query},
                {"$sample": {"size": critical_questions}},
                {"$project": {"_id": 0}}
            ]
            critical_qs = list(self.collection.aggregate(critical_pipeline))
            exam_questions.extend(critical_qs)
            used_numbers.update([q["number"] for q in critical_qs])
        
        # Get questions with images
        if questions_with_images > 0:
            image_query = {
                "hinhanhq": {"$ne": None},
                "number": {"$nin": list(used_numbers)}
            }
            image_pipeline = [
                {"$match": image_query},
                {"$sample": {"size": questions_with_images}},
                {"$project": {"_id": 0}}
            ]
            image_qs = list(self.collection.aggregate(image_pipeline))
            exam_questions.extend(image_qs)
            used_numbers.update([q["number"] for q in image_qs])
        
        # Get remaining questions
        remaining = total_questions - len(exam_questions)
        if remaining > 0:
            remaining_query = {"number": {"$nin": list(used_numbers)}}
            remaining_pipeline = [
                {"$match": remaining_query},
                {"$sample": {"size": remaining}},
                {"$project": {"_id": 0}}
            ]
            remaining_qs = list(self.collection.aggregate(remaining_pipeline))
            exam_questions.extend(remaining_qs)
        
        # Shuffle questions
        random.shuffle(exam_questions)
        
        # Generate exam ID
        exam_id = str(uuid.uuid4())
        
        return exam_id, exam_questions


# Global database instance
db = MongoDB()
