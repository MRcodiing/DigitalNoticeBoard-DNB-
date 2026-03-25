<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Digital Notice Board</title>


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
        width: 80%;
        max-width: 1100px;

    }

    .left-section {
        flex: 1;
        background: linear-gradient(to right, #ff416c, #ff4b2b);
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

</head>
<body>

<div class="container">
    <div class="login-box">
        <h2 class="login-title">Login to DNB</h2>

        <form method="post" action="login.jsp" class="login-form">
            <input type="text" name="username" class="input-field" placeholder="Username" required>
            <input type="password" name="password" class="input-field" placeholder="Password" required>
            <%
                session.setAttribute("message", "Successfully submitted!");
                session.setAttribute("messageType", "success");
                String msg="";

                String username = request.getParameter("username");
                String pass = request.getParameter("password");
                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;



                try {
                    String dbURL = "jdbc:mysql://localhost:3306/dnb_db"; // Change if needed
                    String dbUser = "root"; // Change if you have a password
                    String dbPass = ""; // If you set a password in MySQL, add it here
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                    String sql = "SELECT * FROM users WHERE username=? AND password=?";
                    pst = conn.prepareStatement(sql);
                    pst.setString(1, username);
                    pst.setString(2, pass);
                    rs = pst.executeQuery();

                   if (rs.next()) {
                       session.setAttribute("username", username);
                       session.setAttribute("pass", pass);
                       response.sendRedirect("user_dashboard.jsp");
                   }else{
                        %>

                        <h5 style="color:red;"><%= msg %></h5>
                        <%
                   }


                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                }
            %>

            <button type="submit" class="btn-login">Login</button>
        </form>

        <p class="register-text">New user? <a href="register.jsp" class="register-link">Register here!</a></p>
    </div>
</div>


</body>
</html>
