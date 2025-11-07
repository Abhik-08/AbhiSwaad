<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Result | AbhiSwaad</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #E0F7FA, #B2EBF2);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background: white;
            width: 400px;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            color: #00796B;
            font-size: 26px;
            margin-bottom: 15px;
        }

        p {
            font-size: 16px;
            color: #444;
        }

        .success {
            color: #2E7D32;
            font-weight: bold;
        }

        .failed {
            color: #C62828;
            font-weight: bold;
        }

        a.button {
            display: inline-block;
            background-color: #009688;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            margin-top: 20px;
        }

        a.button:hover {
            background-color: #00796B;
        }

        footer {
            position: absolute;
            bottom: 15px;
            font-size: 14px;
            color: #666;
        }
    </style>
</head>

<body>
    <div class="card">
        <h2>Payment Status</h2>

        <p>
            <%
                String result = (String) request.getAttribute("result");
                if (result != null) {
                    if (result.contains("✅")) {
                        out.println("<span class='success'>" + result + "</span>");
                    } else {
                        out.println("<span class='failed'>" + result + "</span>");
                    }
                } else {
                    out.println("<span class='failed'>⚠️ No payment data received.</span>");
                }
            %>
        </p>

        <a href="index.jsp" class="button">Back to Home</a>
    </div>

    <footer>Developed by Abhik Mukherjee © 2025</footer>
</body>
</html>
