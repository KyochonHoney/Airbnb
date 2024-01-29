package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Main2Dao;
import myVo.RepresentRoomListVo;
import myVo.RoomCategoryVo;

public class main2Action implements Action{
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      Main2Dao dao = new Main2Dao();
      int cateIdx = 1; // 기본값설정
      try {
         cateIdx = Integer.parseInt(request.getParameter("cate"));
      } catch(NumberFormatException e) {
         e.printStackTrace();
      }
//      System.out.println(cateIdx);'
      //카테고리 이름 파라미터로 받기
       // list1에 카테고리내용 담기
       ArrayList<RoomCategoryVo> list1 = Main2Dao.getCateAll();
       ArrayList<RepresentRoomListVo> roomVo = dao.getRoom(cateIdx);
      
      
      request.setAttribute("list1", list1);
      request.setAttribute("cateIdx", cateIdx); 
      request.setAttribute("roomVo",roomVo);
      RequestDispatcher rd = request.getRequestDispatcher("main2.jsp");
      rd.forward(request, response);
   }

}