package util;

public class Common {
	public final static String REDIRECT_HOME = "redirect:/main.do";
	public final static String VIEW_PATH = "/WEB-INF/views/";
	public final static String VIEW_PATH_M_USER = "/WEB-INF/views/m_user/";
	public final static String VIEW_PATH_MISSING = "/WEB-INF/views/missing/";
	public final static String VIEW_PATH_MAIN = "/WEB-INF/views/main/";
	public final static String VIEW_PATH_SHOPPING = "/WEB-INF/views/shopping/";
	public final static String VIEW_PATH_NOTICE = "/WEB-INF/views/notice/";

	// 메인 게시글용
	public static class Missing_Board {
		// 한 페이지에 보여줄 게시물 개수
		public final static int BLOCKLIST = 10; // Common.Missing_Board.BLOCKLIST -> 10을 의미

		// 페이지 메뉴 수
		// <- 1 2 3 ->
		public final static int BLOCKPAGE = 10;
	}

	// 공지사항 게시글 페이지당 게시글 갯수 제한 지정
	public static class Notice_Board {
		// 한 페이지당 게시글 개수를 지정합니다
		public final static int BLOCKLIST = 10; // 한페이지당 10개의 게시글을 표시

		public final static int BLOCKPAGE = 10; // 하단의 페이지 메뉴수를 10개까지 표시 가능 ex) <- 1 2 3 ...10 ->
	}
}
