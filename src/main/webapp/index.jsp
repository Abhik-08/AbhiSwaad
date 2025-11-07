<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome to AbhiSwaad - Food Delivery</title>
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

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #ffccbc, #ffe0b2, #ffd180, #ffab91);
            background-size: 400% 400%;
            animation: gradientFlow 12s ease infinite;
            color: #4e342e;
            overflow-x: hidden;
        }

        @keyframes gradientFlow {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
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
            color: rgba(255, 112, 67, 0.15);
            font-size: 30px;
            animation: floatFood 18s linear infinite;
        }

        @keyframes floatFood {
            0% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            50% {
                opacity: 1;
            }
            100% {
                transform: translateY(-10vh) rotate(360deg);
                opacity: 0;
            }
        }

        /* --- Navbar --- */
        .navbar {
            position: sticky;
            top: 0;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
            z-index: 100;
            animation: fadeDown 1s ease-out forwards;
        }

        .navbar .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 26px;
            font-weight: 700;
            color: #ff7043;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: 0.4s;
        }

        .logo i {
            margin-right: 8px;
            animation: rotateUtensil 3s linear infinite;
        }

        @keyframes rotateUtensil {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .logo:hover {
            transform: scale(1.08);
        }

        /* --- Hero Section --- */
        .hero {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 85vh;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(15px);
            padding: 60px;
            border-radius: 20px;
            box-shadow: 0 8px 35px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 700px;
            transform: scale(0.9);
            opacity: 0;
            animation: zoomIn 1.5s ease forwards 0.6s;
        }

        .hero-icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: #ff7043;
            animation: floatUpDown 3s ease-in-out infinite;
        }

        @keyframes floatUpDown {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-12px); }
        }

        .hero-content h1 {
            font-size: 46px;
            margin-bottom: 15px;
            color: #3e2723;
            animation: fadeInUp 1s ease-in-out forwards 0.8s;
        }

        .hero-content p {
            color: #5d4037;
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 30px;
            opacity: 0;
            animation: fadeInUp 1s ease-in-out forwards 1s;
        }

        .btn {
            background-color: #ff7043;
            color: white;
            font-size: 18px;
            padding: 14px 36px;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.4s ease;
            font-weight: 600;
            display: inline-block;
            animation: pulseGlow 2s infinite;
        }

        .btn:hover {
            background-color: #e64a19;
            transform: scale(1.1);
            box-shadow: 0 0 20px rgba(255, 112, 67, 0.6);
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 0 0 rgba(255,112,67,0.5); }
            50% { box-shadow: 0 0 20px rgba(255,112,67,0.5); }
            100% { box-shadow: 0 0 0 rgba(255,112,67,0.5); }
        }

        /* --- Features Section --- */
        .features {
            padding: 80px 0;
            background: #fffdf9;
        }

        .features .container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 35px;
        }

        .feature-item {
            flex-basis: 300px;
            text-align: center;
            padding: 30px 25px;
            background: white;
            border-radius: 18px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
            opacity: 0;
            transform: translateY(60px);
        }

        .feature-item i {
            font-size: 40px;
            color: #ff7043;
            margin-bottom: 15px;
            transition: 0.3s ease;
        }

        .feature-item:hover {
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 10px 30px rgba(255, 112, 67, 0.3);
        }

        .feature-item:hover i {
            transform: rotate(10deg);
        }

        /* --- Footer --- */
        footer {
            text-align: center;
            padding: 25px 0;
            background-color: #efebe9;
            color: #6d4c41;
            font-size: 14px;
            margin-top: 50px;
            animation: fadeIn 2s ease-in-out forwards;
        }

        /* --- Keyframes --- */
        @keyframes fadeDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes zoomIn {
            from { transform: scale(0.9); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            to { opacity: 1; }
        }

        /* --- Scroll Reveal --- */
        .reveal {
            opacity: 0;
            transform: translateY(40px);
            transition: all 0.8s ease;
        }

        .reveal.active {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>

    <!-- Floating background food icons -->
    <div class="floating-food">
        <i class="fa-solid fa-pizza-slice" style="left: 10%; animation-delay: 0s;"></i>
        <i class="fa-solid fa-burger" style="left: 40%; animation-delay: 3s;"></i>
        <i class="fa-solid fa-ice-cream" style="left: 70%; animation-delay: 6s;"></i>
        <i class="fa-solid fa-fish" style="left: 90%; animation-delay: 9s;"></i>
        <i class="fa-solid fa-mug-hot" style="left: 25%; animation-delay: 12s;"></i>
    </div>

    <header class="navbar">
        <div class="container">
            <a href="#" class="logo">
                <i class="fa-solid fa-utensils"></i>
                AbhiSwaad
            </a>
        </div>
    </header>

    <main class="hero">
        <div class="hero-content">
            <div class="hero-icon">🍲</div>
            <h1>Welcome to <b>AbhiSwaad</b></h1>
            <p>Your one-stop destination for delicious food from top Kolkata restaurants.
                Explore, order, and enjoy authentic flavors delivered to your doorstep!</p>
            <a href="restaurants" class="btn">Start Ordering Now</a>
        </div>
    </main>

    <section class="features">
        <div class="container">
            <div class="feature-item reveal">
                <i class="fa-solid fa-rocket"></i>
                <h3>Fast Delivery</h3>
                <p>Get your favorite meals delivered hot and fresh, right on time.</p>
            </div>
            <div class="feature-item reveal">
                <i class="fa-solid fa-star"></i>
                <h3>Top Restaurants</h3>
                <p>Handpicked selection of the best and most-loved local eateries.</p>
            </div>
            <div class="feature-item reveal">
                <i class="fa-solid fa-credit-card"></i>
                <h3>Secure Payments</h3>
                <p>Easy, fast, and secure payment options for a smooth checkout.</p>
            </div>
        </div>
    </section>

    <footer>
        <p>© 2025 AbhiSwaad — Made with ❤ by Abhik Mukherjee</p>
    </footer>

    <script>
        // Scroll reveal animation
        const reveals = document.querySelectorAll(".reveal");

        window.addEventListener("scroll", () => {
            reveals.forEach((el) => {
                const windowHeight = window.innerHeight;
                const revealTop = el.getBoundingClientRect().top;
                const revealPoint = 120;

                if (revealTop < windowHeight - revealPoint) {
                    el.classList.add("active");
                }
            });
        });
    </script>

</body>
</html>
