//
//  MAHeaderView.swift
//  TableHeaderViewDemo
//
//  Created by admin on 4/27/21.
//

import UIKit
import MAAutoLayout

class MAHeaderView: UIView {

    public var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.red
        headerView.layer.cornerRadius = 45
        return headerView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.headerView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.lineView)
        
        self.headerView.ma_makeConstraints { (make) in
            make.topLeft.equalTo(self).offsets(15)
            make.size.ma_equal(90)
            make.bottom.lessThanOrEqualTo(self).offset(-15)
        }
        self.titleLabel.ma_makeConstraints { (make) in
            make.top.equalTo(self.headerView)
            make.left.equalTo(self.headerView.ma_right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-15).priority(.defaultHigh)
        }
        self.titleLabel.setContentHuggingPriority(UILayoutPriority.init(1000), for: .vertical)
        self.lineView.ma_makeConstraints { (make) in
            make.bottomLeftRight.equalTo(self)
            make.height.ma_equal(0.5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 这句话比较关键，如果界面上有UILabel，需要设置UILabel的preferredMaxLayoutWidth，（如果不设置MAHeaderView就不能自适应高度），如果最大宽度固定，可以在处理约束的位置设置；如果受其他view影响，可以在layoutSubviews中设置。

        self.titleLabel.preferredMaxLayoutWidth = self.frame.size.width - 15 - 90 - 15 - 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
