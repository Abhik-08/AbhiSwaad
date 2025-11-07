<%@ page import="org.bson.Document, org.bson.types.ObjectId, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Dashboard | AbhiSwaad</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(120deg, #fff8e1, #ffe0b2);
            padding: 30px;
        }
        h1 {
            text-align: center;
            color: #e64a19;
            font-size: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background: #ffcc80;
            color: #4e342e;
        }
        select, button {
            padding: 6px 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background: #ff7043;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background: #e64a19;
        }
        .logout {
            float: right;
            background: #d32f2f;
            color: white;
            border: none;
            padding: 7px 15px;
            border-radius: 6px;
            margin-bottom: 10px;
            cursor: pointer;
        }
        .logout:hover {
            background: #b71c1c;
        }
    </style>
</head>
<body>

<!-- 🔒 Logout Form -->
<form action="logout" method="post">
    <button class="logout" type="submit">Logout</button>
</form>

<h1>👨‍🍳 Admin Dashboard – Manage Orders</h1>

<%
    List<Document> orders = (List<Document>) request.getAttribute("ordersList");
    if (orders == null || orders.isEmpty()) {
%>
    <p style="text-align:center;color:red;">No orders found in the system.</p>
<%
    } else {
%>
<table>
    <tr>
        <th>Order ID</th>
        <th>Customer</th>
        <th>Restaurant</th>
        <th>Total (₹)</th>
        <th>Status</th>
        <th>ETA</th>
        <th>Update Status</th>
    </tr>

<%
        for (Document o : orders) {
            String id = o.getObjectId("_id").toHexString();
            String user = o.getString("username");
            String rest = o.getString("restaurant");
            String status = o.getString("status");
            String eta = o.getString("estimatedDelivery");
            double total = o.getDouble("finalAmount");
%>
    <tr>
        <td><%= id.substring(0, 8) %>...</td>
        <td><%= user %></td>
        <td><%= rest %></td>
        <td>₹<%= total %></td>
        <td><%= status %></td>
        <td><%= eta %></td>
        <td>
            <form action="adminDashboard" method="post" style="margin:0;">
                <input type="hidden" name="orderId" value="<%= id %>">
                <select name="newStatus">
                    <option value="Preparing">Preparing</option>
                    <option value="Out for Delivery">Out for Delivery</option>
                    <option value="Delivered">Delivered</option>
                </select>
                <button type="submit">Update</button>
            </form>
        </td>
    </tr>
<%
        }
    }
%>
</table>

<p style="text-align:center;margin-top:20px;">
    <a href="trackOrders" style="color:#e64a19;text-decoration:none;font-weight:bold;">
        🔍 View Customer Tracking →
    </a>
</p>

</body>
</html>
