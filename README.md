# 🍽️ AbhiSwaad – Food Order Management System

AbhiSwaad is a full-stack Java-based food order management web application designed to digitalize restaurant ordering and management processes. The system allows users to browse restaurants, explore menus, place food orders, apply discount coupons, make payments, and download professionally generated PDF bills.

The application is developed using **JSP, Java Servlets, MongoDB, and Apache Tomcat**, and follows a **3-Tier Architecture** to ensure modularity, scalability, and clean separation between presentation, business logic, and data layers.

---

## 🚀 Key Features

### USER FEATURES
- User Registration & Login using secure HTTP sessions  
- Browse preloaded popular Kolkata restaurants  
- View restaurant-specific menus with prices  
- Select food items with quantity control  
- Apply discount coupons (e.g., FIRST50, ABHI10)  
- View payment summary with real-time calculation  
- Auto-generate and download PDF bill after payment  
- Secure logout with session invalidation  

### ADMIN FEATURES
- Admin authentication  
- View all placed orders  
- Update order status (Pending, Paid, Delivered)  
- Manage restaurant and menu information  

---

## 🧩 System Architecture

Presentation Layer (JSP, HTML, CSS)  
  ↓  
Controller Layer (Java Servlets)  
  ↓  
Data Access Layer (DAO Classes)  
  ↓  
MongoDB Database  

The architecture ensures better maintainability, easy debugging, and future scalability.

---

## 🛠️ Tech Stack

Frontend  : JSP, HTML, CSS, JSTL  
Backend   : Java Servlets (Jakarta Servlet API)  
Database  : MongoDB  
Server    : Apache Tomcat 10.1  
Build     : Apache Maven  
PDF       : iTextPDF  
IDE       : IntelliJ IDEA  

---

## 📸 Screenshots (User Interface)

### Figure 1 – Home Page
The Home Page serves as the entry point of AbhiSwaad, welcoming users with a clean and visually appealing interface. It introduces the platform’s purpose and provides quick navigation options to explore restaurants and start ordering.

![Figure 4 – Home Page](screenshots/figure4_home.png)

---

### Figure 2 – Features Window
This section highlights the core strengths of AbhiSwaad such as Fast Delivery, Top Restaurants, and Secure Payments. It builds user trust and encourages engagement through a modern, food-themed design.

![Figure 5 – Features Window](screenshots/figure5_features.png)

---

### Figure 3 – Restaurants Browsing Page
The Restaurants Browsing Page displays a curated list of popular Kolkata restaurants including Pizza Hut, Mocambo, Chowman, and Tandoori Tales. Users can view restaurant details and navigate to menus easily.

![Figure 6 – Restaurants Browsing Page](screenshots/figure6_restaurants.png)

---

### Figure 3 – Menu Page (Pizza Hut)
The Menu Page shows all available dishes with prices and quantity selectors. Users can choose multiple food items and proceed smoothly to the payment process.

![Figure 7 – Menu Page](screenshots/figure7_menu.png)

---

### Figure 4 – Available Coupons
This page lists all active discount coupons with their codes, discount percentages, and expiry dates, allowing users to save money during checkout.

![Figure 8 – Available Coupons](screenshots/figure8_coupons.png)

---

### Figure 6 – Payment Summary Page
The Payment Summary Page displays selected items, subtotal, applied coupon discount, and final payable amount. It ensures transparency before order confirmation.

![Figure 9 – Payment Summary](screenshots/figure9_payment.png)

---

### Figure 7 – PDF Bill Generated
After successful payment, a detailed PDF bill is automatically generated using iTextPDF. The bill includes order details, applied discounts, and the final amount.

![Figure 10 – PDF Bill](screenshots/figure10_bill.png)

---

## ▶️ How to Run Locally (IntelliJ IDEA)

git clone https://github.com/your-username/AbhiSwaad.git

cd AbhiSwaad

# Open project in IntelliJ IDEA  
# File → Open → Select AbhiSwaad folder  

# Set Java SDK  
# Project Structure → SDK → JDK 17+  

# Configure Apache Tomcat  
# Run → Edit Configurations → Add Tomcat (Local)  

# Ensure MongoDB is running locally  
mongodb://localhost:27017  

# Build the project  
mvn clean install  

# Run on Tomcat  
# Click Run ▶️  

# Open in browser  
http://localhost:8080/AbhiSwaad  

---

## 🧠 Future Enhancements

- Online payment gateway integration (UPI, Debit/Credit Cards)  
- Live order tracking system  
- Sales analytics and reporting dashboard  
- AI-based food recommendations  
- Mobile application (Android / iOS)  
- Cloud deployment using MongoDB Atlas  

---

## 👨‍💻 Developed By

Abhik Mukherjee  
B.Tech CSE  
Dr. B.C. Roy Engineering College, Durgapur  

Email    : abhikmukherjee2003@gmail.com  
LinkedIn : https://www.linkedin.com/in/abhik-mukherjee-b6a15920a  
