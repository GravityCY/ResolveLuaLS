---@meta

--- PlainInput represents a single input socket on an Operator.
---
--- Inputs define how a tool receives data from other tools, modifiers,
--- expressions, or direct user interaction.
---
--- Each input can optionally be connected, animated, or driven by expressions.
--- Inputs are the primary interface between operators in the flow graph.
---@class fu.PlainInput : fu.Link
local PlainInput = {};

--- Attribute structure returned by PlainInput:GetAttrs().
---
--- These values describe runtime configuration, UI behavior, limits,
--- connection state, and evaluation rules for the input.
---
--- This struct is read-only and reflects the current evaluated state
--- of the input inside the Resolve/Fusion pipeline.
---@class fu.PlainInputAttrs
---@field INPS_Name string The full name of this input
---@field INPS_ID string Script ID of this input
---@field INPS_DataType string Expected parameter type (Number, Point, Text, Image, etc.)
---@field INPS_StatusText string Status bar text shown on hover
---@field INPB_External boolean Whether input can be animated or connected
---@field INPB_Active boolean Whether this input contributes to rendering
---@field INPB_Required boolean Whether a valid value is required for output
---@field INPB_Connected boolean Whether input is currently connected
---@field INPI_Priority integer Input evaluation priority order
---@field INPID_InputControl string ID of UI control used in inspector
---@field INPID_PreviewControl string ID of preview view control
---@field INPB_Disabled boolean Whether input accepts new values
---@field INPB_DoNotifyChanged boolean Notify tool when value changes
---@field INPB_Integer boolean Rounds values to nearest integer
---@field INPI_NumSlots integer Number of time-sampled value slots
---@field INPB_ForceNotify boolean Always notify even if value unchanged
---@field INPB_InitialNotify boolean Notify tool at creation
---@field INPB_Passive boolean Does not affect render or undo state
---@field INPB_InteractivePassive boolean Does not affect render but supports undo
---@field INPN_MinAllowed number Minimum allowed value (clipped)
---@field INPN_MaxAllowed number Maximum allowed value (clipped)
---@field INPN_MinScale number Minimum UI display scale
---@field INPN_MaxScale number Maximum UI display scale
---@field INPI_IC_ControlPage integer Control window tab index
---@field INPI_IC_ControlGroup integer Shared UI control group ID
---@field INPI_IC_ControlID integer Unique control ID in group

--- Connects this input to an output or disconnects it.
---
--- Inputs can also be connected using direct assignment:
--- input = output
---
--- Passing nil disconnects the input.
---@param out fu.PlainOutput? Output to connect, or nil to disconnect
---@return boolean success True if connection succeeded
function PlainInput:ConnectTo(out) end

--- Returns the output currently connected to this input, if any.
---@return fu.PlainOutput? out Connected output or nil
function PlainInput:GetConnectedOutput() end

--- Returns the expression string assigned to this input, if any.
---@return string? expression Expression string or nil
function PlainInput:GetExpression() end

--- Returns keyframe times for this input if animated.
---
--- Returns nil if the input is not driven by a spline.
---@return number[]? keyframes Keyframe time list or nil
function PlainInput:GetKeyFrames() end

--- Hides or shows on-screen view controls for this input.
---@param hide boolean? true to hide, false to show (default true)
function PlainInput:HideViewControls(hide) end

--- Hides or shows inspector window controls for this input.
---@param hide boolean? true to hide, false to show (default true)
function PlainInput:HideWindowControls(hide) end

--- Sets an expression on this input.
---
--- This enables procedural relationships between parameters.
---@param expression string Expression string
function PlainInput:SetExpression(expression) end

--- Returns whether view controls are currently visible.
---@return boolean hidden True if hidden, false if visible
function PlainInput:ViewControlsVisible() end

--- Returns whether window controls are currently visible.
---@return boolean hidden True if hidden, false if visible
function PlainInput:WindowControlsVisible() end

--- Returns the attribute table for this input.
---
--- This provides runtime metadata such as type, limits, UI behavior,
--- and connection state.
---@param id string? Optional specific lookup
---@return fu.PlainInputAttrs attrs Attribute structure
function PlainInput:GetAttrs(id) end