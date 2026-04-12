---@meta

---Language selection for auto subtitle generation.
---@alias fu.AutoCaptionLanguage
---| "AUTO"
---| "DANISH"
---| "DUTCH"
---| "ENGLISH"
---| "FRENCH"
---| "GERMAN"
---| "ITALIAN"
---| "JAPANESE"
---| "KOREAN"
---| "MANDARIN_SIMPLIFIED"
---| "MANDARIN_TRADITIONAL"
---| "NORWEGIAN"
---| "PORTUGUESE"
---| "RUSSIAN"
---| "SPANISH"
---| "SWEDISH"

---Subtitle styling preset used during auto-caption generation.
---@alias fu.AutoCaptionPreset
---| "SUBTITLE_DEFAULT"
---| "TELETEXT"
---| "NETFLIX"

---Defines how subtitle line breaks are structured.
---@alias fu.AutoCaptionLineBreak
---| "SINGLE"
---| "DOUBLE"

---Settings used for generating subtitles from audio using AI transcription.
---
---Note: Some default values change dynamically depending on combinations of language and preset,
---as defined by DaVinci Resolve UI behavior.
---@class fu.AutoCaptionSettings
---
---Language used for speech recognition.
---Default: AUTO
---@field language fu.AutoCaptionLanguage?
---
---Subtitle styling preset applied during generation.
---Default: SUBTITLE_DEFAULT
---@field preset fu.AutoCaptionPreset?
---
---Maximum number of characters per line.
---Range: 1–60
---Default: 42 (may change based on language/preset combination)
---@field charsPerLine integer?
---
---Line break behavior for generated subtitles.
---Default: SINGLE
---@field lineBreak fu.AutoCaptionLineBreak?
---
---Gap between subtitle blocks.
---Range: 0–10
---Default: 0
---@field gap integer?

---Options used when importing a timeline from an external file format (AAF, EDL, XML, FCPXML, DRT, ADL, OTIO).
---
---This struct controls how Resolve links media, interprets metadata, and builds timeline structure during import.
---All fields are optional and have documented default values when omitted.
---@class fu.TimelineImportOptions
---
---Whether source clips should be automatically imported into the Media Pool.
---Default: true
---@field autoImportSourceClipsIntoMediaPool boolean?
---
---If true, ignores file extensions when matching source media.
---Useful when conforming media with mismatched extensions.
---Default: false
---@field ignoreFileExtensionsWhenMatching boolean?
---
---Enables linking to source camera files instead of existing media pool clips.
---Default: false
---@field linkToSourceCameraFiles boolean?
---
---Applies sizing and transform information from the imported timeline file.
---Default: false
---@field useSizingInfo boolean?
---
---Imports multi-channel audio tracks as linked groups.
---Default: false
---@field importMultiChannelAudioTracksAsLinkedGroups boolean?
---
---Whether to insert additional tracks during import if required.
---Default: true
---@field insertAdditionalTracks boolean?
---
---Timecode offset applied when inserting clips into the timeline.
---Only used when insertAdditionalTracks is false.
---Format: "HH:MM:SS:FF"
---Default: "00:00:00:00"
---@field insertWithOffset string?
---
---Filesystem path used to locate source clips if original media paths are invalid.
---Only used when ignoreFileExtensionsWhenMatching is true.
---@field sourceClipsPath string?
---
---List of Media Pool folders used to search for missing source clips.
---Only used when importSourceClips is false.
---@field sourceClipsFolders fu.Folder[]?

---Optional configuration for creating a compound clip.
---
---Used to define metadata and timeline placement information for the newly created compound clip.
---If omitted, Resolve will use default naming and timing behavior.
---@class fu.CompoundClipInfo
---
---Optional name assigned to the compound clip.
---If not provided, Resolve will auto-generate a name.
---@field name string?
---
---Optional start timecode for the compound clip.
---Format: "HH:MM:SS:FF"
---If omitted, timeline default start is used.
---@field startTimecode string?

---Represents a decoded thumbnail image returned from the current clip in the Color page.
---
---The image is raw RGB 8-bit pixel data encoded as a base64 string.
---Dimensions and format metadata are included for decoding.
---@class fu.ThumbnailImage
---
---Width of the thumbnail in pixels.
---@field width integer
---
---Height of the thumbnail in pixels.
---@field height integer
---
---Pixel format of the image data (e.g. "RGB").
---@field format string
---
---Base64 encoded raw image buffer (RGB 8-bit).
---Must be decoded before use.
---@field data string

