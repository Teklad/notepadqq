set(notepadqq_HEADERS
    include/clickablelabel.h
    include/docengine.h
    include/EditorNS/bannerbasicmessage.h
    include/EditorNS/bannerfilechanged.h
    include/EditorNS/bannerfileremoved.h
    include/EditorNS/bannerindentationdetected.h
    include/EditorNS/customqwebview.h
    include/EditorNS/editor.h
    include/EditorNS/languageservice.h
    include/editortabwidget.h
    include/Extensions/extension.h
    include/Extensions/extensionsloader.h
    include/Extensions/extensionsserver.h
    include/Extensions/installextension.h
    include/Extensions/runtimesupport.h
    include/Extensions/Stubs/editorstub.h
    include/Extensions/Stubs/menuitemstub.h
    include/Extensions/Stubs/notepadqqstub.h
    include/Extensions/Stubs/stub.h
    include/Extensions/Stubs/windowstub.h
    include/frmabout.h
    include/frmencodingchooser.h
    include/frmindentationmode.h
    include/frmlinenumberchooser.h
    include/frmpreferences.h
    include/globals.h
    include/iconprovider.h
    include/keygrabber.h
    include/localcommunication.h
    include/mainwindow.h
    include/notepadqq.h
    include/nqqrun.h
    include/nqqsettings.h
    include/Search/advancedsearchdock.h
    include/Search/filereplacer.h
    include/Search/filesearcher.h
    include/Search/frmsearchreplace.h
    include/Search/searchhelpers.h
    include/Search/searchinstance.h
    include/Search/searchobjects.h
    include/Search/searchstring.h
    include/Sessions/backupservice.h
    include/Sessions/persistentcache.h
    include/Sessions/sessions.h
    include/singleapplication.h
    include/stats.h
    include/topeditorcontainer.h
)

set(notepadqq_SOURCES
    clickablelabel.cpp
    docengine.cpp
    EditorNS/bannerbasicmessage.cpp
    EditorNS/bannerfilechanged.cpp
    EditorNS/bannerfileremoved.cpp
    EditorNS/bannerindentationdetected.cpp
    EditorNS/customqwebview.cpp
    EditorNS/editor.cpp
    EditorNS/languageservice.cpp
    editortabwidget.cpp
    Extensions/extension.cpp
    Extensions/extensionsloader.cpp
    Extensions/extensionsserver.cpp
    Extensions/installextension.cpp
    Extensions/runtimesupport.cpp
    Extensions/Stubs/editorstub.cpp
    Extensions/Stubs/menuitemstub.cpp
    Extensions/Stubs/notepadqqstub.cpp
    Extensions/Stubs/stub.cpp
    Extensions/Stubs/windowstub.cpp
    frmabout.cpp
    frmencodingchooser.cpp
    frmindentationmode.cpp
    frmlinenumberchooser.cpp
    frmpreferences.cpp
    globals.cpp
    iconprovider.cpp
    keygrabber.cpp
    localcommunication.cpp
    main.cpp
    mainwindow.cpp
    notepadqq.cpp
    nqqrun.cpp
    nqqsettings.cpp
    Search/advancedsearchdock.cpp
    Search/filereplacer.cpp
    Search/filesearcher.cpp
    Search/frmsearchreplace.cpp
    Search/searchinstance.cpp
    Search/searchobjects.cpp
    Search/searchstring.cpp
    Sessions/backupservice.cpp
    Sessions/persistentcache.cpp
    Sessions/sessions.cpp
    singleapplication.cpp
    stats.cpp
    topeditorcontainer.cpp
)

set(notepadqq_UIS
    frmabout.ui
    frmencodingchooser.ui
    frmindentationmode.ui
    frmlinenumberchooser.ui
    frmpreferences.ui
    mainwindow.ui
    Search/dlgsearching.ui
    Search/frmsearchreplace.ui
)

# Add our translations
qt5_create_translation(notepadqq_TRANSLATIONS
../translations/notepadqq_zh.ts
../translations/notepadqq_de.ts
../translations/notepadqq_es.ts
../translations/notepadqq_fr.ts
../translations/notepadqq_hu.ts
../translations/notepadqq_it.ts
../translations/notepadqq_ja.ts
../translations/notepadqq_pl.ts
../translations/notepadqq_pt.ts
../translations/notepadqq_ru.ts
../translations/notepadqq_sl.ts
../translations/notepadqq_sv.ts
../translations/notepadqq_uk.ts
)

# Automatically generate translations qrc
set(notepadqq_TFILE "${CMAKE_CURRENT_BINARY_DIR}/notepadqq_translations.qrc")
file(WRITE "${notepadqq_TFILE}" "<RCC><qresource prefix=\"/translations\">")
foreach(QM_FILE ${notepadqq_TRANSLATIONS})
    get_filename_component(QM_FILE_NAME "${QM_FILE}" NAME)
    file(APPEND "${notepadqq_TFILE}" "<file>${QM_FILE_NAME}</file>")
endforeach()
file(APPEND "${notepadqq_TFILE}" "</qresource></RCC>")

# Add our resources
list(APPEND notepadqq_RESOURCES "${notepadqq_TFILE}")
list(APPEND notepadqq_RESOURCES "resources.qrc")

message(${notepadqq_TFILE})
# If we're on Mac, don't append -bin to the binary name
if (APPLE)
    set(notepadqq_BIN notepadqq)
else()
    set(notepadqq_BIN notepadqq-bin)
endif()


# Add all of our source files to the notepadqq binary
add_executable(${notepadqq_BIN}
    ${notepadqq_HEADERS}
    ${notepadqq_SOURCES}
    ${notepadqq_TRANSLATIONS}
    ${notepadqq_UIS}
    ${notepadqq_RESOURCES}
)

# Set properties to use for notepadqq
set_target_properties(${notepadqq_BIN}
    PROPERTIES
    CXX_STANDARD 14
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/notepadqq"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/notepadqq"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/notepadqq"
)

# Add 3rd party include directories
target_include_directories(${notepadqq_BIN} PRIVATE
    ${UCharDet_INCLUDE_DIRS}
    libs/qtpromise/include
)

# Link against our required libraries
target_link_libraries(${notepadqq_BIN}
    ${UCharDet_LIBRARIES}
    Qt5::Core
    Qt5::Gui
    Qt5::Network
    Qt5::PrintSupport
    Qt5::Svg
    Qt5::WebChannel
    Qt5::WebEngine
    Qt5::WebEngineWidgets
    Qt5::WebSockets
    Qt5::Widgets
)

# generate proper GUI program on specified platform
if(WIN32)
    set_target_properties(${PROJECT_NAME} PROPERTIES
        WIN32_EXECUTABLE YES
        LINK_FLAGS "/ENTRY:mainCRTStartup"
    )
elseif(APPLE)
    set_target_properties(${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE YES
    )
endif(WIN32)
