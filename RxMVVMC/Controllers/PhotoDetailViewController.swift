import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {


    // MARK: - Properties
    // MARK: Constants
    
    private enum Constants {
        static let imageContainerLeadingAndTrailing: CGFloat = 100
         static let boarderWidth: CGFloat = 100
    }
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let photo: Photo
    
    let imageContainer = ViewCreator.createImageContaionerWithBoarder(borderWidth: 12)
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    
    // MARK: - Initializers
    
    init(photo: Photo) {
        self.photo = photo
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImageURL()
        setupView()
        setupSubView()
        setupConstraints()
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        self.title = photo.title
        view.backgroundColor = .white
    }
    
    private func setupSubView() {
        view.addSubview(imageContainer)
        imageContainer.addSubview(imageView)
    }
    
    private func setupConstraints() {
        imageContainer.topEdge(to: view.safeAreaLayoutGuide)
        imageContainer.bottomEdge(to: view)
        imageContainer.pinLeadingAndTrailingEdges(to: view, withOffset: Constants.imageContainerLeadingAndTrailing)
        
        imageView.pinEdges(to: imageContainer)
    }
    
    
    // MARK: - Action
    
    func loadImageURL() {
        let imageURL = URL(string: photo.photoUrl)
        imageView.kf.setImage(with: imageURL)
    }
}
