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


                        // ?????? ????????????(????????????) ??????
                        //cookie.setMaxAge(60 * 10); // ???????????? ??????. 10??? = 60??? * 10
                        cookieId.setMaxAge(60 * 60 * 24 * 7); // 1?????? ??????.
                        cookieProfileImage.setMaxAge(60 * 60 * 24 * 7); // 1?????? ??????.
                        cookieNickName.setMaxAge(60 * 60 * 24 * 7); // 1?????? ??????.

                        // ?????? ????????????
                        cookieId.setPath("/"); // ???????????? ?????? ???????????? ?????? ????????? ??????
                        cookieProfileImage.setPath("/"); // ???????????? ?????? ???????????? ?????? ????????? ??????
                        cookieNickName.setPath("/"); // ???????????? ?????? ???????????? ?????? ????????? ??????

                        // ?????????????????? ?????? ????????? response ??????????????? ????????????. -> ????????? ????????? ?????? ??????.
                        resp.addCookie(cookieId);
                        resp.addCookie(cookieProfileImage);
                        resp.addCookie(cookieNickName);
                    }

                    result = 1;
                    map.put("member", memberVO);
                } else {// password ?????????
                    result = 0;
                }

            } else { // ????????? ??????
                result = 0;
            }


        }// login
        else if (getValue.startsWith("/naverLogin")) {

            String naverUserInfo = readMessageBody(reader);

            JsonObject jsonObject = new Gson().fromJson(naverUserInfo, JsonObject.class);

            String id = null;
            String nickName = null;
            String profileImage = null;
            String email = null;
            String age_range = null;
            String gender = null;


            if (jsonObject.has("id")) {
                id = jsonObject.getAsJsonObject().get("id").getAsString();
            }
            if (jsonObject.has("nickname")) {
                nickName = jsonObject.getAsJsonObject().get("nickname").getAsString();
            }
            if (jsonObject.has("profileImage")) {
                profileImage = jsonObject.getAsJsonObject().get("profileImage").getAsString();
            } else {
                profileImage = "/profileImage/default/basicProfile.png";
            }
            if (jsonObject.has("email")) {
                email = jsonObject.getAsJsonObject().get("email").getAsString();
            }
            if (jsonObject.has("age_range")) {
                age_range = jsonObject.getAsJsonObject().get("age_range").getAsString();
            }
            if (jsonObject.has("gender")) {
                gender = jsonObject.getAsJsonObject().get("gender").getAsString();
            }

            MemberDAO memberDAO = MemberDAO.getInstance();
            int count = memberDAO.getCheckById(id);

            if (count != 1) { // ??????
                MemberVO memberVO = new MemberVO();
                memberVO.setId(id);
                memberVO.setEmail(email);
                memberVO.setNickname(nickName);
                memberVO.setProfileImage(profileImage);
                memberVO.setAgeRange(age_range);
                memberVO.setGender(gender);
                memberVO.setReceiveEmail("N");
                memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
                memberVO.setJoinType("N");
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
                memberVO.setJoinType("N");
                result = memberDAO.updateById(memberVO);

            }

            HttpSession session = req.getSession(true);
            session.setAttribute("id", id);
            session.setAttribute("profileImage", profileImage);
            session.setAttribute("nickName", nickName);


        } else if (getValue.startsWith("/kakaoLogin")) {

            String kakaoUserInfo = readMessageBody(reader);

            JsonObject jsonObject = new Gson().fromJson(kakaoUserInfo, JsonObject.class);

            JsonObject object = jsonObject.get("kakao_account").getAsJsonObject();
            JsonElement profile = object.get("profile");
            JsonObject profileObject = profile.getAsJsonObject();

            String id = null;
            String nickName = null;
            String profileImage = null;
            String email = null;
            String age_range = null;
            String gender = null;


            if (jsonObject.has("id")) {
                id = jsonObject.getAsJsonObject().get("id").getAsString();
            }
            if (profileObject.has("nickname")) {
                nickName = profile.getAsJsonObject().get("nickname").getAsString();
            }
            if (profileObject.has("thumbnail_image_url")) {
                profileImage = profile.getAsJsonObject().get("thumbnail_image_url").getAsString();
            } else {
                profileImage = "/profileImage/default/basicProfile.png";
            }
            if (profileObject.has("email")) {
                email = profile.getAsJsonObject().get("email").getAsString();
            }
            if (profileObject.has("age_range")) {
                age_range = profile.getAsJsonObject().get("age_range").getAsString();
            }
            if (profileObject.has("gender")) {
                gender = profile.getAsJsonObject().get("gender").getAsString();
            }

            MemberDAO memberDAO = MemberDAO.getInstance();
            int count = memberDAO.getCheckById(id);

            if (count != 1) { // ??????
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
                birthday = birthday.replace("-", ""); // ????????? ???????????? ??????????????? ??????
                memberVO.setBirthday(birthday);
                int birthYear = Integer.parseInt(birthday.substring(0, 3));
                Calendar cal = Calendar.getInstance();
                int year = cal.get(Calendar.YEAR);
                int age = year - birthYear;
                int age_range = age % 10;
                memberVO.setAgeRange(age_range + "0???");
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
            birthday = birthday.replace("-", ""); // ????????? ???????????? ??????????????? ??????
            memberVO.setBirthday(birthday);
            int birthYear = Integer.parseInt(birthday.substring(0, 3));
            Calendar cal = Calendar.getInstance();
            int year = cal.get(Calendar.YEAR);
            int age = year - birthYear;
            int age_range = age % 10;
            memberVO.setAgeRange(age_range + "0???");
        } else {
            memberVO.setAgeRange(null);
            memberVO.setBirthday(null);
        }
        result = memberDAO.updateById(memberVO);

        HttpSession session = req.getSession(true);
        session.removeAttribute("profileImage");
        session.removeAttribute("nickName");

        session.setAttribute("id", id);
        session.setAttribute("profileImage", profileImage);
        session.setAttribute("nickName", nickname);

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
        id = id.substring(1); // ????????? "/" ?????? ??????


        MemberVO delMember = memberDAO.getMemberById(id);

        // ?????? ????????? ??????
        Map<String, Object> map = new HashMap<>();

        if (delMember != null) {
            memberDAO.deleteById(id); // ?????? ????????????
            map.put("result", true);
            map.put("member", delMember);
        } else { // delMember == null
            map.put("result", false);
        }

        // ???????????? -> JSON ???????????? ?????? (?????????)
        String strResponse = gson.toJson(map); // {}

        // ??????????????? ????????? ????????????
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
