package esVo;

public class KakaoVo {
	private String profileNickname;
	private String profileImage;
	
	public KakaoVo(String profileNickname, String profileImage) {
		this.profileNickname = profileNickname;
		this.profileImage = profileImage;
	}

	public String getProfileNickname() {
		return profileNickname;
	}

	public String getProfileImage() {
		return profileImage;
	}
	
}
