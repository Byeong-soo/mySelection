package com.mySelection.util;

import com.google.gson.*;
import com.mySelection.domain.MemberVO;
import org.mindrot.jbcrypt.BCrypt;

import java.lang.reflect.Type;
import java.sql.Timestamp;

public class MemberDeserializer implements JsonDeserializer<MemberVO> {

    @Override
    public MemberVO deserialize(JsonElement json, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {

        MemberVO memberVO = null;


        if (json.isJsonObject()) {
            JsonObject jsonObject = json.getAsJsonObject(); // {}

            memberVO = new MemberVO();
            memberVO.setId(jsonObject.get("id").getAsString());

            if(jsonObject.has("passwd")){
                memberVO.setPasswd(jsonObject.get("passwd").getAsString());
                String hashedPw = BCrypt.hashpw(memberVO.getPasswd(), BCrypt.gensalt());
                memberVO.setPasswd(hashedPw);
            }
            memberVO.setEmail(jsonObject.get("email").getAsString());
            memberVO.setNickname(jsonObject.get("nickname").getAsString());
            memberVO.setProfileImage(jsonObject.get("profileImage").getAsString());
            memberVO.setBirthday(jsonObject.get("birthday").getAsString());
            memberVO.setGender(jsonObject.get("gender").getAsString());
            memberVO.setReceiveEmail(jsonObject.get("receiveEmail").getAsString());
            memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
            memberVO.setJoinType("J");


            // 비밀번호 암호화 수정하기


        }
        return memberVO;

    }
}
