<%@ page import="org.bson.Document, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Restaurants | AbhiSwaad</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        /* --- Global Setup --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #fff8f5, #ffe0b2, #ffccbc, #ffd180);
            background-size: 400% 400%;
            animation: gradientShift 12s ease infinite;
            color: #4e342e;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            overflow-x: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            flex-grow: 1;
        }

        /* --- Navbar --- */
        .navbar {
            position: sticky;
            top: 0;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
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
            transition: 0.3s ease;
        }

        .logo i {
            margin-right: 8px;
            animation: rotateUtensil 3s linear infinite;
        }

        @keyframes rotateUtensil {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .logo:hover {
            transform: scale(1.1);
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

        /* --- Page Title --- */
        h1 {
            text-align: center;
            color: #e64a19;
            margin-bottom: 25px;
            font-size: 38px;
            animation: fadeInUp 1s ease-out;
        }

        /* --- Search Bar --- */
        .search-container {
            position: relative;
            max-width: 700px;
            margin: 0 auto 40px auto;
            animation: fadeInUp 1.2s ease-out;
        }

        .search-container i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #bbb;
            font-size: 18px;
        }

        #search {
            width: 100%;
            padding: 15px 20px 15px 50px;
            font-size: 18px;
            border-radius: 50px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: all 0.4s ease;
        }

        #search:focus {
            outline: none;
            border-color: #ff7043;
            box-shadow: 0 0 10px rgba(255, 112, 67, 0.3);
            transform: scale(1.02);
        }

        /* --- Restaurant Grid --- */
        .restaurant-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            animation: fadeIn 1s ease-out;
        }

        /* --- Restaurant Card --- */
        .restaurant-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: 0.4s ease;
            display: flex;
            flex-direction: column;
            opacity: 0;
            transform: translateY(30px);
        }

        .restaurant-card.active {
            opacity: 1;
            transform: translateY(0);
        }

        .restaurant-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 10px 30px rgba(255, 112, 67, 0.25);
        }

        /* === MODIFIED CSS === */
        /* This now acts as a container for the image or the icon */
        .card-image {
            height: 180px;
            background: linear-gradient(135deg, #ffe0b2, #ffccbc);
            overflow: hidden; /* Ensures image doesn't break layout */
        }

        /* This is the new image tag */
        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* This makes the image cover the area */
            transition: transform 0.4s ease;
        }

        /* This is the placeholder icon for restaurants without a specific image */
        .card-image .placeholder-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
            color: #ff7043;
            font-size: 50px;
            transition: transform 0.4s ease;
        }

        /* Apply hover zoom to both the image and the icon */
        .restaurant-card:hover .card-image img,
        .restaurant-card:hover .card-image .placeholder-icon {
            transform: scale(1.05);
        }
        /* === END OF MODIFIED CSS === */


        .card-body {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .card-body h2 {
            margin: 0 0 8px 0;
            color: #5d4037;
            font-size: 22px;
        }

        .card-body .address {
            color: #757575;
            font-size: 15px;
            margin-bottom: 12px;
        }

        .card-tags {
            margin-bottom: 15px;
        }

        .tag {
            display: inline-block;
            background: #fbe9e7;
            color: #e64a19;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-right: 6px;
            transition: 0.3s ease;
        }

        .tag:hover {
            background: #ffccbc;
        }

        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
        }

        .rating {
            color: #ffb300;
            font-weight: 700;
            font-size: 16px;
        }

        .rating i {
            margin-right: 4px;
        }

        .btn {
            padding: 10px 20px;
            background: #ff7043;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.4s ease;
            animation: pulseGlow 2.5s infinite;
        }

        .btn:hover {
            background: #e64a19;
            transform: scale(1.1);
            box-shadow: 0 0 20px rgba(255, 112, 67, 0.5);
        }

        @keyframes pulseGlow {
            0% { box-shadow: 0 0 0 rgba(255,112,67,0.4); }
            50% { box-shadow: 0 0 20px rgba(255,112,67,0.4); }
            100% { box-shadow: 0 0 0 rgba(255,112,67,0.4); }
        }

        /* --- No Results --- */
        #no-results {
            text-align: center;
            padding: 40px;
            font-size: 20px;
            color: #757575;
            display: none;
            animation: fadeInUp 1s ease-out;
        }

        #no-results i {
            display: block;
            font-size: 48px;
            margin-bottom: 15px;
            color: #bdbdbd;
        }

        /* --- Footer --- */
        footer {
            text-align: center;
            padding: 25px 0;
            background-color: #efebe9;
            color: #6d4c41;
            font-size: 14px;
            margin-top: 40px;
            animation: fadeIn 2s ease-in-out;
        }

        /* --- Keyframes --- */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>

    <script>
        // --- Search Functionality (Unchanged) ---
        function searchRestaurants() {
            let input = document.getElementById("search").value.toLowerCase();
            let restaurants = document.getElementsByClassName("restaurant-card");
            let noResultsMsg = document.getElementById("no-results");
            let visibleCount = 0;

            for (let i = 0; i < restaurants.length; i++) {
                let name = restaurants[i].getElementsByTagName("h2")[0].innerText.toLowerCase();
                let address = restaurants[i].getElementsByClassName("address")[0].innerText.toLowerCase();

                if (name.includes(input) || address.includes(input)) {
                    restaurants[i].style.display = "flex";
                    visibleCount++;
                } else {
                    restaurants[i].style.display = "none";
                }
            }
            noResultsMsg.style.display = visibleCount === 0 ? "block" : "none";
        }

        // --- Scroll Reveal Animation (Unchanged) ---
        window.addEventListener("scroll", () => {
            document.querySelectorAll(".restaurant-card").forEach((card) => {
                const rect = card.getBoundingClientRect();
                if (rect.top < window.innerHeight - 100) {
                    card.classList.add("active");
                }
            });
        });
    </script>
