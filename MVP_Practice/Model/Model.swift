import Foundation

protocol ModelInput {
    func multiply(_ leftNumber: Float, _ rightNumber: Float) -> Float
}

class Model: ModelInput {
    func multiply(_ leftNumber: Float, _ rightNumber: Float) -> Float {
        return leftNumber * rightNumber
    }
}

