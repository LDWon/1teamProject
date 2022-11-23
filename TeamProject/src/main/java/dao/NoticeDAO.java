package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.MissingVO;
import vo.NoticeVO;

@Repository("notice_dao")
public class NoticeDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	//공지사항 메인글 불러오기 
	public List<NoticeVO> noticeList(HashMap<String, Integer> map) { //notice (공지사항) 리스트 불러오는 변수명 noticeList 함수 생성 
		List<NoticeVO> n_list = null;    //NoticeVO를 참조하는 List 의 변수명 list를  null값을 넣어주어 초기화 **안넣어도 되는지 확인해야함**
		n_list = sqlSession.selectList("m.notice_list",map); // notice mapper의 쿼리문과 map객체를 파라미터로 받아 list에 담아준다.
		return n_list;
	}
	
	//전체 메인글 수 조회
		public int getRowTotal() {
			int count = sqlSession.selectOne("m.notice_count"); //notice.xml에  개시글갯수를 가져오는부분 
			return count;
		}
		
		//idx에 해당하는 메인글 상세조회
		public NoticeVO selectOne(int idx) {
			NoticeVO vo = sqlSession.selectOne("m.notice_view", idx);
			return vo;
		}
	
	

}
