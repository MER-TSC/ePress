<%-- 
    Document   : ModifyArticle
    Created on : 17 mars 2018, 01:59:25
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
        <title>Modify Article</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/><br>
         <%
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT article_id, title, content, image_url FROM articles WHERE article_id=?");
            ps.setInt(1, Integer.parseInt(request.getParameter("article_id")));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
        %>
        <article align="center">
            <form method="POST" action="/ePress/ModifyArticle?article_id=<%=rs.getInt(1)%>" >
                <table align="center">
                    <tr><td>Title :</td><td><input type="text" name="title" value="<%=StringEscapeUtils.escapeHtml(rs.getString(2))%>"></td></tr><br>
                    <tr><td>Content :</td><td><textarea rows="50" cols="120" name="content"><%=StringEscapeUtils.escapeHtml(rs.getString(3))%></textarea></td></tr>
                    <tr><td>Image URL :</td> <td><input type="text" name="image_url" value="<%=StringEscapeUtils.escapeHtml(rs.getString(4))%>"></td></tr><br>
                    <tr><td></td><td></td><td><input type="submit" value="Modify"></td></tr><br>
                </table>
            </form>
        </article>
        <%
            }else{
                out.print("<script>alert('Article not found !')</script>");
            }
             rs.close();ps.close();
        %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
