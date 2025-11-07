package com.abhiswaad.model;

import java.util.Date;
import java.util.List;

public class Order {
    private String id;
    private String username;
    private String restaurantId;
    private String restaurantName;
    private List<OrderItem> items;
    private double totalAmount;
    private double discount;
    private double finalAmount;
    private String status; // Pending Payment, Paid, Cancelled
    private String estimatedDelivery;
    private Date orderDate;

    public Order() {}

    // Getters / setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getRestaurantId() { return restaurantId; }
    public void setRestaurantId(String restaurantId) { this.restaurantId = restaurantId; }
    public String getRestaurantName() { return restaurantName; }
    public void setRestaurantName(String restaurantName) { this.restaurantName = restaurantName; }
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }
    public double getFinalAmount() { return finalAmount; }
    public void setFinalAmount(double finalAmount) { this.finalAmount = finalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getEstimatedDelivery() { return estimatedDelivery; }
    public void setEstimatedDelivery(String estimatedDelivery) { this.estimatedDelivery = estimatedDelivery; }
    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    // Nested OrderItem
    public static class OrderItem {
        private String name;
        private double price;
        private int quantity;

        public OrderItem() {}
        public OrderItem(String name, double price, int quantity) {
            this.name = name; this.price = price; this.quantity = quantity;
        }
        public String getName() { return name; }
        public double getPrice() { return price; }
        public int getQuantity() { return quantity; }
        public void setName(String name) { this.name = name; }
        public void setPrice(double price) { this.price = price; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
    }
}
