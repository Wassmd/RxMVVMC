import UIKit
import Kingfisher

class PhotoGridCell: UICollectionViewCell {
    
    
    //MARK: InnerTypes
    private enum Constants {
        static let titleLabelTopOffset: CGFloat = 8
        static let titleLabelFont = UIFont.boldSystemFont(ofSize: 24)
        static let imageContainerHeight: CGFloat = 160
        static let imageViewTopOffset: CGFloat = 7
    }
    
    // MARK: - Properties
    // MARK: Immutables
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "kittens")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.tintColor = .black
        titleLabel.text = "Kittens"
        titleLabel.font = Constants.titleLabelFont
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    let imageContainer = ViewCreator.createImageContaionerWithBoarder()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    // MARK: - Setups
    
    private func setupSubViews() {
        contentView.addSubview(imageContainer)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
  
    private func setupConstraints() {
        imageContainer.pinLeadingAndTrailingEdges(to: contentView)
        imageContainer.topEdge(to: contentView)
        imageContainer.pinHeight(to: Constants.imageContainerHeight)
        
        imageView.pinTopAndBottomEdge(to: imageContainer, withOffset: Constants.imageViewTopOffset)
        imageView.pinLeadingAndTrailingEdges(to: imageContainer, withOffset: Constants.imageViewTopOffset)
        
        titleLabel.pinLeadingAndTrailingEdges(to: contentView)
        titleLabel.pinTopEdgeToBottom(of: imageContainer, withOffset: Constants.titleLabelTopOffset)
        titleLabel.pinBottomEdge(lessThanOrEqualTo: contentView)
    }
    
    
    //MARK: - Helper
    
    func configureCell(with photo: Photo) {
        titleLabel.text = photo.title
        
        let url = URL(string: photo.imageUrl)
        imageView.kf.setImage(with: url)
    }
}
