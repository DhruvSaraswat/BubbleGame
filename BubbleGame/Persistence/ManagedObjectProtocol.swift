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
    func toEntity() -> Entity?
}

protocol ManagedObjectConvertible {
    associatedtype ManagedObject
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}
