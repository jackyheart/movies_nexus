//
//  DetailViewModel.swift
//  Movies
//
//  Created by Jacky Tjoa on 25/11/21.
//

import UIKit

class DetailViewModel {
  private(set) var dataSource: Observable<MovieDetail?> = Observable(value: nil)
  private let movieService: MovieServiceProtocol
  private let imageService: ImageServiceProtocol
  
  init(movieService: MovieServiceProtocol, imageService: ImageServiceProtocol) {
    self.movieService = movieService
    self.imageService = imageService
  }

  func getMovieDetail(withMovieID movieID: String) {
    guard !movieID.isEmpty else { return }
    movieService.fetchMovieDetail(withMovieID: movieID).bind { [weak self] movieDetail in
      self?.dataSource.value = movieDetail
    }
  }

  func getMoviePoster(withURLString urlString: String) -> Observable<UIImage?> {
    guard !urlString.isEmpty else { return Observable(value: nil) }
    return imageService.loadImage(fromUrlString: urlString)
  }
}
