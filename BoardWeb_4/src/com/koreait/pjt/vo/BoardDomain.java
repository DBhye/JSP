package com.koreait.pjt.vo;

public class BoardDomain extends BoardVO{
	private String nm;
	private int yn_like;
	private String cmt;
	private int i_cmt;
	
	public int getI_cmt() {
		return i_cmt;
	}

	public void setI_cmt(int i_cmt) {
		this.i_cmt = i_cmt;
	}

	public String getCmt() {
		return cmt;
	}

	public void setCmt(String cmt) {
		this.cmt = cmt;
	}

	public String getNm() {
		return nm;
	}

	public void setNm(String nm) {
		this.nm = nm;
	}

	public int getYn_like() {
		return yn_like;
	}

	public void setYn_like(int yn_like) {
		this.yn_like = yn_like;
	}

	
}
