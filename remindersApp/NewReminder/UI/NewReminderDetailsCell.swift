import UIKit

class NewReminderDetailsCell: BaseTableViewCell {
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.text = "Details"
        return label
    }()
    
    private let arrowIconView: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        imageView.image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func setupView() {
        super.setupView()
        
        contentView.addSubview(primaryLabel)
        contentView.addSubview(arrowIconView)
        
        backgroundColor = .systemGray6
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        primaryLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
        }
        
        arrowIconView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(15)
        }
    }
}
