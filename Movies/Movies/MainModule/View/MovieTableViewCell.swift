//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import UIKit
///
final class MovieTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var categoriesLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!

    private var cacheDictionary: [String: Data] = [:]

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func prepareCell(movie: Result) {
        titleLabel.text = movie.title
        summaryLabel.text = movie.releaseDate
        ratingLabel.text = "\(movie.popularity)"
        categoriesLabel.text = "\(movie.voteAverage)"

        posterImageView.image = nil
        if cacheDictionary[movie.posterPath] != nil {
            posterImageView.image = UIImage(data: cacheDictionary[movie.posterPath] ?? Data())
        } else {
            guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { return }

            DispatchQueue.global().async { [weak self] in
                if let dataImage = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self?.cacheDictionary[movie.posterPath] = dataImage
                        self?.posterImageView.image = UIImage(data: dataImage)
                    }
                }
            }
        }
    }
}
