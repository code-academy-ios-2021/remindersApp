import UIKit
import SwiftUI

struct ViewControllerRepresentable<T: UIViewController>: UIViewControllerRepresentable {
    var viewController: () -> T

    func makeUIViewController(context: Context) -> T {
        return viewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
