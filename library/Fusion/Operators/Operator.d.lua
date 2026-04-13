---@meta

---@class fu.OperatorAttrs
---@field TOOLS_Name string The full name of this tool
---@field TOOLB_Visible integer Indicates if this tool is visible on the flow or is a non-visible tool (e.g. modifier)
---@field TOOLB_Locked boolean Indicates if this tool is locked
---@field TOOLB_PassThrough boolean Indicates if this tool is set to pass-through
---@field TOOLB_HoldOutput boolean Indicates if this tool is holding its output (not updating)
---@field TOOLB_CtrlWZoom integer Indicates whether this tool’s control window is open or closed
---@field TOOLB_NameSet boolean Indicates whether this tool’s name was user-defined or default
---@field TOOLB_CacheToDisk integer Indicates whether this tool is set to cache itself to disk
---@field TOOLS_RegID string The registry ID of this tool
---@field TOOLH_GroupParent userdata The associated group object
---@field TOOLNT_EnabledRegion_Start number Frame at which this tool becomes enabled
---@field TOOLNT_EnabledRegion_End number Frame at which this tool becomes disabled
---@field TOOLNT_Region_Start number Frame at which this tool can start providing results
---@field TOOLNT_Region_End userdata Frame at which this tool stops providing results
---@field TOOLN_LastFrameTime number Time (in seconds) taken to process the most recent frame
---@field TOOLI_Number_o_Inputs number Number of inputs on this tool (e.g. 3D merges)
---@field TOOLI_ImageWidth integer Width of most recently processed image
---@field TOOLI_ImageHeight integer Height of most recently processed image
---@field TOOLI_ImageField integer Field information of most recently processed image
---@field TOOLI_ImageDepth integer Image depth of most recently processed image
---@field TOOLN_ImageAspectX number Pixel aspect X of most recently processed image
---@field TOOLN_ImageAspectY number Pixel aspect Y of most recently processed image
---
--- Clip-related attributes (may represent tables when multiple clips exist).
--- Each index corresponds to a clip in the clip list.
---@field TOOLST_Clip_Name string[]
---@field TOOLIT_Clip_Width integer[]
---@field TOOLIT_Clip_Height integer[]
---@field TOOLIT_Clip_StartFrame integer[]
---@field TOOLIT_Clip_Length integer[]
---@field TOOLBT_Clip_IsMultiFrame boolean[]
---@field TOOLST_Clip_FormatName string[]
---@field TOOLST_Clip_FormatID string[]
---@field TOOLNT_Clip_Start number[]
---@field TOOLNT_Clip_End number[]
---@field TOOLBT_Clip_Reverse boolean[]
---@field TOOLBT_Clip_Saving boolean[]
---@field TOOLBT_Clip_Loop boolean[]
---@field TOOLIT_Clip_TrimIn integer[]
---@field TOOLIT_Clip_TrimOut integer[]
---@field TOOLIT_Clip_ExtendFirst integer[]
---@field TOOLIT_Clip_ExtendLast integer[]
---@field TOOLIT_Clip_ImportMode integer[]
---@field TOOLIT_Clip_PullOffset integer[]
---@field TOOLIT_Clip_InitialFrame integer[]
---@field TOOLIT_Clip_AspectMode integer[]
---@field TOOLIT_Clip_TimeCode integer[]
---@field TOOLST_Clip_KeyCode string[]
---
---@field TOOLST_AltClip_Name string[]
---@field TOOLIT_AltClip_Width integer[]
---@field TOOLIT_AltClip_Height integer[]
---@field TOOLIT_AltClip_StartFrame integer[]
---@field TOOLIT_AltClip_Length integer[]
---@field TOOLBT_AltClip_IsMultiFrame boolean[]
---@field TOOLST_AltClip_FormatName string[]
---@field TOOLST_AltClip_FormatID string[]

--- Base class for all tools, modifiers, and operator-based nodes in the system.
--- Operators represent functional units inside a composition graph (flow),
--- including image processing tools, generators, and modifiers.
---
--- Each operator exposes a set of runtime attributes that describe its state,
--- configuration, and evaluation metadata.
---
--- NOTE: Many attributes are dynamically typed by the host system and may reflect
--- either single values or tables depending on context (e.g. clip lists).
---@class fu.Operator : fu.Object
---
--- The composition that this operator belongs to.
--- Read-only.
---@field Composition fu.Comp
---
--- Fill color of the operator (used for UI/display purposes).
---@field FillColor table
---
--- Registry ID of this tool.
--- Read-only.
---@field ID string
---@field Name string Friendly name of this tool (read-only)
---@field ParentTool fu.Operator Parent tool of this tool (group or macro container) (read-only)
---@field TextColor table Color of the tool’s icon text in the Flow view
---@field TileColor table Color of the tool’s icon tile in the Flow view
---@field UserControls table Table of user-control definitions
local Operator = {};

