newoption {
	trigger = "luau-path",
	default = ".",
	description = "sets the path to luau distribution.",
}

workspace "Luau"
	language "C++"
	configurations {"Debug", "Release"}
	location (_OPTIONS["luau-path"] .. "/build")
	targetdir (_OPTIONS["luau-path"] .. "/build/%{cfg.shortname}")

	filter "configurations:Debug"
	defines { "DEBUG" }
	symbols "On"

	filter "configurations:Release"
	defines { "NDEBUG" }
	optimize "On"

project "Luau.Ast"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",

		_OPTIONS["luau-path"] .. "/Ast/include",
	}
	files {_OPTIONS["luau-path"] .. "/Ast/src/*.cpp"}
	
	filter "action:gmake"
	targetname "luauast"

project "Luau.Compiler"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",

		_OPTIONS["luau-path"] .."/Compiler/include",
	}
	files {_OPTIONS["luau-path"] .. "/Compiler/src/*.cpp"}
	
	filter "action:gmake"
	targetname "luaucompiler"

project "Luau.VM"
	kind "Staticlib"
	cppdialect "C++11"
	includedirs {_OPTIONS["luau-path"] .. "/Common/include", _OPTIONS["luau-path"] .. "/VM/include"}
	files {_OPTIONS["luau-path"] .. "/VM/src/*.cpp"}
	
	filter "action:gmake"
	targetname "luauvm"

project "Luau.Config"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",

		_OPTIONS["luau-path"] .. "/Config/include",
	}
	files { _OPTIONS["luau-path"] .. "/Config/src/*.cpp" }
	
	filter "action:gmake"
	targetname "luauconfig"

project "Luau.CodeGen"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/VM/include",
		_OPTIONS["luau-path"] .. "/VM/src",

		_OPTIONS["luau-path"] .. "/CodeGen/include",
	}
	files { _OPTIONS["luau-path"] .. "/CodeGen/src/*.cpp" }
	
	filter "action:gmake"
	targetname "luaucodegen"

project "Luau.Require"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/VM/include",
		_OPTIONS["luau-path"] .. "/Config/include",
		_OPTIONS["luau-path"] .. "/Require/Navigator/include",

		_OPTIONS["luau-path"] .. "/Require/Runtime/include",
	}
	files { _OPTIONS["luau-path"] .. "/Require/Runtime/src/*.cpp" }
	
	filter "action:gmake"
	targetname "luaurequire"

project "Luau.RequireNavigator"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/Config/include",

		_OPTIONS["luau-path"] .. "/Require/Navigator/include",
	}
	files { _OPTIONS["luau-path"] .. "/Require/Navigator/src/*.cpp" }
	
	filter "action:gmake"
	targetname "luaurequirenavigator"

project "Luau.Analysis"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/Config/include",
		_OPTIONS["luau-path"] .. "/EqSat/include",
		_OPTIONS["luau-path"] .. "/Compiler/include",
		_OPTIONS["luau-path"] .. "/VM/include",

		_OPTIONS["luau-path"] .. "/Analysis/include",
	}
	files { _OPTIONS["luau-path"] .. "/Analysis/src/*.cpp" }
	
	filter "action:gmake"
	targetname "luauanalysis"

project "Luau.EqSat"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",

		_OPTIONS["luau-path"] .. "/EqSat/include",
	}
	files { _OPTIONS["luau-path"] .. "/EqSat/src/*.cpp" }
	
	filter "action:gmake"
	targetname "luaueqsat"

project "extern.isocline"
	kind "Staticlib"
	language "C"
	includedirs { _OPTIONS["luau-path"] .. "/extern/isocline/include" }
	files { _OPTIONS["luau-path"] .. "/extern/isocline/src/isocline.c" }
	
	filter "action:gmake"
	targetname "isocline"

project "Luau.Tests"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {

		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/Compiler/include",
		_OPTIONS["luau-path"] .. "/Config/include",
		_OPTIONS["luau-path"] .. "/Analysis/include",
		_OPTIONS["luau-path"] .. "/EqSat/include",
		_OPTIONS["luau-path"] .. "/CodeGen/include",
		_OPTIONS["luau-path"] .. "/VM/include",
		_OPTIONS["luau-path"] .. "/Require/Runtime/include",
		_OPTIONS["luau-path"] .. "/CLI/include",

		_OPTIONS["luau-path"] .. "/extern/isocline/include",
		_OPTIONS["luau-path"] .. "/extern",

	}
	files {
		_OPTIONS["luau-path"] .. "/CLI/src/FileUtils.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Flags.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Profiler.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Coverage.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Repl.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/ReplRequirer.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/VfsNavigator.cpp",

		_OPTIONS["luau-path"] .. "/tests/*.cpp",
	}
	links {
		"Luau.Analysis",
		"Luau.EqSat",
		"Luau.Compiler",
		"Luau.Ast",
		"Luau.Codegen",
		"Luau.VM",
		"Luau.Require",
		"Luau.Requirenavigator",
		"Luau.Config",

		"extern.isocline",
	}
	defines { "DOCTEST_CONFIG_DOUBLE_STRINGIFY" }
	
	filter "action:gmake"
	targetname "luau-tests"
	links { "pthread" }


