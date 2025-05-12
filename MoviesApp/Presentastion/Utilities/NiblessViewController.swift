//
//  NiblessViewController.swift
//  MoviesApp
//
//  Created by Khaled hashem on 11/05/2025.
//

import UIKit

open class NiblessViewController: UIViewController {

    // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
