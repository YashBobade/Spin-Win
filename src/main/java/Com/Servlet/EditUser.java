package Com.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
@WebServlet("/EditUser")
@MultipartConfig(maxFileSize = 16177215) // Handle large file uploads
public class EditUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Retrieve user ID from session
        Integer regId = (Integer) session.getAttribute("reg_id");
        
        if (regId == null) {
            // If reg_id is not available in the session, handle the error
            response.getWriter().write("Error: User ID not found in session.");
            return;
        }

        // Proceed with the rest of the update logic
        String fname = request.getParameter("fname");
        String phone = request.getParameter("phone");
        Part imagePart = request.getPart("image");
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

        Connection con = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/spin", "root", "");

            // SQL query to update user details in the `reguser` table
            String sql = "UPDATE reguser SET fname = ?, phone = ?, image = ? WHERE id = ?";
            stmt = con.prepareStatement(sql);
            stmt.setString(1, fname);
            stmt.setString(2, phone);
            stmt.setString(3, "uploads/" + fileName);  // Store relative image path
            stmt.setInt(4, regId);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Save the uploaded profile picture
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // Create directory if it doesn't exist
                }
                String filePath = uploadPath + File.separator + fileName;

                try (FileOutputStream fos = new FileOutputStream(filePath);
                     InputStream inputStream = imagePart.getInputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }

                // Update the session attributes
                session.setAttribute("fname", fname);
                session.setAttribute("contact", phone);
                session.setAttribute("image", fileName);

                // Redirect to the dashboard with success message
                response.sendRedirect("Dashboard.jsp?success=true");
            } else {
                response.sendRedirect("Profile.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Profile.jsp?error=true");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
