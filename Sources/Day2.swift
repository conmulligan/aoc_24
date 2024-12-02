
struct Day2: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let part1Result = try part1(input: input)
        print("2a result: \(part1Result)")
    }
}

extension Day2 {
    private func isSafe(report: [Int]) -> Bool {
        let tolerance = 1...3
        var isIncremental: Bool?

        for (idx, value) in report.enumerated() {
            guard idx + 1 < report.count else { break }
            let next = report[idx + 1]
            let delta = next - value
            let incremental = delta > 0
            if !tolerance.contains(abs(delta)) {
                return false
            }
            if isIncremental != nil && incremental != isIncremental {
                return false
            }
            isIncremental = incremental
        }

        return true
    }

    private func part1(input: String) throws -> Int {
        var safeCount = 0

        for line in input.split(separator: "\n") {
            let report = line.split(separator: " ").compactMap { Int($0) }
            if isSafe(report: report) {
                safeCount += 1
            }
        }

        return safeCount
    }
}
