package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.M_userDAO;
import util.Common;
import vo.M_userVO;

@Controller
public class M_userController {

	@Autowired
	M_userDAO m_user_dao;

	@Autowired
	HttpServletRequest request;

	// 회원가입시 동의 여부 화면
	@RequestMapping(value = { "/", "/member_agreement.do" })
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
	public String join(M_userVO vo) {
		m_user_dao.insert(vo);
		return "redirect:/member_agreement.do";
	}

	// 아이디 중복확인
	@RequestMapping("/dbCheckId.do")
	@ResponseBody
	public String dbCheckId(String id) {
		System.out.println("id를 가져옴 : " + id);
		int res = m_user_dao.selectAllId(id);
		if (res == 1) {
			return "[{'param':'yes'}]";
		} else {
			return "[{'param':'no'}]";
		}
	}
}
