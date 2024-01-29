package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import common.DBConnection;
import esVo.GetFollowerListsVo;
import esVo.GetPostReplyByPostIdx;
import esVo.GetRoomByHostIdxVo;
import esVo.PostVo;

public class ProfileTimelineDao {
	static Connection conn = DBConnection.getConnection();
	//follower 수
	public int getTotalFollower(int userIdx){
		int totalFollower = 0;
		String sql = "SELECT count(*)"
				+ " FROM following"
				+ " WHERE user_idx = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				totalFollower = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return totalFollower;
	}
	//following 수
	public int getTotalFollowing(int userIdx){
		int totalFollowing = 0;
		String sql = "SELECT count(*)"
				+ " FROM following "
				+ " WHERE follower = ? ";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				totalFollowing = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return totalFollowing;
	}
	//게시글 개수
	public int getTotalPost(int userIdx) {
		int totalPost = 0;
		String sql = "SELECT count(*)"
				+ " FROM post"
				+ " WHERE user_idx = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				totalPost = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return totalPost;
	}
	//팔로잉추가
	public void addFollowing(int userIdx , int thisUserIdx) {
		String sql = "INSERT INTO following(following_idx, user_idx, follower)"
				+ " VALUES (following_idx.nextval, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thisUserIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	//그 사람의 게시글 가져오기
	public ArrayList<PostVo> getPostList(int thisUserIdx, int pageNum){
		String sql = "SELECT t2.* "
				+ " FROM (SELECT rownum rnum, t.*"
				+ "    FROM (SELECT * FROM post WHERE user_idx = ? order by written_date asc) t) t2"
				+ " WHERE t2.rnum >= ? AND t2.rnum<= ?";
		ArrayList<PostVo> list = new ArrayList<PostVo>();
		
		int endRNum = pageNum * 3;
		int startRNum = endRNum - 2;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thisUserIdx);
			//pstmt.setInt(2, startRNum);
			//pstmt.setInt(3, endRNum);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int postIdx = rs.getInt("post_idx");
				int userIdx = rs.getInt("user_idx");
				String content = rs.getString("content");
				String writtenDate = rs.getString("written_date");
				
				list.add(new PostVo(postIdx, userIdx, content, writtenDate));
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//게시글 좋아요개수
	public int countLikeInPost(int postIdx) {
		String sql = "SELECT count(*) FROM post_like WHERE post_idx = ?";
		int cnt = 0;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
		
		return cnt;
	}
//	댓글 가져오기
	public ArrayList<GetPostReplyByPostIdx> getReplyLists(int postIdx){
		ArrayList<GetPostReplyByPostIdx> list = new ArrayList<GetPostReplyByPostIdx>();
		String sql = "SELECT ui.user_image, ui.user_id, pr.written_date, pr.content"
				+ " FROM user_info ui, post_reply pr "
				+ " WHERE ui.user_idx = pr.user_idx AND pr.post_idx = ? "
				+ " ORDER BY reply_idx ASC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String userImage = rs.getString("user_image");
				String userId = rs.getString("user_id");
				String writtenDate = rs.getString("written_date");
				String content = rs.getString("content");
			
				list.add( new GetPostReplyByPostIdx(userImage, userId, writtenDate, content));
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
		
		return list;
	}
//	댓글 갯수
	public int getCountReply(int postIdx) {
		int cnt = 0;
		String sql = "SELECT count(*) FROM post_reply WHERE post_idx = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
		
		return cnt;
	}
	//사용자가 호스트인 숙소리스트 2개 가져오기
	public List<GetRoomByHostIdxVo> getRoomByHostIdx(int hostIdx){
		String sql = "SELECT ar.room_name, ar.room_location, ar.room_score, ri.img1"
				+ " FROM airbnb_room ar, room_image ri "
				+ " WHERE ar.room_idx = ri.room_idx AND ar.user_idx = ? AND ROWNUM <= 2";
	
		List<GetRoomByHostIdxVo> list = new ArrayList<>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hostIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String roomName = rs.getString("room_name");
				String roomLocation = rs.getString("room_location");
				double roomScore = rs.getDouble("room_score");
				String img1 = rs.getString("img1");
			
				list.add(new GetRoomByHostIdxVo(roomName, roomLocation, roomScore, img1));
			}
			rs.close();
			pstmt.close();
		}	catch(Exception e) { e.printStackTrace(); }
		
