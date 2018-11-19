package jp.co.kissco.vo;

public class ReportsVo {
	private int id;
	private String report;
	private String name;
	private int state;
	private String modified_at;
	private String created_at;
	public ReportsVo() {
		// TODO Auto-generated constructor stub
	}
	public ReportsVo(int id, String report, String name, int state,
			String modified_at, String created_at) {
		super();
		this.id = id;
		this.report = report;
		this.name = name;
		this.state = state;
		this.modified_at = modified_at;
		this.created_at = created_at;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getReport() {
		return report;
	}
	public void setReport(String report) {
		this.report = report;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getModified_at() {
		return modified_at;
	}
	public void setModified_at(String modified_at) {
		this.modified_at = modified_at;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	@Override
	public String toString() {
		return "ReportsVo [id=" + id + ", report=" + report + ", name=" + name
				+ ", state=" + state + ", modified_at=" + modified_at
				+ ", created_at=" + created_at + "]";
	}
	
	
	
}
