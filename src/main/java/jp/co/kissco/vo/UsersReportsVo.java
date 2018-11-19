package jp.co.kissco.vo;

import java.util.Date;

public class UsersReportsVo {
	private String uid;
	private String pass;
	private String kanji_name;
	private String akanji_name;
	private String kana_name;
	private boolean admin;
	private boolean is_active;
	private Date last_login;
	private Date ucreated_at;
	private String group_id;
	private String activation_key;
	
	private int rid;
	private String report;
	private String name;
	private int state;
	private String modified_at;
	private String rcreated_at;
	private String number;
	private String modifiedozd;
	
	private String user_id;
	private int report_id;
	public UsersReportsVo() {
		super();
	}
	public UsersReportsVo(String uid, String pass, String kanji_name,
			String akanji_name, String kana_name, boolean admin,
			boolean is_active, Date last_login, Date ucreated_at,
			String group_id, String activation_key, int rid, String report,
			String name, int state, String modified_at, String rcreated_at,
			String number, String modifiedozd, String user_id, int report_id) {
		super();
		this.uid = uid;
		this.pass = pass;
		this.kanji_name = kanji_name;
		this.akanji_name = akanji_name;
		this.kana_name = kana_name;
		this.admin = admin;
		this.is_active = is_active;
		this.last_login = last_login;
		this.ucreated_at = ucreated_at;
		this.group_id = group_id;
		this.activation_key = activation_key;
		this.rid = rid;
		this.report = report;
		this.name = name;
		this.state = state;
		this.modified_at = modified_at;
		this.rcreated_at = rcreated_at;
		this.number = number;
		this.modifiedozd = modifiedozd;
		this.user_id = user_id;
		this.report_id = report_id;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getKanji_name() {
		return kanji_name;
	}
	public void setKanji_name(String kanji_name) {
		this.kanji_name = kanji_name;
	}
	public String getAkanji_name() {
		return akanji_name;
	}
	public void setAkanji_name(String akanji_name) {
		this.akanji_name = akanji_name;
	}
	public String getKana_name() {
		return kana_name;
	}
	public void setKana_name(String kana_name) {
		this.kana_name = kana_name;
	}
	public boolean isAdmin() {
		return admin;
	}
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
	public boolean isIs_active() {
		return is_active;
	}
	public void setIs_active(boolean is_active) {
		this.is_active = is_active;
	}
	public Date getLast_login() {
		return last_login;
	}
	public void setLast_login(Date last_login) {
		this.last_login = last_login;
	}
	public Date getUcreated_at() {
		return ucreated_at;
	}
	public void setUcreated_at(Date ucreated_at) {
		this.ucreated_at = ucreated_at;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getActivation_key() {
		return activation_key;
	}
	public void setActivation_key(String activation_key) {
		this.activation_key = activation_key;
	}
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
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
	public String getRcreated_at() {
		return rcreated_at;
	}
	public void setRcreated_at(String rcreated_at) {
		this.rcreated_at = rcreated_at;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getModifiedozd() {
		return modifiedozd;
	}
	public void setModifiedozd(String modifiedozd) {
		this.modifiedozd = modifiedozd;
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
		return "UsersReportsVo [uid=" + uid + ", pass=" + pass
				+ ", kanji_name=" + kanji_name + ", akanji_name=" + akanji_name
				+ ", kana_name=" + kana_name + ", admin=" + admin
				+ ", is_active=" + is_active + ", last_login=" + last_login
				+ ", ucreated_at=" + ucreated_at + ", group_id=" + group_id
				+ ", activation_key=" + activation_key + ", rid=" + rid
				+ ", report=" + report + ", name=" + name + ", state=" + state
				+ ", modified_at=" + modified_at + ", rcreated_at="
				+ rcreated_at + ", number=" + number + ", modifiedozd="
				+ modifiedozd + ", user_id=" + user_id + ", report_id="
				+ report_id + "]";
	}
	
	

}
