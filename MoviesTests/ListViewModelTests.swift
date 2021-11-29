//
//  ListViewModelTests.swift
//  MoviesTests
//
//  Created by Jacky Tjoa on 29/11/21.
//

import XCTest
@testable import Movies

class ListViewModelTests: XCTestCase {
  private var sut: ListViewModel!
  private var movieServiceMock: MovieServiceMock!

  override func setUp() {
    movieServiceMock = MovieServiceMock()
    sut = ListViewModel(service: movieServiceMock)
  }

  override func tearDown() {
    sut = nil
    movieServiceMock = nil
  }

  func testGetMovieList() {
    // GIVEN
    let dummySearchTerm = "some search term"
    var movies: [Movie] = []
    
    // WHEN
    sut.dataSource.bind { moviesResponse in
      movies = moviesResponse
    }
    sut.getMovieList(withSerchTerm: dummySearchTerm)
    
    // THEN
    XCTAssertTrue(movieServiceMock.isFetchMovieListCalled)
    XCTAssertFalse(movies.isEmpty, "getMovieList() should return list of movies")
  }

  func testGetNextPage() {
    // GIVEN
    let dummySearchTerm = "some search term"
    sut.setItemsPerPage(itemsPerPage: 1)
    sut.getMovieList(withSerchTerm: dummySearchTerm)
    
    // WHEN
    sut.getNextPage()
    
    // THEN
    XCTAssertTrue(movieServiceMock.isFetchMovieListCalled)
    XCTAssertEqual(sut.getCurrentPage(), 2, "currentPage should be incremented")
    XCTAssertEqual(sut.dataSource.value.count, 2, "data should be appended")
  }
}
