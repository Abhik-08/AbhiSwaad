<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.abhiswaad.model.Order.OrderItem" %>
<html>
<head>
  <title>Your Cart - AbhiSwaad</title>
  <style>
    body{font-family:Arial;margin:24px;background:#fffaf6;}
    .box{background:#fff;padding:18px;border-radius:10px;max-width:800px;margin:auto;}
    .item{display:flex;justify-content:space-between;padding:8px 0;border-bottom:1px solid #eee;}
    .btn{background:#ff7a3d;color:#fff;padding:8px 12px;border-radius:6px;text-decoration:none;}
    .small{font-size:14px;color:#666;}
  </style>
</head>
<body>
<div class="box">
  <h2>Your Cart</h2>

  <%
    List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
    String restName = (String) session.getAttribute("cartRestName");
    if (cart == null || cart.isEmpty()) {
  %>
    <p>Your cart is empty. <a href="${pageContext.request.contextPath}/restaurants">Start ordering</a></p>
  <%
    } else {
        double total = 0.0;
        for (OrderItem it : cart) { total += it.getPrice() * it.getQuantity(); }
  %>

    <h3>Restaurant: <%= (restName==null?"-":restName) %></h3>

    <% for (OrderItem it : cart) { %>
      <div class="item">
        <div>
          <strong><%= it.getName() %></strong>
          <div class="small">Qty: <%= it.getQuantity() %>  •  Price: ₹<%= it.getPrice() %></div>
        </div>
        <div>₹ <%= String.format("%.2f", it.getPrice()*it.getQuantity()) %></div>
      </div>
    <% } %>

    <h3>Total: ₹ <%= String.format("%.2f", total) %></h3>

    <form action="<%= request.getContextPath() %>/placeOrder" method="post">
      <input type="hidden" name="restId" value="<%= session.getAttribute("cartRestId") %>"/>
      <input type="hidden" name="restName" value="<%= session.getAttribute("cartRestName") %>"/>
      <label>Your name: <input type="text" name="username" required/></label><br/><br/>
      <label>Coupon (optional): <input type="text" name="coupon"/></label><br/><br/>
      <input type="submit" value="Place Order & Generate Bill" class="btn"/>
    </form>

  <%
    }
  %>
</div>
</body>
</html>
