<%@ page import="org.bson.Document, com.mongodb.client.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String restaurantName = request.getParameter("restaurant");
    double total = 0.0;
    List<Document> dishes = new ArrayList<>();
    Map<String, Integer> quantities = new HashMap<>();

    // ✅ Collect selected dishes and their quantities
    Enumeration<String> params = request.getParameterNames();
    while (params.hasMoreElements()) {
        String param = params.nextElement();
        if (param.startsWith("qty_")) {
            String dishName = param.substring(4);
            int qty = Integer.parseInt(request.getParameter(param));
            if (qty > 0)
                quantities.put(dishName, qty);
        }
    }

    // ✅ Fetch dishes for the selected restaurant
    try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
        MongoDatabase db = mongoClient.getDatabase("AbhiSwaadDB");
        MongoCollection<Document> coll = db.getCollection("restaurants");
        Document restaurant = coll.find(new Document("name", restaurantName)).first();

        if (restaurant != null)
            dishes = (List<Document>) restaurant.get("dishes");
    }

    // ✅ Prepare selected items and calculate total
    List<Document> selectedItems = new ArrayList<>();
    for (Document d : dishes) {
        String name = d.getString("name");
        if (quantities.containsKey(name)) {
            int q = quantities.get(name);
            double price = ((Number) d.get("price")).doubleValue();
            double subtotal = price * q;
            total += subtotal;
            selectedItems.add(new Document("name", name).append("qty", q).append("subtotal", subtotal));
        }
    }

    // ✅ Coupon logic
    String couponCode = request.getParameter("couponCode");
    double discountPercent = 0;

    if (couponCode != null && !couponCode.trim().isEmpty()) {
        couponCode = couponCode.trim().toUpperCase();
        switch (couponCode) {
            case "ABHI10": discountPercent = 10; break;
            case "FIRST50": discountPercent = 50; break;
            case "FREEDINE": discountPercent = 100; break;
            case "TASTY20": discountPercent = 20; break;
            default: discountPercent = 0; break;
        }
    }

    double discountAmount = total * (discountPercent / 100.0);
    double finalTotal = total - discountAmount;
%>

