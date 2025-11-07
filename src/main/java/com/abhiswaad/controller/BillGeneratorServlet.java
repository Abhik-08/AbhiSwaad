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

        // ✅ Fetch core details
        String restaurantName = request.getParameter("restaurant");
        String totalAmount = request.getParameter("total"); // Final amount after discount
        String couponCode = request.getParameter("couponCode");
        String discountPercent = request.getParameter("discountPercent");
        String discountAmount = request.getParameter("discountAmount");

        Map<String, String[]> params = request.getParameterMap();
        String home = System.getProperty("user.home");
        String filePath = home + "/Downloads/AbhiSwaad_Bill.pdf";

        try {
            // Create PDF
            Document document = new Document(PageSize.A4, 40, 40, 50, 50);
            PdfWriter.getInstance(document, new FileOutputStream(filePath));
            document.open();

            // 🧡 Header (Brand)
            Font brandFont = new Font(Font.FontFamily.HELVETICA, 26, Font.BOLD, new BaseColor(255, 112, 67));
            Paragraph brand = new Paragraph("AbhiSwaad\n", brandFont);
            brand.setAlignment(Element.ALIGN_CENTER);
            document.add(brand);

            Font subFont = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.DARK_GRAY);
            Paragraph tagline = new Paragraph("Taste the Tradition of Kolkata 🍴", subFont);
            tagline.setAlignment(Element.ALIGN_CENTER);
            document.add(tagline);

            document.add(new Paragraph("\n----------------------------------------\n"));

            // 📅 Order Details
            String date = new SimpleDateFormat("dd MMM yyyy, HH:mm a").format(new Date());
            Font infoFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            document.add(new Paragraph("Restaurant: " + restaurantName, infoFont));
            document.add(new Paragraph("Date: " + date, infoFont));
            document.add(new Paragraph("\n"));

            // 🍽️ Ordered Items Table
            PdfPTable table = new PdfPTable(new float[]{3, 1, 2});
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);

            Font headFont = new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, BaseColor.WHITE);
            PdfPCell c1;

            c1 = new PdfPCell(new Phrase("Dish", headFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setBackgroundColor(new BaseColor(255, 112, 67));
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase("Qty", headFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setBackgroundColor(new BaseColor(255, 112, 67));
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase("Subtotal (₹)", headFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setBackgroundColor(new BaseColor(255, 112, 67));
            table.addCell(c1);

            table.setHeaderRows(1);

            Font tableFont = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL);

            for (String key : params.keySet()) {
                if (key.startsWith("dish_")) {
                    String dishName = key.substring(5);
                    String qty = request.getParameter("qty_" + dishName);
                    String subtotal = request.getParameter("sub_" + dishName);
                    if (qty != null && !qty.equals("0")) {
                        table.addCell(new Phrase(dishName, tableFont));
                        table.addCell(new Phrase(qty, tableFont));
                        table.addCell(new Phrase("₹" + subtotal, tableFont));
                    }
                }
            }

            document.add(table);
            document.add(new Paragraph("\n"));

            // 💸 Summary Section
            Font summaryFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
            PdfPTable summary = new PdfPTable(2);
            summary.setWidthPercentage(50);
            summary.setHorizontalAlignment(Element.ALIGN_RIGHT);

            // Subtotal (Before discount)
            double subtotalCalc = 0;
            for (String key : params.keySet()) {
                if (key.startsWith("sub_")) {
                    subtotalCalc += Double.parseDouble(request.getParameter(key));
                }
            }

            summary.addCell(new Phrase("Subtotal:", summaryFont));
            summary.addCell(new Phrase("₹" + String.format("%.2f", subtotalCalc), summaryFont));

            // If coupon applied
            if (couponCode != null && !couponCode.trim().isEmpty() &&
                    discountPercent != null && Double.parseDouble(discountPercent) > 0) {
                Font greenFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, new BaseColor(0, 128, 0));
                summary.addCell(new Phrase("Coupon (" + couponCode + "):", greenFont));
                summary.addCell(new Phrase("-₹" + discountAmount + " (" + discountPercent + "% OFF)", greenFont));
            }

            // Final Total
            Font redFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, BaseColor.RED);
            summary.addCell(new Phrase("Total Payable:", redFont));
            summary.addCell(new Phrase("₹" + totalAmount, redFont));

            document.add(summary);

            // 💬 Footer
            document.add(new Paragraph("\n"));
            Paragraph thank = new Paragraph(
                    "Thank you for ordering from AbhiSwaad!\nWe hope to serve you again soon 💛",
                    new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC, BaseColor.GRAY)
            );
            thank.setAlignment(Element.ALIGN_CENTER);
            document.add(thank);

            document.add(new Paragraph("\n"));
            Paragraph copyright = new Paragraph(
                    "© 2025 AbhiSwaad — Made with ❤ by Abhik Mukherjee",
                    new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.LIGHT_GRAY)
            );
            copyright.setAlignment(Element.ALIGN_CENTER);
            document.add(copyright);

            document.close();

            response.getWriter().write("✅ Bill generated successfully! Check your Downloads folder.");
            System.out.println("📄 Bill saved at: " + filePath);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("❌ Failed to generate bill: " + e.getMessage());
        }
    }
}
