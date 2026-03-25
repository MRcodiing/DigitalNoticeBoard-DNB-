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
          background: #f8f9fa;
          display: flex;
          width: 100%;
          height: 100vh;
      }

      /* Sidebar Styling */
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

      /* Sidebar Links */
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
          text-align: left;
          width: calc(100% - 30px);
          box-sizing: border-box;
          font-size: 16px;
          transition: 0.3s;
      }

      .sidebar .nav-links a:hover {
          background: #3282b8;
          padding-left: 25px;
      }

      /* Main Content Styling */
      .main-content {
          margin-left: 250px;
          padding: 20px;
          text-align: center;
          width: calc(100% - 250px);
          flex: 1;
          min-height: 100vh;
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
          background: #1661c7;
          color: white;
          font-size: 16px;
          font-weight: bold;
          border: none;
          padding: 12px 18px;
          border-radius: 25px;
          cursor: pointer;
          display: flex;
          align-items: center;
          gap: 8px;
          transition: 0.3s;
          box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
      }

      .create-btn:hover {
          background: #0f4ba8;
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





    </style>
</head>
<body>
<%
    String className = request.getParameter("class_name");
    if (className != null && !className.isEmpty()) {
        session.setAttribute("class_name", className);
    } else {


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
            <a href="#">Announcements</a>
            <a href="#">Assignments</a>
            <a href="#">Members</a>
            <a href="#">Settings</a>
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

 <a href="anousment.jsp">
        <div class="dashboard-container">
              <div class="dashboard-card">
                  <h3>Announcements</h3>
                  <p>View the latest class updates and news.</p>
</a>
                  </div>

 <a href="ass.jsp">
              <div class="dashboard-card">
                  <h3>Assignments</h3>
                  <p>Check your upcoming assignments.</p>
              </div>
</a>

 <a href="member.jsp">
              <div class="dashboard-card">
                  <h3>Members</h3>
                  <p>See all students and teachers in this class.</p></a>
</div>
   <table border=1px>
              <tr>
                  <th>ID</th>
                  <th>title</th>
                  <th>description</th>
                  <th>subject</th>
                  <th>deadline</th>
                  <th>file</th>
                  <th>username</th>
              </tr>
              <%
                  Connection con3 = null;
                  Statement  stmt = null;
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
                  <td><%= rs3.getString("file") %></td>
                  <td><%= rs3.getString("username") %></td>
              </tr>
              <%
                      }
                  } catch (Exception e) {
                      out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                  } finally {
                      try { if (rs3 != null) rs3.close(); } catch (Exception ex) { ex.printStackTrace(); }
                      try { if (stmt != null) stmt.close(); } catch (Exception ex) { ex.printStackTrace(); }
                      try { if (con3 != null) con3.close(); } catch (Exception ex) { ex.printStackTrace(); }
                  }
              %>
          </table>

        </div>
    </div>
</body>
</html>
