package dao;



import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.MissingVO;


@Repository("missing_dao")
public class MissingDAO {
	@Autowired
	SqlSession sqlSession;
	
	//메인글 불러오기
	public List<MissingVO> selectList(HashMap<String, Integer> map) {
		List<MissingVO> list = null;
		list = sqlSession.selectList("m.missing_list", map);
		return list;
	}
	
	
	//메인글 추가
	public int insert(MissingVO vo) {
		int res = sqlSession.insert("m.missing_insert", vo);		
		return res;
	}
	
	
	//idx에 해당하는 메인글 상세조회
	public MissingVO selectOne(int idx) {
		MissingVO vo = sqlSession.selectOne("m.missing_view", idx);
		return vo;
	}
	
	
	//idx에 해당하는 메인글 삭제하기
	public int delete(int idx) {
		int res = sqlSession.delete("m.missing_delete", idx);
		return res;
	}
	
	
	
	
	//전체 메인글 수 조회
	public int getRowTotal() {
		int count = sqlSession.selectOne("m.missing_count");
		return count;
	}
	
	

	//조회수증가
	public int update_readhit(int idx) {
		int res = sqlSession.update("m.missing_readhit", idx);		
		return res;		
	}
	
	

	//메인글 수정하기
	public int missing_update(MissingVO vo) {
		int res = sqlSession.update("m.missing_update", vo);
		return res;
	}
	
	
	
	
	 //댓글추가를 위한 step+1 
	public int update_step(MissingVO vo) { 
		int res = sqlSession.update("m.missing_update_step", vo); 
	 	return res;
	 }
	 
	 
	 //댓글 추가 
	public int reply(MissingVO vo) {
		int res = sqlSession.insert("m.missing_reply", vo); 
		return res;
	}
	 
	
	//댓글 창 보여주기
	public List<MissingVO> selectList_reply(MissingVO vo) {
		List<MissingVO> list = null;
		list = sqlSession.selectList("m.missing_list_reply", vo);
		return list;
	}
	
	
	
	//지역에 맞는 메인글 찾기 
	public List<MissingVO> selectList_region(String region) {
		List<MissingVO> list = null;
		list = sqlSession.selectList("m.missing_list_region", region);
		return list;
	}
	
}
