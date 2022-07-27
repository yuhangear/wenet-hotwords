set(PYTORCH_VERSION "1.10.0")
if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
  if(${CMAKE_BUILD_TYPE} MATCHES "Release")
    set(LIBTORCH_URL "https://download.pytorch.org/libtorch/cpu/libtorch-win-shared-with-deps-${PYTORCH_VERSION}%2Bcpu.zip")
    set(URL_HASH "SHA256=d7043b7d7bdb5463e5027c896ac21b83257c32c533427d4d0d7b251548db8f4b")
  else()
    set(LIBTORCH_URL "https://download.pytorch.org/libtorch/cpu/libtorch-win-shared-with-deps-debug-${PYTORCH_VERSION}%2Bcpu.zip")
    set(URL_HASH "SHA256=d98c1b6d425ce62a6d65c16d496ef808fb2e7053d706202c536a7e437a5ade86")
  endif()
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
  if(CXX11_ABI)
    set(LIBTORCH_URL "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-${PYTORCH_VERSION}%2Bcpu.zip")
    
  else()
    set(LIBTORCH_URL "https://download.pytorch.org/libtorch/cpu/libtorch-shared-with-deps-${PYTORCH_VERSION}%2Bcpu.zip")
    
  endif()
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
  set(LIBTORCH_URL "https://download.pytorch.org/libtorch/cpu/libtorch-macos-${PYTORCH_VERSION}.zip")
  set(URL_HASH "SHA256=07cac2c36c34f13065cb9559ad5270109ecbb468252fb0aeccfd89322322a2b5")
else()
  message(FATAL_ERROR "Unsupported CMake System Name '${CMAKE_SYSTEM_NAME}' (expected 'Windows', 'Linux' or 'Darwin')")
endif()

FetchContent_Declare(libtorch
  URL      ${LIBTORCH_URL}
  URL_HASH ${URL_HASH}
)
FetchContent_MakeAvailable(libtorch)
find_package(Torch REQUIRED PATHS ${libtorch_SOURCE_DIR} NO_DEFAULT_PATH)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${TORCH_CXX_FLAGS} -DC10_USE_GLOG")

if(MSVC)
  file(GLOB TORCH_DLLS "${TORCH_INSTALL_PREFIX}/lib/*.dll")
  file(COPY ${TORCH_DLLS} DESTINATION ${CMAKE_BINARY_DIR})
endif()
