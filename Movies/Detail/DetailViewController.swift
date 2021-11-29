//
//  DetailViewController.swift
//  Movies
//
//  Created by Jacky Tjoa on 25/11/21.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var ratedLabel: UILabel!
  @IBOutlet weak var runtimeLabel: UILabel!
  @IBOutlet weak var imdbRatingLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var releasedLabel: UILabel!
  @IBOutlet weak var plotLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var languageLabel: UILabel!
  @IBOutlet weak var directorLabel: UILabel!
  @IBOutlet weak var writerLabel: UILabel!
  @IBOutlet weak var actorsLabel: UILabel!
  
  private var movieID: String = ""
  private var imageURLString: String = ""
  private var detailViewModel: DetailViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // configure UI
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true

    // data binding
    let movieService = MovieService()
    let imageService = ImageService()
    detailViewModel = DetailViewModel(movieService: movieService, imageService: imageService)
    detailViewModel.dataSource.bind { [weak self] movieDetail in
      DispatchQueue.main.async {
        self?.bindUI(withMovieDetail: movieDetail)
      }
    }
    detailViewModel.getMovieDetail(withMovieID: movieID)
    detailViewModel.getMoviePoster(withURLString: imageURLString).bind { [weak self] image in
      DispatchQueue.main.async {
        self?.imageView.image = image
      }
    }
  }

  private func bindUI(withMovieDetail movieDetail: MovieDetail?) {
    guard let movieDetail = movieDetail else { return }
    titleLabel.text = movieDetail.title
    yearLabel.text = movieDetail.year
    ratedLabel.text = movieDetail.rated
    runtimeLabel.text = movieDetail.runtime
    imdbRatingLabel.text = movieDetail.imdbRating
    genreLabel.text = "Genre: \(movieDetail.genre)"
    releasedLabel.text = "Released: \(movieDetail.released)"
    plotLabel.text = movieDetail.plot
    countryLabel.text = "Country: \(movieDetail.country)"
    languageLabel.text = "Language: \(movieDetail.language)"
    directorLabel.text = "Director: \(movieDetail.director)"
    writerLabel.text = "Writer: \(movieDetail.writer)"
    actorsLabel.text = "Actors: \(movieDetail.actors)"
  }

  func setData(withMovieID movieID: String, imageURLString: String) {
    self.movieID = movieID
    self.imageURLString = imageURLString
  }
}