---Map of timeline markers indexed by frame position.
---Used by Timeline:GetMarkers() and TimelineItem:GetMarkers().
---
---Key = frame position (frameId)
---Value = fu.TimelineMarker
---
---Example:
---{
---  [96] = {
---    color = "Green",
---    duration = 1.0,
---    name = "Marker 1",
---    note = "",
---    customData = ""
---  }
---}
---@alias fu.TimelineMarkerMap table<integer, fu.TimelineMarker>

---Represents a single marker on a timeline or timeline item.
---@class fu.TimelineMarker
---
---Display color of the marker.
---@field color string
---
---Duration of the marker in frames.
---@field duration number
---
---User-defined display name of the marker.
---@field name string
---
---Optional user note attached to the marker.
---@field note string
---
---Optional custom metadata string for scripting use.
---@field customData string

---Options used when adding a new track to a Timeline via Timeline:AddTrack.
---
---Behavior depends on trackType:
--- - "video"    → only index is relevant
--- - "subtitle" → only index is relevant
--- - "audio"    → supports audioType + index
---
---Defaults:
--- - audioType = "mono" (for audio tracks)
--- - index = append to end of track list if omitted or out of bounds
---@class fu.TimelineAddTrackOptions
---
---Specifies audio channel layout for newly created audio tracks.
---Only used when trackType = "audio".
---@field audioType fu.AudioTrackSubType|nil
---
---Optional insertion index for the new track.
---If nil or out of valid range, track is appended.
---@field index integer|nil

---@alias fu.TrackType
---|"video"
---|"audio"
---|"subtitle"

---Defines audio track channel layout types used in Timeline:AddTrack.
---@alias fu.AudioTrackSubType
---| "mono"
---| "stereo"
---| "lrc"
---| "lcr"
---| "lrcs"
---| "lcrs"
---| "quad"
---| "5.0"
---| "5.0film"
---| "5.1"
---| "5.1film"
---| "7.0"
---| "7.0film"
---| "7.1"
---| "7.1film"
---| "adaptive1"
---| "adaptive2"
---| "adaptive3"
---| "adaptive4"
---| "adaptive5"
---| "adaptive6"
---| "adaptive7"
---| "adaptive8"
---| "adaptive9"
---| "adaptive10"
---| "adaptive11"
---| "adaptive12"
---| "adaptive13"
---| "adaptive14"
---| "adaptive15"
---| "adaptive16"
---| "adaptive17"
---| "adaptive18"
---| "adaptive19"
---| "adaptive20"
---| "adaptive21"
---| "adaptive22"
---| "adaptive23"
---| "adaptive24"
---| "adaptive25"
---| "adaptive26"
---| "adaptive27"
---| "adaptive28"
---| "adaptive29"
---| "adaptive30"
---| "adaptive31"
---| "adaptive32"
---| "adaptive33"
---| "adaptive34"
---| "adaptive35"
---| "adaptive36"

---@alias fu.MarkerColor
---|"Red"
---|"Green"
---|"Blue"
---|"Yellow"
---|"Cyan"
---|"Orange"
---|"Purple"
---|"Pink"
---|"White"
---|"All"

---@alias fu.MarkType
---|"video"
---|"audio"
---|"all"

---@alias fu.StillFrameSource
---|1 -- First frame
---|2 -- Middle frame

---@alias fu.DolbyVisionAnalysisType
---|0
---|1 -- resolve.DLB_BLEND_SHOTS (as per API note)

---@class fu.Timeline
local Timeline = {};

---Returns the timeline name.
---@return string
function Timeline:GetName() end

---Sets the timeline name if it is unique.
---@param timelineName string
---@return boolean
function Timeline:SetName(timelineName) end

---Returns the start frame of the timeline.
---@return integer
function Timeline:GetStartFrame() end

---Returns the end frame of the timeline.
---@return integer
function Timeline:GetEndFrame() end

---Sets the start timecode of the timeline.
---@param timecode string
---@return boolean
function Timeline:SetStartTimecode(timecode) end

