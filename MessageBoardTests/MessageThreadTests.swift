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
        var didFinish: XCTestExpectation? = expectation(description: "didFinish")
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
                didFinish?.fulfill()
                didFinish = nil
            } catch {
                self.messageThreadController.messageThreads = []
                XCTAssertThrowsError(error)
            }
        }.resume()
           wait(for: [didFinish!], timeout: 10) // blocking sync wait
    }
    

    func testFetchThreads() {

        var didFinish: XCTestExpectation? = expectation(description: "didFinish")

        let requestURL = MessageThreadController.baseURL.appendingPathExtension("json")

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                XCTAssertThrowsError(error, "Error fetching message threads:")
                return
            }
            guard let data = data else {  XCTAssertThrowsError(error, "No data returned from data task"); return }

            do {
                let jsonData = try JSONSerialization.jsonObject(with: data,  options: [])
                print(jsonData)
                let threads = try JSONDecoder().decode([String : MessageThread].self, from: data)
                for thread in threads {
                    print(thread.value.messages)
                    self.messageThreadController.messageThreads.append(thread.value)
                    didFinish?.fulfill()
                    didFinish = nil
                }
            } catch {
                self.messageThreadController.messageThreads = []
                XCTAssertThrowsError(error, "Error decoding message threads from JSON data")
            }
        }.resume()

        wait(for: [didFinish!], timeout: 10) // blocking sync wait
    }
    
    
    
    func testMessageCreation() {

        var didFinish: XCTestExpectation? = expectation(description: "didFinish")
        let message = MessageThread.Message(text: "text", sender: "sender")
        
        let requestURL = MessageThreadController.baseURL.appendingPathComponent("3A3BAE81-5E04-497A-8449-23BE906C4D7C").appendingPathComponent("messages").appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            XCTAssertThrowsError(error, "Error encoding message to JSON")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                XCTAssertThrowsError(error, "Error with message thread creation data task")
                return
            }
            didFinish?.fulfill()
            didFinish = nil

        }.resume()
        wait(for: [didFinish!], timeout: 10) // blocking sync wait
    }
    
    func testFetchMessages() {
        
    }
}
