package com.mySelection.restapi;

import com.google.gson.*;
import com.mySelection.domain.*;
import com.mySelection.repository.AttachDAO;
import com.mySelection.repository.BoardDAO;
import com.mySelection.repository.CommentDAO;
import com.mySelection.repository.MemberDAO;
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

            String strPageNum = jsonObject.get("commentPageNum").isJsonNull() ? null : jsonObject.getAsJsonObject().get("commentPageNum").getAsString();
            String strAmount = jsonObject.get("amount").isJsonNull() ? null : jsonObject.getAsJsonObject().get("amount").getAsString();
            int bno = jsonObject.get("bno").isJsonNull() ? 0 : Integer.parseInt(jsonObject.getAsJsonObject().get("bno").getAsString());

            Criteria cri = new Criteria(); // ????????? 1????????? 10???

            if (strPageNum != null) { // ?????? ??????????????? ?????????
                cri.setPageNum(Integer.parseInt(strPageNum)); // cri??? ??? ??????
            }

            if (strAmount != null) {
                cri.setAmount(Integer.parseInt(strAmount));
            }


             int totalCount = 0;
            if(bno != 0){
                List<CommentVO> commentList = commentDAO.getCommentByBno(bno,cri);
                totalCount = commentDAO.getCountByBno(bno,cri);
                PageDTO commentPageDTO = new PageDTO(cri, totalCount);

                String strCommentList = "";

                if (commentPageDTO.getTotalCount() > 0) {
                    map.put("commentList", commentList);
//            strBoardList = gson.toJson(boardList);
                    map.put("commentPageDTO", commentPageDTO);
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
            writeNewComment(req, resp); // ????????? ????????????
        } else if (type.equals("reply")) {
            writeReplyComment(req, resp); // ????????? ????????????
        }

    } // dopost

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // PUT ??????
        // "/api/boards/{bno}" + ???????????? -> ?????? ??? ????????????

        String requestURI = req.getRequestURI();
        String bno = requestURI.substring(BASE_URI.length() + 1);

        BufferedReader reader = req.getReader();
        String strJson = readMessageBody(reader);
        Object valueJson = JSON.parse(strJson);
        String json = gson.toJson(valueJson);
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(json);

        String modifyCommentContent = element.getAsJsonObject().get("modifyCommentContent").getAsString().replace("\"", "");


        int num = Integer.parseInt(bno); // ????????? ????????? ??????

        CommentVO commentVO = new CommentVO();


        // ??????????????? ???????????? VO??? ??????
        commentVO.setNum(num);
        commentVO.setContent(modifyCommentContent);
        commentVO.setIpaddr(req.getRemoteAddr());

        // DB??? ????????? ????????????
        commentDAO.updateComment(commentVO);
        //=============== ????????? ???????????? ?????? ===============


        Map<String, Object> map = new HashMap<>();
        map.put("result", "success");

        strJson = gson.toJson(map);
        System.out.println(strJson);

        sendResponse(resp, strJson);


    } // doPut


    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String requestURI = req.getRequestURI();
        String bno = requestURI.substring(BASE_URI.length() + 1);
        int num = Integer.parseInt(bno);


        BoardDAO boardDAO = BoardDAO.getInstance();
        int intBno = commentDAO.findBnoByNum(num);
        boardDAO.minusCommentCount(intBno);
        commentDAO.deleteCommentByNum(num);
        int totalCount = commentDAO.getCountByBno(intBno);

        Map<String, Object> map = new HashMap<>();
        map.put("result", "success");
        map.put("totalCount", totalCount);

        String strJson = gson.toJson(map);
        sendResponse(resp, strJson);

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


    // ????????? ???????????? ?????????
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

        // BoardDAO ?????? ??????
        CommentDAO commentDAO = CommentDAO.getInstance();

        MemberDAO memberDAO = MemberDAO.getInstance();
        String nickname = memberDAO.getNickname(mid);

        int intBno = Integer.parseInt(bno);


        // insert??? ??? ?????? ?????? ????????????
        int num = commentDAO.getNextnum(intBno);


        // BoardVO ?????? ??????
        CommentVO commentVO = new CommentVO();

        // ??????????????? ???????????? VO??? ??????. MultipartRequest ????????? ?????????.
        commentVO.setMid(mid);
        commentVO.setNickname(nickname);
        commentVO.setContent(content);

        // ????????? ??????
        commentVO.setNum(num);
        commentVO.setBno(intBno);
