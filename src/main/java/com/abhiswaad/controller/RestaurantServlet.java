package com.abhiswaad.controller;

import com.mongodb.client.*;
import org.bson.Document;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        List<Document> restaurants = new ArrayList<>();

        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017"))
        {
            MongoDatabase database = mongoClient.getDatabase("AbhiSwaadDB");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            for (Document doc : collection.find())
            {
                restaurants.add(doc);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        request.setAttribute("restaurants", restaurants);
        RequestDispatcher rd = request.getRequestDispatcher("restaurants.jsp");
        rd.forward(request, response);
    }
}
