package com.koreait.matzip.restaurant;

import javax.servlet.http.HttpServletRequest;

import com.koreait.matzip.CommonDAO;
import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.Const;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.vo.RestaurantRecommendMenuVO;
import com.koreait.matzip.vo.RestaurantVO;
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
		final int I_M = 1; // 카테고리 코드
		request.setAttribute("categoryList", CommonDAO.selCodeList(I_M));

		request.setAttribute(Const.TITLE, "가게 등록");
		request.setAttribute(Const.VIEW, "restaurant/restReg");
		return ViewRef.TEMP_MENU_TEMP;
	}

	public String restRegProc(HttpServletRequest request) {
		String nm = request.getParameter("nm");
		String addr = request.getParameter("addr");
		double lat = CommonUtils.getDoubleParameter("lat", request);
		double lng = CommonUtils.getDoubleParameter("lng", request);
		int cd_category = CommonUtils.getIntParameter("cd_category", request);

		System.out.println("nm: " + nm);
		System.out.println("addr: " + addr);
		System.out.println("lat: " + lat);
		System.out.println("lng: " + lng);
		System.out.println("nm: " + nm);

		UserVO loginUser = SecurityUtils.getLoginUser(request);

		RestaurantVO param = new RestaurantVO();
		param.setNm(nm);
		param.setAddr(addr);
		param.setLat(lat);
		param.setLng(lng);
		param.setI_user(loginUser.getI_user());
		param.setCd_category(cd_category);

		int result = service.restReg(param);

		return "redirect:/restaurant/restMap";
	}
	public String ajaxGetList(HttpServletRequest request) {
		return "ajax:" + service.getRestList();
	}

	public String restDetail(HttpServletRequest request) {
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		
		RestaurantVO param = new RestaurantVO();
		param.setI_rest(i_rest);
		
		request.setAttribute("css", new String[] {"restaurant"});
		request.setAttribute("recommendMenuList", service.getRecommendMenuList(i_rest));
		request.setAttribute("data", service.getRest(param));
		request.setAttribute(Const.TITLE, "디테일");
		request.setAttribute(Const.VIEW, "restaurant/restDetail");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String addRecMenusProc(HttpServletRequest request) {//서비스에 넘겨줬다.
		int i_rest = service.addRecMenus(request);
		return "redirect:/restaurant/restDetail?i_rest=" + i_rest; //모든자료 요청(모든 정보들이 리퀘스트에 담겨있다)
	}
	
	public String ajaxDelRecMenu(HttpServletRequest request) {
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		int seq = CommonUtils.getIntParameter("seq", request);
		
		RestaurantRecommendMenuVO param = new RestaurantRecommendMenuVO();
		param.setI_rest(i_rest);
		param.setSeq(seq);
		
		int result = service.delRecMenu(param);
		
		return "ajax: " +result;
	}
}