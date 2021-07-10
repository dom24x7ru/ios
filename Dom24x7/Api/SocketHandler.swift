//
//  SocketHandler.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 03.04.2021.
//

import Foundation
import ScClient

class SocketHandler {
    
    private static var client: ScClient!
    private static let host = "https://dom24x7-backend-test.nl.yapahost.ru/socketcluster/"
    
    
    public static func initialize() {
        client = ScClient(url: host, authToken: Preferences.getAuthToken())
        
        let onConnectError = { (client: ScClient, error: Error?) in
            //print(error)
            client.connect()
        }
        
        let onDisconnect = { (client: ScClient, error: Error?) in
            //print(error)
            client.connect()
        }
        
        let onSetAuthentication = { (client: ScClient, token: String?) in
            self.setAuthToken(token!)
        }
        
        client.setAuthenticationListener(onSetAuthentication: onSetAuthentication, onAuthentication: nil)
        client.setBasicListener(onConnect: nil, onConnectError: onConnectError, onDisconnect: onDisconnect)
        client.connect()
    }
    
    public static func isAuthorized() -> Bool {
        return client.getAuthToken() != nil
    }
    
    public static func setAuthToken(_ token: String) {
        Preferences.saveAuthToken(token)
    }
    
    public static func subscribeToAll() {
        let userId = Preferences.getUserData().id
        
        client.waitTillConnect()
        subscribeToUser(userId)
        subscribeToPinnedPosts()
        subscribeToPosts()
        subscribeToIMChannels(userId)
        subscribeToHouse()
        subscribeToFlats()
        subscribeToInvites(userId)
        subscribeToVotes(userId)
        subscribeToInstructions()
        subscribeToDocuments()
        subscribeToFaq()
        subscribeToRecomendations()
    }
    
    // MARK: Update callbacks
    
