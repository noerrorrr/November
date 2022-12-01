package com.korea.emp;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.EmpDAO;
import vo.EmpVO;

@Controller
public class EmpController {
	
	EmpDAO empDao;
	public void setEmpDao(EmpDAO empDao) {
		this.empDao = empDao;
	}
	
	@RequestMapping(value={"/", "/list.do"})
	public String empSelect( Model model ) {
		
		List<EmpVO> list = empDao.selectList();
		model.addAttribute("empList", list);//바인딩
		return "/WEB-INF/views/empList.jsp";
	}
	
}
















