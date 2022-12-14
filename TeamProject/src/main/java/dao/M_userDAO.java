package dao;

import java.util.List;

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

	// 로그인 id정보 확인
	public String infoConfirmId(M_userVO vo) {
		String resInfoId_pwd = session.selectOne("u.infoConfirmId", vo);
		if (resInfoId_pwd != null) {
			return resInfoId_pwd;
		} else {
			return null;
		}
	}

	// 이메일 인증여부 확인
	public String infoConfirmEmail(M_userVO vo) {
		int resInfoEmail = session.selectOne("u.infoConfirmEmail", vo);
		if (resInfoEmail == 1) {// 이메일 인증확인
			return "yes";
		} else {// 이메일 인증이 아직 안돼있을 경우
			return "no";
		}
	}

	// 로그인 성공시 회원정보 받아오기
	public M_userVO get_member_information(M_userVO vo) {
		return session.selectOne("u.get_member_information", vo);
	}

	// 회원정보 불러오기
	public List<M_userVO> get_member_list() {
		List<M_userVO> list = null;
		list = session.selectList("u.get_member_list");
		return list;
	}

	//관리자 페이지에서 회원 정보 검색하기
	public List<M_userVO> search_member_list_all(String search_word) {
		List<M_userVO> list = session.selectList("u.search_member_list_all",search_word);
		return list;
	}
	//관리자 페이지에서 회원 정보 아이디 검색하기
	public List<M_userVO> search_member_list_id(String search_word){
		List<M_userVO> list = session.selectList("u.search_member_list_id",search_word);
		return list;
	}
	//관리자 페이지에서 회원 정보 이름 검색하기
	public List<M_userVO> search_member_list_name(String search_word){
		List<M_userVO> list = session.selectList("u.search_member_list_name",search_word);
		return list;
	}
}
