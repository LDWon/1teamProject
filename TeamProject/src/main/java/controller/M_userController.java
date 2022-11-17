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
	/*
	 * https://jee2memory.tistory.com/entry/%EC%8A%A4%ED%94%84%EB%A7%81-%ED%94%84%EB
	 * %A0%88%EC%9E%84%EC%9B%8C%ED%81%AC-%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85-%EC%8B
	 * %9C-%EC%9D%B4%EB%A9%94%EC%9D%BC-%EC%9D%B8%EC%A6%9D-%EA%B5%AC%ED%98%84%ED%95%
	 * 98%EA%B8%B0
	 */	
	
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
			return "[{'param':'no'}]";
		} else {
			return "[{'param':'yes'}]";
		}
	}
}
