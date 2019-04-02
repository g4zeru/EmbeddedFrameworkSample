//
//  DomainTests.swift
//  DomainTests
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import XCTest
@testable import Domain

class DomainTests: XCTestCase {

    func testDecode() {
        let model: APIModel = APIModel(path: "https://qiita.com/api/v2/users/haruevorun", requestMethod: .get, header: ["Host":"qiita.com"])
        let networkExpectation: XCTestExpectation? =
            self.expectation(description: "connect API")
        let context = NetworkCreator.createContext()
        
        debugPrint("request...")
        context.request(model: model) { (response) in
            defer {
                networkExpectation?.fulfill()
            }
            debugPrint("connected...")
            switch response {
            case .failure(let error):
                debugPrint(error)
                XCTAssert(false)
            case .success(let json):
                do {
                    let models = try NetworkParser.decodeToBaseDataModels(json: json, type: User.self)
                    XCTAssertEqual(1, models.count)
                    XCTAssertEqual("こんにちは", models[0].description)
                } catch {
                    print(error)
                }
            }
        }
        
        self.waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testUsers() {
        let page = 1
        let per = 20
        let model: APIModel = APIModel(path: "https://qiita.com/api/v2/users?page=\(page)&per_page=\(per)", requestMethod: .get, header: ["Host":"qiita.com"])
        let networkExpectation: XCTestExpectation? =
            self.expectation(description: "connect API")
        let context = NetworkCreator.createContext()
        
        debugPrint("request...")
        context.request(model: model) { (response) in
            defer {
                networkExpectation?.fulfill()
            }
            debugPrint("connected...")
            switch response {
            case .failure(let error):
                debugPrint(error)
                XCTAssert(false)
            case .success(let json):
                guard let json = json else {
                    XCTAssert(true)
                    return
                }
                do {
                    let result = try NetworkParser.decodeToBaseDataModels(json: json, type: User.self)
                    XCTAssertEqual(result.count, per)
                } catch {
                    print(error)
                    XCTAssert(false)
                }
            }
        }
        
        self.waitForExpectations(timeout: 3, handler: nil)
    }

}
func debugPrint(_ item: Any?) {
    guard let item = item else {
        return
    }
    #if DEBUG
    print(item)
    #else
    print("this method is debug only")
    #endif
}
