<%@ page import="com.localconnect.repository.BookingRepositoryImpl" %>
<%@ page import="java.io.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
String status = request.getParameter("status");

BookingRepositoryImpl repo = new BookingRepositoryImpl();
boolean updated = repo.updateBookingStatus(id, status);

if (updated) {
session.setAttribute("updateMessage", "Booking " + status + " successfully!");
} else {
session.setAttribute("updateMessage", "❌ Failed to update booking.");
}
response.sendRedirect("provider-dashboard.jsp");
%>
