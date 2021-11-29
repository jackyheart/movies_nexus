//
//  MovieServiceMock.swift
//  MoviesTests
//
//  Created by Jacky Tjoa on 29/11/21.
//

@testable import Movies

class MovieServiceMock: MovieServiceProtocol {
  var isFetchMovieListCalled = false
  var isFetchMovieDetailCalled = false
  
  func fetchMovieList(withSearchTerm searchTerm: String, page: Int) -> Observable<MovieListResponse?> {
    isFetchMovieListCalled = true

    let movie = Movie(imdbID: "some id",
                      title: "some title",
                      year: "some year",
                      type: "some type",
                      poster: "some poster")
    let movieListResponse = MovieListResponse(movies: [movie], totalResults: 2)
    return Observable(value: movieListResponse)
  }

  func fetchMovieDetail(withMovieID movieID: String) -> Observable<MovieDetail?> {
    isFetchMovieDetailCalled = true

    let movieDetail = MovieDetail(imdbID: "some ID",
                                  title: "some title",
                                  year: "some year",
                                  type: "some type",
                                  poster: "some poster",
                                  rated: "some rated",
                                  released: "some released",
                                  runtime: "some runtime",
                                  genre: "some genre",
                                  plot: "some plot",
                                  director: "some director",
                                  writer: "some writer",
                                  actors: "some actors",
                                  language: "some language",
                                  country: "some country",
                                  imdbRating: "some rating")

    return Observable(value: movieDetail)
  }
}