</head>
<body>

    <div class="floating-food">
        <i class="fa-solid fa-pizza-slice" style="left: 15%; animation-delay: 0s;"></i>
        <i class="fa-solid fa-burger" style="left: 45%; animation-delay: 4s;"></i>
        <i class="fa-solid fa-ice-cream" style="left: 70%; animation-delay: 8s;"></i>
        <i class="fa-solid fa-mug-hot" style="left: 85%; animation-delay: 12s;"></i>
    </div>

    <header class="navbar">
        <div class="container">
            <a href="index.jsp" class="logo">
                <i class="fa-solid fa-utensils"></i> AbhiSwaad
            </a>
        </div>
    </header>

    <div class="container">
        <h1>🍴 Choose Your Restaurant</h1>

        <div class="search-container">
            <i class="fa-solid fa-search"></i>
            <input type="text" id="search" placeholder="Search by restaurant name or address..." onkeyup="searchRestaurants()">
        </div>

        <div class="restaurant-grid" id="restaurant-list">
            <%
                List<Document> restaurants = (List<Document>) request.getAttribute("restaurants");
                if (restaurants != null) {
                    for (Document r : restaurants) {
                        String name = r.getString("name");
                        String address = r.getString("address");
                        double rating = r.getDouble("rating");

                        // === NEW JAVA LOGIC TO GET IMAGE URL ===
                        String imageUrl = null; // Default to null (will show placeholder)

                        if (name.equalsIgnoreCase("Tandoori Tales")) {
                            imageUrl = "https://i.postimg.cc/j5LRzJrc/Gemini-Generated-Image-4k4mq54k4mq54k4m.png"; // <-- REPLACE THIS LINK
                        } else if (name.equalsIgnoreCase("Chowman")) {
                            imageUrl = "https://i.postimg.cc/LXw2v6H1/Gemini-Generated-Image-kzulackzulackzul.png"; // <-- REPLACE THIS LINK
                        } else if (name.equalsIgnoreCase("Pizza Hut")) {
                            imageUrl = "https://i.postimg.cc/V6dzjbcR/Gemini-Generated-Image-45txaf45txaf45tx.png"; // <-- REPLACE THIS LINK
                        } else if (name.equalsIgnoreCase("Mocambo")) {
                            imageUrl = "https://i.postimg.cc/0Qb9pJqZ/Gemini-Generated-Image-lmji0flmji0flmji.png"; // <-- REPLACE THIS LINK
                        } else if (name.equalsIgnoreCase("Bhojohori Manna")) {
                            imageUrl = "https://i.postimg.cc/TwpTrWXp/Gemini-Generated-Image-fymyfpfymyfpfymy.png"; // <-- REPLACE THIS LINK
                        }
                        // === END OF NEW JAVA LOGIC ===
            %>

            <div class="restaurant-card">

                <div class="card-image">
                    <% if (imageUrl != null) { %>
                        <img src="<%= imageUrl %>" alt="<%= name %> restaurant">
                    <% } else { %>
                        <div class="placeholder-icon">
                            <i class="fa-solid fa-utensils"></i>
                        </div>
                    <% } %>
                </div>
                <div class="card-body">
                    <h2><%= name %></h2>
                    <p class="address"><%= address %></p>

                    <div class="card-tags">
                        <span class="tag">Kolkata</span>
                        <span class="tag">Indian</span>
                        <span class="tag">⭐ Popular</span>
                    </div>

                    <div class="card-footer">
                        <span class="rating"><i class="fa-solid fa-star"></i> <%= String.format("%.1f", rating) %>/5</span>
                        <a href="menu.jsp?restaurant=<%= name %>" class="btn">Explore Menu</a>
                    </div>
                </div>
            </div>

            <% } } %>
        </div>

        <div id="no-results">
            <i class="fa-solid fa-face-sad-tear"></i>
            <strong>No restaurants found</strong>
            <p>Try searching for something else.</p>
        </div>
    </div>

    <footer>
        <p>© 2025 AbhiSwaad — Made with ❤ by Abhik Mukherjee</p>
    </footer>
</body>
</html>