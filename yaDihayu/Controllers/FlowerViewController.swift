//
//  FlowerViewController.swift
//  yaDihayu
//
//  Created by SHIN MIKHAIL on 30.01.2024.
//

// #55AFE7

import Foundation
import UIKit
import SnapKit
import Lottie

final class FlowerViewController: UIViewController {
    // свойства
    private var animationView: LottieAnimationView?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Садись поудобнее, расслабь свое тело. Делай вдох и выдох"
        label.font = UIFont.SFUITextMedium(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()  
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("stop", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    // цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTarget()
    }
    // методы
    private func setupUI() {
        view.backgroundColor = .black
        
        // текст
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
        }
        // старт
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        view.addSubview(stopButton)
        stopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    // анимация
//    private func animationFlower() {
//        // Fade out the titleLabel
//        UIView.animate(withDuration: 0.7, animations: {
//            self.titleLabel.alpha = 0
//        }) { _ in
//            // Remove the titleLabel from the superview
//            self.titleLabel.removeFromSuperview()
//            // Add and animate the Lottie animationView
//            self.animationView = LottieAnimationView(name: "BlueFlower")
//            self.animationView?.frame = self.view.bounds
//            self.animationView?.contentMode = .scaleAspectFit
//            self.animationView?.loopMode = .repeat(10)
//            self.animationView?.animationSpeed = 2
//            self.view.addSubview(self.animationView!)
//            self.animationView?.play()
//        }
//    }
    private func animationFlower() {
        // Fade out the titleLabel
        UIView.animate(withDuration: 0.7, animations: {
            self.titleLabel.alpha = 0
        }) { _ in
            // Remove the titleLabel from the superview
            self.titleLabel.removeFromSuperview()
            // Add and animate the Lottie animationView
            self.animationView = LottieAnimationView(name: "BlueFlower")
            self.animationView?.frame = self.view.bounds
            self.animationView?.contentMode = .scaleAspectFit
            self.animationView?.loopMode = .repeat(10)
            self.animationView?.animationSpeed = 2
            self.view.addSubview(self.animationView!)
            self.animationView?.play()

            // Set constraints for animationView to have a bottom margin of 200 pixels
            self.animationView?.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview().inset(100)
                make.top.equalToSuperview()
            }
        }
    }

    // target
    private func setupTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        animationFlower()
    }    
    
    @objc private func stopButtonTapped() {
        print("stopButton")
    }
}
/*
import UIKit
import SnapKit
import Lottie

final class FlowerView: UIView {
    // свойства
    private var animationView: LottieAnimationView?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Садись поудобнее, расслабь свое тело. Делай вдох и выдох"
        label.font = UIFont.SFUITextMedium(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
  
    // инициализатор
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupTarget()
    }

    // методы
    private func setupUI() {
        backgroundColor = .black
        // текст
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(300)
        }
        // старт
        addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    // анимация
    private func animationFlower() {
        // Fade out the titleLabel
        UIView.animate(withDuration: 0.7, animations: {
            self.titleLabel.alpha = 0
        }) { _ in
            // Remove the titleLabel from the superview
            self.titleLabel.removeFromSuperview()
            // Add and animate the Lottie animationView
            self.animationView = LottieAnimationView(name: "BlueFlower")
            self.animationView?.frame = self.bounds
            self.animationView?.contentMode = .scaleAspectFit
            self.animationView?.loopMode = .repeat(10)
            self.animationView?.animationSpeed = 2
            self.addSubview(self.animationView!)
            self.animationView?.play()
        }
    }
    
    // target
    private func setupTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        animationFlower()
    }
}
*/
