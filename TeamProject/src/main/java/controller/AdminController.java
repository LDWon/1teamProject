package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import util.Common;

@Controller
@RequestMapping("/admin")
public class AdminController {
	/* 관리자 메인 페이지 이동 */
	@RequestMapping("/main")
	public String adminMainGET() {
		return Common.VIEW_PATH_ADMIN + "main.jsp";
	}
}
