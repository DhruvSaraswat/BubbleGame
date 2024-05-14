//
//  ManagedObjectProtocol.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import CoreData
import Foundation

protocol ManagedObjectProtocol {
    associatedtype Entity
    associatedtype ManagedObject
    func toEntity() -> Entity?
    func updateMOWithEntity(entity: Entity) -> ManagedObject?
}

protocol ManagedObjectConvertible {
    associatedtype ManagedObject
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}
