//
//  MockDataProvider.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//
@testable import blockchain_eos
import Foundation

class MockDataProvider {
    
    private static var getInfoJSON = """
    {
      "server_version": "cc752d7c",
      "chain_id": "aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906",
      "head_block_num": 111378084,
      "last_irreversible_block_num": 111377753,
      "last_irreversible_block_id": "06a37d5945c6168a80eaa3b5f3c1f717546769df6ff9d10e9c083378ff601615",
      "head_block_id": "06a37ea495374f895bfeaf97763d19504365e28ad3ec1490a5795d11a958a0bf",
      "head_block_time": "2020-03-21T21:12:33.000",
      "head_block_producer": "zbeosbp11111",
      "virtual_block_cpu_limit": 200000,
      "virtual_block_net_limit": 1048576000,
      "block_cpu_limit": 200000,
      "block_net_limit": 1048576,
      "server_version_string": "v2.0.0-rc3",
      "fork_db_head_block_num": 111378084,
      "fork_db_head_block_id": "06a37ea495374f895bfeaf97763d19504365e28ad3ec1490a5795d11a958a0bf",
      "server_full_version_string": "v2.0.0-rc3-cc752d7c7996587247db7373b89f6a8c683aa9fc"
    }
    """
    
    private static var getEosBlockJSON  = """
        {
          "timestamp": "2020-03-20T03:54:30.500",
          "producer": "zbeosbp11111",
          "confirmed": 0,
          "previous": "069ef69c7d0ce2303dbbce59466ded0a49f12f02d993208690fca2124a2ba0a2",
          "transaction_mroot": "e992adad5aaf1373d4c3b91f45a3afa6d8f0e410026b925400671b4a160aebb8",
          "action_mroot": "2432c57719a36f841262f1b7e2d3b4e9432af4de8d45294b3975d07972b36cfa",
          "schedule_version": 1671,
          "new_producers": null,
          "producer_signature": "SIG_K1_KaPdVpzS6LaLbrQR3tA7ekVbXMKLQVQrDTxGN31i6gyK6CeeN85zqNUdt2xaMvgmb6JN8a86ypizALfhZ1JUE8sAdLJJtF",
          "transactions": [
            {
              "status": "executed",
              "cpu_usage_us": 17114,
              "net_usage_words": 12,
              "trx": {
                "id": "b8733acaad8c49ef7359e4f9dc43c8e0294d763780c7e44304be4690ee1ecca9",
                "signatures": [
                  "SIG_K1_KZGdA4wpJDbM1LWH8aDrGVdCqP76DWesCLDm7RESb5XcAiA18wxYhXLTjZV1S7Jsq7ekynKL1bYScV9nczoLNVgFFMk2Xz"
                ],
                "compression": "none",
                "packed_context_free_data": "",
                "context_free_data": [],
                "packed_trx": "aa4b745ee4f46aad70440000000001c0a88fca546773ad00000000000000a801c0a88fca546773ad00000000a8ed3232010000",
                "transaction": {
                  "expiration": "2020-03-20T04:50:50",
                  "ref_block_num": 62692,
                  "ref_block_prefix": 1148235114,
                  "max_net_usage_words": 0,
                  "max_cpu_usage_ms": 0,
                  "delay_sec": 0,
                  "context_free_actions": [],
                  "actions": [
                    {
                      "account": "pptqipaelyog",
                      "name": "p",
                      "authorization": [
                        {
                          "actor": "pptqipaelyog",
                          "permission": "active"
                        }
                      ],
                      "data": {
                        "actor": ""
                      },
                      "hex_data": "00"
                    }
                  ]
                }
              }
            }
          ],
          "id": "069ef69de9417e85802d2a045d6f6dda3226f526dba8924cec40bd7aaff18ae9",
          "block_num": 111081117,
          "ref_block_prefix": 69873024
        }
    """

    static func createEosInfo() -> EosInfo {
        let eosInfo = EosInfo(rawJsonResponse: nil, headBlockId: "06a37ea495374f895bfeaf97763d19504365e28ad3ec1490a5795d11a958a0bf")
        
        return eosInfo
    }
    
    static func createEosBlock() -> EosBlock {
        let jsonDecoder = JSONDecoder()
        let data = getEosBlockJSON.data(using: .utf8)
        let result = try! jsonDecoder.decode(EosBlock.self, from: data!)
        return result
    }
}
