import UIKit
import Kingfisher

open class PhotoGridCell: UICollectionViewCell {
    
    
    // MARK: - Inner Types
    
    private enum Constants {
        static let titleLabelTopOffset: CGFloat = 8
        static let titleLabelFont = UIFont.boldSystemFont(ofSize: 24)
        static let imageViewTopOffset: CGFloat = 7
        static let cornerRadius: CGFloat = 16
        static let titleLabelHeight: CGFloat = 20
    }
    
    // MARK: - Properties
    // MARK: Immutables
    
    let imageView = UIImageView()
    
    public let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .gray
        titleLabel.text = ""
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    // MARK: Mutable
    
    public var photo: Photo? {
        didSet {
            configureCell(with: photo)
        }
    }
    
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupSubViews()
        setupConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View lifecycle
    
    override open func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    // MARK: - Setups
    
    private func setup() {
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.layer.masksToBounds = true
    }
    
    open func setupSubViews() {
        [imageView, titleLabel].forEach(contentView.addSubview(_:))
    }
  
    private func setupConstraints() {
        imageView.pinLeadingAndTrailingEdges(to: contentView)
        imageView.topEdge(to: contentView)
        imageView.pinBottomEdgeToTop(of: titleLabel, withOffset: -Constants.titleLabelTopOffset)
        
        titleLabel.pinLeadingAndTrailingEdges(to: contentView)
        titleLabel.pinBottomEdge(lessThanOrEqualTo: contentView)
        titleLabel.pinHeight(to: Constants.titleLabelHeight)
    }
    
    
    // MARK: - Helper
    
    public func configureCell(with photo: Photo?) {
        guard let photo = photo else { return }
        titleLabel.text = photo.title
        
        if let url = URL(string: photo.photoUrl) {
            imageView.kf.setImage(with: url)
        }
    }
}
