import com.mySelection.domain.MemberVO;
import com.mySelection.repository.MemberDAO;
import org.junit.Before;
import org.junit.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class MemberDAOTest {

    //픽스처(fixture)
    private MemberDAO dao;
    private MemberVO member1, member2;

    @Before
    public void setUp() {
        dao = MemberDAO.getInstance();
        dao.deleteAll();

        member1 = new MemberVO();
        member1.setId("ubs123");
        member1.setPasswd("@ubs354193");
        member1.setNickname("유병수");
        member1.setBirthday("19930409");
        member1.setAgeRange("20대");
        member1.setGender("M"); // m남자 f여자 n 선택안함
        member1.setEmail("ubs4939@naver.com");
        member1.setRecvEmail("Y");
        member1.setRegDate(new Timestamp(System.currentTimeMillis()));
        member1.setJoinType("J");


        member2 = new MemberVO();
        member2.setId("pumkin08");
        member2.setPasswd("@yoonie08@");
        member2.setNickname("하씨");
        member2.setBirthday("19920908");
        member2.setAgeRange("30대");
        member2.setGender("Y"); // m남자 f여자 n 선택안함
        member2.setEmail("yoon@naver.com");
        member2.setRecvEmail("N");
        member2.setRegDate(new Timestamp(System.currentTimeMillis()));
        member2.setJoinType("J");


    }


    @Test
    public void testConnection() {



        //DB 접속정보
        String url = "jdbc:mysql://localhost:3306/myselectiondb?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul ";
        String user = "myselection";
        String passwd = "@DBqudtn587";

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, passwd);

            assertNotNull(con);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } // testConnection

    @Test
    public void testInsert() throws Exception {
        dao.insert(member1);
        dao.insert(member2);


        MemberVO member = dao.getMemberById(member1.getId());

        assertEquals(member1.getId(),member.getId());
    } // testInsert





} // end class
