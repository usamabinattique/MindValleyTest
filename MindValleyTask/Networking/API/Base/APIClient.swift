//
//  APIClient.swift
//  MindValleyTask
//
//  Created by usama on 11/04/2020.
//  Copyright © 2020 Usama. All rights reserved.
//

import Foundation
import Promises

class APIClient {

    static let shared = APIClient()

    private init() { }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - endPoint: NetworkEndPoint
    ///   - decode: Desired Model
    ///   - error: Desired Error Model
    ///   - completion: RequestCompletionHandler
    func request<T, E>(endPoint: NetworkEndPoint, decode: T.Type,
                       error: E.Type) -> Promise<T> where T: Decodable, E: Decodable & Error {

        return Promise<T> {
            return APIClient.shared.processRequest(with: endPoint, decodingType: T.self, errType: E.self)
        }
    }

    /// ProcessRequest
    ///O
    /// - Parameters:
    ///   - endPoint: NetworkEndPoint
    ///   - decodingType: Desired Model
    ///   - errType: Desired Error Model
    ///   - completion: RequestCompletionHandler
    private func processRequest<T, E>(with endPoint: NetworkEndPoint, decodingType: T.Type, errType: E.Type?) -> Promise<T> where T: Decodable, E: Decodable & Error {

        return Promise<T> { [weak self] (fulfill, reject) in
            guard let self = self else { return }

            let session = endPoint.session
            let request = self.buildRequest(endPoint)
            let task = session.dataTask(with: request) { data, response, error in
                self.logResponseFromServer(request: request, response: response, data: data, error: error)

                if let error = error {
                    reject(DefaultError.exception(error: error))
                    return
                }
                guard let responseData = data  else {
                    let (_, err) = JSONDecoder.decode(decodingType, errorType: errType, data: data)
                    reject(err ?? DefaultError.exception(error: err))
                    return
                }
                if !endPoint.isTesting {

                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        let (_, err) = JSONDecoder.decode(decodingType, errorType: errType, data: responseData)
                        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                        self.saveDataForTests(data: responseData, requestDetail: request, statusCode: statusCode)
                        reject(err ?? DefaultError.exception(error: err))
                        return
                    }
                }

                let (res, err) = JSONDecoder.decode(decodingType, errorType: errType, data: responseData)
                if let parsingError = err {
                    //this will be data issue so no need to save it for testing.
                    //                    if !endPoint.isTesting {
                    //                        self.saveDataForTests(data: responseData, requestDetail: request)
                    //                    }
                    reject(parsingError)
                    return

                }
                if let resData = res {
                    if !endPoint.isTesting {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                        self.saveDataForTests(data: responseData, requestDetail: request, statusCode: statusCode)
                    }
                    fulfill(resData)
                    return
                }
                reject(err ?? DefaultError.exception(error: error))
                return
            }
            task.resume()
        }

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

            SharedLogger.logInfo("\(String(describing: self)) request : \(httpReuqest)\n")
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

    /// This method should be used in Debug only
    ///
    /// - Parameters:
    ///   - data: Response Data
    ///   - requestDetail: URL Request Details
    ///   - statusCode: response status code
    private func saveDataForTests(data: Data, requestDetail: URLRequest?, statusCode: Int) {
        guard let fileName = requestDetail?.url?.lastPathComponent else { return }

        let queryString = requestDetail?.url?.query?.replacingOccurrences(of: "/", with: "_") ?? ""

        let fileNameToBeSaved = "\(fileName)\(queryString)\(statusCode == 200 ? "" : String(statusCode))"

        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileNameToBeSaved).appendingPathExtension("json")
        try! data.write(to: fileURL)
        print("File PAth: \(fileURL.path)")
    }
}
