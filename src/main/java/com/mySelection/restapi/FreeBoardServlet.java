package com.mySelection.restapi;

import com.google.gson.*;
import com.mySelection.domain.BoardVO;
import com.mySelection.domain.Criteria;
import com.mySelection.domain.MemberVO;
import com.mySelection.domain.PageDTO;
import com.mySelection.repository.BoardDAO;
import com.mySelection.repository.MemberDAO;
import com.mySelection.util.MemberDeserializer;
import org.mortbay.util.ajax.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/freeBoard/*")
public class FreeBoardServlet extends HttpServlet {


    private static final String BASE_URI = "/api/freeBoard";


    GsonBuilder builder = new GsonBuilder();
    private Gson gson = builder.serializeNulls().create();



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String boardValue = requestURI.substring(BASE_URI.length()+1);
        boardValue = URLDecoder.decode(boardValue,"UTF-8");
        Map<String, Object> map = new HashMap<>();

        System.out.println(boardValue);

        JsonObject jsonObject = new Gson().fromJson(boardValue, JsonObject.class);

        String strPageNum = jsonObject.get("pageNum").isJsonNull() ? null : jsonObject.getAsJsonObject().get("pageNum").getAsString();
        String  strAmount = jsonObject.get("amount").isJsonNull() ? null : jsonObject.getAsJsonObject().get("amount").getAsString();
        String type = jsonObject.get("type").isJsonNull() ? null : jsonObject.getAsJsonObject().get("type").getAsString();
        String keyword = jsonObject.get("keyword").isJsonNull() ? null : jsonObject.getAsJsonObject().get("keyword").getAsString();
        String orderType = jsonObject.get("orderType").isJsonNull() ? null : jsonObject.getAsJsonObject().get("orderType").getAsString();

        System.out.println("strPageNum :" + strPageNum);
        System.out.println("strAmount :" + strAmount);
        System.out.println("type :" + type);
        System.out.println("keyword :" + keyword);

        System.out.println("strPageNum :" + (strPageNum == null));
        System.out.println("strAmount :" + (strAmount == null));
        System.out.println("type :" + (type == null));
        System.out.println("keyword :" + (keyword == null));


//        String json = gson.toJson(boardValue);
//        JsonParser parser = new JsonParser();
//        JsonElement element = parser.parse(json);
//
        // 글목록 가져오기 조건객체 준비
        System.out.println("cri 생성전");
        Criteria cri = new Criteria(); // 기본값 1페이지 10개
        System.out.println("cri 생성");
//        String strPageNum = element.getAsJsonObject().get("pageNum").getAsString().replace("\"", "");
//        String strAmount = element.getAsJsonObject().get("amount").getAsString().replace("\"", "");
//        String type = element.getAsJsonObject().get("type").getAsString().replace("\"", "");
//        String keyword = element.getAsJsonObject().get("keyword").getAsString().replace("\"", "");
//
        System.out.println("if문 들어가기전");
        if (strPageNum != null) { // 요청 페이지번호 있으면
            cri.setPageNum(Integer.parseInt(strPageNum)); // cri에 값 설정
        }

        if (strAmount != null) {
            cri.setAmount(Integer.parseInt(strAmount));
        }

        if (type != null && type.length() > 0) {
            cri.setType(type);
        }

        if (keyword != null && keyword.length() > 0) {
            cri.setKeyword(keyword);
        }

        if (orderType != null && orderType.length() > 0) {
            cri.setOrderType(orderType);
        }


        System.out.println("if문 나옴 cri:" + cri);
        BoardDAO boardDAO = BoardDAO.getInstance();

        // board 테이블에서 전체글 리스트로 가져오기
        List<BoardVO> boardList = boardDAO.getBoards(cri);
        int totalCount = boardDAO.getCountBySearch(cri);
        PageDTO pageDTO = new PageDTO(cri, totalCount);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH.mm");

//        for(BoardVO boardVO : boardList){
//            String Content = boardVO.getContent().replaceAll("\r\n","<br>");
//            boardVO.setContent(Content);
//        }

       String strBoardList = "";

        if(pageDTO.getTotalCount() >0) {
            map.put("boardList", boardList);
//            strBoardList = gson.toJson(boardList);
        }
        map.put("pageDTO", pageDTO);



        String strResponse = gson.toJson(map); //
        sendResponse(resp, strResponse);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

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
