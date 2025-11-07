<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Order Placed</title>
  <style>
    body{font-family:Arial;text-align:center;padding-top:80px;background:#f8fff8;}
    .box{display:inline-block;padding:24px;background:#fff;border-radius:10px;box-shadow:0 6px 18px rgba(0,0,0,0.06);}
    .btn{background:#ff7a3d;color:#fff;padding:10px 14px;border-radius:8px;text-decoration:none;}
  </style>
</head>
<body>
  <div class="box">
    <h2>✅ Order Placed</h2>
    <p><strong><%= request.getAttribute("message") %></strong></p>
    <p>Your bill PDF has been generated and saved to your Downloads folder (if BillGenerator succeeded).</p>
    <a class="btn" href="${pageContext.request.contextPath}/restaurants">Back to restaurants</a>
  </div>
</body>
</html>
