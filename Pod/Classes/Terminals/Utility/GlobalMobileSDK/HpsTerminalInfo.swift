import Foundation
import GlobalMobileSDK

@objc
public class HpsTerminalInfo: NSObject {
    internal var gmsTerminalInfo: GMSTerminalInfo
    
    required init(name: String, description: String, connected: Bool, terminalType: String, identifier: UUID) {
        var type: TerminalType
        if let t = TerminalType(rawValue: terminalType) {
            type = t
        } else {
            type = .none
        }
        self.gmsTerminalInfo = GMSTerminalInfo(name: name, description: description, connected: connected, terminalType: type, identifier: identifier)
    }
    
    init(fromTerminalInfo terminalInfo: TerminalInfo) {
        self.gmsTerminalInfo = terminalInfo as! GMSTerminalInfo
    }
}
