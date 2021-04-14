import UIKit

class ActionsBottomView: BaseView {
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.setBackgroundImage(
            UIImage(),
            forToolbarPosition: .any,
            barMetrics: .default
        )
        
        toolbar.setShadowImage(
            UIImage(),
            forToolbarPosition: .any
        )
        
        toolbar.barTintColor = .systemGray6
        
        return toolbar
    }()
    
    private let newReminderButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: "New Reminder",
            style: .plain,
            target: nil,
            action: nil
        )
    }()
    
    private let addListButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: "Add List",
            style: .plain,
            target: nil,
            action: nil
        )
    }()
    
    override func setupView() {
        addSubview(toolbar)
    
        toolbar.setItems(
            [
                newReminderButton,
                UIBarButtonItem(systemItem: .flexibleSpace),
                addListButton
            ],
            animated: false)
    }
    
    override func setupConstraints() {
        toolbar.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
