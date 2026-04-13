---@meta

---Represents an item selected from Media Storage for import into the Media Pool.
---Used by MediaPool:AddItemListToMediaPool when importing structured media entries.
---
---This format allows partial clip imports using frame ranges.
---@class fu.MediaStorageItemInfo
---
---Absolute file or folder path in Media Storage.
---@field media string
---
---Optional start frame for partial import.
---Used when importing trimmed sections of media.
---@field startFrame integer|nil
---
---Optional end frame for partial import.
---Used when importing trimmed sections of media.
---@field endFrame integer|nil

---@class fu.MediaStorage
local MediaStorage = {};

---Returns list of folder paths corresponding to mounted volumes in Media Storage.
---@return string[]
function MediaStorage:GetMountedVolumeList() end

---Returns list of subfolder paths within the given absolute folder path.
---@param folderPath string
---@return string[]
function MediaStorage:GetSubFolderList(folderPath) end

---Returns list of media and file listings in the given absolute folder path.
---Media entries may be logically consolidated.
---@param folderPath string
---@return string[]
function MediaStorage:GetFileList(folderPath) end

---Expands and displays the given file or folder path in Media Storage.
---@param path string
---@return boolean
function MediaStorage:RevealInStorage(path) end

---Adds one or more file/folder paths to the current Media Pool folder.
---Returns a list of created MediaPoolItems.
---@vararg string
---@return fu.MediaPoolItem[]
function MediaStorage:AddItemListToMediaPool(...) end

---Adds an array of file/folder paths to the current Media Pool folder.
---Returns a list of created MediaPoolItems.
---@param items string[]
---@return fu.MediaPoolItem[]
function MediaStorage:AddItemListToMediaPool(items) end

---Adds itemInfos (media with optional frame ranges) to the Media Pool.
---Each itemInfo should contain: { media = string, startFrame = integer, endFrame = integer }.
---Returns a list of created MediaPoolItems.
---@param items fu.MediaStorageItemInfo[]
---@return fu.MediaPoolItem[]
function MediaStorage:AddItemListToMediaPool(items) end

---Adds specified media files as mattes to a MediaPoolItem.
---Optionally specify stereoEye ("left" or "right") for stereo clips.
---@param mediaPoolItem fu.MediaPoolItem
---@param paths string[]
---@param stereoEye? string
---@return boolean
function MediaStorage:AddClipMattesToMediaPool(mediaPoolItem, paths, stereoEye) end

---Adds specified media files as timeline mattes in the current Media Pool folder.
---Returns a list of created MediaPoolItems.
---@param paths string[]
---@return fu.MediaPoolItem[]
function MediaStorage:AddTimelineMattesToMediaPool(paths) end