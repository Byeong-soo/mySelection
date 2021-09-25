package com.mySelection.restapi;

import com.google.gson.*;
import com.mySelection.domain.*;
import com.mySelection.repository.AttachDAO;
import com.mySelection.repository.BoardDAO;
import com.mySelection.repository.MemberDAO;
import com.mySelection.util.MemberDeserializer;
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

@WebServlet("/api/freeBoard/*")
public class FreeBoardServlet extends HttpServlet {


    private static final String BASE_URI = "/api/freeBoard";


    GsonBuilder builder = new GsonBuilder();
    private Gson gson = builder.serializeNulls().create();
    BoardDAO boardDAO = BoardDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String urlStr = requestURI.substring(BASE_URI.length() + 1);
        Map<String, Object> map = new HashMap<>();

        if (urlStr.startsWith("one")) {
            urlStr = urlStr.substring(4);
            int bno = Integer.parseInt(urlStr);

            BoardVO boardVO = boardDAO.getBoard(bno);
//            List<AttachVO> attachList = attachDAO.getAttachesByBno(bno);

            String Content = boardVO.getContent().replaceAll("\n", "<br>");
            boardVO.setContent(Content);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH.mm");


            map.put("board", boardVO);
//            map.put("attachList", attachList);

        } else {


            String boardValue = URLDecoder.decode(urlStr, "UTF-8");
            System.out.println(boardValue);

            JsonObject jsonObject = new Gson().fromJson(boardValue, JsonObject.class);

            String strPageNum = jsonObject.get("pageNum").isJsonNull() ? null : jsonObject.getAsJsonObject().get("pageNum").getAsString();
            String strAmount = jsonObject.get("amount").isJsonNull() ? null : jsonObject.getAsJsonObject().get("amount").getAsString();
            String type = jsonObject.get("type").isJsonNull() ? null : jsonObject.getAsJsonObject().get("type").getAsString();
            String keyword = jsonObject.get("keyword").isJsonNull() ? null : jsonObject.getAsJsonObject().get("keyword").getAsString();
            String orderType = jsonObject.get("orderType").isJsonNull() ? null : jsonObject.getAsJsonObject().get("orderType").getAsString();
            String tag = jsonObject.get("tag").isJsonNull() ? null : jsonObject.getAsJsonObject().get("tag").getAsString();

            if (tag != null) {
                tag = tag.replaceAll(",$", "");
            }

            Criteria cri = new Criteria(); // 기본값 1페이지 10개

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

            if (tag != null && tag.length() > 0) {
                cri.setTag(tag);
            }


            System.out.println("if문 나옴 cri:" + cri);


            // board 테이블에서 전체글 리스트로 가져오기
            List<BoardVO> boardList = boardDAO.getBoards(cri);
            int totalCount = boardDAO.getCountBySearch(cri);
            PageDTO pageDTO = new PageDTO(cri, totalCount);


            String strBoardList = "";

            if (pageDTO.getTotalCount() > 0) {
                map.put("boardList", boardList);
//            strBoardList = gson.toJson(boardList);
            }
            map.put("pageDTO", pageDTO);

        } // else 끝

        String strResponse = gson.toJson(map); //
        sendResponse(resp, strResponse);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String type = requestURI.substring(BASE_URI.length() + 1);

