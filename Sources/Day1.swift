
struct Day1: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let result = try part1()
        print("1a result: \(result)")
    }
}

extension Day1 {
    private func part1() throws -> Int {
        let lines = input.split(separator: "\n")

        var leftList = [UInt]()
        var rightList = [UInt]()
        var distances = [Int]()

        for line in lines {
            let columns = line.split(separator: " ")
            leftList.append(UInt(columns[0])!)
            rightList.append(UInt(columns[1])!)
        }

        precondition(leftList.count == rightList.count, "Lists should be equal in length.")
        
        leftList.sort()
        rightList.sort()

        for (idx, value) in leftList.enumerated() {
            let distance = abs(value.distance(to: rightList[idx]))
            distances.append(distance)
        }

        return distances.reduce(0, +)
    }
}