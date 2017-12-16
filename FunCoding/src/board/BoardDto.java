package board;

import java.sql.Timestamp;

//경고! 데이터베이스의 tblBoard테이블의 필드명과 동일하게 변수 만들자!!
public class BoardDto {
	private int num;			// 댓글 달아야 되니깐 고유번호가 있어야 될듯 아래 항목들은 게시글 고유하게 지정하는항목이 없네, 댓글 작업할때 필요없을지 판단해서 추후 삭제 할것 
	private String id;
	private String subject;
	private String content;
	private int count;
	private String ip;
	private Timestamp regdate;   
	private int pos;
	private int	depth;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
}
