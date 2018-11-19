package jp.co.kissco.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jp.co.kissco.dao.AdminInterfaceDao;
import jp.co.kissco.dao.AppInterfaceDao;
import jp.co.kissco.dao.MemberInterfaceDao;
import jp.co.kissco.util.ConvertToPDF;
import jp.co.kissco.util.PageNavigator;
import jp.co.kissco.util.SendMail;
import jp.co.kissco.vo.UsersReportsVo;
import jp.co.kissco.vo.UsersVo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import java.io.File;
import java.util.Hashtable;
import java.io.FileOutputStream;

@Controller
public class DocumentController extends InternalResourceViewResolver  {
	
	@Autowired
	private SqlSession sqlSession;
	int state = 1;									//初めにローディングしたとき申請のページに移動
	String category = "すべて";						//申請、不備、完了のcategoryの基本値
	String array = null;					 	//
	String text = null;	//検索キーワード
	String select = null; //検索フィルター
	String startdate = null; //日付検索キーワード
	String enddate = null;//日付検索キーワード
	@RequestMapping(value = "/login")
	public String login() {
		return "home";
	}
	
	/*　ログイン処理　*/
	@RequestMapping(value = "/loginSucc", method = RequestMethod.POST)
	public String loginProcess(UsersVo user, HttpSession session, Model model, RedirectAttributes redirectAttr) {
		MemberInterfaceDao memberinterfacedao = sqlSession.getMapper(MemberInterfaceDao.class);
		user = memberinterfacedao.oneOfMember(user);
		if (memberinterfacedao.oneOfMember(user) == null) {
			redirectAttr.addFlashAttribute("loginResult", "fail");
			return "redirect:/login";
		}
		//IDをsessionにセーブ
		session.setAttribute("identity", user.getId());
		model.addAttribute("isUser", user.getAdmin());
		model.addAttribute("currentPage", 1);
		return "loadingView";
	}
	
	/*　申請、不備、完了　*/
	@RequestMapping(value = "/appDoc", method = RequestMethod.POST)
	public String appDoc(PageNavigator pagenavigator, HttpServletRequest request, Model model,HttpSession session) {
		AppInterfaceDao appinterfaceaao = sqlSession.getMapper(AppInterfaceDao.class);
		if (request.getParameter("category") != "") {
			category = request.getParameter("category");
		}
		if (request.getParameter("state") != null) {
			state = Integer.parseInt(request.getParameter("state"));
		}
		array = request.getParameter("array"); 
		text = request.getParameter("text");
		select = request.getParameter("select");
		startdate = request.getParameter("startdate");
		enddate = request.getParameter("enddate");
		session = request.getSession();
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		model.addAttribute("isUser", user.getAdmin());
		/* list */ 
		pagenavigator.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		list(pagenavigator, appinterfaceaao, request, model,session);
		return request.getParameter("viewName");
	}
	
	/*　申請で確認,修正PROCESS*/
	@RequestMapping(value = "/appIssuffDoc", method = RequestMethod.POST)
	public String appIssuffDoc(PageNavigator pagenavigator, MultipartHttpServletRequest  request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
		AppInterfaceDao appinterfaceaao = sqlSession.getMapper(AppInterfaceDao.class);
		if (request.getParameter("category") != "") {
			category = request.getParameter("category");
		}
		state = Integer.parseInt(request.getParameter("state"));
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("changeState", Integer.parseInt(request.getParameter("changeState")));
		map.put("rid", Integer.parseInt(request.getParameter("rid")));
		map.put("adminid", session.getAttribute("identity"));
		appinterfaceaao.updateDocState(map);
		appinterfaceaao.updateConfirmAdmin(map);
		session = request.getSession();
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		model.addAttribute("isUser", user.getAdmin());
		/* PDF変換そしてemail送る　*/
		int changeState = Integer.parseInt(request.getParameter("changeState"));		//変更されるSTATEの番号
		String r_id = request.getParameter("rid");										//願書の番号
		String recipient = request.getParameter("uid");									//メールアドレス
		String subject = request.getParameter("subject");								//メールのタイトル
		String body = request.getParameter("body");										//メールの内容
		String uname = request.getParameter("uname");									//ユーザ名前
		String number = request.getParameter("number");									//受験番号
		MultipartFile uploadedFile = request.getFile("upload");
		
		// isEmpty()はnullをチェックしてくれる
        if(!uploadedFile.isEmpty()) {
            // 파일이 있다면, 업로드된 파일이 저장될 경로 및 파일 이름을 지정한다.
              File file = new File("d:\\", uploadedFile.getOriginalFilename());
            // 물리적인 공간에 저장한다.
            uploadedFile.transferTo(file);
            new SendMail(file, recipient, subject, body);
        	/* list出力 */
    		pagenavigator.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
    		list(pagenavigator, appinterfaceaao, request, model,session);
    		return request.getParameter("viewName");
        }
		switch(changeState) {
		case 2:
			//修正の時email送る
			new SendMail(recipient ,changeState, subject, body);
			break;
		case 3:
			//PDF変換
			new ConvertToPDF(r_id, number, uname, request, response);
			//完了の時email送る
			new SendMail(recipient ,changeState, uname);
			break;
		}
		/* list出力 */
		pagenavigator.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		list(pagenavigator, appinterfaceaao, request, model,session);
		return request.getParameter("viewName");
	}
	
