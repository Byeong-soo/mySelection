package com.mySelection.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = { 
		"/member/logout.jsp",
		"/member/modify.jsp",
})
public class LoginCheckFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		// 요청 객체로부터 세션 참조 가져오기
		HttpSession session = req.getSession();
		//로그인 검증하기. 세션값 가져오기
		String id = (String) session.getAttribute("id");
		String nickName = (String) session.getAttribute("nickName");
		String profileImage = (String) session.getAttribute("profileImage");
		//로그인 세션값 없으면, login.jsp로 이동
		if (id == null) {
			res.sendRedirect("/index.jsp");
			return;
		}
		if (nickName == null) {
			res.sendRedirect("/index.jsp");
			return;
		}
		if (profileImage == null) {
			res.sendRedirect("/index.jsp");
			return;
		}
		
		chain.doFilter(request, response);
	} // doFilter

}








