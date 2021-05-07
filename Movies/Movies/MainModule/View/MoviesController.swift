//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import UIKit
///
final class MoviesController: UITableViewController {
    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie"
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
    }

    // MARK: - Table view data source

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        presenter?.films?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "movieCell",
            for: indexPath
        )
            as? MovieCell else { return UITableViewCell() }
        guard let movie = presenter.films?[indexPath.row] else { return UITableViewCell() }
        cell.prepareCell(movie: movie)
        return cell
    }

//    MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = presenter.films?[indexPath.row]
        presenter.tapOnTheFilm(film: film)
    }
}

extension MoviesController: MainViewProtocol {
    func succes() {
        tableView.reloadData()
    }
}
