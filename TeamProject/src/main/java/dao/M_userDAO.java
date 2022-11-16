package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.M_userVO;

@Repository("m_user_dao")
public class M_userDAO {
	@Autowired
	SqlSession sqlSession;
	
	//회원등록
	public int insert(M_userVO vo) {
		int res = sqlSession.insert("u.user_insert",vo);
		return res;
	}
}
