package myAction;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import myDao.Main2Dao;
import myVo.RepresentRoomListVo;
import myVo.RoomCategoryVo;

public class main2Action implements Action{
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      Main2Dao dao = new Main2Dao();
      int cateIdx = 1; // 湲곕낯媛믪꽕�젙
      try {
         cateIdx = Integer.parseInt(request.getParameter("cate"));
      } catch(NumberFormatException e) {
         e.printStackTrace();
      }
//      System.out.println(cateIdx);'
      //移댄뀒怨좊━ �씠由� �뙆�씪誘명꽣濡� 諛쏄린
       // list1�뿉 移댄뀒怨좊━�궡�슜 �떞湲�
       ArrayList<RoomCategoryVo> list1 = Main2Dao.getCateAll();
       ArrayList<RepresentRoomListVo> roomVo = dao.getRoom(cateIdx);
      
      
      request.setAttribute("list1", list1);
      request.setAttribute("cateIdx", cateIdx); 
      request.setAttribute("roomVo",roomVo);
      RequestDispatcher rd = request.getRequestDispatcher("main2.jsp");
      rd.forward(request, response);
   }

}