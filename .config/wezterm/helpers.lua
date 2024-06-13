local helpers = {}

function helpers.detect_host_os()
	-- package.config:sub(1,1) returns '\' for windows and '/' for *nix.
	-- if package.config:sub(1, 1) == "\\" then
	-- 	return "windows"
	-- else
	-- uname should be available on *nix systems.
	local check = io.popen("uname -s")
	local result = nil -- Declare result outside the block

	if check then
		result = check:read("*l")
		check:close()

		if result then
			print("Command output: " .. result)
		else
			print("Failed to read command output")
		end
	else
		print("Failed to execute command")
	end

	if result == "Darwin" then
		return "macos"
	else
		return "linux"
	end
end

function helpers.add_path_in_macos(config)
	local host_os = helpers.detect_host_os()
	local launch_menu = {}

	if host_os == "macos" then
		-- check homebrew binary symlinks on startup.
		config.set_environment_variables = {
			PATH = "/usr/local/bin/:" .. os.getenv("PATH"),
		}
	end

	config.launch_menu = launch_menu
end

return helpers
