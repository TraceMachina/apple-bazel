
# Check if nativelink cloud is configured in the bazelrc
if grep -Fxq "build --remote_timeout=600" .bazelrc
then
  # Build the visionOS example with NativeLink cloud
  bazel test //examples/visionos/HelloWorld:HelloWorldBuildTest

  # Build the iOS example with NativeLink cloud
  bazel test //examples/ios/HelloWorld:ExamplesBuildTest

  # Build the macOS example with NativeLink cloud
  bazel test //examples/macos/HelloWorld:ExamplesBuildTest
else
  # Clone nativelink
  git clone https://github.com/blakehatch/nativelink.git

  # Change directory to nativelink
  cd nativelink

  # Install rust
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  # Install nativelink
  cargo install --git https://github.com/TraceMachina/nativelink --tag v0.4.0

  # Install nativelink
  cargo install --git https://github.com/TraceMachina/nativelink --tag v0.4.0

  # Run nativelink
  # Run nativelink in the background
  bazel run -c opt nativelink -- $(pwd)/nativelink-config/examples/basic_cas.json &

  # Change directory back to the original directory
  cd ..

  # Build the visionOS example with NativeLink
  # Wait for nativelink to start before running the test
  while ! nc -z localhost 50051; do sleep 1; done
  bazel test //examples/visionos/HelloWorld:HelloWorldBuildTest \
    --remote_instance_name=main \
    --remote_cache=grpc://127.0.0.1:50051 \
    --remote_executor=grpc://127.0.0.1:50051 \
    --remote_default_exec_properties=cpu_count=1

  # Build the iOS example with NativeLink
  bazel test //examples/ios/HelloWorld:ExamplesBuildTest \
    --remote_instance_name=main \
    --remote_cache=grpc://127.0.0.1:50051 \
    --remote_executor=grpc://127.0.0.1:50051 \
    --remote_default_exec_properties=cpu_count=1

  # Build the macOS example with NativeLink
  bazel test //examples/macos/HelloWorld:ExamplesBuildTest \
    --remote_instance_name=main \
    --remote_cache=grpc://127.0.0.1:50051 \
    --remote_executor=grpc://127.0.0.1:50051 \
    --remote_default_exec_properties=cpu_count=1
fi
