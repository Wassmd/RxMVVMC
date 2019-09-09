import UIKit

class PhotoViewerScrollView: UIScrollView, UIScrollViewDelegate {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override var bounds: CGRect {
        didSet {
            alignImage() // need revisit
        }
    }
    
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
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
    
    
    // MARK: - Protocol Conformance
    // MARK: UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        alignScrollViewInsets()
    }
    
    
    // MARK: - API
    
    func alignImage() {
        updateZoomScale()
        alignScrollViewInsets()
    }
    
    private func updateZoomScale() {
        updateSizeToFit()
        updateMinimumZoomScale()
    
        setZoomScale(rect: visibleRect(), scale: zoomScale, oldMinimumScale: minimumZoomScale)
    }

    private func updateSizeToFit() {
        imageView.sizeToFit()
    }
    
    private func updateMinimumZoomScale() {
        minimumZoomScale = ZoomScaleCalculator.calculateMinZoomScale(
            viewSize: bounds.size,
            imageSize: imageView.bounds.size
        )
    }
    
    func visibleRect() -> CGRect {
        return convert(bounds, to: imageView)
    }
    
    private func setZoomScale(rect: CGRect, scale: CGFloat, oldMinimumScale: CGFloat) {
        if let transform = ZoomScaleCalculator.transformToInitialZoom(rect: rect, scale: scale, by: minimumZoomScale / oldMinimumScale) {
            setZoomScale(transform.newScale, animated: false)
        } else {
            setZoomScale(minimumZoomScale, animated: false)
        }
    }
    
    func alignScrollViewInsets() {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        guard verticalPadding >= 0 else {
            contentSize = imageViewSize
            return
        }
        
        contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}
