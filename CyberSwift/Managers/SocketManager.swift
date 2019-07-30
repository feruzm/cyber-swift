//
//  SocketManager.swift
//  CyberSwift
//
//  Created by Chung Tran on 04/07/2019.
//  Copyright © 2019 golos.io. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Starscream
import SwiftyJSON

public enum WebSocketEvent {
    case connected
    case disconnected(Error?)
    case message(String)
    case data(Data)
    case pong
}

public class SocketManager {
    // MARK: - Singleton
    public static let shared = SocketManager()
    private init() {
        socket.delegate = self
        retrieveSecret()
    }
    
    // MARK: - Properties
    let socket = WebSocket(url: URL(string: Config.gate_API_URL)!)
    
    let subject = PublishSubject<WebSocketEvent>()
    public let connected = BehaviorRelay<Bool>(value: false)
    let bag = DisposeBag()
    
    // MARK: - Methods
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
    func sendRequest(methodAPIType: RequestMethodAPIType) -> Single<ResponseAPIType> {
        if !socket.isConnected {
            connect()
            connected
                .filter {$0}
                .subscribe(onNext: {[weak self] _ in
                    self?.socket.write(string: methodAPIType.requestMessage!)
                })
                .disposed(by: bag)
        } else {
            socket.write(string: methodAPIType.requestMessage!)
        }
        return text
            .filter {self.compareMessageFromResponseText($0, to: methodAPIType.id)}
            .timeout(10, scheduler: MainScheduler.instance)
            .take(1)
            .asSingle()
            .map {try self.transformMessage($0, to: methodAPIType.methodAPIType)}
    }
    
    func retrieveSecret() {
        text
            .subscribe(onNext: { (text) in
                if let data = text.data(using: .utf8),
                    let json = try? JSON(data: data)
                {
                    
                    // Retrieve secret
                    if let secret = json["params"]["secret"].string {
                        Config.webSocketSecretKey = secret
                        self.connected.accept(true)
                    }
                }
            })
            .disposed(by: bag)
    }
    
    deinit {
        subject.onCompleted()
    }
}

extension SocketManager {
    // MARK: - Helpers
    /// Filter message
    fileprivate func compareMessageFromResponseText(_ text: String, to requestId: Int) -> Bool {
        guard let jsonData = text.data(using: .utf8),
            let json = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)) as? [String: Any],
            let id = json["id"] as? Int
            else {
                return false
        }
        
        return requestId == id
    }
    
    /// validate message
    fileprivate func validate(jsonData: Data) throws {
        guard let json = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)) as? [String: Any] else {
            throw ErrorAPI.invalidData(message: "Response Unsuccessful")
        }
        
        guard let _ = json["id"] as? Int else {
            // Get error
            let jsonDecoder = JSONDecoder()
            
            // Catch error
            if let responseAPIResultError = try? jsonDecoder.decode(ResponseAPIErrorResult.self, from: jsonData) {
                throw ErrorAPI.requestFailed(message: responseAPIResultError.error.message.components(separatedBy: "second.end(): ").last!)
            }
            
            // If no error matching
            throw ErrorAPI.invalidData(message: "Message Id not found")
        }
        
        return
    }
    
    /// Transform text message to object
    func transformMessage(_ text: String, to type: MethodAPIType) throws -> ResponseAPIType {
        Logger.log(message: "websocketDidReceiveMessage: \n\t\(text)", event: .severe)
        
        guard let jsonData = text.data(using: .utf8) else {
            throw ErrorAPI.invalidData(message: "Response Unsuccessful")
        }
        
        // Get messageId
        try validate(jsonData: jsonData)
        
        // Decode json
        let response = try type.decode(from: jsonData)
        
        return response
    }
}
