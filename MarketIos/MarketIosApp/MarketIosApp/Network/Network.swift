//
//  Network.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 22/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

//MARK: ResponseType
enum ResponseType {
    case object
    case array
}

//MARK: Protocol
protocol NetworkProtocol {
    var url: String { get }
    
    var headers: HTTPHeaders? { get }
    
    var httpMethod: HTTPMethod { get }
    
    var parameters: Parameters? { get }
    
    var encoding: ParameterEncoding { get }
    
    var responseType: ResponseType { get }
}

//MARK: Auth
class BaseAuth {
    open var count: Int = 0
    
    open func doAuthentication<T: Mappable>(_ networkProtocol: NetworkProtocol, _ promise: NetworkPromise<T>){}
    
    open func onAuthenticationfailed(){}
    
    open func onUnauthorized<T: Mappable>(_ networkProtocol: NetworkProtocol, _ promise: NetworkPromise<T>) {
        if self.count >= 3 {
            self.count = 0
            self.onAuthenticationfailed()
            return
        }
        
        self.doAuthentication(networkProtocol, promise)
    }
    
    open func isAuthenticated<T: Mappable>(_ response: DataResponse<T>) -> Bool {
        let result: Bool = response.response?.statusCode != 401
        if result {
            self.count = 0
        }
        return result
    }
}

//MARK: NoAuth
class NoAuth: BaseAuth {
    override func isAuthenticated<T>(_ response: DataResponse<T>) -> Bool where T : Mappable {
        return true
    }
}

//MARK: Promise
class NetworkPromise <T: Mappable> {
    let delegate: (NetworkPromise<T>) -> Void
    
    private (set) var successCallback: ((NetworkPromise<T>, T?) -> Void)?
    private (set) var errorCallback: ((NetworkPromise<T>, String?) -> Void)?
    
    init(_ delegate: @escaping (NetworkPromise<T>) -> Void) {
        self.delegate = delegate
    }
    
    @discardableResult
    func onSuccess(_ callback: @escaping (NetworkPromise<T>, T?) -> Void) -> NetworkPromise<T> {
        self.successCallback = callback
        if self.errorCallback != nil {
            self.delegate(self)
        }
        return self
    }
    
    @discardableResult
    func onFailure(_ callback: @escaping (NetworkPromise<T>, String?) -> Void) -> NetworkPromise<T> {
        self.errorCallback = callback
        if self.successCallback != nil {
            self.delegate(self)
        }
        return self
    }
    
    open func isSuccessfull(_ response: DataResponse<T>) -> Bool {
        return (response.response?.statusCode ?? 0) >= 200 && (response.response?.statusCode ?? 0) <= 301
    }
    
    open func handleRequestResponse(_ networkProtocol: NetworkProtocol, _ response: DataResponse<T>) {
        if self.isSuccessfull(response) {
            self.successCallback?(self, response.result.value)
        } else {
            self.errorCallback?(self, response.result.error?.localizedDescription)
        }
        
//        else if Network.auth.isAuthenticated(response) {
//            Network.auth.onUnauthorized(networkProtocol, self)
//        }
        
    }
}

//MARK: Network
class Network {
    
    static var auth: BaseAuth = NoAuth()
    
    //MARK: Request
    class func request<T: Mappable>(_ networkProtocol: NetworkProtocol, _ promise: NetworkPromise<T>) throws {
        let request = try Alamofire.request(self.buildRequest(nil, networkProtocol))
        self.setupListeners(networkProtocol, request, promise)
    }
    
    class func request<T: Mappable>(_ anotherUrl: String? = nil, _ networkProtocol: NetworkProtocol, _ promise: NetworkPromise<T>) throws {
        let request = try Alamofire.request(self.buildRequest(anotherUrl, networkProtocol))
        self.setupListeners(networkProtocol, request, promise)
    }
    
    private class func buildRequest(_ anotherUrl: String? = nil, _ networkProtocol: NetworkProtocol) throws -> URLRequest {
        
        var request: URLRequest
        
        if let baseUrl = anotherUrl {
            let url = baseUrl + networkProtocol.url
            request = URLRequest(url: URL(string: url)!)
        } else {
            let url = Constants.API.baseUrl + networkProtocol.url
            request = URLRequest(url: URL(string: url)!)
        }
        
        //var request = URLRequest(url: anotherUrl ?? networkProtocol.url)
        request.httpMethod = networkProtocol.httpMethod.rawValue
        request.allHTTPHeaderFields = networkProtocol.headers
        request.timeoutInterval = 180
        
        let parameters = networkProtocol.parameters ?? [:]
        let encoding = networkProtocol.encoding
        
        return try encoding.encode(request, with: parameters)
    }
    
    //MARK: Listeners
    private class func setupListeners<T: Mappable>(_ networkProtocol: NetworkProtocol, _ request: DataRequest, _ promise: NetworkPromise<T>) {
        self.setupLogger(request)
        
        switch networkProtocol.responseType {
        case .object:
            self.appendObjectResponseListener(networkProtocol, request, promise)
            break
        case .array:
            //TODO: Here
            break
        }
    }
    
    private class func setupLogger(_ request: DataRequest){
        request.responseJSON(completionHandler: { response in
            
            print("\n======= REQUEST =======\n")
            
            let statusCode = String(describing: response.response?.statusCode ?? 0)
            print("STATUS CODE: \(statusCode)")
            
            let responseResult = response.result
            print("RESPONSE RESULT: \(responseResult)")
            
            let urlRequest = response.request != nil ? String(describing: response.request) : "url not found"
            print(("REQUEST URL: \(urlRequest))") as Any)  // original URL request
            
            print("\n======= HEADERS =======\n")
            
            let responseHeaders = response.response?.allHeaderFields ?? [:]
            print("RESPONSE HEADERS:\n\(responseHeaders)")
            
            let requestHeaders = response.request?.allHTTPHeaderFields ?? [:]
            print("REQUEST HEADERS:\n\(requestHeaders)")
            
            print("\n======= DATA =======\n")
            
            print(response.data as Any)     // server data

            if let httpBody = request.request?.httpBody {
                do {
                    let jsonBody = try JSONSerialization.jsonObject(with: httpBody)
                    print ("BODY:\n\(jsonBody)")
                } catch {
                    
                }
            }
            
            if let JSON = response.result.value {
                print("JSON:\n\(JSON)")
            }
        })
    }
    
    private class func appendObjectResponseListener<T: Mappable>(_ networkProtocol: NetworkProtocol, _ request: DataRequest, _ promise: NetworkPromise<T>) {
        request.responseObject { (response: DataResponse<T>) in
            promise.handleRequestResponse(networkProtocol, response)
        }
    }
}
