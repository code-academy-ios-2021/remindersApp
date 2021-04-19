import UIKit

final class NewListViewController: BaseViewController {
    private let circleView = NewListCircleView()
    
    override func setupView() {
        super.setupView()
                
        view.addSubview(circleView)
        
        // Setting left bar button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closePressed))
        
        // Setting title on navigation bar
        title = "New List"
    }
    
    @objc private func closePressed() {
        dismiss(animated: true, completion: nil)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        circleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalTo(view)
            make.width.height.equalTo(80)
        }
    }
}
