package jp.co.kissco.dao;

import java.util.ArrayList;
import java.util.HashMap;

import jp.co.kissco.vo.JoinTesteeVo;
import jp.co.kissco.vo.PaymentVo;
import jp.co.kissco.vo.UsersReportsVo;
import jp.co.kissco.vo.UsersVo;

public interface AdminInterfaceDao {
	public ArrayList<UsersVo> adminlist();
	public UsersVo oneMember(String id);
	public ArrayList<JoinTesteeVo> testeelist();
	public void edit (UsersVo user);
	public void add (UsersVo user);
	public void editmypage (UsersVo user);
	public void editpw (UsersVo user);
	public int getTotalRecordCount(HashMap<String, Object> map);
	public int getTotalTesteeCount(HashMap<String, Object> map);
	public ArrayList<UsersVo> getPagingRecord(HashMap<String, Object> map);
	public ArrayList<JoinTesteeVo> getJoinPagingRecord(HashMap<String, Object> map);
	public int getTotalPayCount(HashMap<String, Object> map);
	public ArrayList<PaymentVo> getPayRecord(HashMap<String,Object>map);
	public void editpay (PaymentVo vo);
	public void editreportstate (PaymentVo vo);
	public void delAdmin(UsersVo user);
	public PaymentVo checkpay(int rid);
}
