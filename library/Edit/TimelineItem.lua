---@meta

---@class fu.TimelineItem
local TimelineItem = {};

---Returns the item name.
---@return string
function TimelineItem:GetName() end

---Sets the clip name.
---@param name string
---@return boolean
function TimelineItem:SetName(name) end

---Returns duration (frames or float if subframe precision enabled).
---@param subframe_precision? boolean
---@return integer|number
function TimelineItem:GetDuration(subframe_precision) end

---Returns end frame.
---@param subframe_precision? boolean
---@return integer|number
function TimelineItem:GetEnd(subframe_precision) end

---Returns source end frame.
---@return integer
function TimelineItem:GetSourceEndFrame() end

---Returns source end time.
---@return number
function TimelineItem:GetSourceEndTime() end

---Returns number of Fusion comps.
---@return integer
function TimelineItem:GetFusionCompCount() end

---Gets Fusion comp by index.
---@param compIndex integer
---@return fu.Comp
function TimelineItem:GetFusionCompByIndex(compIndex) end

---Returns Fusion comp name list.
---@return string[]
function TimelineItem:GetFusionCompNameList() end

---Gets Fusion comp by name.
---@param compName string
---@return fu.Comp
function TimelineItem:GetFusionCompByName(compName) end

---Returns left trim offset.
---@param subframe_precision? boolean
---@return integer|number
function TimelineItem:GetLeftOffset(subframe_precision) end

---Returns right trim offset.
---@param subframe_precision? boolean
---@return integer|number
function TimelineItem:GetRightOffset(subframe_precision) end

---Returns start frame.
---@param subframe_precision? boolean
---@return integer|number
function TimelineItem:GetStart(subframe_precision) end

---Returns source start frame.
---@return integer
function TimelineItem:GetSourceStartFrame() end

---Returns source start time.
---@return number
function TimelineItem:GetSourceStartTime() end

---Sets property value.
---@param propertyKey string
---@param propertyValue string|number
---@return boolean
function TimelineItem:SetProperty(propertyKey, propertyValue) end

---Gets property value or full property map.
---@param propertyKey? string
---@return table
function TimelineItem:GetProperty(propertyKey) end

---Adds marker.
---@param frameId number
---@param color fu.MarkerColor
---@param name string
---@param note string
---@param duration number
---@param customData? string
---@return boolean
function TimelineItem:AddMarker(frameId, color, name, note, duration, customData) end

---Returns all markers.
---@return fu.TimelineMarkerMap
function TimelineItem:GetMarkers() end

---Returns marker by custom data.
---@param customData string
---@return fu.TimelineMarker
function TimelineItem:GetMarkerByCustomData(customData) end

---Updates marker custom data.
---@param frameId number
---@param customData string
---@return boolean
function TimelineItem:UpdateMarkerCustomData(frameId, customData) end

---Gets marker custom data.
---@param frameId number
---@return string
function TimelineItem:GetMarkerCustomData(frameId) end

---Deletes markers by color.
---@param color fu.MarkerColor | "All"
---@return boolean
function TimelineItem:DeleteMarkersByColor(color) end

---Deletes marker at frame.
---@param frameNum number
---@return boolean
function TimelineItem:DeleteMarkerAtFrame(frameNum) end

---Deletes marker by custom data.
---@param customData string
---@return boolean
function TimelineItem:DeleteMarkerByCustomData(customData) end

---@param color string
---@return boolean
function TimelineItem:AddFlag(color) end

---@return string[]
function TimelineItem:GetFlagList() end

---@param color string | "All"
---@return boolean
function TimelineItem:ClearFlags(color) end

---@return string
function TimelineItem:GetClipColor() end

---@param colorName string
---@return boolean
function TimelineItem:SetClipColor(colorName) end

---@return boolean
function TimelineItem:ClearClipColor() end

---@return fu.Comp
function TimelineItem:AddFusionComp() end

---@param path string
---@return fu.Comp
function TimelineItem:ImportFusionComp(path) end

