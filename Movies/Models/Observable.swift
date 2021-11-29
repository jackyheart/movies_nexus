//
//  Observable.swift
//  Movies
//
//  Created by Jacky Tjoa on 24/11/21.
//

class Observable<T> {
  private var callback: ((T) -> Void)?

  var value: T {
    didSet {
      callback?(value)
    }
  }

  init(value: T) {
    self.value = value
  }

  func bind(completion: @escaping (T) -> Void) {
    callback = completion
    completion(value)
  }
}
