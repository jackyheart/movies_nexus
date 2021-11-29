//
//  ListViewModel.swift
//  Movies
//
//  Created by Jacky Tjoa on 24/11/21.
//

class ListViewModel {
  private(set) var dataSource: Observable<[Movie]> = Observable(value: [])
  private let service: MovieServiceProtocol
  private var searchTerm = ""
  private var currentPage = 1
  private var totalResults = 0
  private var itemsPerPage = 10
  private var totalPages = 1

  init(service: MovieServiceProtocol) {
    self.service = service
  }

  func getMovieList(withSearchTerm searchTerm: String) {
    guard !searchTerm.isEmpty else { return }

    self.searchTerm = searchTerm
    currentPage = 1

    service.fetchMovieList(withSearchTerm: searchTerm, page: currentPage).bind { [weak self] (movieListResponse) in
      guard let movieListResponse = movieListResponse else { return }
      self?.totalResults = movieListResponse.totalResults

      // calculate total number of pages based on 'totalResults' and 'itemsPerPage'
      if let totalResults = self?.totalResults, let itemsPerPage = self?.itemsPerPage {
        let remainder: Int = totalResults % itemsPerPage
        let pages: Int = totalResults / itemsPerPage
        self?.totalPages = remainder == 0 ? pages : pages + 1
      }

      self?.dataSource.value = movieListResponse.movies
    }
  }

  func getNextPage() {
    guard currentPage + 1 <= totalPages else { return }
    currentPage = currentPage + 1

    service.fetchMovieList(withSearchTerm: searchTerm, page: currentPage).bind { [weak self] (movieListResponse) in
      guard let movieListResponse = movieListResponse else { return }
      let nextMovies = movieListResponse.movies
      self?.dataSource.value.append(contentsOf: nextMovies)
    }
  }

  #if DEBUG
  func setItemsPerPage(itemsPerPage: Int) {
    self.itemsPerPage = itemsPerPage
  }

  func getCurrentPage() -> Int {
    return currentPage
  }
  #endif
}
