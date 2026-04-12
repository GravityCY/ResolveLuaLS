---@meta

---@class fu.Folder
local Folder = {};

---Returns a list of clips (items) within the folder.
---@return fu.MediaPoolItem[]
function Folder:GetClipList() end

---Returns the media folder name.
---@return string
function Folder:GetName() end

---Returns a list of subfolders in the folder.
---@return fu.Folder[]
function Folder:GetSubFolderList() end

---Returns true if the folder is stale in collaboration mode.
---@return boolean
function Folder:GetIsFolderStale() end

---Returns a unique ID for the media pool folder.
---@return string
function Folder:GetUniqueId() end

---Exports the folder as a DRB file to the given file path.
---Returns true if successful.
---@param filePath string
---@return boolean
function Folder:Export(filePath) end

---Transcribes audio of MediaPoolItems within the folder and nested folders.
---Returns true if successful.
---@return boolean
function Folder:TranscribeAudio() end

---Clears audio transcription of MediaPoolItems within the folder and nested folders.
---Returns true if successful.
---@return boolean
function Folder:ClearTranscription() end