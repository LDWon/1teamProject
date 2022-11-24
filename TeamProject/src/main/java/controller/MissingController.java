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
import vo.MissingRegionVO;
import vo.MissingVO;

@Controller
public class MissingController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	MissingDAO missing_dao;

	@Autowired
	ServletContext application;

	// 메인 페이지
	@RequestMapping(value = { "/", "/main.do" })
	public String main() {
		return Common.VIEW_PATH_MAIN + "main.jsp";
	}

	// 메인글 페이지 보기 (step이 0임)
	@RequestMapping("/missing_list.do")
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
		map.put("start", start);
		map.put("end", end);

		List<MissingVO> list = missing_dao.selectList(map);

		// 전체 게시물 수 조회
		int rowTotal = missing_dao.getRowTotal();

		String pageMenu = Paging.getPaging("missing_list.do", nowPage, // 현재 페이지 번호
				rowTotal, // 전체 게시물 수
				Common.Missing_Board.BLOCKLIST, // 한 페이지에 표기할 게시물 수
				Common.Missing_Board.BLOCKPAGE); // 페이지 메뉴 수

		// 조회수를 위해 저장해뒀던 show라는 정보를 세션에서 제거
		request.getSession().removeAttribute("show");

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.VIEW_PATH_MISSING + "missing_list.jsp?page=" + nowPage;
		// ?를 포함한 문구가 매핑다음에 따라온다.
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

		// 조회수 증가(F5를 연타했을 때 조회수가 급상승 하는걸 방지)
		HttpSession session = request.getSession();
		String show = (String) session.getAttribute("show");

		if (show == null) {
			int res = missing_dao.update_readhit(idx);
			// 세션에 "show"라는 이름으로 저장
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

	// 메인글 수정하기 페이지로 이동
	@RequestMapping("/missing_modify_form.do")
	public String missing_modify_form(Model model, int idx) {

		MissingVO vo = missing_dao.selectOne(idx);

		model.addAttribute("vo", vo);

		return Common.VIEW_PATH_MISSING + "missing_modify_form.jsp";
	}

	// 메인글을 수정하기
	@RequestMapping("/missing_modify.do")
	public String missing_modify(int idx, String subject, String region, String content, MultipartFile photo,
			int page) {

		MissingVO basevo = missing_dao.selectOne(idx);

		String ip = request.getRemoteAddr();

		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		System.out.println(savePath);

		// 업로드한 파일의 정보
		basevo.setPhoto(photo);
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

		basevo.setFilename(filename);

		basevo.setSubject(subject);
		basevo.setRegion(region);
		basevo.setContent(content);
		basevo.setIp(ip);

		int res = missing_dao.missing_update(basevo);

		if (res > 0) {
			return "redirect:missing_view.do?idx=" + idx + "&page=" + page;
		} else {
			return null;
		}
	}

	// 댓글달기

	@RequestMapping("missing_reply.do")
	public String missing_reply(Model model, int idx, String content, int page) {

		// 기준글 idx를 사용해서 게시물의 정보 얻기
		MissingVO basevo = missing_dao.selectOne(idx);

		// 기준글의 step보다 큰 값은 step = step + 1 처리
		int res = missing_dao.update_step(basevo);
		String ip = request.getRemoteAddr();

		// 댓글VO로 포장
		MissingVO vo = new MissingVO();
		vo.setContent(content);
		vo.setIp(ip);
		// 댓글이 들어갈 위치 설정
		vo.setRef(basevo.getRef());
		vo.setStep(basevo.getStep() + 1);

		res = missing_dao.reply(vo);

		if (res > 0) {
			return "redirect:missing_view.do?idx=" + idx + "&page=" + page;
		} else {
			return null;
		}

	}

	// 댓글보기 페이지로 이동
	@RequestMapping("missing_reply_list.do")
	public String missing_reply_list(Model model, int idx, String page, MissingVO vo) {

		List<MissingVO> list = missing_dao.selectList_reply(vo); // 댓글을 리스트로 묶기
		model.addAttribute("list", list); // 바인딩하기

		return Common.VIEW_PATH_MISSING + "missing_reply_list.jsp?idx=" + idx + "&page=" + page;
	}

	// 지역별로 메인글 보기
	@RequestMapping("/missing_region_list.do")
	public String missing_region_list(Model model, String page, String region) {

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
		map.put("start", start);
		map.put("end", end);

		List<MissingVO> list = null;

		if (region.equals("전체")) { // 전체 지역 불러오기
			list = missing_dao.selectList(map);
		} else {
			// 지역 검색해서 해당 글 불러오기
			start = map.get("start");
			end = map.get("end");
			MissingRegionVO mrvo = new MissingRegionVO();
			mrvo.setStart(start);
			mrvo.setEnd(end);
			mrvo.setRegion(region);
			list = missing_dao.selectList_region(mrvo);
		}

		// 지역별 전체 게시물 수 조회
		int rowTotal = missing_dao.getRowTotal_region(region);

		String pageMenu = Paging.getPaging_region("missing_region_list.do?region=" + region, nowPage, // 현재 페이지 번호
				rowTotal, // 전체 게시물 수
				Common.Missing_Board.BLOCKLIST, // 한 페이지에 표기할 게시물 수
				Common.Missing_Board.BLOCKPAGE); // 페이지 메뉴 수

		// 조회수를 위해 저장해뒀던 show라는 정보를 세션에서 제거
		request.getSession().removeAttribute("show");

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.VIEW_PATH_MISSING + "missing_list.jsp?page=" + nowPage;
		// ?를 포함한 문구가 매핑다음에 따라온다.

	}

	// About us 화면이동
	@RequestMapping("/about.do")
	public String about() {
		return Common.VIEW_PATH_MAIN + "aboutus.jsp";
	}

}
