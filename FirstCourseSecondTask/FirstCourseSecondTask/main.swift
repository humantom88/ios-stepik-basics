//
//  main.swift
//  FirstCourseSecondTask
//
//  Copyright © 2017 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseSecondTaskChecker


let checker = Checker()

/// Передайте в этот метод функцию, вычисляющую количество четных и нечетных чисел в массиве.
/// На вход она должна принимать массив целых чисел, а возвращать кортеж из двух значений.
/// Первое - количество четных чисел, второе - нечетных. Если ваше решение окажется
/// правильным то в консоли вы увидите часть кодового слова.
func firstFunction (array: [Int]) -> (Int, Int) {
    return array.reduce((0, 0)) {
        intermediateResult, anotherElement in
        if (anotherElement % 2 == 0) {
            return (intermediateResult.0 + 1, intermediateResult.1)
        } else {
            return (intermediateResult.0, intermediateResult.1 + 1)
        }
    }
}

checker.checkFirstFunction(function: firstFunction)


func secondFunction(arrayOfCircles: [Checker.Circle]) -> [Checker.Circle] {
    var whites: [Checker.Circle] = [];
    var blues: [Checker.Circle] = [];
    let others = arrayOfCircles
        .compactMap({
            (circle: Checker.Circle) -> Checker.Circle? in
            switch(circle.color) {
            case .red:
                return nil
            case .black:
                return Checker.Circle(radius: circle.radius * 2, color: circle.color)
            case .green:
                blues.append(Checker.Circle(radius: circle.radius, color: Checker.Color.blue))
                return nil
            case .white:
                whites.append(circle)
                return nil
            case .blue:
                blues.append(circle)
                return nil
            }
        })
    return whites + others + blues
}


/// Передайте в этот метод функцию, преобразующую массив окружностей по следующему алгоритму:
/// белые окружности должны быть первыми
/// радиус черных должен быть увеличен в 2 раза
/// красные нужно убрать из результата
/// зеленые перекрасить в синие
/// затем разместить синие в конце массива
/// Если не указано иное, то порядок окружностей должен сохраняться.
/// Если ваше решение окажется правильным то в консоли вы увидите еще одну часть кодового слова.
checker.checkSecondFunction(function: secondFunction)


func thirdFunction (employees: [Checker.EmployeeData]) -> [Checker.Employee] {
    /// Словарь в котором хранятся данные о сотруднике в виде:
    ///
    ///    {
    ///       "fullName": String,
    ///       "salary": String,
    ///       "company": String
    ///    }
    
    return employees.compactMap {
        value in
        
        let fullName: String? = value["fullName"]
        let salary: String? = value["salary"]
        let company: String? = value["company"]
        
        if (fullName == nil || salary == nil || company == nil || value.capacity > 3) {
            return nil
        }
        
        let result = Checker.Employee(
            fullName: fullName!,
            salary: salary!,
            company: company!
        )
        
        print(result)
        
        return result
    }
}
/// Передайте в этот метод функцию которая преобразует массив словарей в структуры Employee.
/// Порядок сотрудников должен остаться тем же. При этом если формат данных не совпадает с
/// указанным выше, то такой словарь должен отбрасываться. Если ваше решение окажется правильным
/// то в консоли вы увидите еще одну часть кодового слова.
checker.checkThirdFunction(function: thirdFunction)


func fourthFunction (names: [String]) -> [String: [String]] {
    let result = names.reduce([String: [String]]()) {
        acc, name in

        let firstLetter = String(name.first!).uppercased()
        let letterIndex: DictionaryIndex? = acc.index(forKey: "\(firstLetter)")
        
        var newAcc = acc
        
        if let nonOptionalLetterIndex = letterIndex {
            var letterArray = acc[nonOptionalLetterIndex].value
            letterArray.append(name)
            newAcc.updateValue(letterArray.sorted(by: >), forKey: firstLetter)
        } else {
            newAcc[firstLetter] = [name]
        }
        
        return newAcc
        }
        .filter { (key: String, value: [String]) -> Bool in
            return value.count >= 2
        }
    print(result)
    return result
}

/// Передайте в этот метод функцию, принимающую массив имен и преобразующую его по алгоритму:
/// 1) Группирует имена в словарь, где ключем будет первая буква имен в виде String, а
/// значением - массив имен начинающихся с этой буквы.
/// Например: ["Вася", "Олег", "Вова"] -> ["В" : ["Вася", "Вова"], "О" : ["Олег"]]
/// 2) Убирает группы в которых меньше двух элементов.
/// 3) Сортирует элементы в каждой группе в обратном алфавитному порядке.
/// Если ваше решение окажется правильным, то в консоли вы увидите еще одну часть кодового слова.
/// - Parameter function: Ваше решение
checker.checkFourthFunction(function: fourthFunction)

