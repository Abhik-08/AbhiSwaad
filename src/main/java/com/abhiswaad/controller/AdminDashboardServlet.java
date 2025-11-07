package com.abhiswaad.controller;

import com.abhiswaad.dao.OrderDao;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet
{
    private final OrderDao dao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        HttpSession session = req.getSession(false);
        Boolean isAdmin = (session != null) ? (Boolean) session.getAttribute("isAdmin") : false;

        if (isAdmin == null || !isAdmin)
        {
            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        List<Document> orders = dao.getAllOrders();
        req.setAttribute("ordersList", orders);
        req.getRequestDispatcher("/adminDashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        HttpSession session = req.getSession(false);
        Boolean isAdmin = (session != null) ? (Boolean) session.getAttribute("isAdmin") : false;

        if (isAdmin == null || !isAdmin)
        {
            resp.sendRedirect("adminLogin.jsp");
            return;
        }

        String orderId = req.getParameter("orderId");
        String newStatus = req.getParameter("newStatus");

        if (orderId != null && newStatus != null)
        {
            dao.updateOrderStatusById(orderId, newStatus);
        }

        resp.sendRedirect("adminDashboard");
    }
}
