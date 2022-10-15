//
//  Ext+String.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 27/09/22.
//

import Foundation

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
