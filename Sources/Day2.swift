
struct Day2: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let lines: [[Int]] = input.split(separator: "\n").map {
            String($0).split(separator: " ").compactMap { Int($0) }
        }

        let part1Result = try part1(lines: lines)
        print("2a result: \(part1Result)")

        let part2Result = try part2(lines: lines)
        print("2b result: \(part2Result)")
    }
}

extension Day2 {
    private func isSafe(report: [Int], excludingIndex: Int? = nil) -> Bool {
        let tolerance = 1...3
        var isIncremental: Bool?

        var report = report
        if let excludingIndex {
            report.remove(at: excludingIndex)
        }

        for (idx, value) in report.enumerated() {
            guard idx + 1 < report.count else { continue }
            let next = report[idx + 1]
            let delta = next - value
            let incremented = delta > 0
            if !tolerance.contains(abs(delta)) || (isIncremental != nil && incremented != isIncremental) {
                return false
            }
            isIncremental = incremented
        }

        return true
    }

    private func part1(lines: [[Int]]) throws -> Int {
        lines.map { isSafe(report: $0) }.count { $0 }
    }

    private func part2(lines: [[Int]]) throws -> Int {
        lines.map { line in
            line.enumerated()
                .map { isSafe(report: line, excludingIndex: $0.offset) }
                .filter { $0 }
                .count
        }.count { $0 > 0 }
    }
}
