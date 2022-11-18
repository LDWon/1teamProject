package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import util.Common;

@Controller

public class AboutUsController {

	@RequestMapping("/about.do")
	public String about() {
		
		return Common.VIEW_PATH_MAIN + "aboutus.jsp";
	}
	
	
}
