import UIKit

public class LoadingView: UIView {
    
    
    // MARK: - Inner Types
    
    private enum Constants {
        static let loadingViewHeight: CGFloat = 80
        static let loadingViewWidth: CGFloat = 80
        static let defaultPadding: CGFloat = 8
    }
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let loadingIndicator = UIActivityIndicatorView(style: .white)
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font =  UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        isHidden = true
    }
    
    private func setupSubViews() {
        addSubview(loadingStackView)
    }
    
    private func setupConstraints() {
        loadingStackView.pinEdges(to: self)
    }
    
    
    // MARK: - Actions
    
    public func show() {
        isHidden = false
        loadingIndicator.startAnimating()
    }
    
    public func hide() {
        isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    
    // MARK: - Helpers
    
    public func placeInCenter(of view: UIView) {
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}
