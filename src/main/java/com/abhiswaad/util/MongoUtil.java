package com.abhiswaad.util;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class MongoUtil
{
    private static final String CONNECTION_STRING = "mongodb://localhost:27017";
    private static final String DATABASE_NAME = "abhi_swaad";
    private static MongoClient mongoClient = null;
    private static MongoDatabase database = null;

    // Connects to MongoDB
    public static MongoDatabase getDatabase()
    {
        try
        {
            if (mongoClient == null)
            {
                mongoClient = MongoClients.create(CONNECTION_STRING);
                database = mongoClient.getDatabase(DATABASE_NAME);
                System.out.println("✅ Connected to MongoDB: " + DATABASE_NAME);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return database;
    }

    // Closes MongoDB connection safely
    public static void closeConnection()
    {
        if (mongoClient != null)
        {
            mongoClient.close();
            System.out.println("🔒 MongoDB connection closed.");
        }
    }
}
