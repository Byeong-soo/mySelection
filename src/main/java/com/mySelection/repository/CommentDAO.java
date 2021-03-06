package com.mySelection.repository;

import com.mySelection.domain.AttachVO;
import com.mySelection.domain.BoardVO;
import com.mySelection.domain.CommentVO;
import com.mySelection.domain.Criteria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private static CommentDAO instance;

    public static CommentDAO getInstance() {
        if (instance == null) {
            instance = new CommentDAO();
        }
        return instance;
    }

    private CommentDAO() {
    }

    public void addComment(CommentVO commentVO) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "";
            sql = "INSERT INTO comment (bno, num, mid, content, reg_date, ipaddr, re_ref, re_lev, re_seq, nickname) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, commentVO.getBno());
            pstmt.setInt(2, commentVO.getNum());
            pstmt.setString(3, commentVO.getMid());
            pstmt.setString(4, commentVO.getContent());
            pstmt.setTimestamp(5, commentVO.getRegDate());
            pstmt.setString(6, commentVO.getIpaddr());
            pstmt.setInt(7, commentVO.getReRef());
            pstmt.setInt(8, commentVO.getReLev());
            pstmt.setInt(9, commentVO.getReSeq());
            pstmt.setString(10, commentVO.getNickname());

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // addAttach

    // 특정 게시글에 포함된 첨부파일 정보 가져오기
    public List<CommentVO> getCommentByBno(int bno, Criteria cri) {
        List<CommentVO> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int startRow = (cri.getPageNum() - 1) * cri.getAmount();

        try {
            con = JdbcUtils.getConnection();

            String sql = "";
            sql = "SELECT * ";
            sql += "FROM comment ";
            sql += "WHERE bno = ? ";
            sql += "ORDER BY re_ref ASC ";
            sql += "LIMIT ?, ? ";


            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bno);
            pstmt.setInt(2, startRow);
            pstmt.setInt(3, cri.getAmount());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                CommentVO commentVO = new CommentVO();
                commentVO.setNum(rs.getInt("num"));
                commentVO.setMid(rs.getString("mid"));
                commentVO.setContent(rs.getString("content"));
                commentVO.setRegDate(rs.getTimestamp("reg_date"));
                commentVO.setIpaddr(rs.getString("ipaddr"));
                commentVO.setReRef(rs.getInt("re_ref"));
                commentVO.setReLev(rs.getInt("re_lev"));
                commentVO.setReSeq(rs.getInt("re_seq"));
                commentVO.setNickname(rs.getString("nickname"));



                list.add( commentVO);
            } // while
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return list;
    } // getAttachesByBno

    // 전체글개수 가져오기
    public int getCountByBno(int bno,Criteria cri) {
        int count = 0;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "";
            sql = "SELECT COUNT(*) AS cnt ";
            sql += "FROM comment ";
            sql += "WHERE bno = ?";


            pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, bno);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt("cnt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return count;
    } // getCountAll

    public int getCountByBno(int bno) {
        int count = 0;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "";
            sql = "SELECT COUNT(*) AS cnt ";
            sql += "FROM comment ";
            sql += "WHERE bno = ?";


            pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, bno);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt("cnt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return count;
    } // getCountAll

    public void deleteCommentByBno(int bno) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "DELETE FROM comment WHERE bno = ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bno);

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // deleteBoardByNum

    public void deleteCommentByNum(int num) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "DELETE FROM comment WHERE num = ?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1,num);

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // deleteBoardByNum

    public int getNextnum(int bno) {
        int num = 0;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "SELECT IFNULL(MAX(num), 0) + 1 AS nextnum FROM comment";

            pstmt = con.prepareStatement(sql);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                num = rs.getInt("nextnum");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return num;
    } // getNextnum


    public int findBnoByNum(int num) {
        int bno = 0;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "SELECT bno AS bno FROM comment WHERE num=?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                bno = rs.getInt("bno");
            }


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return bno;
    } // findBnoByNum


    // 게시글 수정하기
    public void updateComment(CommentVO commentVO) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "";
            sql = "UPDATE comment ";
            sql += "SET content = ? ";
            sql += "WHERE num = ? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, commentVO.getContent());
            pstmt.setInt(2, commentVO.getNum());

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // updateComment


    public void updateReSeqAndAddReply(CommentVO commentVO) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = JdbcUtils.getConnection();
            // 수동커밋으로 변경 (기본값은 자동커밋) - 트랜잭션 단위로 처리하기
            con.setAutoCommit(false);

            // 답글을 다는 대상글과 같은 글그룹 내에서
            // 답글을 다는 대상글의 그룹내 순번보다 큰 글들의 순번을 1씩 증가시키기
            String sql = "";
            sql = "UPDATE comment ";
            sql += "SET re_seq = re_seq + 1 ";
            sql += "WHERE re_ref = ? ";
            sql += "AND re_seq > ? ";

            pstmt = con.prepareStatement(sql); // update문을 가진 문장객체 준비
            pstmt.setInt(1, commentVO.getReRef());
            pstmt.setInt(2, commentVO.getReSeq());
            pstmt.executeUpdate(); // update문을 가진 문장객체 실행하기
            pstmt.close(); // update문을 가진 문장객체 닫기

            sql = "";
            sql = "INSERT INTO comment (bno, num, mid, content, reg_date, ipaddr, re_ref, re_lev, re_seq, nickname) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, commentVO.getBno());
            pstmt.setInt(2, commentVO.getNum());
            pstmt.setString(3, commentVO.getMid());
            pstmt.setString(4, commentVO.getContent());
            pstmt.setTimestamp(5, commentVO.getRegDate());
            pstmt.setString(6, commentVO.getIpaddr());
            pstmt.setInt(7, commentVO.getReRef());
            pstmt.setInt(8, commentVO.getReLev()+1);
            pstmt.setInt(9, commentVO.getReSeq()+1);
            pstmt.setString(10, commentVO.getNickname());

            // 실행
            pstmt.executeUpdate();

            con.commit(); // 커밋하기

            con.setAutoCommit(true); // 기본값이었던 자동커밋으로 설정 되돌리기

        } catch (Exception e) {
            e.printStackTrace();
            try {
                con.rollback(); // 트랜잭션 단위작업에 문제가 생기면 롤백하기
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // updateReSeqAndAddReply

}
