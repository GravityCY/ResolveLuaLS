---@meta

---@alias fu.MediaPages "media"|"cut"|"edit"|"fusion"|"color"|"fairlight"|"deliver"

---@class fu.Resolve
local Resolve = {};

res = Resolve;

--- Dump anything to console
function dump(...) end

--- Returns the Fusion object. Starting point for Fusion scripts.
---@return fu.Fusion
function Resolve:Fusion() end

--- Returns the media storage object to query and act on media locations.
---@return fu.MediaStorage
function Resolve:GetMediaStorage() end

--- Returns the project manager object for currently open database.
---@return fu.ProjectManager
function Resolve:GetProjectManager() end

--- Switches to indicated page in DaVinci Resolve. Input can be one of ("media", "cut", "edit", "fusion", "color", "fairlight", "deliver").
---@param pageName fu.MediaPages
---@return boolean
function Resolve:OpenPage(pageName) end

--- Returns the page currently displayed in the main window. Returned value can be one of ("media", "cut", "edit", "fusion", "color", "fairlight", "deliver", None).
---@return fu.MediaPages
function Resolve:GetCurrentPage() end

--- Returns product name.
---@return string
function Resolve:GetProductName() end

--- Returns list of product version fields in [major, minor, patch, build, suffix] format.
---@return any[]
function Resolve:GetVersion() end

--- Returns product version in "major.minor.patch[suffix].build" format.
---@return string
function Resolve:GetVersionString() end

--- Loads UI layout from saved preset named 'presetName'.
---@param presetName string
---@return boolean
function Resolve:LoadLayoutPreset(presetName) end

--- Overwrites preset named 'presetName' with current UI layout.
---@param presetName string
---@return boolean
function Resolve:UpdateLayoutPreset(presetName) end

--- Exports preset named 'presetName' to path 'presetFilePath'.
---@param presetName string
---@param presetFilePath string
---@return boolean
function Resolve:ExportLayoutPreset(presetName, presetFilePath) end

--- Deletes preset named 'presetName'.
---@param presetName string
---@return boolean
function Resolve:DeleteLayoutPreset(presetName) end

--- Saves current UI layout as a preset named 'presetName'.
---@return boolean
function Resolve:SaveLayoutPreset(presetName) end

--- Imports preset from path 'presetFilePath'. The optional argument 'presetName' specifies how the preset shall be named. If not specified, the preset is named based on the filename.
---@return boolean
function Resolve:ImportLayoutPreset(presetFilePath, presetName) end

--- Quits the Resolve App.
function Resolve:Quit() end

--- Import a preset from presetPath (string) and set it as current preset for rendering.
---@param presetPath string
---@return boolean
function Resolve:ImportRenderPreset(presetPath) end

--- Export a preset to a given path (string) if presetName(string) exists.
---@param presetName string
---@param exportPath string
---@return boolean
function Resolve:ExportRenderPreset(presetName, exportPath) end

--- Import a data burn in preset from a given presetPath (string)
---@param presetPath string
---@return boolean
function Resolve:ImportBurnInPreset(presetPath) end

--- Export a data burn in preset to a given path (string) if presetName (string) exists.
---@param presetName string
---@param exportPath string
---@return boolean
function Resolve:ExportBurnInPreset(presetName, exportPath) end

--- Returns the currently set keyframe mode (int). Refer to section 'Keyframe Mode information' below for details.
---@return integer
function Resolve:GetKeyframeMode() end

--- Returns True when 'keyframeMode'(enum) is successfully set. Refer to section 'Keyframe Mode information' below for details.
---@param keyframeMode integer
---@return boolean
function Resolve:SetKeyframeMode(keyframeMode) end

--- Returns a list of Fairlight presets by name
---@return string[]
function Resolve:GetFairlightPresets() end
