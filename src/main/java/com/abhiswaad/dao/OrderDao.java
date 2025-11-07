package com.abhiswaad.dao;

import com.mongodb.client.*;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.*;

/**
 * DAO class for handling Orders in MongoDB.
 * Includes CRUD operations for user and admin features.
 */
public class OrderDao
{
    // ✅ Connect to MongoDB
    private MongoCollection<Document> getCollection()
    {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("AbhiSwaadDB");
        return database.getCollection("orders");
    }

    // ✅ Place Order Method (used by customers)
    public String placeOrder(String username, String restaurant, Map<String, Integer> items, String couponCode)
    {
        MongoCollection<Document> collection = getCollection();

        double totalAmount = 0.0;
        List<Document> orderItems = new ArrayList<>();

        // ✅ Example Menu (for demo; replace later with DB data)
        Map<String, Double> menu = new HashMap<>();
        menu.put("Pizza", 249.0);
        menu.put("Burger", 149.0);
        menu.put("Pasta", 199.0);
        menu.put("Sandwich", 99.0);
        menu.put("Taco", 169.0);
        menu.put("Cake", 139.0);

        // ✅ Calculate total
        for (Map.Entry<String, Integer> entry : items.entrySet())
        {
            String item = entry.getKey();
            int quantity = entry.getValue();

            if (menu.containsKey(item))
            {
                double price = menu.get(item) * quantity;
                totalAmount += price;

                Document orderItem = new Document("name", item)
                        .append("quantity", quantity)
                        .append("price", menu.get(item))
                        .append("subtotal", price);
                orderItems.add(orderItem);
            }
        }

        // ✅ Apply Coupon
        double discount = applyCoupon(couponCode, totalAmount);
        double finalAmount = totalAmount - discount;

        // ✅ Random ETA between 20–40 mins
        Random random = new Random();
        int min = 20 + random.nextInt(20);

        // ✅ Create Order Document
        Document order = new Document("username", username)
                .append("restaurant", restaurant)
                .append("items", orderItems)
                .append("totalAmount", totalAmount)
                .append("discount", discount)
                .append("finalAmount", finalAmount)
                .append("estimatedDelivery", min + " mins")
                .append("status", "Pending Payment")
                .append("orderDate", new Date());

        // ✅ Insert into MongoDB
        collection.insertOne(order);

        // ✅ Confirmation message
        return "\n✅ Order placed successfully!" +
                "\nRestaurant: " + restaurant +
                "\nTotal: ₹" + totalAmount +
                "\nDiscount: ₹" + discount +
                "\nPayable: ₹" + finalAmount +
                "\nETA: " + min + " mins" +
                "\n\n💰 Please proceed to payment.";
    }

    // ✅ Coupon system
    private double applyCoupon(String couponCode, double total)
    {
        if (couponCode == null || couponCode.trim().isEmpty())
            return 0.0;

        switch (couponCode.trim().toUpperCase())
        {
            case "ABHI10":
                return total * 0.10;
            case "FREEDINE":
                return 100.0;
            default:
                return 0.0;
        }
    }

    // ✅ Fetch all orders (Admin use)
    public List<Document> getAllOrders()
    {
        List<Document> orders = new ArrayList<>();
        try (MongoClient client = MongoClients.create("mongodb://localhost:27017"))
        {
            MongoCollection<Document> coll = client
                    .getDatabase("AbhiSwaadDB")
                    .getCollection("orders");
            coll.find().sort(new Document("orderDate", -1)).into(orders);
        }
        return orders;
    }

    // ✅ Fetch orders for a specific user (Customer use)
    public List<Document> getOrdersByUser(String username)
    {
        List<Document> userOrders = new ArrayList<>();
        try (MongoClient client = MongoClients.create("mongodb://localhost:27017"))
        {
            MongoCollection<Document> coll = client
                    .getDatabase("AbhiSwaadDB")
                    .getCollection("orders");

            coll.find(new Document("username", username))
                    .sort(new Document("orderDate", -1))
                    .into(userOrders);
        }
        return userOrders;
    }

    // ✅ Update status of a specific order by ID (Admin use)
    public void updateOrderStatusById(String id, String newStatus)
    {
        try (MongoClient client = MongoClients.create("mongodb://localhost:27017"))
        {
            MongoCollection<Document> coll = client
                    .getDatabase("AbhiSwaadDB")
                    .getCollection("orders");

            coll.updateOne(
                    new Document("_id", new ObjectId(id)),
                    new Document("$set", new Document("status", newStatus))
            );
        }
    }
}
