package com.abhiswaad.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet
{
    private final String ADMIN_USERNAME = "admin";
    private final String ADMIN_PASSWORD = "abhi123"; // you can change this

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password))
        {
            HttpSession session = request.getSession();
            session.setAttribute("isAdmin", true);
            response.sendRedirect("adminDashboard");
        }
        else
        {
            request.setAttribute("error", "❌ Invalid username or password!");
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
    }
}
