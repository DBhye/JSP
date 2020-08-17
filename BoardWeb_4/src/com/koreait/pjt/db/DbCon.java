package com.koreait.pjt.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DbCon {
	public static Connection getCon() throws Exception {

		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String username = "hr";
		String password = "koreait2020";

		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		Connection con = DriverManager.getConnection(url, username, password); // 클래스.실행();이런 실행은 static이다. db연결을 담당하는
																				// 실행문이다.
		System.out.println("접속성공");
		return con;
	}
	
public static void close (Connection con, PreparedStatement ps, ResultSet rs){
	if (rs != null) {try {rs.close();} catch (Exception e) {}}
	if (ps != null) {try {ps.close();} catch (Exception e) {}}
	if (con != null) {try {con.close();} catch (Exception e) {}}
	}

public static void close (Connection con, PreparedStatement ps){
	close(con, ps, null);
	}
}
