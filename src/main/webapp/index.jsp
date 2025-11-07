<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>AbhiSwaad | Taste. Delivered.</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Fonts + Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Tailwind Theme -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        poppins: ['Poppins', 'sans-serif']
                    },
                    colors: {
                        brand: {
                            orange: '#ff7043',
                            light: '#ffe0b2',
                            dark: '#d84315'
                        }
                    },
                    animation: {
                        gradientShift: 'gradientShift 16s ease infinite',
                        shimmer: 'shimmer 8s linear infinite',
                        pulseGlow: 'pulseGlow 3s ease-in-out infinite',
                        floatFood: 'floatFood 18s linear infinite',
                        floatUpDown: 'floatUpDown 4s ease-in-out infinite'
                    },
                    keyframes: {
                        gradientShift: {
                            '0%, 100%': { backgroundPosition: '0% 50%' },
                            '50%': { backgroundPosition: '100% 50%' }
                        },
                        shimmer: {
                            '0%': { backgroundPosition: '-200% 0' },
                            '100%': { backgroundPosition: '200% 0' }
                        },
                        pulseGlow: {
                            '0%': { boxShadow: '0 0 0 rgba(255,112,67,0.5)' },
                            '50%': { boxShadow: '0 0 25px rgba(255,112,67,0.6)' },
                            '100%': { boxShadow: '0 0 0 rgba(255,112,67,0.5)' }
                        },
                        floatFood: {
                            '0%': { transform: 'translateY(100vh) rotate(0deg)', opacity: '0' },
                            '50%': { opacity: '1' },
                            '100%': { transform: 'translateY(-10vh) rotate(360deg)', opacity: '0' }
                        },
                        floatUpDown: {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-10px)' }
                        }
                    }
                }
            }
        };
    </script>

    <style>
        /* Background Gradient Animation */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(-45deg, #ffccbc, #ffe0b2, #ffd180, #ffab91);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            overflow-x: hidden;
            color: #4e342e;
        }
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Floating Food Emojis */
        .floating-food i {
            position: absolute;
            color: rgba(255, 112, 67, 0.12);
            font-size: 30px;
            animation: floatFood 18s linear infinite;
        }
        @keyframes floatFood {
            0% { transform: translateY(100vh) rotate(0deg); opacity: 0; }
            50% { opacity: 1; }
            100% { transform: translateY(-10vh) rotate(360deg); opacity: 0; }
        }

        /* Food Particles */
        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            animation: floatParticle 12s linear infinite;
        }
        @keyframes floatParticle {
            0% { transform: translateY(100vh) scale(0.5); opacity: 0.3; }
            50% { opacity: 0.8; }
            100% { transform: translateY(-10vh) scale(1.2); opacity: 0; }
        }

        /* Shimmer Stripes Overlay */
        .stripe {
            position: absolute;
            top: 0; left: -150%;
            width: 200%;
            height: 100%;
            background: linear-gradient(120deg, transparent, rgba(255,255,255,0.3), transparent);
            animation: shimmer 10s linear infinite;
            pointer-events: none;
        }
        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        /* Navbar Shrink */
        .navbar {
            transition: all 0.4s ease-in-out;
        }
        .navbar.scrolled {
            background-color: rgba(255,255,255,0.95);
            padding: 0.5rem 0;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        /* Typewriter Effect */
        .typewriter {
            overflow: hidden;
            border-right: .15em solid #ff7043;
            white-space: nowrap;
            animation: typing 4s steps(25, end) infinite alternate, blink 0.7s step-end infinite;
        }
        @keyframes typing {
            from { width: 0 }
            to { width: 100% }
        }
        @keyframes blink {
            50% { border-color: transparent }
        }

        /* Scroll Reveal Animation */
        .reveal {
            opacity: 0;
            transform: translateY(40px);
            transition: all 0.8s ease;
        }
        .reveal.active {
            opacity: 1;
            transform: translateY(0);
        }

        /* Neon Glow Footer */
        .footer-glow {
            box-shadow: 0 0 30px rgba(255,112,67,0.3) inset;
            animation: footerGlow 6s ease-in-out infinite alternate;
        }
        @keyframes footerGlow {
            0% { box-shadow: 0 0 10px rgba(255,112,67,0.2) inset; }
            100% { box-shadow: 0 0 40px rgba(255,112,67,0.5) inset; }
        }

        /* Hover Waves */
        .wave-hover:hover {
            background: linear-gradient(120deg, #ffab91, #ffe0b2);
            transition: background 0.8s ease;
        }
    </style>
</head>

<body class="relative overflow-hidden">

    <!-- Animated Background Elements -->
    <div class="floating-food fixed inset-0 pointer-events-none -z-10 overflow-hidden">
        <i class="fa-solid fa-pizza-slice" style="left: 10%; animation-delay: 0s;"></i>
        <i class="fa-solid fa-burger" style="left: 40%; animation-delay: 3s;"></i>
        <i class="fa-solid fa-ice-cream" style="left: 70%; animation-delay: 6s;"></i>
        <i class="fa-solid fa-fish" style="left: 90%; animation-delay: 9s;"></i>
        <i class="fa-solid fa-mug-hot" style="left: 25%; animation-delay: 12s;"></i>
    </div>

    <!-- Food Particles -->
    <div class="absolute inset-0 -z-20 overflow-hidden">
        <% for(int i=0;i<35;i++){ %>
            <div class="particle" style="
                left:<%= (int)(Math.random()*100) %>%;
                width:<%= (int)(Math.random()*10+5) %>px;
                height:<%= (int)(Math.random()*10+5) %>px;
                animation-delay:<%= (int)(Math.random()*10) %>s;">
            </div>
        <% } %>
    </div>

    <!-- Shimmering Background Stripes -->
    <div class="stripe"></div>

    <!-- Navbar -->
    <header class="navbar fixed w-full bg-white/60 backdrop-blur-lg z-50 transition-all">
        <div class="max-w-7xl mx-auto flex justify-between items-center px-6 py-4">
            <a href="#" class="text-3xl font-bold text-brand-orange flex items-center hover:scale-105 transition-transform">
                <i class="fa-solid fa-utensils mr-2 animate-spin-slow"></i> AbhiSwaad
            </a>
            <nav class="hidden md:flex gap-8 text-sm font-semibold text-[#5d4037]">
                <a href="#features" class="hover:text-brand-dark transition-colors">Features</a>
                <a href="restaurants" class="hover:text-brand-dark transition-colors">Restaurants</a>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <main class="min-h-screen flex flex-col justify-center items-center text-center px-6 relative">
        <div class="bg-white/80 backdrop-blur-lg p-10 rounded-3xl shadow-2xl max-w-3xl transform hover:scale-[1.03] transition-all">
            <div class="text-7xl mb-6 animate-[floatUpDown_3s_ease-in-out_infinite]">🍲</div>
            <h1 class="text-5xl font-bold text-[#3e2723] mb-4 typewriter">Welcome to <span class="text-brand-orange">AbhiSwaad</span></h1>
            <p class="text-lg text-[#5d4037] mb-6 leading-relaxed">
                Your one-stop destination for delicious food from top Kolkata restaurants.<br>
                Explore, order, and enjoy authentic flavors delivered to your doorstep!
            </p>
            <a href="restaurants"
               class="bg-brand-orange text-white px-10 py-3 rounded-xl text-lg font-semibold hover:bg-brand-dark hover:scale-110 transition-all animate-pulseGlow shadow-lg">
               Start Ordering Now 🍕
            </a>
        </div>
    </main>

    <!-- Divider with Floating Text -->
    <section class="h-[200px] bg-gradient-to-r from-brand-orange/20 to-white/0 flex items-center justify-center">
        <p class="text-2xl text-brand-dark font-semibold animate-pulse">Fast • Fresh • Flavorful</p>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-24 bg-white relative overflow-hidden">
        <div class="max-w-7xl mx-auto px-6 grid md:grid-cols-3 gap-12">
            <div class="reveal bg-white rounded-3xl shadow-xl p-10 text-center hover:-translate-y-2 hover:shadow-orange-200/70 transition-all wave-hover">
                <i class="fa-solid fa-rocket text-5xl text-brand-orange mb-4"></i>
                <h3 class="text-xl font-semibold mb-2">Fast Delivery</h3>
                <p class="text-gray-600">Get your favorite meals delivered hot and fresh, right on time.</p>
            </div>
            <div class="reveal bg-white rounded-3xl shadow-xl p-10 text-center hover:-translate-y-2 hover:shadow-orange-200/70 transition-all wave-hover">
                <i class="fa-solid fa-star text-5xl text-brand-orange mb-4"></i>
                <h3 class="text-xl font-semibold mb-2">Top Restaurants</h3>
                <p class="text-gray-600">Handpicked selection of the best and most-loved local eateries.</p>
            </div>
            <div class="reveal bg-white rounded-3xl shadow-xl p-10 text-center hover:-translate-y-2 hover:shadow-orange-200/70 transition-all wave-hover">
                <i class="fa-solid fa-credit-card text-5xl text-brand-orange mb-4"></i>
                <h3 class="text-xl font-semibold mb-2">Secure Payments</h3>
                <p class="text-gray-600">Easy, fast, and secure payment options for a smooth checkout.</p>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-24 bg-brand-orange text-white text-center relative overflow-hidden">
        <div class="absolute inset-0 opacity-30 bg-[radial-gradient(circle_at_center,_rgba(255,255,255,0.2)_0%,_transparent_70%)] animate-pulse"></div>
        <div class="relative z-10">
            <h2 class="text-4xl font-bold mb-4">Hungry? Let’s Fix That!</h2>
            <p class="mb-6 text-lg">Thousands trust <b>AbhiSwaad</b> for food that satisfies every craving.</p>
            <a href="restaurants" class="bg-white text-brand-dark px-8 py-3 rounded-xl font-semibold hover:scale-110 transition-all shadow-lg">Order Now 🚀</a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="text-center py-8 bg-[#fbe9e7] text-[#6d4c41] footer-glow border-t border-brand-light">
        <p class="text-sm">© 2025 <span class="font-bold text-brand-orange">AbhiSwaad</span> — Made with ❤️ by <b>Abhik Mukherjee</b></p>
        <div class="flex justify-center gap-6 mt-3 text-lg">
            <a href="#" class="hover:text-brand-dark"><i class="fab fa-facebook"></i></a>
            <a href="#" class="hover:text-brand-dark"><i class="fab fa-instagram"></i></a>
            <a href="#" class="hover:text-brand-dark"><i class="fab fa-twitter"></i></a>
        </div>
    </footer>

    <!-- Scroll Reveal + Navbar -->
    <script>
        const navbar = document.querySelector(".navbar");
        const reveals = document.querySelectorAll(".reveal");

        window.addEventListener("scroll", () => {
            if (window.scrollY > 50) navbar.classList.add("scrolled");
            else navbar.classList.remove("scrolled");

            reveals.forEach((el) => {
                const windowHeight = window.innerHeight;
                const revealTop = el.getBoundingClientRect().top;
                if (revealTop < windowHeight - 120) el.classList.add("active");
            });
        });
    </script>
</body>
</html>
