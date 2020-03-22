//
//  BlockDetailsViewControllerUITests.swift
//  blockchain-eosUITests
//
//  Created by Tai Huu Ho on 3/22/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import Nimble
import Quick

class BlockDetailsViewControllerUITests: QuickSpec {

    let viewRecentBlocksButtonTitle = "View Recent Blocks"
    
    override func spec() {
        var app: CustomXCUIApplication!
        
        beforeEach {
            app = CustomXCUIApplication()
            
            app.launch()
        }
        
        afterEach {
            app = nil
        }
        
        describe("BlockDetailsViewControllerUITests") {
            
            
            context("when the button is clicked") {
                var viewRecentBlocksButton: XCUIElement!
                
                beforeEach {
                    expect(app.buttons.count).to(equal(1))
                    viewRecentBlocksButton = app.buttons[self.viewRecentBlocksButtonTitle]
                    
                    viewRecentBlocksButton.tap()
                    
                    let tableView = app.tables.firstMatch
                    tableView.cells.firstMatch.tap()
                }
    
                context("Block Details screen") {
                    it("is now visible") {
                        expect(app.navigationBars["Block Details"].exists).toEventually(equal(true), timeout: 2)
                    }
                    
                    it("The Raw Json is displayed by default") {
                        expect(app.textViews.count).toEventually(equal(1))
                        let jsonRawTextView = app.textViews.firstMatch
                        expect(jsonRawTextView.exists).toEventually(equal(true))
                        expect(jsonRawTextView.isHittable).toEventually(equal(true))
                    }
                    
                    describe("Toggle JSON Viewer") {
                        it("The title of the toggle JSON button should be correct") {
                            var toggleJSONButton = app.buttons["Hide Raw JSON"]
                            expect(toggleJSONButton.exists).toEventually(equal(true))
                            toggleJSONButton.tap()
                            
                            toggleJSONButton = app.buttons["Show Raw JSON"]
                            expect(toggleJSONButton.exists).toEventually(equal(true))
                            
                        }
                    }
                }
            }
        }
    }

}
