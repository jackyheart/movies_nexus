//
//  ImageServiceMock.swift
//  MoviesTests
//
//  Created by Jacky Tjoa on 29/11/21.
//

@testable import Movies
import UIKit

class ImageServiceMock: ImageServiceProtocol {
  var isLoadImageCalled = false
  var isInvalidateCalled = false

  func loadImage(fromUrlString urlString: String) -> Observable<UIImage?> {
    isLoadImageCalled = true
    return Observable(value: nil)
  }

  func invalidate() {
    isInvalidateCalled = true
  }
}
