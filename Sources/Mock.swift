//
//  Mock.swift
//  QMobileUI
//

import Foundation

extension URL {
    
    static let qmobile = URL(string: "http://localhost")!
}

public class APIManager {
    /// Default instance of `Self` which use `URL.qmobile` as base url
    public static var instance = APIManager(url: URL.qmobile)

    // MARK: Init
    /// Create an api manager using server URL
    public init(url: URL) {
    }
    public var authToken: AuthToken?
}

/// Authentication token.
public struct AuthToken {
    /// Session id
    public let id: String
    /// Optionnal status message
    public let statusText: String?
    /// Token
    public let token: String?
    /// Additional information
    public let userInfo: [String: Any]?

    /// Create a token with known attributes
    public init(id: String, statusText: String?, token: String?, userInfo: [String: Any]? = nil) {
        self.id = id
        self.token = token
        self.userInfo = userInfo
        self.statusText = statusText
    }
}

extension AuthToken {
    public var email: String? {
        return userInfo?["email"] as? String
    }

    public var isValidToken: Bool {
        guard let token = self.token, !token.isEmpty else {
            return false
        }
        return true
    }
    
    public var isExpiredToken: Bool {
        return isValidToken
    }
}

// MARK: Equatable
extension AuthToken: Equatable {
    public static func == (lhf: AuthToken, rhf: AuthToken) -> Bool {
        return lhf.token == rhf.token && lhf.id == rhf.id
    }
}
