//
//  ZFOArchive.swift
//  ZIPFoundationObjC
//
//  Created by Daniel Muhra on 28.10.24.
//  Copyright © 2024 Daniel Muhra. All rights reserved.
//

import Foundation
import ZIPFoundation

/// Wrapper class for a CRC32 Value
@objc(ZFOCRC32Value) public class CRC32Value : NSObject {
    @objc let value: UInt32
    
    internal init(value: UInt32) {
        self.value = value
    }
}


/// The access mode for an `ZFOArchive`.
@objc public enum ZFOAccessMode: UInt {
    /// Indicates that a newly instantiated `Archive` should create its backing file.
    case create
    /// Indicates that a newly instantiated `Archive` should read from an existing backing file.
    case read
    /// Indicates that a newly instantiated `Archive` should update an existing backing file.
    case update
    
    func toAccessMode() -> Archive.AccessMode {
        return switch (self) {
        case .create: .create
        case .read: .read
        case .update: .update
        }
    }
}

/// Represents a ZIP Archive
@objc(ZFOArchive) public class ZFOArchive: NSObject {
    
    @objc public static let defaultReadChunkSize = ZIPFoundation.defaultReadChunkSize

    /// The backing archive
    let archive: Archive
    
    /// Initializes a new ZIP `Archive`.
    ///
    /// You can use this initalizer to create new archive files or to read and update existing ones.
    /// The `mode` parameter indicates the intended usage of the archive: `.read`, `.create` or `.update`.
    /// - Parameters:
    ///   - url: File URL to the receivers backing file.
    ///   - mode: Access mode of the receiver.
    ///   - pathEncoding: Encoding for entry paths. Overrides the encoding specified in the archive.
    ///                   This encoding is only used when _decoding_ paths from the receiver.
    ///                   Paths of entries added with `addEntry` are always UTF-8 encoded.
    /// - Returns: An archive initialized with a backing file at the passed in file URL and the given access mode
    ///   or `nil` if the following criteria are not met:
    /// - Note:
    ///   - The file URL _must_ point to an existing file for `AccessMode.read`.
    ///   - The file URL _must_ point to a non-existing file for `AccessMode.create`.
    ///   - The file URL _must_ point to an existing file for `AccessMode.update`.
    @objc public init(url: URL, accessMode mode: ZFOAccessMode, pathEncoding: UInt) throws {
        self.archive = try Archive(url: url, accessMode: mode.toAccessMode(), pathEncoding: String.Encoding(rawValue: pathEncoding))
    }
    
    /// Initializes a new ZIP `Archive`.
    ///
    /// You can use this initalizer to create new archive files or to read and update existing ones.
    /// The `mode` parameter indicates the intended usage of the archive: `.read`, `.create` or `.update`.
    /// - Parameters:
    ///   - url: File URL to the receivers backing file.
    ///   - mode: Access mode of the receiver.
    /// - Returns: An archive initialized with a backing file at the passed in file URL and the given access mode
    ///   or `nil` if the following criteria are not met:
    /// - Note:
    ///   - The file URL _must_ point to an existing file for `AccessMode.read`.
    ///   - The file URL _must_ point to a non-existing file for `AccessMode.create`.
    ///   - The file URL _must_ point to an existing file for `AccessMode.update`.
    @objc public init(url: URL, accessMode mode: ZFOAccessMode) throws {
        self.archive = try Archive(url: url, accessMode: mode.toAccessMode())
    }
    
    /// Read a ZIP `Entry` from the receiver and write it to `url`.
    ///
    /// - Parameters:
    ///   - entry: The ZIP `Entry` to read.
    ///   - url: The destination file URL.
    ///   - bufferSize: The maximum size of the read buffer and the decompression buffer (if needed).
    ///   - skipCRC32: Optional flag to skip calculation of the CRC32 checksum to improve performance.
    ///   - allowUncontainedSymlinks: Optional flag to allow symlinks that point to paths outside the destination.
    ///   - progress: A progress object that can be used to track or cancel the extract operation.
    /// - Returns: The checksum of the processed content or 0 if the `skipCRC32` flag was set to `true`.
    /// - Throws: An error if the destination file cannot be written or the entry contains malformed content.
    @objc public func extract(_ entry: ZFOArchiveEntry, to url: URL, bufferSize: Int = defaultReadChunkSize,
                        skipCRC32: Bool = false, allowUncontainedSymlinks: Bool = false,
                        progress: Progress? = nil) throws -> CRC32Value {
        let result = try self.archive.extract(entry.entry, to: url, bufferSize: bufferSize, skipCRC32: skipCRC32, allowUncontainedSymlinks: allowUncontainedSymlinks, progress: progress)
        return CRC32Value(value: result)
    }
    
    /// Read a ZIP `Entry` from the receiver and forward its contents to a `Consumer` closure.
    ///
    /// - Parameters:
    ///   - entry: The ZIP `Entry` to read.
    ///   - bufferSize: The maximum size of the read buffer and the decompression buffer (if needed).
    ///   - skipCRC32: Optional flag to skip calculation of the CRC32 checksum to improve performance.
    ///   - progress: A progress object that can be used to track or cancel the extract operation.
    ///   - consumer: A closure that consumes contents of `Entry` as `Data` chunks.
    /// - Returns: The checksum of the processed content or 0 if the `skipCRC32` flag was set to `true`..
    /// - Throws: An error if the destination file cannot be written or the entry contains malformed content.
    @objc public func extract(_ entry: ZFOArchiveEntry, bufferSize: Int = defaultReadChunkSize, skipCRC32: Bool = false,
                              progress: Progress? = nil, consumer: (Data) -> Void) throws -> CRC32Value {
        let result = try self.archive.extract(entry.entry, bufferSize: bufferSize, skipCRC32: skipCRC32, progress: progress, consumer: consumer)
        return CRC32Value(value: result)
    }
    
    @objc(findFirst:) public func first(where predicate: (ZFOArchiveEntry) -> Bool) -> ZFOArchiveEntry? {
        let closure: (Entry) -> Bool = { predicate(ZFOArchiveEntry(entry: $0)) }
        guard let result = self.archive.first(where: closure) else {
            return nil
        }
        
        return ZFOArchiveEntry(entry: result)
    }

}
