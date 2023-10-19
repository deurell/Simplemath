import XCTest
@testable import equations

class EquationTests: XCTestCase {
    
    func testAddition() {
        let equation = Equation(operation: .addition, operand1: 5, operand2: 3, result: nil)
        XCTAssertEqual(equation.solve(), 8)
    }
    
    func testSubtraction() {
        let equation = Equation(operation: .subtraction, operand1: 10, operand2: 4, result: nil)
        XCTAssertEqual(equation.solve(), 6)
    }
    
    func testMultiplication() {
        let equation = Equation(operation: .multiplication, operand1: 6, operand2: 2, result: nil)
        XCTAssertEqual(equation.solve(), 12)
    }
    
    func testDivision() {
        let equation = Equation(operation: .division, operand1: 8, operand2: 2, result: nil)
        XCTAssertEqual(equation.solve(), 4)
    }
}