--- Creates a modifier and connects it to a tool input.
---
--- This is commonly used to drive animation on tool parameters (e.g. BezierSpline
--- for keyframed values). The modifier is automatically instantiated and linked
--- to the specified input.
---
--- Returns true if the modifier was successfully created and connected.
---
--- Lua usage:
--- myBlur = Blur()
--- if myBlur:AddModifier("Blend", "BezierSpline") then
---     myBlur.Blend[0] = 1.0
---     myBlur.Blend[100] = 0.0
--- end
---@param input string Input ID of the tool parameter to attach the modifier to
---@param modifier string Modifier type identifier to create
---@return boolean success True if modifier creation and connection succeeded
function Operator:AddModifier(input, modifier) end

--- Connect or disconnect a tool input to another operator or output.
---
--- If the target is an Operator, the input connects to its main output.
--- Passing nil disconnects the input.
---
--- This is used to build or modify node graph connections programmatically.
---
--- Lua usage:
--- ldr = comp:FindToolByID("Loader")
--- Merge1:ConnectInput("Foreground", ldr)
---@param input string Input name/ID to connect
---@param target fu.Operator|fu.PlainOutput|nil Target operator, output, or nil to disconnect
---@return boolean success True if the connection succeeded
function Operator:ConnectInput(input, target) end

--- Deletes this tool from the composition.
---
--- This removes the operator from the node graph and invalidates its Lua handle,
--- setting it to nil in the scripting environment.
function Operator:Delete() end

--- Returns the tool’s main (visible) input by index.
---
--- Indexing starts at 1 and increases sequentially.
--- Returns nil when no input exists at the given index.
---@param index number Input index (1-based)
---@return fu.Input? inp The input at the given index, or nil if out of range
function Operator:FindMainInput(index) end

--- Returns the tool’s main (visible) output by index.
---
--- Indexing starts at 1 and increases sequentially.
--- Returns nil when no output exists at the given index.
---@param index number Output index (1-based)
---@return fu.PlainOutput? out The output at the given index, or nil if out of range
function Operator:FindMainOutput(index) end

--- Returns a list of child tools contained in this operator (if it is a Group or Macro).
---
--- This is commonly used to traverse tool hierarchies and inspect grouped nodes.
--- Optionally filters results by selection state or registry ID.
---
--- Lua usage:
--- for i, t in pairs(comp.ActiveTool:GetChildrenList()) do
---     print(t.Name)
--- end
---@param selected boolean? If true, only returns selected child tools
---@param regid string? Optional registry ID filter to restrict tool types
---@return fu.Operator[] tools List of child tool objects
function Operator:GetChildrenList(selected, regid) end

--- Returns all control page names for this tool.
---
--- The returned table is indexed by page number.
---@return string[] names Table of control page names
function Operator:GetControlPageNames() end

--- Returns the index of the currently active settings slot.
---
--- Tools support multiple settings slots (typically 6). Slot 1 is the default.
---@return number index Current settings slot index (1-based)
function Operator:GetCurrentSettings() end

--- Retrieves persistent custom data stored on this tool.
---
--- This is used for script-driven storage and retrieval of arbitrary values.
--- If no name is provided, tool-level data may be returned depending on context.
---@param name string? Optional key name for stored data
---@return number|string|boolean|table value Stored value of any supported type
function Operator:GetData(name) end

--- Retrieves the value of a tool input at a given time.
---
--- If the input is not animated, the time parameter may be omitted.
--- Inputs can also be accessed directly via indexing syntax:
--- tool.Blend[time]
---
--- Lua usage:
--- print(tool:GetInput("Blend", 30.0))
--- print(tool.Blend[30.0])
---@param id string Input identifier
---@param time number? Optional evaluation time
---@return number|string|fu.Parameter value Evaluated input value
function Operator:GetInput(id, time) end

