package esAction;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import action.Action;
import esDao.JoinDao;

public class JoinKakaoUserAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//KakaoVo kakaoVo = (KakaoVo)(request.getParameter("kakaoAccount"));
		String kakaoAccountJson = request.getParameter("kakaoAccount");
		JoinDao joinDao = new JoinDao();
		
        JSONParser parser = new JSONParser();
        JSONObject kakaoAccountObject = null;
        try {
            kakaoAccountObject = (JSONObject) parser.parse(kakaoAccountJson);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        if (kakaoAccountObject != null) {
            String profileNickname = (String) kakaoAccountObject.get("profile_nickname");
            String profileImage = (String) kakaoAccountObject.get("profile_image");
            joinDao.joinKakaoUser(profileNickname, profileImage);
        }
        
	}
}