---Returns the start timecode of the timeline.
---@return string
function Timeline:GetStartTimecode() end

---Returns number of tracks for a given track type.
---@param trackType fu.TrackType
---@return integer
function Timeline:GetTrackCount(trackType) end

---Adds a track with subtype (audio/video/subtitle).
---@param trackType fu.TrackType
---@param subTrackType fu.AudioTrackSubType
---@return boolean
function Timeline:AddTrack(trackType, subTrackType) end

---Adds a track using options.
---@param trackType fu.TrackType
---@param newTrackOptions fu.TimelineAddTrackOptions
---@return boolean
function Timeline:AddTrack(trackType, newTrackOptions) end

---Deletes a track.
---@param trackType fu.TrackType
---@param trackIndex integer
---@return boolean
function Timeline:DeleteTrack(trackType, trackIndex) end

---Returns audio track subtype.
---@param trackType fu.TrackType
---@param trackIndex integer
---@return fu.AudioTrackSubType
function Timeline:GetTrackSubType(trackType, trackIndex) end

---Enables or disables a track.
---@param trackType fu.TrackType
---@param trackIndex integer
---@param enabled boolean
---@return boolean
function Timeline:SetTrackEnable(trackType, trackIndex, enabled) end

---Returns whether track is enabled.
---@param trackType fu.TrackType
---@param trackIndex integer
---@return boolean
function Timeline:GetIsTrackEnabled(trackType, trackIndex) end

---Locks or unlocks a track.
---@param trackType fu.TrackType
---@param trackIndex integer
---@param locked boolean
---@return boolean
function Timeline:SetTrackLock(trackType, trackIndex, locked) end

---Returns whether track is locked.
---@param trackType fu.TrackType
---@param trackIndex integer
---@return boolean
function Timeline:GetIsTrackLocked(trackType, trackIndex) end

---Deletes timeline items.
---@param timelineItems fu.TimelineItem[]
---@param ripple? boolean
---@return boolean
function Timeline:DeleteClips(timelineItems, ripple) end

---Links or unlinks timeline items.
---@param timelineItems fu.TimelineItem[]
---@param linked boolean
---@return boolean
function Timeline:SetClipsLinked(timelineItems, linked) end

---Returns items in a track.
---@param trackType fu.TrackType
---@param index integer
---@return fu.TimelineItem[]
function Timeline:GetItemListInTrack(trackType, index) end

---Adds a marker to the timeline.
---@param frameId number
---@param color fu.MarkerColor
---@param name string
---@param note string
---@param duration number
---@param customData? string
---@return boolean
function Timeline:AddMarker(frameId, color, name, note, duration, customData) end

---Returns all markers.
---@return fu.TimelineMarkerMap
function Timeline:GetMarkers() end

---Returns marker by custom data.
---@param customData string
---@return fu.TimelineMarker
function Timeline:GetMarkerByCustomData(customData) end

---Updates marker custom data.
---@param frameId number
---@param customData string
---@return boolean
function Timeline:UpdateMarkerCustomData(frameId, customData) end

---Returns marker custom data.
---@param frameId number
---@return string
function Timeline:GetMarkerCustomData(frameId) end

---Deletes markers by color.
---@param color fu.MarkerColor | "All"
---@return boolean
function Timeline:DeleteMarkersByColor(color) end

---Deletes marker at frame.
---@param frameNum number
---@return boolean
function Timeline:DeleteMarkerAtFrame(frameNum) end

---Deletes marker by custom data.
---@param customData string
---@return boolean
function Timeline:DeleteMarkerByCustomData(customData) end

---Returns current playhead timecode.
---@return string
function Timeline:GetCurrentTimecode() end

---Sets playhead timecode.
---@param timecode string
---@return boolean
function Timeline:SetCurrentTimecode(timecode) end

---Returns current video item. (The video item under the playhead)
---@return fu.TimelineItem
function Timeline:GetCurrentVideoItem() end

---Returns thumbnail image data.
---@return fu.ThumbnailImage
function Timeline:GetCurrentClipThumbnailImage() end

---Returns track name.
---@param trackType fu.TrackType
---@param trackIndex integer
---@return string
function Timeline:GetTrackName(trackType, trackIndex) end

