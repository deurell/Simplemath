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

  init(
    _ text: String, image: String, equation: Equation? = nil, @ChoiceBuilder choices: () -> [Choice]
  ) {
    self.text = text
    self.image = image
    self.equation = equation
    self.choices = choices()
  }

  func withEquation(_ equation: Equation) -> Question {
    var updatedQuestion = self
    updatedQuestion.equation = equation
    return updatedQuestion
  }
}

@resultBuilder
struct ChoiceBuilder {
  static func buildBlock(_ components: Choice...) -> [Choice] {
    return components
  }
}

struct Level {
  let questions: [Question]

  init(@LevelBuilder builder: () -> [Question]) {
    self.questions = builder()
  }
}

@resultBuilder
struct LevelBuilder {
  static func buildBlock(_ components: Question...) -> [Question] {
    return components
  }
}
