<%-- 
    Document   : ModifyCategory
    Created on : 19 mars 2018, 23:54:30
    Author     : MERZAK
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Oracle.JDBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modify Category</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/><br>
        <% if(session.getAttribute("role") != null && ((session.getAttribute("role")).equals("ADMIN") || (session.getAttribute("role")).equals("MODERATOR"))){ %>
        <%
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT * FROM categories WHERE category_id=?");
            ps.setInt(1, Integer.parseInt(request.getParameter("category_id")));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
        %>
        
        <form method="POST" action="/ePress/ModifyCategory?category_id=<%=rs.getInt(1)%>" >
            <table align="center">
                <tr>
                    <td>Category ID :</td>
                    <td><input type="text" name="cat_id" value="<%=rs.getInt(1)%>" readonly></td>
                </tr>
                <tr>
                    <td>Category Name :</td>
                    <td><input type="text" name="category_name" value="<%=StringEscapeUtils.escapeHtml(rs.getString(2))%>"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Modify"></td>
                </tr>
            </table> 
        </form>
        <%
            }else{
                out.print("<script>alert('Article not found !')</script>");
            } rs.close(); ps.close();
            }else{
                out.print("<script>alert('You do not have suffisent privillage to view this page !')</script>");
            }
        %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
