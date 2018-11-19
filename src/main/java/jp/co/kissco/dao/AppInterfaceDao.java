package jp.co.kissco.dao;

import java.util.ArrayList;
import java.util.HashMap;

import jp.co.kissco.vo.UsersReportsVo;


public interface AppInterfaceDao {
	public int getTotalRecordCount(HashMap<String, Object> map);
	public int getTotalRecordCount2(HashMap<String, Object> map);
	public ArrayList<UsersReportsVo> getPagingRecord(HashMap<String, Object> map);
	public ArrayList<UsersReportsVo> getsuffOrInsuffPagingRecord(HashMap<String, Object> map);
	public int updateDocState(HashMap<String, Object> map);
	public int updateOZD(HashMap<String, Object> map);
	public int insertUserReport(HashMap<String, Object> map);
	public int updateConfirmAdmin(HashMap<String, Object> map);
}
