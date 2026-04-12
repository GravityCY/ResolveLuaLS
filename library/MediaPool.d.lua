---@meta

---Defines the audio channel used for waveform-based syncing.
---Only used when AudioSyncMode = AUDIO_SYNC_WAVEFORM.
---
---Special values:
--- - -1 = Automatic channel selection
--- - -2 = Mixed audio channel
--- - 1+ = Explicit channel index (1..channelMax)
---@alias fu.AudioSyncChannelNumber integer

---Defines how audio synchronization is performed in AutoSyncAudio.
---@alias fu.AudioSyncMode
---| "resolve.AUDIO_SYNC_WAVEFORM"  # Sync using waveform comparison
---| "resolve.AUDIO_SYNC_TIMECODE"  # Sync using timecode alignment

---Settings used for audio synchronization in MediaPool:AutoSyncAudio.
---Controls how audio and video clips are matched during sync operations.
---
---This configuration supports waveform-based or timecode-based syncing,
---along with optional metadata retention behavior.
---@class fu.MediaPoolAudioSyncSettings
---
---Defines the audio sync mode used for matching clips.
---Default: resolve.AUDIO_SYNC_TIMECODE
---@field audioSyncMode fu.AudioSyncMode|nil
---
---Defines which audio channel is used for waveform comparison.
---Used only when audioSyncMode = AUDIO_SYNC_WAVEFORM.
---Default: 1
---@field channelNumber fu.AudioSyncChannelNumber|nil
---
---If true, retains embedded audio tracks during sync operation.
---Default: false
---@field retainEmbeddedAudio boolean|nil
---
---If true, retains video metadata during sync operation.
---Default: false
---@field retainVideoMetadata boolean|nil

---Clip import specification used when importing media into the Media Pool.
---Used by MediaPool:ImportMedia({clipInfo}).
---
---Each entry defines how a file or sequence of files should be interpreted during import.
---Supports both single-file imports and frame sequence imports.
---
---If "Show Individual Frames" is enabled in Resolve, each entry may be treated differently.
---@class fu.MediaPoolImportClipInfo
---
---File path or sequence pattern to import.
---Supports:
--- - absolute file paths
--- - sequence patterns (e.g. file_%03d.dpx)
---@field FilePath string
---
---Start index for numbered file sequences.
---Used when importing image sequences.
---@field StartIndex integer|nil
---
---End index for numbered file sequences.
---Used when importing image sequences.
---@field EndIndex integer|nil

---Options used when importing a timeline from an external file.
---Used by MediaPool:ImportTimelineFromFile(filePath, importOptions).
---
---Supports multiple interchange formats:
---AAF, EDL, XML, FCPXML, DRT, ADL, OTIO
---
---Some options are format-specific (noted per field).
---@class fu.MediaPoolImportTimelineOptions
---Name of the created timeline.
---Not supported when importing DRT files.
---@field timelineName string|nil
---
---Whether source media should be imported into the media pool.
---Default: true
---Not valid for DRT imports.
---@field importSourceClips boolean|nil 
---
---Fallback filesystem path used when media is missing from original locations.
---Used only if importSourceClips = true.
---@field sourceClipsPath string|nil
---
---List of Media Pool folders used to search for missing media.
---Used only if importSourceClips = false.
---Not valid for DRT imports.
---@field sourceClipsFolders fu.Folder[]|nil
---
---Enables interlace processing for imported timelines.
---Only valid for AAF imports.
---@field interlaceProcessing boolean|nil

---Defines how a MediaPool clip is treated when appended to a timeline.
---@alias fu.MediaPoolAppendMediaType
---| 1  # Video only
---| 2  # Audio only

---Clip insertion specification used when appending clips to a timeline.
---Used by MediaPool:AppendToTimeline when passing structured clip placement data.
---
---Each entry describes how a MediaPoolItem should be inserted into the timeline,
---including timing, track placement, and optional media type filtering.
---@class fu.MediaPoolAppendClipInfo
---@field mediaPoolItem fu.MediaPoolItem The source media pool item to append to the timeline.
---@field startFrame number|integer Starting frame of the source clip range.
---@field endFrame number|integer Ending frame of the source clip range.
---@field mediaType fu.MediaPoolAppendMediaType|nil Optional. Specifies media channel usage:
--- - 1 = Video only
--- - 2 = Audio only
--- If nil, full clip is used.
---@field trackIndex integer|nil Optional. Target track index in the timeline. If nil, appends to default track.
---@field recordFrame number|integer|nil Optional. Timeline record frame where the clip should be placed.

---@class fu.MediaPool
local MediaPool = {};

---Returns the root folder of the Media Pool.
---@return fu.Folder
function MediaPool:GetRootFolder() end

---Adds a new subfolder under the specified folder with the given name.
---@param folder fu.Folder
---@param name string
---@return fu.Folder
function MediaPool:AddSubFolder(folder, name) end

---Refreshes folders (useful in collaboration mode).
---@return boolean
function MediaPool:RefreshFolders() end

---Creates a new empty timeline with the given name.
---@param name string
---@return fu.Timeline
function MediaPool:CreateEmptyTimeline(name) end

---Appends one or more MediaPoolItems to the current timeline.
---@vararg fu.MediaPoolItem
---@return fu.TimelineItem[]
function MediaPool:AppendToTimeline(...) end

