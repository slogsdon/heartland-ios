//
//  HpsC2xDevice.swift
//  Heartland-iOS-SDK
//
//  Created by Shane Logsdon on 2/7/21.
//

import Foundation

@objcMembers
public class HpsC2xDevice: NSObject, GMSClientAppDelegate, IC2xDeviceInterface {
    public var config: HpsConnectionConfig?
    public var gmsWrapper: GMSWrapper?
    public var deviceDelegate: HpsC2xDeviceDelegate?
    public var transactionDelegate: HpsC2xTransactionDelegate?
    public var peripherals: NSMutableArray?
    
    public required override init() {
        super.init()
        self.peripherals = NSMutableArray()
    }
    
    public static func initWithConfig(_ config: HpsConnectionConfig) -> Self {
        let result = self.init()
        result.config = config
        return result
    }
    
    public func initialize() {
        print("HpsC2xDevice: initialize")
        self.gmsWrapper = GMSWrapper(GMSConfiguration.fromHpsConnectionConfig(self.config!), delegate:self)
        self.scan()
    }
    
    public func scan() {
        print("HpsC2xDevice: scan")
        if let wrapper = self.gmsWrapper {
            wrapper.searchDevices()
        }
    }

    public func stopScan() {
        print("HpsC2xDevice: stopScan")
        if let wrapper = self.gmsWrapper {
            wrapper.cancelSearch()
        }
    }
    public func getDeviceInfo() {}
    public func connectDevice(_ device: HpsTerminalInfo) {
        print("HpsC2xDevice: connectDevice")
        if let wrapper = self.gmsWrapper {
            wrapper.connectDevice(device)
        }
    }
    public func processTransactionWithRequest(_ builder: HpsC2xBaseBuilder, withTransactionType transactionType: HpsTransactionType) {
        print("HpsC2xDevice: processTransactionWithRequest")
        if let wrapper = self.gmsWrapper {
            wrapper.startTransaction(builder, withTransactionType: transactionType)
        }
    }
    public func confirmAmount(_ amount: Decimal) {
        print("HpsC2xDevice: confirmAmount")
        if let wrapper = self.gmsWrapper {
            wrapper.confirmAmount(amount: amount)
        }
    }

    // mark: GMSClientAppDelegate

    public func deviceConnected() {
        print("HpsC2xDevice: deviceConnected")
        self.deviceDelegate?.onConnected() //:(HpsTerminalInfo *)terminalInfo];
    }

    public func deviceDisconnected() {
        print("HpsC2xDevice: deviceDisconnected")
        self.deviceDelegate?.onDisconnected()
    }

    public func searchComplete() {
        print("HpsC2xDevice: searchComplete")
        self.deviceDelegate?.onBluetoothDeviceList(self.peripherals ?? [])
    }

    public func deviceFound(_ device: NSObject) {
        print("HpsC2xDevice: deviceFound")
        if let peripherals = self.peripherals {
            peripherals.add(device)
        }
    }

    public func onStatus(_ status: HpsTransactionStatus) {
        print("HpsC2xDevice: onStatus")
        self.transactionDelegate?.onStatusUpdate(status)
    }


    public func onTransactionCancelled() {
        print("HpsC2xDevice: onTransactionCancelled")
    }


    public func onTransactionComplete(_ result: String, response: HpsTerminalResponse) {
        print("HpsC2xDevice: onTransactionComplete")
        print(result)
        self.transactionDelegate?.onTransactionComplete(response)
    }


    public func requestAIDSelection(_ applications: Array<AID>) {
        print("HpsC2xDevice: requestAIDSelection")
    }


    public func requestAmountConfirmation(_ amount: Decimal) {
        print("HpsC2xDevice: requestAmountConfirmation")
        self.transactionDelegate?.onConfirmAmount(amount)
    }


    public func requestPostalCode(_ maskedPan: String, expiryDate: String, cardholderName: String) {
        print("HpsC2xDevice: requestPostalCode")
    }


    public func requestSaFApproval() {
        print("HpsC2xDevice: requestSaFApproval")
    }

    public func onError(_ error: NSError) {
        print("HpsC2xDevice: onError")
        self.transactionDelegate?.onError(error)
    }
}
