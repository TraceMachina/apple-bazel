load("@bazel_skylib//rules:build_test.bzl", "build_test")
load(
    "@build_bazel_rules_swift//swift:swift.bzl",
    "swift_library",
)
load("//apple:visionos.bzl", "visionos_application")
load("//apple:versioning.bzl", "apple_bundle_version")

licenses(["notice"])

swift_library(
    name = "Packages",
    srcs = glob(["Packages/RealityKitContent/Package.swift",
    "Packages/RealityKitContent/Sources/RealityKitContent/RealityKitContent.swift",]),
    visibility = ["//visibility:public"],
)

swift_library(
    name = "Sources",
    srcs = [
        "ContentView.swift",
        "Extensions.swift",
        "HandTrackingApp.swift",
        "HandTrackingModel.swift",
        "ImmersiveView.swift",
    ],
    deps = [
        ":Packages",
        # ":ARKit",  # Uncomment this if ARKit is defined somewhere in your Bazel build files
    ],
)

apple_bundle_version(
    name = "HandTrackingVersion",
    build_version = "1.0",
    short_version_string = "1.0",
)

visionos_application(
    name = "HandTracking",
    app_icons = ["//examples/resources:VisionAppIcon.xcassets"],
    bundle_id = "com.example.hello-world",
    infoplists = [":Info.plist"],
    minimum_os_version = "1.0",
    version = ":HandTrackingVersion",
    deps = [":Sources"],
)

build_test(
    name = "HandTrackingBuildTest",
    targets = [
        ":HandTracking",
    ]
)