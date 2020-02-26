package com.lcx.movie.dao;

import java.util.List;

import com.lcx.movie.domain.Movie;
import com.lcx.movie.vo.MovieVo;

public interface MovieMapper {

	List<Movie> selects(MovieVo movievo);

	boolean delete(String ids);

	Movie selectById(Integer id);

	void update(Movie movie);
}
