<%-- 
    Document   : AddJournaliste
    Created on : 21 mars 2018, 01:48:56
    Author     : DELL
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
        <title>New Journalist</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/>
        <%
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT * FROM securityquestions");
            ResultSet rs = ps.executeQuery();
        %>
        <form method="post" action="/ePress/AddJournalist">
            <table>
                <tr><td>Last name :</td> <td><input type="text" name="lastname"></td></tr><br>
                <tr><td>First name :</td><td><input type="text" name="firstname"></td></tr><br>
                <tr><td>Username :</td><td><input type="text" name="username"></td></tr><br>
                <tr><td>Password :</td><td><input type="password" name="password"></td></tr><br>
                <tr><td>Email :</td><td><input type="email" name="email"</td></tr>
                <tr><td>Security Question :</td>
                    <td><select name="security_question">
                           <% while(rs.next()){ %>
                           <option value="<%=rs.getString(1)%>"><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></option>
                           <% } rs.close();ps.close(); %>
                    </select></td>
                </tr>
                <tr><td>Security Answer:</td><td><input type="text" name="security_answer"></td></tr>
                <tr><td></td><td></td><td><input type="Submit" value="Add"></td></tr><br>   
            </table> 
        </form>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
