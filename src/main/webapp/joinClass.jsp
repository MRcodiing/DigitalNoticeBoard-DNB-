<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String message = "";
    String messageType = "";

    String username = "";
    if (session.getAttribute("username") != null) {
        username = session.getAttribute("username").toString();
    } else {
        response.sendRedirect("login.jsp");
    }

    String cls = request.getParameter("class_name");
    String uid = request.getParameter("UniqueID");

    if (cls != null && uid != null) { // Form submit hone par hi execute hoga
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            String dbURL = "jdbc:mysql://localhost:3306/dnb_db";
            String dbUser = "root";
            String dbPass = "";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Check if the class exists
            String sql = "SELECT * FROM createclass WHERE class_name=? AND UniqueID=?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, cls);
            pst.setString(2, uid);
            rs = pst.executeQuery();

            if (rs.next()) {
                // Insert user into joinclass table
                String insertSql = "INSERT INTO joinclass (class_name, UniqueID, username) VALUES (?, ?, ?)";
                PreparedStatement insertPst = conn.prepareStatement(insertSql);
                insertPst.setString(1, cls);
                insertPst.setString(2, uid);
                insertPst.setString(3, username);
                insertPst.executeUpdate();
                insertPst.close();

                session.setAttribute("class_name", cls);
                session.setAttribute("UniqueID", uid);

                response.sendRedirect("join.jsp");
            } else {
                message = "Invalid Class Name or Unique ID! Please check and try again.";
                messageType = "error";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            messageType = "error";
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Class</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to right, #a8c0ff, #dde7f1);
        margin: 0;
        padding: 0;
        display: flex;
    }

    .sidebar {
        width: 250px;
        background: #1e3a5f;
        color: white;
        padding-top: 20px;
        height: 100vh;
        position: fixed;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        padding-left: 15px;
    }

    .sidebar .nav-links a {
        display: block;
        color: white;
        text-decoration: none;
        padding: 15px;
        width: 100%;
        box-sizing: border-box;
        font-size: 16px;
    }

    .sidebar .nav-links a:hover {
        background: #374a6e;
        padding-left: 25px;
        transition: 0.3s;
    }

     .main-content {
                background: transparent; /* Keeps it same as body */
                color: #2c3e50; /* Slightly dark text for readability */
                margin-left: 250px;
                margin-bottom:10px;
                padding: 20px;
                text-align: center;
                width: calc(100% - 250px);

            }

            .main-content h1 {
                color: #2c3e50; /* Explicit black for clarity */
                margin-bottom: 20px;
                padding:10px;
                border-bottom: 2px solid rgba(0, 0, 0, 0.1); /* Subtle bottom border for structure */

            }

    .form-container {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        width: 40%;
        margin: auto;
        text-align: left;
    }

    .form-container form {
        display: flex;
        flex-direction: column;
    }

    .form-container label {
        font-weight: bold;
        margin: 10px 0 5px;
    }

    .form-container input {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .form-container button {
        background: #1e3a5f;
        color: white;
        padding: 10px;
        border: none;
        cursor: pointer;
        font-size: 16px;
        border-radius: 5px;
        transition: 0.3s;
    }

    .form-container button:hover {
        background: #374a6e;
    }

    .message-box {
        padding: 10px;
        margin-bottom: 15px;
        text-align: center;
        font-weight: bold;
        border-radius: 5px;
        display: none;
    }

    .success {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }

    .error {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }

    /* Dropdown Container */
            .dropdown {
                position: relative;
                display: inline-block;
                width: 100%;
            }

            /* Hide Dropdown Menu by Default */
            .dropdown-menu {
                display: none;
                position: absolute;
                left: 0;
                background-color: #1e3a5f; /* Sidebar color */
                min-width: 200px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                border-radius: 5px;
            }

            /* Dropdown Menu Links */
            .dropdown-menu a {
                color: white;
                padding: 12px;
                text-decoration: none;
                display: block;
                transition: 0.3s;
            }

            /* Hover Effect for Links */
            .dropdown-menu a:hover {
                background-color: #374a6e;
            }

            /* Show Menu on Hover */
            .dropdown:hover .dropdown-menu {
                display: block;
            }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>Join Class</h2>
        <div class="nav-links">
            <a href="user_dashboard.jsp">Home</a>
            <div class="dropdown">
                <a href="#" class="nav-link">Classes</a>
                <div class="dropdown-menu">
                    <%
                        // Database connection
                        Connection con = null;
                        PreparedStatement pstmt1 = null, pstmt2 = null;
                        ResultSet rs1 = null, rs2 = null;

                        try {
                            String dbURL = "jdbc:mysql://localhost:3306/dnb_db";
                            String dbUser = "root";
                            String dbPass = "";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                            // Get username from session

                            // Fetch classes created by the logged-in user
                            String sql1 = "SELECT class_name FROM createclass WHERE username=?";
                            pstmt1 = con.prepareStatement(sql1);
                            pstmt1.setString(1, username);
                            rs1 = pstmt1.executeQuery();

                            // Display created classes
                            while (rs1.next()) {
                                String className = rs1.getString("class_name");
                    %>
                                <a href="class.jsp?class_name=<%= className %>"> <%= className %> (Created)</a>
                    <%
                            }

                            // Fetch classes where user has joined
                            String sql2 = "SELECT class_name FROM joinclass WHERE username=?";
                            pstmt2 = con.prepareStatement(sql2);
                            pstmt2.setString(1, username);
                            rs2 = pstmt2.executeQuery();

                            // Display joined classes
                            while (rs2.next()) {
                                String className = rs2.getString("class_name");
                    %>
                                <a href="join.jsp?class_name=<%= className %>"> <%= className %> (Joined)</a>
                    <%
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs1 != null) rs1.close(); } catch (Exception ex) { ex.printStackTrace(); }
                            try { if (pstmt1 != null) pstmt1.close(); } catch (Exception ex) { ex.printStackTrace(); }
                            try { if (rs2 != null) rs2.close(); } catch (Exception ex) { ex.printStackTrace(); }
                            try { if (pstmt2 != null) pstmt2.close(); } catch (Exception ex) { ex.printStackTrace(); }
                            try { if (con != null) con.close(); } catch (Exception ex) { ex.printStackTrace(); }
                        }
                    %>
                </div>
            </div>



        </div>
    </div>

    <div class="main-content">
        <h1>Join a Class</h1>
        <div class="form-container">


            <!-- Form -->
            <form action="" method="POST">
                <label for="class_name">Class Name:</label>
                <input type="text" id="class_name" name="class_name" required>

                <label for="invite-code">Invite Code:</label>
                <input type="text" id="invite-code" name="UniqueID" required>
               <!-- Message Box -->
                       <% if (message != null && !message.isEmpty()) { %>
                        <div class="message-box <%= messageType %>" style="display: block;">
                        <%= message %>
                </div>
            <% } %>
                <button type="submit">Join Class</button>
            </form>
        </div>
    </div>
</body>
</html>
