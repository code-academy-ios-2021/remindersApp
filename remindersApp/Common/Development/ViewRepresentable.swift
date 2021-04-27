import UIKit
import SwiftUI

struct ViewRepresentable: UIViewRepresentable {
    var view: () -> UIView
    
    func makeUIView(context: Context) -> some UIView {
        return view()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
