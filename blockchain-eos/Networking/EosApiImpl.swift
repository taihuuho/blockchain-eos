//
//  EosApiImpl.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import UIKit

extension String: Error {}

extension Encodable {
    // Have to do this as JSONEncode.decode asks for concrete type
    func toJsonData() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [.sortedKeys]
        return try jsonEncoder.encode(self)
    }
}

enum HTTPMethod: String {
    case POST = "POST"
}

final class EosApiImpl: EosApi {
    
    private let endpoint: URL
    private let urlSession: URLSession
    
    init(endpoint: String, urlSession: URLSession = URLSession.shared) {
        if let endpointUrl = URL(string: endpoint) {
            self.endpoint = endpointUrl
        } else {
            fatalError("Invalid URL. Could not create a URL from \(endpoint)")
        }
        self.urlSession = urlSession
    }
    
    private func buildRequest(path: String, method: HTTPMethod, params: Encodable? = nil) throws -> URLRequest {
        if let url = URL(string: path, relativeTo: self.endpoint) {
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let params = params {
                do {
                    urlRequest.httpBody = try params.toJsonData()
                } catch let e {
                    throw e
                }
            }
            return urlRequest
        } else {
            throw "Invalid API Path. Could not create a URL from \(path)"
        }
    }
    
    private func decipherJsonResponse<T: Decodable>(data: Data?, httpUrlResponse: HTTPURLResponse?, error: Error?) -> Result<T, ApiError> {
        if let error = error {
            let apiError = ApiError(code: -1, message: error.localizedDescription)
            
            return .failure(apiError)
        } else if let httpUrlResponse = httpUrlResponse {
            if let data = data {
                if httpStatusIsOK(httpUrlResponse.statusCode) {
                    do {
                        let jsonDecoder = JSONDecoder()
                        #if DEBUG
                        print("JSON for request: \(httpUrlResponse.url!)")
                        print(try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]))
                        #endif
                        let result = try jsonDecoder.decode(T.self, from: data)
                        return .success(result)
                    } catch let error {
                        return .failure(ApiError(code: -1, message: error.localizedDescription))
                    }
                } else {
                    // Parse the JSON for error case
                    do {
                        let jsonDecoder = JSONDecoder()
                        #if DEBUG
                        print("JSON for request: \(httpUrlResponse.url!)")
                        print(try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]))
                        #endif
                        let result = try jsonDecoder.decode(ApiError.self, from: data)
                        return .failure(result)
                    } catch let error {
                        let apiError = ApiError(code: -1, message: error.localizedDescription)
                        return .failure(apiError)
                    }
                }
            } else {
                let error = ApiError(code: -1, message: "Bad response")
                
                return .failure(error)
            }
        } else {
            let error = ApiError(code: -1, message: "Bad response")
            
            return .failure(error)
        }
    }
    
    private func executeRequest<T: Decodable>(apiPath: String, method: HTTPMethod = .POST, params: Encodable? = nil, completion: @escaping (Result<T, ApiError>) -> Void) {
        do {
            let request = try buildRequest(path: apiPath, method: method, params: params)
            let task = self.urlSession.dataTask(with: request) { (data, urlResponse, error) in
                let decipheredResponse: Result<T, ApiError> = self.decipherJsonResponse(data: data, httpUrlResponse: urlResponse as? HTTPURLResponse, error: error)
                completion(decipheredResponse)
            }
            
            task.resume()
        } catch let error {
            print(error)
        }
    }
    
    func getChainInfo(_ completion: @escaping (Result<EosInfo, ApiError>) -> Void) {
        
        executeRequest(apiPath: "v1/chain/get_info", completion: completion)
    }
    
    func getBlock(blockId: String, _ completion: @escaping (Result<EosBlock, ApiError>) -> Void) {
        let params = [
            "block_num_or_id": blockId
        ]
        executeRequest(apiPath: "v1/chain/get_block", params: params, completion: completion)
    }
    
}
