package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import util.Common;

@Controller
public class ShoppingController {
	// 쇼핑몰 메인 화면 이동
	@RequestMapping("/shopping_main")
	public String shopping_main() {
		return Common.VIEW_PATH_SHOPPING + "MainForm.jsp";
	}

}
