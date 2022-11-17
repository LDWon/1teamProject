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
	//로그인
	public int infoConfirm(M_userVO vo) {
		//회원정보 확인
		int resInfo=session.selectOne("u.infoConfirm",vo);
		if (resInfo==1) {//회원정보가 있을때
			//이메일 인증여부 확인
			int resInfoEmail=session.selectOne("u.infoConfirmEmail",vo);
			if (resInfoEmail==1) {//이메일 인증확인
				return 10;
			}else {//이메일 인증이 아직 안돼있을 경우
				return 20;
			}
		}else {//회원정보가 없을 때
			//아이디,비밀번호 일치 확인
			int resInfoId=session.selectOne("u.infoConfirmId",vo);
			int resInfoPwd=session.selectOne("u.infoConfirmPwd",vo);
			if (resInfoId==1) {//비밀번호 불일치
				return 15;
			}else if (resInfoPwd>=1) {//아이디 불일치
				return 25;
			}else {//둘다 불일치
				return 30;
			}
		}
	}
}
