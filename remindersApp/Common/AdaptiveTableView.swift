import UIKit

final class AdaptiveHeightTableView: UITableView {
    var maxHeight: CGFloat?
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        var height = contentSize.height
        if let maxHeight = maxHeight {
            height = min(height, maxHeight)
        }
        return CGSize(width: contentSize.width, height: height)
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
