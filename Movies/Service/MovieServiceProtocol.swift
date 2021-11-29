//
//  MovieServiceProtocol.swift
//  Movies
//
//  Created by Jacky Tjoa on 25/11/21.
//

protocol MovieServiceProtocol {
  func fetchMovieList(withSearchTerm searchTerm: String, page: Int) -> Observable<MovieListResponse?>
  func fetchMovieDetail(withMovieID movieID: String) -> Observable<MovieDetail?>
}
