package esDao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import common.DBConnection;

public class JoinDao {
	static Connection conn = DBConnection.getConnection();
	
	public void newJoinUser(String userId, String pw, String phoneNum, String userRegidence, String birthday, String email) {
		String sql = "INSERT INTO user_info(user_idx, user_id, user_regidence, "
				+ " user_image, introduce, interact, super_host, join_date,"
				+ " user_school, user_job, hometown, birthday, email,"
				+ " phone_number, second_number, password, active) "
				+ " VALUES(user_idx.nextval, ? , ?, null, null, null, 0 , sysdate, "
				+ " null, null, ? , ? , ?, ?, null, ?, 1)";
		PreparedStatement pstmt = null;
		try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userId);
		pstmt.setString(2, userRegidence);
		pstmt.setString(3, userRegidence);
		pstmt.setString(4, birthday);
		pstmt.setString(5, email);
		pstmt.setString(6, phoneNum);
		pstmt.setString(7, pw);
		pstmt.executeUpdate();
		
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
			pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	//kakao로그인 한 사람은 이렇게 회원가입
	public void joinKakaoUser(String name, String image) {
		String sql = "INSERT INTO user_info(user_idx, user_id, user_regidence, user_image, introduce, interact, super_host, join_date, "
				+	"user_school, user_job, hometown, birthday, email, phone_number, second_number, password, active) "
				+	"VALUES (user_idx.nextval, ? , null , ?, null, null, 0, sysdate, null, null, null, null, ?, null, '1234', 1 ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, image);
			pstmt.setString(3, name);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
	}

}
