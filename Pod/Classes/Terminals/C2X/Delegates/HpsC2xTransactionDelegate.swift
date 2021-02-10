import Foundation

@objc
public protocol HpsC2xTransactionDelegate {
    func onStatusUpdate(_ transactionStatus: HpsTransactionStatus)
    func onConfirmAmount(_ amount: Decimal)
//    func onCardholderInteractionRequested(_ request: HpsCardholderInteractionRequest)
    func onTransactionComplete(_ response: HpsTerminalResponse)
    func onError(_ error: NSError)
}


