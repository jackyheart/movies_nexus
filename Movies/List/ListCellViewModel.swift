//
//  ListCellViewModel.swift
//  Movies
//
//  Created by Jacky Tjoa on 26/11/21.
//

import UIKit

class ListCellViewModel {

  private let service: ImageServiceProtocol

  init(service: ImageServiceProtocol) {
    self.service = service
  }

  func reuse() {
    service.invalidate()
  }

  func fetchImage(withURLString urlString: String) -> Observable<UIImage?>  {
    return service.loadImage(fromUrlString: urlString)
  }
}
