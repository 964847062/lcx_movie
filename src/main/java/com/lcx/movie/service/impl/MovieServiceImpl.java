package com.lcx.movie.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lcx.movie.dao.MovieMapper;
import com.lcx.movie.domain.Movie;
import com.lcx.movie.service.MovieService;
import com.lcx.movie.vo.MovieVo;

@Service
public class MovieServiceImpl implements MovieService {

	@Resource
	private MovieMapper movieMapper;

	@Override
	public List<Movie> selects(MovieVo movievo) {

		return movieMapper.selects(movievo);
	}

	@Override
	public boolean delete(String ids) {
		// TODO Auto-generated method stub
		return movieMapper.delete(ids);
	}

	@Override
	public void update(Integer id) {

		Movie movie = movieMapper.selectById(id);

		if (movie.getStatus() == 1) {
			movie.setStatus(2);
		} else if (movie.getStatus() == 2) {
			movie.setStatus(1);
		}
		
		movieMapper.update(movie);

	}

}
