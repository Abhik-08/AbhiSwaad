package com.abhiswaad.util;

import com.mongodb.client.*;
import org.bson.Document;
import java.util.*;

public class PaymentGateway
{
    private static final String CONNECTION_STRING = "mongodb://localhost:27017";
    private static final String DATABASE_NAME = "AbhiSwaadDB";
    private static final String COLLECTION_NAME = "orders";

    // ✅ Payment simulation
    public String processPayment(String username, String restaurant, String method, double amount)
    {
        Random random = new Random();
        boolean success = random.nextBoolean(); // 50% chance for success/failure (simulation)

        String status = success ? "Success" : "Failed";

        // ✅ Save payment in MongoDB
        try (MongoClient client = MongoClients.create(CONNECTION_STRING))
        {
            MongoDatabase db = client.getDatabase(DATABASE_NAME);
            MongoCollection<Document> orders = db.getCollection(COLLECTION_NAME);

            // Find latest order for this user + restaurant
            Document latestOrder = orders.find(new Document("username", username)
                            .append("restaurant", restaurant))
                    .sort(new Document("_id", -1))
                    .first();

            if (latestOrder == null)
            {
                return "❌ No matching order found for payment update!";
            }

            // ✅ Add payment info
            Document paymentInfo = new Document("method", method)
                    .append("amount", amount)
                    .append("status", status)
                    .append("timestamp", new Date());

            Document update = new Document("$set", new Document("payment", paymentInfo)
                    .append("status", status.equals("Success") ? "Paid" : "Payment Failed"));

            orders.updateOne(new Document("_id", latestOrder.getObjectId("_id")), update);

            if (success)
            {
                return "✅ Payment Successful via " + method + " for ₹" + amount +
                        "\nStatus updated in database.";
            }
            else
            {
                return "❌ Payment Failed via " + method + ". Please try again!";
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return "⚠️ Payment processing error: " + e.getMessage();
        }
    }
}
