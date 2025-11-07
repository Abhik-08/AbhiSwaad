package com.abhiswaad.model;

public class Dish {
    private String name;
    private String description;
    private double price;

    // ✅ Updated constructor
    public Dish(String name, String description, double price) {
        this.name = name;
        this.description = description;
        this.price = price;
    }

    // Optional constructor (if you don’t always have a description)
    public Dish(String name, double price) {
        this(name, "", price);
    }

    public String getName() { return name; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
}
