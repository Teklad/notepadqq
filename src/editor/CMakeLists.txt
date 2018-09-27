set(editor_BUILDDIR "${CMAKE_BINARY_DIR}/share/notepadqq/editor")

set(editor_FILES
    app.js
    index.html
    init.js
    Languages.json
)

set(editor_DIRS
    classes
    features
    styles
)

# Rules for adding these files to the build directory
add_custom_target(editor ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory
    "${editor_BUILDDIR}"
)

# Copy directories
foreach(item ${editor_DIRS})
    add_custom_command(TARGET editor POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_CURRENT_SOURCE_DIR}/${item}"
        "${editor_BUILDDIR}/${item}"
    )
endforeach()

# Copy files
foreach(item ${editor_FILES})
    add_custom_command(TARGET editor POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_SOURCE_DIR}/${item}"
        "${editor_BUILDDIR}/${item}"
    )
endforeach(item)


# Install rules
if (UNIX)
    include(GNUInstallDirs)
    set(editor_INSTALLDIR "${CMAKE_INSTALL_DATADIR}/notepadqq/editor")

    install(FILES ${editor_FILES} DESTINATION "${editor_INSTALLDIR}")
    install(DIRECTORY ${editor_DIRS} DESTINATION "${editor_INSTALLDIR}")

    # Special handling for libs directory where we use some regex to skip
    # files that are not needed within codemirror
    install(DIRECTORY libs DESTINATION "${editor_INSTALLDIR}"
        REGEX "libs\/codemirror\/(AUTHORS|CHANGELOG\.md|CONTRIBUTING\.md|README\.md)$" EXCLUDE
        REGEX "libs\/codemirror\/(package.*\.json|rollup\.config\.js|index\.html)$" EXCLUDE
        REGEX "libs\/codemirror\/(bin|demo|doc|test|src)$" EXCLUDE
        REGEX "libs\/codemirror\/\.(editorconfig|gitattributes|gitignore|npmignore|travis\.yml)" EXCLUDE
        REGEX "libs\/codemirror\/mode\/.*\.html$" EXCLUDE
        REGEX "libs\/codemirror\/mode\/.*test\.js$" EXCLUDE
        REGEX "libs\/codemirror\/mode\/m4\/.*\.(in|txt|sh)$" EXCLUDE
    )
endif()
