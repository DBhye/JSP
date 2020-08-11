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

			while (rs.next()) {
				// 줄을 가리킬때 값이 있으면 true 없으면 false
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
			DbCon.close(con, ps, rs);
		}
		return list;
	}

	public static BoardVO selBoard(BoardVO param) {
		BoardVO vo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = " SELECT i_board, title, ctnt, i_student FROM t_board WHERE i_board = ? ";

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
			DbCon.close(con, ps, rs);
		}
		return vo;
	}

	public static int insBoard(BoardVO param) {

		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;

		String sql = " INSERT INTO t_board "
					+ " (i_board, title, ctnt, i_student) "
					+ " VALUES "
					+ " (seq_board.nextval, ?, ?, ?) ";

		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setNString(1, param.getTitle());
			ps.setNString(2, param.getCtnt());
			ps.setInt(3, param.getI_student());

			result = ps.executeUpdate(); // select 때만 excuteQuery
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps);
		}

		return result; // resultset은 select일때만 필요하다.
						// 지금은 정수값만 받아온다.
						// 행을 삭제한다던지, 행을 삽입하는 작업에는 데이터를 데려와서 저장하는것이 불필요.
						// sql문 create sequence seq_board; (시퀀스란? 순차적으로 증가하는 순번을 반환하는 데이터베이스 객체)
						// select seq_board.nextval from dual;(1씩 올라간다.)
	}

	public static int doDel(BoardVO param) { //파라미터로 int i_board를 바로 받아줘도 된다.
		int result = 0;
		Connection con = null;
		PreparedStatement ps = null;

		String sql = " DELETE FROM t_board " + " WHERE i_board = ? ";

		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			ps.setInt(1, param.getI_board());

			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con, ps);
		}

		return result;

	}
}