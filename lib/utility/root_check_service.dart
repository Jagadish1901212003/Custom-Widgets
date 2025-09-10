import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';

class RootCheck {
  static const _androidChannel = MethodChannel(
    'gov.ab.ca.ohsdev.security/root',
  );
  static const _iosChannel = MethodChannel('security_checks');

  /// Runs full security checks: root/jailbreak, Frida, hooks, emulator, etc.
  static Future<bool> runSecurityCheckAndExitIfViolated() async {
    // if (kDebugMode) {
    //   print('⚠️ Skipping security checks in debug mode');
    //   return true;
    // }
    try {
      if (Platform.isAndroid) {
        // ✅ Native side returns true if any tampering or root detected
        final bool isTampered = await _androidChannel.invokeMethod('isRooted');
        final bool isEmulator = await _androidChannel.invokeMethod(
          'checkEmulator',
        );
        final String offendingFile = await _getOffendingRootFile();

        if (offendingFile.isNotEmpty) {
          print("🚨 Offending root file found: $offendingFile");
        }

        print("✅ Root Tampered: $isTampered");
        print("✅ Emulator: $isEmulator");

        if (isTampered || isEmulator) {
          print("❌ Security violation detected. Exiting app.");
          exit(0);
        }

        return true;
      } else if (Platform.isIOS) {
        // ✅ Jailbreak check (via plugin)

        final bool jailbroken =
            await _iosChannel.invokeMethod<bool>('isJailbroken') ?? false;

        // ✅ Native checks via Swift

        final bool hasFrida =
            await _iosChannel.invokeMethod<bool>('hasSuspiciousDylibs') ??
                false;
        final bool isSwizzlingDetected =
            await _iosChannel.invokeMethod<bool>('isSwizzlingDetected') ??
                false;
        final bool isEmulator =
            await _iosChannel.invokeMethod<bool>('isRunningOnEmulator') ??
                false;

        // Additional checks

        final bool isForkRestricted =
            await _iosChannel.invokeMethod<bool>('isForkRestricted') ?? false;

        final bool isRuntimeSwizzlingDetected =
            await _iosChannel.invokeMethod<bool>(
                  'isRuntimeSwizzlingDetected',
                ) ??
                false;

        final bool isDLAddrHooked =
            await _iosChannel.invokeMethod<bool>('isDLAddrHooked') ?? false;

        // Native

        final bool isHooked =
            await _iosChannel.invokeMethod('isHookDetected') ?? false;

        final bool isSecLayerC03Valid =
            await _iosChannel.invokeMethod('isSecLayerC03Valid') ?? false;

        final bool isRWXRegionDetected =
            await _iosChannel.invokeMethod('isRWXRegionDetected') ?? false;

        final bool isTraced =
            await _iosChannel.invokeMethod('isBeingTraced') ?? false;
        final bool isHoneypotTriggered =
            await _iosChannel.invokeMethod<bool>('isHoneypotTriggered') ??
                false;

        final bool isProcSelfTampered =
            await _iosChannel.invokeMethod<bool>('isProcSelfTampered') ?? false;
        final bool hasSuspiciousEntitlements =
            await _iosChannel.invokeMethod<bool>('hasSuspiciousEntitlements') ??
                false;

        final bool isForkDetected =
            await _iosChannel.invokeMethod<bool>('isForkDetected') ?? false;
        final bool isDYLDInjected =
            await _iosChannel.invokeMethod<bool>('isDYLDInjected') ?? false;
        final bool isSyscallTampered =
            await _iosChannel.invokeMethod<bool>('isSyscallTampered') ?? false;

        final bool isMachOValid =
            await _iosChannel.invokeMethod<bool>('isMachOValid') ?? false;

        final bool isSandboxViolated =
            await _iosChannel.invokeMethod<bool>('isSandboxViolated') ?? false;

        final bool isSuspiciousThreadFound =
            await _iosChannel.invokeMethod<bool>('isSuspiciousThreadFound') ??
                false;

        // final bool isSecLayerC09Valid =
        //     await _iosChannel.invokeMethod<bool>('isSecLayerC09Valid') ?? false;

        print("✅ iOS Jailbroken: $jailbroken");
        print("✅ Suspicious Dylibs (Frida): $hasFrida");
        print("✅ Hook Detected (Swizzling): $isSwizzlingDetected");
        print("✅ Emulator: $isEmulator");

        print("✅ isForkRestricted: $isForkRestricted");
        print("✅ isRuntimeSwizzlingDetected: $isRuntimeSwizzlingDetected");
        print("✅ isDLAddrHooked: $isDLAddrHooked");

        //native
        print("✅ isSyscallTampered: $isSyscallTampered");
        print("✅ isHooked: $isHooked");
        print("✅ isSecLayerC03Valid: $isSecLayerC03Valid");
        print("✅ isRWXRegionDetected: $isRWXRegionDetected");

        print("✅ isBeingTraced: $isTraced");
        print("✅ Honeypot Accessed: $isHoneypotTriggered");
        print("✅ isProcSelfTampered: $isProcSelfTampered");
        print("✅ hasSuspiciousEntitlements: $hasSuspiciousEntitlements");

        print("✅ isForkDetected: $isForkDetected");
        print("✅ isDYLDInjected: $isDYLDInjected");
        print("✅ isMachOValid: $isMachOValid");
        print("✅ isSandboxViolated: $isSandboxViolated");
        print("✅ isSuspiciousThreadFound: $isSuspiciousThreadFound");
        // print("✅ isSecLayerC09Valid: $isSecLayerC09Valid");

        if (jailbroken ||
                //isDebugged ||
                hasFrida ||
                isSwizzlingDetected ||
                isEmulator ||
                !isForkRestricted ||
                isRuntimeSwizzlingDetected || //-------> issue is should be FALSE 111
                isDLAddrHooked ||
                isSyscallTampered ||
                isHooked ||
                !isSecLayerC03Valid ||
                isRWXRegionDetected ||
                isTraced ||
                isHoneypotTriggered ||
                isProcSelfTampered ||
                hasSuspiciousEntitlements ||
                isForkDetected ||
                isDYLDInjected || //-------> issue is should be FALSE.  111
                !isMachOValid ||
                isSandboxViolated ||
                isSuspiciousThreadFound
            //!isSecLayerC09Valid //-------> issue is should be TRUE
            ) {
          print("❌ iOS Security violation detected. Exiting app.");
          exit(0);
        }
        return true;
      } else {
        return true; // Safe fallback for other platforms
      }
    } catch (e) {
      print("❌ Security check failed: $e");
      exit(0); // Failsafe exit
    }
  }

  /// Android only: Fetch the offending root binary file (if any)
  static Future<String> _getOffendingRootFile() async {
    try {
      final String filePath = await _androidChannel.invokeMethod(
        'checkRootBinaries',
      );
      return filePath;
    } catch (e) {
      print("⚠️ Failed to get offending file: $e");
      return '';
    }
  }
}
