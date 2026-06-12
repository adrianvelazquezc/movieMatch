//
//  LoginViewRepository.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import Foundation

protocol LoginRepositoryProtocol {
    func login(withUser name: String, password: String) async throws -> String
}

class LoginRepository: MM_NetworkManager, LoginRepositoryProtocol {
    
    enum Paths {
        case newToken
        case validate
        case session
    }
    
    override init() {
        super.init()
    }
    
    func login(withUser name: String, password: String) async throws -> String {
        // Step 1: Request a new temporary authentication token from the server
        let tokenResponse: MovieToken = try await request(MovieMatchEndpoint.newToken)
        guard let token = tokenResponse.token else {
            throw NetworkError.serverError("Could not retrieve authentication token.")
        }
        
        // Persist values in memory for consecutive stateful networking requests
        self.requestToken = token
        self.username = name
        
        // Step 2: Validate user credentials against the newly acquired request token
        let loginResponse: MovieLogin = try await request(
            MovieMatchEndpoint.validateLogin(username: name, password: password, token: token)
        )
        
        guard loginResponse.success == true else {
            throw NetworkError.serverError("Incorrect username or password.")
        }
        
        // Step 3: Convert the validated request token into an official session ID
        let sessionResponse: MovieSession = try await request(MovieMatchEndpoint.newSession(token: token))
        guard let generatedSessionId = sessionResponse.session_id else {
            throw NetworkError.serverError("Could not generate session ID.")
        }
        
        // Retain the session state within the networking layer context
        self.sessionId = generatedSessionId
        
        return generatedSessionId
    }
}