        if (type.equals("new")) {
            writeNewBoard(req, resp); // 새로운 주글쓰기
        } else if (type.equals("reply")) {
            //writeReplyBoard(request, response); // 새로운 답글쓰기
        }

    } // dopost

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


    // 새로운 주글쓰기 메소드
    private void writeNewBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String uploadFolder = "C:/ubs/upload"; // 업로드 기준경로

        File uploadPath = new File(uploadFolder, getFolder());

        if (uploadPath.exists() == false) {
            uploadPath.mkdirs();
        }

        // MultipartRequest 인자값
        // 1. request
        // 2. 업로드할 물리적 경로.  "C:/ksw/upload"
        // 3. 업로드 최대크기 바이트 단위로 제한. 1024Byte * 1024Byte = 1MB
        // 4. request의 텍스트 데이터, 파일명 인코딩 "utf-8"
        // 5. 파일명 변경 정책. 파일명 중복시 이름변경규칙 가진 객체를 전달

        // 파일 업로드하기
        MultipartRequest multi = new MultipartRequest(
                request
                , uploadPath.getPath()
                , 1024 * 1024 * 50
                , "utf-8"
                , new DefaultFileRenamePolicy());
        // ===== 파일 업로드 완료됨. =====


        // enctype="multipart/form-data" 로 전송받으면
        // 기본내장객체인 request로부터 파라미터값을 바로 가져올수 없음! -> null이 리턴됨.
        // MultipartRequest 객체로부터 파라미터값을 가져와야 함. 사용방법은 request 와 동일함.


        // AttachDAO 객체 준비
        AttachDAO attachDAO = AttachDAO.getInstance();
        // BoardDAO 객체 준비
        BoardDAO boardDAO = BoardDAO.getInstance();

        // insert할 새 게시글 번호 가져오기
        int num = boardDAO.getNextnum(); // attach 레코드의 bno 컬럼값에 해당함


        // input type="file" 태그들의 name 속성들을 가져오기
        Enumeration<String> enu = multi.getFileNames(); // Iterator, Enumeration 반복자 객체

        while (enu.hasMoreElements()) { // 파일이 있으면
            String fname = enu.nextElement(); // name 속성값 : file0  file1  file2 ...

            // 저장된 파일명 가져오기
            String filename = multi.getFilesystemName(fname); // fname이 file0일때
            System.out.println("FilesystemName : " + filename);

            // 원본 파일명 가져오기
            String original = multi.getOriginalFileName(fname);
            System.out.println("OriginalFileName : " + original);

            if (filename == null) { // 파일정보가 없으면
                continue; // 그다음 반복으로 건너뛰기
            }


            // AttachVO 객체 준비
            AttachVO attachVO = new AttachVO();

            attachVO.setFilename(filename);
            attachVO.setUploadpath(getFolder());
            attachVO.setBno(num); // 첨부파일이 포함될 게시글 번호 저장

            UUID uuid = UUID.randomUUID();
            attachVO.setUuid(uuid.toString()); // 기본키 uuid 저장

            File file = new File(uploadPath, filename); // 년월일 경로에 실제 파일명의 파일객체

            boolean isImage = checkImageType(file); // 이미지 파일 여부 확인
            attachVO.setFiletype((isImage == true) ? "I" : "O"); // Image 또는 Other

            // 이미지 파일이면 썸네일 이미지 생성하기
            if (isImage == true) {
                File outFile = new File(uploadPath, "s_" + filename); // 생성(출력)할 썸네일 파일정보

                Thumbnailator.createThumbnail(file, outFile, 100, 100); // 썸네일 생성하기
            }


            // 첨부파일 attach 테이블에 attachVO를 insert하기
            attachDAO.addAttach(attachVO);
        } // while


        // BoardVO 객체 준비
        BoardVO boardVO = new BoardVO();

        // 파라미터값 가져와서 VO에 저장. MultipartRequest 로부터 가져옴.
        boardVO.setMid(multi.getParameter("id"));
        boardVO.setSubject(multi.getParameter("subject"));
        boardVO.setContent(multi.getParameter("content"));

        // 글번호 설정
        boardVO.setNum(num);
        // ipaddr  regDate  readcount
        boardVO.setIpaddr(request.getRemoteAddr()); // 127.0.0.1  localhost
        boardVO.setRegDate(new Timestamp(System.currentTimeMillis()));
        boardVO.setReadCount(0); // 조회수

        // 주글에서  re_ref  re_lev  re_seq  설정하기
        boardVO.setReRef(num);  // 주글일때는 글번호와 글그룹번호는 동일함
        boardVO.setReLev(0);  // 주글은 들여쓰기 레벨이 0 (들여쓰기 없음)
        boardVO.setReSeq(0);  // 주글은 글그룹 안에서 순번이 0 (re_ref 오름차순 정렬시 첫번째)

        // 주글 등록하기
        boardDAO.addBoard(boardVO);

        // =======================================================

        BoardVO dbBoard = boardDAO.getBoard(num);
        List<AttachVO> attachList = attachDAO.getAttachesByBno(num);

        Map<String, Object> map = new HashMap<>();
        map.put("result", "success");
        map.put("board", dbBoard); // JSON에서 {}
        map.put("attachList", attachList); // JSON에서 []

        String strJson = gson.toJson(map);
        System.out.println(strJson);

        sendResponse(response, strJson);

    } // writeNewBoard

    // 년/월/일 폴더명 생성하는 메소드
    private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); // "yyyy-MM-dd"
        Date date = new Date();
        String str = sdf.format(date);
        //str = str.replace("-", File.separator);
        return str;
    } // getFolder

    // 이미지 파일인지 여부 리턴하는 메소드
    private boolean checkImageType(File file) {
        boolean isImage = false;
        try {
            String contentType = Files.probeContentType(file.toPath());
            System.out.println("contentType : " + contentType); // "image/jpg"

            isImage = contentType.startsWith("image");

        } catch (IOException e) {
            e.printStackTrace();
        }
        return isImage;
    } // checkImageType

}
