//
//  BannerLabelView.swift
//  SkeletonViewTest
//
//  Created by 김정민 on 2022/05/19.
//

import UIKit


final class BannerLabelView: UIView {
    private let titleLabel = UILabel()
    private let mainContentLabel = UILabel()
    private let subContentLabel = UILabel()
    
    var isLaidOut: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isLaidOut = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        titleLabel.text = "Title"
        mainContentLabel.text = "Main Content"
        subContentLabel.text = "Sub Content"
        
        commonAttribute(at: self)
        commonAttribute(at: titleLabel)
        commonAttribute(at: mainContentLabel)
        commonAttribute(at: subContentLabel)
    }
    
    private func commonAttribute(at targetView: UIView) {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.isSkeletonable = true
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(mainContentLabel)
        addSubview(subContentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            makeLowPrioirtyTralingConstranit(targetView: titleLabel),
            
            mainContentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mainContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            makeLowPrioirtyTralingConstranit(targetView: mainContentLabel),
            
            subContentLabel.topAnchor.constraint(equalTo: mainContentLabel.bottomAnchor, constant: 8),
            subContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            makeLowPrioirtyTralingConstranit(targetView: subContentLabel),
            subContentLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func makeLowPrioirtyTralingConstranit(targetView: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: targetView,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .trailing,
                                            multiplier: 1.0,
                                            constant: -16)
        constraint.priority = .defaultLow
        return constraint
    }
}
