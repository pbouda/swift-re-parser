func insertExplicitConcatOperator(exp: String) -> String {
    var output = ""
    for (index, token) in exp.enumerated() {
        output += String(token)
        if (token == "(" || token == "|") {
            continue 
        }
        if index < exp.count - 1 {
            let lookaheadIndex = exp.index(exp.startIndex, offsetBy: index + 1)
            let lookahead = exp[lookaheadIndex]
            if (lookahead == "*" || lookahead == "|" || lookahead == ")") {
                continue
            }
            output += "."
        }
    }
    return output
}

func peek<T>(stack: Array<T>) -> T? {
    if (!stack.isEmpty) {
        return stack[stack.count - 1]
    } 
    return nil
} 

func operatorPrecedence(op: Character) -> Int {
    let opPrecedence: [Character: Int] = [
        "|": 0,
        ".": 1,
        "*": 2
    ]
    let result = opPrecedence[op]
    if result != nil {
        return result!
    }
    return -1
}

func toPostfix(exp: String) -> String {
    var output = ""
    var operatorStack: [Character] = [];

    for token in exp {
        if token == "." || token == "|" || token == "*" {
            while let latestOp = peek(stack: operatorStack), latestOp != "(" &&
                    operatorPrecedence(op: latestOp) >= operatorPrecedence(op: token) {
                output += String(operatorStack.removeLast())
            }
            operatorStack.append(token)
        } else if token == "(" || token == ")" {
            if token == "(" {
                operatorStack.append(token)
            } else {
                while let latestOp = peek(stack: operatorStack), latestOp != "(" {
                    output += String(operatorStack.removeLast()) 
                }
                operatorStack.removeLast()
            }
        } else {
            output += String(token)
        }
    }
    while !operatorStack.isEmpty {
        output += String(operatorStack.removeLast())
    }
    return output
}

let regex = "a(b|c)*"
let result = insertExplicitConcatOperator(exp: regex)
print(result)
let result2 = toPostfix(exp: result)
print(result2)

