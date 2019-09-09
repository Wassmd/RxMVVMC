import UIKit

public class PhotoDetailCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    // MARK: Mutable
    
    private let photoViewContainer = UIView()
    private let photoViewer = PhotoViewerScrollView()
    
    // MARK: Mutable
    
    public var photo: Photo? {
        didSet {
            configureCell(with: photo)
        }
    }
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setups
    
    func setupSubviews() {
        photoViewContainer.addSubview(photoViewer)
        addSubview(photoViewContainer)
    }
    
    func setupConstraints() {
        photoViewContainer.pinEdges(to: self)
        photoViewer.pinEdges(to: photoViewContainer)
    }
    
    
    // MARK: - Configurations
    
    func configureCell(with photo: Photo?) {
        if let photo = photo, let url = URL(string: photo.photoUrl) {
            photoViewer.imageView.kf.setImage(with: url) { [weak self] _ in
                self?.photoViewer.alignImage()
            }
        }
    }
}
