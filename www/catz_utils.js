/*global cordova, module*/

module.exports = {
    checkPlugin: function (messageForPlugin, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatzUtilPlugin", "checkPlugin", [messageForPlugin]);
    },
	initBillingModule: function (skuList, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatzUtilPlugin", "initBillingModule", [skuList]);
    },
	billingGetPurchases: function (skuList, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatzUtilPlugin", "billingGetPurchases", [skuList]);
    },
	billingGetProductDetails: function (skuList, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatzUtilPlugin", "billingGetProductDetails", [skuList]);
    },
	billingPurchaseProduct: function (skuList, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatzUtilPlugin", "billingPurchaseProduct", [skuList]);
    },
	billingConsumeProduct: function (skuList, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "CatzUtilPlugin", "consumeProduct", [skuList]);
    }
};
