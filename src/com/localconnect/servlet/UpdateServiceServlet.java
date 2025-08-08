package com.localconnect.servlet;

import com.localconnect.dto.ServiceDto;
import com.localconnect.repository.ServiceRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-service")
public class UpdateServiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("serviceName");
        String location = req.getParameter("location");
        String contact = req.getParameter("contact");
        String description = req.getParameter("description");

        ServiceDto dto = new ServiceDto();
        dto.setId(id);
        dto.setServiceName(name);
        dto.setLocation(location);
        dto.setContact(contact);
        dto.setDescription(description);

        try {
            ServiceRepositoryImpl repo = new ServiceRepositoryImpl();
            boolean updated = repo.update(dto); // ✅ use return value

            HttpSession session = req.getSession();

            if (updated) {
                session.setAttribute("updateMessage", "✅ Service updated successfully!");
                resp.sendRedirect("provider-dashboard.jsp");
            } else {
                req.setAttribute("message", "❌ Update failed. Invalid service ID?");
                req.setAttribute("dto", dto);
                req.getRequestDispatcher("edit-service.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Update failed due to error.");
            req.setAttribute("dto", dto);
            req.getRequestDispatcher("edit-service.jsp").forward(req, resp);
        }
    }
}
