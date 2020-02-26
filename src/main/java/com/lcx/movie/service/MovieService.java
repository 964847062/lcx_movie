package com.lcx.movie.service;

import java.util.List;

import com.lcx.movie.domain.Movie;
import com.lcx.movie.vo.MovieVo;

public interface MovieService {
	List<Movie> selects(MovieVo movievo);

	boolean delete(String ids);

	void update(Integer id);
}
