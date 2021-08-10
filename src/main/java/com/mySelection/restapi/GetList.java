package com.mySelection.restapi;

import com.google.gson.Gson;
import com.mySelection.repository.ClassificationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/getList")
public class GetList extends HttpServlet {

    private ClassificationDAO dao = ClassificationDAO.getInstance();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String type = request.getParameter("type");
        String large = request.getParameter("large").trim();
        String middle = request.getParameter("middle").trim();
        String small = request.getParameter("small").trim();
        String strJson = "";
        if(large.length() == 0){
            large = null;
        }
        if(middle.length() == 0){
            middle = null;
        }
        if(small.length() == 0){
            small = null;
        }
        System.out.println("type = " + type);
        System.out.println("large = " + large);
        System.out.println("middle = " + middle);
        System.out.println("small = " + small);

        List list = dao.getClassification(type,large,middle,small);

        for(int i=0; i<list.size(); i++) {
            System.out.println("list = " + list.get(i));
        }

            strJson = gson.toJson(list);


        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(strJson);
        out.flush();
        out.close();


    }
}
