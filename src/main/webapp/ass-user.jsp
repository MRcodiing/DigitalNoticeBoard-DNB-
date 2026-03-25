<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Class Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="class-dashboard.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f8f9fa;
            display: flex;
            width: 100%;
            height: 100vh;
        }

        .sidebar {
            width: 250px;
            background: #1b262c;
            color: white;
            padding-top: 20px;
            height: 100vh;
            position: fixed;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding-left: 15px;
        }

        .sidebar .nav-links {
            width: 100%;
            display: flex;
            flex-direction: column;
            margin-top: 20px;
        }

        .sidebar .nav-links a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 15px;
            font-size: 16px;
            transition: 0.3s;
        }

        .sidebar .nav-links a:hover {
            background: #3282b8;
            padding-left: 25px;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
            text-align: center;
            width: calc(100% - 250px);
        }

        .dashboard-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        .dashboard-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            width: 320px;
            text-align: center;
            cursor: pointer;
            transition: 0.3s;
        }

        .dashboard-card:hover {
            transform: scale(1.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #1661c7;
            color: white;
        }
    </style>
</head>
<body>
<%
    String className = request.getParameter("class_name");
    if (className != null && !className.isEmpty()) {
        session.setAttribute("class_name", className);
    }
%>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        String dbURL = "jdbc:mysql://localhost:3306/dnb_db";
        String dbUser = "root";
        String dbPass = "";
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, dbUser, dbPass);
        String sql = "SELECT * FROM createclass WHERE class_name=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, className);
        rs = pstmt.executeQuery();
        if (!rs.next()) {
            out.print("<p style='color:red;'>Class not found.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    }
%>

<div class="sidebar">
    <h2>Class Dashboard</h2>
    <div class="nav-links">
        <a href="user_dashboard.jsp">Home</a>
        <a href="anousment-user.jsp">Announcements</a>
        <a href="ass-user.jsp">Assignments</a>
        <a href="member-user.jsp">Members</a>
        <a href="#">Settings</a>
    </div>
</div>

<div class="main-content">
    <h1>Welcome to Your Class</h1>
    <div class="dashboard-container">
        <a href="anousment-user.jsp" class="dashboard-card">
            <h3>Announcements</h3>
            <p>View the latest class updates and news.</p>
        </a>
        <a href="ass-user.jsp" class="dashboard-card">
            <h3>Assignments</h3>
            <p>Check your upcoming assignments.</p>
        </a>
        <a href="member-user.jsp" class="dashboard-card">
            <h3>Members</h3>
            <p>See all students and teachers in this class.</p>
        </a>
    </div>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Subject</th>
            <th>Deadline</th>
            <th>File</th>
            <th>Username</th>
        </tr>
        <%
            Connection con3 = null;
            Statement stmt = null;
            ResultSet rs3 = null;
            try {
                String url = "jdbc:mysql://localhost:3306/dnb_db";
                String user = "root";
                String password = "";
                Class.forName("com.mysql.cj.jdbc.Driver");
                con3 = DriverManager.getConnection(url, user, password);
                stmt = con3.createStatement();
                String query = "SELECT * FROM assignments";
                rs3 = stmt.executeQuery(query);
                while (rs3.next()) {
        %>
        <tr>
            <td><%= rs3.getInt("id") %></td>
            <td><%= rs3.getString("title") %></td>
            <td><%= rs3.getString("description") %></td>
            <td><%= rs3.getString("subject") %></td>
            <td><%= rs3.getString("deadline") %></td>
            <td><a href="F:/uploads/assignments/<%= rs3.getString("file") %>" download>Download</a></td>
            <td><%= rs3.getString("username") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs3 != null) rs3.close();
                if (stmt != null) stmt.close();
                if (con3 != null) con3.close();
            }
        %>
    </table>
</div>
</body>
</html>
