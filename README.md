# ZIPFoundationObjc

`ZIPFoundationObjc` is an Objective-C compatible wrapper for [ZIPFoundation](https://github.com/weichsel/ZIPFoundation), a Swift library for handling ZIP archives. This wrapper makes it easy for Objective-C projects to use ZIPFoundation by exposing its functionality directly, without requiring additional Swift code in the Objective-C codebase. `ZIPFoundationObjc` is compatible with Swift Package Manager, streamlining integration for Objective-C projects.

## Features

- **Easy ZIP Archive Handling**: Access ZIPFoundation's robust functionality in Objective-C, including reading, writing, and modifying ZIP files.
- **SPM-Compatible**: Integrate ZIPFoundation directly into Objective-C projects via Swift Package Manager, without needing extra wrapper classes or bridging code.
- **Lightweight**: This library is a minimal wrapper around ZIPFoundation, designed to expose Swift methods directly to Objective-C without unnecessary overhead.

## Requirements

- **iOS** 11.0+ / **macOS** 10.13+
- **Xcode** 11+
- **Swift Package Manager** support

## Installation

Add `ZIPFoundationObjc` to your project as a Swift Package:

1. In Xcode, go to **File > Add Packages...**.
2. Enter the URL for this repository: https://github.com/nostradani/ZIPFoundationObjC
3. Select the latest version and add it to your project.

## Documentation

For detailed documentation of ZIPFoundation’s functionality, refer to the [ZIPFoundation documentation](https://github.com/weichsel/ZIPFoundation). Since ZIPFoundationObjc exposes ZIPFoundation's APIs directly to Objective-C, all methods and usage are nearly identical.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you find bugs or have suggestions for improvements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.