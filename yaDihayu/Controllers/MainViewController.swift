//
//  ViewController.swift
//  yaDihayu
//
//  Created by SHIN MIKHAIL on 28.01.2024.
//

import UIKit
import SnapKit
import Lottie

final class MainViewController: UIViewController {
    private var koalaView: LottieAnimationView?
    // MARK: - свойства
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Просто дыши"
        label.font = UIFont.SFUITextMedium(ofSize: 35)
        label.textAlignment = .center
        label.textColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextRegular(ofSize: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animationFlower()
        setupUI()
        setupTarget()
    }
    // animation
    private func animationFlower() {
        koalaView = .init(name: "Koala")
        koalaView!.frame = view.bounds
        koalaView!.contentMode = .scaleAspectFit
        koalaView!.loopMode = .loop
        koalaView!.animationSpeed = 1
        view.addSubview(koalaView!)
        koalaView!.play()
    }
    // constraints
    private func setupUI() {
        view.backgroundColor = .black
        // title label
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
        }
        // breatheButton
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.width.equalTo(200)
        }
    }
    // target
    private func setupTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    // tapped
    @objc private func startButtonTapped() {
        let breatheViewController = FlowerViewController()
        // Установите анимацию transitionFrom
        let transition = CATransition()
        transition.duration = 0.7
        transition.type = CATransitionType.fade
        view.window?.layer.add(transition, forKey: kCATransition)
        breatheViewController.modalPresentationStyle = .overFullScreen
        present(breatheViewController, animated: false, completion: nil)
    }


} // end
