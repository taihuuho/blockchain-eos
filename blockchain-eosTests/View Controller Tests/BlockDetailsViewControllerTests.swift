//
//  BlockDetailsViewControllerTests.swift
//  blockchain-eosTests
//
//  Created by Tai Huu Ho on 3/21/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import Nimble
import Quick
@testable import blockchain_eos

class BlockDetailsViewControllerTests: QuickSpec {
    override func spec() {
        var subject: BlockDetailsViewController!
        var viewModel: BlockDetailsViewModel!
        var eosBlock: EosBlock!
        beforeEach {
            eosBlock = MockDataProvider.createEosBlock()
            viewModel = BlockDetailsViewModel(eosBlock: eosBlock)
            subject = BlockDetailsViewController.instantiate(from: UIStoryboard.main())
            subject.inject(viewModel: viewModel)
            
            // hell yeah, need to do this to trigger viewDidLoad
            _ = subject.view
        }
        
        describe("BlockDetailsViewControllerTests") {
            context("when view is load") {
                it("the producer name label is visible") {
                    expect(subject.producerNameLabel.isHidden).to(equal(false))
                }
                 
                it("the producer signature label is visible") {
                    expect(subject.producerSignatureLabel.isHidden).to(equal(false))
                }
                
                it("the transactions count label is visible") {
                    expect(subject.transactionsCountLabel.isHidden).to(equal(false))
                }
                
                it("the toggle Raw JSON button title should be correct") {
                    expect(subject.toggleRawJsonButton.titleLabel?.text).to(equal(viewModel.getToggleRawJsonTitle()))
                }
                
                it("the Raw JSON should be hidden") {
                    expect(subject.rawJsonTextView.isHidden).to(equal(true))
                }
                
                it("the labels should display the block details correctly") {
                    expect(subject.producerNameLabel.text).to(contain(eosBlock.producer))
                    expect(subject.producerSignatureLabel.text).toEventually(contain(eosBlock.producerSignature))
                    expect(subject.transactionsCountLabel.text).toEventually(contain("\(eosBlock.transactionsCount)"))
                }
            }
            
            context("When the Toggle Raw JSON button is click once") {
                it("the JSON text view should become visible") {
                   
                    subject.toggleRawJsonButton.sendActions(for: .touchUpInside)
                    expect(subject.rawJsonTextView.isHidden).to(equal(false))
                }
                it("the raw Json should match with the block details") {
                    expect(subject.rawJsonTextView.text).to(equal(eosBlock.rawJsonResponse?.description))
                }
            }
            
            context("When the Toggle Raw JSON button is click twice") {
                it("the JSON text view should be hidden again") {
                   
                    subject.toggleRawJsonButton.sendActions(for: .touchUpInside)
                    expect(subject.rawJsonTextView.isHidden).to(equal(false))
                    
                    subject.toggleRawJsonButton.sendActions(for: .touchUpInside)
                    expect(subject.rawJsonTextView.isHidden).to(equal(true))
                }
            }
        }
    }
}
