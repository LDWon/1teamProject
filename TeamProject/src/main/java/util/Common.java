package util;

public class Common {
	public final static String REDIRECT_HOME = "redirect:/main.do";
	public final static String VIEW_PATH = "/WEB-INF/views/";
	public final static String VIEW_PATH_M_USER = "/WEB-INF/views/m_user/";
	public final static String VIEW_PATH_MISSING = "/WEB-INF/views/missing/";
	public final static String VIEW_PATH_MAIN = "/WEB-INF/views/main/";
	public final static String VIEW_PATH_SHOPPING = "/WEB-INF/views/shopping/";

	// 메인 게시글용
	public static class Missing_Board {
		// 한 페이지에 보여줄 게시물 개수
		public final static int BLOCKLIST = 10; // Common.Missing_Board.BLOCKLIST -> 10을 의미

		// 페이지 메뉴 수
		// <- 1 2 3 ->
		public final static int BLOCKPAGE = 10;
	}
}
