package com.koreait.board.db;

import java.util.*;
import java.sql.*;
import com.koreait.board.vo.*;

public class BoardDAO {

	public static List<BoardVO> selBoardList() {

		List<BoardVO> list = new ArrayList();

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = " SELECT i_board, title, i_student FROM t_board ORDER BY i_board DESC ";

		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) {
				//줄을 가리킬때 값이 있으면 true 없으면 false
				int i_board = rs.getInt("i_board");
				String title = rs.getNString("title");
				int i_student = rs.getInt("i_student");
				BoardVO vo = new BoardVO();
				vo.setI_board(i_board);
				vo.setTitle(title);
				vo.setI_student(i_student);
				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con,ps,rs);
		}
		return list;
	}
	
	public static BoardVO selBoard(BoardVO param) {
		BoardVO vo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql =" SELECT i_board, title, ctnt, i_student FROM t_board WHERE i_board = ? ";
		
		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setInt(1, param.getI_board());
			rs = ps.executeQuery();
			
			if (rs.next()) {	 
				String title = rs.getNString("title");
				String ctnt = rs.getNString("ctnt");
				int i_student = rs.getInt("i_student");
				int i_board = rs.getInt("i_board");
				
				vo = new BoardVO();
				
				vo.setI_board(i_board);
				vo.setCtnt(ctnt);
				vo.setI_student(i_student);
				vo.setTitle(title);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con,ps,rs);
		}
		return vo;
		
	public static selWrite() {
		
		BoardVO vo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_student = request.getParameter("i_student"); 
		int i_student = Integer.parseInt(strI_student);
		
		Connection con = null;
		PreparedStatement ps = null;
		
		int result=-1;
		
		String sql = " INSERT INTO t_board (i_board,title,ctnt,i_student) "
					+ " SELECT nvl(max(i_board), 0)+1, ?, ?, ? "
					+ " FROM t_board ";
		try{
			con = getCon();
			ps = con.prepareStatement(sql);	
			ps.setNString(1, title);
			ps.setNString(2, ctnt);
			ps.setInt(3,i_student);
			
			result = ps.executeUpdate();
		
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
		
			if (ps != null) {try {ps.close();} catch (Exception e) {}}
			if (con != null) {try {con.close();} catch (Exception e) {}}
		}
	}
	}
}