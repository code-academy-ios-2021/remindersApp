import UIKit

class ActionsBottomView: UIToolbar {
    private let newReminderButton: UIBarButtonItem = {
        let color = UIColor.systemBlue
        let highlightedColor = UIColor.systemBlue.withAlphaComponent(0.5)
        let button = UIButton()
        button.setTitle("  New Reminder", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(highlightedColor, for: .highlighted)
        let normalImage = #imageLiteral(resourceName: "plus").withTintColor(color)
        let highlightedImage = #imageLiteral(resourceName: "plus").withTintColor(highlightedColor)
        button.setImage(normalImage, for: .normal)
        button.setImage(highlightedImage, for: .highlighted)
        let fontSize = button.titleLabel?.font.pointSize ?? 12
        button.titleLabel?.font = .boldSystemFont(ofSize: fontSize)
        
        return UIBarButtonItem(customView: button)
    }()
    
    private let addListButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: "Add List",
            style: .plain,
            target: nil,
            action: nil
        )
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setBackgroundImage(
            UIImage(),
            forToolbarPosition: .any,
            barMetrics: .default
        )
        
        setShadowImage(
            UIImage(),
            forToolbarPosition: .any
        )
        
        barTintColor = .systemGray6
        
        setItems(
            [
                newReminderButton,
                UIBarButtonItem(systemItem: .flexibleSpace),
                addListButton
            ],
            animated: false)
    }
}
