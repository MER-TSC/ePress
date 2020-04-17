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
@WebServlet(name = "Like", urlPatterns = {"/Like"})
public class Like extends HttpServlet {

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
            out.println("<title>Servlet LikeComment</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LikeComment at " + request.getContextPath() + "</h1>");
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
        try{
            int article_id = Integer.parseInt(request.getParameter("article_id"));
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("INSERT INTO reacts VALUES ((SELECT NVL(MAX(react_id),0)+1 FROM reacts),SYSDATE,?,?,?,?)");
            if(request.getParameter("action").equals("like")){
                ps.setString(1, "LIKE");
            }else if(request.getParameter("action").equals("dislike")){
                ps.setString(1, "DISLIKE");
            }
            ps.setString(2, request.getSession().getId());
            if(request.getParameter("target").equals("comment")){
                ps.setInt(3, Integer.parseInt(request.getParameter("comment_id")));
                ps.setNull(4, java.sql.Types.NULL);
            }else if(request.getParameter("target").equals("article")){
                ps.setNull(3, java.sql.Types.NULL);
                ps.setInt(4, article_id);
            }
            ps.executeUpdate();
            ps.close();
            request.getRequestDispatcher("/JSP/ArticleDetails.jsp?article_id="+article_id).forward(request, response);
        }catch(SQLException ex){
            Logger.getLogger(Like.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        processRequest(request, response);
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
