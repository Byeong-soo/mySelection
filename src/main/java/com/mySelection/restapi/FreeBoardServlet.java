package com.mySelection.restapi;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mySelection.domain.BoardVO;
import com.mySelection.domain.Criteria;
import com.mySelection.domain.PageDTO;
import com.mySelection.repository.BoardDAO;
import com.mySelection.repository.MemberDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/freeBoard/*")
public class FreeBoardServlet extends HttpServlet {


    private static final String BASE_URI = "/api/freeBoard";

    
    private Gson gson;
    String address;

    public FreeBoardServlet() {
        GsonBuilder builder = new GsonBuilder();
        gson = builder.create();
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        BoardDAO boardDAO = BoardDAO.getInstance();
        // 글목록 가져오기 조건객체 준비
        Criteria cri = new Criteria(); // 기본값 1페이지 10개
        // board 테이블에서 전체글 리스트로 가져오기
        List<BoardVO> boardList = boardDAO.getBoards(cri);
        int totalCount = boardDAO.getCountBySearch(cri);
        PageDTO pageDTO = new PageDTO(cri, totalCount);



        String strJson = "";

        if(pageDTO.getTotalCount() >0) {

            strJson = gson.toJson(boardList);
        }

        sendResponse(resp, strJson);
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


}
