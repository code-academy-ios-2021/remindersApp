import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
        setupConstraints()
    }
    
    func setupView() {}
    func setupConstraints() {}
}
