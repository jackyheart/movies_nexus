//
//  NetworkManager.swift
//  Movies
//
//  Created by Jacky Tjoa on 25/11/21.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  private let baseURL = "https://www.omdbapi.com/"
  private let apiKey = "b9bd48a6" //should not add to source control on production app

  func fetchData(withQueryParameters queryParameters: [String: String]) -> Observable<Data?> {
    let responseData: Observable<Data?> = Observable(value: nil)
    let session = URLSession.shared
    guard var urlComponents = URLComponents(string: baseURL) else { return responseData }

    urlComponents.queryItems = queryParameters.map { (key, value) in
      URLQueryItem(name: key, value: value)
    }
    urlComponents.queryItems?.append(URLQueryItem(name: "apikey", value: apiKey))

    guard let url = urlComponents.url else { return responseData }
    
    let request = URLRequest(url: url)

    let task = session.dataTask(with: request) { (data, response, error) in
      if error != nil {
        print("error fetching data")
      } else {
        responseData.value = data
      }
    }
    task.resume()
    return responseData
  }
}
