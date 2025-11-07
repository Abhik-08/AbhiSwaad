<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Login | AbhiSwaad</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ffcc80, #ff8a65);
            display: flex; justify-content: center; align-items: center;
            height: 100vh;
        }
        .login-box {
            background: #fff3e0;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            width: 320px;
        }
        h2 { text-align: center; color: #e64a19; }
        input[type=text], input[type=password] {
            width: 100%; padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc; border-radius: 6px;
        }
        button {
            background: #e64a19; color: white;
            width: 100%; padding: 10px;
            border: none; border-radius: 6px;
            cursor: pointer;
        }
        button:hover { background: #d84315; }
        .error { color: red; text-align: center; }
    </style>
</head>
<body>
<div class="login-box">
    <h2>👨‍🍳 Admin Login</h2>

    <form action="adminLogin" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <p class="error"><%= error %></p>
    <% } %>
</div>
</body>
</html>
