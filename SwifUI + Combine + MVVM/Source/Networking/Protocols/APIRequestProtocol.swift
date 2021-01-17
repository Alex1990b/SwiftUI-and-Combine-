
import Foundation

enum APIRequestType: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

protocol APIRequestProtocol {

    associatedtype ResponseType: Decodable
    var type: APIRequestType { get }
    var endPoint: EndPointProtocol { get }
}
