package jp.co.kissco.vo;

public class User_reportVo {
	private String user_id;
	private int report_id;
	public User_reportVo() {
		// TODO Auto-generated constructor stub
	}
	public User_reportVo(String user_id, int report_id) {
		super();
		this.user_id = user_id;
		this.report_id = report_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getReport_id() {
		return report_id;
	}
	public void setReport_id(int report_id) {
		this.report_id = report_id;
	}
	@Override
	public String toString() {
		return "User_reportVo [user_id=" + user_id + ", report_id=" + report_id
				+ "]";
	}
	
}
