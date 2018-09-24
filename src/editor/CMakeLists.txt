set(editor_BUILDDIR "${CMAKE_BINARY_DIR}/share/notepadqq/editor")

set(editor_FILES
    app.js
    classes
    features
    index.html
    init.js
    Languages.json
    libs
    styles
)

add_custom_target(editor ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory
    "${editor_BUILDDIR}"
)

add_custom_command(TARGET editor POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_CURRENT_SOURCE_DIR}/classes" "${editor_BUILDDIR}/classes"
)

add_custom_command(TARGET editor POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_CURRENT_SOURCE_DIR}/features" "${editor_BUILDDIR}/features"
)

add_custom_command(TARGET editor POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_CURRENT_SOURCE_DIR}/libs" "${editor_BUILDDIR}/libs"
)

add_custom_command(TARGET editor POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_CURRENT_SOURCE_DIR}/styles" "${editor_BUILDDIR}/styles"
)

foreach(item ${editor_FILES})
    add_custom_command(TARGET editor POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${CMAKE_CURRENT_SOURCE_DIR}/${item}"
        "${editor_BUILDDIR}/${item}"
    )
endforeach(item)

