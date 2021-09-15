package com.mySelection.restapi;

import com.google.gson.Gson;
import com.mySelection.domain.ClassificationVO;
import com.mySelection.repository.ClassificationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/classification/*")
public class ClassificationServlet extends HttpServlet {

    private static final String BASE_URI = "/api/classification";

    private ClassificationDAO CLADAO = ClassificationDAO.getInstance();

    private Gson gson;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String requestURI = req.getRequestURI();
        String getValue = requestURI.substring(BASE_URI.length());

        String strJson = "";

        if(getValue.startsWith("/sub")){
            getValue = getValue.substring(5); // 맨앞에 "/" 문자 제거

            ClassificationVO CLAVO = gson.fromJson(getValue, ClassificationVO.class);
            List<String> CLAList = CLADAO.getClassification(CLAVO);

            strJson = gson.toJson(CLAList);
        }

        sendResponse(resp, strJson);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPut(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doDelete(req, resp);
    }


    private void sendResponse(HttpServletResponse response, String json) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    } // sendResponse

}
