
cmake_minimum_required(VERSION 3.22.1)

project(AndroidSample)
set(DEPLOY_PROJECT native-activity)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../../../source ${CMAKE_CURRENT_BINARY_DIR}/cpp)

if(SANITIZE)
    # For asan and ubsan, we need to copy some files from the NDK into our APK.
    get_filename_component(HINT_PATH ${ANDROID_C_COMPILER} DIRECTORY)
    message(STATUS "NDK Path : ${HINT_PATH}")
    set(ARCH_STR ${CMAKE_ANDROID_ARCH})
    if ("${CMAKE_ANDROID_ARCH_ABI}" STREQUAL "arm64-v8a")
        set(ARCH_STR "aarch64")
    elseif ("${CMAKE_ANDROID_ARCH_ABI}" STREQUAL "armeabi")
        set(ARCH_STR "arm")
    elseif ("${CMAKE_ANDROID_ARCH_ABI}" STREQUAL "armeabi-v7a")
        set(ARCH_STR "arm")
    elseif ("${CMAKE_ANDROID_ARCH_ABI}" STREQUAL "x86")
        set(ARCH_STR "i686")
    elseif ("${CMAKE_ANDROID_ARCH_ABI}" STREQUAL "x86_64")
        set(ARCH_STR "x86_64")
    endif()

    if(${SANITIZE} STREQUAL "hwasan")
        message("Using hwasan")

        target_compile_options(${DEPLOY_PROJECT} PUBLIC -fsanitize=hwaddress -fno-omit-frame-pointer)
        target_link_options(${DEPLOY_PROJECT} PUBLIC -fsanitize=hwaddress)
    elseif(${SANITIZE} STREQUAL "asan")
        message("Using asan")

        target_compile_options(${DEPLOY_PROJECT} PUBLIC -fsanitize=address -fno-omit-frame-pointer)
        target_link_options(${DEPLOY_PROJECT} PUBLIC -fsanitize=address)

        # Grab libclang_rt.asan-${ARCH_STR}-android.so from the NDK.
        file(GLOB ASAN_GLOB "${HINT_PATH}/../lib/clang/*/lib/linux")
        find_file(ASAN
                NAMES libclang_rt.asan-${ARCH_STR}-android.so
                PATHS ${ASAN_GLOB})
        get_filename_component(ASAN_NAME ${ASAN} NAME)
        set(ASAN_NAME ${CMAKE_SOURCE_DIR}/../../asan/jniLibs/${CMAKE_ANDROID_ARCH_ABI}/${ASAN_NAME})

        add_custom_target(copy_asan COMMAND ${CMAKE_COMMAND} -E copy ${ASAN} ${ASAN_NAME})
        add_dependencies(${DEPLOY_PROJECT} copy_asan)

        # Set definition to load shared lib
        target_compile_definitions(${DEPLOY_PROJECT} PRIVATE NDK_SANITIZER="libclang_rt.asan-${ARCH_STR}-android.so")
    elseif(${SANITIZE} STREQUAL "ubsan")
        message("Using ubsan")

        target_compile_options(${DEPLOY_PROJECT} PUBLIC -fsanitize=undefined -fno-sanitize-recover=undefined)
        target_link_options(${DEPLOY_PROJECT} PUBLIC -fsanitize=undefined -fno-sanitize-recover=undefined)

        # Grab libclang_rt.ubsan_standalone-${ARCH_STR}-android.so from the NDK.
        file(GLOB UBSAN_GLOB "${HINT_PATH}/../lib/clang/*/lib/linux")
        find_file(UBSAN
                NAMES libclang_rt.ubsan_standalone-${ARCH_STR}-android.so
                PATHS ${UBSAN_GLOB})
        get_filename_component(UBSAN_NAME ${UBSAN} NAME)
        set(UBSAN_NAME ${CMAKE_SOURCE_DIR}/../../ubsan/jniLibs/${CMAKE_ANDROID_ARCH_ABI}/${UBSAN_NAME})

        add_custom_target(copy_ubsan COMMAND ${CMAKE_COMMAND} -E copy ${UBSAN} ${UBSAN_NAME})
        add_dependencies(${DEPLOY_PROJECT} copy_ubsan)
        
        # Set definition to load shared lib
        target_compile_definitions(${DEPLOY_PROJECT} PRIVATE NDK_SANITIZER="libclang_rt.ubsan_standalone-${ARCH_STR}-android.so")
    endif()
endif()