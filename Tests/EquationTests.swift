import XCTest

@testable import equations

class EquationTests: XCTestCase {

  func testAddition1() {
    let equation = Equation(
      operation: .addition,
      operand1: .doubleValue(3.0),
      operand2: .doubleValue(2.0),
      result: nil)
    if case .doubleValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue, 5.0)
    } else {
      XCTFail("Expected double result")
    }
  }

  func testAddition2() {
    let equation = Equation(
      operation: .addition,
      operand1: .rationalValue(Rational(5, 1)),
      operand2: .rationalValue(Rational(3, 1)),
      result: nil)
    if case .rationalValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue.numerator, 8)
      XCTAssertEqual(resultValue.denominator, 1)
    } else {
      XCTFail("Expected rational result")
    }
  }

  func testAddition3() {
    let equation = Equation(
      operation: .addition,
      operand1: .doubleValue(3.0),
      operand2: nil,
      result: .doubleValue(5.0))
    if case .doubleValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue, 2.0)
    } else {
      XCTFail("Expected double result")
    }
  }

  func testSubtraction1() {
    let equation = Equation(
      operation: .subtraction,
      operand1: .rationalValue(Rational(10, 1)),
      operand2: .rationalValue(Rational(4, 1)),
      result: nil)
    if case .rationalValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue.numerator, 6)
      XCTAssertEqual(resultValue.denominator, 1)
    } else {
      XCTFail("Expected rational result")
    }
  }

  func testMultiplication1() {
    let equation = Equation(
      operation: .multiplication,
      operand1: .rationalValue(Rational(6, 2)),
      operand2: .rationalValue(Rational(4, 2)),
      result: nil)
    if case .rationalValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue.numerator, 6)
      XCTAssertEqual(resultValue.denominator, 1)
    } else {
      XCTFail("Expected rational result")
    }
  }

  func testMultiplication2() {
    let equation = Equation(
      operation: .multiplication,
      operand1: .rationalValue(Rational(2, 3)),
      operand2: .rationalValue(Rational(4, 6)),
      result: nil)
    if case .rationalValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue.numerator, 4)
      XCTAssertEqual(resultValue.denominator, 9)
    } else {
      XCTFail("Expected rational result")
    }
  }

    func testMultiplication3() {
    let equation = Equation(
      operation: .multiplication,
      operand1: .doubleValue(2.0),
      operand2: nil,
      result: .doubleValue(7.0))
    if case .doubleValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue, 3.5)
    } else {
      XCTFail("Expected double result")
    }
  }

  func testDivisionSimple() {
    let equation = Equation(
      operation: .division,
      operand1: .rationalValue(Rational(6, 1)),  // which is 6
      operand2: .rationalValue(Rational(2, 1)),  // which is 2
      result: nil)
    if case .rationalValue(let resultValue)? = equation.solve() {
      print(resultValue.numerator, resultValue.denominator)  // should print 3 1
      XCTAssertEqual(resultValue.numerator, 3)  // because 6 divided by 2 is 3
      XCTAssertEqual(resultValue.denominator, 1)  // simplified denominator
    } else {
      XCTFail("Expected rational result")
    }
  }

}
