//
//  UIScrollView+Utils.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 12/10/2021.
//

import UIKit
import RxSwift

extension UIScrollView {
    func scrollToTop(_ value: CGFloat? = nil) {
        let desiredOffset = CGPoint(x: 0, y: value ?? contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    
    var reachedBottom: Observable<Void> {
        // variable to save the last position visited, default to zero
        var lastContentOffset: CGFloat = 0
        
        return rx.didEndDragging.flatMap { [weak self] _ -> Observable<Void> in
            var res: Observable<Void>
            guard let scrollView = self else {
                return Observable.empty()
            }
            
            if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
                // move up
                res = Observable.empty()
            } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
                // move down
                let threshold = 150.0
                let contentOffset = scrollView.contentOffset.y
                let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
                let needRefresh = maximumOffset - contentOffset <= CGFloat(threshold) && (maximumOffset - contentOffset != -5.0) //Add more content.
                
                res = needRefresh ? Observable.just(Void()) : Observable.empty()
            } else {
                res = Observable.empty()
            }
            
            // update the new position acquired
            lastContentOffset = scrollView.contentOffset.y
            
            return res
        }
    }
    
    // Scroll to a specific view so that it's top is at the top of scrollview
    func scrollToView(view: UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of the child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of the subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y, width: 1, height: self.frame.height), animated: animated)
        }
    }
    
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}
