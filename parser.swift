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

let regex = "a(b|c)*"
let result = insertExplicitConcatOperator(exp: regex)
print(result)

