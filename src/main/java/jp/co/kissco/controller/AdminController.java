package jp.co.kissco.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import jp.co.kissco.dao.AdminInterfaceDao;
import jp.co.kissco.dao.MemberInterfaceDao;
import jp.co.kissco.vo.UsersVo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {
	@Autowired
	private SqlSession sqlSession;
	int state = 0;
	String category = "すべて";
	//管理者追加ページの追加ボタンをクリックする時
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(HttpServletRequest request) {
		UsersVo user = new UsersVo();
		if(request.getParameter("radio").equals("N")){//一般管理者をクリックする時
			user.setAdmin(1);
		}
		else{//特別管理者をクリックする時
			user.setAdmin(2);
		}
		user.setId(request.getParameter("inputId"));
		user.setKanji_name(request.getParameter("name1"));
		user.setKana_name(request.getParameter("name2"));
		user.setPass(request.getParameter("inputPwd"));
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		admininterfacedao.add(user);
		return "redirect:admin";
	}
	//管理者追加ページの追加ボタンをクリックする時重複アイディチェック（AJAX通信用）
	@RequestMapping(value = "/idcheck", method = RequestMethod.POST)
	public ModelAndView idcheck(HttpServletRequest request, @ModelAttribute String admin){
		String id = request.getParameter("id");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		modelAndView.addObject("id",user);
		return modelAndView;
	}
	//暗証番号変更ページの変更ボタンをクリックする時暗証番号をチェック（AJAX通信用）
	@RequestMapping(value = "/pwcheck", method = RequestMethod.POST)
	public ModelAndView pwcheck(HttpServletRequest request, @ModelAttribute String admin,HttpSession session){
		session = request.getSession();
		String pw = request.getParameter("pw");
		UsersVo vo = new UsersVo();
		vo.setPass(pw);
		vo.setId((String)session.getAttribute("identity"));
		MemberInterfaceDao dao = sqlSession.getMapper(MemberInterfaceDao.class);
		UsersVo user = dao.oneOfMember(vo);
		ModelAndView modelAndView = new ModelAndView(new MappingJacksonJsonView());
		modelAndView.addObject("user",user);
		return modelAndView;
	}
	//ログアウト
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, HttpServletRequest request) {
		session = request.getSession();
		if(session.getAttribute("identity")!=null){
			session.removeAttribute("identity");
		}
		return "redirect:/login";
	}
	@RequestMapping(value = "/editAdmin")
	public String editAdmin(HttpSession session, Model model,  HttpServletRequest request, @RequestParam("pk")String pk) {
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo users = admininterfacedao.oneMember(id);
		if(users.getAdmin()!=2){
			return "redirect:/login";
		}
		UsersVo user = admininterfacedao.oneMember(pk);
		model.addAttribute("user",user);
		return "editAdmin";
	}
	//管理者権限を削除
	@RequestMapping(value = "/delAdmin")
	public String delAdmin(HttpSession session, Model model,  HttpServletRequest request, @RequestParam("pk")String pk) {
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo users = admininterfacedao.oneMember(id);
		if(users.getAdmin()!=2){//特別管理者がない場合ログインページに移動
			return "redirect:/login";
		}
		UsersVo user = admininterfacedao.oneMember(pk);
		admininterfacedao.delAdmin(user);
		return  "redirect:/admin";
	}
	//マイページに情報を変更ボタンをクリックする時
	@RequestMapping(value = "/editmypage", method = RequestMethod.POST)
	public String editmypage(HttpSession session, Model model,  HttpServletRequest request) {
		UsersVo vo = new UsersVo();
		vo.setId(request.getParameter("inputId"));
		vo.setKanji_name(request.getParameter("name1"));
		vo.setKana_name(request.getParameter("name2"));
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		admininterfacedao.editmypage(vo);
		UsersVo user = admininterfacedao.oneMember(vo.getId());
		session.setAttribute("identity", user.getId());
		model.addAttribute("isUser", user.getAdmin());
		model.addAttribute("currentPage", 1);
		return "loadingView";
	}
	//暗証番号変更ページに移動
	@RequestMapping(value = "/newPw", method = RequestMethod.POST)
	public String newPw(HttpSession session, Model model,  HttpServletRequest request) {
		UsersVo vo = new UsersVo();
		vo.setId(request.getParameter("inputId"));
		vo.setPass(request.getParameter("inputPwd2"));
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		admininterfacedao.editpw(vo);
		UsersVo user = admininterfacedao.oneMember(vo.getId());
		session.setAttribute("identity", user.getId());
		model.addAttribute("isUser", user.getAdmin());
		model.addAttribute("currentPage", 1);
		return "loadingView";
	}
	//管理者の権限変更
	@RequestMapping(value = "/edit")
	public String edit(HttpSession session, Model model,  HttpServletRequest request, @RequestParam("inputPwd")String apk, @RequestParam("inputId")String pk,@RequestParam("radio")String radio) {
		String id = (String)session.getAttribute("identity");
		
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo users = admininterfacedao.oneMember(id);
		if(users.getAdmin()!=2){//特別管理者がない場合ログインページに移動
			return "redirect:/login";
		}
		UsersVo user = new UsersVo();
		user.setId(pk);
		user.setPass(apk);
		if(radio.equals("N")){//特別管理者をクリックする時
			user.setAdmin(2);
		}
		else{//一般管理者をクリックする時
			user.setAdmin(1);
		}
		admininterfacedao.edit(user);
		return "redirect:/admin";
	}
	//暗証番号変更
	@RequestMapping(value = "/editPw")
	public String editPw(HttpSession session, Model model,  HttpServletRequest request){
		session = request.getSession();
		String id = (String)session.getAttribute("identity");
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		UsersVo user = admininterfacedao.oneMember(id);
		if(user==null)return "redirect:/login";//ログインを確認してログインしなかった場合ログインページに移動
		model.addAttribute("isUser", user.getAdmin());
		model.addAttribute("userId", id);
		return "editPw";
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
}
