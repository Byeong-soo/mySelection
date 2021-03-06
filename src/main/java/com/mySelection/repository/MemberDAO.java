package com.mySelection.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mySelection.domain.MemberVO;

// DAO(Data Access Object): 데이터 접근 오브젝트 역할

public class MemberDAO {
    // 싱글톤(singleton) 클래스 설계 : 객체 한개만 공유해서 사용하기
    private static MemberDAO instance;

    public static MemberDAO getInstance() {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }

    // 생성자를 private로 외부로부터 숨김
    private MemberDAO() {
    }
    // ========= 싱글톤 설계 완료 =========


    public int insert(MemberVO memberVO) {
        int count = 0;

        Connection con = null;
        PreparedStatement pstmt = null; // sql문장객체 타입

        try {
            con = JdbcUtils.getConnection(); // 1단계, 2단계 수행 후 커넥션 가져옴
            // con.setAutoCommit(true); // 기본 커밋은 자동커밋으로 설정되있음.

            // 3단계. sql 생성
            String sql = "";
            sql  = "INSERT INTO member (id, passwd, nickname, profile_image, birthday, age_range, gender, email, receive_email, register_date, join_type ) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
            // sql문장객체 준비
            pstmt = con.prepareStatement(sql);

            // pstmt의 ? 자리에 값 설정
            pstmt.setString(1, memberVO.getId());
            pstmt.setString(2, memberVO.getPasswd());
            pstmt.setString(3, memberVO.getNickname());
            pstmt.setString(4, memberVO.getProfileImage());
            pstmt.setString(5, memberVO.getBirthday());
            pstmt.setString(6,memberVO.getAgeRange());
            pstmt.setString(7, memberVO.getGender());
            pstmt.setString(8, memberVO.getEmail());
            pstmt.setString(9, memberVO.getReceiveEmail());
            pstmt.setTimestamp(10, memberVO.getRegDate());
            pstmt.setString(11, memberVO.getJoinType());

            // 4단계. sql문 실행
            count = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
        return count;
    } // insert

    public int deleteAll() {
        int count = 0;

        // JDBC
        Connection con = null; // 접속
        PreparedStatement pstmt = null; // sql문장객체 타입

        try {
            con = JdbcUtils.getConnection();
            // sql문 준비
            String sql = "DELETE FROM member";
            // 3단계. pstmt 문장객체 생성
            pstmt = con.prepareStatement(sql);
            // 4단계. sql 문장 실행
            count = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
        return count;
    } // deleteAll


    // 특정 아이디 해당하는 회원정보 삭제하는 메소드
    // DELETE FROM member WHERE id = ?;
    public int deleteById(String id) {
        int count = 0;

        Connection con = null; // 접속
        PreparedStatement pstmt = null; // sql문장객체 타입

        try {
            con = JdbcUtils.getConnection();

            String sql = "DELETE FROM member WHERE id = ? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
        return count;
    } // deleteById

    // 특정 아이디 해당하는 회원정보 수정하는 메소드
    // UPDATE member
    // SET passwd = ?, name = ?, email = ?, recv_email = ?, reg_date = ?
    // WHERE id = ?;
    public int updateById(MemberVO memberVO) {
        int count =0;
        Connection con = null; // 접속
        PreparedStatement pstmt = null; // sql문장객체 타입

        try {
            con = JdbcUtils.getConnection();

            String passwd = memberVO.getPasswd();
            if(passwd == null){
                passwd = "";
            } else {
                passwd = ",passwd = " + passwd;
            }

            String sql = "UPDATE member SET nickname=?,profile_image=?,birthday=?," +
                         "age_range=?,gender=?,email=?,receive_email=?"+passwd+" WHERE id=?";


            pstmt = con.prepareStatement(sql);

            pstmt.setString(1, memberVO.getNickname());
            pstmt.setString(2, memberVO.getProfileImage());
            pstmt.setString(3, memberVO.getBirthday());
            pstmt.setString(4,memberVO.getAgeRange());
            pstmt.setString(5, memberVO.getGender());
            pstmt.setString(6, memberVO.getEmail());
            pstmt.setString(7, memberVO.getReceiveEmail());
            pstmt.setString(8, memberVO.getId());

            System.out.println(pstmt);
            count = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
        return  count;
    } // updateById

    // 특정 아이디 해당하는 회원 레코드(행)의 개수 가져오기
    public int getCheckById(String id) {
    int count = 0;

        Connection con = null; // 접속
        PreparedStatement pstmt = null; // sql문장객체 타입
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "SELECT count(*) AS cnt FROM member WHERE id = ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                count =  rs.getInt(1); // rs.getInt("cnt")
            }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return count;
    } // getCountById


    // SELECT COUNT(*) AS cnt FROM member;
    public int getCountAll() {
        int count = 0;

        Connection con = null; // 접속
        PreparedStatement pstmt = null; // sql문장객체 타입
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "SELECT count(*) AS cnt FROM member";

            pstmt = con.prepareStatement(sql);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1); // rs.getInt("cnt")
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return count;
    } // getCountAll


    // 기본키 컬럼값을 기준으로 레코드(행) 최대 1개 가져오기
    // SELECT * FROM member WHERE id = 'bbb';
    public MemberVO getMemberById(String id) {
        MemberVO memberVO = null;

        Connection con = null; // 접속
        PreparedStatement pstmt = null; // sql문장객체 타입
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "SELECT * FROM member WHERE id = ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                memberVO = new MemberVO();
                memberVO.setId(rs.getString("id"));
                memberVO.setPasswd(rs.getString("passwd"));
                memberVO.setEmail(rs.getString("email"));
                memberVO.setNickname(rs.getString("nickname"));
                memberVO.setProfileImage(rs.getString("profile_image"));
                memberVO.setBirthday(rs.getString("birthday"));
                memberVO.setAgeRange(rs.getString("age_range"));
                memberVO.setGender(rs.getString("gender"));
                memberVO.setReceiveEmail(rs.getString("receive_email"));
                memberVO.setRegDate(rs.getTimestamp("register_date"));
                memberVO.setJoinType(rs.getString("join_type"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return memberVO;
    } // getMemberById

    public String getNickname(String id) {
        String nickname = "";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "SELECT nickname AS nickname FROM member WHERE id=?";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                nickname = rs.getString("nickname");
            }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }

        return nickname;
    }



//
//
//    // select * from member order by name;
//    public List<MemberVO> getMembers() {
//        List<MemberVO> list = new ArrayList<>();
//
//        Connection con = null; // 접속
//        PreparedStatement pstmt = null; // sql문장객체 타입
//        ResultSet rs = null;
//
//        try {
//            con = JdbcUtils.getConnection();
//
//            String sql = "SELECT * FROM member ORDER BY id";
//
//            pstmt = con.prepareStatement(sql);
//
//            rs = pstmt.executeQuery();
//
//            while (rs.next()) {
//                MemberVO memberVO = new MemberVO();
//                memberVO.setId(rs.getString("id"));
//                memberVO.setPasswd(rs.getString("passwd"));
//                memberVO.setNickname(rs.getString("nickname"));
//                memberVO.setProfileimg(rs.getString("profileimg"));
//                memberVO.setBirthday(rs.getString("birthday"));
//                memberVO.setAge_range(rs.getString("age_range"));
//                memberVO.setGender(rs.getString("gender"));
//                memberVO.setEmail(rs.getString("email"));
//                memberVO.setRecvEmail(rs.getString("recv_email"));
//                memberVO.setRegDate(rs.getTimestamp("reg_date"));
//                memberVO.setJointype(rs.getString("jointype"));
//
//                list.add(memberVO);
//            } // while
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            JdbcUtils.close(con, pstmt, rs);
//        }
//        return list;
//    } // getMembers

}