//         ipaddr  regDate  readcount
        commentVO.setIpaddr(request.getRemoteAddr()); // 127.0.0.1  localhost
        commentVO.setRegDate(new Timestamp(System.currentTimeMillis()));

        // ????????????  re_ref  re_lev  re_seq  ????????????
        commentVO.setReRef(num);  // ?????????????????? ???????????? ?????????????????? ?????????
        commentVO.setReLev(0);  // ???????????? ???????????? ????????? 0 (???????????? ??????)
        commentVO.setReSeq(0);  // ???????????? ????????? ????????? ????????? 0 (re_ref ???????????? ????????? ?????????)

        // ?????? ????????????
        commentDAO.addComment(commentVO);

        BoardDAO boardDAO = BoardDAO.getInstance();
        boardDAO.plusCommentCount(intBno);

        int totalCount = commentDAO.getCountByBno(intBno);
        Map<String, Object> map = new HashMap<>();
        map.put("result", "success");
        map.put("totalCount", totalCount);

        strJson = gson.toJson(map);

        sendResponse(response, strJson);

    } // writeNewBoard


    private void writeReplyComment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        BufferedReader reader = request.getReader();
        String strJson = readMessageBody(reader);
        Object valueJson = JSON.parse(strJson);
        String json = gson.toJson(valueJson);
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(json);

        String mid = element.getAsJsonObject().get("mid").getAsString().replace("\"", "");
        String content = element.getAsJsonObject().get("content").getAsString().replace("\"", "");
        String bno = element.getAsJsonObject().get("bno").getAsString().replace("\"", "");
        String reRef = element.getAsJsonObject().get("reRef").getAsString().replace("\"", "");
        String reLev = element.getAsJsonObject().get("reLev").getAsString().replace("\"", "");
        String reSeq = element.getAsJsonObject().get("reSeq").getAsString().replace("\"", "");


        // BoardDAO ?????? ??????
        CommentDAO commentDAO = CommentDAO.getInstance();

        MemberDAO memberDAO = MemberDAO.getInstance();
        String nickname = memberDAO.getNickname(mid);

        int intBno = Integer.parseInt(bno);


        // insert??? ??? ?????? ?????? ????????????
        int num = commentDAO.getNextnum(intBno);


        // BoardVO ?????? ??????
        CommentVO commentVO = new CommentVO();

        // ??????????????? ???????????? VO??? ??????. MultipartRequest ????????? ?????????.
        commentVO.setMid(mid);
        commentVO.setNickname(nickname);
        commentVO.setContent(content);

        // ????????? ??????
        commentVO.setNum(num);
        commentVO.setBno(intBno);
        commentVO.setIpaddr(request.getRemoteAddr()); // 127.0.0.1  localhost
        commentVO.setRegDate(new Timestamp(System.currentTimeMillis()));


        commentVO.setReRef(Integer.parseInt(reRef));  // ?????????????????? ???????????? ?????????????????? ?????????
        commentVO.setReLev(Integer.parseInt(reLev));  // ???????????? ???????????? ????????? 0 (???????????? ??????)
        commentVO.setReSeq(Integer.parseInt(reSeq));  // ???????????? ????????? ????????? ????????? 0 (re_ref ???????????? ????????? ?????????)


        commentDAO.updateReSeqAndAddReply(commentVO);

        BoardDAO boardDAO = BoardDAO.getInstance();
        boardDAO.plusCommentCount(intBno);

        int totalCount = commentDAO.getCountByBno(intBno);
        Map<String, Object> map = new HashMap<>();
        map.put("result", "success");
        map.put("totalCount", totalCount);

        strJson = gson.toJson(map);

        sendResponse(response, strJson);

    } // writeReplyComment



}
