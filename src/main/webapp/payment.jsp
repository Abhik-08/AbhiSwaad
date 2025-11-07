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

    // ✅ Coupon logic (safe type handling)
    String couponCode = request.getParameter("couponCode");
    double discountPercent = 0;
    String couponMessage = null;

    if (couponCode != null && !couponCode.trim().isEmpty()) {
        couponCode = couponCode.trim().toUpperCase();
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase db = mongoClient.getDatabase("AbhiSwaadDB");
            MongoCollection<Document> couponColl = db.getCollection("coupons");

            Document coupon = couponColl.find(new Document("code", couponCode)).first();
            if (coupon != null) {
                Object discountObj = coupon.get("discount");
                if (discountObj instanceof Number)
                    discountPercent = ((Number) discountObj).doubleValue();
                else if (discountObj instanceof String)
                    discountPercent = Double.parseDouble((String) discountObj);

                Object expiryObj = coupon.get("expiry");
                String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
                boolean valid = true;
                String expiryDateStr = null;

                if (expiryObj instanceof java.util.Date) {
                    expiryDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format((java.util.Date) expiryObj);
                    valid = expiryDateStr.compareTo(today) >= 0;
                } else if (expiryObj instanceof String) {
                    expiryDateStr = (String) expiryObj;
                    valid = expiryDateStr.compareTo(today) >= 0;
                }

                if (valid) {
                    couponMessage = "✅ Coupon \"" + couponCode + "\" applied successfully!"
                            + (expiryDateStr != null ? " (valid till " + expiryDateStr + ")" : "");
                } else {
                    discountPercent = 0;
                    couponMessage = "⚠️ Coupon expired"
                            + (expiryDateStr != null ? " on " + expiryDateStr : "") + ".";
                }
            } else {
                couponMessage = "❌ Invalid coupon code!";
            }
        } catch (Exception e) {
            couponMessage = "⚠️ Error validating coupon.";
            e.printStackTrace();
        }
    }

    double discountAmount = total * (discountPercent / 100.0);
    double finalTotal = total - discountAmount;

    // ✅ Fetch all active coupons for popup
    List<Document> availableCoupons = new ArrayList<>();
    try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
        MongoDatabase db = mongoClient.getDatabase("AbhiSwaadDB");
        MongoCollection<Document> couponColl = db.getCollection("coupons");
        FindIterable<Document> all = couponColl.find();
        String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

        for (Document c : all) {
            Object expiryObj = c.get("expiry");
            String expiryStr = null;
            boolean valid = true;

            if (expiryObj instanceof java.util.Date) {
                expiryStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format((java.util.Date) expiryObj);
                valid = expiryStr.compareTo(today) >= 0;
            } else if (expiryObj instanceof String) {
                expiryStr = (String) expiryObj;
                valid = expiryStr.compareTo(today) >= 0;
            }

            if (valid) availableCoupons.add(c);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
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
            color: #4e342e;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            max-width: 650px;
            background: rgba(255, 255, 255, 0.95);
            margin: auto;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            animation: fadeInUp 1s ease;
        }

        .coupon-box {
            margin: 25px 0;
            text-align: center;
        }

        .coupon-box button.view-btn {
            background: #ffa726;
            border: none;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            margin-top: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        .coupon-box button.view-btn:hover {
            background: #fb8c00;
            transform: scale(1.05);
        }

        .coupon-popup {
            display: none;
            position: fixed;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 14px;
            padding: 20px;
            width: 400px;
            max-height: 60vh;
            overflow-y: auto;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            z-index: 100;
            animation: fadeIn 0.4s ease;
        }

        .coupon-popup h2 {
            text-align: center;
            color: #e64a19;
            margin-bottom: 10px;
        }

        .coupon-popup .coupon-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }

        .coupon-popup .coupon-item p {
            margin: 3px 0;
            font-size: 14px;
        }

        .coupon-popup .close-btn {
            display: block;
            margin: 10px auto 0;
            background: #ff7043;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        .coupon-popup .close-btn:hover {
            background: #d84315;
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

        <div class="coupon-box">
            <form method="get">
                <input type="hidden" name="restaurant" value="<%= restaurantName %>">
                <% for (Map.Entry<String,Integer> e : quantities.entrySet()) { %>
                    <input type="hidden" name="qty_<%= e.getKey() %>" value="<%= e.getValue() %>">
                <% } %>
                <input type="text" name="couponCode" placeholder="Enter coupon code (e.g. ABHI10)" value="<%= (couponCode!=null)?couponCode:"" %>">
                <button type="submit">Apply</button>
            </form>
            <button class="view-btn" id="viewCouponsBtn">🎟️ View Available Coupons</button>

            <% if (couponMessage != null) { %>
                <p class="coupon-message" style="color:<%= couponMessage.startsWith("✅")?"green":"red" %>;">
                    <%= couponMessage %>
                </p>
            <% } %>
        </div>

        <div class="total-box">
            <p>Subtotal: ₹<%= total %></p>
            <% if (discountPercent > 0) { %>
                <p class="discount-text">Coupon "<%= couponCode %>" applied: -<%= discountPercent %>% (₹<%= discountAmount %>)</p>
            <% } %>
            <h2>Total Payable: ₹<%= finalTotal %></h2>
        </div>

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
        <% } %>
    </div>

    <!-- Coupon Popup -->
    <div id="couponPopup" class="coupon-popup">
        <h2>🎁 Active Coupons</h2>
        <% if (availableCoupons.isEmpty()) { %>
            <p>No active coupons right now!</p>
        <% } else {
            for (Document c : availableCoupons) {
                String code = c.getString("code");
                Object dis = c.get("discount");
                Object exp = c.get("expiry");
        %>
            <div class="coupon-item">
                <p><b>Code:</b> <%= code %></p>
                <p><b>Discount:</b> <%= dis %>%</p>
                <p><b>Expiry:</b> <%= exp %></p>
            </div>
        <% } } %>
        <button class="close-btn" id="closePopup">Close</button>
    </div>

    <script>
        const popup = document.getElementById('couponPopup');
        document.getElementById('viewCouponsBtn').onclick = () => popup.style.display = 'block';
        document.getElementById('closePopup').onclick = () => popup.style.display = 'none';
        document.getElementById('payBtn')?.addEventListener('click', e => {
            e.preventDefault();
            e.target.style.display = 'none';
            document.getElementById('billForm').submit();
        });
    </script>
</body>
</html>
