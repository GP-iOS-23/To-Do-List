//
//  Exetnsion.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 18.11.2024.
//

import Foundation
import UIKit

extension UILabel {
    func strikeThrough(with text: String) {
        self.attributedText = NSAttributedString(string: text, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    }
    
    func removeStrikeThrough() {
        self.attributedText = NSAttributedString(string: self.text ?? "")
    }
}

extension Notification.Name {
    static let didAddTask = Notification.Name("didAddTask")
}
