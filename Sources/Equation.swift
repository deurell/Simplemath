enum Operation {
  case addition, subtraction, multiplication, division
}

enum Operand {
  case doubleValue(Double)
  case rationalValue(Rational)
}

struct Rational {
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
      // Double Addition
      if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let op2)? = operand2
      {
        return .doubleValue(op1 + op2)
      }
      // Rational Addition
      else if case .rationalValue(let op1)? = operand1,
        case .rationalValue(let op2)? = operand2
      {
        return .rationalValue(op1.add(op2))
      }
      // Addition with one operand missing (Double)
      else if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let res)? = result
      {
        return .doubleValue(res - op1)
      } else if case .doubleValue(let op2)? = operand2,
        case .doubleValue(let res)? = result
      {
        return .doubleValue(res - op2)
      }

    case .subtraction:
      // Double Subtraction
      if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let op2)? = operand2
      {
        return .doubleValue(op1 - op2)
      }
      // Rational Subtraction
      else if case .rationalValue(let op1)? = operand1,
        case .rationalValue(let op2)? = operand2
      {
        return .rationalValue(op1.subtract(op2))
      }
      // Subtraction with one operand missing (Double)
      else if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let res)? = result
      {
        return .doubleValue(op1 - res)
      } else if case .doubleValue(let op2)? = operand2,
        case .doubleValue(let res)? = result
      {
        return .doubleValue(res + op2)
      }

    case .multiplication:
      // Double Multiplication
      if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let op2)? = operand2
      {
        return .doubleValue(op1 * op2)
      }
      // Rational Multiplication
      else if case .rationalValue(let op1)? = operand1,
        case .rationalValue(let op2)? = operand2
      {
        return .rationalValue(op1.multiply(op2))
      }
      // Multiplication with one operand missing (Double)
      else if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let res)? = result, op1 != 0
      {
        return .doubleValue(res / op1)
      } else if case .doubleValue(let op2)? = operand2,
        case .doubleValue(let res)? = result, op2 != 0
      {
        return .doubleValue(res / op2)
      }

    case .division:
      // Double Division
      if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let op2)? = operand2, op2 != 0
      {
        return .doubleValue(op1 / op2)
      }
      // Rational Division
      else if case .rationalValue(let op1)? = operand1,
        case .rationalValue(let op2)? = operand2
      {
        return .rationalValue(op1.divide(op2))
      }
      // Division with one operand missing (Double)
      else if case .doubleValue(let op1)? = operand1,
        case .doubleValue(let res)? = result, res != 0
      {
        return .doubleValue(op1 / res)
      } else if case .doubleValue(let op2)? = operand2,
        case .doubleValue(let res)? = result, op2 != 0
      {
        return .doubleValue(res * op2)
      }
    }
    return nil
  }

}
