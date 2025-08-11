package com.localconnect.servlet;

import com.localconnect.dto.ServiceDto;
import com.localconnect.repository.ServiceRepositoryImpl;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/search-services")
public class ServiceSearchServlet extends HttpServlet {

    private ServiceRepositoryImpl serviceRepo;

    @Override
    public void init() throws ServletException {
        serviceRepo = new ServiceRepositoryImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("q");
        if (keyword == null || keyword.trim().isEmpty()) {
            resp.setContentType("application/json");
            resp.getWriter().write("[]");
            return;
        }

        List<ServiceDto> results = serviceRepo.searchByKeyword(keyword.trim());

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        resp.getWriter().write(gson.toJson(results));
    }
}

