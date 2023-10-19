enum Operation {
    case addition, subtraction, multiplication, division
}

struct Equation {
    var operation: Operation
    var operand1: Double?
    var operand2: Double?
    var result: Double?
    
    func solve() -> Double? {
        switch operation {
        case .addition:
            if let op1 = operand1, let op2 = operand2 {
                return op1 + op2
            } else if let op1 = operand1, let res = result {
                return res - op1
            } else if let op2 = operand2, let res = result {
                return res - op2
            }
            
        case .subtraction:
            if let op1 = operand1, let op2 = operand2 {
                return op1 - op2
            } else if let op1 = operand1, let res = result {
                return op1 - res
            } else if let op2 = operand2, let res = result {
                return res + op2
            }
            
        case .multiplication:
            if let op1 = operand1, let op2 = operand2 {
                return op1 * op2
            } else if let op1 = operand1, let res = result, op1 != 0 {
                return res / op1
            } else if let op2 = operand2, let res = result, op2 != 0 {
                return res / op2
            }
            
        case .division:
            if let op1 = operand1, let op2 = operand2, op2 != 0 {
                return op1 / op2
            } else if let op1 = operand1, let res = result, res != 0 {
                return op1 / res
            } else if let op2 = operand2, let res = result, op2 != 0 {
                return res * op2
            }
        }
        return nil
    }
}