project "Luau.CLI"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/Compiler/include",
		_OPTIONS["luau-path"] .. "/Config/include",
		_OPTIONS["luau-path"] .. "/VM/include",
		_OPTIONS["luau-path"] .. "/CodeGen/include",
		_OPTIONS["luau-path"] .. "/Require/Runtime/include",

		_OPTIONS["luau-path"] .. "/extern/isocline/include",
		_OPTIONS["luau-path"] .. "/extern",

		_OPTIONS["luau-path"] .. "/CLI/include",
	}
	files {
		_OPTIONS["luau-path"] .. "/CLI/src/FileUtils.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Flags.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Profiler.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Coverage.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Repl.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/ReplEntry.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/ReplRequirer.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/VfsNavigator.cpp",
	}
	links {
		"Luau.Compiler",
		"Luau.Ast",
		"Luau.CodeGen",
		"Luau.VM",
		"Luau.Require",
		"Luau.RequireNavigator",
		"Luau.Config",

		"extern.isocline",
	}
	
	filter "action:gmake"
	targetname "luau"
	links { "pthread" }

project "Luau.Analyze"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/Analysis/include",
		_OPTIONS["luau-path"] .. "/EqSat/include",
		_OPTIONS["luau-path"] .. "/Config/include",
		_OPTIONS["luau-path"] .. "/Require/Navigator/include",
		_OPTIONS["luau-path"] .. "/extern",
		_OPTIONS["luau-path"] .. "/CLI/include",

	}
	files {
		_OPTIONS["luau-path"] .. "/CLI/src/FileUtils.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Flags.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Analyze.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/AnalyzeRequirer.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/VfsNavigator.cpp",
	}
	links {
		"Luau.Analysis",
		"Luau.EqSat",
		"Luau.Ast",
		"Luau.Compiler",
		"Luau.Vm",
		"Luau.Requirenavigator",
		"Luau.Config",
	}
	
	filter "action:gmake"
	targetname "luau-analyze"
	links { "pthread" }

project "Luau.Compile"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/Compiler/include",
		_OPTIONS["luau-path"] .. "/CodeGen/include",
		_OPTIONS["luau-path"] .. "/VM/include",

		_OPTIONS["luau-path"] .. "/CLI/include",

	}
	files {
		_OPTIONS["luau-path"] .. "/CLI/src/FileUtils.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Flags.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Compile.cpp",
	}
	links {
		"Luau.Ast",
		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.Vm",
	}
	
	filter "action:gmake"
	targetname "luau-compile"

project "Luau.Bytecode"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Ast/include",
		_OPTIONS["luau-path"] .. "/Compiler/include",
		_OPTIONS["luau-path"] .. "/CodeGen/include",
		_OPTIONS["luau-path"] .. "/VM/include",

		_OPTIONS["luau-path"] .. "/CLI/include",

	}
	files {
		_OPTIONS["luau-path"] .. "/CLI/src/FileUtils.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Flags.cpp",
		_OPTIONS["luau-path"] .. "/CLI/src/Bytecode.cpp",
	}
	links {
		"Luau.Ast",
		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.VM",
	}
	
	filter "action:gmake"
	targetname "luau-bytecode"

project "Luau.Web"
	kind "ConsoleApp"
	includedirs {
		_OPTIONS["luau-path"] .. "/Common/include",
		_OPTIONS["luau-path"] .. "/Compiler/include",
		_OPTIONS["luau-path"] .. "/VM/include",
	}
	files {_OPTIONS["luau-path"] .. "/CLI/src/Web.cpp"}
	links { "Luau.Ast", "Luau.Compiler", "Luau.VM" }
	linkoptions {
		"-sEXPORTED_FUNCTIONS=['_executeScript']",
		"-sEXPORTED_RUNTIME_METHODS=['ccall','cwrap']",
		"-fexceptions",
		"-sSINGLE_FILE=1",
	}
	targetextension ".js"

	filter "not system:emscripten"
	kind "None"
