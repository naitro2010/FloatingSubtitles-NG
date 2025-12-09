-- set minimum xmake version
set_xmakever("2.8.2")

-- includes
includes("lib/commonlibsse-ng")

-- set project
set_project("po3_FloatingSubtitles")
set_version("3.1.0")
set_license("GPL-3.0, original repository is MIT")

-- set defaults
set_languages("c++23")
set_warnings("allextra")
add_requires("clib")
add_requires("xbyak")
add_requires("srell")
add_requires("boost", {configs = {containers = true}})
add_requires("imgui", {configs = {dx11 = true, win32 = true, freetype = true, wchar32 = true}})
-- set policies
set_policy("package.requires_lock", true)

-- add rules
add_rules("mode.debug", "mode.releasedbg")
add_rules("plugin.vsxmake.autoupdate")

-- targets
target("po3_FloatingSubtitles")
    -- add dependencies to target
    add_deps("commonlibsse-ng")
	add_packages("imgui")
	add_packages("clib")
	add_packages("xbyak")
	add_packages("srell")
	add_packages("boost")

    -- add commonlibsse-ng plugin
    add_rules("commonlibsse-ng.plugin", {
        name = "po3_FloatingSubtitles",
        author = "powerof3, Iamgoofball",
        description = "A port of Floating Subtitles to CommonLibSSE-NG for VR support."
    })

    -- add src files
    add_files("src/**.cpp")
    add_headerfiles("src/**.h")
    add_includedirs("src")
	add_includedirs("lib/CLibUtil/include")
    set_pcxxheader("src/pch.h")
