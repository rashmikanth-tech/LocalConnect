package com.localconnect.servlet;

import com.localconnect.repository.ServiceRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-service")
public class DeleteServiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            ServiceRepositoryImpl repo = new ServiceRepositoryImpl();
            repo.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect("provider-dashboard.jsp");
    }
}

