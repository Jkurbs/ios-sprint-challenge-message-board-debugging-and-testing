//
//  MessageThreadTests.swift
//  MessageBoardTests
//
//  Created by Andrew R Madsen on 9/13/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Message_Board

class MessageThreadTests: XCTestCase {
    
    var messageThreadController: MessageThreadController {
        return MessageThreadController()
    }
    override func setUp() {
        super.setUp()
    }

    // Creation of a thread
    func testThreadsCreation() {
        let didFinish = expectation(description: "didFinish")
        let testThread = MessageThread(title: "test title")
        let requestURL = MessageThreadController.baseURL.appendingPathComponent(testThread.identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(testThread)
        } catch {
            XCTAssertThrowsError(error, "Error encode thread")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data else { return }
            do {
                let thread = try JSONDecoder().decode(MessageThread.self, from: data)
                self.messageThreadController.messageThreads.append(thread)
                XCTAssertEqual(thread.title, testThread.title)
                didFinish.fulfill()
            } catch {
                self.messageThreadController.messageThreads = []
                XCTAssertThrowsError(error)
            }
        }.resume()
           wait(for: [didFinish], timeout: 10) // blocking sync wait
    }
    

    func testFetchThreads() {
//        
//        let didFinish = expectation(description: "didFinish")
//        
//        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")
//
//        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
//            if let error = error {
//                XCTAssertThrowsError(error, "Error fetching message threads:")
//                return
//            }
//
//            guard let data = data else {  XCTAssertThrowsError(error, "No data returned from data task"); return }
//
//            do {
//
//                let thread =  try JSONDecoder().decode(MessageThread.self, from: data)
////                self.messageThreadController.messageThreads =
//                didFinish.fulfill()
//            } catch {
//                self.messageThreadController.messageThreads = []
//                print("ERROR: \(error)")
//                XCTAssertThrowsError(error, "Error decoding message threads from JSON data")
//            }
//        }.resume()
//        
//        wait(for: [didFinish], timeout: 10) // blocking sync wait
    }
    
    func testMessageCreation() {
        
    }
    
    func testFetchMessages() {
        
    }
}