    private static func subscribeToDocuments() {
        client.subscribe(channelName: "documents")
        client.onChannel(channelName: "documents", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.documents.data.append(JSONDecoder.decode(DocumentObject.self, from: objectAny))
            }
        })
    }
    
    private static func subscribeToFaq() {
        client.subscribe(channelName: "faq")
        client.onChannel(channelName: "faq", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.faq.data.append(JSONDecoder.decode(FaqObject.self, from: objectAny))
            }
        })
    }
    
    private static func subscribeToFlats() {
        client.subscribe(channelName: "flats")
        client.onChannel(channelName: "flats", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.flats.data.append(JSONDecoder.decode(FlatObject.self, from: objectAny))
            } else {
                ClientData.setSections()
            }
        })
    }
    
    private static func subscribeToHouse() {
        client.subscribe(channelName: "house")
        client.onChannel(channelName: "house", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.house.data = JSONDecoder.decode(HouseObject.self, from: objectAny)
            }
        })
    }
    
    private static func subscribeToIMChannels(_ userId: Int) {
        client.subscribe(channelName: "imChannels.\(userId)")
        client.onChannel(channelName: "imChannels.\(userId)", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.imChannels.data.append(JSONDecoder.decode(IMChannelObject.self, from: objectAny))
            }
        })
    }
    
    public static func subscribeToIMMessages(_ channelId: Int) {
        client.subscribe(channelName: "imMessages.\(channelId)")
        client.onChannel(channelName: "imMessages.\(channelId)", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                if ClientData.imMessages.data.keys.contains(channelId) {
                    ClientData.imMessages.data[channelId]?.append(JSONDecoder.decode(IMMessage.self, from: objectAny))
                } else {
                    ClientData.imMessages.data[channelId] = [JSONDecoder.decode(IMMessage.self, from: objectAny)]
                }
            }
        })
    }
    
    private static func subscribeToInstructions() {
        client.subscribe(channelName: "instructions")
        client.onChannel(channelName: "instructions", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.instructions.data.append(JSONDecoder.decode(InstructionObject.self, from: objectAny))
            }
        })
    }
    
    private static func subscribeToInvites(_ userId: Int) {
        client.subscribe(channelName: "invites.\(userId)")
        client.onChannel(channelName: "invites.\(userId)", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.invites.data.append(JSONDecoder.decode(InviteObject.self, from: objectAny))
            }
        })
    }
    
    private static func subscribeToPinnedPosts() {
        client.subscribe(channelName: "pinnedPosts")
        client.onChannel(channelName: "pinnedPosts", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.pinnedPosts.data.append(JSONDecoder.decode(PostObject.self, from: objectAny))
            }
        })
    }
    
    private static func subscribeToPosts() {
        client.subscribe(channelName: "posts")
        client.onChannel(channelName: "posts", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.posts.data.append(JSONDecoder.decode(PostObject.self, from: objectAny))
            }
        })
    }
    
    private static func subscribeToRecomendations() {
        client.subscribe(channelName: "recomendations")
        client.onChannel(channelName: "recomendations", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.recommendations.data.append(JSONDecoder.decode(RecomendationObject.self, from: objectAny))
            }
        })
    }
    
    private static func subscribeToUser(_ userId: Int) {
        client.subscribe(channelName: "user.\(userId)")
        client.onChannel(channelName: "user.\(userId)", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.user.data = JSONDecoder.decode(UserObject.self, from: objectAny)
            }
        })
    }
    
    private static func subscribeToVotes(_ userId: Int) {
        client.subscribe(channelName: "votes.\(userId)")
        client.onChannel(channelName: "votes.\(userId)", ack: { (channelName: String, response: AnyObject?) in
            if let objectAny = (response as! Dictionary<String, AnyObject>)["data"] {
                ClientData.votes.data.append(JSONDecoder.decode(VoteObject.self, from: objectAny))
            }
        })
    }
    
    // MARK: Socket APIs
    
    public static func flatInfo(flatNumber: Int, then handler: @escaping ResultHandler) {
        let data = FlatInfoObject(flatNumber: flatNumber)

        client.emitAck(eventName: "flat.info", data: data as AnyObject, ack: { (_: String, errorObj: AnyObject?, dataObj: AnyObject?) in
            if errorObj != nil && !(errorObj is NSNull) {
                let error = JSONDecoder.decode(ErrorObject.self, from: errorObj)
                
                handler(.failure(error))
            } else if dataObj != nil {
                let response = JSONDecoder.decode([ResidentOwnerObject].self, from: dataObj)
                
                handler(.success(response))
            } else {
                handler(.failure(ErrorObject(code: "0", message: Localization.unknownError)))
            }
        })
    }
    
    public static func register(phoneNumber: String, invite: String, then handler: @escaping ResultHandler) {
        let data = SignInWithInviteObject(mobile: "7" + phoneNumber, invite: invite)

        client.emitAck(eventName: "user.auth", data: data as AnyObject, ack: { (_: String, errorObj: AnyObject?, dataObj: AnyObject?) in
            if errorObj != nil && !(errorObj is NSNull) {
                let error = JSONDecoder.decode(ErrorObject.self, from: errorObj)
                
                handler(.failure(error))
            } else if dataObj != nil {                
                let response = JSONDecoder.decode(StatusObject.self, from: dataObj)
                
                handler(.success(response))
            } else {
                handler(.failure(ErrorObject(code: "0", message: Localization.unknownError)))
            }
        })
    }
    
    public static func signIn(phoneNumber: String, then handler: @escaping ResultHandler) {
        let data = SignInWithInviteObject(mobile: "7" + phoneNumber, invite: nil)
        
        client.emitAck(eventName: "user.auth", data: data as AnyObject, ack: { (_: String, errorObj: AnyObject?, dataObj: AnyObject?) in
            if errorObj != nil && !(errorObj is NSNull) {
                let error = JSONDecoder.decode(ErrorObject.self, from: errorObj)

                handler(.failure(error))
            } else if dataObj != nil {
                let response = JSONDecoder.decode(StatusObject.self, from: dataObj)
                
                handler(.success(response))
            } else {
                handler(.failure(ErrorObject(code: "0", message: Localization.unknownError)))
            }
        })
    }
    
    public static func signIn(phoneNumber: String, code: String, then handler: @escaping ResultHandler) {
        let data = SignInWithCodeObject(mobile: "7" + phoneNumber, code: code)
        
        client.emitAck(eventName: "user.auth", data: data as AnyObject, ack: { (_: String, errorObj: AnyObject?, dataObj: AnyObject?) in
            if errorObj != nil && !(errorObj is NSNull) {
                let error = JSONDecoder.decode(ErrorObject.self, from: errorObj)

                handler(.failure(error))
            } else if dataObj != nil {
                let response = JSONDecoder.decode(UserObject.self, from: dataObj)

                handler(.success(response))
            } else {
                handler(.failure(ErrorObject(code: "0", message: Localization.unknownError)))
            }
        })
    }
    
}
