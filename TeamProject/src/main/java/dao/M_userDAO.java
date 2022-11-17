package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.M_userVO;

@Repository("m_user_dao")
public class M_userDAO {
	@Autowired
	SqlSession session;

	// 회원등록
	public int insert(M_userVO vo) {
		int res = session.insert("u.user_insert", vo);
		return res;
	}

	// 아이디 중복확인
	public int selectAllId(String id) {
		int result = -1; // 오류 발생
		result = session.selectOne("u.selectAllId", id);
		return result;
	}

	// <!-- 이메일인증을 위한 랜덤번호 저장 -->
	public int updateMailKey(M_userVO vo) {
		return session.update("u.updateMailKey", vo);
	}

	// <!-- 메일 인증시 mail_auth를 기본값 0에서 1로 변경(로그인 허용) -->
	public int updateMailAuth(M_userVO vo) {
		return session.update("u.updateMailAuth", vo);
	}

	// <!-- 로그인시 인증 체크 확인 -->
	public int emailAuthFail(String id) {
		return session.selectOne("u.emailAuthFail", id);
	}
}
