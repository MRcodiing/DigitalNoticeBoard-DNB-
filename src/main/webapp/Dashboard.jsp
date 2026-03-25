<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - DNB</title>
    <link rel="stylesheet" href="style/dashbord.css">
    <link rel="stylesheet" href="style/main.css">

</head>
<body>

<div class="dashboard-container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <h2>DNB Admin</h2>
        <ul>
            <li><a href="dashboard.jsp" class="active">Dashboard</a></li>
            <li><a href="notices.jsp">Manage Notices</a></li>
            <li><a href="users.jsp">Manage Users</a></li>
            <li><a href="settings.jsp">Settings</a></li>
            <li><a href="logout.jsp" class="logout">Logout</a></li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <h1>Dashboard Overview</h1>
        <p>Welcome! Manage notices, users, and system settings.</p>

        <div class="cards">
            <div class="card">
                <h3>Total Notices</h3>
                <p>15</p>
                <a href="notices.jsp" class="btn">View Notices</a>
            </div>

            <div class="card">
                <h3>Registered Users</h3>
                <p>120</p>
                <a href="users.jsp" class="btn">Manage Users</a>
            </div>

            <div class="card">
                <h3>Settings</h3>
                <p>Configure your system</p>
                <a href="settings.jsp" class="btn">Go to Settings</a>
            </div>
        </div>
    </main>
</div>

<%@ include file="footer.jsp" %>

</body>

</html>
