find_packages(PHONE_RINGER_PACKAGES REQUIRED
    Gst
    Gee
    GLib
    GModule
    GObject
    GDKPixbuf2
)

vala_precompile(PHONE_RINGER_VALA_C
SOURCES
    src/plugin.vala
    src/register_plugin.vala
CUSTOM_VAPIS
    ${CMAKE_BINARY_DIR}/exports/xmpp-vala.vapi
    ${CMAKE_BINARY_DIR}/exports/dino.vapi
    ${CMAKE_BINARY_DIR}/exports/qlite.vapi
PACKAGES
    ${PHONE_RINGER_PACKAGES}
)

add_definitions(${VALA_CFLAGS})
add_library(phone-ringer SHARED ${PHONE_RINGER_VALA_C})
target_link_libraries(phone-ringer libdino ${PHONE_RINGER_PACKAGES})
set_target_properties(phone-ringer PROPERTIES PREFIX "")
set_target_properties(phone-ringer PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/plugins/)

add_custom_command(TARGET phone-ringer PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy_directory
                   ${CMAKE_SOURCE_DIR}/plugins/phone-ringer/sounds
                   ${CMAKE_BINARY_DIR}/sounds)

install(TARGETS phone-ringer ${PLUGIN_INSTALL})

install(FILES
    sounds/phone-incoming-call.oga
    sounds/phone-outgoing-calling.oga
DESTINATION
    ${SOUND_INSTALL_DIR}
)
