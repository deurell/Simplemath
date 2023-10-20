enum Operation {
  case addition, subtraction, multiplication, division
}

enum Operand: Equatable {
  case doubleValue(Double)
  case rationalValue(Rational)
}

struct Rational: Equatable {
  var numerator: Int
  var denominator: Int

  init(_ numerator: Int, _ denominator: Int) {
    assert(denominator != 0, "Denominator cannot be zero.")
    self.numerator = numerator
    self.denominator = denominator
  }

  func simplified() -> Rational {
    let gcdValue = gcd(numerator, denominator)
    return Rational(numerator / gcdValue, denominator / gcdValue)
  }

  private func gcd(_ a: Int, _ b: Int) -> Int {
    return b == 0 ? a : gcd(b, a % b)
  }

  func add(_ other: Rational) -> Rational {
    let newNumerator = self.numerator * other.denominator + other.numerator * self.denominator
    let newDenominator = self.denominator * other.denominator
    return Rational(newNumerator, newDenominator).simplified()
  }

  func subtract(_ other: Rational) -> Rational {
    let newNumerator = self.numerator * other.denominator - other.numerator * self.denominator
    let newDenominator = self.denominator * other.denominator
    return Rational(newNumerator, newDenominator).simplified()
  }

  func multiply(_ other: Rational) -> Rational {
    let newNumerator = self.numerator * other.numerator
    let newDenominator = self.denominator * other.denominator
    return Rational(newNumerator, newDenominator).simplified()
  }

  func divide(_ other: Rational) -> Rational {
    assert(other.numerator != 0, "Cannot divide by zero.")
    return self.multiply(Rational(other.denominator, other.numerator)).simplified()
  }
}

struct Equation {
  var operation: Operation
  var operand1: Operand?
  var operand2: Operand?
  var result: Operand?

  func solve() -> Operand? {
    switch operation {
    case .addition:
      return performAddition()
    case .subtraction:
      return performSubtraction()
    case .multiplication:
      return performMultiplication()
    case .division:
      return performDivision()
    }
  }

  private func performAddition() -> Operand? {
    if let op1 = extractDouble(operand1), let op2 = extractDouble(operand2) {
      return .doubleValue(op1 + op2)
    } else if let op1 = extractRational(operand1), let op2 = extractRational(operand2) {
      return .rationalValue(op1.add(op2))
    } else if let op1 = extractDouble(operand1), let res = extractDouble(result) {
      return .doubleValue(res - op1)
    } else if let op2 = extractDouble(operand2), let res = extractDouble(result) {
      return .doubleValue(res - op2)
    } else if let op1 = extractRational(operand1), let res = extractRational(result) {
      return .rationalValue(res.subtract(op1))
    } else if let op2 = extractRational(operand2), let res = extractRational(result) {
      return .rationalValue(res.subtract(op2))
    }
    return nil
  }

  private func performSubtraction() -> Operand? {
    if let op1 = extractDouble(operand1), let op2 = extractDouble(operand2) {
      return .doubleValue(op1 - op2)
    } else if let op1 = extractRational(operand1), let op2 = extractRational(operand2) {
      return .rationalValue(op1.subtract(op2))
    } else if let op1 = extractDouble(operand1), let res = extractDouble(result) {
      return .doubleValue(op1 - res)
    } else if let op2 = extractDouble(operand2), let res = extractDouble(result) {
      return .doubleValue(res + op2)
    } else if let op1 = extractRational(operand1), let res = extractRational(result) {
      return .rationalValue(op1.subtract(res))
    } else if let op2 = extractRational(operand2), let res = extractRational(result) {
      return .rationalValue(res.add(op2))
    }
    return nil
  }

  private func performMultiplication() -> Operand? {
    if let op1 = extractDouble(operand1), let op2 = extractDouble(operand2) {
      return .doubleValue(op1 * op2)
    } else if let op1 = extractRational(operand1), let op2 = extractRational(operand2) {
      return .rationalValue(op1.multiply(op2))
    } else if let op1 = extractDouble(operand1), let res = extractDouble(result), op1 != 0 {
      return .doubleValue(res / op1)
    } else if let op2 = extractDouble(operand2), let res = extractDouble(result), op2 != 0 {
      return .doubleValue(res / op2)
    } else if let op1 = extractRational(operand1), let res = extractRational(result) {
      assert(res.numerator != 0, "Cannot divide by zero.")
      return .rationalValue(res.divide(op1))
    } else if let op2 = extractRational(operand2), let res = extractRational(result) {
      assert(op2.numerator != 0, "Cannot divide by zero.")
      return .rationalValue(res.divide(op2))
    }
    return nil
  }

  private func performDivision() -> Operand? {
    if let op1 = extractDouble(operand1), let op2 = extractDouble(operand2), op2 != 0 {
      return .doubleValue(op1 / op2)
    } else if let op1 = extractRational(operand1), let op2 = extractRational(operand2) {
      return .rationalValue(op1.divide(op2))
    } else if let op1 = extractDouble(operand1), let res = extractDouble(result), res != 0 {
      return .doubleValue(op1 / res)
    } else if let op2 = extractDouble(operand2), let res = extractDouble(result), op2 != 0 {
      return .doubleValue(res * op2)
    } else if let op1 = extractRational(operand1), let res = extractRational(result) {
      return .rationalValue(op1.divide(res))
    } else if let op2 = extractRational(operand2), let res = extractRational(result) {
      return .rationalValue(res.multiply(op2))
    }
    return nil
  }

  private func extractDouble(_ operand: Operand?) -> Double? {
    if case .doubleValue(let value)? = operand {
      return value
    }
    return nil
  }

  private func extractRational(_ operand: Operand?) -> Rational? {
    if case .rationalValue(let value)? = operand {
      return value
    }
    return nil
  }
}
