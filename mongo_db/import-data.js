// Import Data Script for Driving License Questions
// This script reads the JSON file and imports data into MongoDB

const { MongoClient } = require('mongodb');
const fs = require('fs');
const path = require('path');

// MongoDB connection configuration
const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017';
const DB_NAME = 'driving_license_db';
const COLLECTION_NAME = 'questions';

// Path to JSON file
const JSON_FILE_PATH = path.join(__dirname, '..', 'docs', '600cauhoib.json');

async function importData() {
  let client;
  
  try {
    console.log('🔄 Starting data import process...\n');
    
    // Read JSON file
    console.log('📖 Reading JSON file:', JSON_FILE_PATH);
    const jsonData = JSON.parse(fs.readFileSync(JSON_FILE_PATH, 'utf8'));
    console.log(`✅ Successfully read ${jsonData.length} questions from file\n`);
    
    // Connect to MongoDB
    console.log('🔌 Connecting to MongoDB:', MONGO_URI);
    client = new MongoClient(MONGO_URI);
    await client.connect();
    console.log('✅ Connected to MongoDB successfully\n');
    
    // Get database and collection
    const db = client.db(DB_NAME);
    const collection = db.collection(COLLECTION_NAME);
    
    // Clear existing data (optional - comment out if you want to keep existing data)
    console.log('🗑️  Clearing existing data...');
    const deleteResult = await collection.deleteMany({});
    console.log(`✅ Deleted ${deleteResult.deletedCount} existing documents\n`);
    
    // Transform data to ensure correct types
    console.log('🔄 Transforming data...');
    const transformedData = jsonData.map(item => ({
      number: parseInt(item.number),
      question: item.question,
      category: item.category,
      answers: item.answers.map(answer => ({
        text: answer.text,
        correct: Boolean(answer.correct)
      })),
      explanation: item.explanation || null,
      hinhanhq: item.hinhanhq || null,
      hinhanhqAlt: item.hinhanhqAlt || null
    }));
    console.log('✅ Data transformation completed\n');
    
    // Insert data in batches for better performance
    console.log('📥 Inserting data into MongoDB...');
    const batchSize = 100;
    let insertedCount = 0;
    
    for (let i = 0; i < transformedData.length; i += batchSize) {
      const batch = transformedData.slice(i, i + batchSize);
      const result = await collection.insertMany(batch, { ordered: false });
      insertedCount += result.insertedCount;
      console.log(`   Inserted batch ${Math.floor(i / batchSize) + 1}: ${result.insertedCount} documents`);
    }
    
    console.log(`\n✅ Successfully inserted ${insertedCount} questions into database!\n`);
    
    // Verify data
    console.log('🔍 Verifying data...');
    const totalCount = await collection.countDocuments();
    const categories = await collection.distinct('category');
    const questionsWithImages = await collection.countDocuments({ hinhanhq: { $ne: null } });
    
    console.log('\n📊 Database Statistics:');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(`   Total questions: ${totalCount}`);
    console.log(`   Categories: ${categories.length}`);
    console.log(`   Questions with images: ${questionsWithImages}`);
    console.log('\n📋 Categories:');
    for (const category of categories) {
      const count = await collection.countDocuments({ category });
      console.log(`   - ${category}: ${count} questions`);
    }
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
    
    console.log('✨ Data import completed successfully!');
    
  } catch (error) {
    console.error('❌ Error during import:', error.message);
    console.error(error);
    process.exit(1);
  } finally {
    // Close connection
    if (client) {
      await client.close();
      console.log('\n🔌 MongoDB connection closed');
    }
  }
}

// Run the import
importData();
