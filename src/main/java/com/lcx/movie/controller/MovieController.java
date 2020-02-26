package com.lcx.movie.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lcx.movie.domain.Movie;
import com.lcx.movie.service.MovieService;
import com.lcx.movie.vo.MovieVo;

//sd
//asdsad

@Controller
public class MovieController {
	
	
	@Resource
	private MovieService movieService;
	
	
	@RequestMapping("selects")
	public String list(MovieVo movievo,Model model) {
		if(movievo.getPageNum()==null || "".equals(movievo.getPageNum())) {
			movievo.setPageNum(1);
		}
		
		PageHelper.startPage(movievo.getPageNum(), 2);
		
		List<Movie> movies = movieService.selects(movievo);
		
		PageInfo<Movie> page = new PageInfo<Movie>(movies);
		model.addAttribute("movies",movies);
		model.addAttribute("page",page);
		model.addAttribute("movievo",movievo);
		return "movies";
		
	}
	
	@ResponseBody
	@RequestMapping("delete")
	public Object delete(String ids) {
		
		boolean flag = movieService.delete(ids);
		
		return flag;
		
	}
	
	

	@RequestMapping("update")
	public String update(Integer id) {
		System.out.println("已经进入方法");
		 movieService.update(id);
		
		
		return "redirect:selects";
	}
	
	
}
