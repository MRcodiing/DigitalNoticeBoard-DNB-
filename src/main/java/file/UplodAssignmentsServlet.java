package file;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig // ✅ Enables file upload handling
public class UplodAssignmentsServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "F:/SD/DNB/src/main/webapp/uploads"; // ✅ Change this path if needed

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get username and class_name from session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String className = (String) session.getAttribute("class_name");

        if (username == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if session expired
            return;
        }

        if (className == null) {
            response.getWriter().println("<script>alert('Error: class_name is missing!');</script>");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String subject = request.getParameter("subject");
        String deadline = request.getParameter("deadline");

        Part filePart = request.getPart("file");
        String fileName = null;

        // ✅ File Upload Process with Renaming
        if (filePart != null && filePart.getSize() > 0) {
            String originalName = filePart.getSubmittedFileName();
            String extension = originalName.substring(originalName.lastIndexOf(".")); // Get file extension
            fileName = "assignment_" + System.currentTimeMillis() + extension; // Rename file

            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();  // 🔹 Create folder if it doesn't exist
            }

            String filePath = UPLOAD_DIR + File.separator + fileName;
            filePart.write(filePath);  // ✅ Save file with new name
        }

        // ✅ Database Connection Details
        String DB_URL = "jdbc:mysql://localhost:3306/dnb_db";
        String DB_USER = "root";
        String DB_PASSWORD = "";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO assignments (title, description, subject, deadline, file, username, class_name) VALUES (?, ?, ?, ?, ?, ?, ?)")) {

            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, subject);
            stmt.setString(4, deadline);
            stmt.setString(5, fileName);
            stmt.setString(6, username);
            stmt.setString(7, className);  // ✅ Added class_name

            stmt.executeUpdate();
            response.sendRedirect("class.jsp"); // ✅ Redirect to class.jsp after success
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }
}
