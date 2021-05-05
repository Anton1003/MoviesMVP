//
//  Loader.swift
//  Movies
//
//  Created by User on 11.03.2021.
//

import Alamofire
import Foundation

protocol NetworkServiceProtocol {
    func getMovies(completion: @escaping (Film) -> Void)
}

///
class NetworkService: NetworkServiceProtocol {
    func getMovies(completion: @escaping (Film) -> Void) {
        let url = "https://api.themoviedb.org/4/list/1?api_key=1383ccd603d60a04c2085457ec3c9e0d"
        AF.request(url, method: .get).responseDecodable(of: Film.self) { response in
            switch response.result {
            case let .success(film):
                completion(film)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
