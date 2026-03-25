<!DOCTYPE html>
<html lang="en">
<%@ include file="header.jsp" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Digital Notice Board</title>
    <link rel="stylesheet" href="style/main.css">
<style>
         body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 50%;
                margin: auto;
                background: #ffffff;
                padding: 20px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                margin-top: 50px;
            }

            h2 {
                text-align: center;
                color: #1e3a5f;
            }

            label {
                font-weight: bold;
                color: #333;
            }

            input, textarea {
                width: 100%;
                padding: 10px;
                margin: 5px 0 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                width: 100%;
                padding: 10px;
                background-color: #1e3a5f;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }

            button:hover {
                background-color: #374a6e;
            }
        </style>
</head>
<body>

    <main class="container">
        <h2>Contact Us</h2>
        <p>If you have any queries or suggestions, feel free to contact us using the form below.</p>

        <form action="contactServlet" method="post" class="contact-form">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="5" required></textarea>

            <button type="submit">Send Message</button>
        </form>
    </main>
    <%@ include file="footer.jsp" %>


</body>
</html>
