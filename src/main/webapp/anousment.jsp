package file;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class UploadAssignmentsServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "E:/uploads/assignments"; // ✅ Adjust path as needed

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp"); // Redirect if not logged in
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String subject = request.getParameter("subject");
        String deadline = request.getParameter("deadline");

        Part filePart = request.getPart("file");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            String extension = originalName.substring(originalName.lastIndexOf("."));
            fileName = "assignment_" + System.currentTimeMillis() + extension;

            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = UPLOAD_DIR + File.separator + fileName;
            filePart.write(filePath);
        }

        String DB_URL = "jdbc:mysql://localhost:3306/dnb_db";
        String DB_USER = "root";
        String DB_PASSWORD = "";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO assignments (title, description, subject, deadline, file, username) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, title);
                stmt.setString(2, description);
                stmt.setString(3, subject);
                stmt.setString(4, deadline);
                stmt.setString(5, fileName);
                stmt.setString(6, username);
                stmt.executeUpdate();
            }
            response.sendRedirect("class.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }
}