---Appends an array of MediaPoolItems to the current timeline.
---@param clips fu.MediaPoolItem[]
---@return fu.TimelineItem[]
function MediaPool:AppendToTimeline(clips) end

---Appends clipInfos to the current timeline.
---Each clipInfo should contain:
---{ mediaPoolItem, startFrame, endFrame, mediaType?, trackIndex?, recordFrame? }
---@param clipInfos fu.MediaPoolAppendClipInfo[]
---@return fu.TimelineItem[]
function MediaPool:AppendToTimeline(clipInfos) end

---Creates a new timeline and appends given MediaPoolItems.
---@param name string
---@vararg fu.MediaPoolItem
---@return fu.Timeline
function MediaPool:CreateTimelineFromClips(name, ...) end

---Creates a new timeline and appends an array of MediaPoolItems.
---@param name string
---@param clips fu.MediaPoolItem[]
---@return fu.Timeline
function MediaPool:CreateTimelineFromClips(name, clips) end

---Creates a new timeline using clipInfos.
---@param name string
---@param clipInfos fu.MediaPoolAppendClipInfo[]
---@return fu.Timeline
function MediaPool:CreateTimelineFromClips(name, clipInfos) end

---Imports a timeline from file with optional import options.
---@param filePath string
---@param importOptions? fu.MediaPoolImportTimelineOptions
---@return fu.Timeline
function MediaPool:ImportTimelineFromFile(filePath, importOptions) end

---Deletes specified timelines.
---@param timelines fu.Timeline[]
---@return boolean
function MediaPool:DeleteTimelines(timelines) end

---Returns the currently selected folder.
---@return fu.Folder
function MediaPool:GetCurrentFolder() end

---Sets the current folder.
---@param folder fu.Folder
---@return boolean
function MediaPool:SetCurrentFolder(folder) end

---Deletes specified clips or timeline mattes.
---@param clips fu.MediaPoolItem[]
---@return boolean
function MediaPool:DeleteClips(clips) end

---Imports a folder from a DRB file.
---@param filePath string
---@param sourceClipsPath? string
---@return boolean
function MediaPool:ImportFolderFromFile(filePath, sourceClipsPath) end

---Deletes specified subfolders.
---@param subfolders fu.Folder[]
---@return boolean
function MediaPool:DeleteFolders(subfolders) end

---Moves specified clips to the target folder.
---@param clips fu.MediaPoolItem[]
---@param targetFolder fu.Folder
---@return boolean
function MediaPool:MoveClips(clips, targetFolder) end

---Moves specified folders to the target folder.
---@param folders fu.Folder[]
---@param targetFolder fu.Folder
---@return boolean
function MediaPool:MoveFolders(folders, targetFolder) end

---Returns matte file paths for the given MediaPoolItem.
---@param mediaPoolItem fu.MediaPoolItem
---@return string[]
function MediaPool:GetClipMatteList(mediaPoolItem) end

---Returns timeline mattes in the specified folder.
---@param folder fu.Folder
---@return fu.MediaPoolItem[]
function MediaPool:GetTimelineMatteList(folder) end

---Deletes mattes for the given MediaPoolItem using file paths.
---@param mediaPoolItem fu.MediaPoolItem
---@param paths string[]
---@return boolean
function MediaPool:DeleteClipMattes(mediaPoolItem, paths) end

---Relinks specified clips to a new folder path.
---@param clips fu.MediaPoolItem[]
---@param folderPath string
---@return boolean
function MediaPool:RelinkClips(clips, folderPath) end

---Unlinks specified clips.
---@param clips fu.MediaPoolItem[]
---@return boolean
function MediaPool:UnlinkClips(clips) end

---Imports file/folder paths into the Media Pool.
---@param items string[]
---@return fu.MediaPoolItem[]
function MediaPool:ImportMedia(items) end

---Imports media using clipInfo definitions.
---@param clipInfos fu.MediaPoolImportClipInfo[]
---@return fu.MediaPoolItem[]
function MediaPool:ImportMedia(clipInfos) end

---Exports metadata of specified clips to a CSV file.
---If no clips are provided, exports all clips.
---@param fileName string
---@param clips? fu.MediaPoolItem[]
---@return boolean
function MediaPool:ExportMetadata(fileName, clips) end

---Returns a unique ID for the Media Pool.
---@return string
function MediaPool:GetUniqueId() end

---Creates a stereo clip from two MediaPoolItems.
---@param left fu.MediaPoolItem
---@param right fu.MediaPoolItem
---@return fu.MediaPoolItem
function MediaPool:CreateStereoClip(left, right) end

---Automatically syncs audio for the given MediaPoolItems.
---@param items fu.MediaPoolItem[]
---@param audioSyncSettings fu.MediaPoolAudioSyncSettings
---@return boolean
function MediaPool:AutoSyncAudio(items, audioSyncSettings) end

---Returns currently selected MediaPoolItems.
---@return fu.MediaPoolItem[]
function MediaPool:GetSelectedClips() end

---Sets the selected MediaPoolItem.
---@param mediaPoolItem fu.MediaPoolItem
---@return boolean
function MediaPool:SetSelectedClip(mediaPoolItem) end