package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import vo.M_userVO;

public class AdminInterceptor implements HandlerInterceptor {
	// controller에 들어가기 전에 작업하기 위해서
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		// 먼저 로그인 정보를 가져온다
		HttpSession session = request.getSession();
		// 가져온 로그인 정보를 lvo에 저장
		M_userVO lvo = (M_userVO) session.getAttribute("member");
		if (lvo == null || lvo.getAdminCk() == 0) { // 관리자 계정 아닌 경우

			response.sendRedirect("/missing/main.do"); // 메인페이지로 리다이렉트

			return false;

		}
		return true;	// 관리자 계정 로그인 경우(lvo != null && lvo.getAdminCk() == 1)
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}
}
