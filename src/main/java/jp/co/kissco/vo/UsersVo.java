package jp.co.kissco.vo;

import java.util.Date;

public class UsersVo {
	String id;
	String pass;
	String kanji_name;
	String kana_name;
	int admin;
	boolean is_active;
	Date last_login;
	Date created_at;
	String group_id;
	String activation_key;
	
	public UsersVo() {
		super();
	}
	
	public UsersVo(String id, String pass, String kanji_name, String kana_name,
			int admin, boolean is_active, Date last_login, Date created_at,
			String group_id, String activation_key) {
		super();
		this.id = id;
		this.pass = pass;
		this.kanji_name = kanji_name;
		this.kana_name = kana_name;
		this.admin = admin;
		this.is_active = is_active;
		this.last_login = last_login;
		this.created_at = created_at;
		this.group_id = group_id;
		this.activation_key = activation_key;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getKana_name() {
		return kana_name;
	}
	public void setKana_name(String kana_name) {
		this.kana_name = kana_name;
	}
	
	public int getAdmin() {
		return admin;
	}

	public void setAdmin(int admin) {
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
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
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

	@Override
	public String toString() {
		return "UsersVo [id=" + id + ", pass=" + pass + ", kanji_name="
				+ kanji_name + ", kana_name=" + kana_name + ", admin=" + admin
				+ ", is_active=" + is_active + ", last_login=" + last_login
				+ ", created_at=" + created_at + ", group_id=" + group_id
				+ ", activation_key=" + activation_key + "]";
	}
	
}
