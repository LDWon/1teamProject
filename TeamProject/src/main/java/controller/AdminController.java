package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.M_userDAO;
import util.Common;
import vo.M_userVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	M_userDAO m_user_dao;

	@Autowired
	HttpServletRequest request;

	/* 관리자 메인 페이지 이동 */
	@RequestMapping("/main")
	public String adminMainGET() {
		return Common.VIEW_PATH_ADMIN + "main.jsp";
	}

	// 회원목록 조회창으로 이동
	@RequestMapping("/member_list_search")
	public String member_list_search(Model model) {
		List<M_userVO> member_list = null;
		member_list = m_user_dao.get_member_list();
		model.addAttribute("member_list", member_list);
		return Common.VIEW_PATH_ADMIN + "member_list.jsp";
	}
}
