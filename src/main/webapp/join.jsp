<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Class Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="class-dashboard.css">
    <style>
        /* General Styling */
  /* General Styling */

        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
            padding: 0;
            background: linear-gradient(to right, #a8c0ff, #dde7f1);
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
                   width: 150%;
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
   out.print(className);

   } else {
       session.setAttribute("class_name", className);
   out.print(className);

   }

%>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Class Dashboard</h2>
        <div class="nav-links">
            <a href="user_dashboard.jsp">Home</a>
            <a href="login.jsp">log-out</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Welcome to Your Class</h1>

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
             <th>Title</th>
             <th>Description</th>
             <th>File</th>
             <th>Username</th>
         </tr>
         <%
              className = request.getParameter("class_name");

             if (className != null && !className.isEmpty()) {
                 session.setAttribute("class_name", className);
             }

             Connection con3 = null;
             PreparedStatement pstmt3 = null;
             ResultSet rs3 = null;

             try {
                 String url = "jdbc:mysql://localhost:3306/dnb_db";
                 String user = "root";
                 String password = "";

                 Class.forName("com.mysql.cj.jdbc.Driver");
                 con3 = DriverManager.getConnection(url, user, password);

                 // Query to fetch notices for the selected class
                 String query = "SELECT * FROM notices WHERE class_name=?";
                 pstmt3 = con3.prepareStatement(query);
                 pstmt3.setString(1, className);
                 rs3 = pstmt3.executeQuery();

                 while (rs3.next()) {
         %>
         <tr>
             <td><%= rs3.getInt("id") %></td>
             <td><%= rs3.getString("title") %></td>
             <td><%= rs3.getString("description") %></td>
             <td><a href="Download?fn=<%= rs3.getString("file") %>" target="_blank">Open File</a></td>
             <td><%= rs3.getString("username") %></td>
         </tr>
         <%
                 }
             } catch (Exception e) {
                 out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
             } finally {
                 try { if (rs3 != null) rs3.close(); } catch (Exception ex) { ex.printStackTrace(); }
                 try { if (pstmt3 != null) pstmt3.close(); } catch (Exception ex) { ex.printStackTrace(); }
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
                        PreparedStatement  pstmt = null;
                        ResultSet rs2 = null;


                       try {
                           String url = "jdbc:mysql://localhost:3306/dnb_db";
                           String user = "root";
                           String password = "";

                           Class.forName("com.mysql.cj.jdbc.Driver");
                           con2 = DriverManager.getConnection(url, user, password);

                           // ✅ Corrected SQL Query
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

                          String query = "SELECT * FROM assignments where class_name=?";
                          pstmt = con3.prepareStatement(query);
                          pstmt.setString(1,className);
                          rs3 = pstmt.executeQuery();

                          while (rs3.next()) {
                  %>
                  <tr>
                      <td><%= rs3.getInt("id") %></td>
                      <td><%= rs3.getString("title") %></td>
                      <td><%= rs3.getString("description") %></td>
                      <td><%= rs3.getString("subject") %></td>
                      <td><%= rs3.getString("deadline") %></td>
                       <td><a href="Downlode?fn=<%= rs3.getString("file") %>" target="_blank">Open File</a></td>
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
</body>
</html>
