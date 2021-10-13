// swift-tools-version:5.1

import PackageDescription

let package = Package(name: "SwiftDay",
                  platforms: [.macOS(.v10_12),
                              .iOS(.v10),
                              .tvOS(.v10),
                              .watchOS(.v3)],
                  products: [.library(name: "SwiftDay",
                                      targets: ["SwiftDay"])],
                  targets: [.target(name: "SwiftDay",
                                    path: "Source"),
                            .testTarget(name: "SwiftDayTests",
                                        dependencies: ["SwiftDay"])],
                  swiftLanguageVersions: [.v5])
