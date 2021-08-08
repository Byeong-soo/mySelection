import java.util.regex.Pattern;

public class regexpTest {


    public void randomString() {
        String chars = "ㄱㄴㄷㄹㅁㅠㅂㄷ0ㄷㅅㅇㅂㄷㅜ123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz~!@#$%^&*(_+|<>?:{}";
        String randomstring = "";
        int success = 0;
        int fail = 0;
        String pattern = "^[a-zA-Z0-9~!@#$%^&*(_+|<>?:{}]{6,16}$";

        for(int z =0; z<1; z++){
            for(int j=0; j<10; j++) {
                for (int i=0; i<6+j; i++) {
                    int rnum =(int) Math.floor(Math.random() * chars.length());
                    randomstring += chars.substring(rnum,rnum+1);
                }
                System.out.println("test = " + randomstring);
                boolean regex = Pattern.matches(pattern, randomstring);
                if(regex) {
                    success ++;
                } else {
                    fail ++;
                }
                randomstring = "";
            }
        }
        System.out.println("성공 : " + success);
        System.out.println(" 실패 : " + fail);

    } // end

    public static void main(String[] args) {
       regexpTest regexpTest = new regexpTest();
       regexpTest.randomString();
    }



}
