package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.M_userDAO;
import util.Common;
import vo.M_userVO;

@Controller
public class M_userController {
	
	@Autowired
	M_userDAO m_user_dao;
	
	//회원가입시 동의 여부 화면
	@RequestMapping(value = { "/", "/member_agreement.do" })
	public String member_agreement() {
		return Common.VIEW_PATH_M_USER + "member_agreement_form.jsp";
	}
	//회원가입창 
	@RequestMapping("/join_form.do")
	public String join_form() {
		return Common.VIEW_PATH_M_USER+"join_form.jsp";
	}
	//회원등록
	@RequestMapping("/join.do")
	public String join(M_userVO vo) {
		m_user_dao.insert(vo);
		return "redirect:/member_agreement.do";
	}
	
	
}
