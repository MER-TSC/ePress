<%-- 
    Document   : oubliermdp
    Created on : 28 mars 2018, 01:14:35
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Password Recovery</title>
    </head>
    <body style="text-align: center">
        <jsp:include page="Header.jsp"/>
        <br> <br> <br> 
        <div style="text-align: center; box-shadow: 0 1px 12px 0 rgba(0,0,0,0.5), 0 1px 15px 0 rgba(0,0,0,0.29); padding: 10px; margin: 35%; margin-top: 20px">
            <h2 style="color: royalblue ;margin-top: 40px ; font-family: 'Segoe UI'">Recover Password</h2> <br>
            <form action="/ePress/CheckEmail" method="POST">
                <input type="email" name="email" placeholder="Entrer your Email..." required style="padding: 13px 25px;; font-family:'Segoe UI'"><br><br>
                <input type="submit" value="Recover Password" style="border-radius: 4px; background-color:cornflowerblue ; color: #ffffff; padding: 13px 25px;border-style: hidden">

            </form>
        </div>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
