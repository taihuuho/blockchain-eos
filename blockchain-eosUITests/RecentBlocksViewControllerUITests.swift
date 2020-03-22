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
                    let viewRecentBlocksButton = app.buttons[self.viewRecentBlocksButtonTitle]
                    expect(viewRecentBlocksButton.exists).toEventually(equal(true))
                }
            }
            
            context("when the button is clicked") {
                var viewRecentBlocksButton: XCUIElement!
                
                beforeEach {
                    expect(app.buttons.count).to(equal(1))
                    viewRecentBlocksButton = app.buttons[self.viewRecentBlocksButtonTitle]
                    
                    viewRecentBlocksButton.tap()
                }
    
                describe("Table View") {
                    var tableView: XCUIElement!
                    
                    beforeEach {
                        tableView = app.tables.firstMatch
                    }
                    it("is now visible") {
                        expect(app.tables.count).toEventually(equal(1))
                    }
                    
                    it("clicking on a cell will push to Block Details screen") {
                        expect(app.tables.count).toEventually(equal(1))
                        tableView.cells.firstMatch.tap()
                        expect(app.navigationBars["Block Details"].exists).toEventually(equal(true), timeout: 2)
                    }
                    
                    context("The View More button") {
                        var viewMoreButton: XCUIElement!
                        beforeEach {
                            viewMoreButton = tableView.buttons["View More"]

                            // Swipe down until the button is visible
                            while !viewMoreButton.isHittable {
                                tableView.swipeUp()
                            }
                        }
                        
                        it("should be visible") {
                            expect(viewMoreButton.isHittable).toEventually(equal(true))
                        }
                        
                        it("when clicked, it should load more") {
                            let currentRowCount = tableView.children(matching: .cell).count
                            viewMoreButton.tap()
                            
                            expect(tableView.children(matching: .cell).count).toEventually(beGreaterThan(currentRowCount))
                        }
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
