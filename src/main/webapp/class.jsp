
<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Class Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="class-dashboard.css"> <!-- Custom CSS for this page -->
    <style>
     /* General Styling */

      /* General Styling */
      body {
          font-family: Arial, sans-serif;
          margin: 0;
          padding: 0;
          background: linear-gradient(135deg, #a8c0ff, #dde7f1);
          display: flex;
          width: 100%;
          height: 100vh;

      }

      /* Sidebar Styling */
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
      /* Dashboard Cards */
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

      /* Create Button Styling */
      .create-button-container {
          position: relative;
          display: inline-block;
      }

      .create-btn {
          background: linear-gradient(135deg, #1a73e8, #1661c7); /* Gradient for better look */
          color: white;
          font-size: 16px;
          font-weight: bold;
          border: none;
          padding: 12px 20px;
          border-radius: 30px;
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
          gap: 10px;
          transition: all 0.3s ease-in-out;
          box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
          width: auto;
          min-width: 140px;
      }

      /* Hover effect */
      .create-btn:hover {
          background: linear-gradient(135deg, #145ab6, #0f4ba8);
          transform: scale(1.08);
          box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
      }

      /* Active Click Effect */
      .create-btn:active {
          transform: scale(0.95);
          box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.2);
      }

      /* Media query for responsiveness */
      @media (max-width: 768px) {
          .create-btn {
              font-size: 14px;
              padding: 10px 16px;
              min-width: 120px;
          }
      }

      @media (max-width: 480px) {
          .create-btn {
              font-size: 13px;
              padding: 8px 14px;
              min-width: 100px;
              gap: 5px;
          }
      }


      /* Dropdown Menu */
      .dropdown-menu {
          display: none;
          position: absolute;
          top: 50px;
          left: 0;
          background: white;
          border-radius: 10px;
          box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
          min-width: 220px;
          overflow: hidden;
          z-index: 100;
          padding: 8px 0;
      }

      .dropdown-menu a {
          display: flex;
          align-items: center;
          padding: 12px;
          text-decoration: none;
          color: black;
          font-weight: bold;
          transition: 0.3s;
          font-size: 14px;
      }

      .dropdown-menu a .icon {
          margin-right: 10px;
      }

      .dropdown-menu a:hover {
          background: #f1f1f1;
      }

      /* Show dropdown on hover */
      .create-button-container:hover .dropdown-menu {
          display: block;
      }


      /* Table Styling */
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
          font-weight: bold;
          text-transform: uppercase;
      }

      tr:hover {
          background: #f1f1f1;
      }

      /* Dashboard Card Links */
      .dashboard-container a {
          text-decoration: none;
          color: inherit;
          display: inline-block;
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
          box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
      }


   /* Dropdown Container */
                     .dropdown {
                         position: relative;
                         display: inline-block;
                         width: 100%;
                     }

                     /* Hide Dropdown Menu by Default */
                     .dropdown-menu1 {
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
                     .dropdown-menu1 a {
                         color: white;
                         padding: 12px;
                         text-decoration: none;
                         display: block;
                         transition: 0.3s;
                     }

                     /* Hover Effect for Links */
                     .dropdown-menu1 a:hover {
                         background-color: #374a6e;
                     }

                     /* Show Menu on Hover */
                     .dropdown1:hover .dropdown-menu1 {
                         display: block;
                     }


    </style>
</head>


<body>
<script>
    function showTable(tableId) {
        // Hide all tables
        document.getElementById('notices-table').style.display = 'none';
        document.getElementById('assignments-table').style.display = 'none';
        document.getElementById('members-table').style.display = 'none';

        // Show the selected table
        document.getElementById(tableId).style.display = 'table';
    }
</script>

<%

    String className = request.getParameter("class_name");
    if (className == null || className.isEmpty()) {
       className = (String) session.getAttribute("class_name");

   } else {
       session.setAttribute("class_name", className);
   }

%>

<%
        // Fetch class details
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

            if (rs.next()) {


            } else {
                    out.print("error");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) { ex.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception ex) { ex.printStackTrace(); }
            try { if (con != null) con.close(); } catch (Exception ex) { ex.printStackTrace(); }
        }
    %>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Class Dashboard</h2>
        <div class="nav-links">
            <a href="user_dashboard.jsp">Home</a>
            <a href="notice.jsp?class_name=<%= className %>">Notice</a>
            <a href="assignment.jsp?class_name=<%= className %>">Assignments</a>
            <a href="index.jsp">log-out</a>


        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Welcome to Your Class</h1>
        <div class="create-button-container">
            <button class="create-btn">
                + Create
            </button>
            <div class="dropdown-menu">
                <a href="notice.jsp"> Notice</a>
                <a href="assignment.jsp"> Assignment</a>
            </div>
        </div>

<div class="dashboard-container">

        <div class="dashboard-card" onclick="showTable('notices-table')">
            <h3>Announcements</h3>
            <p>View the latest class updates and news.</p>
        </div>



                <div class="dashboard-card" onclick="showTable('assignments-table')">
                  <h3>Assignments</h3>
                  <p>Check your upcoming assignments.</p>
              </div>



            <div class="dashboard-card" onclick="showTable('members-table')">
                  <h3>Members</h3>
                  <p>See all students and teachers in this class.</p>

</div>

 <table id="notices-table" style="display:none;" border="1px">
                <tr>
                    <th>ID</th>
                    <th>title</th>
                    <th>description</th>
                    <th>file</th>
                    <th>username</th>
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
                        String query = "SELECT * FROM notices where class_name=?";
                         pstmt = con3.prepareStatement(query);
                         pstmt.setString(1, className);
                         rs3 = pstmt.executeQuery();

                        while (rs3.next()) {
                %>
                <tr>
                    <td><%= rs3.getInt("id") %></td>
                    <td><%= rs3.getString("title") %></td>
                    <td><%= rs3.getString("description") %></td>
                    <td><a href="Downlode?fn=<%= rs3.getString("file") %>" target="_blank">Open File</a></td>
                    <td><%= rs3.getString("username") %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (rs3 != null) rs3.close(); } catch (Exception ex) { ex.printStackTrace(); }
                        try { if (pstmt != null) stmt.close(); } catch (Exception ex) { ex.printStackTrace(); }
                        try { if (con3 != null) con3.close(); } catch (Exception ex) { ex.printStackTrace(); }
                    }
                %>

            </table>


    <table id="members-table" style="display:none;" border="1">
             <tr>
                 <th>ID</th>
                 <th>Name</th>
                 <th>Email</th>
                 <th>Username</th>
             </tr>

             <%
                  Connection con2 = null;
                  pstmt = null;
                  ResultSet rs2 = null;


                 try {
                     String url = "jdbc:mysql://localhost:3306/dnb_db";
                     String user = "root";
                     String password = "";

                     Class.forName("com.mysql.cj.jdbc.Driver");
                     con2 = DriverManager.getConnection(url, user, password);


                     String query = "SELECT DISTINCT users.* FROM users  WHERE users.username IN ( SELECT username FROM createclass WHERE class_name = ? UNION  SELECT username FROM joinclass WHERE class_name = ?);";
                     pstmt = con2.prepareStatement(query);
                     pstmt.setString(1, className);
                     pstmt.setString(2, className);

                     rs2 = pstmt.executeQuery();

                     while (rs2.next()) {
             %>
             <tr>
                 <td><%= rs2.getInt("id") %></td>
                 <td><%= rs2.getString("name") %></td>
                 <td><%= rs2.getString("email") %></td>
                 <td><%= rs2.getString("username") %></td>
             </tr>
             <%
                     }
                 } catch (Exception e) {
                     out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                 } finally {
                     try { if (rs2 != null) rs2.close(); } catch (Exception ex) { ex.printStackTrace(); }
                     try { if (pstmt != null) pstmt.close(); } catch (Exception ex) { ex.printStackTrace(); }
                     try { if (con2 != null) con2.close(); } catch (Exception ex) { ex.printStackTrace(); }
                 }
             %>
         </table>


           <table id="assignments-table" style="display:none;" border="1">

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

                 con3 = null;
                 pstmt = null;
                 rs3 = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/dnb_db";
                    String user = "root";
                    String password = "";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con3 = DriverManager.getConnection(url, user, password);

                     String query = "SELECT * FROM assignments WHERE class_name = ?";
                            pstmt = con3.prepareStatement(query);
                            pstmt.setString(1, className); // Set the class_name value dynamically
                            rs3 = pstmt.executeQuery();

                    while (rs3.next()) {
            %>
            <tr>
                <td><%= rs3.getInt("id") %></td>
                <td><%= rs3.getString("title") %></td>
                <td><%= rs3.getString("description") %></td>
                <td><%= rs3.getString("subject") %></td>
                <td><%= rs3.getString("deadline") %></td>

                  <td>
                      <a href="Downlode?fn=<%= rs3.getString("file") %>" target="_blank">Open File</a>
                  </td>
                <td><%= rs3.getString("username") %></td>
            </tr>
            <%
                    }

                } catch (Exception e) {
                    out.print("<p style='color:red;'>Error: Unable to fetch assignments.</p>");
                    e.printStackTrace();
                } finally {
                    try { if (rs3 != null) rs3.close(); } catch (Exception ex) {}
                    try { if (pstmt != null) pstmt.close(); } catch (Exception ex) {}
                    try { if (con3 != null) con3.close(); } catch (Exception ex) {}
                }
            %>
        </table>




        </div>

    </div>

</body>
</html>
