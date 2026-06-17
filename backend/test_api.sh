#!/bin/bash

# Test script for Driving License API
# Make sure the API is running before executing this script

API_URL="http://localhost:8000"

echo "🧪 Testing Driving License API"
echo "================================"
echo ""

# Test 1: Root endpoint
echo "📍 Test 1: Root endpoint"
curl -s $API_URL/ | python3 -m json.tool
echo ""
echo ""

# Test 2: Health check
echo "📍 Test 2: Health check"
curl -s $API_URL/api/health | python3 -m json.tool
echo ""
echo ""

# Test 3: Get statistics
echo "📍 Test 3: Get statistics"
curl -s $API_URL/api/statistics | python3 -m json.tool
echo ""
echo ""

# Test 4: Get categories
echo "📍 Test 4: Get categories"
curl -s $API_URL/api/categories | python3 -m json.tool
echo ""
echo ""

# Test 5: Get questions (first page)
echo "📍 Test 5: Get questions (first 5)"
curl -s "$API_URL/api/questions?page=1&page_size=5" | python3 -m json.tool
echo ""
echo ""

# Test 6: Get question by number
echo "📍 Test 6: Get question #1"
curl -s $API_URL/api/questions/1 | python3 -m json.tool
echo ""
echo ""

# Test 7: Search questions
echo "📍 Test 7: Search questions with keyword 'tốc độ'"
curl -s "$API_URL/api/questions/search/tốc%20độ?page=1&page_size=3" | python3 -m json.tool
echo ""
echo ""

# Test 8: Get random questions
echo "📍 Test 8: Get 5 random questions"
curl -s "$API_URL/api/questions/random?count=5" | python3 -m json.tool
echo ""
echo ""

# Test 9: Get critical questions
echo "📍 Test 9: Get critical questions (first 3)"
curl -s "$API_URL/api/questions/critical/list?page=1&page_size=3" | python3 -m json.tool
echo ""
echo ""

# Test 10: Get questions with images
echo "📍 Test 10: Get questions with images (first 3)"
curl -s "$API_URL/api/questions/images/list?page=1&page_size=3" | python3 -m json.tool
echo ""
echo ""

# Test 11: Generate exam
echo "📍 Test 11: Generate exam"
curl -s -X POST $API_URL/api/exam/generate \
  -H "Content-Type: application/json" \
  -d '{
    "total_questions": 10,
    "critical_questions": 2,
    "questions_with_images": 1
  }' | python3 -m json.tool
echo ""
echo ""

echo "✅ All tests completed!"
