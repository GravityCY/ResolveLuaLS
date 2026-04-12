---@meta

---@class fu.ColorGroup
local ColorGroup = {};

---Returns the name of the ColorGroup.
---@return string
function ColorGroup:GetName() end

---Renames the ColorGroup to the given name.
---@param groupName string
---@return boolean
function ColorGroup:SetName(groupName) end

---Returns a list of TimelineItem objects that belong to this ColorGroup in the given timeline.
---If Timeline is not provided, the current timeline is used as default.
---@param Timeline fu.Timeline|nil Timeline (optional). If nil, uses current timeline.
---@return fu.TimelineItem[]
function ColorGroup:GetClipsInTimeline(Timeline) end

---Returns the Pre-Clip node graph for this ColorGroup.
---@return fu.Graph
function ColorGroup:GetPreClipNodeGraph() end

---Returns the Post-Clip node graph for this ColorGroup.
---@return fu.Graph
function ColorGroup:GetPostClipNodeGraph() end