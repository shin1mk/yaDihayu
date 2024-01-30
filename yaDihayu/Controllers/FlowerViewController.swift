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
    private var flowerView: LottieAnimationView?
    // текст
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Садись поудобнее\nРасслабь свое тело\nДелай вдох и выдох"
        label.font = UIFont.SFUITextRegular(ofSize: 25)
        label.textAlignment = .center
//        label.textColor = .systemBlue
        label.textColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начнем", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextRegular(ofSize: 20)
        button.layer.cornerRadius = 10
//        button.backgroundColor = .systemGray6
        button.backgroundColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
//        button.setTitleColor(UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0), for: .normal)
        return button
    }()  
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        button.contentEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
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
        // закрыть
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview()
        }
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
            make.bottom.equalToSuperview().inset(30)
            make.width.equalTo(200)
        }
    }
    // анимация
    private func animationFlower() {
        // Fade out the titleLabel
        UIView.animate(withDuration: 0.7, animations: {
            self.titleLabel.alpha = 0
        }) { _ in
            // Add and animate the Lottie animationView
            self.flowerView = LottieAnimationView(name: "BlueFlower")
            self.flowerView?.frame = self.view.bounds
            self.flowerView?.contentMode = .scaleAspectFit
            self.flowerView?.loopMode = .repeat(10)
            self.flowerView?.animationSpeed = 2
            self.view.addSubview(self.flowerView!)
            self.flowerView?.play()
            // Set constraints for animationView to have a bottom margin of 100 pixels
            self.flowerView?.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview().inset(100)
                make.top.equalToSuperview().inset(100)
            }
        }
    }
    // target
    private func setupTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        if startButton.currentTitle == "Начнем" {
            // Нажата кнопка "Начать"
            UIView.animate(withDuration: 0.7, animations: {
                self.animationFlower()
                self.startButton.alpha = 0
            }) { _ in
                self.startButton.setTitle("Закончить", for: .normal)
                UIView.animate(withDuration: 0.7) {
                    self.startButton.alpha = 1
                }
            }
        } else {
            // Нажата кнопка "Стоп"
            UIView.animate(withDuration: 0.7, animations: {
                self.stopAnimation()
                self.startButton.alpha = 0
            }) { _ in
                self.startButton.setTitle("Начнем", for: .normal)
                UIView.animate(withDuration: 0.7) {
                    self.startButton.alpha = 1
                }
            }
        }
    }

    private func stopAnimation() {
        // Остановка анимации
        flowerView?.stop()
        flowerView?.removeFromSuperview()
        
        // Показываем снова titleLabel
        UIView.animate(withDuration: 0.7) {
            self.titleLabel.alpha = 1.0
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
        stopAnimation()
    }

}
