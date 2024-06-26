//
//  Request.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 12/05/24.
//

import Foundation

enum Request: APIRequest {
    case authenticate(username: String, password: String)
    case getLevelDetails(level: Int)
    case saveScore(score: Int, sessionID: String, username: String)

    var scheme: String {
        "http"
    }

    var baseURL: String {
        "test.sensibol.com"
    }

    var path: String {
        switch self {
        case .authenticate:
            return "/authenticate"
        case .getLevelDetails:
            return "/leveldetails"
        case .saveScore:
            return "/savescore"
        }
    }

    var port: Int? {
        nil
    }

    var headers: [String : String]? {
        nil
    }

    var query: String? {
        switch self {
        case .authenticate(let username, let password):
            return "login={\"username\":\"\(username)\",\"password\":\"\(password)\"}"
        case .getLevelDetails(let level):
            return "level=\(level)"
        case .saveScore(let score, let sessionID, let username):
            return "score=\(score)&sessionID=\(sessionID)&username=\(username)"
        }
    }

    /**var queryParameters: [URLQueryItem]? {
        switch self {
        case .authenticate(let username, let password):
            return [URLQueryItem(name: "login", value: "{\"username\":\"\(username)\",\"password\": \"\(password)\"}"]
        }
    }*/

    var method: HTTPMethod {
        switch self {
        case .authenticate, .saveScore:
            return HTTPMethod.post
        case .getLevelDetails:
            return HTTPMethod.get
        }
    }

    var requestBody: [String : Any]? {
        nil
    }
}
