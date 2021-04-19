import UIKit

class ActionsBottomView: UIToolbar {
    private var defaultShadowImage: UIImage?
    private var defaultBackgroundImage: UIImage?
    private var defaultBarTintColor: UIColor?
    
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
    
    var isTransparent: Bool = false {
        didSet {
            if isTransparent {
                makeTransparentBackground()
            } else {
                makeDefaultBackground()
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        defaultBackgroundImage = backgroundImage(forToolbarPosition: .any, barMetrics: .default)
        defaultShadowImage = shadowImage(forToolbarPosition: .any)
        defaultBarTintColor = barTintColor
        
        setItems(
            [
                newReminderButton,
                UIBarButtonItem(systemItem: .flexibleSpace),
                addListButton
            ],
            animated: false)
    }
}

// MARK: - Transparency Effect

extension ActionsBottomView {
    private func makeTransparentBackground() {
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
    }
    
    private func makeDefaultBackground() {
        setBackgroundImage(
            defaultBackgroundImage,
            forToolbarPosition: .any,
            barMetrics: .default
        )
        setShadowImage(
            defaultShadowImage,
            forToolbarPosition: .any
        )
        barTintColor = defaultBarTintColor
    }
}