		return list;
	}
	//좋아요 알림
	public void InsertLikeAlarm(int thisUserIdx,int userIdx){
		String sql = "INSERT INTO notification(notification_idx, user_idx, txt, when_time, receiver)\r\n"
				+ "VALUES(notification_idx.nextval, ?, '(((user_id)))님이 회원님의 게시글을 좋아합니다.', sysdate, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.setInt(2, thisUserIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
	}
	//팔로잉 알림
		public void InsertFollowingAlarm(int thisUserIdx,int userIdx){
			String sql = "INSERT INTO notification(notification_idx, user_idx, txt, when_time, receiver)\r\n"
					+ "VALUES(notification_idx.nextval, ?, '(((user_id)))님이 회원님을 팔로우합니다.', sysdate, ?)";
			
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, userIdx);
				pstmt.setInt(2, thisUserIdx);
				pstmt.executeUpdate();
				pstmt.close();
			} catch(Exception e) { e.printStackTrace(); }
		}
	//좋아요누르기
	public void InsertPostLike(int postIdx, int userIdx){
		String sql = "INSERT INTO post_like VALUES( ? , ? )";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); } 
	}
	//좋아요 취소
	public void DeletePostLike(int postIdx, int userIdx) {
		String sql = "DELETE FROM post_like WHERE post_idx = ? AND user_idx = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
	}
	//follower사람들 목록
	public List<GetFollowerListsVo> getFollowerLists(int thisUserIdx){
		List<GetFollowerListsVo> list = new ArrayList<GetFollowerListsVo>();
		String sql = "SELECT ui.user_image, ui.user_id"
				+ " FROM following f, user_info ui"
				+ " WHERE f.follower = ui.user_idx AND f.user_idx = ? " ;
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thisUserIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String userImage = rs.getString("user_image");
				String userId = rs.getString("user_id");
				
				list.add(new GetFollowerListsVo(userImage, userId));
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); } 
	
		return list;
	}
	//following사람들 목록
	public List<GetFollowerListsVo> getFollowingLists(int thisUserIdx){
		List<GetFollowerListsVo> list = new ArrayList<GetFollowerListsVo>();
		String sql = "SELECT ui.user_image, ui.user_id"
				+ " FROM following f, user_info ui"
				+ " WHERE f.user_idx = ui.user_idx AND f.follower = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thisUserIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String userImage = rs.getString("user_image");
				String userId = rs.getString("user_id");
				
				list.add(new GetFollowerListsVo(userImage, userId));
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); } 
		return list;
	}
	//이 사람을 팔로잉했는지 여부를 받고 팔로잉받았으면 팔로잉버튼 안했으면 팔로우버튼
//	public boolean checkFollowing(int thisUserIdx, int userIdx) {
//	}
	//댓글달기
	public boolean insertReply(int postIdx, int userIdx, String content){
		String sql = "INSERT INTO post_reply(reply_idx, user_idx, content, written_date, post_idx)"
				+ " VALUES (reply_idx.nextval, ?, ?, sysdate, ?)";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			pstmt.setString(2, content);
			pstmt.setInt(3, postIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) { return false; }
		
		return true;
	} 
	//이 사람을 팔로우했는지 체크
	public boolean checkFollowing(int userIdx, int thisUserIdx) {
		String sql = "SELECT count(*) FROM following WHERE user_idx = ? AND follower = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thisUserIdx);
			pstmt.setInt(2, userIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int check = rs.getInt(1);

				if(check == 0) {
					return true;
				}
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
	
		return false;
	}
	//팔로우 취소
	public void cancelFollowing(int userIdx, int thisUserIdx) {
		String sql = "DELETE FROM following WHERE user_idx = ? AND follower = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, thisUserIdx);
			pstmt.setInt(2, userIdx);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
