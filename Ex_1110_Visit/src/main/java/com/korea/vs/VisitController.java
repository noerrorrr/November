package com.korea.vs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.VisitDAO;
import util.Comm;
import vo.VisitVO;

@Controller
public class VisitController {
	
	VisitDAO visit_dao;
	public void setVisit_dao(VisitDAO visit_dao) {
		this.visit_dao = visit_dao;
	}
	
	//방명록 조회
	@RequestMapping(value= {"/", "/list.do"})
	public String list( Model model ) {
		
		List<VisitVO> list = visit_dao.selectList();
		model.addAttribute("list", list);//바인딩
		return Comm.VIEW_PATH + "visit_list.jsp";//포워딩
		
	}
	
	@RequestMapping("/insert_form.do")
	public String insert_form() {
		return Comm.VIEW_PATH + "visit_insert_form.jsp";
	}
	
	//새 글쓰기
	@RequestMapping("/insert.do")
	//public String insert(String name, String content, String pwd) {
	public String insert( VisitVO vo, HttpServletRequest request) {
		//insert.do?name=홍&content=1235&pwd=1111
		
		//접속자의 ip가져오기
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		//DB에 새 글을 추가하기 위해 DAO에게 vo를 전달
		int res = visit_dao.insert(vo);
		
        //redirect: view로 이동하는 것이 아닌, 컨트롤러의 url매핑을 호출하기 위한 키워드
		return "redirect:list.do";
	}
}

















