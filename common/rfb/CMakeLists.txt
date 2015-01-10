include_directories(${CMAKE_SOURCE_DIR}/common ${JPEG_INCLUDE_DIR})

if(WIN32)
include_directories(${CMAKE_SOURCE_DIR}/win)
endif()

set(INCLUDE_FILE_SOURCE
	Blacklist.h
	Hostname.h
	ServerCore.h
	CConnection.h
	HTTPServer.h
	SMsgHandler.h
	CMsgHandler.h
	ImageGetter.h
 	SMsgReader.h
	CMsgReader.h
	InputHandler.h
  	SMsgReaderV3.h
	CMsgReaderV3.h
	KeyRemapper.h
 	SMsgWriter.h
	CMsgWriter.h
	keysymdef.h
	SMsgWriterV3.h
	CMsgWriterV3.h
	Logger.h
	SSecurity.h
	ColourCube.h
	Logger_file.h
 	SSecurityFactoryStandard.h
	ColourMap.h
	Logger_stdio.h
  	SSecurityNone.h
	ComparingUpdateTracker.h
  	LogWriter.h
	SSecurityVncAuth.h
	Configuration.h
	msgTypes.h
	Threading.h
	ConnParams.h
	Password.h
	Timer.h
	CSecurity.h
	Pixel.h
	TransImageGetter.h
	CSecurityNone.h
	PixelBuffer.h
 	transInitTempl.h
	CSecurityVncAuth.h
	PixelFormat.h
 	transTempl.h
	Cursor.h
	RawDecoder.h
	TrueColourMap.h
	d3des.h
	RawEncoder.h
	UpdateTracker.h
	Decoder.h
	Rect.h
	UserPasswdGetter.h
	Encoder.h
	Region.h
	util.h
	encodings.h
	rreDecode.h
	VNCSConnectionST.h
	Exception.h
	RREDecoder.h
	VNCServer.h
	hextileConstants.h
	rreEncode.h
	VNCServerST.h
	hextileDecode.h
	RREEncoder.h
	zrleDecode.h
	HextileDecoder.h
	SConnection.h
 	ZRLEDecoder.h
	hextileEncode.h
	SDesktop.h
	zrleEncode.h
	HextileEncoder.h
	secTypes.h
	ZRLEEncoder.h
)

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

add_library(rfb STATIC ${RFB_SOURCES} ${INCLUDE_FILE_SOURCE})

target_link_libraries(rfb ${RFB_LIBRARIES})

if(UNIX)
  libtool_create_control_file(rfb)
endif()

#install library files
install(TARGETS rfb
   RUNTIME DESTINATION ${BIN_DIR}
   LIBRARY DESTINATION ${BIN_DIR}
   ARCHIVE DESTINATION ${LIB_DIR}
)

#install header files
INSTALL(FILES ${INCLUDE_FILE_SOURCE} DESTINATION "${INCLUDE_DIR}/rfb")
