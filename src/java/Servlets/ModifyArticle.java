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
 * @author MERZAK
 */
@WebServlet(name = "ModifyArticle", urlPatterns = {"/ModifyArticle"})
public class ModifyArticle extends HttpServlet {

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
            out.println("<title>Servlet Modify</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Modify at " + request.getContextPath() + "</h1>");
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
            PreparedStatement ps = cn.prepareStatement("UPDATE articles SET title=?, content=?, image_url=?, status=?, post_date=TO_DATE(?,'DD/MM/YYYY HH24:MI') WHERE article_id=? AND status IN('PENDING','DECLINED',?)");
            ps.setString(1, request.getParameter("title"));
            ps.setString(2,request.getParameter("content"));
            ps.setString(3, request.getParameter("image_url"));
            if(request.getSession().getAttribute("role").equals("ADMIN")){
                ps.setString(4,"APPROVED");
                ps.setString(5,new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()));
                ps.setString(7,"APPROVED");
            }else{
                ps.setString(4,"PENDING");
                ps.setNull(5, java.sql.Types.NULL);
                ps.setNull(7, java.sql.Types.NULL);
            }
            ps.setInt(6, Integer.parseInt(request.getParameter("article_id")));
            ps.executeUpdate();
            ps.close();
            //out.print("<script>alert('Successfully updated !')</script>");
            request.getRequestDispatcher("/JSP/ArticleDetails.jsp?article_id="+request.getParameter("article_id")+"&msg=Article successfully updated !").forward(request, response);
        }catch(SQLException sqle){
            Logger.getLogger(ModifyArticle.class.getName()).log(Level.SEVERE, null, sqle);
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
