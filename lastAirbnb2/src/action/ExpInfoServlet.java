package action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ExperienceDao;
import swVo.ExpCateVo;
import swVo.ExpOnlineVo;
import swVo.ExpReviewVo;
import swVo.ExperienceVo;

@WebServlet("/ExpInfo")
public class ExpInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ExperienceVo experienceVO = null;
		ExpCateVo expcateVO = null;
		ExpReviewVo expreviewVO = null;
		ExpOnlineVo exponlineVO = null;
		int idx = Integer.parseInt(request.getParameter("exp_idx"));
		
		ExperienceDao eDao = new ExperienceDao();
		experienceVO = eDao.getExpInfo(idx);
		ArrayList<ExperienceVo> listExperienceVo = eDao.getExpList(experienceVO.getExpIdx());
		String expCate = eDao.getExpCateTitle(experienceVO.getExpIdx());
		ArrayList<ExperienceVo> listInfoExp = eDao.getInfoExpList(experienceVO.getExpIdx());
		expreviewVO = eDao.getExpReview(idx);
		ArrayList<ExpReviewVo> listExpReview = eDao.getReviewList(idx);
		exponlineVO = eDao.getExpType(idx);
		ArrayList<ExpOnlineVo> listOnlineType = eDao.getOnlineList(idx);
		
		request.setAttribute("experienceVO", experienceVO);
		request.setAttribute("listExperienceVo", listExperienceVo);
		request.setAttribute("expCate", expCate);
		request.setAttribute("listInfoExp", listInfoExp);
		request.setAttribute("expreviewVO", expreviewVO);
		request.setAttribute("listExpReview", listExpReview);
		request.setAttribute("idx", idx);
		request.setAttribute("exponlineVO", exponlineVO);
		request.setAttribute("listOnlineType", listOnlineType);
		RequestDispatcher rd = request.getRequestDispatcher("ExpInfo.jsp");
		rd.forward(request, response);
	}
}
