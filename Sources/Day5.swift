import Foundation

struct Day5: Day {
    var input: String

    init(input: String) {
        self.input = input
    }

    func run() throws {
        let (orderings, updates) = parse(input: input)

        let part1Result = part1(orderings: orderings, updates: updates)
        print("5a result: \(part1Result)")

        let part2Result = part2(orderings: orderings, updates: updates)
        print("5b result: \(part2Result)")
    }
}

extension Day5 {
    typealias PagePair = (Int, Int)
    typealias Update = [Int]

    private func parse(input: String) -> ([PagePair], [Update]) {
        var orderings = [PagePair]()
        var updates = [Update]()

        for line in input.split(separator: "\n") {
            if line.contains("|") {
                let components = line.split(separator: "|").map { Int($0)! }
                orderings.append(PagePair(components.first!, components.last!))
            } else if line.contains(",") {
                let components = line.split(separator: ",").map { Int($0)! }
                updates.append(components)
            }
         }

         return (orderings, updates)
    }
}

extension Day5 {
    private func isOrdered(update: Update, orderings: [PagePair]) -> Bool {
        update.enumerated().map { index, page in 
            orderings.filter { $0.0 == page }.map { ordering in
                if let nextIndex = update.firstIndex(of: ordering.1) {
                    index < nextIndex
                } else {
                    true
                }
            }.allSatisfy { $0 }
        }.allSatisfy { $0 }
    }

    private func part1(orderings: [PagePair], updates: [Update]) -> Int {
        var correctlyOrdered = [Update]()

        for update in updates {
            if isOrdered(update: update, orderings: orderings) {
                correctlyOrdered.append(update)
            }
        }

        return correctlyOrdered.map { update in
            let index = Int((Double(update.count) / 2).rounded(.down))
            return update[index]
        }.reduce(0, +)
    }

    private func part2(orderings: [PagePair], updates: [Update]) -> Int {
        let (orderings, updates) = parse(input: input)
        let filteredUpdates = updates.filter {
            !isOrdered(update: $0, orderings: orderings)
        }

        var correctlyOrdered = [Update]()

        for var update in filteredUpdates {
            while !isOrdered(update: update, orderings: orderings) {
                update.enumerated().forEach { index, page in
                    let orderings = orderings.filter { $0.0 == page }
                    for ordering in orderings {
                        if let nextIndex = update.firstIndex(of: ordering.1) {
                            if index > nextIndex {
                                update.append(update.remove(at: nextIndex))
                            }
                        }
                    }
                }
            }
            correctlyOrdered.append(update)
        }

        return correctlyOrdered.map { update in
            let index = Int((Double(update.count) / 2).rounded(.down))
            return update[index]
        }.reduce(0, +)
    }
}