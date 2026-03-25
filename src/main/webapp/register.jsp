<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
 <style>
     * {
         margin: 0;
         padding: 0;
         box-sizing: border-box;
         font-family: Arial, sans-serif;
     }

     body {
         height: 100vh;
         background: url("signup-bg.png") no-repeat center center/cover;
         display: flex;
         justify-content: center;
         align-items: center;
     }

     .container {
         display: flex;
         width: 30%;
         max-width: 1100px;
         margin-right:800px;

     }

     .left-section {
         flex: 1;
         padding: 30px;
         color: white;
         display: flex;
         flex-direction: column;
         justify-content: center;
         align-items: center;
     }

     .right-section {
         flex: 1;
         padding: 40px 30px;
         display: flex;
         flex-direction: column;
         justify-content: center;
         background-color: #fff;
     }

     .login-title {
         font-size: 28px;
         font-weight: bold;
         margin-bottom: 25px;
         color: #333;
     }

     .input-field {
         width: 100%;
         padding: 12px;
         margin: 10px 0;
         border: 1px solid #ccc;
         border-radius: 8px;
         font-size: 16px;
     }

     .btn-login {
         width: 100%;
         padding: 12px;
         background: #ff4b2b;
         color: white;
         border: none;
         border-radius: 8px;
         cursor: pointer;
         font-size: 16px;
         font-weight: bold;
         transition: background 0.3s;
     }

     .btn-login:hover {
         background: #ff416c;
     }

     .register-text {
         margin-top: 15px;
         text-align: center;
         font-size: 14px;
     }

     .register-link {
         color: #ff4b2b;
         font-weight: bold;
         text-decoration: none;
     }

     .register-link:hover {
         text-decoration: underline;
     }
 </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Digital Notice Board</title>


</head>
<body>

<div class="container">
    <div class="login-box">
        <h2 class="login-title">Registar to DNB</h2>

        <form method="post" action="" class="login-form">
            <input type="text" name="name" class="input-field" placeholder="Enter Name" required>
            <input type="email" name="email" class="input-field" placeholder="Enter Email" required>
            <input type="text" name="username" class="input-field" placeholder="Username" required>
            <input type="password" name="password" class="input-field" placeholder="Password" required>
            <button type="submit" class="btn-login">Login</button>
        </form>

        <p class="register-text"><a href="login.jsp" class="register-link">Login here!</a></p>
    </div>
</div>


    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dnb_db", "root", "");

            String query = "INSERT INTO users (name, email, username, password) VALUES (?, ?, ?, ?)";
            pst = conn.prepareStatement(query);

            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, username);
            pst.setString(4, pass);

            int row = pst.executeUpdate();

            if (row > 0) {
                out.println("<script>alert('Registration successful!'); window.location='login.jsp';</script>");
            } else {
                out.println("<script>alert('Registration failed. Try again!'); window.location='register.jsp';</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='register.jsp';</script>");
        } finally {
            try {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>




</body>
</html>
