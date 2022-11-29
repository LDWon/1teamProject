package controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.NoticeDAO;
import util.Common;
import util.Paging;
import vo.NoticeVO;

@Controller
public class NoticeController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	NoticeDAO notice_dao; // NoticeDAO를 가져오기 위해 notice_dao 선언

	@Autowired
	ServletContext application;

	// 공지사항 메인글 구현 ( 페이징 처리와 페이지메뉴 처리 기능 구현 ) util 폴더에 paging 파일에 구현되어있는 파일을 참조
	@RequestMapping("/notice_list.do")
	public String notice_list(Model model, String page) {

		int nowpage = 1;

		if (page != null && !page.isEmpty()) {
			nowpage = Integer.parseInt(page);
		}

		// 총 10개의 표시 게시글을 위한 작업
		int start = (nowpage - 1) * Common.Notice_Board.BLOCKLIST + 1; // 시작값 1
		int end = start + Common.Notice_Board.BLOCKLIST - 1; // 끝값 10

		// 위의 게시글 표시의 start,end 변수명을 HashMap에 담는다.
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start); // put = start키값에 start값
		map.put("end", end); // put = end키값에 end 값

		List<NoticeVO> list = notice_dao.selectList(map);// list 에 noticedao의 noticeList로 함수지정된 메서드 호출 파마리터로 (map을
															// 같이포함해서 넣어준다 )

		// 전체 게시물 수 조회
		int rowTotal = notice_dao.getRowTotal();// NoticeDAO에 게시글 조회 함수명 지정되어있음 getRowTotal

		String pageMenu = Paging.getPaging("notice_list.do", nowpage, // 현재 페이지 번호
				rowTotal, // 전체 게시물 수
				Common.Notice_Board.BLOCKLIST, // 한 페이지에 표기할 게시물 수
				Common.Notice_Board.BLOCKPAGE); // 페이지 메뉴 수

		// 조회수를 위해 저장해뒀던 show라는 정보를 세션에서 제거
		request.getSession().removeAttribute("show");

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.VIEW_PATH_NOTICE + "notice_list.jsp?page=" + nowpage;
	}

	// 위의 공지사항 을 페이징 처리에 맞게 리스스트를 보여주기위한 구현 부분
	@RequestMapping("/notice_view.do")
	public String notice_view(Model model, int idx) {

		NoticeVO vo = notice_dao.selectOne(idx);

		model.addAttribute("vo", vo);

		return Common.VIEW_PATH_NOTICE + "notice_view.jsp";
	}

}
