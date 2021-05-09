//
//  RealmProvider.swift
//  Movies
//
//  Created by User on 09.05.2021.
//

import RealmSwift

protocol RealmProviderProtocol {
    func get<RealmObject: Object>(type: RealmObject.Type) -> Results<RealmObject>
    func save<RealmObject: Object>(items: [RealmObject])
}

final class RealmProvider: RealmProviderProtocol {
    func get<RealmObject: Object>(type: RealmObject.Type) -> Results<RealmObject> {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm(configuration: config) else { fatalError("Error Realm") }
        return realm.objects(type)
    }

    func save<RealmObject: Object>(items: [RealmObject]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(items, update: .all)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
