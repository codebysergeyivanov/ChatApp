//
//  MainVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 15.01.2021.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }


}



import SwiftUI
struct MainPreview: PreviewProvider{
   
    static var previews: some View{
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
 
        typealias UIViewControllerType = MainVC
        
        func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType {
            return MainVC()
        }

        func updateUIViewController(_ uiViewController: MainVC, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {}
    }
}
