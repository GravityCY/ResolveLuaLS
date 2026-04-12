---@meta

---@class fu.Project
local Project = {};

---Returns the Media Pool object.
---@return fu.MediaPool
function Project:GetMediaPool() end

---Returns the number of timelines currently present in the project.
---@return integer
function Project:GetTimelineCount() end

---Returns timeline at the given index (1 <= idx <= GetTimelineCount()).
---@param idx integer
---@return fu.Timeline
function Project:GetTimelineByIndex(idx) end

---Returns the currently loaded timeline.
---@return fu.Timeline
function Project:GetCurrentTimeline() end

---Sets given timeline as current timeline for the project.
---Returns true if successful.
---@param timeline fu.Timeline
---@return boolean
function Project:SetCurrentTimeline(timeline) end

---Returns the Gallery object.
---@return fu.Gallery
function Project:GetGallery() end

---Returns project name.
---@return string
function Project:GetName() end

---Sets project name if the given name is unique.
---@param projectName string
---@return boolean
function Project:SetName(projectName) end

---Returns a list of presets and their information.
---@return table
function Project:GetPresetList() end

---Sets preset by given name into project.
---@param presetName string
---@return boolean
function Project:SetPreset(presetName) end

---Adds a render job based on current settings to the render queue.
---Returns a unique job ID.
---@return string
function Project:AddRenderJob() end

---Deletes render job for the given job ID.
---@param jobId string
---@return boolean
function Project:DeleteRenderJob(jobId) end

---Deletes all render jobs in the queue.
---@return boolean
function Project:DeleteAllRenderJobs() end

---Returns a list of render jobs and their information.
---@return table
function Project:GetRenderJobList() end

---Returns a list of render presets and their information.
---@return table
function Project:GetRenderPresetList() end

---Starts rendering jobs indicated by the given job IDs.
---
---@vararg string
---@return boolean
function Project:StartRendering(...) end

--- Starts rendering jobs indicated by the input job ids.
--- 
--- The optional "isInteractiveMode", when set, enables error feedback in the UI during rendering.
---@param jobIds string[]
---@param isInteractiveMode boolean?
---@return boolean
function Project:StartRendering(jobIds, isInteractiveMode) end

--- Starts rendering all queued render jobs.
---@param isInteractiveMode boolean?
---@return boolean
function Project:StartRendering(isInteractiveMode) end

---Stops any current render processes.
---@return nil
function Project:StopRendering() end

---Returns true if rendering is currently in progress.
---@return boolean
function Project:IsRenderingInProgress() end

---Loads a render preset by name if it exists.
---@param presetName string
---@return boolean
function Project:LoadRenderPreset(presetName) end

---Creates a new render preset with the given name if unique.
---@param presetName string
---@return boolean
function Project:SaveAsNewRenderPreset(presetName) end

---Deletes the render preset with the given name.
---@param presetName string
---@return boolean
function Project:DeleteRenderPreset(presetName) end

---Sets rendering settings using a key-value table.
---@param settings table
---@return boolean
function Project:SetRenderSettings(settings) end

---Returns status and completion percentage of a render job.
---@param jobId string
---@return table
function Project:GetRenderJobStatus(jobId) end

---Returns a list of Quick Export render preset names.
---@return string[]
function Project:GetQuickExportRenderPresets() end

---Starts a quick export render for the current timeline.
---Returns status info or an error string on failure.
---@param preset_name string
---@param param_dict table
---@return table|string
function Project:RenderWithQuickExport(preset_name, param_dict) end

---Returns value of a project setting.
---@param settingName string
---@return string
function Project:GetSetting(settingName) end

---Sets a project setting to the given value.
---@param settingName string
---@param settingValue string
---@return boolean
function Project:SetSetting(settingName, settingValue) end

---Returns available render formats (format -> file extension).
---@return table<string, string>
function Project:GetRenderFormats() end

---Returns available codecs for a given render format.
---@param renderFormat string
---@return table<string, string>
function Project:GetRenderCodecs(renderFormat) end

---Returns the currently selected render format and codec.
---@return {format: string, codec: string}
function Project:GetCurrentRenderFormatAndCodec() end

---Sets the render format and codec for rendering.
---@param format string
---@param codec string
---@return boolean
function Project:SetCurrentRenderFormatAndCodec(format, codec) end

---Returns the current render mode (0 = Individual clips, 1 = Single clip).
---@return integer
function Project:GetCurrentRenderMode() end

---Sets the render mode (0 = Individual clips, 1 = Single clip).
---@param renderMode integer
---@return boolean
function Project:SetCurrentRenderMode(renderMode) end

---Returns available resolutions for given format and codec.
---If none provided, returns all available resolutions.
---@param format? string
---@param codec? string
---@return {Width: integer, Height: integer}[]
function Project:GetRenderResolutions(format, codec) end

---Refreshes the LUT list.
---@return boolean
function Project:RefreshLUTList() end

---Returns a unique ID for the project.
---@return string
function Project:GetUniqueId() end

---Inserts audio into the current track at the playhead.
---@param mediaPath string
---@param startOffsetInSamples integer
---@param durationInSamples integer
---@return boolean
function Project:InsertAudioToCurrentTrackAtPlayhead(mediaPath, startOffsetInSamples, durationInSamples) end

---Loads a burn-in preset by name.
---@param presetName string
---@return boolean
function Project:LoadBurnInPreset(presetName) end

---Exports the current frame as a still image to the given file path.
---@param filePath string
---@return boolean
function Project:ExportCurrentFrameAsStill(filePath) end

---Returns a list of all color groups in the timeline.
---@return fu.ColorGroup[]
function Project:GetColorGroupsList() end

---Creates a new color group with a unique name.
---@param groupName string
---@return fu.ColorGroup
function Project:AddColorGroup(groupName) end

---Deletes the given color group and ungroups clips.
---@param colorGroup fu.ColorGroup
---@return boolean
function Project:DeleteColorGroup(colorGroup) end

---Applies a Fairlight preset to the current timeline.
---@param name string
---@return boolean
function Project:ApplyFairlightPresetToCurrentTimeline(name) end