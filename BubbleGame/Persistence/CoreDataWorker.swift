//
//  CoreDataWorker.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import CoreData
import Foundation

enum DBResult<T> {
    case sucess(_ response: T)
    case failure(_ error: String)
}

protocol CoreDataWorkerProtocol {
    associatedtype EntityType
    func fetch(_ predicate: NSPredicate?, _ description: [NSSortDescriptor]?, _ fetchLimit: Int?, _ completion: @escaping (DBResult<[EntityType]>) -> Void)
    func save(entities: [EntityType], completion: @escaping (Error?) -> Void)
}

final class CoreDataWorker<ManagedEntity, Entity>: CoreDataWorkerProtocol where ManagedEntity: NSManagedObject, ManagedEntity: ManagedObjectProtocol, Entity: ManagedObjectConvertible {
    typealias EntityType = Entity

    private let dataBaseService: CoreDataServiceProtocol

    init(dataBaseService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.dataBaseService = dataBaseService
    }

    func fetch(_ predicate: NSPredicate?, _ description: [NSSortDescriptor]?, _ fetchLimit: Int?, _ completion: @escaping (DBResult<[EntityType]>) -> Void) {
        dataBaseService.performBackgroundTask { context in
            do {
                let fetchRequest = ManagedEntity.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = description
                if let limit = fetchLimit {
                    fetchRequest.fetchLimit = limit
                }
                let results = try context.fetch(fetchRequest) as? [ManagedEntity]
                let items: [Entity] = results?.compactMap { $0.toEntity() as? Entity } ?? []
                completion(.sucess(items))
            } catch {
                completion(.failure(error.localizedDescription))
            }
        }
    }

    func save(entities: [EntityType], completion: @escaping (Error?) -> Void) {
        dataBaseService.performBackgroundTask { context in
            _ = entities.compactMap { entity -> ManagedEntity? in
                return entity.toManagedObject(in: context) as? ManagedEntity
            }

            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    completion(error)
                }
            }
            completion(nil)
        }
    }
}
