package com.korea.vs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	//게시글 삭제
	@RequestMapping("/delete.do")
	@ResponseBody //Ajax로 요청된 메서드는 결과를 콜백메서드로 돌려주기 위해 반드시 @ResponseBody가 필요!!
	public String delete(int idx) {
		//delete.do?idx=1
		int res = visit_dao.delete(idx);
		
		String result = "no";
		if(res == 1) {
			result = "yes";
		}
		
		//yes, no값을 가지고 콜백메서드(resultFn)로 돌아간다
		//콜백으로 리턴되는 값은 영문으로 보내준다
		return result;
	} 
	
	//글 수정 폼으로 전환
	@RequestMapping("/modify_form.do")
	public String modify_form( Model model ,int idx) {
		//modify_form.do?idx=2&pwd=1111&c_pwd=1111
		VisitVO vo = visit_dao.selectOne(idx);
		
		if(vo != null) {
			model.addAttribute("vo", vo);
		}
		
		return Comm.VIEW_PATH + "visit_modify_form.jsp";
		
	}

	//게시글 수정하기
	@RequestMapping("/modify.do")
	@ResponseBody
	public String modify( VisitVO vo, HttpServletRequest request ) {
		//modify.do?idx=2&name=hong&content=가나다&pwd=1111
		String ip = request.getRemoteAddr();
		vo.setIp(ip);
		
		int res = visit_dao.update(vo);
		
		String result = "{'result':'no'}";
		if( res != 0 ) {
			result = "{'result':'yes'}";
		}
		
		return result;
	}
	
}

















