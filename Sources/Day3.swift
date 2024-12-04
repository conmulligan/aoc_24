import Foundation
import RegexBuilder

struct Day3: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let part1Result = try part1()
        print("3a result: \(part1Result)")

        let part2Result = try part2()
        print("3b result: \(part2Result)")
    }
}

extension Day3 {
    private func sum(input: String, useConditionals: Bool = false) throws -> Int {
        let xRef = Reference(Int.self)
        let yRef = Reference(Int.self)

        let regex = Regex {
            ChoiceOf {
                Regex {
                    "mul("
                    Capture(as: xRef) { OneOrMore(.digit) } transform: { Int($0)! }
                    ","
                    Capture(as: yRef) { OneOrMore(.digit) } transform: { Int($0)! }
                    ")"
                }
                "do()"
                "don't()"
            }
        }

        var doIt = true
        return input.matches(of: regex)
            .compactMap { match -> (Int, Int)? in
                switch match.output.0 {
                case "do()":
                    doIt = true
                    return nil
                case "don't()":
                    doIt = false
                    return nil
                default:
                    return doIt || !useConditionals ? (match[xRef], match[yRef]) : nil
                }
            }
            .map { x, y in x * y }
            .reduce(0, +)
    }

    private func part1() throws -> Int {
        try sum(input: input, useConditionals: false)
    }

    private func part2() throws -> Int {
        try sum(input: input, useConditionals: true)
    }
}
