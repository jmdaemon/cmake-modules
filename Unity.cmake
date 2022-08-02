# Build ThrowTheSwitch's unity cmake project
set(UNITY_NAME Unity)
add_library(
    ${UNITY_NAME}
    STATIC
    "${PROJECT_SOURCE_DIR}/subprojects/unity/src/unity.c")

target_include_directories(${UNITY_NAME} PUBLIC ${HEADERS_UNITY})
