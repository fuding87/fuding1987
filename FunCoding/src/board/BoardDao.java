package board;

import java.sql.*;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDao {
	
	private Connection con;				//DB연결 정보를 담고 있는 Connection객체 저장
	private PreparedStatement pstmt;	//SQL문 실행 객체 저장
	private ResultSet rs;				//select의 결과를 저장할 객체를 저장
	private DataSource ds; 				//커넥션풀의 역할
	
	//DB연결하는 생성자
	//1. 커넥션풀 얻기
	public BoardDao() {
		try {
			//1.웹서버와 연결된 웹프로젝트의 모든 정보를 가지고 잇는
			//컨텍스트 객체 생성
			Context init = new InitialContext();

			//2.연결된 웹서버에서 DataSource(커넥션풀) 검색해서 가져오기
			ds = (DataSource)init.lookup("java:comp/env/jdbc/fuding");
			
		} catch (Exception e) {
			System.out.println("BoardDao 생성자에서 커넥션풀 얻기 실패:" + e);
		}
	} //생성자 끝
	
	//리소스 자원해제 메소드
	public void freeResource(){
		if (con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		if (rs != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		if (pstmt != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
	}
	
	//DB에 있는 글들을 select해서 가져와서 전체 글리스트를 뿌려주기 위한 메소드
	//List.jsp페이지에서 사용 하는 메소드
	public Vector getBoardList(String keyField, String keyWord, String board) {
		Vector<BoardDto> v = new Vector<BoardDto>();
		// Vector<BoardDto> = BoardDto이외의 객체들은 담을수 없게 지정하는 것
		
		String sql = "";
		
		try {
			//DataSource(커넥션풀)에서 DB와 미리 연결된 DB연결객체(Connection) 꺼내오기
			con = ds.getConnection(); 	//DB연결
			
			//검색어를 입력하지 않았다면?
			if(keyWord == null || keyWord.isEmpty()){
/*				//가장 최신글이 위로 오게 num를 기준으로 내림차순 정렬
				sql = "select * from tblBoard order by num desc";*/
				//답변글 작성시 pos를 기준으로 오름차순 정렬하여 검색
				sql = "select * from " + board + " order by pos asc";				
			}else{
				//keyField(검색기준필드)에 해당하는 앞뒤에 어떤문자가 와도 상관없이
				//keyWord(검색어)를 가진 데이터를 검색하는데...
				//num기준으로 내림차순 정렬하여 검색
/*				sql = "select * from tblBoard where " + keyField
						+ " like '%" + keyWord + "%' order by num desc";*/
				sql = "select * from " + board + " where " + keyField
						+ " like '%" + keyWord + "%' order by pos asc";			
			}
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCount(rs.getInt("count"));
				dto.setDepth(rs.getInt("depth"));
				dto.setIp(rs.getString("ip"));
				dto.setPos(rs.getInt("pos"));
				dto.setRegdate(rs.getTimestamp("regdate"));
		
				v.add(dto);
				
			}
		} catch (Exception e) {
			System.out.println("getBoardList메소드에서 오류:" + e);
		} finally {
			//자원해제
			freeResource();
		}
		
		//DB로 부터 검색하여 가져온 전체글들(DTO객체들)을 벡터에 담아
		//벡터 자체를 반환
		return v;
		
	}//getBoardList 메소드 끝 부분
	
	//DB에 글추가 메소드
	public void insertBoard(BoardDto dto,String board) {

		try{
			
			con = ds.getConnection();	
			
			//[1] 답변을 달기위한 새글 추가 규칙2.
			//새로운 데이터를 입력할때 먼저 기존 데이터의 모든 pos값은 1씩 증가 시킨다.
			String sql = "update  " + board + " set pos=pos+1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			//[2] 답변을 달기위한 새글 추가 규칙3.
			//처음 입력되는 데이터(부모글,답변글이 아닌글)은 무조건 pos,depth값은 0으로 입력한다.
			// insert 쿼리구문 작성
			sql = 	"insert into " + board + "(id, subject, content, count, ip, regdate, pos, depth) "+
							"values(?,?,?,0,?,now(),0,0)";
			// count -> 0, post -> 0, depth -> 0

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getSubject());
			pstmt.setString(3,dto.getContent());
			pstmt.setString(4,dto.getIp());

			// insert쿼리 실행
			pstmt.executeUpdate();
			
		}catch(Exception e1){
			System.out.println("insertBoard 메소드에서 오류:"+e1);
		}finally{
			freeResource();		
		}
	}
	
	public void updateBoard(BoardDto dto,String board) {
		
		// update 쿼리구문 작성

		String sql = 	"update " + board + 
						" set subject=?, content=? " +
						"where num=?";
		try{
			
			con = ds.getConnection();	
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1,dto.getSubject());
			pstmt.setString(2,dto.getContent());
			pstmt.setInt(3,dto.getNum());
			
			pstmt.executeUpdate();
			
		}catch(Exception e1){
			System.out.println("updateBoard 메소드에서 오류:"+e1);
		}finally{
			freeResource();		
		}

	}

	public void deleteBoard(int num, String board) {
		
		// update 쿼리구문 작성
		String sql = 	"delete from " + board + 
						" where num=?";

		try{

			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e1){
			System.out.println("deleteBoard 메소드에서 오류:"+e1);
		}finally{
			freeResource();		
		}		
		
	}
	
	//답변글 등록하기
	//1. 부모글보다 큰 pos는 1씩 증가 시킨다.
	//2. 답변글은 부모글의 pos에 1을 더한다
	//3. 부모글의 depth(들여쓰기)에 1을 더해준다.
	//-------------------------------
	//부모글의 pos값을 전달받아.. 부모글보다 큰 pos갑에 1을 더해서 수정하는 메소드
	public void replyUpPos(int ParentPos, String board){
		try {
			con = ds.getConnection();
			String sql = "update " + board + " set pos=pos+1 where pos>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ParentPos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("replyUpPos() 메소드에서 오류 : " + e);
		} finally {
			freeResource();
		}
	}
	
	//답변글 저장하는 메소드
	//부모글의 pos,depth값 + 답변글내용 저장한 dto객체를 인자로 전달 받는다.
	public void replyBoard(BoardDto dto, String board) {
		try {
			//2.답변글은 부모글의 pos에 1을 더한다.
			con = ds.getConnection();
			//3.부모글의 depth(들여쓰기레벨)에 1을 더한다.
			int pos = dto.getPos() + 1;
			int depth = dto.getDepth() + 1;
			String sql = "insert into " + board + "(id,subject, "
						+ "content,count,ip,regdate,pos,depth) " 
						+ "values(?,?,?,0,?,now(),?,?);";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getIp());
			pstmt.setInt(5, pos);
			pstmt.setInt(6, depth);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("replyBoard()메소드에서 오류:" + e);
		} finally {
			freeResource();
		}
	}

	//글상세보기 메소드(넘겨받은 글번호를 통해서...)
	public BoardDto getBoard(int num, String board) {
		//넘겨받은 글번호를 통해서 DB로 select한 하나의 글을...
		//DTO객체에 저장하기 위해 BoardDto객체 생성
		BoardDto dto = new BoardDto(); // ctrl + space + ; (객체 빠르게 생성, java에서만 가능)
		
		try {
			con = ds.getConnection();
			
			//넘겨받은 글번호에 해당하는 글 검색 SQL문
			String sql = "select * from " + board + " where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery(); //DB에 select실행후 검색결과값 가져오기
			if(rs.next()){
				//DTO객체에 검색한 글내용 저장 (뿌려줄것만 받아올것)
				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("content"));
				dto.setCount(rs.getInt("count"));
				dto.setDepth(rs.getInt("depth"));
				dto.setIp(rs.getString("ip"));
				dto.setPos(rs.getInt("pos"));
				dto.setRegdate(rs.getTimestamp("regdate"));
				dto.setSubject(rs.getString("subject"));
			}
		} catch (Exception e) {
			System.out.println("getBoard()메소드에서 오류 : " + e);
		} finally {
			freeResource();
		}
		
		//DB로 부터 검색한 글정보가 저장된 DTO객체를 리턴
		return dto;
	}
	
	public void count(int num, String board){
		
		try {
			con = ds.getConnection();
			
			//글을 읽었을때.. 글조회수 증가시키기 SQL문
			String sql = "update " + board + " set count=count+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("count()메소드에서 오류 : " + e);
		} finally {
			freeResource();
		}
	}
	
	public String useDepth(int depth){
		String result = "";
		for (int i=0; i<depth; i++){
			result += "&nbsp;&nbsp;&nbsp;";
		}
		if (depth>0){
			result += "<img src='../images/re.gif'>";	
		}
		return result;
	}
	
	public int getMaxNum(String board){
		int maxNum = 0;
		try {
			con = ds.getConnection();
			
			//글을 읽었을때.. 글조회수 증가시키기 SQL문
			String sql = "select max(num) from " + board;
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while(rs.next()){
				maxNum = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("getMaxNum()메소드에서 오류 : " + e);
		} finally {
			freeResource();
		}
		
		return maxNum;
	}
	
	public Vector getPrevNextInfo(int num, String board){
		Vector<BoardDto> v = new Vector<BoardDto>();
		Vector<String> resultV = new Vector<String>();
		try {
			con = ds.getConnection();
			
			String sql = "select num, subject from " + board + " order by pos asc";				

			pstmt = con.prepareStatement(sql);
	
			rs = pstmt.executeQuery();

			while(rs.next()){
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt(1));
				dto.setSubject(rs.getString(2));
				v.add(dto);
			}
			
			int nowNum;
			int nowIndex=0;
			for(int i=0; i<v.size(); i++){
				BoardDto tmp = (BoardDto)v.get(i);
				nowNum = tmp.getNum();
				if (num == nowNum){
					nowIndex = i;
					// now index 가 나왔으니 여기 i 값의 +1 -1 한것들이 내가 원하는 값
					break;
				}
			}
			
			int prevIndex = nowIndex-1;
			int nextIndex = nowIndex+1;

			BoardDto prevDto;
			BoardDto nextDto;
			if (prevIndex>=0){ //prevIndex 가 0보다 값거나 커야지 표시할 값이 있다
				prevDto = (BoardDto)v.get(prevIndex);
				resultV.add(String.valueOf(prevDto.getNum()));
				resultV.add(prevDto.getSubject());
			} else {
				resultV.add("");
				resultV.add("");
			}
			
			if (nextIndex <= v.size()-1){ //max값이 v.size-1 값이다. nextIndex 가 max값보다 같거나 작아야지 표시할 값이 있다.
				nextDto = (BoardDto)v.get(nextIndex);
				resultV.add(String.valueOf(nextDto.getNum()));
				resultV.add(nextDto.getSubject());
			} else {
				resultV.add("");
				resultV.add("");
			}

			
		} catch (Exception e) {
			System.out.println("getPrevNextInfo()메소드에서 오류 : " + e);
		} finally {
			freeResource();
		}		
		
		return resultV;
	}
	
}
