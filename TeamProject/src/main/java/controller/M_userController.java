package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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

	//임시 메인 화면
	@RequestMapping(value= {"/","/home"})
	public String main() {
		return Common.VIEW_PATH +"main.jsp";
	}
	
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
		return "redirect:/home";
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

	//로그인 입력창
	@RequestMapping("/loginForm")
	public String loginForm() {
		return Common.VIEW_PATH_M_USER+"login_form.jsp";
	}
	//로그인
	@RequestMapping("/login")
	@ResponseBody
	public String login(String id,String pwd) {
		M_userVO vo =new M_userVO();
		vo.setId(id);
		vo.setPwd(pwd);
		int res=m_user_dao.infoConfirm(vo);
		if (res==10) {//로그인 성공
			return "[{'param':'Y'}]";
		}else if (res==20) {//이메일 인증만 안되있을 시
			return "[{'param':'noEmail'}]";
		}else if (res==15) {//비밀번호 불일치
			return "[{'param':'noPwd'}]";
		}else if (res==25) {//아이디 불일치
			return "[{'param':'noId'}]";
		}else if (res==30) {//회원정보 없음
			return "[{'param':'noInfo'}]";
		}
		return "[{'param':'error'}]";
	}
}
