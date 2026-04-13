---@meta

--- Parameter is the base class for all evaluated data types in the system.
---
--- This includes fundamental runtime values such as numbers, images, points,
--- text, gradients, and other computed results produced by Operators.
---
--- Parameters represent the evaluated output of a tool or input evaluation chain.
---@class fu.Parameter : fu.Object
local Parameter = {}

--- Attribute structure for Parameter objects.
---
--- This contains runtime metadata describing identity and display properties
--- of the evaluated parameter.
---@class fu.ParameterAttrs
---@field ID string ID of this Parameter (read-only)
---@field Name string Friendly name of this Parameter (read-only)

--- Retrieves attribute table for this parameter.
---
--- This provides runtime metadata such as identity and display information.
---@param id string? Optional specific lookup key
---@return fu.ParameterAttrs attrs Attribute structure
function Parameter:GetAttrs(id) end

--- Retrieves metadata associated with this parameter.
---
--- Metadata is typically injected by upstream tools such as loaders and may
--- describe provenance information (e.g. file origin, format, or source path).
---
--- WARNING: This metadata may be overwritten when upstream evaluation re-runs
--- (e.g. Loader re-evaluation or pipeline refresh).
---
--- Example:
--- Image was loaded from metadata["Filename"]
---@return table metadata Metadata table associated with this parameter
function Parameter:Metadata() end

--- Retrieves custom persistent data stored on this Parameter.
---
--- Allows arbitrary Lua values to be associated with the object for scripting use.
---@param name string? Optional key name
---@return number|string|boolean|table value Stored value
function Parameter:GetData(name) end

--- Stores custom persistent data on this Parameter.
---
--- Data persists across evaluation but may be invalidated if upstream tools
--- re-evaluate and rebuild the parameter chain.
---@param name string Key name
---@param value number|string|boolean|table Value to store
function Parameter:SetData(name, value) end