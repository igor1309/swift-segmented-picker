// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CustomSegmentedPicker",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .segmentedPicker,
    ],
    dependencies: [
    ],
    targets: [
        .customSegmentedPicker,
        .example1,
    ]
)

private extension Product {
    
    static let segmentedPicker = library(
        name: .segmentedPicker,
        targets: [.customSegmentedPicker]
    )
}

private extension Target {
    
    static let customSegmentedPicker = target(name: .customSegmentedPicker)
    static let example1 = target(name: .example1)
}

private extension String {
    
    static let customSegmentedPicker = "CustomSegmentedPicker"
    static let segmentedPicker = "SegmentedPicker"
    
    static let example1 = "Example1"
}
