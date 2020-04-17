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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MERZAK
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession s = request.getSession(); 
        String username = s.getAttribute("username").toString();
        try{
            Connection cn = JDBConnection.Connect();
            PreparedStatement chkOldPwd = cn.prepareStatement("SELECT password FROM users WHERE username=?");
            chkOldPwd.setString(1, username);
            ResultSet rs = chkOldPwd.executeQuery();
            if(rs.next()){
                if(BCrypt.checkPassword(request.getParameter("oldpassword"),rs.getString(1))){
                    if((request.getParameter("newpassword")).equals(request.getParameter("newpasswordconfirmation"))){
                        PreparedStatement ps = cn.prepareStatement("UPDATE users SET password=? WHERE username=?");
                        ps.setString(1, BCrypt.hashPassword(request.getParameter("newpassword")));
                        ps.setString(2, username);
                        ps.executeUpdate();
                        ps.close();
                        //request.setAttribute("msg", "Password Successfully Updated !");
                        request.getRequestDispatcher("/JSP/ChangePassword.jsp?msg=Password Successfully Updated !").forward(request, response);
                    }else{
                        //request.setAttribute("msg", "The given passwords does not match !");
                        request.getRequestDispatcher("/JSP/ChangePassword.jsp?msg=The given passwords does not match !").forward(request, response);
                    }
                }else{
                    //request.setAttribute("msg", "Your old password was not correct !");
                    request.getRequestDispatcher("/JSP/ChangePassword.jsp?msg=Your old password was not correct !").forward(request, response);
                }
            }
            rs.close();
            chkOldPwd.close();
            //request.setAttribute("msg", null);
        }catch(SQLException ex){
            Logger.getLogger(ChangePassword.class.getName()).log(Level.SEVERE, null, ex);
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
