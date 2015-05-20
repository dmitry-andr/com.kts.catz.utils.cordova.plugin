#!/bin/bash
echo ">>>HOOK - Processing custom plugin com.kts.cordova.catz_utils.plugin "
echo “Current directory : “ $(pwd)

echo "Remomving Custom plugin";
cordova plugin rm com.kts.cordova.catz_utils.plugin

echo "Installing the latest plugin source code";
cordova plugin add ./custom_plugins_src/com.kts.catz.utils --variable BILLING_KEY="MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAr+0wKgD7K3bVR2K6hAIvVRR235EczB16n5to5579oWPX82Qgt7cUNcmpz+/r/6AFm8NV7clHd9RwKgXlCXWg0oEbyvNvpdi5rrvkRq7yJ2BFh2HGiOfqxAvWTTTBP5sIrzk8nGDm4UNCihEcSxuBP9G/jrmQ4ShBG0aWSAOtvoBrQTDkfP8ZqTtV5xGltlFFuIjh+bxAcGkLzfdRQ5qSsNO7dmHu54fUmatnYE07YGJAFUZC+ZbL/zfvTaYSkkP7wrXslPGxbjx4ZcR8mkEfLJAgtJB8pKDyS0PlWqJnyVX+1CzvoWLcNj0mCjOty4WT09bzEskYqV6WcguiO+Ag8QIDAQAB"



echo ">>>FINISHED HOOK - Processing custom plugin com.kts.cordova.catz_utils.plugin "




