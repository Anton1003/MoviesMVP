//
//  Loader.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import Alamofire
import Foundation

protocol GetFilmServiceProtocol {
    func getMovies(completion: @escaping (Film) -> Void)
}

protocol GetImagesServiceProtocol {
    func loadPhotos(for filmId: Int, completion: @escaping (Result<[Photo]?, Error>) -> ())
}

protocol NetworkServiceProtocol: GetFilmServiceProtocol, GetImagesServiceProtocol {}

final class NetworkService: NetworkServiceProtocol {
    let baseURL = "https://api.themoviedb.org"
    let apiKey = "1383ccd603d60a04c2085457ec3c9e0d"

    func getMovies(completion: @escaping (Film) -> Void) {
        let path = "/4/list/1"
        let parameters: Parameters = [
            "api_key": apiKey
        ]
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseDecodable(of: Film.self, queue: .global()) { response in
                switch response.result {
                case let .success(film):
                    completion(film)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }

    func loadPhotos(for filmId: Int, completion: @escaping (Result<[Photo]?, Error>) -> ()) {
        let path = "/3/movie/\(filmId)/images"
        let parameters: Parameters = [
            "api_key": apiKey
        ]

        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData(queue: .global()) { response in
                switch response.result {
                case let .success(data):
                    do {
                        let photos = try JSONDecoder().decode(PhotoModel.self, from: data).backdrops
                        completion(.success(photos))
                    } catch {
                        completion(.failure(error))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
