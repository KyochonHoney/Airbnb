package esAction;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;

@WebServlet("/UploadFileInMessageAction")
public class UploadFileInMessageAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		ServletContext application = getServletContext(); //어플리케이션 객체를 먼저 받기
//		String path = application.getRealPath("upload");	//-->절대 경로 확인
//		
//		File filePath = new File(path);	// -->폴더를 만듦
//		if(!filePath.exists()) {	//폴더가 없으면
//			filePath.mkdirs();	//폴더를 만듦
//		}
//		
//		int sizeLimit = 100*1024*1024; //파일크기 제한 설정: 100MB
//		
//		MultipartRequest multi = new MultipartRequest(
//													request, //요청 객체
//													path,	//파일 저장 경로(절대경로)
//													sizeLimit,	//파일최대크기
//													"UTF-8",	//파일명 한글깨짐 방지
//													new DefaultFileRenamePolicy() //기본적인 "rename 정의"
//													);
//		// -->MultipartRequest --> 객체가 생성될 때! -> 파일 저장 완료
//		//이제, 저장된 파일에 대한 정보(파일이름)를 MultipartRequest객체로부터 받아냄.
//		Enumeration<?> files = multi.getFileNames();
//		String fileObject = (String)files.nextElement();
//		String filename = multi.getFilesystemName(fileObject);
//		//참고 multi.getOriginalFileName(fileObject) --> 웹브라우저에서 선택한 파일 이름.
//		//참고 mutli.getFile(fileObject).length() --> 업로드한 파일 크기
//		
//		String description = multi.getParameter("desc");
//		
//		request.setAttribute("imgSrc", filename);
//		request.setAttribute("desc", description);
//		request.getRequestDispatcher("ExUploadResult.jsp").forward(request, response);
	}
	
}
