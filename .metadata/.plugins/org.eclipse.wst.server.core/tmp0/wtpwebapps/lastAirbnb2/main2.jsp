<%@page import="java.text.DecimalFormat"%>
<%@page import="esVo.UserInfoVo"%>
<%@page import="esVo.LanguageVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="myDao.*"%>
<%@page import="myVo.*"%>
<%@page import="esDao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//카테고리 목록을 받음12345
	ArrayList<RoomCategoryVo> roomcate = (ArrayList<RoomCategoryVo>)request.getAttribute("list1"); // roomcate는 
	int paramCate = (Integer)request.getAttribute("cateIdx");   // cate= 국립공원
	ArrayList<RepresentRoomListVo> roomList = (ArrayList<RepresentRoomListVo>)request.getAttribute("roomVo"); 
	
	Main2Dao dao = new Main2Dao();
	// 광화문 위도경도
	double currentLatitude = 126.96033;
	double currentLongitude = 37.264842;
	LoginDao LoginDao = new LoginDao();
	LanguageDao langDao = new LanguageDao();
	ArrayList<LanguageVo> listLanguageVo = langDao.getLanguage();
	int userIdx = 0;
	UserInfoVo userList = null;
	int howManyAlarm = 0;
	if(request.getSession().getAttribute("userIdx") != null) {
		try{
			userIdx = (Integer)request.getSession().getAttribute("userIdx"); //--> 로그인창 만들면 이걸로 적용하기	
			userList = LoginDao.getUserInfoBy(userIdx);
			howManyAlarm = (Integer)LoginDao.getCountAlarm(userIdx);
		} catch (NullPointerException e){
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>여행은 살아보는거야-에어비앤비</title>

	<link rel="stylesheet" href="./css/reset.css">
   <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
   <link rel="stylesheet" href="css/main2.css"/>
   <link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>   
   <link rel="stylesheet" type="text/css" href="css/slick.css"/>
   <link rel="stylesheet" type="text/css" href="css/slick-theme.css"/>   
	<script src = "js/jquery-3.7.1.min.js"></script>
	<script src = "js/jquery-ui.min.js"></script>
   <script src = "js/main2.js"></script>
	<!-- 날짜 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  	<!--슬릭  -->
   <script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>   
</head>	

<body>

<div id = mini_box>
지도 표시하기
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 16px; width: 16px;"><path d="M31.25 3.75a2.29 2.29 0 0 0-1.01-1.44A2.29 2.29 0 0 0 28.5 2L21 3.67l-10-2L2.5 3.56A2.29 2.29 0 0 0 .7 5.8v21.95a2.28 2.28 0 0 0 1.06 1.94A2.29 2.29 0 0 0 3.5 30L11 28.33l10 2 8.49-1.89a2.29 2.29 0 0 0 1.8-2.24V4.25a2.3 2.3 0 0 0-.06-.5zM12.5 25.98l-1.51-.3L9.5 26H9.5V4.66l1.51-.33 1.49.3v21.34zm10 1.36-1.51.33-1.49-.3V6.02l1.51.3L22.5 6h.01v21.34z"></path></svg>
</div>
<div class="currency_language_background"></div>
				<div id="currency_language_">
					<button class="close_div"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 3; overflow: visible;"><path d="m6 6 20 20M26 6 6 26"></path></svg></button>
					<div id="currency_">
						<div id="currency_top">
							<button class="currency_button fl">언어와 지역</button>
							<button class="language_button fl">통화</button>
						</div><!--currency_top-->
						<div id="currency_center">
							<div>
								<h2>추천 언어 및 지역</h2>
								<ul>
									<li class="fl">
										<div>English</div>
										<div>United States</div>
									</li>
									<li class="fl">
										<div>English</div>
										<div>United States</div>
									</li>
								</ul>
							</div>
							<div>
								<h3 style="font-size: 22px; font-weight: 600;">언어와 지역을 선택하세요</h3>
						<%
                        		for( int i = 0; i <= 90; i++ ){
  									if(i % 5 == 0)
  										out.println("<ul>");
                        %>
                         	  <li class="fl">
                            	  <div><%=listLanguageVo.get(i).getLanguage() %></div>
                              	<div><%=listLanguageVo.get(i).getLocation() %></div>
                         	  </li>
                        <%
                        		if(i % 5 == 4)
                        			out.println("</ul>");
                        		}
                        %>
							</div>
						</div><!--currency_center-->
					</div><!--currency_-->
					<div id="language_"></div><!--language_-->
				</div><!--currency_language_-->
		<div id="header">
			<div id="header_left" class="fl">
				<a href="Main2"><img src="images/logo.png" class="fr"/></a>
			</div><!--header_left-- <!--airbnbë¡ê³ -->
			<div id="center" class="fl">
				<div class= "btns">
		          <button class ="btn1">
		            <div>어디든지</div>
		          </button>
		          <button class ="btn2">
		                <div>언제든 일주일</div>
		          </button>
		          <button class ="btn3">
		              <div>게스트 추가</div>
		              <div><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" style="display:block;fill:none;height:12px;width:12px;stroke:currentColor;stroke-width:5.333333333333333;overflow:visible" aria-hidden="true" role="presentation" focusable="false"><path fill="none" d="M13 24a11 11 0 1 0 0-22 11 11 0 0 0 0 22zm8-3 9 9"></path></svg></div>
		          </button> 
		        </div>
			</div><!--header_center--> 
			<div id="center2" class="fl" style="display:none;">
		         <div class="btn4">숙소</div>
		         <div class="btn5">체험</div>
		         <div class="btn6">온라인 체험</div>
   			</div>
			<div id="header_right" class="fl">
				<div id="areaair" class="fl">
					<a href="doairbnb.jsp"><strong>당신의 공간을 에어비앤비하세요</strong></a>
				</div>
				<div id="globe" class="fl">
					<img src="images/globe.png"/>
				</div><!--globe-->
				<div id="profile" class="fl">
					<img src="images/list.png" style="margin: 21px 0 0 0px;"/>
					<% 		if(userIdx == 0) { %>
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 30px; width: 40px; fill: currentcolor; margin: -30px 0 0 41px;"><path d="M16 .7C7.56.7.7 7.56.7 16S7.56 31.3 16 31.3 31.3 24.44 31.3 16 24.44.7 16 .7zm0 28c-4.02 0-7.6-1.88-9.93-4.81a12.43 12.43 0 0 1 6.45-4.4A6.5 6.5 0 0 1 9.5 14a6.5 6.5 0 0 1 13 0 6.51 6.51 0 0 1-3.02 5.5 12.42 12.42 0 0 1 6.45 4.4A12.67 12.67 0 0 1 16 28.7z"></path></svg>
						<%  } else { %>
								<% if(userList.getUser_image() != null) { %>
								<img src="<%=userList.getUser_image() %>"/>
								<% } else { %>
										<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 30px; width: 40px; fill: currentcolor; margin: -30px 0 0 41px;"><path d="M16 .7C7.56.7.7 7.56.7 16S7.56 31.3 16 31.3 31.3 24.44 31.3 16 24.44.7 16 .7zm0 28c-4.02 0-7.6-1.88-9.93-4.81a12.43 12.43 0 0 1 6.45-4.4A6.5 6.5 0 0 1 9.5 14a6.5 6.5 0 0 1 13 0 6.51 6.51 0 0 1-3.02 5.5 12.42 12.42 0 0 1 6.45 4.4A12.67 12.67 0 0 1 16 28.7z"></path></svg>
								<% } %>
								<div id="notice"><%=howManyAlarm %></div>
						<%    } %>
				</div><!--profile-->
				<div style ="clear : both;"></div>
				<div class="profile_list">
					<% if(userIdx > 0) { %> 
					<div class="profile_list_top">
						<form action="message.jsp" method="post">
							<input type="submit" value="메시지"/>
						</form>
						<form action="notification.jsp" method="post">
							<input type="submit" value="알림"/>
						</form>
						<form action="trip.jsp" method="post">
							<input type="submit" value="여행"/>
						</form>
						<form action="wishlist.jsp" method="post">
							<input type="submit" value="위시리스트"/>
						</form>
					</div><!--profile_list_top-->
					<div class="profile_list_center">
						<form action="doairbnb.jsp" method="post">
							<input type="submit" value="당신의 공간을 에어비앤비하세요"/>
						</form>
						<form action="account.jsp" method="post">
							<input type="submit" value="계정"/>
						</form>
					</div><!--profile_list_center-->
					<div class="profile_list_bottom">
						<form action="timeline.jsp" method="post">
							<input type="submit" value="타임라인"/>
						</form>
						<div class="Logout">로그아웃</div>
					</div><!--profile_list_bottom-->
				 	<% } else{ %>
					<div class="profile_list_diff">
						<div>로그인</div>
						<div>회원가입</div>
					</div>
					<% } %>
				</div><!--profile_list-->
			</div><!--header_right-->
			<div style ="clear : both;"></div>
		</div>
		<!-- 회원가입창 -->
   <div id="joinmember_outer"></div>
      <div id="joinmember">
      
         <div class="jm_header">
            <button>
               <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
                  aria-hidden="true" role="presentation" focusable="false"
                  style="display: block; fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 3; overflow: visible; margin: 0 auto;">
                  <path d="m6 6 20 20M26 6 6 26"></path></svg>
            </button>
            <h2>로그인 또는 회원 가입</h2>
         </div>
         
         <div class="jm_section">
            <h2>에어비엔비에 오신것을 환영합니다</h2>
         
            <form id="jm_form" action="lmyController" method="post">
               <div>
                  <label for="jm_form" id="code"></label> 
                  <select name="jm_code" class="jm_seclect_box">
                     <option value="korean">선호하는 언어</option>
                     <% for(int i = 0; i <= 90; i++) { %>
                  	 		<option><%=listLanguageVo.get(i).getLocation() %></option>
                  	 <% } %>
                  </select>
	               </div>
	               
	               <input type="text" class="jm_phnum" placeholder="전화번호" name="phone_num" required/>
	           	   <input type="password" class="password" placeholder="비밀번호" name="pw" required/>
	               <span>전화나 문자로 전화번호를 확인하겠습니다. 일반 문자 메시지 요금 및 데이터 요금이 부과됩니다.</span>
	         	   <input type="hidden" name="url" value="Main2"/>
	         	   <input type="hidden" name="command" value="login"/>
	               <input type="submit" class="jm_submit" value="로그인"><br/>
               <div class="join_user" style="padding-top: 16px;">회원 가입</div>
            </form>
         </div>
      </div>
      <div id="join_user">
      		<button>
               <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"
                  aria-hidden="true" role="presentation" focusable="false"
                  style="display: block; fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 3; overflow: visible; margin: 0 auto;">
                  <path d="m6 6 20 20M26 6 6 26"></path></svg>
            </button>
      		<form method="post" class="join_user_form" action="lmyController">
      			이름 : <input type="text" placeholder="Ex) 김철수" name="user_id" required/> <br/><br/><br/>
      			비밀번호 : <input type="password" name="pw" required/> <br/><br/><br/>
      			비밀번호 확인 : <input type="password" class="check_pw" required/> <br/><br/><br/>
      			휴대폰 번호 : <input type="number" name="phone_num" placeholder="010xxxx1234" required/> <br/><br/><br/>
      			거주지 : <input type="text" name="user_regidence" required/> <br/><br/><br/>
      			생년월일 : <input type="text" name="birthday" placeholder="2000/12/12"required/> <br/><br/><br/>
      			이메일 : <input type="email" name="email" placeholder="asd123@naver.com" required/> <br/><br/><br/><br/>
      			<input type="hidden" name="command" value="join"/>
      			<input type="submit" style="width: 500px; background-color: rgb(255,56,92); border-radius: 10px; color: white; border: none;}"/>
      		</form>
      </div>
<!--회원가입창 끝  -->
<!-- header2 -->
<div id="header2" style="display:none;">

<!-- ----------세부창 -->
	<div id="head_pop1" style="display:none;"><!--오랜지  -->
		<div class="pop_content1"><!-- 하늘색 -->
			<div class="pop_content1-1">최근 검색 내역</div>
			<div class="pop_content1-2">
			
				<div class="pop_content1-3">
					<div class= "pop_content1-4">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 22px; width: 22px; fill: currentcolor;"><path d="M16 .33a15.67 15.67 0 1 1 0 31.34A15.67 15.67 0 0 1 16 .33zm0 2a13.67 13.67 0 1 0 0 27.34 13.67 13.67 0 0 0 0-27.34zm1 3v10.1l8.74 5.04-1 1.73L15 16.58V5.33z"></path></svg>
					</div>
					<div class= "pop_content1-5">
						<span>제주도 · 숙소</span><br>
						언제든일주일
					</div>
				</div>
				
				<div class="pop_content1-3">
					<div class= "pop_content1-4">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 22px; width: 22px; fill: currentcolor;"><path d="M16 .33a15.67 15.67 0 1 1 0 31.34A15.67 15.67 0 0 1 16 .33zm0 2a13.67 13.67 0 1 0 0 27.34 13.67 13.67 0 0 0 0-27.34zm1 3v10.1l8.74 5.04-1 1.73L15 16.58V5.33z"></path></svg>
					</div>
					<div class= "pop_content1-5">
						<span>용산구 · 숙소</span><br>
						 12월 14일~16일
					</div>
				</div>
				
			</div>
		</div><!-- 왼쪽끝 -->
		
		<div class="pop_content2" >
			<div class="pop_content2-1">지역으로 검색하기</div>
			<div class="pop_content2-2"> <!-- 지역그리드 -->
				<div class="pop_content2-3">
					<img src="https://a0.muscache.com/pictures/f9ec8a23-ed44-420b-83e5-10ff1f071a13.jpg"/>
					<span>유연한 검색</span>
				</div>
				<div class="pop_content2-3">
					<img src="https://a0.muscache.com/im/pictures/d77de9f5-5318-4571-88c7-e97d2355d20a.jpg"/>
					<span>아시아</span>
				</div>
				<div class="pop_content2-3">
					<img src="https://a0.muscache.com/pictures/f9ec8a23-ed44-420b-83e5-10ff1f071a13.jpg"/>
					<span>오세아니아</span>
				</div>
				<div class="pop_content2-3">
					<img src="https://a0.muscache.com/im/pictures/4e762891-75a3-4fe1-b73a-cd7e673ba915.jpg"/>
					<span>아메리카</span>
				</div>
				<div class="pop_content2-3">
					<img src="https://a0.muscache.com/pictures/f9ec8a23-ed44-420b-83e5-10ff1f071a13.jpg"/>
					<span>아프리카</span>
				</div>
				<div class="pop_content2-3">
					<img src="https://a0.muscache.com/im/pictures/7b5cf816-6c16-49f8-99e5-cbc4adfd97e2.jpg"/>
					<span>유럽</span>
				</div>
			</div>
		</div>
	</div>
<!-- 세부차1번끝  -->
<div id="head_pop2" style="display:none;">

	<div class="hpop_content1">
		<div class="hpop_content1-1">
			<div>날짜 지정</div>
			<div>월 단위</div>
			<div>유연한 일정</div>
		</div>
	</div>
	
	<div class="hpop_content2">
		<div class="hpop_content2-1">
		 	<div id="dp1" name="dp1" class="datepicker"></div>
		</div>
		<div class="hpop_content2-2">
			<div id="dp2" name="dp2" class="datepicker2"></div>
		</div>
	</div>
	 
	<div class="hpop_content3">
		<div class="hpop_content3-1">정확한날짜</div>
		<div class="hpop_content3-2"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 2.66667; overflow: visible;"><path fill="none" d="M16 4v16m-8-8h16M8 26h16"></path></svg>1일</div>
		<div class="hpop_content3-2"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 2.66667; overflow: visible;"><path fill="none" d="M16 4v16m-8-8h16M8 26h16"></path></svg> 2일</div>
		<div class="hpop_content3-2"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 2.66667; overflow: visible;"><path fill="none" d="M16 4v16m-8-8h16M8 26h16"></path></svg> 3일</div>
		<div class="hpop_content3-2"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 2.66667; overflow: visible;"><path fill="none" d="M16 4v16m-8-8h16M8 26h16"></path></svg> 7일</div>
	</div>
</div>
<!-- 세부창2끝 -->
<div id="head_pop3" style="display:none;">

	<div class="hpop_content1">
		<div class="hpop_content1-1">
			<div>날짜 지정</div>
			<div>월 단위</div>
			<div>유연한 일정</div>
		</div>
	</div>
	
	<div class="hpop_content4">
		<span>숙박기간을 선택해주세요</span>
		<div class="hpop_content4-1">
			<div>주말</div>
			<div>일주일</div>
			<div>한 달</div>
		</div>
	</div>
	
	<div  class="hpop_content5">
		<span>여행날짜를 선택하세요</span>
		<div class="hpop_content5-1">
			<div>
				<img src="https://a0.muscache.com/pictures/cf82c9bc-520a-4486-9be4-1f0927972381.jpg" />
				<span>12월</span>
			</div>
			<div>
				<img src="https://a0.muscache.com/pictures/cf82c9bc-520a-4486-9be4-1f0927972381.jpg" />
				<span> 1월</span>
			</div>
			<div>
				<img src="https://a0.muscache.com/pictures/cf82c9bc-520a-4486-9be4-1f0927972381.jpg" />
				<span> 2월</span>
			</div>
			<div>
				<img src="https://a0.muscache.com/pictures/cf82c9bc-520a-4486-9be4-1f0927972381.jpg" />
				<span> 3월</span>
			</div>
			<div>
				<img src="https://a0.muscache.com/pictures/cf82c9bc-520a-4486-9be4-1f0927972381.jpg" />
				<span> 4월</span>
			</div>
			<div>
				<img src="https://a0.muscache.com/pictures/cf82c9bc-520a-4486-9be4-1f0927972381.jpg" />
				<span> 5월</span>
			</div>
		</div>
		<div class="hpop_content5-2">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;"><path fill="none" d="m12 4 11.3 11.3a1 1 0 0 1 0 1.4L12 28"></path></svg>
		</div>
	</div>

</div>
<!-- 세부창3끝 -->
<div id="head_pop4" style="display:none;" >
	<div class="hpop_content6"><!--오렌지  -->
			<div>
				<span class="hop_content6-1">성인</span>
				<span class="hop_content6-2">13세 이상</span>
			</div>
			<div>
				<button class= "hop4_btn1"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m.75 6.75h10.5v-1.5h-10.5z"></path></svg></button> 
				<input type="text" class="hop4_input" value="0"/>
				<button class="hop4_btn2"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m6.75.75v4.5h4.5v1.5h-4.5v4.5h-1.5v-4.5h-4.5v-1.5h4.5v-4.5z"></path></svg></button>
			</div>
	</div>
	<div class="hpop_content6"><!--오렌지  -->
			<div>
				<span class="hop_content6-1">어린이</span>
			<span class="hop_content6-2">2~12세</span>
			</div>
			<div>
				<button class= "hop4_btn1"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m.75 6.75h10.5v-1.5h-10.5z"></path></svg></button> 
				<input type="text" class="hop4_input" value="0"/>
				<button class="hop4_btn2"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m6.75.75v4.5h4.5v1.5h-4.5v4.5h-1.5v-4.5h-4.5v-1.5h4.5v-4.5z"></path></svg></button>
			</div>
	</div>
	<div class="hpop_content6"><!--오렌지  -->
			<div>
				<span class="hop_content6-1">유아</span>
				<span class="hop_content6-2">2세 미만</span>
			</div>
			<div>
				<button class= "hop4_btn1"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m.75 6.75h10.5v-1.5h-10.5z"></path></svg></button> 
				<input type="text" class="hop4_input" value="0"/>
				<button class="hop4_btn2"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m6.75.75v4.5h4.5v1.5h-4.5v4.5h-1.5v-4.5h-4.5v-1.5h4.5v-4.5z"></path></svg></button>
			</div>
	</div>
		<div class="hpop_content6" style="border-bottom:none;"><!--오렌지  -->
			<div>
				<span class="hop_content6-1">반려동물</span>
				<span class="hop_content6-3">보조동물을 동반하시나요?</span>
			</div>
			<div>
				<button class= "hop4_btn1"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m.75 6.75h10.5v-1.5h-10.5z"></path></svg></button> 
				<input type="text" class="hop4_input" value="0"/>
				<button class="hop4_btn2"><svg viewBox="0 0 12 12" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 12px; width: 12px; fill: currentcolor;margin-left: 9.2px;"><path d="m6.75.75v4.5h4.5v1.5h-4.5v4.5h-1.5v-4.5h-4.5v-1.5h4.5v-4.5z"></path></svg></button>
			</div>
	</div>
</div>
<!--세부창4끝  -->
<!--세부창 끝  -->	

	<div id="header_inner">
		<div class="head_content1">
			<span>여행지</span>
			<input type="text" id="head_input" name="email" placeholder="여행지 검색"/>
		</div>
		<div class="head_content2">
			<span>체크인</span>
			<span>날짜추가</span>
		</div>
		<div class="head_content3">
			<span>체크아웃</span>
			<span>날짜추가</span>
		</div>
		<div class="head_content4">
			<span>여행자</span>
			<span>게스트 추가</span>
			<div class="head_svg">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="M13 24a11 11 0 1 0 0-22 11 11 0 0 0 0 22zm8-3 9 9"></path></svg>
			</div>
		</div>
		
		
	</div>
</div>
<!-- header2끝  -->
<div id ="section">
	<div id="menu">
	 <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: inline;fill: none;height: 12px;width: 12px; stroke: currentcolor;stroke-width: 5.33333;overflow: visible;position: absolute;left: 62px;top: 29px;"><path fill="none" d="M20 28 8.7 16.7a1 1 0 0 1 0-1.4L20 4"></path></svg>
		<div id ="cate">
			<!--  -->
			<% for( RoomCategoryVo vo : roomcate ){ %>
				<div class="w hover">
					<span>
						<img src="<%= vo.getCategory_icon()%>"/>
						<div><span><%=vo.getCategory_name() %></span></div>
						<div style="display:none;"><%=vo.getRoom_category_idx() %></div>
<!-- 					<div class="bar" style="width:62.5625px; height:2px;background-color:black; visibility:hidden; "></div> -->
					</span>
				</div>
			<% } %>
		</div><!-- 카테끝 -->
		 <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; cursor : pointer; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;position: absolute;top: 28.5px;right: 160px;"><path fill="none" d="m12 4 11.3 11.3a1 1 0 0 1 0 1.4L12 28"></path></svg>
		<div id="menu_btn">
			<button>
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" style="display:block;fill:none;height:16px;width:16px;stroke:currentColor;stroke-width:3;overflow:visible" aria-hidden="true" role="presentation" focusable="false"><path fill="none" d="M7 16H3m26 0H15M29 6h-4m-8 0H3m26 20h-4M7 16a4 4 0 1 0 8 0 4 4 0 0 0-8 0zM17 6a4 4 0 1 0 8 0 4 4 0 0 0-8 0zm0 20a4 4 0 1 0 8 0 4 4 0 0 0-8 0zm0 0H3"></path></svg>
				<a>필터</a>
			</button>
		</div>
	</div><!-- 메뉴끝 -->
	
</div>



<!-- 내용 -->
<div id="content_outer">
	<div id="content">
<!-- 		<a>
			<div>
				<img src="https://a0.muscache.com/im/pictures/34822e87-1915-4f1e-9ae0-a5b0cccbce1e.jpg?im_w=1200"/>
				<button><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: rgba(0, 0, 0, 0.5); height: 24px; width: 22.7px; stroke:white; stroke-width: 2; overflow: visible;"><path d="M16 28c7-4.73 14-10 14-17a6.98 6.98 0 0 0-7-7c-1.8 0-3.58.68-4.95 2.05L16 8.1l-2.05-2.05a6.98 6.98 0 0 0-9.9 0A6.98 6.98 0 0 0 2 11c0 7 7 12.27 14 17z"></path></svg></button>
			</div>
			<div class="ps">
				<div>토스카나 | 수영장과 레스토랑이 있는 농장 체험 숙박</div>
				<span>★  5.0</span>
				<div>치악산국립공원에서 60km</div>
				<div>12월 3일~8일</div>
				<div><b>₩294,455</b> /박</div>
			</div>
		</a> -->
		<% for(RepresentRoomListVo r : roomList){ %>
		<% double roomLatitude = r.getLatitude(); 
		   double roomLongitude = r.getLongitude();
		%>
		<%
		double distance = dao.checkDistance(currentLatitude, currentLongitude, roomLatitude, roomLongitude);
		if(paramCate == 8 || paramCate == 2) {
			distance = dao.checkDistance1(currentLatitude, currentLongitude, roomLatitude, roomLongitude); 
		}
		%>
			<a>	
				<div>
					<img src="<%=r.getImg1() %>"/>
					<button><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: rgba(0, 0, 0, 0.5); height: 24px; width: 22.7px; stroke:white; stroke-width: 2; overflow: visible;"><path d="M16 28c7-4.73 14-10 14-17a6.98 6.98 0 0 0-7-7c-1.8 0-3.58.68-4.95 2.05L16 8.1l-2.05-2.05a6.98 6.98 0 0 0-9.9 0A6.98 6.98 0 0 0 2 11c0 7 7 12.27 14 17z"></path></svg></button>
				</div>
				<div class="ps">
					<div><%= r.getRoomName()%></div>
				<%-- 	<%if(r.getRoomScore() != null){ %> --%>
						<span>★<%= r.getRoomScore()%></span>
			<%-- 		<%} %> --%>
					<div>광화문에서 <%=distance %>km</div>
					<div>12월 3일~8일</div>
					<div><b>₩<%= new DecimalFormat("###,###").format(r.getRoomPrice()) %></b> /박</div>
				</div>
				<div class="room_idx" style="display:none;"><%=r.getRoomIdx()%></div>
			<%-- 	<div class="host_idx" style="display:none;"><%=r.getHost_idx()%></div> --%>
			</a>
		<% } %>
		
	</div>
</div>
<!-- 위시팝업 -->
<div id="wish_outer"></div>
<div id="wish" >
	<div class="wish_header">
		<button>
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 3; overflow: visible;position:absolute;top: 20px;"><path d="m6 6 20 20M26 6 6 26"></path></svg>
		</button>
		<span>위시리스트에 담기</span>
	</div>
	
	<div class="wish_inner1">
		<div class="wish_content_outer">
			<div class="wish_content1">
				<img src="https://a0.muscache.com/im/pictures/032392ef-892e-4e85-bad1-2881905f67f0.jpg?im_w=1200"/>
				<span class="wish_sp1">경기도 안양시</span><br>
				<span class="wish_sp2">0개 저장됨</span>
			</div>
		</div>
<!-- 		<div class="wish_content_outer">
			<div class="wish_content1">
				<img src="https://a0.muscache.com/im/pictures/032392ef-892e-4e85-bad1-2881905f67f0.jpg?im_w=1200"/>
				<span class="wish_sp1">경기도 안양시</span><br>
				<span class="wish_sp2">0개 저장됨</span>
			</div>
		</div>
		<div class="wish_content_outer">
			<div class="wish_content1">
				<img src="https://a0.muscache.com/im/pictures/032392ef-892e-4e85-bad1-2881905f67f0.jpg?im_w=1200"/>
				<span class="wish_sp1">경기도 안양시</span><br>
				<span class="wish_sp2">0개 저장됨</span>
			</div>
		</div>
	 	<div class="wish_content_outer">
			<div class="wish_content1">
				<img src="images/wish.png"/>
				<span class="wish_sp1">경기도 안양시</span><br>
				<span class="wish_sp2">0개 저장됨</span>
			</div>
		</div>
	-->
		
	</div> <!-- inner1끝 -->
	<div class="wish_inner2">
		<div class="wish_content2">새로운 위시리스트 만들기</div>
	</div>
</div>
<!-- 위시팝업 끝 -->



<!--필터팝업  -->
<div id="filter_outer" style="display:hidden;"></div>
<div id="filter" style="display:hidden;">
	<div class="filter_header">
		<button><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 3; overflow: visible;"><path d="m6 6 20 20M26 6 6 26"></path></svg></button>
		필터
	</div>
	<div class="filter_content">
		<div class="filter_content1">
			<h1>숙소유형</h1>
			<span>방, 집 전체 등 원하는 숙소 유형을 검색해보세요.</span>
			<div class="fil_btns">
				<button >모든유형</button>
				<button >방</button>
				<button >집 전체</button>
			</div>
		</div>
		
		<form action="lmyController" method="post">
			<input type="hidden" name="command" value="filter_room"/>
			<input type="hidden" name="category_idx" value="<%=paramCate%>"/>
			<div class="filter_content2">
				<h1>가격범위</h1>
				<span>1박 요금(수수료 및 세금 포함)</span>
				<div class="filter_content2-2">
					<div class="filter_price">
					
						<div class="filter_price_input">
							<span class="filter_span">최저</span><br>
							<span class="filter_span2">R</span>
							<input type="text" id="fist_price" name="min_price">
						</div>
						<span></span>
						<div class="filter_price_input">
							<span class="filter_span">최고</span><br>
							<span class="filter_span2">R</span>
							<input type="text" id="fist_price" name="max_price">
						</div>
						
					</div>
				</div>
			</div>
			
			<script>
				$(function() {
					$(".fil3_btns > button").click(function() {
						let txt = $(this).text();
						if(txt!="상관없음") 
							$("input[name='fil3_btns']").val(txt);
						else 
							$("input[name='fil3_btns']").val("0");
					});
				});
			</script>
			
			<div class="filter_content3">
				<input type="hidden" name="fil3_btns" value="0"/>
				<h1>침실과 침대</h1>
				<span>침실</span>
				<div class="fil3_btns">
					<button type="button">상관없음</button>
					<button type="button">1</button>
					<button type="button">2</button>
					<button type="button">3</button>
					<button type="button">4</button>
					<button type="button">5</button>
					<button type="button">6</button>
					<button type="button">7</button>
					<button type="button">8+</button>
				</div>
				
				<span>침대</span>
				<div class="fil3_btns2">
					<button type="button">상관없음</button>
					<button type="button">1</button>
					<button type="button">2</button>
					<button type="button">3</button>
					<button type="button">4</button>
					<button type="button">5</button>
					<button type="button">6</button>
					<button type="button">7</button>
					<button type="button">8+</button>
				</div>
				
					
				<span>욕실</span>
				<div class="fil3_btns3">
					<button type="button">상관없음</button>
					<button type="button">1</button>
					<button type="button">2</button>
					<button type="button">3</button>
					<button type="button">4</button>
					<button type="button">5</button>
					<button type="button">6</button>
					<button type="button">7</button>
					<button type="button">8+</button>
				</div>
			</div>
<!-- 		
		<div class="filter_content4">
			<h1>최고 수준의 숙소</h1>
			<div class="filter_content4-1">
				<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; height: 40px; width: 40px; fill: currentcolor;"><path d="m26.3732689 2.47961624.6167441.48322004c1.7072543 1.33763663 2.6054782 2.90952832 2.6054782 4.67605261 0 .3660905-.0390268.72618704-.116891 1.07902433.2220822-.04940579.4535208-.09078168.6921664-.12465571l.775726-.11010878.2925061.72685288c.8097073 2.01205449.8016461 3.82246449-.0816161 5.35231939-.2032148.3519785-.4424546.6712615-.7165374.9579743l.2224321.0794128.9515555.3797252-.1101088.7757261c-.3048001 2.1473439-1.2169863 3.7111744-2.7468413 4.5944365-.5761025.332613-1.1919899.5411159-1.8434482.6285758.1841168.1929555.3637753.4031581.5393959.6273064l.48322.6167441-.48322.6167441c-1.3376366 1.7072543-2.9095283 2.6054781-4.6760526 2.6054781-1.2480882 0-2.4019214-.4496183-3.4432232-1.3171892l-.0012213.0394115c0 1.2886644 1.044669 2.3333333 2.3333334 2.3333333.5522847 0 1 .4477153 1 1s-.4477153 1-1 1c-2.3932339 0-4.3333334-1.9400994-4.3333334-4.3333333 0-.9731196.3231417-1.8972354.901435-2.6461065.0487133-.1124489.1099252-.2143841.183909-.2995515.2333023-.2685692.4731075-.5134836.719657-.7345023 1.092313-.9792012 2.3169607-1.4865064 3.6394435-1.4865064l.0684312.0004504c.3275052-1.8187509 1.1205491-3.1889128 2.3863714-4.0426116-.4569936-1.4757574-.4468151-2.8322754.0552629-4.0354282-1.4028349-1.2488618-2.1367966-2.68667211-2.1367966-4.28352171 0-1.76652429.8982238-3.33841598 2.6054781-4.67605261zm-3.5954911 19.52038376c-.8090047 0-1.5656514.3134377-2.3044395.9757225l-.1826884.1713488-.0733166.074262.1281937.1295236c.7776797.743284 1.5802193 1.0935875 2.4322508 1.0935875l.218427-.0078032c.7972463-.0573203 1.5547873-.4315014 2.2882491-1.1577185l.0555461-.056256-.0555461-.057145c-.8001401-.7922368-1.6289366-1.1655217-2.5066761-1.1655217zm3.7578827-4.4994059-.1852617.1159713c-.6617754.448264-1.1307346 1.1510849-1.4028227 2.1467382l-.0182612.0759557.0749618.0222525c1.0890601.2860271 1.9934613.1949031 2.753606-.2439667l.1852618-.1159712c.6617753-.4482641 1.1307346-1.1510849 1.4028226-2.1467383l.0193478-.0769097-.0760483-.0212985c-1.0890601-.2860271-1.9934613-.194903-2.7536061.2439667zm3.1123395-6.7679274-.0769097.0193477c-1.0861673.2968233-1.8238397.8279397-2.2627095 1.5880844l-.1024557.1930649c-.3489823.7190957-.4037025 1.5622361-.141511 2.5605412l.0222526.0749618.0759556-.0182613c1.0861673-.2968233 1.8238397-.8279397 2.2627095-1.5880844s.5299938-1.664546.2439667-2.7536061zm-3.2751755-5.65600003-.0562561.05554607c-.7922368.80014014-1.1655217 1.62893662-1.1655217 2.50667615l.0078032.21842698c.0573204.7972463.4315015 1.55478738 1.1577185 2.28824913l.0575894.0537683.0189905-.0176348c.505107-.50232394.8443631-1.01414101 1.0296433-1.53660354.1153772-.32534636.1726996-.65911739.1726996-1.00620607 0-.87773953-.3732849-1.70653601-1.1655217-2.50667615zm-20.9125938-2.59705043-.6167441.48322004c-1.70725429 1.33763663-2.60547812 2.90952832-2.60547812 4.67605261 0 .3660905.03902677.72618704.11689093 1.07902433-.22208221-.04940579-.45352077-.09078168-.69216632-.12465571l-.77572608-.11010878-.29250604.72685288c-.80970728 2.01205449-.80164608 3.82246449.08161606 5.35231939.20321486.3519785.44245466.6712615.71653743.9579743l-.2224321.0794128-.95155553.3797252.11010879.7757261c.30480015 2.1473439 1.21698637 3.7111744 2.74684128 4.5944365.57610257.332613 1.19198995.5411159 1.84344825.6285758-.18411676.1929555-.36377531.4031581-.53939589.6273064l-.48322004.6167441.48322004.6167441c1.33763662 1.7072543 2.90952832 2.6054781 4.67605261 2.6054781 1.24808813 0 2.40192143-.4496183 3.44322313-1.3171892l.0012213.0394115c0 1.2886644-1.0446689 2.3333333-2.3333333 2.3333333-.55228477 0-1.00000002.4477153-1.00000002 1s.44771525 1 1.00000002 1c2.3932339 0 4.3333333-1.9400994 4.3333333-4.3333333 0-.9731196-.3231417-1.8972354-.901435-2.6461065-.0487133-.1124489-.1099252-.2143841-.1839089-.2995515-.2333024-.2685692-.4731075-.5134836-.7196571-.7345023-1.092313-.9792012-2.3169606-1.4865064-3.63944343-1.4865064l-.06843124.0004504c-.32750516-1.8187509-1.12054908-3.1889128-2.38637136-4.0426116.45699357-1.4757574.44681506-2.8322754-.05526292-4.0354282 1.40283491-1.2488618 2.13679658-2.68667211 2.13679658-4.28352171 0-1.76652429-.89822383-3.33841598-2.60547813-4.67605261zm3.59549117 19.52038376c.8090047 0 1.56565133.3134377 2.30443953.9757225l.1826884.1713488.0733165.074262-.1281937.1295236c-.7776796.743284-1.58021923 1.0935875-2.43225073 1.0935875l-.21842698-.0078032c-.7972463-.0573203-1.55478738-.4315014-2.28824918-1.1577185l-.05554607-.056256.05554607-.057145c.80014014-.7922368 1.62893662-1.1655217 2.50667616-1.1655217zm-3.75788275-4.4994059.18526172.1159713c.66177537.448264 1.13073465 1.1510849 1.40282266 2.1467382l.01826127.0759557-.07496179.0222525c-1.08906009.2860271-1.99346135.1949031-2.75360608-.2439667l-.18526171-.1159712c-.66177538-.4482641-1.13073465-1.1510849-1.40282267-2.1467383l-.01934775-.0769097.07604828-.0212985c1.08906008-.2860271 1.99346134-.194903 2.75360607.2439667zm-3.11233948-6.7679274.07690971.0193477c1.08616726.2968233 1.82383971.8279397 2.26270948 1.5880844l.10245572.1930649c.34898228.7190957.40370248 1.5622361.14151095 2.5605412l-.02225252.0749618-.07595567-.0182613c-1.08616726-.2968233-1.8238397-.8279397-2.26270947-1.5880844s-.5299938-1.664546-.24396668-2.7536061zm3.27517551-5.65600003.05625608.05554607c.7922368.80014014 1.1655217 1.62893662 1.1655217 2.50667615l-.0078032.21842698c-.05732034.7972463-.43150144 1.55478738-1.1577185 2.28824913l-.05758942.0537683-.01899046-.0176348c-.50510698-.50232394-.84436314-1.01414101-1.02964333-1.53660354-.11537714-.32534636-.17269954-.65911739-.17269954-1.00620607 0-.87773953.3732849-1.70653601 1.1655217-2.50667615z"></path></svg>
				<span>게스트 선호</span>
				<span>에어비앤비 게스트에게 가장 사랑받는<br>숙소</span>
			</div>
		</div>
		
		<div class="filter_content5">
			<h1>건물 유형</h1>
			<div>
				<div class="filter_content5-1">
					<img src="https://a0.muscache.com/pictures/4d7580e1-4ab2-4d26-a3d6-97f9555ba8f9.jpg" alt="" class="idts58w atm_vy_1osqo2v atm_e2_1osqo2v dir dir-ltr">
					<span>단독 또는 다세대<br>주택</span>
				</div>
				<div class="filter_content5-1">
					<img src="https://a0.muscache.com/pictures/21cfc7c9-5457-494d-9779-7b0c21d81a25.jpg" alt="" class="idts58w atm_vy_1osqo2v atm_e2_1osqo2v dir dir-ltr">
					<span>아파트</span>
				</div>
				<div class="filter_content5-1">
					<img src="https://a0.muscache.com/pictures/6f261426-2e47-4c91-8b1a-7a847da2b21b.jpg" alt="" class="idts58w atm_vy_1osqo2v atm_e2_1osqo2v dir dir-ltr">
					<span>게스트용 별채</span>
				</div>
				<div class="filter_content5-1">
					<img src="https://a0.muscache.com/pictures/64b27fed-56a1-4f03-950a-d8da08efb428.jpg" alt="" class="idts58w atm_vy_1osqo2v atm_e2_1osqo2v dir dir-ltr">
					<span>호텔</span>
				</div>
			</div>
		</div>
		
		<div class="filter_content6">
			<h1>편의시설</h1>
			<span>필수</span>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
				<input type="checkbox" class="fil_check">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
				<span>무선 전화기</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
				<input type="checkbox" class="fil_check">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
				<span>무선 전화기</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
				<input type="checkbox" class="fil_check">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
				<span>무선 전화기</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
				<input type="checkbox" class="fil_check">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
				<span>무선 전화기</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
				<input type="checkbox" class="fil_check">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
				<span>무선 전화기</span>
				</label>
			</div>
			<div style="clear: both;"></div>
			더보기 내용 
			<div class="fil_pop" style="display:none;">	
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div style="clear: both;"></div>
				
				<span>특징</span>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div style="clear: both;"></div>
				
				<span>위치</span>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div style="clear: both;"></div>
				
				<span>안전</span>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>무선 전화기</span>
				</label>
				</div>
				<div style="clear: both;"></div>
				<div class="filter_content6-3" style="display:none;"><span>접기</span></div>
			</div>
			
			<div style="clear: both;"></div>
			
			<div class="filter_content6-2"><span>더 표시</span></div>
		</div>
		
		<div class="filter_content7">
			<h1>예약 옵션</h1>
			<div class="filter_content7-1">
				<div>
					<span class="filter7-1_sp1">즉시 예약</span>
					<span class="filter7-1_sp2">호스트 승인을 기다릴 필요 없이 예약할 수 있는 숙소</span>
				</div>
				
				<div class="onoff-switch-container">
				  <input type="checkbox" name="onoff-switch" id="onoff-switch1" />
				  <label for="onoff-switch1"></label>
				</div>
			
			</div>
			
			<div class="filter_content7-1">
				<div>
					<span class="filter7-1_sp1">셀프 체크인</span>
					<span class="filter7-1_sp2">숙소에 도착한 후 복잡한 절차 없이 쉽게 입실할 수 있습니다.</span>
				</div>
				
				<div class="onoff-switch-container2">
				  <input type="checkbox" name="onoff-switch2" id="onoff-switch2" />
				  <label for="onoff-switch2"></label>
				</div>
			</div>
			
			<div class="filter_content7-1">
				<div>
					<span class="filter7-1_sp1">반려동물 동반 가능 </span>
					<span class="filter7-1_sp3">보조동물을 동반하시나요?</span>
					
					<div id="animal_outer" style="display:none"></div>
					<div id="animal" style="display:none">
									<div class="animal_header">
										<button><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 3; overflow: visible;"><path d="m6 6 20 20M26 6 6 26"></path></svg></button>
									</div>
									<div class="animal_section">
										<img src="https://a0.muscache.com/pictures/adafb11b-41e9-49d3-908e-049dfd6934b6.jpg"/>
									</div>
									<div class="animal_content">
										<h2>보조동물</h2>
										<span>
										보조동물은 반려동물이 아니므로 여기에 추가할 필요가 없습니다.<br><br>
										정서적 지원 동물과 함께 여행하시나요? 에어비앤비 접근성 정책을 확인해보세요.
										</span>
									</div>
							 </div>
					
				</div>
				<div class="onoff-switch-container3">
				  <input type="checkbox" name="onoff-switch3" id="onoff-switch3" />
				  <label for="onoff-switch3"></label>
				</div>
			</div>
		</div>
		
		<div class="filter_content8">
			<h1>호스트 언어</h1>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>영어</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>프랑스어</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>독일어</span>
				</label>
			</div>
			<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>일본어</span>
				</label>
			</div>
			더보기
			<div style="clear: both;"></div>
			<div class="fil_pop2" style="display:none;">	
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>일본어</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>일본어</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>일본어</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>일본어</span>
				</label>
				</div>
				<div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>일본어</span>
				</label>
				</div><div class="filter_content6-1">
				<label for="fil_check" class="fil_label">
					<input type="checkbox" class="fil_check">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true" role="presentation" focusable="false" style=" fill: none; height: 16px; width: 16px; stroke: currentcolor; stroke-width: 4; overflow: visible;"><path fill="none" d="m4 16.5 8 8 16-16"></path></svg>
					<span>일본어</span>
				</label>
				</div>
				<div style="clear: both;"></div>
				<div class="filter_content6-5" style="display:none;"><span>접기</span></div>
			</div>
			더보기끝
			<div style="clear: both;"></div>
			<div class="filter_content6-4"><span>더보기</span></div>
		</div>
	</div>section끝 -->
	
	<div class="filter_footer">
		<!-- <div class="filter_footer1"><span>전체 해제</span></div> -->
		<!-- <div>숙소 n개 보기</div> -->
		<input type="reset" value="전체 해제" id="reset"/>
		<input type="submit" value="속소 보기" id="Show_all_lists"/>
	</div>
	</form>
	
</div>

<!-- 필터팝업 -->

<!-- 슾파이더 -->

<script>
		$(function() {
			//슬릭
			$('#cate').slick({
				slidesToShow: 17,
			    slidesToScroll: 17
			    
			});
			
			//카테고리 인덱스mainservlet으로 넘겨주기
			$("#cate .w").click(function() {
				let selectedCate = $(this).find("span").find("div:nth-child(3)").text();
				location.href="lmyController?command=main2&cate=" + selectedCate;
			});	
			
	         let cate = <%=paramCate%>;
	         $(".w > span > div:nth-child(3)").each(function(idx, item) {
	            //console.log($(item).text());
	            if($(item).text() == cate) {
	               $(item).parents(".w").removeClass("hover").addClass("on");
	            }
	         });
	         
	         // 숙소idx 파라미터 넘기기
	    	$("#content>a").click(function(){
	    		let roomIdx = $(this).find(".room_idx").text();
	    		location.href="lmyController?command=main3&roomIdx=" + roomIdx;
	    	 });
	         
	         
	         // 필터 ajax
	         //필터에있는것들 form으로 통째로 다 감싸주기
/* 	         $(".filter_footer>div:nth-child(2)").click(function(){
	        	 var formData = $("#form1").serialize(); //form안에있는 정보 정렬햊

	             $.ajax({
	                 cache : false,
	                 url : "${pageContext.request.contextPath}/testForm1", // 요기에
	                 type : 'POST', 
	                 data : formData, 
	                 success : function(data) {
	                     var jsonObj = JSON.parse(data);
	                 }, // success 
	         
	                 error : function(xhr, status) {
	                     alert(xhr + " : " + status);
	                 }
	             }); // $.ajax */
	    
	         
	         
	         
		});
</script>
</body>

</html>