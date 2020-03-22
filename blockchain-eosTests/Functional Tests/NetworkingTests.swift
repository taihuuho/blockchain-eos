//
//  NetworkingTests.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/19/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import XCTest

@testable import blockchain_eos

final class MockURLSession: URLSession {
    private var dataTask: MockURLSessionDataTask!
    
    override init() {}
    
    func setMockResponse(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        dataTask = MockURLSessionDataTask()
        dataTask.taskResponse = (data, response, error)
    }
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let (data, response, error) = self.dataTask.taskResponse!
        if let response = response as? HTTPURLResponse {
            let newResponse = HTTPURLResponse(url: request.url!, statusCode: response.statusCode, httpVersion: "1.1", headerFields: response.allHeaderFields as? [String : String])
            dataTask.taskResponse = (data, newResponse, error)
        }
        dataTask.completionHandler = completionHandler
        return dataTask
    }
}

final class MockURLSessionDataTask: URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (Data?, URLResponse?, Error?)?
    
    override init() {}
    
    override func resume() {
      DispatchQueue.main.async {
        self.completionHandler?(
            self.taskResponse?.0,
            self.taskResponse?.1,
            self.taskResponse?.2
        )
      }
    }
}

class NetworkingTests: XCTestCase {
    let mockServerEndpoint = "http://localhost"
    var apiClient: EosApi!
    var mockUrlSession: MockURLSession!
    var baseURL: URL!

    override func setUp() {
        mockUrlSession = MockURLSession()
        baseURL = URL(string: mockServerEndpoint)!
        apiClient = EosApiImpl(endpoint: mockServerEndpoint, urlSession: mockUrlSession)
    }

    override func tearDown() {
        mockUrlSession = nil
        apiClient = nil
    }

    func testGetInfoSuccess() {
        let getInfoData = MockDataProvider.getInfoJSON.data(using: .utf8)
        let jsonDecoder = JSONDecoder()
        let mockEosInfo = try! jsonDecoder.decode(EosInfo.self, from: getInfoData!)
        let urlResponse = HTTPURLResponse(url: baseURL, statusCode: 200, httpVersion: "1.0", headerFields: nil)
        mockUrlSession.setMockResponse(data: getInfoData, response: urlResponse, error: nil)
        apiClient.getChainInfo { (result) in
            switch result {
            case .success(let eosInfo):
                XCTAssertTrue(eosInfo.headBlockId == mockEosInfo.headBlockId)
                break
            case .failure(_):
                XCTAssertFalse(true)
                break
            }
        }
    }
    
    func testGetBlockSuccess() {
        let getBlockData = MockDataProvider.getEosBlockJSON.data(using: .utf8)
        let jsonDecoder = JSONDecoder()
        let mockEosBlock = try! jsonDecoder.decode(EosBlock.self, from: getBlockData!)
        let urlResponse = HTTPURLResponse(url: baseURL, statusCode: 200, httpVersion: "1.0", headerFields: nil)
        mockUrlSession.setMockResponse(data: getBlockData, response: urlResponse, error: nil)
        
        apiClient.getBlock(blockId: mockEosBlock.id) { (result) in
            switch result {
            case .success(let eosBlock):
                XCTAssertTrue(eosBlock.id == mockEosBlock.id)
                break
            case .failure(_):
                break
            }
        }
    }
    
    func testGetBlockFailure() {
        
        let jsonDecoder = JSONDecoder()
        let getBlockData = MockDataProvider.getEosBlockJSON.data(using: .utf8)!
        let mockEosBlock = try! jsonDecoder.decode(EosBlock.self, from: getBlockData)
        
        let apiErrorData = MockDataProvider.getEosBlockJSONError.data(using: .utf8)!
        let mockApiError = try! jsonDecoder.decode(ApiError.self, from: apiErrorData)
        
        let urlResponse = HTTPURLResponse(url: baseURL, statusCode: 500, httpVersion: "1.0", headerFields: nil)
        mockUrlSession.setMockResponse(data: apiErrorData, response: urlResponse, error: nil)
        
        apiClient.getBlock(blockId: mockEosBlock.id) { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertTrue(error.code == mockApiError.code)
                XCTAssertTrue(error.message == mockApiError.message)
                break
            }
        }
    }
}
