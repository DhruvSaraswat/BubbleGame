//
//  DifficultyLevelViewModel.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 13/05/24.
//

import Foundation
import UIKit

enum DifficultyLevelViewObserver {
    case showNextScreen
}

struct DifficultyLevelViewModel {
    var difficultyLevelViewObserver: ((DifficultyLevelViewObserver) -> Void)?
    private let levels: [String] = ["1", "2", "3", "4"]
    private let networkEngine: NetworkEngine

    init(networkEngine: NetworkEngine = NetworkEngineImpl()) {
        self.networkEngine = networkEngine
    }

    func getDropdownTitles() -> [String] {
        levels
    }

    func getRate(forLevel level: String) async {
        guard !level.isEmpty, let intLevel = Int(level) else { return }

        let apiResult = await networkEngine.request(request: Request.getLevelDetails(level: intLevel))

        switch apiResult {
        case .success(let response):
            guard let responseData = response,
                  let rate = String(data: responseData, encoding: String.Encoding.utf8) else {
                /// Show an error toast
                return
            }
            difficultyLevelViewObserver?(.showNextScreen)

        case .failure(let error):
            debugPrint("error in authentication = \(error)")
            /// Show an error toast
        }
    }
}
