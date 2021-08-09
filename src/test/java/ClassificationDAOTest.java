import com.mySelection.domain.ClassificationVO;
import com.mySelection.repository.ClassificationDAO;
import org.junit.Before;
import org.junit.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Timestamp;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class ClassificationDAOTest {


    //픽스처(fixture)
    private ClassificationDAO dao;
    private ClassificationVO class1, class2, class3, class4;

    @Before
    public void setUp() {
        dao = ClassificationDAO.getInstance();

        class1 = new ClassificationVO();
        class1.setTitle("전자기기");
        class1.setType("L");
        class1.setIndex(1);


        class2 = new ClassificationVO();
        class2.setTitle("휴대폰");
        class2.setType("M");
        class2.setIndex(1);
        class2.setFirst("L1");


        class3 = new ClassificationVO();
        class3.setTitle("노트10");
        class3.setType("s");
        class3.setIndex(1);
        class3.setFirst("L1");
        class3.setSecond("M1");


        class4 = new ClassificationVO();
        class4.setTitle("냉장고");
        class4.setType("M");
        class3.setIndex(2);
        class4.setFirst("L1");



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
        dao.insert(class1);
        dao.insert(class2);
        dao.insert(class3);
        dao.insert(class4);



//        ClassificationVO class0 = dao.getMemberById(member1.getId());
//
//        assertEquals(member1.getId(),member.getId());
    } // testInsert



}
