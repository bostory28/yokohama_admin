package jp.co.kissco.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		
		if (session == null) {
			response.sendRedirect("login");
			return false;
		}
		
		String userId = (String) session.getAttribute("identity");
		if (userId == null) {
			response.sendRedirect("redirect:/login");
			return false;
		}
		System.out.println("session ある");
		return true;
	}
}
