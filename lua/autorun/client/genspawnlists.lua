if not spawnmenu then require("spawnmenu") end

local exclude = {
	["comicprops.txt"] = true,
	["constructionprops.txt"] = true,
	["hl2characters.txt"] = true,
}

local fileNames = file.Find("settings/spawnlist/*.txt", "GAME")

for _,fileName in pairs(fileNames) do
	if exclude[fileName] then continue end -- exclude Garry's spawn lists

	fileName = "settings/spawnlist/"..fileName
	local contents = file.Read(fileName, "GAME")
	if not contents then print("Could not read "..fileName) continue end

	local blob = util.KeyValuesToTable(contents)

	if not blob.information then continue end -- not a legacy spawn list

	local categoryName = blob.information.name
	local entries = {}
	for i,model in pairs(blob.entries) do
		entries[i] = {
			type = "model",
			model = model,
		}
	end
	spawnmenu.AddPropCategory(fileName, categoryName, entries)
end