	/*　ユーザのメールを直接クッリク時メールを送る　*/
	@RequestMapping(value = "/sendPersonalMail", method = RequestMethod.POST)
	public ModelAndView  sendPersonalMail(PageNavigator pagenavigator, HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		new SendMail(request.getParameter("uid"), 2, request.getParameter("subject"), request.getParameter("body"));
		return modelAndView;
	}
	
	@RequestMapping(value = "/sendModifiedOZD", method = RequestMethod.POST)
	public ModelAndView  sendModifiedOZD(PageNavigator pagenavigator, HttpServletRequest request, HttpServletResponse response, Model model) {
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		String sort = request.getParameter("sort");
		String rid = request.getParameter("rid");
		String number = request.getParameter("number");
		String kanji_name = request.getParameter("kanji_name");
		new ConvertToPDF(rid,sort, number, kanji_name, request, response);
		
		AppInterfaceDao appinterfaceaao = sqlSession.getMapper(AppInterfaceDao.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("changeState", 2);
		map.put("rid", Integer.parseInt(request.getParameter("rid")));
		map.put("adminid", request.getParameter("session"));
		map.put("modifiedozd", "http://192.168.1.51:9999/kissco/ozd_file/"+number+".ozd");
		
		appinterfaceaao.updateDocState(map);
		appinterfaceaao.updateOZD(map);
		appinterfaceaao.updateConfirmAdmin(map);
		
		String recipient = request.getParameter("uid");									//メールアドレス
		String subject = request.getParameter("subject");								//メールのタイトル
		String body = request.getParameter("body");										//メールの内容
		new SendMail(recipient ,2, subject, body);
		return modelAndView;
	}
	
	/* OZ FORM接続(現在のページで画面転換)　 */
	/*@RequestMapping(value = "/appForm", method = RequestMethod.POST)
	public String appForm(HttpServletRequest request, Model model) throws Exception {
		String rid = request.getParameter("rid");
		String sort = request.getParameter("sort");
		return "redirect:http://192.168.1.25:9999/kissco/oz/sample.html?sort="+ sort + "&rid="+rid ;
	}*/
	
	/* LIST */
	public void list(PageNavigator pagenavigator, AppInterfaceDao appinterfaceaao, HttpServletRequest request, Model model,HttpSession session) {
		if (array == null) {
			array = "rid DESC";
		}
		String[] arraysplit = array.split(" ");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("state", state);
		map.put("filter", select);
		map.put("text", text);
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		int totalRecordsCount;
		if(select!=null&&select.equals("resposible")){
			totalRecordsCount = appinterfaceaao.getTotalRecordCount2(map);
		}
		else{   
			totalRecordsCount = appinterfaceaao.getTotalRecordCount(map);
		}
		if (totalRecordsCount != 0) {
			pagenavigator = new PageNavigator(pagenavigator.getCountPerPage(), pagenavigator.getPagePerGroup(), pagenavigator.getCurrentPage(), totalRecordsCount);
			map.put("startRecord", pagenavigator.getStartRecord());
			map.put("countPerPage", pagenavigator.getCountPerPage());
			map.put("array", arraysplit[0]);
			if (arraysplit.length == 2) {
				map.put("arrayOrder", arraysplit[1]);
			}
			ArrayList<UsersReportsVo> appList = null;
			switch (state) {
			//申請の場合list持ってくる  
			case 1:
				appList = appinterfaceaao.getPagingRecord(map);
				break;
			//不備の場合,完了の場合
			default:
				appList = appinterfaceaao.getsuffOrInsuffPagingRecord(map);
				break;
			}
			System.out.println(appList);
			session = request.getSession();
			String id = (String)session.getAttribute("identity");
			AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
			UsersVo user = admininterfacedao.oneMember(id);
			model.addAttribute("isUser", user.getAdmin());
			/* value of paging and category(JSPに渡すデータ)  */
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
			model.addAttribute("session", id);
		}
		model.addAttribute("category", request.getParameter("category"));
	}
	
	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
	
}

