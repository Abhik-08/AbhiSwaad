# 🍽️ AbhiSwaad – Food Order Management System

**AbhiSwaad** is a Java-based web application that simplifies restaurant food ordering by allowing users to browse restaurants, select dishes, apply discount coupons, make payments, and download PDF bills — all from a single platform.

The project is built using **JSP, Java Servlets, MongoDB, and Apache Tomcat**, following a **3-tier architecture** for clean design, scalability, and efficient data handling.

---

## 🚀 Key Features

### 👤 User Features
- User Login & Signup (Session-based authentication)
- Browse top Kolkata restaurants
- View menus and select food quantities
- Apply discount coupons
- Payment summary with live price calculation
- Auto-generated **PDF bill download**
- Secure logout

### 🧑‍💼 Admin Features
- Admin login
- View all placed orders
- Update order status
- Manage restaurant and menu data

---

## 🧩 System Architecture

JSP (Presentation Layer)
↓
Java Servlets (Controller Layer)
↓
DAO Layer
↓
MongoDB (Data Layer)


---

## 🛠️ Tech Stack

| Layer | Technology |
|------|------------|
| Frontend | JSP, HTML, CSS, JSTL |
| Backend | Java Servlets (Jakarta Servlet API) |
| Database | MongoDB |
| Server | Apache Tomcat 10.1 |
| Build Tool | Maven |
| PDF Generation | iTextPDF |
| IDE | IntelliJ IDEA |

---

## 📸 Screenshots

### 🏠 Home Page
Welcoming interface with quick navigation to start ordering.

### ⭐ Features Window
Highlights fast delivery, top restaurants, and secure payments.

### 🏪 Restaurants Browsing Page
Browse preloaded Kolkata restaurants like Pizza Hut, Mocambo, Chowman, and more.

### 🍕 Menu Page (Pizza Hut)
Select dishes, set quantities, and proceed to payment easily.

### 🎟️ Available Coupons
View active discount coupons with expiry dates.

### 💳 Payment Summary Page
Shows subtotal, applied coupon, discount, and final payable amount.

### 🧾 PDF Bill Generated
Automatically generated invoice with full order details.

---

## ▶️ How to Run Locally (IntelliJ IDEA)

### ✅ Prerequisites
- Java JDK 17+
- MongoDB (running locally)
- Apache Tomcat 10.1+
- Maven
- IntelliJ IDEA

### ▶️ Steps
```bash
git clone https://github.com/your-username/AbhiSwaad.git

1. Open the project in IntelliJ IDEA

2. Set JDK 17 in Project Structure

3. Configure Apache Tomcat Server

4. Ensure MongoDB is running at:
   mongodb://localhost:27017

5. Build the project:
   mvn clean install

6. Run the project on Tomcat
   http://localhost:8080/AbhiSwaad

🧠 Future Enhancements

Online payment gateway (UPI, Cards)

Live order tracking

Sales analytics dashboard

AI-based food recommendations

Mobile app (Android / iOS)

Cloud deployment (MongoDB Atlas)

👨‍💻 Developed By

Abhik Mukherjee
B.Tech CSE
Dr. B.C. Roy Engineering College, Durgapur

📧 Email: abhikmukherjee2003@gmail.com

🔗 LinkedIn: https://www.linkedin.com/in/abhik-mukherjee-b6a15920a


