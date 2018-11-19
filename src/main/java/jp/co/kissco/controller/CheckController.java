package jp.co.kissco.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jp.co.kissco.dao.AdminInterfaceDao;
import jp.co.kissco.util.PageNavigator;
import jp.co.kissco.vo.PaymentVo;
import jp.co.kissco.vo.UsersVo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CheckController {
	@Autowired
	private SqlSession sqlSession;
	int state = 0;
	int currentpage = 1;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	//決済情報を変更ページに移動
	@RequestMapping(value = "/checkPay", method = RequestMethod.GET)
	public String checkPay(Locale locale, Model model,@RequestParam("rid")String rid,HttpSession session,HttpServletRequest request) {
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		PaymentVo vo =admininterfacedao.checkpay(Integer.valueOf(rid));
		model.addAttribute("vo",vo);
		session = request.getSession();
		String id = (String)session.getAttribute("identity");
		UsersVo user = admininterfacedao.oneMember(id);
		model.addAttribute("isUser", user.getAdmin());
		return "checkPay";
	}
	//決済情報を変更
	@RequestMapping(value = "/editpay", method = RequestMethod.POST)
	public String editPay(Locale locale, Model model,HttpServletRequest request,PageNavigator pagenavigator,HttpSession session) {
		int id = Integer.valueOf(request.getParameter("hidden"));
		String means = (String)request.getParameter("radio");
		String state = (String)request.getParameter("radio1");
		PaymentVo vo = new PaymentVo();
		vo.setReport_id(id);
		if(state.equals("Y")){//完納をクリックする時
			vo.setIspayed(true);
			vo.setReport_state(1);
			vo.setMeans(means);
		}
		else{//未納をクリックする時
			vo.setIspayed(false);
			vo.setReport_state(0);
			vo.setMeans(null);
			vo.setDeposit_date(null);
		}
		AdminInterfaceDao admininterfacedao = sqlSession.getMapper(AdminInterfaceDao.class);
		admininterfacedao.editpay(vo);
		admininterfacedao.editreportstate(vo);
		String ids = (String)session.getAttribute("identity");
		UsersVo users = admininterfacedao.oneMember(ids);
		if(users==null){//ログインを確認してログインしなかった場合ログインページに移動
			return "redirect:/login";
		}
		pagenavigator.setCurrentPage(1);
		HomeController home = new HomeController();
		home.paylist(pagenavigator, admininterfacedao, request, model); 
		model.addAttribute("isUser", users.getAdmin());
		return "PayView";
	}
}