--- Returns all inputs on this tool.
---
--- Optionally filters inputs by datatype.
--- Valid filter types include: "Image", "Number", "Point", "Gradient", "Text"
---
--- Lua usage:
--- for i, inp in pairs(tool:GetInputList()) do
---     print(inp:GetAttrs().INPS_Name)
--- end
---@param type string? Optional datatype filter
---@return fu.Input[] inputs List of input objects
function Operator:GetInputList(type) end

--- Returns all keyframe times for this tool.
---
--- This only includes keyframes directly on the tool itself.
--- It does NOT include animation driven by connected modifiers or splines.
---@return number[] keyframes Ordered list of keyframe times
function Operator:GetKeyFrames() end

--- Returns all outputs on this tool.
---
--- Optionally filters outputs by datatype.
--- Valid filter types include: "Image", "Number", "Point", "Gradient", "Text"
---
--- Lua usage:
--- for i, out in pairs(tool:GetOutputList()) do
---     print(out:GetAttrs().OUTS_Name)
--- end
---@param type string? Optional datatype filter
---@return fu.PlainOutput[] outputs List of output objects
function Operator:GetOutputList(type) end

--- Loads tool settings from a file path or a settings table.
---
--- This method restores a tool’s configuration, including input values,
--- animation data, and internal parameter states.
---
--- It supports two input forms:
--- - A file path pointing to a .setting file
--- - A Lua table containing serialized settings data
---
--- This is commonly used for external configuration management, pipeline
--- synchronization, or reapplying saved tool states.
---@param filename string File path to a .setting file OR serialized settings table
---@return boolean success True if settings were successfully loaded
function Operator:LoadSettings(filename) end

--- Loads tool settings from a settings table.
---
--- This overload accepts a pre-parsed Lua table containing tool settings.
--- Useful when settings are generated or modified programmatically.
---@param settings table Serialized settings table
---@return boolean success True if settings were successfully loaded
function Operator:LoadSettings(settings) end

--- Refreshes the tool and rebuilds its UI/control state.
---
--- This forces the operator to update its user controls and internal state.
--- Calling Refresh invalidates the current tool handle and returns a new one.
--- The returned handle should be stored and used going forward.
---
--- This is typically used after dynamic UI or parameter changes.
---@return fu.Operator refreshedTool New valid tool handle after refresh
function Operator:Refresh() end

--- Saves the tool’s current settings to a file or returns them as a table.
---
--- When a filename is provided, settings are written to disk as a .setting file.
--- When no filename is provided, the tool returns a serialized Lua table instead.
---
--- This includes inputs, animations, and configuration state.
---@param filename string File path to save settings to
---@return boolean success True if settings were successfully saved
function Operator:SaveSettings(filename) end

--- Saves the tool’s current settings into a Lua table.
---
--- This overload returns a serialized representation of the tool’s state
--- instead of writing it to disk.
---@param customdata boolean Placeholder overload discriminator (no runtime effect)
---@return table settings Serialized tool settings table
function Operator:SaveSettings(customdata) end

--- Sets the active settings slot for this tool.
---
--- Tools maintain multiple internal settings slots (typically 6).
--- Switching slots replaces all inputs with the values stored in that slot.
--- The previous slot state is preserved automatically.
---
--- Changing slots may also swap animations and parameter configurations.
---@param index number Settings slot index (1-based)
---@return number index The newly active settings slot index
function Operator:SetCurrentSettings(index) end

--- Stores persistent custom data on this tool.
---
--- This data persists with the tool and can be retrieved later using GetData().
--- Supports numbers, strings, booleans, and tables.
---@param name string Key name for stored data
---@param value number|string|boolean|table Value to store
function Operator:SetData(name, value) end

--- Sets the value of a tool input at an optional time.
---
--- If the input is not animated, the time parameter may be omitted.
--- Inputs can also be set using indexing syntax:
--- tool.Blend[time] = value
---
--- This method is typically used for scripted animation or automation.
---@param id string Input identifier
---@param value number|string|fu.Parameter Value to assign
---@param time number? Optional time for animated inputs
function Operator:SetInput(id, value, time) end

--- Shows the specified control page in the tool’s UI.
---
--- Control pages can be queried using GetControlPageNames().
--- This affects only UI visibility, not tool behavior.
---@param name string Name of the control page to display
function Operator:ShowControlPage(name) end

--- Returns the attribute table for this input.
---
--- This provides runtime metadata such as type, limits, UI behavior,
--- and connection state.
---@param id string? Optional specific lookup
---@return fu.OperatorAttrs attrs Attribute structure
function Operator:GetAttrs(id) end