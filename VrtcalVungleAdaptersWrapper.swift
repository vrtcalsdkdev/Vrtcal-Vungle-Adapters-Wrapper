import Vrtcal_Adapters_Wrapper_Parent
import VungleSDK

// Must be NSObject for VungleSDKDelegate
class VrtcalVungleAdaptersWrapper: NSObject, AdapterWrapperProtocol {
    
    var appLogger: Logger
    var sdkEventsLogger: Logger
    var sdk = SDK.vungle
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
        do {
            VungleSDK.shared().delegate = self
            // Note: This is TwitMore's appId
            // https://publisher.vungle.com/applications/update/application/627c5502a9cf1e63b8e6137d
            try VungleSDK.shared().start(withAppId: "627c5502a9cf1e63b8e6137d")
        } catch {
            sdkEventsLogger.log("Error starting vungle: \(error)")
        }
    }
    
    func handle(adTechConfig: AdTechConfig) {
        sdkEventsLogger.log("Vungle does not support Vungle-As-Primary mediation.")
    }
    
    func showInterstitial() -> Bool {
        false
    }
    
    func destroyInterstitial() {

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
