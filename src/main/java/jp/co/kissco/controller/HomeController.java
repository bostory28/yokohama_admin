package jp.co.kissco.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;



import javax.servlet.http.HttpSession;

import jp.co.kissco.dao.AdminInterfaceDao;
import jp.co.kissco.dao.AppInterfaceDao;
import jp.co.kissco.util.PageNavigator;
import jp.co.kissco.vo.JoinTesteeVo;
import jp.co.kissco.vo.PaymentVo;
import jp.co.kissco.vo.UsersReportsVo;
import jp.co.kissco.vo.UsersVo;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	String array = null;//整列用パラメータ
	String text = null;	//検索キーワード
	String select = null; //検索フィルター
	String startdate = null; //日付検索キーワード
	String enddate = null;//日付検索キーワード
	String stateSelect = null;
	@Autowired
	private SqlSession sqlSession;
	int state = 0; //初めにローディングしたとき申請のページに移動
	int currentpage = 1;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	//ネイゲイションを押した時、管理者ページに移動
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String admin(Model model, PageNavigator pagenavigator,HttpServletRequest request,HttpSession session) throws Exception{
		array = null;
		text = null;
		select =null;
		session = request.getSession();
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		if(user.getAdmin()!=2){//特別管理者がない場合ログインページに移動
			return "redirect:/login";
		}
		pagenavigator.setCurrentPage(currentpage);
		list(pagenavigator, admininterfacedao, request, model); 
		model.addAttribute("isUser", user.getAdmin());
		return "admin";
	}
	//管理者ページにページングをしたり検索する時実行
	@RequestMapping(value = "/againadmin", method = RequestMethod.GET)
	public String againadmin(Model model, PageNavigator pagenavigator,HttpServletRequest request,HttpSession session,@RequestParam("currentPage")int pk) throws Exception{
		session = request.getSession();
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		if(user.getAdmin()!=2){//特別管理者がない場合ログインページに移動
			return "redirect:/login";
		}
		if(Integer.parseInt(request.getParameter("currentPage"))==1){//ページング番号を確認
		pagenavigator.setCurrentPage(currentpage);}
		else{
			pagenavigator.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		//検索用キーワードと整列用パラメータを読み込む
		array = request.getParameter("array");
		text = request.getParameter("text");
		select = request.getParameter("select");
		list(pagenavigator, admininterfacedao, request, model); 
		//管理者を区分するためにパラメータを貯蔵
		model.addAttribute("isUser", user.getAdmin());
		return "admin";
	}
	//ネイゲイションを押した時、決済ページに移動
	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public String payment(Model model, PageNavigator pagenavigator,HttpServletRequest request,HttpSession session) throws Exception{
		array = null;
		text = null;
		startdate= null;
		enddate= null;
		select =null;
		stateSelect = null;
		session = request.getSession();
		String ids = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo users = admininterfacedao.oneMember(ids);
		if(users==null){//ログインを確認してログインしなかった場合ログインページに移動
			return "redirect:/login";
		}
		pagenavigator.setCurrentPage(1);
		paylist(pagenavigator, admininterfacedao, request, model); 
		model.addAttribute("isUser", users.getAdmin());
		return "PayView";
	}
	/*pay LIST */
	public void paylist(PageNavigator pagenavigator,AdminInterfaceDao admin, HttpServletRequest request, Model model) {
		if (array == null) {
			array = "report_id DESC";
		}
		String[] arraysplit = array.split(" ");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("filter", select); 
		if(select!=null&&select.equals("statePay")){
			map.put("text", stateSelect);	
		}
		else if(select!=null&&select.equals("payMeans")){
			map.put("text", stateSelect);
		}
		else{
			map.put("text", text);
		}
		map.put("startdate", startdate);
		map.put("enddate",enddate);
		int totalRecordsCount = admin.getTotalPayCount(map);
		if (totalRecordsCount != 0) {//データがない場合
			pagenavigator = new PageNavigator(pagenavigator.getCountPerPage(), pagenavigator.getPagePerGroup(), pagenavigator.getCurrentPage(), totalRecordsCount);
			map.put("startRecord", pagenavigator.getStartRecord());
			map.put("countPerPage", pagenavigator.getCountPerPage());
			map.put("array", arraysplit[0]);
			if (arraysplit.length == 2) {
				map.put("arrayOrder", arraysplit[1]);
			}
			ArrayList<PaymentVo> appList = null;
			appList = admin.getPayRecord(map);
			/* value of paging and category  */
			model.addAttribute("appList", appList);
			model.addAttribute("currentPage", pagenavigator.getCurrentPage());
			model.addAttribute("startPageGroup", pagenavigator.getStartPageGroup());
			model.addAttribute("endPageGroup", pagenavigator.getEndPageGroup());
			model.addAttribute("currentGroup", pagenavigator.getCurrentGroup());
			model.addAttribute("totalGroup", (pagenavigator.getTotalRecordsCount()-1)/(pagenavigator.getCountPerPage()*pagenavigator.getPagePerGroup()));
			model.addAttribute("array", array);
			model.addAttribute("select", select);
			model.addAttribute("text", text);
			model.addAttribute("startdate", startdate);
			model.addAttribute("enddate", enddate);
			model.addAttribute("stateSelect",stateSelect);
		}
	}
	//決済ページにページングをしたり検索する時実行
	@RequestMapping(value = "/againpay", method = RequestMethod.GET)
	public String againpay(Model model, PageNavigator pagenavigator,HttpServletRequest request,HttpSession session,@RequestParam("currentPage")int pk) throws Exception{
		session = request.getSession();
		String ids = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo users = admininterfacedao.oneMember(ids);
		if(users==null){return "redirect:/login";}
		if(Integer.parseInt(request.getParameter("currentPage"))==1){//ページング番号を確認
			pagenavigator.setCurrentPage(currentpage);
		}
		else{
				pagenavigator.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		//検索用キーワードと整列用パラメータを読み込む
		array = request.getParameter("array");
		text = request.getParameter("text");
		select = request.getParameter("select");
		startdate = request.getParameter("startdate");
		enddate = request.getParameter("enddate");
		stateSelect = request.getParameter("stateSelect");
		System.out.println(stateSelect);
		paylist(pagenavigator, admininterfacedao, request, model); 
		model.addAttribute("isUser", users.getAdmin());
		return "PayView";
	}
	//ネイゲイションを押した時、受験者ページに移動
	@RequestMapping(value = "/testee", method = RequestMethod.GET)
	public String testee(Model model, PageNavigator pagenavigator,HttpServletRequest request,HttpSession session) throws Exception{
		array = null;
		text = null;
		select =null;
		session = request.getSession();
		String ids = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo users = admininterfacedao.oneMember(ids);
		if(users==null){//ログインを確認してログインしなかった場合ログインページに移動
			return "redirect:/login";
		}
		pagenavigator.setCurrentPage(1);
		testeelist(pagenavigator, admininterfacedao, request, model); 
		model.addAttribute("isUser", users.getAdmin());
		return "testee";
	}
	//受験者ページにページングをしたり検索する時実行
	@RequestMapping(value = "/againtestee", method = RequestMethod.GET)
	public String againtestee(Model model, PageNavigator pagenavigator,HttpServletRequest request,HttpSession session,@RequestParam("currentPage")int pk) throws Exception{
		session = request.getSession();
		String ids = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo users = admininterfacedao.oneMember(ids);
		if(users==null){return "redirect:/login";}//ログインを確認してログインしなかった場合ログインページに移動
		if(Integer.parseInt(request.getParameter("currentPage"))==1){//ページング番号を確認
			pagenavigator.setCurrentPage(currentpage);
		}
		else{
				pagenavigator.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		//検索用キーワードと整列用パラメータを読み込む
		array = request.getParameter("array");
		text = request.getParameter("text");
		select = request.getParameter("select");
		testeelist(pagenavigator, admininterfacedao, request, model); 
		model.addAttribute("isUser", users.getAdmin());
		return "testee";
	}
	/*ADMIN LIST */
	public void list(PageNavigator pagenavigator,AdminInterfaceDao admin, HttpServletRequest request, Model model) {
		if (array == null) {
			array = "kanji_name DESC";
		}
		String[] arraysplit = array.split(" ");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("filter", select);
		map.put("text", text); 
		int totalRecordsCount = admin.getTotalRecordCount(map);
		if (totalRecordsCount != 0) {//データがない場合
			pagenavigator = new PageNavigator(pagenavigator.getCountPerPage(), pagenavigator.getPagePerGroup(), pagenavigator.getCurrentPage(), totalRecordsCount);
			map.put("startRecord", pagenavigator.getStartRecord());
			map.put("countPerPage", pagenavigator.getCountPerPage());
			map.put("array", arraysplit[0]);
		
			if (arraysplit.length == 2) {
				map.put("arrayOrder", arraysplit[1]);
			}
			
			ArrayList<UsersVo> appList = null;
			appList = admin.getPagingRecord(map);
			/* value of paging and category  */
			model.addAttribute("appList", appList);
			model.addAttribute("currentPage", pagenavigator.getCurrentPage());
			model.addAttribute("startPageGroup", pagenavigator.getStartPageGroup());
			model.addAttribute("endPageGroup", pagenavigator.getEndPageGroup());
			model.addAttribute("currentGroup", pagenavigator.getCurrentGroup());
			model.addAttribute("totalGroup", (pagenavigator.getTotalRecordsCount()-1)/(pagenavigator.getCountPerPage()*pagenavigator.getPagePerGroup()));
			model.addAttribute("array", array);

			model.addAttribute("select", select);
			model.addAttribute("text", text);
		}
	}
	
	/*testee LIST */
	public void testeelist(PageNavigator pagenavigator,AdminInterfaceDao admin, HttpServletRequest request, Model model) {
		if (array == null) {
			array = "name DESC";
		}
		String[] arraysplit = array.split(" ");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("filter", select);
		map.put("text", text); 
		int totalRecordsCount = admin.getTotalTesteeCount(map);
		if (totalRecordsCount != 0) {//データがない場合
			pagenavigator = new PageNavigator(pagenavigator.getCountPerPage(), pagenavigator.getPagePerGroup(), pagenavigator.getCurrentPage(), totalRecordsCount);
			map.put("startRecord", pagenavigator.getStartRecord());
			map.put("countPerPage", pagenavigator.getCountPerPage());
			map.put("array", arraysplit[0]);
			if (arraysplit.length == 2) {
				map.put("arrayOrder", arraysplit[1]);
			}			
			ArrayList<JoinTesteeVo> appList = null;
			appList = admin.getJoinPagingRecord(map);
			/* value of paging and category  */
			model.addAttribute("appList", appList);
			model.addAttribute("currentPage", pagenavigator.getCurrentPage());
			model.addAttribute("startPageGroup", pagenavigator.getStartPageGroup());
			model.addAttribute("endPageGroup", pagenavigator.getEndPageGroup());
			model.addAttribute("currentGroup", pagenavigator.getCurrentGroup());
			model.addAttribute("totalGroup", (pagenavigator.getTotalRecordsCount()-1)/(pagenavigator.getCountPerPage()*pagenavigator.getPagePerGroup()));
			model.addAttribute("array", array);
			model.addAttribute("select", select);
			model.addAttribute("text", text);
		}
	} 
	//管理者追加ページ
	@RequestMapping(value="/addAdmin", method = RequestMethod.GET)
	public String addAdmin(HttpServletRequest request, Model model,HttpSession session) {
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		if(user.getAdmin()!=2){//特別管理者がない場合ログインページに移動
			return "redirect:/login";
		}
		return "addAdmin";
	}
	//マイページ
	@RequestMapping(value="/mypage", method = RequestMethod.GET)
	public String mypage(HttpServletRequest request, Model model, HttpSession session) {
		setState(5);
		session = request.getSession();
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		if(user==null)return "redirect:/login";//ログインを確認してログインしなかった場合ログインページに移動
		model.addAttribute("state", getState());
		model.addAttribute("user",user);
		model.addAttribute("isUser", user.getAdmin());
		return "mypage";
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getCurrentpage() {
		return currentpage;
	}
	public void setCurrentpage(int currentpage) {
		this.currentpage = currentpage;
	}
	

}
