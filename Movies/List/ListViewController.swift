//
//  ListViewController.swift
//  Movies
//
//  Created by Jacky Tjoa on 24/11/21.
//

import UIKit

class ListViewController: UIViewController {
  private var viewModel: ListViewModel!
  private var enteredSearchText: String = ""
  private let reuseIdentifier = "reuseIdentifier"
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  private enum Constants {
    static let sectionInsets = UIEdgeInsets(
      top: 16.0,
      left: 16.0,
      bottom: 16.0,
      right: 16.0)
    static let itemsPerRow: CGFloat = 2.0
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // UI config
    collectionView.dataSource = self
    collectionView.delegate = self
    searchBar.delegate = self
    searchBar.tintColor = .systemRed
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.tintColor = .systemRed
    navigationController?.view.backgroundColor = .clear
    let textFieldApp = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
    textFieldApp.textColor = .white

    // data binding
    let movieService = MovieService()
    viewModel = ListViewModel(service: movieService)
    viewModel.dataSource.bind { [weak self] movies in
      DispatchQueue.main.async {
        let indexSet = IndexSet(integer: 0)
        self?.collectionView.reloadSections(indexSet)
      }
    }
    
    // initial load with keyword 'marvel' so that the list is not empty
    let defaultSearchTerm = "marvel"
    searchBar.text = defaultSearchTerm
    viewModel.getMovieList(withSearchTerm: defaultSearchTerm)
  }
}

extension ListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.dataSource.value.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ListCell else { return UICollectionViewCell() }
    let data = viewModel.dataSource.value[indexPath.row]
    cell.configureUI()
    cell.loadImage(withURLString: data.poster)
    cell.titleLabel.text = data.title
    return cell
  }
}

extension ListViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == viewModel.dataSource.value.count - 1 {
      viewModel.getNextPage()
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let detailViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
        print("Unable to instantiate DetailViewController")
      return
    }
    let data = viewModel.dataSource.value[indexPath.row]
    detailViewController.setData(withMovieID: data.imdbID, imageURLString: data.poster)
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / Constants.itemsPerRow
    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return Constants.sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.sectionInsets.left
  }
}

extension ListViewController: UISearchBarDelegate {

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    enteredSearchText = searchBar.text ?? ""
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.getMovieList(withSearchTerm: enteredSearchText)
    searchBar.resignFirstResponder()
  }
}
