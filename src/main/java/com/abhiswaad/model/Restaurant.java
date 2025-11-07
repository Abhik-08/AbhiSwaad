package com.abhiswaad.model;

import java.util.List;

public class Restaurant {
    private String id;
    private String name;
    private String category;
    private String address;
    private double rating;
    private int deliveryTime; // in minutes
    private List<Dish> dishes;

    // ✅ Full Constructor (matches your DAO calls)
    public Restaurant(String id, String name, String category, String address, double rating, int deliveryTime, List<Dish> dishes) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.address = address;
        this.rating = rating;
        this.deliveryTime = deliveryTime;
        this.dishes = dishes;
    }

    // ✅ Simplified Constructors for flexibility
    public Restaurant(String name, String category, double rating, List<Dish> dishes) {
        this("R" + System.currentTimeMillis(), name, category, "N/A", rating, 30, dishes);
    }

    public Restaurant(String name, double rating, List<Dish> dishes) {
        this("R" + System.currentTimeMillis(), name, "General", "N/A", rating, 30, dishes);
    }

    // ✅ Getters
    public String getId() { return id; }
    public String getName() { return name; }
    public String getCategory() { return category; }
    public String getAddress() { return address; }
    public double getRating() { return rating; }
    public int getDeliveryTime() { return deliveryTime; }
    public List<Dish> getDishes() { return dishes; }

    // ✅ Optional Setters (only if needed)
    public void setId(String id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setCategory(String category) { this.category = category; }
    public void setAddress(String address) { this.address = address; }
    public void setRating(double rating) { this.rating = rating; }
    public void setDeliveryTime(int deliveryTime) { this.deliveryTime = deliveryTime; }
    public void setDishes(List<Dish> dishes) { this.dishes = dishes; }
}
