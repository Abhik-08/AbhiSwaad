<%@ page import="org.bson.Document, com.mongodb.client.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String restaurantName = request.getParameter("restaurant");
    List<Document> dishes = new ArrayList<>();

    try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
        MongoDatabase db = mongoClient.getDatabase("AbhiSwaadDB");
        MongoCollection<Document> coll = db.getCollection("restaurants");
        Document restaurant = coll.find(new Document("name", restaurantName)).first();
        if (restaurant != null)
            dishes = (List<Document>) restaurant.get("dishes");
    } catch (Exception e) { e.printStackTrace(); }
%>

<html>
<head>
    <title><%= restaurantName %> Menu | AbhiSwaad</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        /* --- General Setup --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #fff8e1, #ffe0b2, #ffd180, #ffccbc);
            background-size: 400% 400%;
            animation: gradientShift 12s ease infinite;
            color: #4e342e;
            padding: 40px 20px;
            overflow-x: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* --- Floating Food Icons --- */
        .floating-food {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
            pointer-events: none;
        }

        .floating-food i {
            position: absolute;
            color: rgba(255, 112, 67, 0.1);
            font-size: 30px;
            animation: floatFood 18s linear infinite;
        }

        @keyframes floatFood {
            0% { transform: translateY(100vh) rotate(0deg); opacity: 0; }
            50% { opacity: 1; }
            100% { transform: translateY(-10vh) rotate(360deg); opacity: 0; }
        }

        /* --- Header --- */
        h1 {
            text-align: center;
            color: #e64a19;
            margin-bottom: 35px;
            font-size: 40px;
            animation: fadeInUp 1s ease-out;
        }

        /* --- Table Section --- */
        form {
            text-align: center;
            animation: fadeInUp 1.2s ease-out;
        }

        table {
            width: 85%;
            margin: auto;
            border-collapse: collapse;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(8px);
            animation: fadeIn 1.5s ease-in-out;
        }

        th, td {
            padding: 15px;
            text-align: center;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        th {
            background: #ffccbc;
            color: #4e342e;
            font-size: 18px;
            text-transform: uppercase;
        }

        tr:nth-child(even) td {
            background: rgba(255, 236, 179, 0.3);
        }

        tr:hover td {
            background: rgba(255, 204, 188, 0.5);
        }

        input[type="number"] {
            width: 70px;
            padding: 6px;
            border-radius: 8px;
            border: 1px solid #ddd;
            text-align: center;
            transition: all 0.3s ease;
        }

        input[type="number"]:focus {
            border-color: #ff7043;
            box-shadow: 0 0 6px rgba(255,112,67,0.5);
            transform: scale(1.05);
            outline: none;
        }

        /* --- Buttons --- */
        .btn {
            background: #ff7043;
            color: white;
            padding: 14px 30px;
            border-radius: 8px;
            text-decoration: none;
            border: none;
            font-size: 17px;
            cursor: pointer;
            margin-top: 30px;
            transition: 0.4s ease;
            font-weight: 600;
            animation: pulseGlow 2.5s infinite;
        }

        .btn:hover {
            background: #e64a19;
            transform: scale(1.08);
            box-shadow: 0 0 20px rgba(255,112,67,0.5);
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 0 0 rgba(255,112,67,0.4); }
            50% { box-shadow: 0 0 20px rgba(255,112,67,0.4); }
            100% { box-shadow: 0 0 0 rgba(255,112,67,0.4); }
        }

        /* --- Animations --- */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* --- Footer --- */
        footer {
            text-align: center;
            padding: 20px;
            margin-top: 50px;
            background-color: #efebe9;
            color: #6d4c41;
            font-size: 14px;
            animation: fadeIn 2s ease-in-out;
        }
    </style>
</head>

<body>

    <!-- Floating Food Icons -->
    <div class="floating-food">
        <i class="fa-solid fa-pizza-slice" style="left: 10%; animation-delay: 0s;"></i>
        <i class="fa-solid fa-ice-cream" style="left: 30%; animation-delay: 4s;"></i>
        <i class="fa-solid fa-burger" style="left: 55%; animation-delay: 8s;"></i>
        <i class="fa-solid fa-mug-hot" style="left: 80%; animation-delay: 12s;"></i>
    </div>

    <h1>🍽️ <%= restaurantName %> Menu</h1>

    <form action="payment.jsp" method="get">
        <input type="hidden" name="restaurant" value="<%= restaurantName %>">

        <table>
            <tr><th>Dish</th><th>Price (₹)</th><th>Quantity</th></tr>
            <% for (Document d : dishes) { %>
            <tr>
                <td><%= d.getString("name") %></td>
                <td><%= d.get("price") %></td>
                <td><input type="number" name="qty_<%= d.getString("name") %>" value="0" min="0"></td>
            </tr>
            <% } %>
        </table>

        <button type="submit" class="btn">Proceed to Payment</button>
    </form>

    <footer>
        <p>© 2025 AbhiSwaad — Made with ❤ by Abhik Mukherjee</p>
    </footer>

</body>
</html>
