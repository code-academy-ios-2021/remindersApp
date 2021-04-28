import UIKit

class NewReminderTextFieldCell: BaseTableViewCell {
    private let newReminderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont(name: "HelveticaNeue", size: 15)
        return textField
    }()
    
    override func setupView() {
        super.setupView()
        
        contentView.addSubview(newReminderTextField)
        
        backgroundColor = .systemGray6
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        newReminderTextField.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
