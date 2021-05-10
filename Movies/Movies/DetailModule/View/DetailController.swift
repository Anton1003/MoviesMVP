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

    var presenter: DetailViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setFilm()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DetailController: DetailViewProtocol {
    func success() {
        collectionView.reloadData()
    }

    func failure(_ error: Error) {
        print(error.localizedDescription)
    }

    func setFilm(film: Movie?) {
        titleLabel.text = film?.title
        ratingLabel.text = "\(film?.popularity ?? 0.0)"
        summaryTextView.text = film?.overview
        categoriesLabel.text = "\(film?.voteAverage ?? 0.0)"
        durationLabel.text = film?.releaseDate
    }
}

extension DetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.imageArray.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? ImageCollectionCell
        else { return UICollectionViewCell() }
        if let photo = presenter?.imageArray[indexPath.row] {
            cell.setImage(photo)
        }
        return cell
    }
}

extension DetailController: UICollectionViewDelegate {}
