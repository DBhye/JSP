package com.koreait.matzip.restaurant;

import javax.servlet.http.HttpServletRequest;

import com.koreait.matzip.CommonDAO;
import com.koreait.matzip.Const;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.vo.UserVO;

public class RestaurantController {

	private RestaurantService service; 
	
	public RestaurantController() {
		service = new RestaurantService();
	}
	public String restMap(HttpServletRequest request) {
		request.setAttribute(Const.TITLE, "restmap");
		request.setAttribute(Const.VIEW, "restaurant/restMap");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String restReg(HttpServletRequest request) {
		final int I_M = 1; //카테고리 코드
		request.setAttribute("categoryList", CommonDAO.selCodeList(I_M));
		
		request.setAttribute(Const.TITLE, "가게 등록");
		request.setAttribute(Const.VIEW, "restaurant/restReg");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String restRegProc(HttpServletRequest request) {
		
	UserVO param = SecurityUtils.getLoginUser(request);
	
	String nm = request.getParameter("nm");
	String addr = request.getParameter("addr");
	double lat = Double.parseDouble(request.getParameter("lat"));
	double lng = Double.parseDouble(request.getParameter("lng"));
	int cd_category = Integer.parseInt(request.getParameter("cd_category"));
	int i_user = param.getI_user();
	
	RestaurantVO rest = new RestaurantVO();
	rest.setNm(nm);
	rest.setAddr(addr);
	rest.setLat(lat);
	rest.setLng(lng);
	rest.setCd_category(cd_category);
	rest.setI_user(i_user);
	
	int result = service.restReg(rest);
	return "redirect:/restaurant/restMap";
	}
	public String ajaxGetList(HttpServletRequest request) {
		return "ajax: " + service.getRestList();
	
	}
}
