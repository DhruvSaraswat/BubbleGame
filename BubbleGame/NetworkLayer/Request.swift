//
//  Request.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 12/05/24.
//

import Foundation

enum Request: APIRequest {
    case authenticate(username: String, password: String)

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
        }
    }

    var port: Int? {
        nil
    }

    var headers: [String : String]? {
        switch self {
        case .authenticate:
            return nil
        }
    }

    var query: String? {
        switch self {
        case .authenticate(let username, let password):
            return "login={\"username\":\"\(username)\",\"password\":\"\(password)\"}"
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
        case .authenticate:
            return HTTPMethod.post
        }
    }

    var requestBody: [String : Any]? {
        switch self {
        case .authenticate:
            return nil
        }
    }
}
