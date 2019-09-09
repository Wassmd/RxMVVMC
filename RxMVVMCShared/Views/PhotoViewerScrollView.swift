import UIKit

class PhotoViewerScrollView: UIScrollView, UIScrollViewDelegate {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override var bounds: CGRect {
        didSet {
            alignImage()
        }
    }
    
    
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
    
    
    // MARK: - Protocol Conformance
    // MARK: UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        alignInsets()
    }
    
    
    // MARK: - API
    
    func alignImage() {
        updateSizeToFit()
        alignInsets()
        
        setZoomScale()
    }
    
    private func updateSizeToFit() {
        imageView.sizeToFit()
    }
    
    private func updateMinZoomScale() {
        minimumZoomScale = ZoomScaleCalculator.calculateMinZoomScale(
            viewSize: bounds.size,
            imageSize: imageView.bounds.size
        )
    }
    
    private func setZoomScale() {
        setZoomScale(minimumZoomScale, animated: false)
    }
    
    func alignInsets() {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        guard verticalPadding >= 0 else {
            // Limit the image panning to the screen bounds
            contentSize = imageViewSize
            return
        }
        
        // Center the image on screen
        contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}
