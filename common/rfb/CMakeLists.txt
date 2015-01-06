include_directories(${CMAKE_SOURCE_DIR}/common ${JPEG_INCLUDE_DIR})

set(RFB_SOURCES
  Blacklist.cxx
  CConnection.cxx
  CMsgHandler.cxx
  CMsgReader.cxx
  CMsgReaderV3.cxx
  CMsgWriter.cxx
  CMsgWriterV3.cxx
  CSecurityVncAuth.cxx
  ComparingUpdateTracker.cxx
  Configuration.cxx
  ConnParams.cxx
  Cursor.cxx
  Decoder.cxx
  Encoder.cxx
  HTTPServer.cxx
  HextileDecoder.cxx
  HextileEncoder.cxx
  KeyRemapper.cxx
  LogWriter.cxx
  Logger.cxx
  Logger_file.cxx
  Logger_stdio.cxx
  Password.cxx
  PixelBuffer.cxx
  PixelFormat.cxx
  RREEncoder.cxx
  RREDecoder.cxx
  RawDecoder.cxx
  RawEncoder.cxx
  Region.cxx
  SConnection.cxx
  SMsgHandler.cxx
  SMsgReader.cxx
  SMsgReaderV3.cxx
  SMsgWriter.cxx
  SMsgWriterV3.cxx
  ServerCore.cxx
  SSecurityFactoryStandard.cxx
  SSecurityVncAuth.cxx
  Timer.cxx
  TransImageGetter.cxx
  UpdateTracker.cxx
  VNCSConnectionST.cxx
  VNCServerST.cxx
  ZRLEEncoder.cxx
  ZRLEDecoder.cxx
  encodings.cxx
  secTypes.cxx
  util.cxx
  d3des.c)

set(RFB_LIBRARIES rdr)

add_library(rfb STATIC ${RFB_SOURCES})

target_link_libraries(rfb ${RFB_LIBRARIES})

if(UNIX)
  libtool_create_control_file(rfb)
endif()
