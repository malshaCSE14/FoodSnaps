//
//  TwoColumnCollectionView.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 03/10/2021.
//

import UIKit

class TwoColumnCollectionView: UIView {
    let nibName = "TwoColumnCollectionView"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func nibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}
