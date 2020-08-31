package com.koreait.pjt.user;

import java.io.IOException;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import java.io.*;

@WebServlet("/user/profile")
public class profileSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   // 프로필 화면(나의 프로필 이미지, 이미지 변경가능한 화면)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		request.setAttribute("data", UserDAO.selUser(loginUser.getI_user()));
		ViewResolver.forward("/user/profile", request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		String savePath = request.getSession().getServletContext().getRealPath("img")+"/user/" + loginUser.getI_user(); //저장경로
		System.out.println("save Path : " + savePath);
		
		File directory = new File(savePath);
		
		if(!directory.exists()) {
			directory.mkdirs();
		}
	
		int maxFileSize = 10_485_760; //(자릿수 보기 편하도록) //최대 파일 사이즈 크기
		String fileNm="";
		String originFileNm = "";
		String saveFileNm=null;
		
		try {
			MultipartRequest mr = new MultipartRequest(request, savePath
					, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		
				Enumeration files = mr.getFileNames();
				
				if(files.hasMoreElements()) {
					
				String key = (String)files.nextElement();
				fileNm = mr.getFilesystemName(key);
				//originFileNm = mr.getOriginalFileName(key);
				String ext = fileNm.substring(fileNm.lastIndexOf("."));
				saveFileNm = UUID.randomUUID() + ext;
				
				
				System.out.println("key : " + key);
				System.out.println("fileNm : " + fileNm);
				System.out.println("originalFileNm : " + originFileNm);
				File oldFile = new File(savePath + "/" + fileNm);
				File newFile = new File(savePath + "/" + saveFileNm); //자바메모리상에 파일객체를 만들어준것이다.
				oldFile.renameTo(newFile);
				}
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(saveFileNm != null) {
			//DB에 프로필 파일명 저장
			
			UserVO param = new UserVO();
			param.setProfile_img(saveFileNm);
			param.setI_user(loginUser.getI_user());
			 UserDAO.updUser(param);

			//i_user, user_id(3) of nm
			//처리는 정수값으로 하는것이 좋다. 인트값이 속도가 더 빠르기 때문이다.
			
		}
		response.sendRedirect("/user/profile");

	}  
	
}
