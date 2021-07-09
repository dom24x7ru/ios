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
    
    public static var sections = IClientData<[Int: SectionObject]>([:])
    
    public static var user = IClientData<UserObject>()
    
    public static var votes = IClientData<[VoteObject]>([])
    
    
    public static func setSections() {
        for item in flats.data {
            let persons = item.residents?.count ?? 0
            let populated = persons == 0 ? 0 : 1
            
            if sections.data.keys.contains(item.section) {
                if sections.data[item.section]!.floors.keys.contains(item.floor) {
                    sections.data[item.section]!.floors[item.floor]!.flats.append(item)
                    
                    sections.data[item.section]!.floors[item.floor]!.flatMin = min(item.number, sections.data[item.section]!.floors[item.floor]!.flatMin)
                    sections.data[item.section]!.floors[item.floor]!.flatMax = max(item.number, sections.data[item.section]!.floors[item.floor]!.flatMax)
                    sections.data[item.section]!.floors[item.floor]!.flatsCount = sections.data[item.section]!.floors[item.floor]!.flatMax - sections.data[item.section]!.floors[item.floor]!.flatMin + 1
                    sections.data[item.section]!.floors[item.floor]!.populated += populated
                    sections.data[item.section]!.floors[item.floor]!.persons += persons
                } else {
                    sections.data[item.section]!.floors[item.floor] = FloorObject(flats: [item], flatMin: item.number, flatMax: item.number, flatsCount: 1, populated: populated, persons: persons)
                }
                
                sections.data[item.section]!.floorsCount = max(item.floor, sections.data[item.section]!.floorsCount)
                sections.data[item.section]!.flatMin = min(item.number, sections.data[item.section]!.flatMin)
                sections.data[item.section]!.flatMax = max(item.number, sections.data[item.section]!.flatMax)
                sections.data[item.section]!.flatsCount = sections.data[item.section]!.flatMax - sections.data[item.section]!.flatMin + 1
                sections.data[item.section]!.populated += populated
                sections.data[item.section]!.persons += persons
            } else {
                let floor = [item.floor : FloorObject(flats: [item], flatMin: item.number, flatMax: item.number, flatsCount: 1, populated: populated, persons: persons)]
                sections.data[item.section] = SectionObject(floors: floor, floorsCount: 1, flatMin: item.number, flatMax: item.number, flatsCount: 1, populated: populated, persons: persons)
            }
        }
    }
    
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
