load("@bazel_skylib//rules:build_test.bzl", "build_test")
load(
    "//apple:macos.bzl",
    "macos_application",
    "macos_extension",
)
load(
    "//apple:versioning.bzl",
    "apple_bundle_version",
)

licenses(["notice"])

swift_library(
    name = "Sources",
    srcs = [
        "ContentView.swift",
        "HelloWorldApp.swift",
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
    version = ":HelloWorldVersion",
    deps = [":Sources"],
)

build_test(
    name = "HandTrackingBuoldTest",
    targets = [
        ":HandTracking",