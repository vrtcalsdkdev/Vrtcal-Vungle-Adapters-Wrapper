import Vrtcal_Adapters_Wrapper_Parent
import VungleSDK

// Must be NSObject for VungleSDKDelegate
class VrtcalVungleAdaptersWrapper: NSObject, AdapterWrapperProtocol {
    
    var appLogger: Logger
    var sdkEventsLogger: Logger
    var delegate: AdapterWrapperDelegate
    
    required init(
        appLogger: Logger,
        sdkEventsLogger: Logger,
        delegate: AdapterWrapperDelegate
    ) {
        self.appLogger = appLogger
        self.sdkEventsLogger = sdkEventsLogger
        self.delegate = delegate
    }
    
    func initializeSdk() {
        appLogger.log()
        
        do {
            VungleSDK.shared().delegate = self
            // Note: This is TwitMore's appId
            // https://publisher.vungle.com/applications/update/application/627c5502a9cf1e63b8e6137d
            try VungleSDK.shared().start(withAppId: "627c5502a9cf1e63b8e6137d")
        } catch {
            sdkEventsLogger.log("Error starting vungle: \(error)")
        }
    }
    
    func handle(vrtcalAsSecondaryConfig: VrtcalAsSecondaryConfig) {
        
        switch vrtcalAsSecondaryConfig.placementType {
                
            case .banner:
                appLogger.log()
                
            case .interstitial:
                appLogger.log()
                
            case .rewardedVideo:
                sdkEventsLogger.log()
                
            case .showDebugView:
                sdkEventsLogger.log()
        }
    }
    
    func showInterstitial() -> Bool {
        false
    }
}

extension VrtcalVungleAdaptersWrapper: VungleSDKDelegate {
    func vungleSDKDidInitialize() {
        appLogger.log()
        sdkEventsLogger.log("vungleSDKDidInitialize")
    }
    
    func vungleSDKFailedToInitializeWithError(_ error: Error) {
        appLogger.log("error: \(error)")
        sdkEventsLogger.log("vungleSDKFailedToInitializeWithError: \(error)")
    }
}
