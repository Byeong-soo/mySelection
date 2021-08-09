package com.mySelection.repository;

import com.mySelection.domain.ClassificationVO;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
            sql  = "INSERT INTO classification (title, type, first, second, third ) ";
            sql += "VALUES (?, ?, ?, ?, ? ) ";
            // sql문장객체 준비
            pstmt = con.prepareStatement(sql);

            // pstmt의 ? 자리에 값 설정
            pstmt.setString(1, classificationVO.getTitle());
            pstmt.setString(2, classificationVO.getType());
            pstmt.setString(3, classificationVO.getFirst());
            pstmt.setString(4, classificationVO.getSecond());
            pstmt.setString(5, classificationVO.getThird());


            // 4단계. sql문 실행
         pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // insert



}
