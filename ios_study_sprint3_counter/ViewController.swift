//
//  ViewController.swift
//  ios_study_sprint3_counter
//
//  Created by Павел Шкуропацкий on 20.07.2024.
//

import UIKit

class ViewController: UIViewController {

    /// Дополнительные действия при загрузке вью
    ///
    /// Дополнительно инициирует текст информации о счетчике
    ///
    /// Скругляет поле истории счетчика
    ///
    /// Добавляет начальную запись в историю
    ///
    /// Обновляет элемент истории счетчика
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterInfo.text = "0"
        
        counterHistoryText.layer.cornerRadius = 10
        if counterHistory.isEmpty { addInitialHistoryLine() }
        
        updateHistoryView()
    }
    
    /// Состояние счетчика в целочисленном виде
    ///
    /// Дополнительно контролируется, что счетчик не должен быть меньше 0
    private var counterState: Int = 0 {
        didSet {
            counterState = max(0, counterState)
            counterInfo.text = counterStateText
        }
    }
    
    /// Состояние счетчика в виде текста
    ///
    /// Для отображения пользователю
    private var counterStateText: String {
        "Значение счётчика: \(counterState)"
    }
    
    /// История счетчика
    private var counterHistory: [String] = []
    
    /// История счетчика в виде текста для отображения в интерфейсе
    private var counterHistoryAsText: String {
        counterHistory.joined(separator: "\n")
    }
    
    /// Кнопка увеличения счетчика
    @IBOutlet private weak var plusButton: UIButton!
    
    /// Кнопка уменьшения счетчик
    @IBOutlet private weak var minusButton: UIButton!
    
    /// Кнопка сброса счетчика
    @IBOutlet private weak var resetButton: UIButton!

    /// Инфомрация о состоянии счетчика
    @IBOutlet private weak var counterInfo: UILabel!

    /// Текст истории счетчика
    @IBOutlet private weak var counterHistoryText: UITextView!
    
    @IBAction private func plusOnClick() {
        counterState += 1
        
        addPlusHistoryLine()
    }
    
    @IBAction private func minusOnClick() {
        if counterState > 0 {
            counterState -= 1
            
            addMinusHistoryLine()
        } else {
            addMinusOverflowHistoryLine()
        }
    }
    
    @IBAction private func resetOnClick() {
        counterState = 0
        addResetHistoryLine()
    }
    
    /// Добавляет запись истории счетчика
    private func addHistoryLine(_ line: String) {
        counterHistory.append(line)
        updateHistoryView()
    }
    
    /// Добавляет начальную запись истории
    private func addInitialHistoryLine() { addHistoryLine("История изменений") }
    
    /// Добавляет запись истории об увеличении счетчика
    private func addPlusHistoryLine() { addHistoryLine(plusHistoryLine()) }
    
    /// Добавляет запись истории об уменьшении счетчика
    private func addMinusHistoryLine() { addHistoryLine(minusHistoryLine()) }
    
    /// Добавляет запись истории о неуспешном уменьшении счетчикаб приводившему к выходу в отрицательные числа
    private func addMinusOverflowHistoryLine() { addHistoryLine(minusOverflowHistoryLine()) }
    
    /// Добавляет запись истории о сбросе счетчика
    private func addResetHistoryLine() { addHistoryLine(resetHistoryLine()) }
    
    /// Текущая дата в виде строки в нужном формате
    private var dateNowAsString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormater.string(from: Date.now)
    }
    
    /// Текст для записи истории об увеличении счетчика
    private func plusHistoryLine() -> String { "\(dateNowAsString): значение изменено на +1" }
    
    /// Текст для записи истории об успешном уменьшении счетчика
    private func minusHistoryLine() -> String { "\(dateNowAsString): значение изменено на -1" }
    
    /// Текст для записи истории о неуспешном уменьшении счетчика, которое приводило к выходу в отрицательные числа
    private func minusOverflowHistoryLine() -> String { "\(dateNowAsString): попытка уменьшить счётчик ниже 0" }
    
    /// Текст для записи истории о сбросе счетчика
    private func resetHistoryLine() -> String { "\(dateNowAsString): значение сброшено" }
    
    /// Обновляет отображение истории счетчика для пользователя
    private func updateHistoryView() { counterHistoryText.text = counterHistoryAsText }
}
