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
//		ServletContext application = getServletContext(); //���ø����̼� ��ü�� ���� �ޱ�
//		String path = application.getRealPath("upload");	//-->���� ��� Ȯ��
//		
//		File filePath = new File(path);	// -->������ ����
//		if(!filePath.exists()) {	//������ ������
//			filePath.mkdirs();	//������ ����
//		}
//		
//		int sizeLimit = 100*1024*1024; //����ũ�� ���� ����: 100MB
//		
//		MultipartRequest multi = new MultipartRequest(
//													request, //��û ��ü
//													path,	//���� ���� ���(������)
//													sizeLimit,	//�����ִ�ũ��
//													"UTF-8",	//���ϸ� �ѱ۱��� ����
//													new DefaultFileRenamePolicy() //�⺻���� "rename ����"
//													);
//		// -->MultipartRequest --> ��ü�� ������ ��! -> ���� ���� �Ϸ�
//		//����, ����� ���Ͽ� ���� ����(�����̸�)�� MultipartRequest��ü�κ��� �޾Ƴ�.
//		Enumeration<?> files = multi.getFileNames();
//		String fileObject = (String)files.nextElement();
//		String filename = multi.getFilesystemName(fileObject);
//		//���� multi.getOriginalFileName(fileObject) --> ������������ ������ ���� �̸�.
//		//���� mutli.getFile(fileObject).length() --> ���ε��� ���� ũ��
//		
//		String description = multi.getParameter("desc");
//		
//		request.setAttribute("imgSrc", filename);
//		request.setAttribute("desc", description);
//		request.getRequestDispatcher("ExUploadResult.jsp").forward(request, response);
	}
	
}
