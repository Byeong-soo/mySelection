package com.mySelection.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class RememberMeFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		// 요청 사용자의 세션 가져오기
		HttpSession session = req.getSession();
		// 세션에 로그인 아이디가 있는 확인 (이미 로그인 되어있는지 확인)
		String id = (String) session.getAttribute("id");
		String nickName = (String) session.getAttribute("nickName");
		String profileImage = (String) session.getAttribute("profileImage");
		// 세션에 로그인 아이디가 없으면 쿠키에서 아이디 찾아서 세션에 저장(로그인 처리)
		if (id == null) {
			// 쿠키 배열객체 가져오기
			Cookie[] cookies = req.getCookies();
			
			// 로그인 상태유지용 쿠키정보를 찾기
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("id")) {
						id = cookie.getValue();
						
						// 세션에 저장 (로그인 인증 처리)
						session.setAttribute("id", id);
					}
				} // for
			}
		} // if

		if (nickName == null) {
			// 쿠키 배열객체 가져오기
			Cookie[] cookies = req.getCookies();

			// 로그인 상태유지용 쿠키정보를 찾기
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("nickName")) {
						nickName = cookie.getValue();

						// 세션에 저장 (로그인 인증 처리)
						session.setAttribute("nickName", nickName);
					}
				} // for
			}
		} // if

		if (profileImage == null) {
			// 쿠키 배열객체 가져오기
			Cookie[] cookies = req.getCookies();

			// 로그인 상태유지용 쿠키정보를 찾기
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("profileImage")) {
						profileImage = cookie.getValue();

						// 세션에 저장 (로그인 인증 처리)
						session.setAttribute("profileImage", profileImage);
					}
				} // for
			}
		} // if
		
		// 다음 필터를 호출함
		chain.doFilter(request, response);
	} // doFilter

}
