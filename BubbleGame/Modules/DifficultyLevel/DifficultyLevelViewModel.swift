//
//  DifficultyLevelViewModel.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 13/05/24.
//

import Foundation
import UIKit

struct DifficultyLevelViewModel {
    private let levels: [String] = ["1", "2", "3", "4"]

    func getDropdownTitles() -> [String] {
        levels
    }

    func getRate(forLevel: String) {

    }
}
