//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import UIKit
///
final class MoviesController: UITableViewController {
    private var movies: [Result] = []
    private let router = MainRouter()

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService().getMovies { moviesArray in
            self.movies = moviesArray.results
            self.tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let vcMVD = segue.destination as? DetailController {
            guard let row = tableView.indexPathForSelectedRow?.row else { return }
            let movie = movies[row]
            vcMVD.movie = movie
        }
    }

    // MARK: - Table view data source

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "movieCell",
            for: indexPath
        ) as? MovieCell else { return UITableViewCell() }
        cell.prepareCell(movie: movies[indexPath.row])
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        router.toDetail()
//    }
}
