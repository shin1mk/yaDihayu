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
        label.text = "Просто дихай"
        label.font = UIFont.SFUITextMedium(ofSize: 35)
        label.textAlignment = .center
        label.textColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    // кнопка
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Почати", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextRegular(ofSize: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        return button
    }()    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        button.contentEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animationFlower()
        setupUI()
        setupTarget()
    }
    // animation вью
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
        }
        view.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(15)
        }
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    // target
    private func setupTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
    // tapped
    @objc private func startButtonTapped() {
        let flowerViewController = FlowerViewController()
        // Установите анимацию transitionFrom
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        view.window?.layer.add(transition, forKey: kCATransition)
        flowerViewController.modalPresentationStyle = .overFullScreen
        present(flowerViewController, animated: false, completion: nil)
    }  
    
    @objc private func infoButtonTapped() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .popover
        present(infoViewController, animated: true, completion: nil)
    }
} // end
