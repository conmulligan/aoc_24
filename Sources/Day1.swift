
struct Day1: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let lines: [[UInt]] = input.split(separator: "\n").map {
            String($0).split(separator: " ").compactMap { UInt($0) }
        }
        let (left, right) = enumerateLists(lines: lines)

        let part1Result = try part1(left: left, right: right)
        print("1a result: \(part1Result)")

        let part2Result = try part2(left: left, right: right)
        print("1b result: \(part2Result)")
    }
}

extension Day1 {
    private func enumerateLists(lines: [[UInt]]) -> (left: [UInt], right: [UInt]) {
        var leftList = [UInt]()
        var rightList = [UInt]()

        for line in lines {
            leftList.append(line.first!)
            rightList.append(line.last!)
        }

        precondition(leftList.count == rightList.count, "Lists should be equal in length.")

        leftList.sort()
        rightList.sort()

        return (leftList, rightList)
    }
}

extension Day1 {
    private func part1(left: [UInt], right: [UInt]) throws -> Int {
        left.enumerated().map {
            abs($0.element.distance(to: right[$0.offset]))
        }.reduce(0, +)
    }

    private func part2(left: [UInt], right: [UInt]) throws -> Int {
        left.map { value in
            (Int(value) * right.count { $0 == value})
        }.reduce(0, +)
    }
}
