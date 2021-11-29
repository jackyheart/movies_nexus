//
//  DetailViewModelTests.swift
//  MoviesTests
//
//  Created by Jacky Tjoa on 29/11/21.
//

import XCTest
@testable import Movies

class DetailViewModelTests: XCTestCase {
  private var sut: DetailViewModel!
  private var movieServiceMock: MovieServiceMock!
  private var imageServiceMock: ImageServiceMock!

  override func setUp() {
    movieServiceMock = MovieServiceMock()
    imageServiceMock = ImageServiceMock()
    sut = DetailViewModel(movieService: movieServiceMock, imageService: imageServiceMock)
  }

  override func tearDown() {
    sut = nil
    movieServiceMock = nil
    imageServiceMock = nil
  }

  func testGetMovieDetail() {
    // GIVEN
    let movieID = "some movie ID"
    var movieDetail: MovieDetail?
    
    // WHEN
    sut.dataSource.bind { movieDetailResponse in
      movieDetail = movieDetailResponse
    }
    sut.getMovieDetail(withMovieID: movieID)
    
    // THEN
    XCTAssertTrue(movieServiceMock.isFetchMovieDetailCalled)
    XCTAssertNotNil(movieDetail)
  }

  func testGetMoviePoster() {
    // GIVEN
    let dummyURLString = "www.someurl.com"
    
    // WHEN
    _ = sut.getMoviePoster(withURLString: dummyURLString)
    
    // THEN
    XCTAssertTrue(imageServiceMock.isLoadImageCalled)
  }
}
