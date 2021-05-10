//
//  Photo.swift
//  Movies
//
//  Created by User on 09.05.2021.
//

import Foundation
import RealmSwift
///
struct PhotoModel: Codable {
    let id: Int
    let backdrops: [Photo]
}

final class Photo: Object {
    @objc dynamic var filePath = ""

    override class func primaryKey() -> String? {
        "filePath"
    }
}

extension Photo: Codable {
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
