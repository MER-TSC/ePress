<%-- 
    Document   : FormAddArticle
    Created on : 14 mars 2018, 14:54:13
    Author     : DELL
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
        <title>New Article</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/>
        <article align="center">
          <form action="/ePress/AddArticle" method="POST" >
             <table>
                 <tr><td>Title : </td><td><input type="text" name="title"></td></tr>
                 <tr><td>Category : </td>
                     <td><select name="category">
                             <%
                                Connection cn = JDBConnection.Connect();
                                PreparedStatement ps = cn.prepareStatement("SELECT * FROM categories");
                                ResultSet rs = ps.executeQuery();
                                while(rs.next()){
                            %>
                            <option value="<%=rs.getInt(1)%>"><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></option>
                            <% } rs.close();ps.close(); %>
                         </select></td>
                </tr>
                <tr><td>Content : </td><td><textarea name="content" cols="120" rows="50" ></textarea></td></tr>
                <tr><td>Image : </td><td><input type="text" name="image_url"></td></tr>
                <tr><td></td><td></td><td><input type="submit" value="Submit" ></td></tr>
            </table>
          </form>
        </article>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
