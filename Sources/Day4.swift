import Foundation

struct Day4: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let grid: Grid = input.split(separator: "\n").map { Array(String($0)) }
        
        let part1Result = try part1(grid: grid)
        print("4a result: \(part1Result)")

        let part2Result = try part2(grid: grid)
        print("4b result: \(part2Result)")
    }
}

extension Day4 {
    typealias Position = (x: Int, y: Int)
    typealias Grid = [[Character]]

    enum Direction: CaseIterable {
        case n, s, w, e, nw, ne, sw, se
        static var diagonals: [Direction] { [.ne, .nw, .se, .sw] }
    }

    private func isValid(position: Position, in grid: Grid) -> Bool {
        (0..<grid.count).contains(position.y) && (0..<grid[position.y].count).contains(position.x)
    }

    private func shift(_ position: Position, in direction: Direction, amount: Int = 1) -> Position {
        switch direction {
            case .n: (x: position.x, y: position.y - amount)
            case .s: (x: position.x, y: position.y + amount)
            case .w: (x: position.x - amount, y: position.y)
            case .e: (x: position.x + amount, y: position.y)
            case .nw: (x: position.x - amount, y: position.y - amount)
            case .ne: (x: position.x + amount, y: position.y - amount)
            case .sw: (x: position.x - amount, y: position.y + amount)
            case .se: (x: position.x + amount, y: position.y + amount)
        }
    }
}

extension Day4 {
    static let phrase = Array("XMAS")

    private func findPhrase(position: Position, grid: Grid) throws -> Int {
        guard isValid(position: position, in: grid) else { return 0 }
        return Direction.allCases.map { direction in
            let characters: [Character] = (0..<Self.phrase.count).compactMap { offset in
                let position = shift(position, in: direction, amount: offset)
                guard isValid(position: position, in: grid) else { return nil }
                return grid[position.y][position.x]
            }
            return characters == Self.phrase
        }
        .filter { $0 }
        .count
    }

    private func part1(grid: Grid) throws -> Int {
        var count = 0
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                count += try findPhrase(position: Position(x: x, y: y), grid: grid)
            }
        }
        return count
    }
}

extension Day4 {
    static let values = Set("MS")

    private func findX(position: Position, grid: Grid) throws -> Bool {
        guard isValid(position: position, in: grid), grid[position.y][position.x] == "A" else { return false }

        let left: [Character] = [Direction.nw, Direction.se].compactMap { direction in
                let position = shift(position, in: direction, amount: 1)
                guard isValid(position: position, in: grid) else { return nil }
                return grid[position.y][position.x]
        }
        let right: [Character] = [Direction.ne, Direction.sw].compactMap { direction in
                let position = shift(position, in: direction, amount: 1)
                guard isValid(position: position, in: grid) else { return nil }
                return grid[position.y][position.x]
        }

        func validPair(_ axis: [Character]) -> Bool {
            Self.values.intersection(axis).count == Self.values.count
        }

        return validPair(left) && validPair(right)
    }

    private func part2(grid: Grid) throws -> Int {
        var count = 0
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                let position = Position(x: x, y: y)
                if isValid(position: position, in: grid), try findX(position: position, grid: grid) {
                    count += 1
                }
            }
        }
        return count
    }
}
