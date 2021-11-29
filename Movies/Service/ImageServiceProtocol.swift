//
//  ImageServiceProtocol.swift
//  Movies
//
//  Created by Jacky Tjoa on 26/11/21.
//

import UIKit

protocol ImageServiceProtocol {
  func loadImage(fromUrlString urlString: String) -> Observable<UIImage?>
  func invalidate()
}
