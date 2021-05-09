//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import UIKit
///
final class DetailController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoriesLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var summaryTextView: UITextView!

    var presenter: DetailViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setFilm()
    }
}

extension DetailController: DetailViewProtocol {
    func success() {}

    func failure(_ error: Error) {
        print(error.localizedDescription)
    }

    func setFilm(film: Movie?) {
        titleLabel.text = film?.title
        ratingLabel.text = "\(film?.popularity ?? 0.0)"
        summaryTextView.text = film?.overview
        categoriesLabel.text = "\(film?.voteAverage ?? 0.0)"
        durationLabel.text = film?.releaseDate
//        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: film?.posterPath))")
//        else { return }
//        DispatchQueue.global().async { [weak self] in
//            if let dataImage = try? Data(contentsOf: imageURL) {
//                DispatchQueue.main.async {
//                    self?.bigPosterImageView.image = UIImage(data: dataImage)
//                }
//            }
//        }
    }
}
