//
//  Movie.swift
//  Movies
//
//  Created by Jacky Tjoa on 24/11/21.
//


struct MovieListResponse: Decodable {
  let movies: [Movie]
  let totalResults: Int

  enum CodingKeys: String, CodingKey {
    case search = "Search"
    case totalResults
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    movies = try container.decode([Movie].self, forKey: .search)
    let totalResultsInString = try container.decode(String.self, forKey: .totalResults)
    totalResults = Int(totalResultsInString) ?? 0
  }

  #if DEBUG
  init(movies: [Movie], totalResults: Int) {
    self.movies = movies
    self.totalResults = totalResults
  }
  #endif
}

struct Movie: Decodable {
  let imdbID: String
  let title: String
  let year: String
  let type: String
  let poster: String

  enum CodingKeys: String, CodingKey {
    case imdbID
    case title = "Title"
    case year = "Year"
    case type = "Type"
    case poster = "Poster"
  }
}

struct MovieDetail: Decodable {
  let imdbID: String
  let title: String
  let year: String
  let type: String
  let poster: String
  let rated: String
  let released: String
  let runtime: String
  let genre: String
  let plot: String
  let director: String
  let writer: String
  let actors: String
  let language: String
  let country: String
  let imdbRating: String

  enum CodingKeys: String, CodingKey {
    case imdbID
    case title = "Title"
    case year = "Year"
    case type = "Type"
    case poster = "Poster"
    case rated = "Rated"
    case released = "Released"
    case runtime = "Runtime"
    case genre = "Genre"
    case plot = "Plot"
    case director = "Director"
    case writer = "Writer"
    case actors = "Actors"
    case language = "Language"
    case country = "Country"
    case imdbRating
  }
}
