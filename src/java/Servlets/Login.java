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
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }

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
            Connection co =JDBConnection.Connect();
            PreparedStatement ps = co.prepareStatement("SELECT username, password, role, last_name || ' ' || first_name FROM users WHERE username=UPPER(?) OR email=LOWER(?)");
            ps.setString(1, request.getParameter("username"));
            ps.setString(2, request.getParameter("username")); // In case it's the e-mail
            ResultSet rs = ps.executeQuery();
            HttpSession s=request.getSession();
            if(rs.next()){
                if(BCrypt.checkPassword(request.getParameter("password"), rs.getString(2))){
                    s.setAttribute("username",rs.getString(1));
                    s.setAttribute("role",rs.getString(3));
                    s.setAttribute("name",rs.getString(4));
                    request.getRequestDispatcher("/JSP/Home.jsp").forward(request, response);
                }else{
                    //request.setAttribute("msg","Login failed, wrong Login/Password !");
                    request.getRequestDispatcher("/JSP/Login.jsp?msg=Login failed, wrong Login/Password !").forward(request, response);
                }
            }else{
                //request.setAttribute("msg","Login failed, no such Username/Email !");
                request.getRequestDispatcher("/JSP/Login.jsp?msg=Login failed, no such Username/Email !").forward(request, response);
            }
            rs.close();
            ps.close();
            //request.setAttribute("msg", null);
        }catch(SQLException ex){
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
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
