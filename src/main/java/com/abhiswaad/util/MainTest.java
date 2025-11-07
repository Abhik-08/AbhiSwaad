package com.abhiswaad.util;

import com.mongodb.client.*;
import org.bson.Document;

import java.util.*;

public class MainTest
{
    public static void main(String[] args)
    {
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017"))
        {
            MongoDatabase db = mongoClient.getDatabase("AbhiSwaadDB");
            MongoCollection<Document> restaurants = db.getCollection("restaurants");

            // Clear old data
            restaurants.drop();

            // ✅ Define restaurants and their dishes
            List<Document> restaurantList = new ArrayList<>();

            restaurantList.add(new Document("name", "Tandoori Tales")
                    .append("address", "Park Street, Kolkata")
                    .append("rating", 4.7)
                    .append("dishes", Arrays.asList(
                            new Document("name", "Butter Chicken").append("price", 280.0),
                            new Document("name", "Paneer Tikka").append("price", 230.0),
                            new Document("name", "Garlic Naan").append("price", 70.0),
                            new Document("name", "Biryani").append("price", 250.0),
                            new Document("name", "Lassi").append("price", 90.0),
                            new Document("name", "Gulab Jamun").append("price", 80.0)
                    )));

            restaurantList.add(new Document("name", "Chowman")
                    .append("address", "Salt Lake, Sector 1, Kolkata")
                    .append("rating", 4.6)
                    .append("dishes", Arrays.asList(
                            new Document("name", "Hakka Noodles").append("price", 220.0),
                            new Document("name", "Chilli Chicken").append("price", 260.0),
                            new Document("name", "Spring Rolls").append("price", 150.0),
                            new Document("name", "Fried Rice").append("price", 210.0),
                            new Document("name", "Chicken Manchurian").append("price", 240.0),
                            new Document("name", "Hot Garlic Prawns").append("price", 320.0)
                    )));

            restaurantList.add(new Document("name", "Pizza Hut")
                    .append("address", "Quest Mall, Kolkata")
                    .append("rating", 4.4)
                    .append("dishes", Arrays.asList(
                            new Document("name", "Veggie Supreme Pizza").append("price", 379.0),
                            new Document("name", "Pepperoni Pizza").append("price", 449.0),
                            new Document("name", "Garlic Bread").append("price", 149.0),
                            new Document("name", "Pasta Alfredo").append("price", 299.0),
                            new Document("name", "Choco Lava Cake").append("price", 139.0),
                            new Document("name", "Pepsi").append("price", 70.0)
                    )));

            restaurantList.add(new Document("name", "Mocambo")
                    .append("address", "Park Street, Kolkata")
                    .append("rating", 4.8)
                    .append("dishes", Arrays.asList(
                            new Document("name", "Fish Meuniere").append("price", 490.0),
                            new Document("name", "Grilled Chicken").append("price", 410.0),
                            new Document("name", "Prawn Cocktail").append("price", 370.0),
                            new Document("name", "Spaghetti Bolognese").append("price", 360.0),
                            new Document("name", "Lemon Tart").append("price", 150.0),
                            new Document("name", "Cold Coffee").append("price", 120.0)
                    )));

            restaurantList.add(new Document("name", "Bhojohori Manna")
                    .append("address", "Gariahat, Kolkata")
                    .append("rating", 4.5)
                    .append("dishes", Arrays.asList(
                            new Document("name", "Kosha Mangsho").append("price", 300.0),
                            new Document("name", "Luchi").append("price", 40.0),
                            new Document("name", "Shorshe Ilish").append("price", 380.0),
                            new Document("name", "Chingri Malai Curry").append("price", 400.0),
                            new Document("name", "Basanti Pulao").append("price", 160.0),
                            new Document("name", "Mishti Doi").append("price", 70.0)
                    )));

            // Insert all
            restaurants.insertMany(restaurantList);
            System.out.println("✅ Successfully inserted sample restaurants and dishes!");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
