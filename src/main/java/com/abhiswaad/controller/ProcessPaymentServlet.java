package com.abhiswaad.controller;

import com.abhiswaad.util.PaymentGateway;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

//@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.setContentType("text/html");

        String username = request.getParameter("username");
        String restaurant = request.getParameter("restaurant");
        String method = request.getParameter("method");
        double amount = Double.parseDouble(request.getParameter("amount"));

        PaymentGateway payment = new PaymentGateway();
        String result = payment.processPayment(username, restaurant, method, amount);

        // ✅ Store result to display on JSP
        request.setAttribute("result", result);

        // ✅ Forward result to JSP page
        RequestDispatcher rd = request.getRequestDispatcher("paymentResult.jsp");
        rd.forward(request, response);
    }
}
