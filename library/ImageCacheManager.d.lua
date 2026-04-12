---@meta

---@class fu.ImageCacheManager
local ICM = {};

--- FreeSpace
---@return boolean
function ICM:FreeSpace() end

--- GetSize
---@return number
function ICM:GetSize() end

--- This is useful to see how much room there currently is in the cache manager by checking to
--- see if a certain number of bytes will fit without needing to purge/flush.
--- 
--- bytes The number of bytes to check.
--- 
--- Returns a boolean indicating whether or not there is room in the cache manager for the
--- number of bytes passed as an argument.
--- 
---@param bytes number
---@return boolean
function ICM:IsRoom(bytes) end

--- This function allows the cache to be purged exactly as if doing so interactively in Fusion.
function ICM:Purge() end
