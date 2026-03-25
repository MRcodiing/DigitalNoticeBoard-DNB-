<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/your_database"; // Database ka naam update karein
    String user = "your_username"; // Database username
    String password = "your_password"; // Database password

    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        out.println("Database Connected Successfully!");
    } catch (Exception e) {
        out.println("Database Connection Failed: " + e.getMessage());
    }
%>

