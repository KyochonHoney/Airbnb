package swAction;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import swDao.ExperienceDao;
import swVo.ExpCateVo;
import swVo.ExpReviewVo;
import swVo.ExperienceVo;

@WebServlet("/ExpMain")
public class ExpMainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ExperienceVo experienceVO = null;
		ExpCateVo expcateVO = null;
		ExpReviewVo expreviewVO = null;
		int idx = Integer.parseInt(request.getParameter("exp_idx"));
		
		
		ExperienceDao eDao = new ExperienceDao();
		experienceVO = eDao.getExpInfo(idx);
		ArrayList<ExperienceVo> listExperienceVo = eDao.getExpList(experienceVO.getExpIdx());
		String expCate = eDao.getExpCateTitle(experienceVO.getExpIdx());
		ArrayList<ExperienceVo> listInfoExp = eDao.getInfoExpList(experienceVO.getExpIdx());
		expreviewVO = eDao.getExpReview(idx);
		
		request.setAttribute("experienceVO", experienceVO);
		request.setAttribute("listExperienceVo", listExperienceVo);
		request.setAttribute("expCate", expCate);
		request.setAttribute("listInfoExp", listInfoExp);
		request.setAttribute("expreviewVO", expreviewVO);
		RequestDispatcher rd = request.getRequestDispatcher("ExpMain.jsp");
		rd.forward(request, response);
	}
}
