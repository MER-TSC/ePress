<%-- 
    Document   : DetailsCommentaire
    Created on : 21 mars 2018, 00:35:42
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Oracle.JDBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comment Details</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
         <% 
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT noc,titre,contenu,email,pseudo,datecomm FROM commentaire WHERE noc=?");
            ps.setInt(1, Integer.parseInt(request.getParameter("noc")));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){  %>
            <table>
                <tr><td>TITLE :</td><td><input type="text" name="TITRE" value="<%=rs.getString(2)%>" readonly></td></tr>
                <tr><td>PSEUDO :</td><td><input type="text" name="PSEUDO" value="<%=rs.getString(5)%>" readonly></td></tr>
                <tr><td>CONTENU :</td><td><textarea rows="9" cols="80"  name="CONTENU" readonly><%=rs.getString(3)%></textarea></td></tr>
                <tr><td>Email :</td><td><input type="email" name="Email" value="<%=rs.getString(4)%>" readonly></td></tr>
                <tr><td>DATE COMMENTAIRE :</td><td><input type="date" name="DATE" value="<%= rs.getDate(6) %>" readonly></td></tr>
                <td><form method="POST" action="/ePress/ValideCommentaire?noc=<%= rs.getInt(1) %>&etat=ACCEPTE"><input type="submit" value="Publier"></form></td>
                <td><form method="POST" action="/ePress/ValideCommentaire?noc=<%= rs.getInt(1) %>&etat=REJETE"><input type="submit" value="Archiver"></form></td>
            </table>
            

         <% } %>
    </body>
</html>
