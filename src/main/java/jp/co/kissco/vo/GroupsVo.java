package jp.co.kissco.vo;

public class GroupsVo {
	private String id;
	private String name;
	private String repo_id;
	private String repo_pass;
	private String modified_at;
	private String created_at;
	private String repo_url;
	public GroupsVo() {
		// TODO Auto-generated constructor stub
	}
	public GroupsVo(String id, String name, String repo_id, String repo_pass,
			String modified_at, String created_at, String repo_url) {
		super();
		this.id = id;
		this.name = name;
		this.repo_id = repo_id;
		this.repo_pass = repo_pass;
		this.modified_at = modified_at;
		this.created_at = created_at;
		this.repo_url = repo_url;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRepo_id() {
		return repo_id;
	}
	public void setRepo_id(String repo_id) {
		this.repo_id = repo_id;
	}
	public String getRepo_pass() {
		return repo_pass;
	}
	public void setRepo_pass(String repo_pass) {
		this.repo_pass = repo_pass;
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
	public String getRepo_url() {
		return repo_url;
	}
	public void setRepo_url(String repo_url) {
		this.repo_url = repo_url;
	}
	@Override
	public String toString() {
		return "GroupsVo [id=" + id + ", name=" + name + ", repo_id=" + repo_id
				+ ", repo_pass=" + repo_pass + ", modified_at=" + modified_at
				+ ", created_at=" + created_at + ", repo_url=" + repo_url + "]";
	}
	
}
