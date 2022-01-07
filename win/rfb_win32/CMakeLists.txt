# MinGW64 has header support but no library support for IActiveDesktop, so we
# need to check for both the header and library and use our own implementation
# in common/os if either doesn't exist.
if(WIN32)
    check_c_source_compiles("#include <windows.h>\n#include <wininet.h>\n#include <shlobj.h>\nint main(int c, char** v) {IActiveDesktop iad; (void)iad; return 0;}" HAVE_ACTIVE_DESKTOP_H)
    if(HAVE_ACTIVE_DESKTOP_H)
        list(APPEND RFB_WIN32_DEFINED HAVE_ACTIVE_DESKTOP_H)
    endif()
    check_c_source_compiles("#include <windows.h>\n#include <wininet.h>\n#include <shlobj.h>\nint main(int c, char** v) {GUID i = CLSID_ActiveDesktop; (void)i; return 0;}" HAVE_ACTIVE_DESKTOP_L)
    if(HAVE_ACTIVE_DESKTOP_L)
        list(APPEND RFB_WIN32_DEFINED HAVE_ACTIVE_DESKTOP_L)
    endif()
endif()

set(RFB_WIN32_SOURCES
  AboutDialog.cxx
  Clipboard.cxx
  CurrentUser.cxx
  DeviceContext.cxx
  DeviceFrameBuffer.cxx
  Dialog.cxx
  DIBSectionBuffer.cxx
  EventManager.cxx
  LaunchProcess.cxx
  ListViewControl.cxx
  MonitorInfo.cxx
  MsgWindow.cxx
  RegConfig.cxx
  Registry.cxx
  SecurityPage.cxx
  SDisplayCorePolling.cxx
  SDisplayCoreWMHooks.cxx
  SDisplay.cxx
  Security.cxx
  Service.cxx
  SInput.cxx
  SocketManager.cxx
  TCharArray.cxx
  TsSessions.cxx
  Win32Util.cxx
  WMCursor.cxx
  WMHooks.cxx
  WMNotifier.cxx
  WMPoller.cxx
  WMShatter.cxx
  WMWindowCopyRect.cxx)

if(BUILD_WINVNC)
  set(RFB_WIN32_SOURCES ${RFB_WIN32_SOURCES} CleanDesktop.cxx)
endif()

add_library(rfb_win32 STATIC ${RFB_WIN32_SOURCES})
target_compile_definitions(rfb_win32 PRIVATE ${RFB_WIN32_DEFINED})
target_link_libraries(rfb_win32 user32.lib comctl32.lib wtsapi32.lib version.lib)
