//
//  ViewController.swift
//  yaDihayu
//
//  Created by SHIN MIKHAIL on 28.01.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Просто дыши"
        label.font = UIFont.SFUITextHeavy(ofSize: 35)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private let breatheButton: UIButton = {
        let button = UIButton()
        button.setTitle("Breathe", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextHeavy(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
        setupTarget()
        setupUI()
    }

    private func setupUI() {
        // background image view
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // title label
        view.addSubview(titleLabel)
        titleLabel.layer.zPosition = 1
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
        }
        // pause button
        view.addSubview(breatheButton)
        breatheButton.layer.zPosition = 1
        breatheButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    private func setupTarget() {
        breatheButton.addTarget(self, action: #selector(breatheButtonTapped), for: .touchUpInside)

    }

    @objc private func breatheButtonTapped() {
        let breatheViewController = BreatheViewController()

        // Установите анимацию transitionFrom
        let transition = CATransition()
        transition.duration = 1.0
        transition.type = CATransitionType.fade

        // Добавьте анимацию к окну
        view.window?.layer.add(transition, forKey: kCATransition)
        breatheViewController.modalPresentationStyle = .overFullScreen

        // Представьте контроллер
        present(breatheViewController, animated: false, completion: nil)
    }


}

