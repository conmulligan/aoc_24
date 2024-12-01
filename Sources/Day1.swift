
struct Day1: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let (left, right) = enumerateLists(input: input)

        let part1Result = try part1(left: left, right: right)
        print("1a result: \(part1Result)")

        let part2Result = try part2(left: left, right: right)
        print("1b result: \(part2Result)")
    }
}

extension Day1 {
    private func enumerateLists(input: String) -> (left: [UInt], right: [UInt]) {
        var leftList = [UInt]()
        var rightList = [UInt]()

        for line in input.split(separator: "\n") {
            let columns = line.split(separator: " ")
            leftList.append(UInt(columns[0])!)
            rightList.append(UInt(columns[1])!)
        }

        precondition(leftList.count == rightList.count, "Lists should be equal in length.")

        leftList.sort()
        rightList.sort()

        return (leftList, rightList)
    }
}

extension Day1 {
    private func part1(left: [UInt], right: [UInt]) throws -> Int {
        var distances = [Int]()

        for (idx, value) in left.enumerated() {
            let distance = abs(value.distance(to: right[idx]))
            distances.append(distance)
        }

        return distances.reduce(0, +)
    }

    private func part2(left: [UInt], right: [UInt]) throws -> Int {
        var score = 0

        for value in left {
            let count = right.count { $0 == value}
            score += (Int(value) * count)
        }

        return score
    }
}
