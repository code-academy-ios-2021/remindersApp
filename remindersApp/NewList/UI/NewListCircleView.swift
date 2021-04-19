import UIKit

final class NewListCircleView: BaseView {
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "list").withTintColor(.white))
        
    override func setupView() {
        super.setupView()
        
        backgroundColor = .systemBlue
        
        addSubview(imageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners()
        addShadow()
        addGradient()
    }

    private func roundCorners() {
        layer.cornerRadius = bounds.height / 2
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.systemBlue.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        
        gradient.frame = bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.red.cgColor]
        gradient.cornerRadius = bounds.width / 2
        
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        layer.insertSublayer(gradient, at: 0)
    }
    
    private func addBorder() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 5.0
    }
}
