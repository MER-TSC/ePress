/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Oracle.JDBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ValidateArticle", urlPatterns = {"/ValidateArticle"})
public class ValidateArticle extends HttpServlet {

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
            out.println("<title>Servlet ValideArticle</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ValideArticle at " + request.getContextPath() + "</h1>");
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
        
        try{
            String action;
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("UPDATE articles SET status=?, post_date=TO_DATE(?,'DD/MM/YYYY HH24:MI') WHERE article_id=?");
            if(request.getParameter("action").equals("approve")){
                ps.setString(1, "APPROVED");action="approved";
                ps.setString(2, new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()));
            }else{
                ps.setString(1, "DECLINED");action="declined";
                ps.setNull(2, java.sql.Types.NULL);
            }
            ps.setInt(3, Integer.parseInt(request.getParameter("article_id")));
            ps.executeUpdate();
            ps.close();
            request.getRequestDispatcher("/JSP/ValidateArticles.jsp?msg=Article successfully "+action+" !").forward(request, response);
            //request.setAttribute("msg", null);
        }catch(SQLException ex){
            Logger.getLogger(ValidateArticle.class.getName()).log(Level.SEVERE, null, ex);
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
