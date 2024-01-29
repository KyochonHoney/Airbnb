package esDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.DBConnection;
import esVo.ChatListVo;
import esVo.EmojiVo;

public class MessageDao {
	//Ï±ÑÌåÖÎ∞©Ïóê ?ì∏ ?ù¥Î™®Ìã∞ÏΩ?
	static Connection conn = DBConnection.getConnection();
	public ArrayList<EmojiVo> getAllEmoji(){
		ArrayList<EmojiVo> list = new ArrayList<EmojiVo>();
		
		String sql = "SELECT emoji_idx, emoji_url"
				+ " FROM    emoji"
				+ " ORDER BY emoji_idx";
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int emojiIdx = rs.getInt("emoji_idx");
				String emojiUrl = rs.getString("emoji_url");
				
				EmojiVo vo = new EmojiVo(emojiIdx, emojiUrl);
				list.add(vo);
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//Ï±ÑÌåÖÎ™©Î°ù ÎΩëÏïÑ?ò§Í∏?
	public ArrayList<ChatListVo> getChatList(int userIdx){
		String sql = "SELECT      ui.user_image, ui.user_id, ml.msg_list_idx, ui.user_idx"
				+ " FROM        user_info ui, message_list ml"
				+ " WHERE       ml.partner_idx = ui.user_idx AND ml.host_idx = ?"
				+ " ORDER BY    msg_list_idx DESC";
		ArrayList<ChatListVo> list = new ArrayList<ChatListVo>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String userImage = rs.getString("user_image");
				String userId = rs.getString("user_id");
				int msgListIdx = rs.getInt("msg_list_idx");
				int userIdx1 = rs.getInt("user_idx");
				
				list.add(new ChatListVo(userImage, userId, msgListIdx, userIdx1));
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) { e.printStackTrace(); }
		
		return list;
	}
	//Ï±ÑÌåÖ Î™©Î°ù Ï§? Í∞??û• ÏµúÍ∑º ???ôî ?ïú Ï§? ÎΩëÏïÑ?ò§Í∏?
	public String getRecentChat(int msgListIdx) {
		String sql = "SELECT m.*"
				+ " FROM(SELECT m.msg"
				+ " FROM message_list ml, message m"
				+ " WHERE ml.msg_list_idx = m.msg_list_idx AND ml.msg_list_idx = ?"
				+ " ORDER BY m.msg_idx DESC) m "
				+ " WHERE ROWNUM <= 1";
		String chat = "";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, msgListIdx);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				chat = rs.getString(1);
			}
		} catch(Exception e) { e.printStackTrace(); }
		
		return chat;
	}
	
}
