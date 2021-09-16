package com.mySelection.restapi;

import com.google.gson.*;

import com.mySelection.domain.MemberVO;

import com.mySelection.repository.MemberDAO;
import com.mySelection.util.MemberDeserializer;

import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import org.mortbay.util.ajax.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;


@WebServlet("/api/member/*")
public class MemberServlet extends HttpServlet {

    private static final String BASE_URI = "/api/member";

    private MemberDAO memberDAO = MemberDAO.getInstance();
    GsonBuilder builder = new GsonBuilder();


    private Gson gson = builder.serializeNulls().registerTypeAdapter(MemberVO.class, new MemberDeserializer()).create();
    String address;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        address = "/dupCheck";

        String requestURI = req.getRequestURI();
        String idValue = requestURI.substring(BASE_URI.length());
        if (idValue.startsWith(address)) {

            String id = idValue.substring(address.length() + 1);
            int count = memberDAO.getCheckById(id);

            PrintWriter out = resp.getWriter();
            out.println(count);
            out.flush();
            out.close();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestURI = req.getRequestURI();
        String getValue = requestURI.substring(BASE_URI.length());

        BufferedReader reader = req.getReader();
        Map<String, Object> map = new HashMap<>();
        int result = 0;

        if (getValue.startsWith("/login")) {

            String strJson = readMessageBody(reader);
            Object valueJson = JSON.parse(strJson);
            String json = gson.toJson(valueJson);
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(json);

            String id = element.getAsJsonObject().get("id").getAsString().replace("\"", "");
            String passwd = element.getAsJsonObject().get("passwd").getAsString().replace("\"", "");
            String rememberMe = "";
            if (!(element.getAsJsonObject().get("rememberMe").isJsonNull())) {
                rememberMe = element.getAsJsonObject().get("rememberMe").getAsString().replace("\"", "");
            }

            int count = memberDAO.getCheckById(id);

            if (count == 1) {


                MemberVO memberVO = memberDAO.getMemberById(id);
                if (BCrypt.checkpw(passwd, memberVO.getPasswd())) {


                    String profileImage = memberVO.getProfileImage();
                    String nickName = memberVO.getNickname();

                    HttpSession session = req.getSession(true);
                    session.setAttribute("id", id);
                    session.setAttribute("profileImage", profileImage);
                    session.setAttribute("nickName", nickName);


                    if (rememberMe.equals("true")) {
                        Cookie cookieId = new Cookie("id", id);
                        Cookie cookieProfileImage = new Cookie("profileImage", profileImage);
                        Cookie cookieNickName = new Cookie("nickName", nickName);



                        // 쿠키 유효시간(유통기한) 설정
                        //cookie.setMaxAge(60 * 10); // 초단위로 설정. 10분 = 60초 * 10
                        cookieId.setMaxAge(60 * 60 * 24 * 7); // 1주일 설정.
                        cookieProfileImage.setMaxAge(60 * 60 * 24 * 7); // 1주일 설정.
                        cookieNickName.setMaxAge(60 * 60 * 24 * 7); // 1주일 설정.

                        // 쿠키 경로설정
                        cookieId.setPath("/"); // 프로젝트 모든 경로에서 쿠키 받도록 설정
                        cookieProfileImage.setPath("/"); // 프로젝트 모든 경로에서 쿠키 받도록 설정
                        cookieNickName.setPath("/"); // 프로젝트 모든 경로에서 쿠키 받도록 설정

                        // 클라이언트로 보낼 쿠키를 response 응답객체에 추가하기. -> 응답시 쿠키도 함께 보냄.
                        resp.addCookie(cookieId);
                        resp.addCookie(cookieProfileImage);
                        resp.addCookie(cookieNickName);
                    }

                    result = 1;
                    map.put("member", memberVO);
                } else {// password 불일치
                    result = 0;
                }

            } else{ // 아이디 없음
                result = 0;
            }


        } // login
        else if (getValue.startsWith("/kakaoLogin")) {

            String kakaoUserInfo = readMessageBody(reader);

            JsonObject jsonObject = new Gson().fromJson(kakaoUserInfo, JsonObject.class);

            JsonObject object = jsonObject.get("kakao_account").getAsJsonObject();
            JsonElement profile = object.get("profile");


            String id = jsonObject.getAsJsonObject().get("id").getAsString();
            String nickName = profile.getAsJsonObject().get("nickname").getAsString();
            String profileImage = profile.getAsJsonObject().get("thumbnail_image_url").getAsString();
            String email = object.getAsJsonObject().get("email").getAsString();
            String age_range = object.getAsJsonObject().get("age_range").getAsString();
            String gender = object.getAsJsonObject().get("gender").getAsString();


            MemberDAO memberDAO = MemberDAO.getInstance();
            int count = memberDAO.getCheckById(id);

            if (count != 1) { // 가입
                MemberVO memberVO = new MemberVO();
                memberVO.setId(id);
                memberVO.setEmail(email);
                memberVO.setNickname(nickName);
                memberVO.setProfileImage(profileImage);
                memberVO.setAgeRange(age_range);
                memberVO.setGender(gender);
                memberVO.setReceiveEmail("N");
                memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
                memberVO.setJoinType("K");
                result = memberDAO.insert(memberVO);
            } else {
                MemberVO memberVO = new MemberVO();
                memberVO.setId(id);
                memberVO.setEmail(email);
                memberVO.setNickname(nickName);
                memberVO.setProfileImage(profileImage);
                memberVO.setAgeRange(age_range);
                memberVO.setGender(gender);
                memberVO.setReceiveEmail("N");
                memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
                memberVO.setJoinType("K");
                result = memberDAO.updateById(memberVO);

            }

            HttpSession session = req.getSession(true);
            session.setAttribute("id", id);
            session.setAttribute("profileImage", profileImage);
            session.setAttribute("nickName", nickName);

        } else if (getValue.startsWith("/join")) {


            String strJson = readMessageBody(reader);

            MemberVO memberVO = gson.fromJson(strJson, MemberVO.class);


            String id = memberVO.getId();
            String birthday = memberVO.getBirthday();
            String profileImage = memberVO.getProfileImage();
            String nickname = memberVO.getNickname();
            String basicImage = "/profileImage/default/basicProfile.png";

            if (profileImage.equals("")) {
                memberVO.setProfileImage(basicImage);
            }

            if (nickname.equals("") || nickname == null) {
                memberVO.setNickname(id);
            }


            if (!birthday.equals("")) {
                birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 대체
                memberVO.setBirthday(birthday);
                int birthYear = Integer.parseInt(birthday.substring(0, 3));
                Calendar cal = Calendar.getInstance();
                int year = cal.get(Calendar.YEAR);
                int age = year - birthYear;
                int age_range = age % 10;
                memberVO.setAgeRange(age_range + "0대");
            } else {
                memberVO.setAgeRange(null);
                memberVO.setBirthday(null);
            }
            result = memberDAO.insert(memberVO);


        }// join


        if (result == 1) {
            map.put("result", true);
        } else { // delMember == null
            map.put("result", false);
        }

        String strResponse = gson.toJson(map); //
        sendResponse(resp, strResponse);
    } // post

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String getValue = requestURI.substring(BASE_URI.length());

