import Foundation
import GlobalMobileSDK

@objcMembers
public class GMSConfiguration: NSObject {
    private var config: HpsConnectionConfig?
    
    public override init() {
    }

    public init(config: HpsConnectionConfig) {
        self.config = config
    }

    public func asPorticoConfig() -> PorticoConfig {
        var config = PorticoConfig()
        if let c = self.config {
            config.username = c.username
            config.password = c.password
            config.licenseId = c.licenseID
            config.siteId = c.siteID
            config.deviceId = c.deviceID
            config.developerId = c.developerID
            config.versionNumber = c.versionNumber
            config.environment = c.isProduction ? .production : .certification
        }
        config.merchantName = ""
        config.merchantNumber = ""
        config.merchantAddress = ""
        config.acknowledgement = ""
        config.signatureAgreement = ""
        config.terminalType = .bbpos_c2x
        return config
    }
    
    public static func fromHpsConnectionConfig(_ config: HpsConnectionConfig) -> GMSConfiguration {
        return GMSConfiguration(config: config)
    }
}
