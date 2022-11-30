package controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import dao.M_userDAO;
import dao.NoticeDAO;
import util.Common;
import vo.M_userVO;
import vo.NoticeVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	M_userDAO m_user_dao;

	@Autowired
	HttpServletRequest request;

	@Autowired
	NoticeDAO notice_dao; // NoticeDAO를 가져오기 위해 notice_dao 선언

	@Autowired
	ServletContext application;

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
	//회원 목록에서 검색하기
	@RequestMapping("/member_list_searching")
	public String member_list_searching(Model model, String search_type,String search_word) {
		List<M_userVO> list = null;
		if (search_type.equals("전체")) {
			list = m_user_dao.search_member_list_all(search_word);
		}else if (search_type.equals("아이디")) {
			list = m_user_dao.search_member_list_id(search_word);
		}else if (search_type.equals("이름")) {
			list = m_user_dao.search_member_list_name(search_word);
		}
		model.addAttribute("member_list",list);
		return Common.VIEW_PATH_ADMIN + "member_list.jsp";
	}
	
	// 글 추가 페이지로 이동
	@RequestMapping("/notice_insert_form.do")
	public String insert_form() {
		return Common.VIEW_PATH_NOTICE + "notice_insert.jsp";
	}

	// 공지사항 등록
	@RequestMapping("/notice_insert.do")
	public String notice_insert(NoticeVO vo) {
		// 입력한 제목, 작성자, 지역, 내용

		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);

		// 업로드한 파일의 정보
		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";

		// 업로드된 파일이 존재하면
		if (!photo.isEmpty()) {
			filename = photo.getOriginalFilename(); // 진짜이름 부여

			File saveFile = new File(savePath, filename);
			if (!saveFile.exists()) {
				saveFile.mkdirs();
			} else { // 동일파일명 방지
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}

			// 업로드를 위한 실제 파일을 물리적으로 기록
			try {
				photo.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		vo.setFilename(filename); // vo에 묶어서 전달

		int res = notice_dao.insert(vo);
		if (res > 0) {
			return "redirect:../notice_list.do";
		} else {
			return null;
		}
	}
}
