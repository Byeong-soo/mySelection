package com.mySelection.repository;

import java.sql.*;

public class JdbcUtils {
    // MySQL DB접속정보
    public static final String url = "jdbc:mysql://localhost:3307/jspdb?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
    public static final String user = "myselection";
    public static final String passwd = "@DBqudtn587";


    public  static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection con = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, passwd);

        return con;
    } // getConnection

    public static void close(Connection con, PreparedStatement pstmt) {close(con,pstmt, null);}

    public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } // close

}
