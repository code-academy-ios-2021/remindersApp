import UIKit

final class NewListViewController: BaseViewController {
    private let circleView = NewListCircleView()
    
    override func setupView() {
        super.setupView()
                
        view.addSubview(circleView)
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
