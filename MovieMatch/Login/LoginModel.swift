//
//  LoginModel.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

struct MovieToken: Decodable {
    let success: Bool?
    let expires_at: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expires_at
        case token = "request_token"
    }
}

struct MovieLogin: Decodable {
    let success: Bool?
    let request_token: String?
}

struct MovieSession: Decodable {
    let success: Bool?
    let session_id: String?
}
