---@meta

---Cache mode used by Fusion/Color nodes in the Resolve graph system.
---Controls whether a node is cached automatically, disabled, or explicitly enabled.
---
---Values correspond to Resolve internal cache flags:
--- - -1 = auto enabled (resolve.CACHE_AUTO_ENABLED)
--- -  0 = disabled (resolve.CACHE_DISABLED)
--- -  1 = enabled (resolve.CACHE_ENABLED)
---
---Returned by Graph:GetNodeCacheMode(nodeIndex)
---Accepted by Graph:SetNodeCacheMode(nodeIndex, cache_value)
---@alias fu.NodeCacheMode
---| -1  # Auto enabled cache (CACHE_AUTO_ENABLED)
---| 0   # Cache disabled (CACHE_DISABLED)
---| 1   # Cache enabled (CACHE_ENABLED)

---@class fu.Graph
local Graph = {};

---Returns the number of nodes in the graph.
---@return integer
function Graph:GetNumNodes() end

---Sets a LUT on a node by index.
---The LUT path can be absolute or relative (based on Resolve LUT paths).
---Must reference a LUT already discovered by Resolve (see Project.RefreshLUTList).
---@param nodeIndex integer
---@param lutPath string
---@return boolean
function Graph:SetLUT(nodeIndex, lutPath) end

---Returns the LUT path for the given node index.
---@param nodeIndex integer
---@return string
function Graph:GetLUT(nodeIndex) end

---Sets cache mode for a node.
---Cache mode controls how Resolve caches node output.
---@param nodeIndex integer
---@param cache_value fu.NodeCacheMode
---@return boolean
function Graph:SetNodeCacheMode(nodeIndex, cache_value) end

---Returns cache mode for a node.
---@param nodeIndex integer
---@return fu.NodeCacheMode
function Graph:GetNodeCacheMode(nodeIndex) end

---Returns the label of a node at the given index.
---@param nodeIndex integer
---@return string
function Graph:GetNodeLabel(nodeIndex) end

---Returns a list of tool names used in the specified node.
---@param nodeIndex integer
---@return string[]
function Graph:GetToolsInNode(nodeIndex) end

---Enables or disables a node.
---@param nodeIndex integer
---@param isEnabled boolean
---@return boolean
function Graph:SetNodeEnabled(nodeIndex, isEnabled) end

---Applies a grade from a DRX file to the graph.
---gradeMode:
---0 = No keyframes
---1 = Source timecode aligned
---2 = Start frames aligned
---@param path string
---@param gradeMode integer
---@return boolean
function Graph:ApplyGradeFromDRX(path, gradeMode) end

---Applies ARRI CDL and LUT to the graph.
---@return boolean
function Graph:ApplyArriCdlLut() end

---Resets all grades in the graph.
---@return boolean
function Graph:ResetAllGrades() end