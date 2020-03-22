//
//  blockchain_eosUITests.swift
//  blockchain-eosUITests
//
//  Created by Tai Huu Ho on 3/19/20.
//  Copyright © 2020 Tai Huu Ho. All rights reserved.
//

import Nimble
import Quick

class RecentBlocksViewControllerUITests: QuickSpec {
    
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
        
        describe("RecentBlocksViewControllerUITests") {
            context("when the view is loaded") {
                it("It should only have the View Recent Blocks button only") {
                    expect(app.buttons.count).to(equal(1))
                    let viewRecentBlocksButton = app.staticTexts[self.viewRecentBlocksButtonTitle]
                    expect(viewRecentBlocksButton.exists).to(equal(true))
                }
            }
            
            context("when the button is clicked") {
                var viewRecentBlocksButton: XCUIElement!
                
                beforeEach {
                    expect(app.buttons.count).to(equal(1))
                    viewRecentBlocksButton = app.staticTexts[self.viewRecentBlocksButtonTitle]
                    
                    viewRecentBlocksButton.tap()
                }
    
                context("Table View") {
                    it("is now visible") {
                        expect(app.tables.count).toEventually(equal(1))
                    }
                    
                    it("clicking on a cell will push to Block Details screen") {
                        expect(app.tables.count).toEventually(equal(1))
                        let tableView = app.tables.firstMatch
                        tableView.cells.firstMatch.tap()
                        expect(app.staticTexts["Block Details"].exists).toEventually(equal(true), timeout: 2)
                    }
                }
                
                it("The loading indicator should be hidden") {
                    let loadingIndicator = app.activityIndicators.firstMatch
                    expect(loadingIndicator.exists).toEventually(equal(false), timeout: 5)
                }
                
                it("The button should be hidden") {
                   
                    viewRecentBlocksButton = app.staticTexts[self.viewRecentBlocksButtonTitle]
                    expect(viewRecentBlocksButton.exists).toEventually(equal(false), timeout: 5)
                }
            }
        }
    }
}
