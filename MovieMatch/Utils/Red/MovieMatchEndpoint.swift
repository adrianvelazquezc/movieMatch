//
//  MovieMatchEndpoint.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import Foundation

enum MovieMatchEndpoint: Endpoint {
    case newToken
    case validateLogin(username: String, password: String, token: String)
    case newSession(token: String)
    case deleteSession(sessionId: String)
    case movieCategories(category: String)
    case movieDetails(movieId: Int)
    case favoriteList(username: String, sessionId: String, page: Int)
    case markFavorite(username: String, sessionId: String, mediaId: Int, isFavorite: Bool)

    var path: String {
        switch self {
        case .newToken:
            return "authentication/token/new"
        case .validateLogin:
            return "authentication/token/validate_with_login"
        case .newSession:
            return "authentication/session/new"
        case .deleteSession:
            return "authentication/session"
        case .movieCategories(let category):
            return "movie/\(category)"
        case .movieDetails(let movieId):
            return "movie/\(movieId)"
        case .favoriteList(let username, _, _):
            return "account/\(username)/favorite/movies"
        case .markFavorite(let username, _, _, _):
            return "account/\(username)/favorite"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .newToken, .movieCategories, .movieDetails, .favoriteList:
            return .get
        case .validateLogin, .newSession, .markFavorite:
            return .post
        case .deleteSession:
            return .delete
        }
    }

    var queryItems: [URLQueryItem]? {
        var items = [URLQueryItem]()
        switch self {
        case .deleteSession(let sessionId):
            items.append(URLQueryItem(name: "session_id", value: sessionId))
        case .favoriteList(_, let sessionId, let page):
            items.append(URLQueryItem(name: "session_id", value: sessionId))
            items.append(URLQueryItem(name: "sort_by", value: "created_at.asc"))
            items.append(URLQueryItem(name: "page", value: "\(page)"))
        case .markFavorite(_, let sessionId, _, _):
            items.append(URLQueryItem(name: "session_id", value: sessionId))
        default:
            break
        }
        return items.isEmpty ? nil : items
    }

    var body: [String: Any]? {
        switch self {
        case .validateLogin(let username, let password, let token):
            return ["username": username, "password": password, "request_token": token]
        case .newSession(let token):
            return ["request_token": token]
        case .markFavorite(_, _, let mediaId, let isFavorite):
            return ["media_type": "movie", "media_id": mediaId, "favorite": isFavorite]
        default:
            return nil
        }
    }

    var headers: [String: String]? {
        var defaultHeaders = ["Content-Type": "application/json"]
        switch self {
        case .movieDetails(_):
            let token = "YOUR_STATIC_BEARER_TOKEN"
            defaultHeaders["Authorization"] = "Bearer \(token)"
        default:
            break
        }
        return defaultHeaders
    }
}
