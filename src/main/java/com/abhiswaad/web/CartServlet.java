package com.abhiswaad.web;

import com.abhiswaad.model.Order.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles adding items to session cart and showing the cart.
 *
 * GET  -> show cart (forward to /WEB-INF/jsp/cart.jsp)
 * POST -> add item to cart parameters: restId, restName, name, price
 */
@WebServlet("/cart")
public class CartServlet extends jakarta.servlet.http.HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        @SuppressWarnings("unchecked")
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
        if (cart == null) { cart = new ArrayList<>(); }

        String restId = req.getParameter("restId");
        String restName = req.getParameter("restName");
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int qty = 1;
        String qtyStr = req.getParameter("qty");
        if (qtyStr != null && !qtyStr.isEmpty()) {
            try { qty = Integer.parseInt(qtyStr); } catch (NumberFormatException ignored) {}
        }

        // add item
        OrderItem item = new OrderItem();
        item.setName(name);
        item.setPrice(price);
        item.setQuantity(qty);
        cart.add(item);

        // store restaurant info for checkout convenience
        session.setAttribute("cart", cart);
        session.setAttribute("cartRestId", restId);
        session.setAttribute("cartRestName", restName);

        // redirect back to restaurants page or cart
        String action = req.getParameter("action");
        if ("checkout".equals(action)) {
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else {
            // return to restaurants page
            resp.sendRedirect(req.getContextPath() + "/restaurants");
        }
    }
}
