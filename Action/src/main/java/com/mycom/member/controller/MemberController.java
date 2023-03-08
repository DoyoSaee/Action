package com.mycom.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycom.member.dto.MemberDTO;
import com.mycom.member.service.MemberService;


@Controller

public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService;
	
	// 회원리스트
	@RequestMapping("/member/list.do")
	public String memberList(Model model) {
		
		List<MemberDTO> list = memberService.memberList();
		logger.info("회원 목록 : " + list);
		model.addAttribute("list", list);
		
		return "member/memberListFrm";
	}
	
	// 회원등록 폼
	@RequestMapping("/member/write.do")
	public String write() {
		
		return "member/addMemberFrm";
	}
	
	// 회원가입
	@PostMapping("/member/insert.do")
	public String insert(@ModelAttribute MemberDTO dto) {
		
		
		int insertMember = memberService.insertMember(dto);
	
		return "/member/addSuccess";
	}
	
	// 회원 상세조회
	@RequestMapping("/member/view.do")
	public String view(@RequestParam String memId, Model model) {
		
		model.addAttribute("dto", memberService.viewMember(memId));
		
		return "member/updateMemberFrm";
	}
	
	// 회원 정보수정
	
	@RequestMapping(value="/member/update.do", method=RequestMethod.POST)
	public String update(@ModelAttribute MemberDTO dto, Model model) {
		
		boolean result = memberService.checkPw(dto.getmemId(),dto.getpasswd());
		
		
		if(result) {
			memberService.updateMember(dto);
			return "redirect:/member/list.do";
		
		}else {
			MemberDTO dto2 = memberService.viewMember(dto.getmemId());	 // 비밀번호 틀리면 전체 dto 내용 다시 나오게한다.
			dto.setregDate(dto2.getregDate());	// 날짜가 없어지지않도록 한다.
			
			model.addAttribute("dto", dto);
			model.addAttribute("message", "비밀번호가 일치하지않습니다.");
			return "member/updateMemberFrm";
		}
	}
	
	@RequestMapping("/member/delete.do")
	public String delete(@RequestParam String memId,@RequestParam String passwd , Model model) {
		 			// userid, passwd를 한번에 @ModelAttribute로 만들어도 되는데 dto 담는게 실패할때도 있기때문에 각각 사용
		//비밀번호 체크
		boolean result = memberService.checkPw(memId,passwd);
		if(result) {				// MemberDAOImpl에서 return = true이면 삭제
			memberService.deleteMember(memId);
			return "redirect:/member/list.do";
		
		}else {  // 비밀번호 틀렸을때
			model.addAttribute("message", "비밀번호가 일치하지않습니다.");
			model.addAttribute("dto", memberService.viewMember(memId));	// model.addAttribute("변수명", "값");
			return "member/updateMemberFrm";
		}
	}
	// 로그인
	@RequestMapping("/member/login.do")	  
	public String login() {
		
		return "member/login";
	}
	
	//로그인 확인
	@RequestMapping("/member/login_check.do")	  
	public ModelAndView login_check(@ModelAttribute MemberDTO dto, HttpSession session) {
		
		// 로그인 성공시 -> 이름이 넘어옴    /  로그인 실패시 -> null이 넘어옴
		String name = memberService.loginCheck(dto, session);
		
		logger.info("name : " + name);
		
		ModelAndView mav = new ModelAndView();
		
		if(name != null) {
			mav.setViewName("home");
		}else {
			mav.setViewName("member/login");
			mav.addObject("message", "error");
		}
		
		return mav;
	}
	//로그아웃
	@RequestMapping("/member/logout.do")
	public ModelAndView logout(ModelAndView mav, HttpSession session) {
		
		memberService.logout(session);	// 세션 초기화
		
		mav.setViewName("member/login");
		mav.addObject("message", "logout");
		
		return mav;
	}
	
	// 	-------------------------------------------------------------------
	
	//id찾기 
	@RequestMapping(value="/member/findIdFrm", method=RequestMethod.GET)
	public String findIdView() throws Exception{
		return"/member/findIdFrm";
	}
	
	@RequestMapping(value="/findId.do", method=RequestMethod.POST)
	public String findId(MemberDTO dto,Model model) throws Exception{
				
		if(memberService.findIdCheck(dto.getEmail())==0) {
		model.addAttribute("msg", "이메일을 확인해주세요");
		return "/member/findIdFrm";
		}else {
		model.addAttribute("member", memberService.findId(dto.getEmail()));
		
		return "/member/findId";
		}
	}
	
}