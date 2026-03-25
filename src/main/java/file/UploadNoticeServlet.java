package file;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig(fileSizeThreshold = 2 * 1024 * 1024, // 2MB
        maxFileSize = 10 * 1024 * 1024,      // 10MB
        maxRequestSize = 50 * 1024 * 1024)   // 50MB
public class UploadNoticeServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "F:/SD/DNB/src/main/webapp/uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String className = (String) session.getAttribute("class_name");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (className == null) {
            response.getWriter().println("<script>alert('Error: className is missing!');</script>");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");

        Part filePart = request.getPart("file");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName();
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

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO notices (title, description, file, username, class_name) VALUES (?, ?, ?, ?, ?)")) {

            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, fileName);
            stmt.setString(4, username);
            stmt.setString(5, className);
            stmt.executeUpdate();

            response.sendRedirect("class.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }
}
