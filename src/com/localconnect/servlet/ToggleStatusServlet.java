package com.localconnect.servlet;

import com.localconnect.repository.ServiceRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/toggle-status")
public class ToggleStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int serviceId = Integer.parseInt(req.getParameter("id"));

        try {
            ServiceRepositoryImpl repo = new ServiceRepositoryImpl();
            String currentStatus = repo.getStatusById(serviceId);

            // Toggle the status
            String newStatus = "active".equalsIgnoreCase(currentStatus) ? "inactive" : "active";
            repo.updateStatus(serviceId, newStatus);

            resp.sendRedirect("provider-dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("provider-dashboard.jsp?error=toggle_failed");
        }
    }
}
