//
//  Message_BoardUITests.swift
//  Message BoardUITests
//
//  Created by Spencer Curtis on 9/14/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Message_Board


class Message_BoardUITests: XCTestCase {
    
    var app: XCUIApplication {
        return XCUIApplication()
    }
    
    private var addButton: XCUIElement {
        return app.buttons["MessageThreadDetailTableViewController.addButton"]
    }
    
    private var sendButton: XCUIElement {
        return app.buttons["MessageThreadDetailTableViewController.sendButton"]
    }
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        // NOTE: Keep this setup as is for UI Testing
        app.launchArguments = ["UITesting"]
        app.launch()
     
    }
    
    
    func testAddMessageVC() {
        
        let threadsTable = app.tables.matching(identifier: "ThreadsTableView")
        let cell = threadsTable.cells.element(matching: .cell, identifier: "cell0")
                      
        XCTAssert(app.staticTexts["A New Thread"].exists)

        cell.tap()
        addButton.tap()
        
        let textField = app.textFields.firstMatch
        textField.tap()
        
        textField.typeText("New message title")
        
        let textView = app.textViews.firstMatch
        textView.tap()
        textView.typeText("New message description")
        
        sendButton.tap()
        
        XCTAssert(app.staticTexts["New message description"].exists)
            
        
    }
}