---@param path string
---@param compIndex integer
---@return boolean
function TimelineItem:ExportFusionComp(path, compIndex) end

---@param compName string
---@return boolean
function TimelineItem:DeleteFusionCompByName(compName) end

---@param compName string
---@return fu.Comp
function TimelineItem:LoadFusionCompByName(compName) end

---@param oldName string
---@param newName string
---@return boolean
function TimelineItem:RenameFusionCompByName(oldName, newName) end

---@param versionName string
---@param versionType integer
---@return boolean
function TimelineItem:AddVersion(versionName, versionType) end

---@return fu.ColorVersion
function TimelineItem:GetCurrentVersion() end

---@param versionName string
---@param versionType integer
---@return boolean
function TimelineItem:DeleteVersionByName(versionName, versionType) end

---@param versionName string
---@param versionType integer
---@return boolean
function TimelineItem:LoadVersionByName(versionName, versionType) end

---@param oldName string
---@param newName string
---@param versionType integer
---@return boolean
function TimelineItem:RenameVersionByName(oldName, newName, versionType) end

---@param versionType integer
---@return string[]
function TimelineItem:GetVersionNameList(versionType) end

---@return fu.MediaPoolItem
function TimelineItem:GetMediaPoolItem() end

---@return string
function TimelineItem:GetUniqueId() end

---@param mediaPoolItem fu.MediaPoolItem
---@param startFrame? integer
---@param endFrame? integer
---@return boolean
function TimelineItem:AddTake(mediaPoolItem, startFrame, endFrame) end

---@return integer
function TimelineItem:GetSelectedTakeIndex() end

---@return integer
function TimelineItem:GetTakesCount() end

---@param idx integer
---@return fu.TakeInfo
function TimelineItem:GetTakeByIndex(idx) end

---@param idx integer
---@return boolean
function TimelineItem:DeleteTakeByIndex(idx) end

---@param idx integer
---@return boolean
function TimelineItem:SelectTakeByIndex(idx) end

---@return boolean
function TimelineItem:FinalizeTake() end

---@param items fu.TimelineItem[]
---@return boolean
function TimelineItem:CopyGrades(items) end

---@param enabled boolean
---@return boolean
function TimelineItem:SetClipEnabled(enabled) end

---@return boolean
function TimelineItem:GetClipEnabled() end

---@return boolean
function TimelineItem:Stabilize() end

---@param mode string
---@return boolean
function TimelineItem:CreateMagicMask(mode) end

---@return boolean
function TimelineItem:RegenerateMagicMask() end

---@return boolean
function TimelineItem:SmartReframe() end

---@param layerIdx? integer
---@return fu.Graph
function TimelineItem:GetNodeGraph(layerIdx) end

---@return fu.ColorGroup
function TimelineItem:GetColorGroup() end

---@param group fu.ColorGroup
---@return boolean
function TimelineItem:AssignToColorGroup(group) end

---@return boolean
function TimelineItem:RemoveFromColorGroup() end

---@param exportType integer
---@param path string
---@return boolean
function TimelineItem:ExportLUT(exportType, path) end

---@return fu.TimelineItem[]
function TimelineItem:GetLinkedItems() end

---@return fu.TrackType, integer
function TimelineItem:GetTrackTypeAndIndex() end

---@return string
function TimelineItem:GetSourceAudioChannelMapping() end

---@return fu.CacheState
function TimelineItem:GetIsColorOutputCacheEnabled() end

---@return fu.CacheState
function TimelineItem:GetIsFusionOutputCacheEnabled() end

---@param state fu.CacheState
---@return boolean
function TimelineItem:SetColorOutputCache(state) end

---@param state fu.CacheState
---@return boolean
function TimelineItem:SetFusionOutputCache(state) end

---@return fu.VoiceIsolationState
function TimelineItem:GetVoiceIsolationState() end

---@param state fu.VoiceIsolationState
---@return boolean
function TimelineItem:SetVoiceIsolationState(state) end