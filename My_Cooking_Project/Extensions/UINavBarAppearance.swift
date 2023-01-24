//
//  UINavBarAppearance.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/16/23.
//

import Foundation
import UIKit

enum BackButtonType {
    case back
    case cancel
    case close
    case clear
}

enum UINavigationBarAppearanceType {
    case defaultAppear
    case opaque
    case transparent

    var backImage: UIImage {
        return UIImage(named: "backArrow")!
    }
}

private var actionKey: Void?

extension UIViewController {

    private var _action: () -> Void {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! () -> Void
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }


    private func customNavBarAppearance(
        _ type: UINavigationBarAppearanceType,
        titleColor: UIColor = .white,
        largeTitleColor: UIColor = .white,
        buttonColor: UIColor = .white,
        fontTitle: UIFont = UIFont.systemFont(ofSize: 24),
        backButtonText: String = ""
    ) -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()

        // set type nav bar
        switch type {
        case .defaultAppear:
            customNavBarAppearance.configureWithDefaultBackground()
            customNavBarAppearance.backgroundColor = .systemBackground
        case .opaque:
            customNavBarAppearance.configureWithOpaqueBackground()
            customNavBarAppearance.backgroundColor = .systemBackground
        case .transparent:
            customNavBarAppearance.configureWithTransparentBackground()
            customNavBarAppearance.backgroundColor = .systemBackground
        }

        // Apply colored, font normal and large titles.
        customNavBarAppearance.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: fontTitle
        ]
        customNavBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: largeTitleColor
        ]

        // Apply white color to all the nav bar buttons.
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)

        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: buttonColor]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: buttonColor]

        let backBarButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)

        backBarButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        backBarButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.white]
        backBarButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.white]
        backBarButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]


        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavBarAppearance.backButtonAppearance = backBarButtonItemAppearance
        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance

        UINavigationBar.appearance().tintColor = .white


        // change text with back button

        return customNavBarAppearance
    }

    func setNavigationStackCustomNavBar(type: UINavigationBarAppearanceType) {
        let newAppearance = customNavBarAppearance(type)

        navigationController!.navigationBar.scrollEdgeAppearance = newAppearance
        navigationController!.navigationBar.compactAppearance = newAppearance
        navigationController!.navigationBar.standardAppearance = newAppearance

        if #available(iOS 15.0, *) {
            navigationController!.navigationBar.compactScrollEdgeAppearance = newAppearance
        }
    }

    func setUIAppearanceCustomNavBar(type: UINavigationBarAppearanceType) {
        let newAppearance = customNavBarAppearance(type)

        UINavigationBar.appearance().scrollEdgeAppearance = newAppearance
        UINavigationBar.appearance().compactAppearance = newAppearance
        UINavigationBar.appearance().standardAppearance = newAppearance

        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = newAppearance
        }
    }


    func setLocalCustomNavBar(type: UINavigationBarAppearanceType) {
        let newAppearance = customNavBarAppearance(type)

        navigationItem.scrollEdgeAppearance = newAppearance
        navigationItem.compactAppearance = newAppearance
        navigationItem.standardAppearance = newAppearance

        if #available(iOS 15.0, *) {
            navigationItem.compactScrollEdgeAppearance = newAppearance
        }
    }

    func addCustomizeNavigationBackButton(type: BackButtonType, completion: @escaping () -> Void) {
        var backButton = UIBarButtonItem()
        _action = completion
        switch type {
        case .cancel:
            let text = "Cancel"
            backButton = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(pressed))
        case .back:
            let image = UIImage(named: "backArrow")?.withRenderingMode(.alwaysOriginal)
            backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(pressed))
        case .close:
            let image = UIImage(named: "close")
            backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(pressed))
        case .clear:
            backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }

        backButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .normal)
        navigationItem.leftBarButtonItem = backButton
    }

    @objc
    private func pressed(sender: UIBarButtonItem) {
        _action()
    }
}
