//
//  ImageService.swift
//  Movies
//
//  Created by Jacky Tjoa on 26/11/21.
//

import Foundation
import UIKit

class ImageService: ImageServiceProtocol {

  private lazy var session: URLSession = {
    URLCache.shared.memoryCapacity = 100 * 1024 * 1024
    
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    return URLSession(configuration: configuration)
  }()
  
  private var dataTask: URLSessionDataTask?
  
  func loadImage(fromUrlString urlString: String) -> Observable<UIImage?> {

    let observable: Observable<UIImage?> = Observable(value: nil)

    guard let url = URL(string: urlString) else {
      return observable
    }
    
    let dataTask = session.dataTask(with: url) { (data, response, error) in
      if error != nil {
        print("error fetching image data")
        return
      }
      if let data = data {
        observable.value = UIImage(data: data)
      }
    }
    dataTask.resume()
    self.dataTask = dataTask
    
    return observable
  }

  func invalidate() {
    dataTask?.cancel()
    dataTask = nil
  }
}
