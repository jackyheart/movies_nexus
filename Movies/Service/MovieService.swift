//
//  MovieService.swift
//  Movies
//
//  Created by Jacky Tjoa on 25/11/21.
//

import Foundation

class MovieService: MovieServiceProtocol {

  func fetchMovieList(withSearchTerm searchTerm: String, page: Int) -> Observable<MovieListResponse?> {
    let movieListResponse: Observable<MovieListResponse?> = Observable(value: nil)
    let params = ["s": searchTerm,
                  "page": "\(page)",
                  "type": "movie"]

    NetworkManager.shared.fetchData(withQueryParameters: params).bind { data in
      do {
        let decoder = JSONDecoder()
        if let data = data {
          let response = try decoder.decode(MovieListResponse.self, from: data)
          movieListResponse.value = response
        }
      } catch {
        print("can't decode MovieListResponse, error: \(error)")
      }
    }

    return movieListResponse
  }
  
  func fetchMovieDetail(withMovieID movieID: String) -> Observable<MovieDetail?> {
    let movieDetail: Observable<MovieDetail?> = Observable(value: nil)
    let params = ["i": movieID]
    
    NetworkManager.shared.fetchData(withQueryParameters: params).bind { data in
      do {
        let decoder = JSONDecoder()
        if let data = data {
          let response = try decoder.decode(MovieDetail.self, from: data)
          movieDetail.value = response
        }
      } catch {
        print("can't decode MovieDetail, error: \(error)")
      }
    }
   
    return movieDetail
  }
}
