import ArgumentParser

@main struct AOC24: ParsableCommand {
    @Option(help: "Enter the day:")
    public var day: UInt8

    public func run() throws {
        print("Day: \(day)")
    }
}
