//
//  BaseAPIClient.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation
import Promises

typealias RequestCompletionHandler = (Result<Decodable, DefaultError>) -> Void

class NetworkManager {

    static let shared = NetworkManager()

    private init() { }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - endPoint: NetworkEndPoint
    ///   - decode: Desired Model
    ///   - error: Desired Error Model
    ///   - completion: RequestCompletionHandler
    func request<T, E>(endPoint: NetworkEndPoint, decode: T.Type,
                       error: E.Type,
                       completion: @escaping RequestCompletionHandler) where T: Decodable, E: Decodable & Error {

        NetworkManager.shared.processRequest(with: endPoint, decodingType: T.self, errType: E.self, completionHandler: completion)
    }

    /// ProcessRequest
    ///
    /// - Parameters:
    ///   - endPoint: NetworkEndPoint
    ///   - decodingType: Desired Model
    ///   - errType: Desired Error Model
    ///   - completion: RequestCompletionHandler
    private func processRequest<T, E>(with endPoint: NetworkEndPoint, decodingType: T.Type, errType: E.Type?,
                                      completionHandler completion: @escaping RequestCompletionHandler) where T: Decodable, E: Decodable & Error {
        let session = endPoint.session
        let request = buildRequest(endPoint)
        let task = session.dataTask(with: request) { data, response, error in
            self.logResponseFromServer(request: request, response: response, data: data, error: error)

            if let error = error {
                completion(.failure(DefaultError.exception(error: error)))
                return
            }
            // swiftlint:disable:next unused_optional_binding
            guard let _ = response as? HTTPURLResponse, let responseData = data  else {
                completion(.failure(DefaultError.exception(error: error)))
                return
            }

            let (res, err) = JSONDecoder.decode(decodingType, errorType: errType, data: responseData)
            if let parsingError = err {
                completion(.failure(DefaultError.responseError(errorStatus: parsingError)))
                return
            }
            completion(.success(res))
            return

        }
        task.resume()
    }

    /// Constructs request from `NetworkEndPoint`
    private func buildRequest(_ endPoint: NetworkEndPoint) -> URLRequest {

        let url = endPoint.url.apending(endPoint.queryItems)
        let caching = endPoint.caching
        let timeout = endPoint.timeout
        var request = URLRequest(url: url, cachePolicy: caching, timeoutInterval: timeout)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers

        if let body = endPoint.body {
            request.httpBody = body
        }
        return request
    }

    //Handy private method to print request and response
    private func logResponseFromServer(request: URLRequest?, response: URLResponse?, data: Data?, error: Error?) {
        if let httpReuqest = request {
            //SharedLogger.logInfo("\(String(describing: self)) request : \(httpReuqest)\n")
            if let allHTTPHeaderFields = httpReuqest.allHTTPHeaderFields {
                SharedLogger.logInfo("""
                    \(String(describing: self))
                    request headers : \(allHTTPHeaderFields.description)\n
                    """)
            }
        }
        if let postBody = request?.httpBody,
            let strRequestBody = String(data: postBody, encoding: String.Encoding.utf8) {
            SharedLogger.logInfo("\(String(describing: self)) request body: \(strRequestBody)\n")
        }
        if let httpResponse = response {
            SharedLogger.logInfo("\(String(describing: self)) response headers: \(httpResponse)\n")
        }
        if let responseData = data, let strResponse = String(data: responseData, encoding: String.Encoding.utf8) {
            SharedLogger.logInfo("\(String(describing: self)) response: \(strResponse)\n")
        }
        if let error = error {
            SharedLogger.logError("response error: \(error)\n")
        }
    }
}

