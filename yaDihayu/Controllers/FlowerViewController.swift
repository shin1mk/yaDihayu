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
    private var feedbackGenerator: CHHapticEngine?
    private var animationCounter = 0

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
            make.bottom.equalToSuperview().inset(40)
            make.width.equalTo(200)
        }
    }
    // анимация
//    private func animationFlower() {
//        // не видно текста
//        UIView.animate(withDuration: 0.7, animations: {
//            self.titleLabel.alpha = 0
//        }) { _ in
//            // покажем и начнем анимацию цветка
//            self.flowerView = LottieAnimationView(name: "BlueFlower")
//            self.flowerView?.frame = self.view.bounds
//            self.flowerView?.contentMode = .scaleAspectFit
//            self.flowerView?.loopMode = .repeat(1)
//            self.flowerView?.animationSpeed = 2
//            self.view.addSubview(self.flowerView!)
//            self.flowerView?.play()
//            // Set constraints for animationView to have a bottom margin of 100 pixels
//            self.flowerView?.snp.makeConstraints { make in
//                make.leading.equalToSuperview()
//                make.trailing.equalToSuperview()
//                make.bottom.equalToSuperview().inset(100)
//                make.top.equalToSuperview().inset(100)
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.startHapticFeedback()
//                
//                // Зацикливание вызова
//                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { // Подождите 2 секунды (пример)
//                    self.animationFlower()
//                }
//            }
//        }
//    }

    private func animationFlower() {
        guard animationCounter < 10 else {
            // Если достигнуто 10 повторений, выходим из рекурсии
            return
        }

        // Увеличиваем счетчик
        animationCounter += 1
        
        // Начало анимации
        UIView.animate(withDuration: 0.7, animations: {
            self.titleLabel.alpha = 0
        }) { _ in
            // Запуск анимации цветка
            self.flowerView = LottieAnimationView(name: "BlueFlower")
            self.flowerView?.frame = self.view.bounds
            self.flowerView?.contentMode = .scaleAspectFit
            self.flowerView?.loopMode = .repeat(1)
            self.flowerView?.animationSpeed = 2
            self.view.addSubview(self.flowerView!)
            self.flowerView?.play()
            
            // Установка ограничений для анимационного представления с отступом снизу на 100 пикселей
            self.flowerView?.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview().inset(100)
                make.top.equalToSuperview().inset(100)
            }
            
            // Задержка перед вызовом следующей анимации
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.startHapticFeedback()
                
                // Зацикливание вызова
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { // Подождите 6 секунд (пример)
                    // Рекурсивный вызов для следующей анимации
                    self.animationFlower()
                }
            }
        }
    }


    // target
    private func setupTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    // кнопка старт
    @objc private func startButtonTapped() {
        if startButton.currentTitle == "Начнем" {
            // Нажата кнопка "Начать"
            UIView.animate(withDuration: 0.7, animations: {
                self.animationFlower() // вызвали старт анимации
                self.startButton.alpha = 0 // на секунду убрали
            }) { _ in
                self.startButton.setTitle("Закончить", for: .normal)
                UIView.animate(withDuration: 0.7) {
                    self.startButton.alpha = 1 // на секунду вернули
                }
            }
        } else {
            // Нажата кнопка "Стоп"
            UIView.animate(withDuration: 0.7, animations: {
                self.stopAnimation() // стоп анимация
                self.startButton.alpha = 0 // скрыли
            }) { _ in
                self.startButton.setTitle("Начнем", for: .normal)
                UIView.animate(withDuration: 0.7) {
                    self.startButton.alpha = 1 // показали
                }
            }
        }
    }
    // стоп анимация
    private func stopAnimation() {
        // Остановка анимации
        flowerView?.stop()
        flowerView?.removeFromSuperview()
        // Показываем снова titleLabel
        UIView.animate(withDuration: 0.7) {
            self.titleLabel.alpha = 1.0
        }
    }
    // крестик закрыть остановить анимацию
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
        stopAnimation()
    }
    
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
    
    private func createHapticTransientEvents() -> [CHHapticEvent] {
        var events: [CHHapticEvent] = []
        
        for i in 0..<14 {
            let relativeTime = Double(i) * 0.20 // Интервал в 0.5 секунды между вибрациями
            let hapticEvent = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [],
                relativeTime: relativeTime,
                duration: 0.1 // Длительность короткой вибрации
            )
            events.append(hapticEvent)
        }
        
        return events
    }
} // end
