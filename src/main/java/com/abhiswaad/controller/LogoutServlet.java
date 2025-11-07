package com.abhiswaad.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException
    {
        HttpSession session = req.getSession(false);
        if (session != null)
            session.invalidate();  // clear session

        resp.sendRedirect("adminLogin.jsp"); // redirect to login page
    }
}