---Sets track name.
---@param trackType fu.TrackType
---@param trackIndex integer
---@param name string
---@return boolean
function Timeline:SetTrackName(trackType, trackIndex, name) end

---Duplicates timeline.
---@param timelineName? string
---@return fu.Timeline
function Timeline:DuplicateTimeline(timelineName) end

---Creates compound clip.
---@param timelineItems fu.TimelineItem[]
---@param clipInfo? fu.CompoundClipInfo
---@return fu.TimelineItem
function Timeline:CreateCompoundClip(timelineItems, clipInfo) end

---Creates fusion clip.
---@param timelineItems fu.TimelineItem[]
---@return fu.TimelineItem
function Timeline:CreateFusionClip(timelineItems) end

---Imports timeline.
---@param filePath string
---@param importOptions? fu.TimelineImportOptions
---@return boolean
function Timeline:ImportIntoTimeline(filePath, importOptions) end

---Exports timeline.
---@param fileName string
---@param exportType string
---@param exportSubtype string
---@return boolean
function Timeline:Export(fileName, exportType, exportSubtype) end

---Gets setting.
---@param settingName string
---@return string
function Timeline:GetSetting(settingName) end

---Sets setting.
---@param settingName string
---@param settingValue string
---@return boolean
function Timeline:SetSetting(settingName, settingValue) end

---Inserts generator.
---@param generatorName string
---@return fu.TimelineItem
function Timeline:InsertGeneratorIntoTimeline(generatorName) end

---Inserts Fusion generator.
---@param generatorName string
---@return fu.TimelineItem
function Timeline:InsertFusionGeneratorIntoTimeline(generatorName) end

---Inserts Fusion composition.
---@return fu.TimelineItem
function Timeline:InsertFusionCompositionIntoTimeline() end

---Inserts OFX generator.
---@param generatorName string
---@return fu.TimelineItem
function Timeline:InsertOFXGeneratorIntoTimeline(generatorName) end

---Inserts title.
---@param titleName string
---@return fu.TimelineItem
function Timeline:InsertTitleIntoTimeline(titleName) end

---Inserts Fusion title.
---@param titleName string
---@return fu.TimelineItem
function Timeline:InsertFusionTitleIntoTimeline(titleName) end

---Grabs still.
---@return fu.GalleryStill
function Timeline:GrabStill() end

---Grabs all stills.
---@param stillFrameSource fu.StillFrameSource
---@return fu.GalleryStill[]
function Timeline:GrabAllStills(stillFrameSource) end

---Returns unique ID.
---@return string
function Timeline:GetUniqueId() end

---Creates subtitles from audio.
---@param autoCaptionSettings? fu.AutoCaptionSettings
---@return boolean
function Timeline:CreateSubtitlesFromAudio(autoCaptionSettings) end

---Detects scene cuts.
---@return boolean
function Timeline:DetectSceneCuts() end

---Converts timeline to stereo.
---@return boolean
function Timeline:ConvertTimelineToStereo() end

---Returns node graph.
---@return fu.Graph
function Timeline:GetNodeGraph() end

---Analyzes Dolby Vision.
---@param timelineItems? fu.TimelineItem[]
---@param analysisType? fu.DolbyVisionAnalysisType
---@return boolean
function Timeline:AnalyzeDolbyVision(timelineItems, analysisType) end

---Returns MediaPoolItem.
---@return fu.MediaPoolItem
function Timeline:GetMediaPoolItem() end

---Returns mark in/out.
---@return fu.MarkInOut
function Timeline:GetMarkInOut() end

---Sets mark in/out.
---@param inPoint number
---@param outPoint number
---@param type? fu.MarkType
---@return boolean
function Timeline:SetMarkInOut(inPoint, outPoint, type) end

---Clears mark in/out.
---@param type? fu.MarkType
---@return boolean
function Timeline:ClearMarkInOut(type) end

---Gets voice isolation state.
---@param trackIndex integer
---@return fu.VoiceIsolationState
function Timeline:GetVoiceIsolationState(trackIndex) end

---Sets voice isolation state.
---@param trackIndex integer
---@param state fu.VoiceIsolationState
---@return boolean
function Timeline:SetVoiceIsolationState(trackIndex, state) end