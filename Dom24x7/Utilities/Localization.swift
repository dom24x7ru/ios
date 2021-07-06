//
//  Localization.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 17.04.2021.
//

import Foundation

class Localization {
    
    /* label */
    public static var chats: String!
    public static var feed: String!
    public static var neighbors: String!
    public static var or: String!
    public static var other: String!
    public static var register: String!
    public static var signIn: String!
    public static var submit: String!
    
    /* text */
    public static var enterInviteCode: String!
    public static var invalidFormat: String!
    public static var noMessagesHereYet: String!
    public static var noTitle: String!
    public static var phoneNumbersMustBeIdentical: String!
    public static var retypeYourPhoneNumber: String!
    public static var smsCode: String!
    public static var unknownError: String!
    public static var yourPhoneNumber: String!
    
    /* array */
    public static var weekdaySymbols: [String]!
    
    
    public static func initialize() {
        setRussian()
    }
    
    private static func setRussian() {
        /* label */
        chats = "Чаты"
        feed = "Лента"
        neighbors = "Соседи"
        or = "или"
        other = "Прочее"
        register = "Зарегистрироваться"
        signIn = "Войти"
        submit = "Отправить"
        
        /* text */
        enterInviteCode = "Введите код приглашения"
        invalidFormat = "Неверный формат"
        noMessagesHereYet = "Здесь пока нет сообщений"
        noTitle = "Без названия"
        phoneNumbersMustBeIdentical = "Номера телефона должны совпадать"
        retypeYourPhoneNumber = "Повторно ваш номер телефона"
        smsCode = "СМС код"
        unknownError = "Неизвестная ошибка"
        yourPhoneNumber = "Ваш номер телефона"
        
        /* array */
        weekdaySymbols = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    }

}
