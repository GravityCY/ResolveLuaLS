---@meta

--- PlainOutput represents a single output socket on an Operator.
---
--- Outputs define how a tool exposes computed results to downstream tools.
--- They can be connected to multiple inputs but originate from a single tool.
---
--- Outputs may be evaluated, cached, or queried to retrieve computed values
--- or render results from upstream operator chains.
---
--- This is a Link-based class used in the node graph system.
---@class fu.PlainOutput : fu.Link
local PlainOutput = {}

---@class fu.PlainOutputAttrs
---@field OUTS_Name string The name of the Output
---@field OUTS_ID string The Output’s unique ID string
---@field OUTS_DataType string The type of Parameter that this Output uses

--- Clears frames from the disk cache.
---
--- This removes cached render data for a specified frame range.
--- Useful for forcing recomputation of outdated or invalid cached results.
---@param start number Start frame (inclusive)
---@param _end number End frame (inclusive)
---@return boolean success True if cache was successfully cleared
function PlainOutput:ClearDiskCache(start, _end) end


--- Enables or disables disk-based caching for this output.
---
--- This controls whether rendered results are written to disk for reuse.
--- Additional options control locking behavior, cache invalidation rules,
--- pre-rendering, and network rendering usage.
---
--- WARNING: Locking cache prevents invalidation and may cause stale results.
---@param enable boolean Enable or disable disk cache
---@param path string File system path for cache storage
---@param lockCache boolean? Prevent cache invalidation when upstream changes (default false)
---@param lockBranch boolean? Lock upstream tool chain (default false)
---@param delete boolean? Delete existing cache at path (default false)
---@param preRender boolean? Pre-render cache immediately (default true)
---@param useNetwork boolean? Use network rendering for pre-render (default false)
---@return boolean success True if cache configuration succeeded
function PlainOutput:EnableDiskCache(enable, path, lockCache, lockBranch, delete, preRender, useNetwork) end


--- Returns all inputs connected to this output.
---
--- Since outputs can branch to multiple inputs, this returns a list.
---@return fu.PlainInput[] inputs List of connected inputs
function PlainOutput:GetConnectedInputs() end


--- Returns the Domain of Definition (DoD) of the output at a given time.
---
--- The DoD represents the bounding region of valid image data.
--- Returns a table containing: left, bottom, right, top.
---@param time number? Frame time (default: current frame)
---@param flags number? Quality evaluation flags (default: final quality)
---@param proxy number? Proxy level (default: no proxy)
---@return number[] dod Bounding box {left, bottom, right, top}
function PlainOutput:GetDoD(time, flags, proxy) end


--- Returns the evaluated value of this output at a given time.
---
--- This forces evaluation of upstream tools if cached results are unavailable.
--- The returned type depends on the output’s data type (number, image, text, etc.).
---
--- For images, returns an Image object.
--- For points, returns a table with X/Y.
--- For numbers, returns a numeric value.
---@return fu.Parameter|number|string|table value Evaluated output value
function PlainOutput:GetValue() end


--- Displays the cache-to-disk configuration dialog.
---
--- This is a modal UI operation and will block script execution until closed.
---@return boolean success True if user confirmed, false if canceled
function PlainOutput:ShowDiskCacheDlg() end