//
//  ZFOArchiveEntry.swift
//  ZIPFoundationObjC
//
//  Created by Daniel Muhra on 28.10.24.
//  Copyright © 2024 Daniel Muhra. All rights reserved.
//

import Foundation
import ZIPFoundation

/// A value that represents a file, a directory or a symbolic link within a ZIP `ZFOArchive`.
///
/// You can retrieve instances of `ZFOArchiveEntry` from an `ZFOArchive` via subscripting or iteration.
/// Entries are identified by their `path`.
@objc(ZFOArchiveEntry) public class ZFOArchiveEntry: NSObject {
    let entry: Entry

    internal init(entry: Entry) {
        self.entry = entry
    }
    
    @objc public var path: String {
        return self.entry.path
    }
}
