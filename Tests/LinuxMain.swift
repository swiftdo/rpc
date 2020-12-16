import XCTest

import rpcTests

var tests = [XCTestCaseEntry]()
tests += rpcTests.allTests()
XCTMain(tests)
