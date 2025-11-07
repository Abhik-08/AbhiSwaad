package com.abhiswaad.web; // <-- change to com.abhiswaad.controller if that's where your other servlets live

import com.abhiswaad.dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * PlaceOrderServlet
 * Accepts form POST with:
 *  - restaurant (String)
 *  - couponCode (String, optional)
 *  - item_<itemName> = <quantity>  (for example: item_Pizza=2, item_Burger=1)
 *
 * Calls OrderDao.placeOrder(username, restaurant, itemsMap, couponCode)
 * and forwards the user to payment.jsp (or results page) with a message.
 */
@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");

        // 1) Get username (from session or request)
        HttpSession session = request.getSession(false);
        String username = null;
        if (session != null && session.getAttribute("username") != null)
        {
            username = (String) session.getAttribute("username");
        }
        // fallback: try request param
        if (username == null)
        {
            username = request.getParameter("username");
        }
        if (username == null || username.trim().isEmpty())
        {
            // If no username available, redirect to login or show error
            request.setAttribute("error", "You must be logged in to place an order.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 2) Read restaurant and couponCode
        String restaurant = request.getParameter("restaurant");
        String couponCode = request.getParameter("couponCode");

        if (restaurant == null || restaurant.trim().isEmpty())
        {
            request.setAttribute("error", "Please select a restaurant.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // 3) Parse items from request parameters.
        //    We expect parameters named like "item_Pizza" -> quantity
        Map<String, Integer> items = new HashMap<>();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements())
        {
            String param = paramNames.nextElement();
            if (param.startsWith("item_"))
            {
                String itemName = param.substring("item_".length());
                String qtyStr = request.getParameter(param);
                try
                {
                    int qty = Integer.parseInt(qtyStr);
                    if (qty > 0)
                    {
                        items.put(itemName, qty);
                    }
                }
                catch (NumberFormatException ignored)
                {
                    // treat as zero / ignore invalid
                }
            }
        }

        if (items.isEmpty())
        {
            request.setAttribute("error", "No items selected. Please add items to your cart.");
            request.getRequestDispatcher("/menu.jsp?restaurant=" + restaurant).forward(request, response);
            return;
        }

        // 4) Call DAO to place order
        try
        {
            String confirmation = orderDao.placeOrder(username, restaurant, items, couponCode);

            // Save confirmation message in session (or request) to show on payment page
            session = request.getSession(true);
            session.setAttribute("orderConfirmation", confirmation);

            // Also store last order payable amount or order id if you returned one (not implemented here)
            // Redirect / forward to payment page
            response.sendRedirect(request.getContextPath() + "/payment.jsp");
        }
        catch (Exception ex)
        {
            // log server side (use logger in real app)
            ex.printStackTrace();

            request.setAttribute("error", "Failed to place order: " + ex.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    // Optionally allow GET to show a form/redirect
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
