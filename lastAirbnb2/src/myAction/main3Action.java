package myAction;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import myDao.Main3Dao;
import myVo.ConvenientVo;
import myVo.ReviewVo;
import myVo.RoomExplainVo;
import myVo.RoomImageVo;
import myVo.RoomInfoVo;
import myVo.RoomVo;
import myVo.StayVo;
import esVo.UserInfoVo;

public class main3Action implements Action{

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      Main3Dao dao3 = new Main3Dao();
   
      // main2.jsp�뜝�럥�뱺�뜝�럡�맋 �뜝�럡�맂�뇦爰용쳛�뜝占� �뜝�럥�빣�뜝�럥爰뻟dx,�뜝�럩源덂뜝�럥裕욃뜝�럥諭쐇dx �뛾�룇猷꾤뵳占�
      int roomIdx = Integer.parseInt(request.getParameter("roomIdx"));
      RoomVo roomvo = dao3.getRoom(roomIdx);
      int hostidx = roomvo.getUser_idx();
      
      
      // 占쎈쇀占쎈닗nfo �뜝�럩�겱占쎈ご占쎈뼬�뵳占�
      String str = roomvo.getRoom_info_idx(); //1,2,3
      String[] str2 = str.split(",");
      
      String conv = roomvo.getConvenient_idx();
      

                                                
      int countReview = dao3.getCountReview(roomIdx);
      RoomImageVo imagevo = dao3.getRoomImage(roomIdx);
      UserInfoVo uservo = dao3.getUserInfo(hostidx);
      RoomExplainVo explainvo = dao3.getRoomExplain(roomIdx);
      ArrayList<RoomInfoVo> roominfovo = dao3.getRoomInfo(roomIdx,str2);
      ArrayList<ConvenientVo> convenientvo = dao3.getConvenientV2(conv);
      ArrayList<ReviewVo> reviewvo = dao3.getReview(roomIdx);
      ArrayList<StayVo> stayvo = dao3.getStay(roomIdx);
      

      
      request.setAttribute("roomvo",roomvo);
      request.setAttribute("countReview",countReview);
      request.setAttribute("imagevo",imagevo);
      request.setAttribute("uservo",uservo);
      request.setAttribute("explainvo",explainvo);
      request.setAttribute("roominfovo",roominfovo);
      request.setAttribute("reviewvo",reviewvo);
      request.setAttribute("convenientvo",convenientvo);
      request.setAttribute("stayvo",stayvo);
      for(StayVo vo : stayvo) {
    	  if(vo.getStay_img().contains("svg")){
    		  System.out.println(vo.getStay_img());
    	  }else {
    		  System.out.println(vo.getStay_img());
    	  }
      }
      
      
      
      RequestDispatcher rd = request.getRequestDispatcher("main3.jsp");
      rd.forward(request, response);
   }
   
   
   
   

}