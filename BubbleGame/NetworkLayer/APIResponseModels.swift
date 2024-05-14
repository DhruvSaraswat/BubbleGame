//
//  APIResponseModels.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 14/05/24.
//

import Foundation

struct LoginResponse: Codable {
    let message, status: String?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
    }
}
