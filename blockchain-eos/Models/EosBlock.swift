//
//  EosBlock.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

struct Transaction: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
        case cpuUsageUs = "cpu_usage_us"
        case netUsageWords = "net_usage_words"
        case trx
    }
    
    let status: String
    let cpuUsageUs: Int
    let netUsageWords: Int
    let trx: String
    
}

struct EosBlock: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case producer
        case producerSignature = "producer_signature"
        case transactions
    }
    
    let producer: String
    let producerSignature: String
    let transactionsCount: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        producer = try container.decodeIfPresent(String.self, forKey: CodingKeys.producer) ?? ""
        producerSignature = try container.decodeIfPresent(String.self, forKey: CodingKeys.producerSignature) ?? ""
    
        let transactions = try container.decodeIfPresent([Transaction].self, forKey: CodingKeys.transactions) ?? [Transaction]()
        transactionsCount = transactions.count
    }
}
