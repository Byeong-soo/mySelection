package com.mySelection.repository;

import com.mySelection.domain.ClassificationVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClassificationDAO {

    // 싱글톤(singleton) 클래스 설계 : 객체 한개만 공유해서 사용하기
    private static ClassificationDAO instance;

    public static ClassificationDAO getInstance() {
        if (instance == null) {
            instance = new ClassificationDAO();
        }
        return instance;
    }

    // 생성자를 private로 외부로부터 숨김
    private ClassificationDAO() {
    }
    // ========= 싱글톤 설계 완료 =========


    public void insert(ClassificationVO classificationVO) {
        int count = 0;

        Connection con = null;
        PreparedStatement pstmt = null; // sql문장객체 타입

        try {
            con = JdbcUtils.getConnection(); // 1단계, 2단계 수행 후 커넥션 가져옴
            // con.setAutoCommit(true); // 기본 커밋은 자동커밋으로 설정되있음.


            // 3단계. sql 생성
            String sql = "";
            sql  = "INSERT INTO classification (id, title, type, firstParent, secondParent) ";
            sql += "VALUES (?, ?, ?, ?, ?) ";
            // sql문장객체 준비
            pstmt = con.prepareStatement(sql);

            // pstmt의 ? 자리에 값 설정
            pstmt.setString(1, classificationVO.getId());
            pstmt.setString(2, classificationVO.getTitle());
            pstmt.setString(3, classificationVO.getType());
            pstmt.setString(4, classificationVO.getFirstParent());
            pstmt.setString(5, classificationVO.getSecondParent());



            // 4단계. sql문 실행
         pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // insert


    public List<String> getClassification(ClassificationVO classificationVO) {
        List<String> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            con = JdbcUtils.getConnection();


            String firstParent = classificationVO.getFirstParent();
            String secondParent = classificationVO.getSecondParent();

            firstParent = (firstParent == null) ? "IS NULL" : " = \""+firstParent+"\"" ;
            secondParent = (secondParent == null) ? "IS NULL" : " = \""+secondParent+"\"" ;


            String sql = "SELECT title FROM classification WHERE id = ? AND type = ? "
                       + "AND firstParent " + firstParent + " AND secondParent " + secondParent;

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, classificationVO.getId());
            pstmt.setString(2, classificationVO.getType());


            rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(rs.getString("title"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }

        return list;
    } // getFirst





}
