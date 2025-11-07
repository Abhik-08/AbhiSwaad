<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.abhiswaad.model.Restaurant, com.abhiswaad.model.Dish" %>
<html>
<head>
    <title>Order Food - AbhiSwaad</title>
    <style>
        body { font-family: Arial; background: #fdf1e7; text-align: center; }
        .dish { margin: 10px auto; width: 400px; background: white; padding: 10px; border-radius: 8px; }
        button { background: #ff7043; color: white; border: none; padding: 8px 15px; border-radius: 6px; cursor: pointer; }
    </style>
</head>
<body>

<%
    String restaurant = request.getParameter("restaurant");
%>
<h1>🍛 <%= restaurant %></h1>
<form action="PlaceOrderServlet" method="post">
    <input type="hidden" name="restaurant" value="<%= restaurant %>">

    <div class="dish">
        <label>Pizza (₹249): </label>
        <input type="number" name="Pizza" value="0" min="0">
    </div>
    <div class="dish">
        <label>Burger (₹149): </label>
        <input type="number" name="Burger" value="0" min="0">
    </div>
    <div class="dish">
        <label>Pasta (₹199): </label>
        <input type="number" name="Pasta" value="0" min="0">
    </div>
    <div class="dish">
        <label>Sandwich (₹99): </label>
        <input type="number" name="Sandwich" value="0" min="0">
    </div>
    <div class="dish">
        <label>Taco (₹169): </label>
        <input type="number" name="Taco" value="0" min="0">
    </div>

    <br>
    <label>Coupon Code: </label>
    <input type="text" name="couponCode">
    <br><br>
    <button type="submit">Place Order</button>
</form>

</body>
</html>
