package esVo;

public class GetRoomByHostIdxVo {
	private String roomName;
	private String roomLocation;
	private double roomScore;
	private String img1;
	private int roomIdx;
	
	public GetRoomByHostIdxVo(String roomName, String roomLocation, double roomScore, String img1, int roomIdx) {
		this.roomName = roomName;
		this.roomLocation = roomLocation;
		this.roomScore = roomScore;
		this.img1 = img1;
		this.roomIdx = roomIdx;
	}

	public String getRoomName() {
		return roomName;
	}

	public String getRoomLocation() {
		return roomLocation;
	}

	public double getRoomScore() {
		return roomScore;
	}

	public String getImg1() {
		return img1;
	}
	
	public int getRoomIdx() {
		return roomIdx;
	}
}
