//
//  TwoColumnCollectionView.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 03/10/2021.
//

import UIKit

protocol FSPresentDelegate: AnyObject {
    func presentDetailView()
}

class TwoColumnCollectionView: UIView {
    let nibName = "TwoColumnCollectionView"
    var photos = Photo.allPhotos()
    weak var delegate: FSPresentDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBInspectable public var scrollable: Bool {
        set (scrollable) {
            self.collectionView.isScrollEnabled = scrollable
        }
        
        get {
            return self.collectionView.isScrollEnabled
        }
    }
    
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
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        let nib = UINib(nibName: "FSCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FSCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? FSCollectionViewLayout {
            layout.delegate = self
        }
    }
}

extension TwoColumnCollectionView: FSCollectionLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return photos[indexPath.item].image.size.height
    }
}

extension TwoColumnCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FSCollectionViewCell", for: indexPath) as! FSCollectionViewCell
        cell.photo = photos[indexPath.item]
        return cell
    }
}

extension TwoColumnCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.presentDetailView()
    }
}
