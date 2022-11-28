package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.M_userDAO;
import mail.MailHandler;
import mail.TempKey;
import util.Common;
import vo.M_userVO;

@Controller
public class M_userController {

	@Autowired
	M_userDAO m_user_dao;

	@Autowired
	HttpServletRequest request;

	@Autowired
	JavaMailSender mailSender;

	// 비밀번호 암호화를 위한
	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	// 회원가입시 동의 여부 화면
	@RequestMapping("/member_agreement.do")
	public String member_agreement() {
		return Common.VIEW_PATH_M_USER + "member_agreement_form.jsp";
	}

	// 회원가입창
	@RequestMapping("/join_form.do")
	public String join_form() {
		return Common.VIEW_PATH_M_USER + "join_form.jsp";
	}

	// 회원등록
	@RequestMapping("/join.do")
	public String join(M_userVO vo) throws Exception {
		// 랜덤 문자열을 생성하여 mail_key에 넣기
		String mail_key = new TempKey().getKey(30, false);
		vo.setMail_key(mail_key);
		// 비밀번호 인코딩(암호화)
		String rawPw = ""; // 인코딩 전 비밀번호
		String encodePw = ""; // 인코딩 후 비밀번호
		rawPw = vo.getPwd(); // 비밀번호 데이터 얻음
		encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		vo.setPwd(encodePw); // 인코딩된 비밀번호 member객체에 다시 저장
		// 회원가입
		m_user_dao.insert(vo);
		m_user_dao.updateMailKey(vo);
		// 회원가입 완료되면 인증을 위한 이메일 발송
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[FIND 인증메일 입니다.]"); // 메일제목
		sendMail.setText("<h1>FIND 메일인증</h1>" + "<br>FIND에 오신 것을 환영합니다." + "<br>아래 [이메일 인증 확인]을 눌러주세요."
				+ "<br><a href='http://localhost:9090/missing/registerEmail.do?email=" + vo.getEmail() + "&mail_key="
				+ mail_key + "' target='_blank'>이메일 인증 확인</a>");
		sendMail.setFrom("testemailcertification@gmail.com", "FIND");
		sendMail.setTo(vo.getEmail());
		sendMail.send();
		return Common.REDIRECT_HOME;
	}

	// 이메일 인증 확인을 누를때
	@RequestMapping("/registerEmail.do")
	public String emailConfirm(M_userVO vo) throws Exception {
		m_user_dao.updateMailAuth(vo);
		return Common.VIEW_PATH_M_USER + "emailAuthSuccess.jsp";
	}

	// 아이디 중복확인
	@RequestMapping("/dbCheckId.do")
	@ResponseBody
	public String dbCheckId(String id) {
		System.out.println("id를 가져옴 : " + id);
		int res = m_user_dao.selectAllId(id);
		if (res == 1) {
			return "[{'param':'no'}]";
		} else {
			return "[{'param':'yes'}]";
		}
	}

	// 로그인 입력창
	@RequestMapping("/loginForm")
	public String loginForm() {
		return Common.VIEW_PATH_M_USER + "login_form.jsp";
	}

	// 로그인
	@RequestMapping("/login")
	@ResponseBody
	public String login(String id, String pwd) {
		M_userVO vo = new M_userVO();
		vo.setId(id);
		vo.setPwd(pwd);
		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";
		// resInfoId_pwd의 값이 null이 아니면 id가 존재
		String resInfoId_pwd = m_user_dao.infoConfirmId(vo);
		// 아이디가 존재할 경우 비밀번호 대조
		if (resInfoId_pwd != null) {// 아이디가 존재할 경우
			rawPw = vo.getPwd(); // 사용자가 제출한 비밀번호
			encodePw = resInfoId_pwd; // 데이터베이스에 저장한 인코딩된 비밀번호
			if (true == pwEncoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단
				// 이메일 인증여부 확인
				String resInfoEmail = m_user_dao.infoConfirmEmail(vo);
				if (resInfoEmail == "yes") {// 로그인 성공
					// 로그인 성공시 회원정보 가져오기
					M_userVO lvo = m_user_dao.get_member_information(vo);
					// 회원정보 세션에 저장
					session.setAttribute("member", lvo);
					return "[{'param':'Y'}]";
				} else if (resInfoEmail == "no") {// 이메일 인증만 안되있을 시
					return "[{'param':'noEmail'}]";
				}
			} else {
				// 비밀번호가 일치하지 않는경우
				return "[{'param':'noPwd'}]";
			}
		} else {// 아이디가 존재하지 않을 경우
			return "[{'param':'noId'}]";
		}
		return "[{'param':'error'}]";
	}

	// 로그아웃
	@RequestMapping("/logout")
	public String logout() {
		HttpSession session = request.getSession();
		// 세션 전부 삭제
		session.invalidate();
		return Common.REDIRECT_HOME;
	}

	/* 비동기방식 로그아웃 메서드 */
	@RequestMapping("/logout.do")
	@ResponseBody
	public void logoutPOST() throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
	}
}
