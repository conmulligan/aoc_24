import Foundation
import ArgumentParser

func readStringFromFileURL(_ url: URL) throws -> String? {
    let fileHandle = try FileHandle(forReadingFrom: url)
    let data = fileHandle.readDataToEndOfFile()
    return String(data: data, encoding: .utf8)
}

protocol Day {
    var input: String { get }
    init(input: String)
    func run() throws
}

extension AOC24 {
    static let days: [UInt8: Day.Type] = [
        1: Day1.self,
        2: Day2.self,
        3: Day3.self
    ]
}

@main struct AOC24: ParsableCommand {
    @Option(help: "The day number of the puzzle to run.")
    public var day: UInt8

    @Option(transform: URL.init(fileURLWithPath:))
    var inputFile: URL

    public func run() throws {
        guard let dayType = AOC24.days[day] else {
            fatalError("Could not find `Day` for input: \(day)")
        }

        guard let string = try readStringFromFileURL(inputFile) else {
            fatalError("Could not read string for for file input: \(inputFile)")
        }

        let day = dayType.init(input: string)
        try day.run()
    }
}
