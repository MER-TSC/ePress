package Oracle;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author MERZAK
 */
public class JDBConnection {
    private static String url="jdbc:oracle:thin:@localhost:1521:XE";
    private static String user="ePRESS";
    private static String password="ePRESS";
    private static Connection cn=null;
    
    public static Connection Connect(){
        
        try{
            if(cn == null || !cn.isValid(5) || cn.isClosed()){
                Class.forName("oracle.jdbc.driver.OracleDriver");
                cn = DriverManager.getConnection(url, user, password);
                System.out.println("Connected successfully");
            }
        }catch(ClassNotFoundException cnfe){
            System.out.println("Could not load JDBC Driver");
        }catch(SQLException sqle){
            System.out.println("Could not connect to the Database : "+sqle.getMessage());
        }catch(NullPointerException npe){
            System.out.println("Could not connect to the Database, check your network connection and try again !");
        }/**finally{
            password="";
        }*/
        
        return cn;
    }
    
}