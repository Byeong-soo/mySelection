package com.mySelection.restapi;

import com.google.gson.*;
import com.mySelection.domain.*;
import com.mySelection.repository.AttachDAO;
import com.mySelection.repository.BoardDAO;
import com.mySelection.repository.CommentDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import net.coobird.thumbnailator.Thumbnailator;
import org.mortbay.util.ajax.JSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/api/comment/*")
public class commentServlet extends HttpServlet {


    private static final String BASE_URI = "/api/comment";


    GsonBuilder builder = new GsonBuilder();
    private Gson gson = builder.serializeNulls().create();
    BoardDAO boardDAO = BoardDAO.getInstance();
    AttachDAO attachDAO = AttachDAO.getInstance();
    CommentDAO commentDAO = CommentDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String urlStr = requestURI.substring(BASE_URI.length() + 1);
        Map<String, Object> map = new HashMap<>();


            String commentValue = URLDecoder.decode(urlStr, "UTF-8");

            JsonObject jsonObject = new Gson().fromJson(commentValue, JsonObject.class);

            String strPageNum = jsonObject.get("pageNum").isJsonNull() ? null : jsonObject.getAsJsonObject().get("pageNum").getAsString();
            String strAmount = jsonObject.get("amount").isJsonNull() ? null : jsonObject.getAsJsonObject().get("amount").getAsString();
            int bno = jsonObject.get("bno").isJsonNull() ? 0 : Integer.parseInt(jsonObject.getAsJsonObject().get("bno").getAsString());

            Criteria cri = new Criteria(); // 기본값 1페이지 10개

            if (strPageNum != null) { // 요청 페이지번호 있으면
                cri.setPageNum(Integer.parseInt(strPageNum)); // cri에 값 설정
            }

            if (strAmount != null) {
                cri.setAmount(Integer.parseInt(strAmount));
            }

            // board 테이블에서 전체글 리스트로 가져오기
             int totalCount = 0;
            if(bno != 0){
                List<CommentVO> commentList = commentDAO.getCommentByBno(bno,cri);
                totalCount = commentDAO.getCountBySearch(bno,cri);
                PageDTO commentPageDTO = new PageDTO(cri, totalCount);

                String strCommentList = "";

                if (commentPageDTO.getTotalCount() > 0) {
                    map.put("commentList", commentList);
//            strBoardList = gson.toJson(boardList);
                    map.put("pageDTO", commentPageDTO);
                }


            }

        String strResponse = gson.toJson(map); //
        sendResponse(resp, strResponse);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String type = requestURI.substring(BASE_URI.length() + 1);

        if (type.equals("new")) {
            writeNewComment(req, resp); // 새로운 주글쓰기
        } else if (type.equals("reply")) {
            //writeReplyBoard(request, response); // 새로운 답글쓰기
        }

    } // dopost

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    } // doPut


    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


    } // doDelete

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


    // 새로운 주글쓰기 메소드
    private void writeNewComment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        BufferedReader reader = request.getReader();
        String strJson = readMessageBody(reader);
        Object valueJson = JSON.parse(strJson);
        String json = gson.toJson(valueJson);
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(json);

        String mid = element.getAsJsonObject().get("mid").getAsString().replace("\"", "");
        String content = element.getAsJsonObject().get("content").getAsString().replace("\"", "");
        String bno = element.getAsJsonObject().get("bno").getAsString().replace("\"", "");

        // BoardDAO 객체 준비
        CommentDAO commentDAO = CommentDAO.getInstance();
        System.out.println(mid);
        System.out.println(content);
        System.out.println(bno);

        int intBno = Integer.parseInt(bno);


        // insert할 새 댓글 번호 가져오기
        int num = commentDAO.getNextnum(intBno);


        // BoardVO 객체 준비
        CommentVO commentVO = new CommentVO();

        // 파라미터값 가져와서 VO에 저장. MultipartRequest 로부터 가져옴.
        commentVO.setMid(mid);
        commentVO.setContent(content);

        // 글번호 설정
        commentVO.setNum(num);
        commentVO.setBno(intBno);
        // ipaddr  regDate  readcount
        commentVO.setIpaddr(request.getRemoteAddr()); // 127.0.0.1  localhost
        commentVO.setRegDate(new Timestamp(System.currentTimeMillis()));

        // 주글에서  re_ref  re_lev  re_seq  설정하기
        commentVO.setReRef(num);  // 주댓글일때는 글번호와 글그룹번호는 동일함
        commentVO.setReLev(0);  // 주댓글은 들여쓰기 레벨이 0 (들여쓰기 없음)
        commentVO.setReSeq(0);  // 주댓글은 글그룹 안에서 순번이 0 (re_ref 오름차순 정렬시 첫번째)

        // 주글 등록하기
        commentDAO.addComment(commentVO);

        BoardDAO boardDAO = BoardDAO.getInstance();
        boardDAO.plusCommentCount(intBno);

        Map<String, Object> map = new HashMap<>();
        map.put("result", "success");

        strJson = gson.toJson(map);

        sendResponse(response, strJson);

    } // writeNewBoard




}
