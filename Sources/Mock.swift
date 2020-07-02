//
//  Mock.swift
//  QMobileUI
//

import Foundation
import Moya

extension URL {

    static let qmobile = URL(string: "http://localhost")!
}

public class APIManager {
    /// Alias for network progression request callback.
    public typealias ProgressHandler = Moya.ProgressBlock
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

/// Status of 4D rest server.
public struct Status {
    static let okKey = "ok"
    static let successKey = "success"

    /// `true` if server ok
    public var ok: Bool

    public init(ok: Bool) {
        self.ok = ok
    }
}
public struct ImportableParser {

    public enum Error: Swift.Error {
        case emptyJSON
        case noTable
        case incoherentTableName(String, String)
        case builderReturnNil
    }
}
/// An error from data store
public enum APIError: Swift.Error {
    /// Indicates that JSON data for one page is not decodable.
    case jsonMappingFailed(JSON, Any.Type)

    /// Indicates that JSON data have incoherence and records could not be decoded.
    case recordsDecodingFailed(JSON, ImportableParser.Error)

    /// Indicates a response failed due to an underlying `Error`.
    case request(Swift.Error)

    /// Indicates a json decoding process due to an underlying `Error` .
    case jsonDecodingFailed(Swift.Error)

    /// Indicates a string decoding process due to an underlying `Error` .
    case stringDecodingFailed(Swift.Error)
}

public struct JSON {}

// MARK: authentificate
///  mobileapp/$authenticate/
public class AuthTarget: TargetType {
    public var baseURL: URL = URL.qmobile

    public var path: String = ""

    public var method: Moya.Method = .post

    public var sampleData: Data = Data()

    public var task: Task = .requestPlain

    public var headers: [String: String]?

    public enum Send: String {
        case link
        case code
    }
}

class MockCancellable: Cancellable {
    var isCancelled: Bool  = false

    func cancel() {
        isCancelled = true
    }
}

// MARK: Auth
extension APIManager {
    public typealias CompletionAuthTokenHandler = ((Result<AuthToken, APIError>) -> Void)
    /// Authentificate with login and password.
    open func authentificate(login: String,
                             password: String? = nil,
                             send: AuthTarget.Send = .link,
                             parameters: [String: Any]? = nil,
                             callbackQueue: DispatchQueue? = nil,
                             progress: ProgressHandler? = nil,
                             completionHandler: @escaping CompletionAuthTokenHandler) -> Cancellable {
        return MockCancellable()
    }

    /// Authentificate with token.
    open func authentificate(token: String,
                             callbackQueue: DispatchQueue? = nil,
                             progress: ProgressHandler? = nil,
                             completionHandler: @escaping CompletionAuthTokenHandler) -> Cancellable {
        return  MockCancellable()
    }

    /// Logout using token in headers or passed token.
    public typealias CompletionLogOutHandler = ((Result<Status, APIError>) -> Void)
    open func logout(token: String? = nil,
                     callbackQueue: DispatchQueue? = nil,
                     progress: ProgressHandler? = nil,
                     completionHandler: @escaping CompletionLogOutHandler) -> Cancellable {
        return MockCancellable()
    }
}

// MARK: Action

public struct ActionSheet {
    public let title: String?
    public let subtitle: String?
    public let dismissLabel: String?

    public let actions: [Action]

    public init(title: String? = nil,
                subtitle: String? = nil,
                dismissLabel: String? = nil,
                actions: [Action] = []) {
        self.title = title
        self.subtitle = subtitle
        self.dismissLabel = dismissLabel
        self.actions = actions
    }
}
public struct Action {
    public let name: String
}

public struct Table {
    public var name: String
    public var className: String?
    public var collectionName: String?
    public var scope: String?
    public var dataURI: String?

    public var attributes: [String: Attribute] = [:]
    public var attributesBySafeName: [String: Attribute] = [:]

    public init(name: String) {
        self.name = name
    }
}


public struct Attribute {
    /// Attribute name.
    public var name: String
}
