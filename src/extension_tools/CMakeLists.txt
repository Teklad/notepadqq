set(extensions_BUILDDIR "${CMAKE_BINARY_DIR}/share/notepadqq/extension_tools")

set(extensions_FILES
    install.js
    pack.js
    package.json
    readmanifest.js
)

set(extensions_DIRS
    node_modules
)

# Rules for adding these files to the build directory
add_custom_target(extensions ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory
    "${extensions_BUILDDIR}"
)

# Copy directories
foreach(item ${extensions_DIRS})
    add_custom_command(TARGET extensions POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_CURRENT_SOURCE_DIR}/${item}"
        "${extensions_BUILDDIR}/${item}"
    )
endforeach()

# Copy files
foreach(item ${extensions_FILES})
    add_custom_command(TARGET extensions POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_SOURCE_DIR}/${item}"
        "${extensions_BUILDDIR}/${item}"
    )
endforeach(item)


# Install rules
if (UNIX)
    include(GNUInstallDirs)
    set(extensions_INSTALLDIR "${CMAKE_INSTALL_DATADIR}/notepadqq/editor")
    install(FILES ${extensions_FILES} DESTINATION "${extensions_INSTALLDIR}")
    install(DIRECTORY ${extensions_DIRS} DESTINATION "${extensions_INSTALLDIR}")
endif()
