package com.abhiswaad.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/generateBill")
public class BillGeneratorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");

        String restaurantName = request.getParameter("restaurant");
        String totalAmount = request.getParameter("total");  // this is the *final* amount (after discount)

        // Optional: Retrieve coupon details if present
        String couponCode = request.getParameter("couponCode");
        String discountPercent = request.getParameter("discountPercent");
        String discountAmount = request.getParameter("discountAmount");

        Map<String, String[]> params = request.getParameterMap();
        String home = System.getProperty("user.home");
        String filePath = home + "/Downloads/AbhiSwaad_Bill.pdf";

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(filePath));
            document.open();

            // 🧾 Title
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD, BaseColor.ORANGE);
            Paragraph title = new Paragraph("AbhiSwaad Food Bill\n\n", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            // 🍴 Restaurant name
            Font subFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
            document.add(new Paragraph("Restaurant: " + restaurantName, subFont));

            // 📅 Date
            String date = new SimpleDateFormat("dd-MM-yyyy HH:mm").format(new Date());
            document.add(new Paragraph("Date: " + date + "\n\n"));

            // 🍽️ Table for ordered items
            PdfPTable table = new PdfPTable(3);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);
            table.addCell("Dish");
            table.addCell("Quantity");
            table.addCell("Subtotal (₹)");

            for (String key : params.keySet()) {
                if (key.startsWith("dish_")) {
                    String dishName = key.substring(5);
                    String qty = request.getParameter("qty_" + dishName);
                    String subtotal = request.getParameter("sub_" + dishName);
                    if (qty != null && !qty.equals("0")) {
                        table.addCell(dishName);
                        table.addCell(qty);
                        table.addCell(subtotal);
                    }
                }
            }

            document.add(table);

            // 💸 Summary section
            document.add(new Paragraph("\n", new Font(Font.FontFamily.HELVETICA, 12)));

            // If coupon applied, show discount breakdown
            if (couponCode != null && !couponCode.trim().isEmpty()) {
                Font discountFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, new BaseColor(0, 128, 0));
                Paragraph discountInfo = new Paragraph(
                        "Coupon Applied: " + couponCode.toUpperCase() +
                                "  (" + (discountPercent != null ? discountPercent : "0") + "% OFF)",
                        discountFont
                );
                discountInfo.setAlignment(Element.ALIGN_RIGHT);
                document.add(discountInfo);

                if (discountAmount != null) {
                    Paragraph discountValue = new Paragraph("Discount Amount: ₹" + discountAmount, discountFont);
                    discountValue.setAlignment(Element.ALIGN_RIGHT);
                    document.add(discountValue);
                }
            }

            // Final total
            Font totalFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, BaseColor.RED);
            Paragraph total = new Paragraph("\nTotal Payable: ₹" + totalAmount, totalFont);
            total.setAlignment(Element.ALIGN_RIGHT);
            document.add(total);

            // ✅ Footer note
            Paragraph thank = new Paragraph(
                    "\nThank you for ordering from AbhiSwaad!\nWe hope you enjoy your meal 🍲",
                    new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC)
            );
            thank.setAlignment(Element.ALIGN_CENTER);
            document.add(thank);

            document.close();

            response.getWriter().write("✅ Bill generated successfully! Check your Downloads folder.");
            System.out.println("Bill saved at: " + filePath);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("❌ Failed to generate bill: " + e.getMessage());
        }
    }
}
