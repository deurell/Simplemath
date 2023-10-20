import Foundation

struct Choice {
  let text: String
  let image: String
}

struct Question {
  let text: String
  let image: String
  var equation: Equation?
  let choices: [Choice]
  
  init(text: String, image: String, equation: Equation? = nil, choices: [Choice]) {
    self.text = text
    self.image = image
    self.equation = equation
    self.choices = choices
  }
  
  func withEquation(_ equation: Equation) -> Question {
    var updatedQuestion = self
    updatedQuestion.equation = equation
    return updatedQuestion
  }
}

@resultBuilder
struct QuestionBuilder {
  static func buildBlock(_ components: Question...) -> [Question] {
    return components
  }
}

func MathQuestion(
  _ text: String, image: String,
  @ChoiceBuilder choices: () -> [Choice]
) -> Question {
  return Question(text: text, image: image, choices: choices())
}

@resultBuilder
struct ChoiceBuilder {
  static func buildBlock(_ components: Choice...) -> [Choice] {
    return components
  }
}

func MathChoice(_ text: String, image: String) -> Choice {
  return Choice(text: text, image: image)
}

@resultBuilder
struct LevelBuilder {
  static func buildBlock(_ components: Question...) -> [Question] {
    return components
  }
}

func Level(@LevelBuilder builder: () -> [Question]) -> [Question] {
  return builder()
}

func MathEquation(
  _ operation: Operation, operand1: Operand?, operand2: Operand?, result: Operand?
) -> Equation {
  return Equation(operation: operation, operand1: operand1, operand2: operand2, result: result)
}
