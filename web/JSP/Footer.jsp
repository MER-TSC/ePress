<%-- 
    Document   : Footer
    Created on : 31-Mar-2018, 12:23:58
    Author     : MERZAK
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <footer style="">
        <div style="text-align: center; background-color: #f1f1f1; font-family: 'Segoe UI'; box-sizing: inherit; display: block;box-shadow: 0 0 7px rgba(0,0,0,0.3); margin-top: 35px">
            Copyright &COPY; <%="2018"%>
        </div>
        <%
            if(request.getParameter("msg") != null){
                out.print("<script>alert('"+StringEscapeUtils.escapeHtml(request.getParameter("msg"))+"')</script>");
            }
        %>
    </footer>
</html>
