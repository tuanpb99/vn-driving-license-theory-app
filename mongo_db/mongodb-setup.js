// MongoDB Setup Script for Driving License Questions Database
// Run this script using: mongosh < mongodb-setup.js

// Connect to MongoDB (adjust connection string if needed)
// Use database
use driving_license_db;

// Drop existing collection if exists (optional - remove if you want to keep existing data)
db.questions.drop();

// Create collection with validation schema
db.createCollection("questions", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["number", "question", "category", "answers"],
      properties: {
        number: {
          bsonType: "int",
          description: "Question number - must be an integer and is required"
        },
        question: {
          bsonType: "string",
          description: "Question text - must be a string and is required"
        },
        category: {
          bsonType: "string",
          description: "Question category - must be a string and is required"
        },
        answers: {
          bsonType: "array",
          description: "Array of answer options - must be an array and is required",
          minItems: 2,
          items: {
            bsonType: "object",
            required: ["text", "correct"],
            properties: {
              text: {
                bsonType: "string",
                description: "Answer text - must be a string"
              },
              correct: {
                bsonType: "bool",
                description: "Whether this answer is correct - must be a boolean"
              }
            }
          }
        },
        explanation: {
          bsonType: ["string", "null"],
          description: "Explanation for the correct answer - can be string or null"
        },
        hinhanhq: {
          bsonType: ["string", "null"],
          description: "Image URL for the question - can be string or null"
        },
        hinhanhqAlt: {
          bsonType: ["string", "null"],
          description: "Alternative text for the image - can be string or null"
        }
      }
    }
  }
});

// Create indexes for better query performance
db.questions.createIndex({ number: 1 }, { unique: true });
db.questions.createIndex({ category: 1 });
db.questions.createIndex({ "category": 1, "number": 1 });

print("✅ Database 'driving_license_db' created successfully!");
print("✅ Collection 'questions' created with validation schema!");
print("✅ Indexes created on 'number' and 'category' fields!");
print("\nNext step: Run the import script to load data");
print("Command: node import-data.js");
