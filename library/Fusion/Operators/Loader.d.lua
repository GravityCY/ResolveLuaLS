---@meta

--- Loader is a threaded operator responsible for importing and managing media sources.
---
--- It supports assigning MultiClip clip lists for timeline-based media loading workflows.
--- This is typically used to programmatically define multi-source media sequences.
---@class fu.Loader : fu.ThreadedOperator
local Loader = {};

--- Assign a MultiClip clip list to the Loader.
---
--- This method defines a sequence of media clips as a single MultiClip source.
--- Optional timing parameters allow control over how the clip is interpreted:
--- - startframe defines the starting frame offset
--- - trimin defines the in-point trim
--- - trimout defines the out-point trim
---
--- If optional parameters are omitted, default timeline or clip-derived values are used.
---@param filename string Path or identifier of the MultiClip source file
---@param startframe number? Start frame offset (optional)
---@param trimin number? Trim in point (optional)
---@param trimout number? Trim out point (optional)
function Loader:SetMultiClip(filename, startframe, trimin, trimout) end