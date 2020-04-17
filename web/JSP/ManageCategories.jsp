<%-- 
    Document   : ManageCategories
    Created on : 19 mars 2018, 20:30:52
    Author     : MERZAK
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Oracle.JDBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Categories</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/><br>
        <% if((session.getAttribute("role")).equals("ADMIN") || (session.getAttribute("role")).equals("MODERATOR")){ %>
        <div align="center">
            <a href="/ePress/JSP/NewCategory.jsp">New Category</a><br><br>
            <% 
                Connection cn = JDBConnection.Connect();
                PreparedStatement ps = cn.prepareStatement("SELECT * FROM categories");
                ResultSet rs = ps.executeQuery();
            %>
            <table id="table1" border="1" style="text-align: center">
                <tr><td>ID</td><td>Category Name</td></tr>
                <% while(rs.next()){ %>
                <tr>
                    <td><%=rs.getInt(1)%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></td>
                    <td><form method="POST" action="/ePress/JSP/ModifyCategory.jsp?category_id=<%=rs.getInt(1)%>"><input type="submit" value="Modify"></form></td>
                    <td><form method="POST" action="/ePress/DeleteCategory?category_id=<%=rs.getInt(1)%>"><input type="submit" value="Delete"></form></td>
                </tr>
                <% } %> 
            </table>
        </div>
        <% } else out.print("<script>alert('You do not have suffisent privillage to view this page !')</script>"); %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