        BufferedReader reader = req.getReader();
        Map<String, Object> map = new HashMap<>();
        int result = 0;


        String strJson = readMessageBody(reader);

        MemberVO memberVO = gson.fromJson(strJson, MemberVO.class);


        String id = memberVO.getId();
        String birthday = memberVO.getBirthday();
        String profileImage = memberVO.getProfileImage();
        String nickname = memberVO.getNickname();
        String basicImage = "/profileImage/default/basicProfile.png";

        if (profileImage.equals("")) {
            memberVO.setProfileImage(basicImage);
        }

        if (nickname.equals("") || nickname == null) {
            memberVO.setNickname(id);
        }

        if (!birthday.equals("")) {
            birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 대체
            memberVO.setBirthday(birthday);
            int birthYear = Integer.parseInt(birthday.substring(0, 3));
            Calendar cal = Calendar.getInstance();
            int year = cal.get(Calendar.YEAR);
            int age = year - birthYear;
            int age_range = age % 10;
            memberVO.setAgeRange(age_range + "0대");
        } else {
            memberVO.setAgeRange(null);
            memberVO.setBirthday(null);
        }
        result = memberDAO.updateById(memberVO);


        if (result == 1) {
            map.put("result", true);
        } else { // delMember == null
            map.put("result", false);
        }

        String strResponse = gson.toJson(map); //
        sendResponse(resp, strResponse);


    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String id = requestURI.substring(BASE_URI.length());
        id = id.substring(1); // 맨앞에 "/" 문자 제거


        MemberVO delMember = memberDAO.getMemberById(id);

        // 응답 데이터 준비
        Map<String, Object> map = new HashMap<>();

        if (delMember != null) {
            memberDAO.deleteById(id); // 회원 삭제하기
            map.put("result", true);
            map.put("member", delMember);
        } else { // delMember == null
            map.put("result", false);
        }

        // 자바객체 -> JSON 문자열로 변환 (직렬화)
        String strResponse = gson.toJson(map); // {}

        // 클라이언트 쪽으로 출력하기
        sendResponse(resp, strResponse);


    }


    private String readMessageBody(BufferedReader reader) throws IOException {

        StringBuilder sb = new StringBuilder();
        String line = "";
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        } // while

        return sb.toString();
    } // readMessageBody

    private void sendResponse(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    } // sendResponse


}
