package com.mySelection.email;

import com.google.gson.*;
import org.apache.commons.mail.SimpleEmail;
import org.mortbay.util.ajax.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@WebServlet("/email/simple-mail")
public class SimpleEmailServlet extends HttpServlet {
    GsonBuilder builder = new GsonBuilder();
    Gson gson = builder.serializeNulls().create();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        BufferedReader reader = request.getReader();
        String userEmailInfo = readMessageBody(reader);

        JsonObject jsonObject = new Gson().fromJson(userEmailInfo, JsonObject.class);

        String receiver = null;

        if (jsonObject.has("email")) {
            receiver = jsonObject.getAsJsonObject().get("email").getAsString();
        }



        Random random = new Random(System.currentTimeMillis());

        int code = 100000 + random.nextInt(900000);
        String msg = "장바구Needs 인증번호 : " + code;


        // 메일전송기능 라이브러리 : commons-email 라이브러리

        // SimpleEmail 클래스 : 텍스트 메일 전송 용도

        // MultiPartEmail 클래스 : 텍스트 메시지와 파일을 함께 전송 용도
        //   EmailAttachment 클래스 : 첨부파일 정보 표현

        // HtmlEmail 클래스 : 이메일 내용을 HTML 문서 형식으로 전송 용도


        // SimpleEmail 객체 생성
        SimpleEmail email = new SimpleEmail();

        // SMTP 서버 연결설정
        email.setHostName("smtp.naver.com");
        email.setSmtpPort(465); // 기본포트  465(SSL)  587(TLS)
        email.setAuthentication("ubs4939", "2NEHTXNY3EU3");

        // SMTP  SSL, TLS 활성화 설정
        email.setSSLOnConnect(true);
        email.setStartTLSEnabled(true);

        String message = "fail";

        try {
            // 보내는 사람 설정. 제약사항: 보내는사람은 로그인한 아이디와 동일한 계정이 되어야 함.
            email.setFrom("ubs4939@naver.com", "관리자", "utf-8");

            // 받는사람 설정
//			email.addTo("zencoding@daum.net", "김상우", "utf-8");
//			email.addTo("zencoding@daum.net", "김상우", "utf-8");
//			email.addTo("zencoding@daum.net", "김상우", "utf-8");

            email.addTo(receiver);


            // 받는사람(참조인) 설정
            //email.addCc("zencoding@hanmail.net", "김상우", "utf-8");

            // 받는사람(숨은참조인) 설정
            //email.addBcc("zencoding@hanmail.net", "김상우", "utf-8");


            // 제목 설정
            email.setSubject("장바구니즈 이메일 인증");
            // 본문 설정
            email.setMsg(msg);

            // 메일 전송
            message = email.send();

        } catch (Exception e) {
            e.printStackTrace();
        }



        Map<String, Object> map = new HashMap<>();
        map.put("result", message);
        map.put("code", code);

        String strResponse = gson.toJson(map); //
        sendResponse(response, strResponse);


//        long endTime = System.currentTimeMillis(); // 종료시간
//
//        long execTime = endTime - beginTime;
//        System.out.println("execTime : " + execTime);
//
//        System.out.println("message : " + message);


//        response.setContentType("text/html; charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        StringBuilder sb = new StringBuilder();
//        sb.append("<script>");
//        sb.append("    alert('메일 전송 성공! 전송시간: " + execTime + "ms message : " + message + "');");
//        sb.append("    location.href = '/email/simpleEmail.jsp';");
//        sb.append("</script>");
//
//        out.print(sb.toString());
//        out.flush();



    } // doPost

    private void sendResponse(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    } // sendResponse

    private String readMessageBody(BufferedReader reader) throws IOException {

        StringBuilder sb = new StringBuilder();
        String line = "";
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        } // while

        return sb.toString();
    } // readMessageBody
}
