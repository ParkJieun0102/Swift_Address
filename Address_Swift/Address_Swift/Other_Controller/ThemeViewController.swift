//
//  ThemeViewController.swift
//  Address_Swift
//
//  Created by JiEunPark on 2021/02/26.
//

import UIKit

class ThemeViewController: UIViewController {

    @IBOutlet weak var yellowTheme: UIImageView!
    @IBOutlet weak var redTheme: UIImageView!
    @IBOutlet weak var blueTheme: UIImageView!
    @IBOutlet weak var greenTheme: UIImageView!
    @IBOutlet weak var orangeTheme: UIImageView!
    @IBOutlet weak var purpleTheme: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지뷰를 터치했을때 이벤트 주기 ( 빨간색 ) +++++++++++++++++
        let tapRed = UITapGestureRecognizer(target: self, action: #selector(touchToRed))
        redTheme.addGestureRecognizer(tapRed)
        redTheme.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        
        // 이미지뷰를 터치했을때 이벤트 주기 ( 노란색 ) +++++++++++++++++
        let tapYellow = UITapGestureRecognizer(target: self, action: #selector(touchToYellow))
        yellowTheme.addGestureRecognizer(tapYellow)
        yellowTheme.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        
        // 이미지뷰를 터치했을때 이벤트 주기 ( 하늘색 ) +++++++++++++++++
        let tapBlue = UITapGestureRecognizer(target: self, action: #selector(touchToBlue))
        blueTheme.addGestureRecognizer(tapBlue)
        blueTheme.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        
        // 이미지뷰를 터치했을때 이벤트 주기 ( 주황색 ) +++++++++++++++++
        let tapOrange = UITapGestureRecognizer(target: self, action: #selector(touchToOrange))
        orangeTheme.addGestureRecognizer(tapOrange)
        orangeTheme.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        
        // 이미지뷰를 터치했을때 이벤트 주기 ( 초록색 ) +++++++++++++++++
        let tapGreen = UITapGestureRecognizer(target: self, action: #selector(touchToGreen))
        greenTheme.addGestureRecognizer(tapGreen)
        greenTheme.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        
        // 이미지뷰를 터치했을때 이벤트 주기 ( 초록색 ) +++++++++++++++++
        let tapPurple = UITapGestureRecognizer(target: self, action: #selector(touchToPurple))
        purpleTheme.addGestureRecognizer(tapPurple)
        purpleTheme.isUserInteractionEnabled = true
        // ++++++++++++++++++++++++++++++++++++++++
        
    }
    
    // 빨간색 테마
    @objc func touchToRed(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            self.navigationController?.navigationBar.barTintColor = .systemRed
            UITabBar.appearance().barTintColor = .systemRed
            self.tabBarController?.tabBar.barTintColor = .systemRed
        }
    }
    
    // 노란색 테마
    @objc func touchToYellow(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            self.navigationController?.navigationBar.barTintColor = .yellow
            UITabBar.appearance().barTintColor = .yellow
            self.tabBarController?.tabBar.barTintColor = .yellow
            
            // 지정
//            UIButton.appearance().backgroundColor = .yellow
        }
    }
    
    
    // 하늘색 테마
    @objc func touchToBlue(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            self.navigationController?.navigationBar.barTintColor = .systemTeal
            UITabBar.appearance().barTintColor = .systemTeal
            self.tabBarController?.tabBar.barTintColor = .systemTeal
        }
    }
    
    
    // 주황색 테마
    @objc func touchToOrange(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            self.navigationController?.navigationBar.barTintColor = .systemOrange
            UITabBar.appearance().barTintColor = .systemOrange
            self.tabBarController?.tabBar.barTintColor = .systemOrange
        }
    }
    
    // 초록색 테마
    @objc func touchToGreen(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            self.navigationController?.navigationBar.barTintColor = .systemGreen
            UITabBar.appearance().barTintColor = .systemGreen
            self.tabBarController?.tabBar.barTintColor = .systemGreen
        }
    }
    
    // 보라색 테마
    @objc func touchToPurple(sender: UITapGestureRecognizer) {
        if (sender.state == .ended) {
            self.navigationController?.navigationBar.barTintColor = .systemPurple
            UITabBar.appearance().barTintColor = .systemPurple
            self.tabBarController?.tabBar.barTintColor = .systemPurple
        }
    }
}
