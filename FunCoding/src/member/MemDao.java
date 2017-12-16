package member;

import java.sql.*;
import java.util.*;

import javax.mail.*;
import javax.mail.internet.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.Cookie;
import javax.sql.DataSource;

public class MemDao {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	DataSource ds = null;
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		ds = (DataSource)ctx.lookup("java:comp/env/jdbc/fuding");
		return ds.getConnection();
	}
	
	private void freeResource() {
		try {
			if(con != null) con.close();
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
		} catch(Exception e) {
			System.out.println("freeResource()메서드에서 에러 : " + e);
		}
	}
	
	// 회원 가입 할때 id 중복 체크
	public boolean checkUser(String id) {
		boolean check = false;
		
		try {
			con = getConnection();
			
			String sql = "SELECT id, pass FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) check = true;
			else check = false;
		} catch(Exception e) {
			System.out.println("checkUser()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		
		return check;
	}
	
	// 회원 가입 할때 nick 중복 체크
	public boolean checkNick(String nick) {
		boolean check = false;
		
		try {
			con = getConnection();
			
			String sql = "SELECT id, pass FROM member WHERE nick=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);

			rs = pstmt.executeQuery();
			
			if(rs.next()) check = true;
			else check = false;
		} catch(Exception e) {
			System.out.println("checkNick()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		
		return check;
	}

	// 로그인 할때 사용 nick 값을 반환해옴
	public String loginUser(String id, String pass) {
		String nick = "";
		
		try {
			con = getConnection();
			
			String sql = "SELECT nick FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();

			while(rs.next()){
				nick = rs.getString(1);
			}

		} catch(Exception e) {
			System.out.println("loginUser()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		
		return nick;
	}
	
	// 아이디로 닉을 받아옴
	public String getNickById(String id) {
		String nick = "";
		
		try {
			con = getConnection();
			
			String sql = "SELECT nick FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();

			while(rs.next()){
				nick = rs.getString(1);
			}

		} catch(Exception e) {
			System.out.println("getNickById()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		
		return nick;
	}
	
	// 닉으로  id를 받아옴
	public String getIdByNick(String nick) {
		String id = "";
		
		try {
			con = getConnection();
			
			String sql = "SELECT id FROM member WHERE nick=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			
			rs = pstmt.executeQuery();

			while(rs.next()){
				id = rs.getString(1);
			}

		} catch(Exception e) {
			System.out.println("getIdByNick()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		
		return id;
	}
	
	//이메일 인증 메서드
	public int sendEmail(String to, String authNum, String purpose, String askingMember) {
		
		System.out.println("받는 사람 : '" + to + "'");
		
		String from = "fudinghost@naver.com";
		String subject = "";
		String content = "";
		if (purpose == "cert"){
			subject = "FuDing 이메일 인증";
			content = "환영합니다. Fun CoDing = Fuding 입니다. <br/>"
					   + "푸딩 처럼 달콤하고 중독성 있는 Fuding 이메일 인증 입니다. <br/>"
					   + "아래 인증 코드를 팝업창에 입력하세요 <br/>"
					   + "-------------------- <br/>"
					   + "인증코드 :" + authNum;
		} else if(purpose == "findpw") {
			subject = "FuDing 비밀번호 확인";
			// dto 조회해서 비번 반환해줄것, 비번확인은 authNum 없어도 됨
			String getPass = getPassword(to);
			content = "환영합니다. Fun CoDing = Fuding 입니다. <br/>"
					   + "푸딩 처럼 달콤하고 중독성 있는 Fuding 입니다. <br/>"
					   + "귀한의 비밀번호는 아래와 같습니다. <br/>"
					   + "-------------------- <br/>"
					   + "비밀번호 : " + getPass;
		} else if(purpose == "resume") {
			subject = "" + askingMember + " 님이 이력서 요청 하였습니다.";
			content = "주인님  <br/>" + askingMember + "<br/>님이 이력서를 요청 했습니다. ";
		}

		System.out.println("1   '" + to + "'");
		
		Properties p = new Properties(); // 정보를 담을 객체
		System.out.println("2   '" + to + "'");
		p.put("mail.smtp.host", "smtp.naver.com"); // 네이버 SMTP

		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		System.out.println("3   '" + to + "'");
		// SMTP 서버에 접속하기 위한 정보들
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session ses = Session.getInstance(p, auth);
			System.out.println("4   '" + to + "'");
			ses.setDebug(true);

			MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
			msg.setSubject(subject); // 제목
			System.out.println("5   '" + to + "'");
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr); // 보내는 사람
			System.out.println(fromAddr);
			
			Address toAddr = new InternetAddress(to);
			System.out.println(toAddr);
			msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람

			msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
			System.out.println("10   '" + to + "'");
			Transport.send(msg); // 전송
			
			return 1;
		} catch (Exception e) {
			System.out.println("sendEmail()메서드에서 에러 : " + e);
			return 0;
		}
	}
	
	public String randomNum() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 6; i++) {
			int n = (int)(Math.random() * 10);
			sb.append(n);
		}
		return sb.toString();
	}
	
	//회원가입폼 DB저장 메서드
	public void insertMember(MemDto dto) {
		try {
			con = getConnection();
			
			String sql = "INSERT INTO member "
					+ "VALUES(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getNick());
			pstmt.setString(4, dto.getName());
			pstmt.setInt(5, dto.getPostcode());
			pstmt.setString(6, dto.getAddress());
			pstmt.setString(7, dto.getAddress2());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("insertMember()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
	}
	
	// to 로 넘어온 emailId 를 기준으로 password 받기
	public String getPassword(String emailId){
		String pw = "";
		try {
			con = getConnection();
			
			String sql = "select pass from member WHERE id =?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, emailId);

			rs = pstmt.executeQuery();
			while(rs.next()){
				pw = rs.getString(1);
			}
			
		} catch(Exception e) {
			System.out.println("getPassword()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		return pw;
	}
	
	//회원정보 탈퇴 메서드
	public void closeAccount(String nick) {
		try {
			con = getConnection();
			
			String sql = "delete from member WHERE nick =?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, nick);

			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("closeAccount()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
	}
	
	// 회원 정보 display nick 값 기준으로 정보를 가지고 옴
	public MemDto getMember(String nick) {
		MemDto dto = new MemDto();
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM member WHERE nick = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setAddress(rs.getString("address"));
				dto.setAddress2(rs.getString("address2"));
				dto.setName(rs.getString("name"));
				dto.setNick(rs.getString("nick"));
				dto.setPostcode(rs.getInt("postcode"));
				dto.setRegdate(rs.getTimestamp("regdate"));
			}
		} catch(Exception e) {
			System.out.println("getMember()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		
		return dto;
	}
	
	// 회원 정보 수정
	public void updateMember(MemDto dto) {
		try {
			con = getConnection();
			
			String sql = 	"UPDATE member "
						+	"SET name=?, pass=?, nick=?, postcode=?, address=?, address2=?  WHERE id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getNick());
			pstmt.setInt(4, dto.getPostcode());
			pstmt.setString(5, dto.getAddress());
			pstmt.setString(6, dto.getAddress2());
			pstmt.setString(7, dto.getId());

			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("updateMember()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
	}
	
	// 쿠키 값 가져오는것
	public String getCookieValue(Cookie[] cookies, String name){
		if (cookies==null){
			return null;
		}
		
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name)){
				return cookie.getValue();
			}
		}
			
		return null;
	}
	
	
	// 비밀번호 찾기 할때 emailList 얻는 logic
	public Vector<String> getEmailList(String name) {
		
		Vector<String> v = new Vector<String>();
		
		try {
			con = getConnection();
			
			String sql = "SELECT id FROM member WHERE name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);

			rs = pstmt.executeQuery();
			
			while(rs.next()){
				v.add(rs.getString(1));
			}

		} catch(Exception e) {
			System.out.println("checkNick()메서드에서 에러 : " + e);
		} finally {
			freeResource();
		}
		
		return v;
	}
}
