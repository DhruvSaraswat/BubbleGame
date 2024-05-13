//
//  LoginViewModel.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 12/05/24.
//

import Foundation

enum LoginViewObserver {
    case showNextScreen
}

struct LoginViewModel {
    private let networkEngine: NetworkEngine
    var loginViewObserver: ((LoginViewObserver) -> Void)?

    init(networkEngine: NetworkEngine = NetworkEngineImpl()) {
        self.networkEngine = networkEngine
    }

    func authenticate(username: String?, password: String?) async {
        guard let username, let password else {
            /// Show an error toast
            return
        }
        let apiResult: Result<LoginResponse?, APIError> = await networkEngine.request(request: Request.authenticate(username: username, password: password))

        switch apiResult {
        case .success(let loginResponse):
            guard let response = loginResponse,
                  let sessionID = response.message,
                  let status = response.status, status.lowercased().elementsEqual("success") else {
                /// Show an error toast
                return
            }
            debugPrint("SESSION ID = \(sessionID)")
            loginViewObserver?(.showNextScreen)

        case .failure(let error):
            debugPrint("error in authentication = \(error)")
            /// Show an error toast
        }
    }
}
