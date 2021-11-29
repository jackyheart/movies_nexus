//
//  ListCellViewModelTests.swift
//  MoviesTests
//
//  Created by Jacky Tjoa on 29/11/21.
//

import XCTest
@testable import Movies

class ListCellViewModelTests: XCTestCase {
  private var sut: ListCellViewModel!
  private var imageServiceMock: ImageServiceMock!

  override func setUp() {
    imageServiceMock = ImageServiceMock()
    sut = ListCellViewModel(service: imageServiceMock)
  }

  override func tearDown() {
    sut = nil
    imageServiceMock = nil
  }

  func testFetchImage() {
    // GIVEN
    let dummyURLString = "www.someurl.com"
    
    // WHEN
    _ = sut.fetchImage(withURLString: dummyURLString)
    
    // THEN
    XCTAssertTrue(imageServiceMock.isLoadImageCalled)
  }

  func testReuse() {
    // WHEN
    sut.reuse()
    
    // THEN
    XCTAssertTrue(imageServiceMock.isInvalidateCalled)
  }
}
