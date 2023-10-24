//
//  ViewController.swift
//  CircularProgressTimer
//
//  Created by Zezethu Dlanga on 2023/10/24.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var circularProgressBarView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    //MARK: - Properties
    var countdownTimer: Timer!
    var totalSeconds = 60
    var circleLayer = CAShapeLayer()
    var circleProgressLayer = CAShapeLayer()
    var startPoint = CGFloat(-Double.pi / 2)
    var endPoint = CGFloat(3 * Double.pi / 2)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Display the initial seconds label
        self.timerLabel.text = "\(totalSeconds)"
        
        //Update and display the updates seconds label
        self.startTimer()
        
        //Diplay circular progress bar animation
        self.circularProgressBarAnimation(duration: Double(self.totalSeconds))
    }

    func startTimer() {
        self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if self.totalSeconds != 0 {
            totalSeconds -= 1
        } else {
            endTimer()
        }
        self.timerLabel.text = "\(totalSeconds)"
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func createCircularProgressBarPath() {
        let circularProgressBarPath = UIBezierPath(arcCenter: CGPoint(x: circularProgressBarView.frame.size.width / 2.0, y: circularProgressBarView.frame.height / 2.0), radius: 80, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        circleLayer.path = circularProgressBarPath.cgPath
        circleLayer.lineCap = .square
        circleLayer.strokeEnd = 1.0
        circleLayer.lineWidth = 15.0
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circularProgressBarView.layer.addSublayer(circleLayer)
        
        circleProgressLayer.path = circularProgressBarPath.cgPath
        circleProgressLayer.lineCap = .square
        circleProgressLayer.strokeEnd = 0
        circleProgressLayer.lineWidth = 15.0
        circleProgressLayer.fillColor = UIColor.clear.cgColor
        circleProgressLayer.strokeColor = UIColor.systemPink.cgColor
        circularProgressBarView.layer.addSublayer(circleProgressLayer)
        
    }
    
    func circularProgressBarAnimation(duration: TimeInterval) {
        self.createCircularProgressBarPath()
        
        let circularProgressBarAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressBarAnimation.duration = duration
        circularProgressBarAnimation.toValue = 1.0
        circularProgressBarAnimation.isRemovedOnCompletion = false
        circleProgressLayer.add(circularProgressBarAnimation, forKey: "progressAnim")
    }
}

