---@meta

---@class fu.FontList
local FontList = {};

--- Adds the specified font to the global font list.
---@param fontfile string
---@return boolean
function FontList:AddFont(fontfile) end

--- Empties the global font list.
function FontList:Clear() end

--- Returns all font files in the global font list.
---@return table
function FontList:GetFontList() end

--- Adds the specified dir to the global font list.
---@param dirname string?
function FontList:ScanDir(dirname) end
