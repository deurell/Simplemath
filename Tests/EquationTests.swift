import XCTest

@testable import Simplemath

class EquationTests: XCTestCase {

  func testAdditionTwoDoubles() {
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

  func testAdditionTwoRationals() {
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

  func testAdditionDoublesOneOperand() {
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

  func testSubtractionRationalOneOperand() {
    let equation = Equation(
      operation: .subtraction,
      operand1: nil,
      operand2: .rationalValue(Rational(2, 5)),
      result: .rationalValue(Rational(2, 5)))
    if case .rationalValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue.numerator, 4)
      XCTAssertEqual(resultValue.denominator, 5)
    } else {
      XCTFail("Expected rational result")
    }
  }

  func testSubtractionRationalsNoResult() {
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

  func testMultiplicationTwoRationals() {
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

  func testMultiplicationTwoRationals2() {
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

  func testMultiplicationDoublesOneOperand() {
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

  func testDivisionTwoDoubles() {
    let equation = Equation(
      operation: .division,
      operand1: .doubleValue(6.0),
      operand2: .doubleValue(2.0),
      result: nil)
    if case .doubleValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue, 3.0)
    } else {
      XCTFail("Expected double result")
    }
  }

  func testDivisionTwoRationals() {
    let equation = Equation(
      operation: .division,
      operand1: .rationalValue(Rational(6, 1)),
      operand2: .rationalValue(Rational(2, 1)),
      result: nil)
    if case .rationalValue(let resultValue)? = equation.solve() {
      XCTAssertEqual(resultValue.numerator, 3)
      XCTAssertEqual(resultValue.denominator, 1)
    } else {
      XCTFail("Expected rational result")
    }
  }

  func testBuildingQuestionsWithDSL() {
    let level = Level {
      Question("x * 5 = 25", image: "image1.jpg") {
        Choice(text: "4", image: "choice1.jpg")
        Choice(text: "5", image: "choice2.jpg")
        Choice(text: "8", image: "choice3.jpg")
      }
      .withEquation(
        Equation(
          operation: .multiplication,
          operand1: nil,
          operand2: .doubleValue(5),
          result: .doubleValue(25)
        )
      )

      Question("1/2 + x = 3/4", image: "image2.jpg") {
        Choice(text: "1/2", image: "choice4.jpg")
        Choice(text: "3/4", image: "choice5.jpg")
      }
      .withEquation(
        Equation(
          operation: .addition,
          operand1: .rationalValue(Rational(1, 2)),
          operand2: nil,
          result: .rationalValue(Rational(3, 4))
        )
      )
    }

    XCTAssertEqual(level.questions.count, 2)
    XCTAssertEqual(level.questions[0].choices.count, 3)
    if let equation = level.questions[0].equation {
      XCTAssertEqual(equation.solve(), .doubleValue(5))
    }
    XCTAssertEqual(level.questions[1].text, "1/2 + x = 3/4")
    XCTAssertEqual(level.questions[1].choices.count, 2)
    if let equation = level.questions[1].equation {
      XCTAssertEqual(equation.operation, .addition)
      XCTAssertEqual(equation.solve(), .rationalValue(Rational(1, 4)))
    }
  }

  func testDividingRationalsWithDSL() {
    let level = Level {
      Question("1/2 ÷ x = 1/3", image: "imageDivide.jpg") {
        Choice(text: "3/2", image: "choiceDivide1.jpg")
        Choice(text: "2/3", image: "choiceDivide2.jpg")
      }
      .withEquation(
        Equation(
          operation: .division,
          operand1: .rationalValue(Rational(1, 2)),
          operand2: nil,
          result: .rationalValue(Rational(1, 3))
        )
      )
    }
    if let equation = level.questions.first?.equation {
      XCTAssertEqual(equation.operation, .division)
      XCTAssertEqual(equation.solve(), .rationalValue(Rational(3, 2)))
    } else {
      XCTFail("Equation is missing")
    }
  }
}
