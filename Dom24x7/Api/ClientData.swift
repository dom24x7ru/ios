//
//  ClientData.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 27.04.2021.
//

import Foundation

class ClientData {
    
    public static var documents = IClientData<[DocumentObject]>([])
    
    public static var faq = IClientData<[FaqObject]>([])
    
    public static var flats = IClientData<[FlatObject]>([])
    
    public static var house = IClientData<HouseObject>()
    
    public static var imChannels = IClientData<[IMChannelObject]>([])
    
    public static var imMessages = IClientData<[Int: [IMMessage]]>([:])
    
    public static var instructions = IClientData<[InstructionObject]>([])
    
    public static var invites = IClientData<[InviteObject]>([])
    
    public static var pinnedPosts = IClientData<[PostObject]>([])
    
    public static var posts = IClientData<[PostObject]>([])
    
    public static var recommendations = IClientData<[RecomendationObject]>([])
    
    public static var user = IClientData<UserObject>()
    
    public static var votes = IClientData<[VoteObject]>([])
    
}

class IClientData<T> {
    
    private var isUpdated: Bool = false
    
    public var onUpdate: Runnable? {
        didSet {
            if isUpdated {
                isUpdated = false
                onUpdate?()
            }
        }
    }
    
    public var data: T! {
        didSet {
            isUpdated = true
            onUpdate?()
        }
    }
    
    init(_ defaultValue: T! = nil) {
        data = defaultValue
    }
    
}
