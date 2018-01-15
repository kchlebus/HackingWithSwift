//
//  ViewController.swift
//  AutoLayoutSnapKit
//
//  Created by Kamil Chlebuś on 15/01/2018.
//  Copyright © 2018 Kamil Chlebuś. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        autolayoutWithSnapkit()
    }
    
    func setLabels() {
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
    }
    
    func autolayoutWithSnapkit() {
        var previous: UILabel!
        for label in [label1, label2, label3, label4, label5] {
            label.snp.makeConstraints { make -> Void in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(88)
                if previous != nil {
                    make.top.equalTo(previous.snp.bottom)
                }
                previous = label
            }
        }
    }

}

