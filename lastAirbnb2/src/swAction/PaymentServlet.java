package swAction;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import swDao.PaymentDao;
import swVo.ExpReviewVo;
import swVo.ExperienceVo;

@WebServlet("/Payment")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ExperienceVo experienceVO = null;
		ExpReviewVo expreviewVO = null;
		int idx = Integer.parseInt(request.getParameter("exp_idx"));
		
		PaymentDao pDao = new PaymentDao();
		experienceVO = pDao.getExpInfo(idx);
		expreviewVO = pDao.getExpReview(idx);
		
		request.setAttribute("experienceVO", experienceVO);
		request.setAttribute("expreviewVO", expreviewVO);
		
		RequestDispatcher rd = request.getRequestDispatcher("Payment.jsp");
		rd.forward(request, response);
	}
}
