import UIKit

class PhotoViewerScrollView: UIScrollView, UIScrollViewDelegate {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        contentInset = .zero
        delegate = self
    }
    
    private func setupSubviews() {
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        imageView.pinEdges(to: self)
    }
}
