---@meta

--- Link is the base class for Input and Output objects.
---
--- It represents a connection point in the operator graph and provides
--- shared functionality for data storage and tool ownership queries.
---
--- Links are lockable objects and may store persistent custom data.
---@class fu.Link : fu.LockableObject
---@field ID string ID of this Link (read-only)
---@field Name string Friendly name of this Link (read-only)
local Link = {};

--- Retrieves custom persistent data stored on this Link.
---
--- This system is shared with Composition-level data storage and allows
--- arbitrary Lua values to be associated with a link.
---
--- If no name is provided, the behavior depends on the host implementation
--- and may return all stored data or a default entry.
---@param name string? Optional key name
---@return number|string|boolean|table value Stored value
function Link:GetData(name) end


--- Returns the Tool object that owns this Link.
---
--- This allows traversal from Inputs/Outputs back to their parent Operator.
---@return fu.Operator tool Owning tool instance
function Link:GetTool() end


--- Stores custom persistent data on this Link.
---
--- Data persists across sessions and can be retrieved later using GetData().
--- Supported value types include number, string, boolean, and table.
---@param name string Key name
---@param value number|string|boolean|table Value to store
function Link:SetData(name, value) end