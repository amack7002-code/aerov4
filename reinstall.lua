local commit
pcall(function()
	commit = readfile('aerov4/profiles/commit.txt')
end)

local function wipe(path)
	if isfolder(path) then
		for _, item in listfiles(path) do
			wipe(item)
		end
		pcall(delfolder, path)
	elseif isfile(path) then
		pcall(delfile, path)
	end
end

if isfolder('aerov4') then
	wipe('aerov4')
end

pcall(function()
	game:GetService('StarterGui'):SetCore('SendNotification', {
		Title = 'aerov4',
		Text = 'deleted aerov4, reinjecting now',
		Duration = 4
	})
end)

task.wait(0.67)

loadstring(game:HttpGet('https://raw.githubusercontent.com/amack7002-code/tapev4/'..(commit or 'main')..'/main.lua', true))()
