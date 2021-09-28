package com.mySelection.repository;

import com.mySelection.domain.AttachVO;
import com.mySelection.domain.CommentVO;
import com.mySelection.domain.Criteria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
            sql = "INSERT INTO comment (bno, num, mid, content, reg_date, ipaddr, re_ref, re_lev, re_seq) ";
            sql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ";

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
            sql += "ORDER BY re_ref ASC";
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
    public int getCountBySearch(int bno,Criteria cri) {
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


    // 업로드 경로가 일치하는 첨부파일 정보 가져오기
    public List<AttachVO> getAttachesByUploadpath(String uploadpath) {
        List<AttachVO> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "";
            sql = "SELECT * ";
            sql += "FROM attach ";
            sql += "WHERE uploadpath = ? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, uploadpath);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                AttachVO attachVO = new AttachVO();
                attachVO.setUuid(rs.getString("uuid"));
                attachVO.setUploadpath(rs.getString("uploadpath"));
                attachVO.setFilename(rs.getString("filename"));
                attachVO.setFiletype(rs.getString("filetype"));
                attachVO.setBno(rs.getInt("bno"));

                list.add(attachVO);
            } // while
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return list;
    } // getAttachesByUploadpath

    // 첨부파일 한개 정보 가져오기
    public AttachVO getAttachByUuid(String uuid) {
        AttachVO attachVO = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "";
            sql = "SELECT * ";
            sql += "FROM attach ";
            sql += "WHERE uuid = ? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, uuid);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                attachVO = new AttachVO();
                attachVO.setUuid(rs.getString("uuid"));
                attachVO.setUploadpath(rs.getString("uploadpath"));
                attachVO.setFilename(rs.getString("filename"));
                attachVO.setFiletype(rs.getString("filetype"));
                attachVO.setBno(rs.getInt("bno"));
            } // if
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt, rs);
        }
        return attachVO;
    } // getAttachByUuid

    // 특정 게시글번호에 해당하는 첨부파일들 삭제하기
    public void deleteAttachesByBno(int bno) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "DELETE FROM attach WHERE bno = ? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, bno);

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // deleteAttachesByBno

    // uuid에 해당하는 첨부파일 한개 삭제하기
    public void deleteAttachByUuid(String uuid) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = JdbcUtils.getConnection();

            String sql = "DELETE FROM attach WHERE uuid = ? ";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, uuid);

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(con, pstmt);
        }
    } // deleteAttachByUuid

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



}
