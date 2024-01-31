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
import CoreHaptics

final class FlowerViewController: UIViewController {
    // свойства
    private var flowerView: LottieAnimationView?
    private var feedbackGenerator: CHHapticEngine? // виброотклик
    // текст
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Садись поудобнее\nРасслабь свое тело\nДелай вдох и выдох"
        label.font = UIFont.SFUITextRegular(ofSize: 25)
        label.textAlignment = .center
        label.textColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начнем", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextRegular(ofSize: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
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
            make.bottom.equalToSuperview().inset(40)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    // target
    private func setupTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    // анимация
    private func animationFlower() {
        // Начало анимации
        UIView.animate(withDuration: 0.7, animations: {
            self.titleLabel.alpha = 0 // скрыли текст
        }) { _ in
            // Запуск анимации цветка
            self.flowerView = LottieAnimationView(name: "BlueFlower")
            self.flowerView?.frame = self.view.bounds
            self.flowerView?.contentMode = .scaleAspectFit
            self.flowerView?.loopMode = .repeat(10) // повторы 1
            self.flowerView?.animationSpeed = 1.6 // скорость
            self.view.addSubview(self.flowerView!)
            self.flowerView?.play()

            self.flowerView?.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview().inset(100)
                make.top.equalToSuperview().inset(100)
            }
        }
    }
    // кнопка старт
    @objc private func startButtonTapped() {
        if startButton.currentTitle == "Начнем" {
            // Нажата кнопка "Начать"
            UIView.animate(withDuration: 0.5, animations: {
                self.animationFlower() // вызвали старт анимации
                self.startButton.alpha = 0 // на секунду убрали
            }) { _ in
                self.startButton.setTitle("Закончить", for: .normal)
                UIView.animate(withDuration: 0.5) {
                    self.startButton.alpha = 1 // на секунду вернули
                }
                self.startHapticFeedback()

            }
        } else {
            // Нажата кнопка "Стоп"
            UIView.animate(withDuration: 0.5, animations: {
                self.stopAnimation() // стоп анимация
                self.flowerView?.alpha = 0 // скрыли цветок
                self.flowerView?.isHidden = true
                self.startButton.alpha = 0 // скрыли
            }) { _ in
                self.startButton.setTitle("Начнем", for: .normal)
                UIView.animate(withDuration: 0.5) {
                    self.startButton.alpha = 1 // показали
                }
                self.stopHapticFeedback()

            }
        }
    }
    // стоп анимация
    private func stopAnimation() {
        DispatchQueue.main.async {
            // Остановка вибрации
            self.feedbackGenerator?.stop()
            // Остановка анимации цветка
            self.flowerView?.stop()
            self.flowerView?.alpha = 0
            self.flowerView?.isHidden = true
            // Показываем снова titleLabel
            UIView.animate(withDuration: 0.5) {
                self.titleLabel.alpha = 1.0
            }
        }
    }
    // крестик закрыть остановить анимацию
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
        stopAnimation()
    }
    // виброотклик
   
    private func startHapticFeedback() {
        do {
            // Проверяем, поддерживается ли устройство вибрация
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            // Создаем двигатель для вибрации
            feedbackGenerator = try CHHapticEngine()
            // Запускаем двигатель
            try feedbackGenerator?.start()
            // Создаем паттерн для вибрации
            let hapticPattern = try CHHapticPattern(
                events: createHapticTransientEvents(),
                parameters: []
            )
            // Создаем плеер для вибрации
            let hapticPlayer = try feedbackGenerator?.makePlayer(with: hapticPattern)
            // Воспроизводим вибрацию
            try hapticPlayer?.start(atTime: 0)
        } catch {
            print("Не удалось запустить вибрацию: \(error)")
        }
    }
    /*
    // настраивае вибрации
    private func createHapticTransientEvents() -> [CHHapticEvent] {
        var events: [CHHapticEvent] = []
        // цикл
        for i in 0..<20 { // повторы
            let relativeTime = Double(i) * 0.15 // Интервал между вибрациями
            let hapticEvent = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [],
                relativeTime: relativeTime,
                duration: 0.1 // Длительность вибрации
            )
            events.append(hapticEvent)
        }
        
        return events
    }
     */
    private func createHapticTransientEvents() -> [CHHapticEvent] {
        var events: [CHHapticEvent] = []

        // Loop for 10 repetitions
        for iteration in 0..<10 {
            // Vibration for 4 seconds
            for i in 0..<15 { // 8 events for 4 seconds of vibration
                let relativeTime = Double(i) * 0.2 + Double(iteration) * 8.4 // Adjusted time for each iteration
                let hapticEvent = CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [],
                    relativeTime: relativeTime,
                    duration: 0.05 // Duration of vibration
                )
                events.append(hapticEvent)
            }

            // Pause for 4 seconds after each iteration (except the last one)
            if iteration < 10 {
                for i in 0..<10 { // 4 events for 4 seconds of pause
                    let relativeTime = Double(i) * 0.5 + Double(iteration) * 8.0 + 4.0 // Adjusted time for each iteration
                    let hapticEvent = CHHapticEvent(
                        eventType: .hapticTransient,
                        parameters: [],
                        relativeTime: relativeTime,
                        duration: 0.1 // Duration of the pause
                    )
                    events.append(hapticEvent)
                }
            }
        }

        return events
    }
    private func stopHapticFeedback() {
        // Остановка вибрации
        feedbackGenerator?.stop()
        feedbackGenerator = nil
    }


} // end

