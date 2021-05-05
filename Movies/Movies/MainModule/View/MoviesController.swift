//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import UIKit
///
final class MoviesController: UITableViewController {
//    private let router = MainRouter()

    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie"
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
    }

    // MARK: - Table view data source

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        presenter?.films?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "movieCell",
            for: indexPath
        )
            as? MovieCell else { return UITableViewCell() }
        guard let movie = presenter.films?.results[indexPath.row] else { return UITableViewCell() }
        cell.prepareCell(movie: movie)
        return cell
    }
}

extension MoviesController: MainViewProtocol {
    func succes() {
        tableView.reloadData()
    }
}
