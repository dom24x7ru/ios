//
//  Localization.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 17.04.2021.
//

import Foundation

class Localization {
    
    /* label */
    public static var available: String!
    public static var chats: String!
    public static var documents: String!
    public static var faq: String!
    public static var feed: String!
    public static var flat: String!
    public static var flatShort: String!
    public static var flats: String!
    public static var floor: String!
    public static var floors: String!
    public static var instructions: String!
    public static var invitations: String!
    public static var logout: String!
    public static var midname: String!
    public static var name: String!
    public static var neighbors: String!
    public static var of: String!
    public static var or: String!
    public static var other: String!
    public static var persons: String!
    public static var populated: String!
    public static var profile: String!
    public static var recommendations: String!
    public static var register: String!
    public static var rooms: String!
    public static var save: String!
    public static var section: String!
    public static var signIn: String!
    public static var size: String!
    public static var submit: String!
    public static var surname: String!
    public static var voting: String!
    public static var unknown: String!
    
    /* text */
    public static var contactsDisplay: String!
    public static var enterInviteCode: String!
    public static var flatNumber: String!
    public static var hiddenByUser: String!
    public static var invalidFormat: String!
    public static var nameDisplay: String!
    public static var noMessagesHereYet: String!
    public static var noTitle: String!
    public static var notSpecified: String!
    public static var phoneNumbersMustBeIdentical: String!
    public static var privacySettings: String!
    public static var retypeYourPhoneNumber: String!
    public static var showPhoneNumber: String!
    public static var showTelegramAccount: String!
    public static var smsCode: String!
    public static var squareMeter: String!
    public static var telegramAccount: String!
    public static var unknownError: String!
    public static var yourPhoneNumber: String!
    
    /* array */
    public static var nameDisplayOptions: [String]!
    public static var weekdaySymbols: [String]!
    
    
    public static func initialize() {
        setRussian()
    }
    
    private static func setRussian() {
        /* label */
        available = "Доступно"
        chats = "Чаты"
        documents = "Документы"
        faq = "Вопросы-Ответы"
        feed = "Лента"
        flat = "Квартира"
        flatShort = "Кв."
        flats = "Квартиры"
        floor = "Этаж"
        floors = "Этажей"
        instructions = "Инструкции"
        invitations = "Приглашения"
        logout = "Выйти"
        midname = "Отчество"
        name = "Имя"
        neighbors = "Соседи"
        of = "из"
        or = "или"
        other = "Прочее"
        persons = "Жильцов"
        populated = "Заселено"
        profile = "Профиль"
        recommendations = "Рекомендации"
        register = "Зарегистрироваться"
        rooms = "Комнат"
        save = "Сохранить"
        section = "Подъезд"
        signIn = "Войти"
        size = "Размер"
        submit = "Отправить"
        surname = "Фамилия"
        voting = "Голосование"
        unknown = "Неизвестно"
        
        /* text */
        contactsDisplay = "Отображение контактов"
        enterInviteCode = "Введите код приглашения"
        flatNumber = "Номер квартиры"
        hiddenByUser = "Скрыто пользователем"
        invalidFormat = "Неверный формат"
        nameDisplay = "Отображение имени"
        noMessagesHereYet = "Здесь пока нет сообщений"
        noTitle = "Без названия"
        notSpecified = "Не указан"
        phoneNumbersMustBeIdentical = "Номера телефона должны совпадать"
        privacySettings = "Настройки приватности"
        retypeYourPhoneNumber = "Повторно ваш номер телефона"
        showPhoneNumber = "Показывать номер телефона"
        showTelegramAccount = "Показывать telegram аккаунт (если указан)"
        smsCode = "СМС код"
        squareMeter = "кв.м."
        telegramAccount = "Аккаунт в Telegram"
        unknownError = "Неизвестная ошибка"
        yourPhoneNumber = "Ваш номер телефона"
        
        /* array */
        nameDisplayOptions = ["Не показывать имя", "Показывать только имя", "Показывать полностью"]
        weekdaySymbols = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    }

}
