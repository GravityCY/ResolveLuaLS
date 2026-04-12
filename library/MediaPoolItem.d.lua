---@meta

---@class fu.MediaPoolItem
local MediaPoolItem = {};

---Returns the clip name.
---@return string
function MediaPoolItem:GetName() end

---Sets the clip name.
---@param name string
---@return boolean
function MediaPoolItem:SetName(name) end

---Returns metadata for a key, or all metadata if no key is provided.
---@param metadataType? string
---@return string|table
function MediaPoolItem:GetMetadata(metadataType) end

---Sets metadata value for a given key.
---@param metadataType string
---@param metadataValue string
---@return boolean
function MediaPoolItem:SetMetadata(metadataType, metadataValue) end

---Sets multiple metadata values using a dictionary.
---@param metadata table
---@return boolean
function MediaPoolItem:SetMetadata(metadata) end

---Returns third-party metadata for a key, or all if no key provided.
---@param metadataType? string
---@return string|table
function MediaPoolItem:GetThirdPartyMetadata(metadataType) end

---Sets a third-party metadata value for a given key.
---@param metadataType string
---@param metadataValue string
---@return boolean
function MediaPoolItem:SetThirdPartyMetadata(metadataType, metadataValue) end

---Sets multiple third-party metadata values using a dictionary.
---@param metadata table
---@return boolean
function MediaPoolItem:SetThirdPartyMetadata(metadata) end

---Returns the unique ID for the MediaPoolItem.
---@return string
function MediaPoolItem:GetMediaId() end

---Creates a marker at the given frame with metadata.
---@param frameId number
---@param color string
---@param name string
---@param note string
---@param duration number
---@param customData? string
---@return boolean
function MediaPoolItem:AddMarker(frameId, color, name, note, duration, customData) end

---Returns all markers as a map of frameId -> marker info.
---@return table<number, table>
function MediaPoolItem:GetMarkers() end

---Returns marker information for the first marker matching custom data.
---@param customData string
---@return table
function MediaPoolItem:GetMarkerByCustomData(customData) end

---Updates custom data for a marker at a given frame.
---@param frameId number
---@param customData string
---@return boolean
function MediaPoolItem:UpdateMarkerCustomData(frameId, customData) end

---Returns custom data for a marker at a given frame.
---@param frameId number
---@return string
function MediaPoolItem:GetMarkerCustomData(frameId) end

---Deletes markers by color (or all if "All").
---@param color string
---@return boolean
function MediaPoolItem:DeleteMarkersByColor(color) end

---Deletes marker at a specific frame.
---@param frameNum number
---@return boolean
function MediaPoolItem:DeleteMarkerAtFrame(frameNum) end

---Deletes marker matching custom data.
---@param customData string
---@return boolean
function MediaPoolItem:DeleteMarkerByCustomData(customData) end

---Adds a flag to the clip.
---@param color string
---@return boolean
function MediaPoolItem:AddFlag(color) end

---Returns list of flag colors.
---@return string[]
function MediaPoolItem:GetFlagList() end

---Clears a flag by color, or all flags if "All".
---@param color string
---@return boolean
function MediaPoolItem:ClearFlags(color) end

---Returns clip color.
---@return string
function MediaPoolItem:GetClipColor() end

---Sets clip color.
---@param colorName string
---@return boolean
function MediaPoolItem:SetClipColor(colorName) end

---Clears clip color.
---@return boolean
function MediaPoolItem:ClearClipColor() end

---Returns clip properties or a specific property.
---@param propertyName? string
---@return string|table
function MediaPoolItem:GetClipProperty(propertyName) end

---Sets a clip property value.
---@param propertyName string
---@param propertyValue string
---@return boolean
function MediaPoolItem:SetClipProperty(propertyName, propertyValue) end

---Links proxy media to this clip.
---@param proxyMediaFilePath string
---@return boolean
function MediaPoolItem:LinkProxyMedia(proxyMediaFilePath) end

---Links full-resolution media to this clip.
---@param fullResMediaPath string
---@return boolean
function MediaPoolItem:LinkFullResolutionMedia(fullResMediaPath) end

---Unlinks proxy media from this clip.
---@return boolean
function MediaPoolItem:UnlinkProxyMedia() end

---Replaces the clip with a new media file.
---@param filePath string
---@return boolean
function MediaPoolItem:ReplaceClip(filePath) end

---Replaces clip while preserving subclip ranges.
---@param filePath string
---@return boolean
function MediaPoolItem:ReplaceClipPreserveSubClip(filePath) end

---Returns unique ID for the MediaPoolItem.
---@return string
function MediaPoolItem:GetUniqueId() end

---Transcribes audio for this clip.
---@return boolean
function MediaPoolItem:TranscribeAudio() end

---Clears transcription for this clip.
---@return boolean
function MediaPoolItem:ClearTranscription() end

---Returns audio mapping as JSON string.
---@return string
function MediaPoolItem:GetAudioMapping() end

---Returns mark in/out information.
---@return table
function MediaPoolItem:GetMarkInOut() end

---Sets mark in/out range.
---@param inPoint number
---@param outPoint number
---@param type? string
---@return boolean
function MediaPoolItem:SetMarkInOut(inPoint, outPoint, type) end

---Clears mark in/out range.
---@param type? string
---@return boolean
function MediaPoolItem:ClearMarkInOut(type) end

---Monitors a growing media file.
---@return boolean
function MediaPoolItem:MonitorGrowingFile() end