//
//  MessageCell.swift
//  Message Board
//
//  Created by Kerby Jean on 3/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

final class LabelCell: UITableViewCell {
        
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        //Draw main body
        bezierPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        //Draw the tail
        bezierPath.move(to: CGPoint(x: rect.maxX - 25.0, y: rect.maxY - 10.0))
        bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY))
        bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY - 10.0))
        UIColor.lightGray.setFill()
        bezierPath.fill()
        bezierPath.close()
    }
    
    fileprivate static let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    fileprivate static let font = UIFont.systemFont(ofSize: 17)
    
    static var singleLineHeight: CGFloat {
        return 100.0
    }
    
    var id: String {
        String(describing: self)
    }
    
    static func textHeight(_ text: String, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSAttributedString.Key.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom
    }
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = LabelCell.font
        return label
    }()
    
    var messageText: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView.addSubview(label)
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        label.frame = UIEdgeInsetsInsetRect(bounds, LabelCell.insets)
    }
    
    override var isHighlighted: Bool {
        didSet {
            //            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }
}
