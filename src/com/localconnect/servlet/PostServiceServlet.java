package com.localconnect.servlet;

import com.localconnect.dto.ServiceDto;
import com.localconnect.dto.UserDto;
import com.localconnect.repository.ServiceRepository;
import com.localconnect.repository.ServiceRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/post-service")
public class PostServiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String serviceName = req.getParameter("serviceName");
        String location = req.getParameter("location");
        String contact = req.getParameter("contact");
        String description = req.getParameter("description");

        HttpSession session = req.getSession(false);
        UserDto user = (UserDto) session.getAttribute("user");

        ServiceDto dto = new ServiceDto(serviceName, location, contact, description, user.getEmail() , user.getId());
        dto.setStatus("active");
        try {
            ServiceRepository repo = new ServiceRepositoryImpl();
            boolean success = repo.save(dto);

            // ✅ Set message in session instead of request
            session.setAttribute("postMessage", success ? "✅ Service posted successfully!" : "❌ Error occurred while posting.");
        } catch (Exception e) {
            session.setAttribute("postMessage", "❌ Something went wrong: " + e.getMessage());
        }

        resp.sendRedirect("provider-dashboard.jsp");
    }
}
