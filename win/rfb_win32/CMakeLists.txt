include_directories(${CMAKE_SOURCE_DIR}/common)

set(RFB_WIN32_SOURCES
    AboutDialog.cxx
    LaunchProcess.cxx
    SInput.cxx
    CKeyboard.cxx
    LowLevelKeyEvents.cxx
    SocketManager.cxx
    MonitorInfo.cxx
    TCharArray.cxx
    Clipboard.cxx
    MsgWindow.cxx
    Threading.cxx
    CPointer.cxx
    OSVersion.cxx
    TsSessions.cxx
    CurrentUser.cxx
    RegConfig.cxx
    Win32Util.cxx
    DeviceContext.cxx
    Registry.cxx
    WMCursor.cxx
    DeviceFrameBuffer.cxx
    SDisplay.cxx
    WMHooks.cxx
    Dialog.cxx
    SDisplayCorePolling.cxx
    WMNotifier.cxx
    DIBSectionBuffer.cxx
    SDisplayCoreWMHooks.cxx
    WMPoller.cxx
    DynamicFn.cxx
    Security.cxx
    WMShatter.cxx
    EventManager.cxx
    Service.cxx
    WMWindowCopyRect.cxx
)

if(BUILD_WINVNC)
  set(RFB_WIN32_SOURCES ${RFB_WIN32_SOURCES} CleanDesktop.cxx)
endif()

add_library(rfb_win32 STATIC ${RFB_WIN32_SOURCES})

target_link_libraries(rfb_win32 user32.lib comctl32.lib version.lib)
