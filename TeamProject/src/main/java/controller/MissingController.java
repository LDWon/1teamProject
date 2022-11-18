package controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.MissingDAO;
import util.Common;
import util.Paging;
import vo.MissingVO;

@Controller
public class MissingController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	MissingDAO missing_dao;

	@Autowired
	ServletContext application;

	//메인 페이지
	@RequestMapping(value = { "/", "/main.do" })
	public String main () {
		return Common.VIEW_PATH_MAIN+"main.jsp";
	}
	
	// 메인글 페이지 보기 (step이 0임)
	@RequestMapping("/missing_list.do" )
	public String missing_list(Model model, String page) {

		int nowPage = 1;

		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		// 한 페이지에 표시가 될 게시물의 시작과 끝 번호 계산
		// page가 1이면 1~10까지 계산되어야 함
		// page가 2이면 11~20까지 계산되어야 함
		int start = (nowPage - 1) * Common.Missing_Board.BLOCKLIST + 1;
		int end = start + Common.Missing_Board.BLOCKLIST - 1;

		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start",start);
		map.put("end",end);
		
		
		List<MissingVO> list = missing_dao.selectList(map);
		
		//전체 게시물 수 조회
		int rowTotal = missing_dao.getRowTotal();
		
		String pageMenu = Paging.getPaging("missing_list.do", 
				   nowPage, //현재 페이지 번호 
				   rowTotal, //전체 게시물 수
				   Common.Missing_Board.BLOCKLIST, //한 페이지에 표기할 게시물 수
				   Common.Missing_Board.BLOCKPAGE); //페이지 메뉴 수
		
		//조회수를 위해 저장해뒀던 show라는 정보를 세션에서 제거
		request.getSession().removeAttribute("show");
		
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.VIEW_PATH_MISSING + "missing_list.jsp?page=" + nowPage;
		//?를 포함한 문구가 매핑다음에 따라온다.
	}

	
	
	// 글을 등록하기 위한 페이지로 이동
	@RequestMapping("/missing_insert_form.do")
	public String missing_insert_form() {
		return Common.VIEW_PATH_MISSING + "missing_insert_form.jsp";
	}

	
	
	// 메인글을 등록하기
	@RequestMapping("/missing_insert.do")
	public String missing_insert(MissingVO vo) {
		// 입력한 제목, 작성자, 지역, 내용
		String ip = request.getRemoteAddr();
		// ip까지 받고
		vo.setIp(ip);

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

		int res = missing_dao.insert(vo);
		if (res > 0) {
			return "redirect:missing_list.do";
		} else {
			return null;
		}
	}

	
	
	// 메인글 상세보기
	@RequestMapping("/missing_view.do")
	public String missing_view(Model model, int idx) {

		MissingVO vo = missing_dao.selectOne(idx);
		
		//조회수 증가(F5를 연타했을 때 조회수가 급상승 하는걸 방지)
		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");
				
		if (show == null) {
			int res = missing_dao.update_readhit(idx);
			//세션에 "show"라는 이름으로 저장
			session.setAttribute("show", "0");
		}

		model.addAttribute("vo", vo);

		return Common.VIEW_PATH_MISSING + "missing_view.jsp";
	}

	
	
	// 메인글 삭제하기
	@RequestMapping("/missing_del.do")
	@ResponseBody
	public String missing_del(int idx) {

		int res = missing_dao.delete(idx);

		if (res == 1) {
			return "[{'param':'yes'}]";
		} else {
			return "[{'param':'no'}]";
		}
	}

	
	
	//메인글 수정하기 페이지로 이동
	@RequestMapping("/missing_modify_form.do")
	public String missing_modify_form(Model model, int idx) {
		
		MissingVO vo = missing_dao.selectOne(idx);
		
		model.addAttribute("vo", vo);
		
		return Common.VIEW_PATH_MISSING + "missing_modify_form.jsp";
	}
	
	
	
	
	//메인글을 수정하기
	@RequestMapping("/missing_modify.do")
	public String missing_modify(int idx, String subject, String region, String content, String filename, int page) {
		
		MissingVO basevo = missing_dao.selectOne(idx);
		
		String ip = request.getRemoteAddr();
		
		basevo.setSubject(subject);
		basevo.setRegion(region);
		basevo.setContent(content);
		basevo.setFilename(filename);
		basevo.setIp(ip);
		
		int res = missing_dao.missing_update(basevo);
		
		if (res > 0) {
			return "redirect:missing_list.do?page=" + page;
		} else {
			return null;
		}
	}
//	@RequestMapping("/search.do")
//	public String addr(Model model ,String addr){
//		 
//		
//		String search ="all";
//		String str_search = addr;
//		
//		//정상적으로 내용이 들어온 경우만 
//	    if(str_search != null && !str_search.isEmpty()) {
//		    search = str_search;
//		  }
//		List<MissingVO> list = null;
//		
//		//아무것도 입력 안하고 검색 눌렀을 때 -> 경고창(키워드를 입력하세요)
//		//아무것도 입력 안하고 검색 눌렀을 때 -> 1페이지부터 보여줄껀지
//		if(search.equalsIgnoreCase("all")) {
//			HashMap<String, Integer> map = new HashMap<String, Integer>();
//			
//			list = missing_dao.selectList(map);
//		}else {
//			//내가 검색만 지역만 보기 
//			list = missing_dao.addr(search);
//		}
//		
//	    model.addAttribute("list",list);
//		
//		return Common.VIEW_PATH_ADDR+"addr.jsp";
//	}
	
}
