//
//  EosBlock.swift
//  blockchain-eos
//
//  Created by Tai Huu Ho on 3/20/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

struct EosTransaction: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
        case cpuUsageUs = "cpu_usage_us"
        case netUsageWords = "net_usage_words"
        case trx
    }
    
    let status: String
    let cpuUsageUs: Int
    let netUsageWords: Int
//    let trx: AnyObject
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decodeIfPresent(String.self, forKey: CodingKeys.status) ?? ""
        cpuUsageUs = try container.decodeIfPresent(Int.self, forKey: CodingKeys.cpuUsageUs) ?? -1
        netUsageWords = try container.decodeIfPresent(Int.self, forKey: CodingKeys.netUsageWords) ?? -1
//        trx = try container.dec
    }
    
}

struct EosBlock: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case producer
        case producerSignature = "producer_signature"
        case transactions
        case previousBlockId = "previous"
    }
    
    let producer: String
    let producerSignature: String
    let transactionsCount: Int
    let previousBlockId: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        producer = try container.decodeIfPresent(String.self, forKey: CodingKeys.producer) ?? ""
        producerSignature = try container.decodeIfPresent(String.self, forKey: CodingKeys.producerSignature) ?? ""
    
        let transactions = try container.decodeIfPresent([EosTransaction].self, forKey: CodingKeys.transactions) ?? [EosTransaction]()
        transactionsCount = transactions.count
        
        previousBlockId = try container.decodeIfPresent(String.self, forKey: CodingKeys.previousBlockId) ?? ""
    }
}
