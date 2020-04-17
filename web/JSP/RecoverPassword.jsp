<%-- 
    Document   : RecoverPassword
    Created on : 28 mars 2018, 14:34:02
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
        <title>Recover Password</title>
    </head>
    <body>
         <jsp:include page="Header.jsp"/><br>
        <%
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT * FROM securityquestions");
            ResultSet rs = ps.executeQuery();
        %>
      <br> <br> <br> 
        <div style="text-align: center; box-shadow: 0 1px 12px 0 rgba(0,0,0,0.5), 0 1px 15px 0 rgba(0,0,0,0.29); padding: 10px; margin: 35%; margin-top: 20px">
            <h2 style="color: royalblue ;margin-top: 40px ; font-family: 'Segoe UI'">Recover Password</h2> <br>
            <form method="POST" action="/ePress/ChkSecInfos">
                <select name="secquestion">
                    <% while(rs.next()){ %>
                    <option value="<%=rs.getInt(1)%>"><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></option>
                  <% } rs.close();ps.close(); %>
                </select>
                <input type="text" name="secanswer">
                <input type="submit" value="Recover Password">
            </form>
        </div>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
