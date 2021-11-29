//
//  ListCell.swift
//  Movies
//
//  Created by Jacky Tjoa on 24/11/21.
//

import UIKit

class ListCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  private var viewModel: ListCellViewModel!

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    let imageService = ImageService()
    viewModel = ListCellViewModel(service: imageService)
  }

  override func prepareForReuse() {
    imageView.image = nil
    viewModel.reuse()
  }

  func configureUI() {
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 4.0
    imageView.layer.masksToBounds = true
  }

  func loadImage(withURLString urlString: String) {
    viewModel.fetchImage(withURLString: urlString).bind { (image) in
      DispatchQueue.main.async { [weak self] in
        self?.imageView.image = image
      }
    }
  }
}
