find_package(Doxygen)

if (DOXYGEN_FOUND)
    # Doxygenがある場合のみ"make doxygen"というmakeのターゲットを用意しておく
    add_custom_target(doxygen)
endif ()

# add_doxygen関数
# @brief 個別のビルド対象に対する"make doxygen-${targetname}"を作り、
# "make doxygen"に関連つける関数
# @param targetname ビルド対象(add_executable,add_libraryで指定する名前を入れる)
function (add_doxygen targetname)
    # Doxygenないときは空関数
    if (NOT DOXYGEN_FOUND)
        return()
    endif ()

    #~~~~~~~~準備の作業~~~~~~~~#
    # Doxygen関連ファイル置き場へのパス
    set(doxydir ${CMAKE_SOURCE_DIR}/Doxygen)

    # CMakeコマンド実行した場所に/DoxyDocを作り、そこに実行結果を保存する
    set(outputdir ${CMAKE_BINARY_DIR}/DoxyDoc)

    # Doxygenが受け取れるようにソースファイルをスペース区切りtextにする
    get_property(sourcefiles
        TARGET ${targetname}
        PROPERTY SOURCES)
    foreach (source ${sourcefiles})
        set(source_spaces "${source_spaces} ${source}")
    endforeach ()

    # ソースファイルと同じ階層もインクルードパス扱いとする(.hを探すため)
    foreach (source ${sourcefiles})
        get_filename_component(source_dir ${source} DIRECTORY)
        set(source_dirs ${source_dirs} ${source_dir})
    endforeach ()

    # Doxygenが受け取れるようにインクルードパスをスペース区切りtextにする
    get_property(includedirs
        TARGET ${targetname}
        PROPERTY INCLUDE_DIRECTORIES)
    # 事前にインクルードパス扱いディレクトリをまとめてから・・
    list(APPEND includedirs ${source_dirs})
    list(REMOVE_DUPLICATES includedirs)
    # スペース区切りにする
    foreach (dir ${includedirs})
        set(dir_spaces "${dir_spaces} ${dir}")
    endforeach ()

    # インクルードパスにある.hもDoxygenのINPUT対象にする
    foreach (dir ${includedirs})
        file(GLOB headers ${dir}/*.h)
        foreach (h ${headers})
            set(header_spaces "${header_spaces} ${h}")
        endforeach ()
    endforeach ()

    # Doxygenが受け取れるように-Dのビルド時defineマクロをスペース区切りtextにする
    get_property(definitions
        DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        PROPERTY COMPILE_DEFINITIONS)
    foreach (def ${definitions})
        set(predef_spaces "${predef_spaces} ${def}")
    endforeach ()

    #~~~~~~~~本番の作業~~~~~~~~#
    # mkdir相当の処理。依存関係解消のためにここから実際に実施されていくはず。
    add_custom_command(
        OUTPUT  ${outputdir}/${targetname}
        COMMAND cmake -E make_directory ${outputdir}/${targetname}
        COMMENT "Creating documentation directory for ${targetname}")

    # Doxyfile.inからDoxyfileを作る処理。そのためにはmkdir相当の処理が必要。
    add_custom_command(
        OUTPUT  ${outputdir}/${targetname}/Doxyfile
        COMMAND ${CMAKE_COMMAND}
                -D "DOXYGEN_TEMPLATE=${doxydir}/Doxyfile.in"
                -D "DOXY_PROJECT_INPUT=${source_spaces} ${header_spaces}"
                -D "DOXY_PROJECT_INCLUDE_DIR=${dir_spaces}"
                -D "DOXY_PROJECT_PREDEFINED=${predef_spaces}"
                -D "DOXY_PROJECT_STRIP_FROM_PATH=${CMAKE_SOURCE_DIR}"
                -D "DOXY_DOCUMENTATION_OUTPUT_PATH=${outputdir}"
                -D "DOXY_PROJECT_NAME=${targetname}"
                -P "${doxydir}/doxygen-script.cmake"
        DEPENDS ${doxydir}/Doxyfile.in
                ${outputdir}/${targetname}
        WORKING_DIRECTORY
                ${outputdir}/${targetname}
        COMMENT "Generating Doxyfile for ${targetname}")

    # Doxygenコマンドを実際に実行しindex.htmlを作る。そのためにはDoxyfileが必要。
    add_custom_command(
        OUTPUT  ${outputdir}/${targetname}/index.html
        COMMAND ${DOXYGEN_EXECUTABLE}
        DEPENDS ${outputdir}/${targetname}/Doxyfile
        WORKING_DIRECTORY
                ${outputdir}/${targetname}
        COMMENT "Creating HTML documentation for ${targetname}")

    # "make doxygen-${targetname}"により、ピンポイントでdoxygen実行できる
    add_custom_target(doxygen-${targetname}
        DEPENDS ${outputdir}/${targetname}/index.html)

    # "make doxygen"に"make doxygen-${targetname}"を登録する（依存させる）
    add_dependencies(doxygen
        doxygen-${targetname})

endfunction ()
