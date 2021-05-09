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
    func loadPhotos(for filmId: Int, completion: @escaping ([Photo]?) -> ())
}

protocol NetworkServiceProtocol: GetFilmServiceProtocol, GetImagesServiceProtocol {}

///
class NetworkService: NetworkServiceProtocol {
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

    func loadPhotos(for filmId: Int, completion: @escaping ([Photo]?) -> ()) {
        let path = "/\(filmId)/images"
        let parameters: Parameters = [
            "api_key": apiKey
        ]

        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseDecodable(of: [Photo].self, queue: .global()) { response in
                switch response.result {
                case let .success(data):
                    completion(data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }
}
