//
//  APIRequest.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 12/05/24.
//

import Foundation

enum APIError: Error {
    case requestCreationFailed
    case serverError(error: Error)
    case serverError(statusCode: Int)
}

protocol APIRequest {
    /// `HTTP` or `HTTPS`
    var scheme: String { get }

    /// Example: `"api.flickr.com"`
    var baseURL: String { get }

    /// Example: `"/services/rest`
    var path: String { get }

    var port: Int? { get }

    var headers: [String: String]? { get }

    var query: String? { get }

    // var queryParameters: [URLQueryItem]? { get }

    var method: HTTPMethod { get }

    var requestBody: [String: Any]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
