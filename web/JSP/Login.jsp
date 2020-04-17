<%-- 
    Document   : Login
    Created on : 14 mars 2018, 14:20:31
    Author     : MERZAK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/>
        <br><br><br> 
        <div style="text-align: center; box-shadow: 0 1px 12px 0 rgba(0,0,0,0.5), 0 1px 15px 0 rgba(0,0,0,0.29); padding: 10px; margin: 35%; margin-top: 20px">
            <h2 style="color: royalblue ;margin-top: 40px ; font-family: 'Segoe UI'">Login</h2> <br><br><br>
                <form action="/ePress/Login" method="post">
                    <input type="text" name ="username" placeholder="Entrer votre login.." required style="padding: 13px 25px ; font-family:'Segoe UI';"><br><br>
                    <input type="password" name ="password" placeholder="Entrer votre password.." required style="padding: 13px 25px;; font-family:'Segoe UI'" ><br><br>
                    <input type="checkbox" name="stayconnected" value="true" style="padding: 13px 25px;font-family:'Segoe UI'" > Stay Connected
                    <br><br>
                    <input type="submit" value="Login" style="border-radius: 4px; background-color:cornflowerblue ; color: #ffffff; padding: 13px 25px;border-style: hidden"><br><br>
                    <a href="/ePress/JSP/ForgottenPassword.jsp"class="nav">Forgotten Password ?</a><br><br><br>
                </form>
         </div>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
