<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>DNB Dashboard</title>

  <style>
   /* Global Background */
   body {
     font-family: Arial, sans-serif;
     margin: 0;
     padding: 0;
     background: linear-gradient(to right, #a8c0ff, #dde7f1);
     display: flex;
     flex-direction: column;
     align-items: center;
   }


  .header {
      background: transparent; /* Same as background */
      color: #2c3e50; /* Slightly dark text for readability */
      padding: 20px;
      text-align: center;
      font-size: 28px;
      font-weight: bold;
      width: 95%;
      border-bottom: 2px solid rgba(0, 0, 0, 0.1); /* Subtle bottom border for structure */
  }



   /* Sidebar */
   .sidebar {
     width: 250px;
     background:#1e3a5f;
     color: white;
     padding-top: 20px;
     height: 100vh;
     position: fixed;
     display: flex;
     flex-direction: column;
     align-items: flex-start;
     top: 0;
     left: 0;
     overflow-y: auto;
   }
   .sidebar h2{
        padding-left:35%;
   }

   /* Sidebar Links */
   .sidebar .nav-links {
     width: 100vh;
     display: flex;
     flex-direction: column;
     padding-left: 0;
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
     background: #374a6e; /* Light Red */
   }

   /* Main Content */
   .main-content {
     margin-left: 270px;
     padding: 20px;
     text-align: center;
     width: calc(100% - 270px);
   }

   /* Options Box */
   .options-container {
     display: flex;
     justify-content: center;
     gap: 30px;
     margin-top: 25px;
   }

   .option-box {
     background: white;
     padding: 25px;
     border-radius: 10px;
     box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
     width: 320px;
     text-align: center;
     cursor: pointer;
     transition: 0.3s;
   }

   .option-box:hover {
     transform: scale(1.08);
   }

   .option-box h3 {
     margin: 0 0 12px;
     color: #333;
   }

   .option-box p {
     color: #555;
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
  <h2>DNB</h2>
  <div class="nav-links">
    <a href="index.jsp">Home</a>
    <a href="createClass.jsp">Create class/offie</a>
    <a href="joinClass.jsp">join class/office</a>
    <div class="dropdown">
                        <a href="#" class="nav-link">Classes</a>
                        <div class="dropdown-menu">
                            <%

                             String username = "";
                                if (session.getAttribute("username") != null) {
                                    username = session.getAttribute("username").toString();
                                } else {
                                    response.sendRedirect("login.jsp");
                                }
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

<!-- Main Content -->
<div class="main-content">
  <h1 class="header">Welcome to DNB</h1>  <!-- Heading Fixed -->

  <div class="options-container">
    <div class="option-box" onclick="location.href='createClass.jsp'">
      <h3>Create class/office</h3>
      <p>Start a new class or office group.</p>
    </div>
    <div class="option-box" onclick="location.href='joinClass.jsp'">
      <h3>Join class/office</h3>
      <p>Enter an invite code to join a group.</p>
    </div>
  </div>
</div>

</body>
</html>
