<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Class</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #a8c0ff, #dde7f1);
            margin: 0;
            padding: 0;
            display: flex;
        }

         /* Sidebar Styling */
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
                         padding: 15px 20px;
                         text-align: left;
                         width: 100%;
                         box-sizing: border-box;
                         font-weight: bold;
                         transition: 0.3s;
                    }

                    .sidebar .nav-links a:hover {
                        background: #374a6e;
                        padding-left: 25px;

                        transition: 0.3s;
                    }
        /* Main Content Styling */
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
        /* Form Container */
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            width: 50%;
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

        /* Message Box */
        .message-box {
            margin-bottom: 10px;
            padding: 10px;
            text-align: center;
            font-weight: bold;
            border-radius: 5px;
            display: none; /* Hidden by default */
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
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Create Class</h2>
        <div class="nav-links">
            <a href="user_dashboard.jsp">Home</a>

            <div class="dropdown">
                <a href="#" class="nav-link">Classes</a>
                <div class="dropdown-menu">
                    <%
                        // **Database Connection**
                        Connection con = null;
                        PreparedStatement pstmt1 = null, pstmt2 = null;
                        ResultSet rs1 = null, rs2 = null;
                        String username = (String) session.getAttribute("username");

                        if (username == null) {
                            response.sendRedirect("login.jsp");
                        } else {
                            try {
                                String dbURL = "jdbc:mysql://localhost:3306/dnb_db";
                                String dbUser = "root";
                                String dbPass = "";
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection(dbURL, dbUser, dbPass);

                                // **Fetch created classes**
                                String sql1 = "SELECT class_name FROM createclass WHERE username=?";
                                pstmt1 = con.prepareStatement(sql1);
                                pstmt1.setString(1, username);
                                rs1 = pstmt1.executeQuery();

                                while (rs1.next()) {
                                    String className = rs1.getString("class_name");
                    %>
                                    <a href="class.jsp?class_name=<%= className %>"> <%= className %> (Created)</a>
                    <%
                                }

                                // **Fetch joined classes**
                                String sql2 = "SELECT class_name FROM joinclass WHERE username=?";
                                pstmt2 = con.prepareStatement(sql2);
                                pstmt2.setString(1, username);
                                rs2 = pstmt2.executeQuery();

                                while (rs2.next()) {
                                    String className = rs2.getString("class_name");
                    %>
                                    <a href="join.jsp?class_name=<%= className %>"> <%= className %> (Joined)</a>
                    <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs1 != null) rs1.close();
                                if (pstmt1 != null) pstmt1.close();
                                if (rs2 != null) rs2.close();
                                if (pstmt2 != null) pstmt2.close();
                                if (con != null) con.close();
                            }
                        }
                    %>
                </div>
            </div>

        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Create a New Class</h1>
        <div class="form-container">
            <%
                String message = "";
                String messageType = "";

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String className = request.getParameter("class_name");
                    String subject = request.getParameter("subject");
                    String uniqueID = request.getParameter("UniqueID");

                    if (className != null && subject != null && uniqueID != null) {
                        try {
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dnb_db", "root", "");
                            PreparedStatement pstmt = con.prepareStatement("INSERT INTO createclass (class_name, subject, UniqueID, username) VALUES (?, ?, ?, ?)");
                            pstmt.setString(1, className);
                            pstmt.setString(2, subject);
                            pstmt.setString(3, uniqueID);
                            pstmt.setString(4, username);

                            int rows = pstmt.executeUpdate();
                            if (rows > 0) {
                                response.sendRedirect("class.jsp");
                            } else {
                                message = "Error in creating class!";
                                messageType = "error";
                            }
                        } catch (SQLIntegrityConstraintViolationException e) {
                            message = "Class already exists!";
                            messageType = "error";
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else {
                        message = "All fields are required!";
                        messageType = "error";
                    }
                }
            %>

            <% if (!message.isEmpty()) { %>
                <div class="message-box <%= messageType %>" style="display: block;">
                    <%= message %>
                </div>
            <% } %>

            <form action="createClass.jsp" method="POST">
                <label>Class Name:</label>
                <input type="text" name="class_name" required>
                <label>Subject:</label>
                <input type="text" name="subject" required>
                <label>UniqueID:</label>
                <input type="text" name="UniqueID" required>
                <button type="submit">Create Class</button>
            </form>
        </div>
    </div>
</body>
</html>
