package com.mySelection.repository;


import com.mySelection.domain.MemberVO;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/LoginCheck")
public class LoginCheck extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");

        MemberDAO memberDAO = MemberDAO.getInstance();
        String id = request.getParameter("id").trim();
        String passwd = request.getParameter("passwd").trim();
        String rememberMe = request.getParameter("rememberMe");

        int count = 0;
        MemberVO memberVO = memberDAO.getMemberById(id);
        if(memberVO == null) { // 아이디 존재안하면 2
            count = 2;
        } else {
            String DBPasswd = memberVO.getPasswd();
            if(passwd.equals(DBPasswd)) { // 비번 맞음
                count = 1;

                String profileImage = memberVO.getProfileimg();
                String nickName = memberVO.getNickname();
                // 로그인 정보 세션에 저장
                HttpSession session = request.getSession();
                session.setAttribute("loginId", id);
                session.setAttribute("profileImage", profileImage);
                session.setAttribute("nickName", nickName);


                if (rememberMe.equals(true)) {
                    // 쿠키 생성

                    Cookie cookie = new Cookie("loginId", id);
                    // 쿠키 유효시간(유통기한) 설정
                    //cookie.setMaxAge(60 * 10); // 초단위로 설정. 10분 = 60초 * 10
                    cookie.setMaxAge(60 * 60 * 24 * 7); // 1주일 설정.

                    // 쿠키 경로설정
                    cookie.setPath("/"); // 프로젝트 모든 경로에서 쿠키 받도록 설정

                    // 클라이언트로 보낼 쿠키를 response 응답객체에 추가하기. -> 응답시 쿠키도 함께 보냄.
                    response.addCookie(cookie);
                }






            } else { // 비번 틀림
                count = 0;
            }

        }



        PrintWriter out = response.getWriter();
        out.println(count);
        out.flush();
        out.close();

    }
}
