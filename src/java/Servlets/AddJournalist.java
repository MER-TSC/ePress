/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Oracle.BCrypt;
import Oracle.JDBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MERZAK
 */
@WebServlet(name = "AddJournalist", urlPatterns = {"/AddJournalist"})
public class AddJournalist extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddJournaliste</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddJournaliste at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //PrintWriter out = response.getWriter();
         
        try{
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("INSERT INTO users VALUES (UPPER(?),?,LOWER(?),?,?,UPPER(?),INITCAP(?),'JOURNALIST')");
            ps.setString(1, request.getParameter("username"));
            ps.setString(2, BCrypt.hashPassword(request.getParameter("password")));
            ps.setString(3, request.getParameter("email"));
            ps.setString(4, request.getParameter("security_question"));
            ps.setString(5, request.getParameter("security_answer"));
            ps.setString(6, request.getParameter("lastname"));
            ps.setString(7, request.getParameter("firstname"));
            ps.executeUpdate();
            ps.close();
            //out.print("<script>alert('Journalist Successfully added !');</script>");
            request.getRequestDispatcher("/JSP/ManageJournalists.jsp?msg=Journalist Successfully added !").forward(request, response);
            //request.setAttribute("msg", null);
        }catch(SQLException ex){
            Logger.getLogger(AddJournalist.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
