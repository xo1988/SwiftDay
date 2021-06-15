//
//  ViewController.swift
//  SwiftDay
//
//  Created by wangyu on 4/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        var day = Day()
        
        print("day ", day.format())
    }
}

