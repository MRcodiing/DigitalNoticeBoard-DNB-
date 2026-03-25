<%@ page import="java.sql.*, java.io.*, javax.servlet.http.*, javax.servlet.annotation.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Notice</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #a8c0ff, #dde7f1);
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 250px;
            background: #1e3a5f;
            color: white;
            padding: 20px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
        }
        .sidebar h2 { font-size: 22px; margin-bottom: 30px; }
        .sidebar a {
            color: white; text-decoration: none; font-size: 16px;
            padding: 12px 15px; display: block; border-radius: 5px;
            transition: background 0.3s, padding-left 0.3s;
        }
        .sidebar a:hover { background: rgba(255, 255, 255, 0.2); padding-left: 20px; }
        .main-content {
            margin-left: 270px; width: calc(100% - 270px);
            display: flex; justify-content: center; align-items: center; height: 100vh;
        }
        .notice-form-container {
            background: white; padding: 30px; border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.15);
            max-width: 500px; width: 100%;
        }
        .notice-form-container h2 {
            text-align: center; color: #0f4c81; font-size: 22px; margin-bottom: 20px;
        }
        .notice-form-container form { display: flex; flex-direction: column; }
        .notice-form-container label {
            font-size: 16px; font-weight: 600; margin-bottom: 5px; color: #0f4c81;
        }
        .notice-form-container input, .notice-form-container textarea {
            width: 100%; padding: 12px; margin-bottom: 15px;
            border: 1px solid #d1d5db; border-radius: 8px; font-size: 14px;
            transition: border 0.3s, box-shadow 0.3s;
        }
        .notice-form-container input:focus, .notice-form-container textarea:focus {
            border-color: #1661c7; outline: none; box-shadow: 0px 0px 5px rgba(22, 97, 199, 0.3);
        }
        .submit-btn {
            background: #1661c7; color: white; font-size: 16px;
            font-weight: bold; border: none; padding: 12px;
            border-radius: 8px; cursor: pointer; transition: background 0.3s, transform 0.2s;
        }
        .submit-btn:hover { background: #0f4ba8; transform: scale(1.05); }
    </style>
</head>
<body>
<% String username = (String) session.getAttribute("username"); %>
<% String className = (String) session.getAttribute("class_name"); %>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>DNB Admin</h2>
        <a href="class.jsp?class_name=<%= className %>"> home </a>
           <a href="notice.jsp?class_name=<%= className %>"> notice</a>
                  <a href="assignment.jsp?class_name=<%= className %>">Assignments</a>

    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="notice-form-container">
            <h2>Create Notice</h2>


            <!-- HTML Form for Uploading Notice -->
            <form action="us" method="post" enctype="multipart/form-data">
                <label>Title:</label>
                <input type="text" name="title" required>

                <label>Description:</label>
                <textarea name="description" required></textarea>

                <label>Upload File:</label>
                <input type="file" name="file" accept=".jpg, .jpeg, .png, .gif, .pdf, .doc, .docx">

                <input type="hidden" name="username" value="<%= username %>">
                <input type="hidden" name="className" value="<%= className %>">

                <button type="submit" class="submit-btn">Upload</button>
            </form>
        </div>
    </div>
</body>
</html>
