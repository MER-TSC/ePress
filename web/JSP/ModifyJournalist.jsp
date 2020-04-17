<%-- 
    Document   : ModifyJournaliste
    Created on : 21 mars 2018, 02:11:32
    Author     : DELL
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Oracle.JDBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modify Journalist</title>
    </head>
    <body>
        <jsp:include  page="Header.jsp"/><br>
        <% if(session.getAttribute("role") != null && ((session.getAttribute("role")).equals("ADMIN") || (session.getAttribute("role")).equals("MODERATOR"))){ %>
            <%
                Connection cn = JDBConnection.Connect();
                PreparedStatement ps = cn.prepareStatement("SELECT username, last_name, first_name, email FROM users WHERE username=? AND role='JOURNALIST'");
                ps.setString(1, request.getParameter("journalist").toString());
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
            %>
        <form method="POST" action="/ePress/ModifyJournalist?journalist=<%=StringEscapeUtils.escapeHtml(rs.getString(1))%>">
            <table>
                <tr><td>Last Name : </td><td><input type="text" name="last_name" value="<%=StringEscapeUtils.escapeHtml(rs.getString(2))%>"></td></tr>
                <tr><td>First Name : </td><td><input type="text"  name="first_name" value="<%=StringEscapeUtils.escapeHtml(rs.getString(3))%>"></td></tr>
                <tr><td>Email : </td><td><input type="email" name="email" value="<%=StringEscapeUtils.escapeHtml(rs.getString(4))%>"></td>
                </tr><br><tr><td></td><td></td><td><input type="submit" value="Modify"></td></tr>
            </table> 
        </form>
        <%
                }else{
                    out.print("<script>alert('Journalist not found !')</script>");
                }rs.close();ps.close();
            } else out.print("<script>alert('You do not have suffisent privillage to view this page !')</script>");
        %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
