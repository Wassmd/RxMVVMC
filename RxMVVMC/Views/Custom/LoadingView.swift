import UIKit

class LoadingView: UIView {
    
    
    // MARK: - Inner Types
    
    private enum Constants {
        static let loadingViewHeight: CGFloat = 80
        static let loadingViewWidth: CGFloat = 80
        static let defaultPadding: CGFloat = 8
    }
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let loadingIndicator = UIActivityIndicatorView(style: .gray)
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font =  UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loadingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loadingIndicator, loadingLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        isHidden = true
    }
    
    private func setupSubViews() {
        self.addSubview(loadingStackView)
    }
    
    private func setupConstraints() {
        loadingStackView.translatesAutoresizingMaskIntoConstraints = false
        loadingStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loadingStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        loadingStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        loadingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        widthAnchor.constraint(equalToConstant: Constants.loadingViewWidth).isActive = true
        heightAnchor.constraint(equalToConstant: Constants.loadingViewHeight).isActive = true
    }
    
    
    // MARK: - Actions
    
    func show() {
        isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func hide() {
        isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    
    // MARK: - Helpers
    
    func placeInCenter(of view: UIView) {
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
