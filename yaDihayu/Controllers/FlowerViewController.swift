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
        label.text = "Сідай зручніше\nРозслаб своє тіло\nСфокусуйся на диханні\nЗроби глибокий вдих і видих"
        label.font = UIFont.SFUITextRegular(ofSize: 22)
        label.textAlignment = .center
        label.textColor = UIColor(red: 85/255.0, green: 175/255.0, blue: 231/255.0, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Почнемо", for: .normal)
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
            make.top.equalToSuperview().offset(50)
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
            self.flowerView?.loopMode = .repeat(10) // повторы 10
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
        if startButton.currentTitle == "Почнемо" {
            // Нажата кнопка "Начать"
            UIView.animate(withDuration: 0.5, animations: {
                self.animationFlower() // вызвали старт анимации
                self.startButton.alpha = 0 // на секунду убрали
            }) { _ in
                self.startButton.setTitle("Закінчити", for: .normal)
                UIView.animate(withDuration: 0.5) {
                    self.startButton.alpha = 1 // на секунду вернули
                }
                self.startHapticFeedback() // старт вибро
            }
        } else {
            // Нажата кнопка "Стоп"
            UIView.animate(withDuration: 0.5, animations: {
                self.stopAnimation() // стоп анимация
                self.flowerView?.alpha = 0 // скрыли цветок
                self.flowerView?.isHidden = true
                self.startButton.alpha = 0 // скрыли
            }) { _ in
                self.startButton.setTitle("Почнемо", for: .normal)
                UIView.animate(withDuration: 0.5) {
                    self.startButton.alpha = 1 // показали
                }
                self.stopHapticFeedback() // останавливаем вибро
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
    // настраивае вибрации
    private func createHapticTransientEvents() -> [CHHapticEvent] {
        var events: [CHHapticEvent] = []
        // Цикл для 10 повторений
        for iteration in 0..<10 {
            // Вибрация в течение 4 секунд
            for i in 0..<20 { // 15 событий для 4 секунд вибрации
                // Вычисление времени относительно текущей итерации и индекса внутреннего цикла
                let relativeTime = Double(i) * 0.2 + Double(iteration) * 8.4 // Скорректированное время для каждой итерации
                // Создание события вибрации
                let hapticEvent = CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [],
                    relativeTime: relativeTime,
                    duration: 0.05 // Длительность вибрации
                )
                // Добавление события в массив
                events.append(hapticEvent)
            }
            // Пауза в течение 4 секунд после каждой итерации (кроме последней)
            if iteration < 10 {
                for i in 0..<10 { // 10 событий для 4 секунд паузы
                    // Вычисление времени относительно текущей итерации и индекса внутреннего цикла
                    let relativeTime = Double(i) * 0.5 + Double(iteration) * 8.0 + 4.0 // Скорректированное время для каждой итерации
                    // Создание события паузы
                    let hapticEvent = CHHapticEvent(
                        eventType: .hapticTransient,
                        parameters: [],
                        relativeTime: relativeTime,
                        duration: 0.1 // Длительность паузы
                    )
                    // Добавление события в массив
                    events.append(hapticEvent)
                }
            }
        }
        return events
    }
    // останавливаем вибрации
    private func stopHapticFeedback() {
        // Остановка вибрации
        feedbackGenerator?.stop()
        feedbackGenerator = nil
    }
} // end

