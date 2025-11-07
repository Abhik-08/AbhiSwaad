package com.abhiswaad.dao;

import com.abhiswaad.model.Dish;
import com.abhiswaad.model.Restaurant;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import org.bson.Document;
import java.util.*;

public class RestaurantDao {

    private MongoCollection<Document> getCollection() {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("AbhiSwaadDB");
        return database.getCollection("restaurants");
    }

    public void insertSampleRestaurants() {
        MongoCollection<Document> collection = getCollection();
        collection.drop(); // clear old data before inserting new

        List<Restaurant> restaurants = new ArrayList<>();

        // ✅ Restaurant 1
        List<Dish> r1dishes = Arrays.asList(
                new Dish("Butter Chicken", "Rich creamy chicken curry", 249),
                new Dish("Paneer Tikka", "Grilled cottage cheese cubes", 199),
                new Dish("Naan", "Soft tandoori bread", 49),
                new Dish("Biryani", "Fragrant rice with spices", 299),
                new Dish("Gulab Jamun", "Sweet dessert balls", 99)
        );
        restaurants.add(new Restaurant("R101", "Tandoori Tales", "Indian", "Park Street, Kolkata", 4.6, 30, r1dishes));

        // ✅ Restaurant 2
        List<Dish> r2dishes = Arrays.asList(
                new Dish("Margherita Pizza", "Classic cheese pizza", 249),
                new Dish("Veg Supreme", "Loaded with veggies", 299),
                new Dish("Garlic Bread", "Toasted with herbs", 129),
                new Dish("Pasta Alfredo", "Creamy white sauce pasta", 239),
                new Dish("Brownie", "Chocolate dessert", 149)
        );
        restaurants.add(new Restaurant("R102", "Bella Italia", "Italian", "Salt Lake, Kolkata", 4.5, 25, r2dishes));

        // ✅ Restaurant 3
        List<Dish> r3dishes = Arrays.asList(
                new Dish("Chowmein", "Stir-fried noodles", 179),
                new Dish("Chilli Chicken", "Spicy Indo-Chinese chicken", 229),
                new Dish("Spring Roll", "Crispy veggie rolls", 99),
                new Dish("Fried Rice", "Fried rice with veggies", 149),
                new Dish("Manchurian", "Tangy spicy dish", 189)
        );
        restaurants.add(new Restaurant("R103", "Dragon Wok", "Chinese", "New Town, Kolkata", 4.4, 28, r3dishes));

        // ✅ Restaurant 4
        List<Dish> r4dishes = Arrays.asList(
                new Dish("Cheeseburger", "Loaded beef patty and cheese", 249),
                new Dish("Fries", "Crispy potato fries", 99),
                new Dish("Wrap", "Stuffed grilled roll", 179),
                new Dish("Milkshake", "Vanilla or chocolate shake", 149),
                new Dish("Chicken Nuggets", "Fried crispy bites", 129)
        );
        restaurants.add(new Restaurant("R104", "Burger House", "Fast Food", "Sector V, Kolkata", 4.3, 20, r4dishes));

        // ✅ Restaurant 5
        List<Dish> r5dishes = Arrays.asList(
                new Dish("Sushi Roll", "Salmon with rice and seaweed", 349),
                new Dish("Ramen", "Japanese noodle soup", 299),
                new Dish("Miso Soup", "Soybean soup", 149),
                new Dish("Tempura", "Crispy fried prawns", 259),
                new Dish("Mochi", "Japanese sweet rice cake", 139)
        );
        restaurants.add(new Restaurant("R105", "Tokyo Dine", "Japanese", "Camac Street, Kolkata", 4.7, 35, r5dishes));

        // ✅ Insert into MongoDB
        for (Restaurant restaurant : restaurants) {
            List<Document> dishDocs = new ArrayList<>();
            for (Dish dish : restaurant.getDishes()) {
                dishDocs.add(new Document("name", dish.getName())
                        .append("description", dish.getDescription())
                        .append("price", dish.getPrice()));
            }

            Document restaurantDoc = new Document("id", restaurant.getId())
                    .append("name", restaurant.getName())
                    .append("category", restaurant.getCategory())
                    .append("address", restaurant.getAddress())
                    .append("rating", restaurant.getRating())
                    .append("deliveryTime", restaurant.getDeliveryTime())
                    .append("dishes", dishDocs);

            collection.insertOne(restaurantDoc);
        }

        System.out.println("✅ Sample restaurants inserted successfully!");
    }
}
