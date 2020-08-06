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

		String sql = " SELECT i_board, title FROM t_board ORDER BY i_board DESC ";

		try {
			con = DbCon.getCon();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();

			while(rs.next()) {
				//줄을 가리킬때 값이 있으면 true 없으면 false
				int i_board = rs.getInt("i_board");
				String title = rs.getNString("title");
				BoardVO vo = new BoardVO();
				vo.setI_board(i_board);
				vo.setTitle(title);

				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbCon.close(con,ps,rs);
		}
		return list;
	}

}