<html>
<head>
    <title>Payment | AbhiSwaad</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #fff3e0, #ffe0b2, #ffd180, #ffccbc);
            background-size: 400% 400%;
            animation: gradientShift 12s ease infinite;
            padding: 40px 20px;
            overflow-x: hidden;
            color: #4e342e;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .floating-food {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
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

        .container {
            max-width: 650px;
            background: rgba(255, 255, 255, 0.9);
            margin: auto;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            animation: fadeInUp 1s ease;
        }

        h1 {
            text-align: center;
            color: #e64a19;
            margin-bottom: 10px;
        }

        h3 {
            text-align: center;
            color: #6d4c41;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            animation: fadeIn 1.5s ease;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }

        th {
            background: #ffe0b2;
            color: #5d4037;
        }

        .coupon-box {
            margin: 25px 0;
            text-align: center;
            animation: fadeInUp 1s ease;
        }

        .coupon-box input {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            width: 60%;
            text-align: center;
            transition: 0.3s;
        }

        .coupon-box input:focus {
            border-color: #ff7043;
            box-shadow: 0 0 10px rgba(255,112,67,0.4);
            outline: none;
        }

        .coupon-box button {
            background: #ff7043;
            border: none;
            color: white;
            padding: 10px 16px;
            border-radius: 6px;
            margin-left: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        .coupon-box button:hover {
            background: #e64a19;
            transform: scale(1.05);
        }

        .total-box {
            background: #fff8f5;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
            text-align: right;
            animation: fadeInUp 1s ease;
        }

        .total-box h2 {
            color: #d84315;
            margin: 0;
        }

        .discount-text {
            color: green;
            font-weight: 600;
        }

        .btn {
            display: block;
            text-align: center;
            background: #ff7043;
            color: white;
            padding: 14px;
            border-radius: 8px;
            margin-top: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
            animation: pulseGlow 2s infinite;
        }

        .btn:hover {
            background: #e64a19;
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255,112,67,0.5);
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 0 0 rgba(255,112,67,0.4); }
            50% { box-shadow: 0 0 15px rgba(255,112,67,0.4); }
            100% { box-shadow: 0 0 0 rgba(255,112,67,0.4); }
        }

        .success {
            display: none;
            color: green;
            text-align: center;
            font-size: 16px;
            margin-top: 15px;
        }

        .empty {
            text-align: center;
            color: red;
            font-weight: bold;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>

    <!-- Floating food background -->
    <div class="floating-food">
        <i class="fa-solid fa-pizza-slice" style="left: 10%; animation-delay: 0s;"></i>
        <i class="fa-solid fa-burger" style="left: 40%; animation-delay: 3s;"></i>
        <i class="fa-solid fa-ice-cream" style="left: 70%; animation-delay: 6s;"></i>
        <i class="fa-solid fa-mug-hot" style="left: 90%; animation-delay: 9s;"></i>
    </div>

    <div class="container">
        <h1>Payment Summary</h1>
        <h3>Restaurant: <%= restaurantName %></h3>

        <% if (selectedItems.isEmpty()) { %>
            <p class="empty">⚠️ No items selected. Please go back and choose dishes.</p>
        <% } else { %>

        <table>
            <tr><th>Dish</th><th>Qty</th><th>Subtotal (₹)</th></tr>
            <% for (Document item : selectedItems) { %>
            <tr>
                <td><%= item.getString("name") %></td>
                <td><%= item.get("qty") %></td>
                <td>₹<%= item.get("subtotal") %></td>
            </tr>
            <% } %>
        </table>

        <!-- Coupon Section -->
        <div class="coupon-box">
            <form method="get">
                <input type="hidden" name="restaurant" value="<%= restaurantName %>">
                <% for (Map.Entry<String,Integer> e : quantities.entrySet()) { %>
                    <input type="hidden" name="qty_<%= e.getKey() %>" value="<%= e.getValue() %>">
                <% } %>
                <input type="text" name="couponCode" placeholder="Enter coupon code (e.g. ABHI10)" value="<%= (couponCode!=null)?couponCode:"" %>">
                <button type="submit">Apply</button>
            </form>
        </div>

        <!-- Total & Discount -->
        <div class="total-box">
            <p>Subtotal: ₹<%= total %></p>
            <% if (discountPercent > 0) { %>
                <p class="discount-text">Coupon "<%= couponCode %>" applied: -<%= discountPercent %>% (₹<%= discountAmount %>)</p>
            <% } %>
            <h2>Total Payable: ₹<%= finalTotal %></h2>
        </div>

        <!-- Proceed Button -->
        <form id="billForm" action="generateBill" method="post">
            <input type="hidden" name="restaurant" value="<%= restaurantName %>">
            <input type="hidden" name="total" value="<%= finalTotal %>">
            <input type="hidden" name="couponCode" value="<%= couponCode %>">
            <input type="hidden" name="discountPercent" value="<%= discountPercent %>">
            <input type="hidden" name="discountAmount" value="<%= discountAmount %>">
            <% for (Document item : selectedItems) { %>
                <input type="hidden" name="dish_<%= item.getString("name") %>" value="<%= item.getString("name") %>">
                <input type="hidden" name="qty_<%= item.getString("name") %>" value="<%= item.get("qty") %>">
                <input type="hidden" name="sub_<%= item.getString("name") %>" value="<%= item.get("subtotal") %>">
            <% } %>
            <a href="#" class="btn" id="payBtn">Proceed to Pay</a>
        </form>

        <p id="done" class="success">✅ Payment Successful! Bill Generated in your Downloads folder.</p>
        <% } %>
    </div>

    <script>
        document.getElementById("payBtn")?.addEventListener("click", function(e) {
            e.preventDefault();
            this.style.display = "none";
            document.getElementById("done").style.display = "block";
            document.getElementById("billForm").submit();
        });
    </script>
</body>
</html>
