package jp.co.kissco.vo;

public class Report_dataVo {
	private int id;
	private String major1;
	private String major2;
	private String major3;
	public Report_dataVo() {
		// TODO Auto-generated constructor stub
	}
	public Report_dataVo(int id, String major1, String major2, String major3) {
		super();
		this.id = id;
		this.major1 = major1;
		this.major2 = major2;
		this.major3 = major3;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMajor1() {
		return major1;
	}
	public void setMajor1(String major1) {
		this.major1 = major1;
	}
	public String getMajor2() {
		return major2;
	}
	public void setMajor2(String major2) {
		this.major2 = major2;
	}
	public String getMajor3() {
		return major3;
	}
	public void setMajor3(String major3) {
		this.major3 = major3;
	}
	@Override
	public String toString() {
		return "Report_dataVo [id=" + id + ", major1=" + major1 + ", major2="
				+ major2 + ", major3=" + major3 + "]";
	}
	
}
