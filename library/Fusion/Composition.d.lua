---@meta

---@class fu.CompositionRenderSettings
---@field wait_for_render boolean? Whether to wait for render completion (default false)
---@field renderstart number? Frame to start rendering at
---@field renderend number? Frame to stop rendering at
---@field step number? Render every Nth frame (e.g. 2 = every second frame)
---@field proxy number? Proxy scale factor for faster rendering
---@field hiQ boolean? High quality render (default true)
---@field mblur boolean? Motion blur enable (default true)

---@class fu.CompositionRenderTable
---@field Start number? First frame to render (default: comp render end setting)
---@field End number? Last frame to render (inclusive)
---@field HiQ boolean? High quality render (default true)
---@field RenderAll boolean? Render all tools regardless of downstream usage (default false)
---@field MotionBlur boolean? Enable motion blur (default true)
---@field SizeType integer?
---| -1 # Custom (PreviewSaver only)
---| 0  # Use preferences setting
---| 1  # Full size (default)
---| 2  # Half size
---| 3  # Third size
---| 4  # Quarter size
---@field Width number? Custom render width (SizeType = -1)
---@field Height number? Custom render height (SizeType = -1)
---@field KeepAspect boolean? Maintain aspect ratio in custom sizing
---@field StepRender boolean? Enable stepped rendering (shoot on X frames)
---@field Steps number? Step interval count (default 5)
---@field UseNetwork boolean? Enable network rendering
---@field Groups string? Network slave group selection (default "all")
---@field Flags number? Render flags (e.g. 262144 for preview renders)
---@field Tool fu.Tool? Render only up to this tool
---@field FrameRange string? Non-contiguous frame ranges (e.g. "1..10,20..30")
---@field Wait boolean? Wait for render completion

--- Valid control types for Composition:AskUser().
---
--- These define which UI widget Fusion will render for the control.
---@alias fu.AskUserControlType
---| "FileBrowse"
---| "PathBrowse"
---| "ClipBrowse"
---| "Position"
---| "Slider"
---| "Screw"
---| "Checkbox"
---| "Dropdown"
---| "Text"

--- Result table returned by Composition:AskUser().
---
--- Each key corresponds to the control's ID (first field in definition table).
--- Values depend on control type:
--- - number for sliders/screws
--- - boolean for checkboxes
--- - string for text/file paths
--- - table for position controls
---@alias fu.AskUserResult table<string, number|string|boolean|table>

--- A single UI control definition for Composition:AskUser().
---
--- Each entry defines:
--- - a unique key (table index)
--- - a control type (widget)
--- - optional configuration values depending on type
---
--- This is used to dynamically construct modal UI dialogs.
---@class fu.AskUserControl
---@field [1] string? Display label override
---@field [2] fu.AskUserControlType Control widget type
---@field Default any? Default value (type depends on ControlType)
---@field Min number? Minimum numeric value (Slider/Screw)
---@field Max number? Maximum numeric value (Slider/Screw)
---@field DisplayedPrecision number? Decimal precision for numeric controls
---@field Integer boolean? Force integer values (Slider/Screw)
---@field Save boolean? FileBrowse: treat as save dialog
---@field Lines integer? Text: number of visible lines
---@field Wrap boolean? Text: enable wrapping
---@field ReadOnly boolean? Text: disable editing
---@field FontName string? Text font family
---@field FontSize number? Text font size
---@field LowName string? Slider minimum label
---@field HighName string? Slider maximum label
---@field NumAcross integer? Checkbox layout grouping
---@field Options string[]? Dropdown options list

--- Composition represents a full Fusion composition (flow graph + timeline context).
---
--- It is the central runtime object that controls time evaluation, rendering,
--- tool creation, and global composition state.
---
--- In Lua console scripts, Composition methods are globally accessible
--- without needing a `comp.` prefix.
---
---@class fu.Comp : fu.Object
local Composition = {}

--- Attribute structure for Composition objects.
---
--- Contains runtime state for playback, rendering, timing bounds,
--- and composition-level configuration flags.
---@class fu.CompositionAttrs
---@field COMPN_CurrentTime number Current evaluation time of the composition
---@field COMPB_HiQ boolean HiQ (high quality) mode enabled state
---@field COMPB_Proxy boolean Proxy mode enabled state
---@field COMPB_Rendering integer Whether composition is currently rendering
---@field COMPN_RenderStart number Render start time
---@field COMPN_RenderEnd number Render end time
---@field COMPN_GlobalStart number Global start time (valid evaluation range start)
---@field COMPN_GlobalEnd number Global end time (valid evaluation range end)
---@field COMPN_LastFrameRendered number Last successfully rendered frame
---@field COMPN_LastFrameTime number Time taken for last frame render (seconds)
---@field COMPN_AverageFrameTime number Average render time per frame (seconds)
---@field COMPN_TimeRemaining number Estimated remaining render time (seconds)
---@field COMPS_FileName string Full file path of the composition
---@field COMPS_Name string Name of the composition
---@field COMPI_RenderFlags integer Render flags for current render
---@field COMPI_RenderStep integer Render step value
---@field COMPB_Locked boolean Whether composition is locked

--- Returns the currently active tool in the composition.
---@return fu.Tool tool Active tool
function Composition:GetActiveTool() end

--- Enables or disables automatic positioning of newly added tools.
---@param val boolean Whether auto-positioning is enabled
function Composition:SetAutoPos(val) end

--- Returns the current frame (timeline frame object).
---@return fu.FuFrame frame Current frame object
function Composition:GetCurrentFrame() end

--- Gets or sets the current time of the composition.
---@param val number? Optional time to set
---@return number currentTime Current composition time
function Composition:GetCurrentTime(val) end

--- Sets the X position for the next tool added to the flow.
---@param val number X coordinate
function Composition:SetXPos(val) end

--- Sets the Y position for the next tool added to the flow.
---@param val number Y coordinate
function Composition:SetYPos(val) end

--- Stops any active render immediately.
function Composition:AbortRender() end

--- Asks user confirmation before aborting render.
function Composition:AbortRenderUI() end

--- Adds a tool to the composition at a specified position.
---
--- If xpos and ypos are omitted, the tool is placed using default flow rules.
--- Passing -32768 for both coordinates uses automatic placement behavior
--- similar to clicking a toolbar tool.
---@param id string Tool RegID
---@param defsettings boolean? Use user-modified default settings (default false)
---@param xpos number? Flow X position
---@param ypos number? Flow Y position
---@return fu.Tool tool Newly created tool instance
function Composition:AddTool(id, defsettings, xpos, ypos) end

--- Shows the Render Settings dialog for the composition.
---
--- This opens the standard Fusion render settings UI and blocks execution
--- until the user confirms or cancels the dialog.
function Composition:AskRenderSettings() end

--- Present a custom dialog to the user, and return selected values.
--- 
--- The AskUser function displays a dialog to the user, requesting input using a variety of
--- common fusion controls such as sliders, menus and textboxes. All script execution stops
--- until the user responds to the dialog by selecting OK or Cancel. This function can only be
--- called interactively, command line scripts cannot use this function.
--- 
--- The second argument of this function recieves a table of inputs describing which controls
--- to display. Each entry in the table is another table describing the control and its options.
--- For example, if you wanted to display a dialog that requested a path from a user, you might
--- use the following script.
--- 
--- Returns a table containing the responses from the user, or nil if the user cancels the dialog.
--- 
--- Input Name (string, required)
--- 
--- This name is the index value for the controls value as set by the user (i.e. dialog.Control or
--- dialog[“Control Name”]). It is also the label shown next to the control in the dialog, unless
--- the Name option is also provided for the control.
--- 
--- Input Type (string, required)
--- 
--- A string value describing the type of control to display. Valid strings are FileBrowse,PathBrowse,
--- Position, Slider, Screw, Checkbox, Dropdown, and Text. Each Input type has its own
--- properties and optional values, which are described below.
--- 
--- Options (misc)
--- Different control types accept different options that determine how that control appears
--- and behaves in the dialog.
--- 
--- AskUser Inputs
--- | Input Type                       | Description                                                                                                                                                                                                                                                                                                                                                                                                                    | Options                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
--- |----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
--- |                                  | Several of the Options are common to several controls. For example, the name option can be used with any type of control, and the DisplayedPrecision option can be used with any control that displays and returns numeric values.                                                                                                                                                                                             | Name (string) This option can be used to specify a more reasonable name for this inputs index in the returned table than the one used as a label for the control. Default (various) The default value displayed when the control is first shown. Min (integer) Sets the minimum value allowed by the slider or screw control. Max (numeric) Sets the maximum value allowed by the slider or screw control. DisplayedPrecision (numeric) Use this option to set how much precision is used for numeric controls like sliders, screws and position controls. A value of 2 would allow two decimal places of precision - i.e. 2.10 instead of 2.105 Integer (boolean) If true the slider or screw control will only allow integer (non decimal) values, otherwise the slider will provide full precision. Defaults to false if not specified. |
--- | FileBrowse PathBrowse ClipBrowse | The FileBrowse input allows you to browse to select a file on disk, while the PathBrowse input allows you to select a directory.                                                                                                                                                                                                                                                                                               | Save (boolean) Set this option to true if the dialog is used to select a path or file which does not yet exist (i.e. when selecting a file to save to)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
--- | Screw                            | Displays the standard Fusion thumbwheel or screw control. This control is identical to a slider in almost all respects except that its range is infinite, and so it is well suited for angle controls and other values without practical limits.                                                                                                                                                                               |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
--- | Text                             | Displays the Fusion textedit control, which is used to enter large amounts of Text into a control.                                                                                                                                                                                                                                                                                                                             | Lines (integer) A number specifying how many lines of text to display in the control. Wrap (boolean) A true or false value that determines whether the text entered into this control will wrap to the next line when it reaches the end of the line. ReadOnly (boolean) If this option is set to true the control will not allow any editing of the text within the control. Use for displaying non-editable information. FontName (string) The name of a true type font to use when displaying text in this control. FontSize (numeric) A number specifying the font size used to display the text in this control.                                                                                                                                                                                                                      |
--- | Slider                           | Displays a standard Fusion slider control. Labels can be set for the high and low ends of the slider using the following options.                                                                                                                                                                                                                                                                                              | LowName (string) The text label used for the low (left) end of the slider. HighName (string) The text label used for the high (right) end of the slider.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
--- | Checkbox                         | Displays a Fusion standard checkbox control. You can display several of these controls next to each other using the NumAcross option.                                                                                                                                                                                                                                                                                          | Default (numeric) The default state for the checkbox, use 0 to leave the checkbox deselected, or 1 to enable the checkbox. Defaults to 0 if not specified. NumAcross (numeric) If the NumAcross value is set the dialog will reserve space to display two or more checkboxes next to each other. The NumAcross value must be set for all checkboxes to be displayed on the same row. See examples below for more information.                                                                                                                                                                                                                                                                                                                                                                                                              |
--- | Position                         | Displays a pair of edit boxes used to enter X & Y co-ordinates for a center control or other positional value. The default value for this control is a table with two values, one for the X value and one for the Y value. This control returns a table of values.                                                                                                                                                             | Default (table {x,y}) A table with two numeric entries specifying the value for the x and y co-ordinates                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
--- | Dropdown Multibutton             | Displays the standard Fusion drop down menu for selecting from a list of options. This control exposes an option called Options which takes a table containing the values for the drop down menu. Note that the index for the Options table starts at 0, not 1 like is common in most tables. So if you wish to set a default for the first entry in a list, you would use Default = 0, for the second Default = 1, and so on. | Default (num) A number specifying the index of the options table (below) to use as a default value for the drop down box when it is created. Options (table {string, string, string,...}) A table of strings describing the values displayed by the drop down box.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
--- 
--- **Lua usage:**
--- ```
--- composition_path = composition:GetAttrs().COMPS_FileName
--- msg = “This dialog is only an example. It does not actually do anything, “..“so you should not expect to see a useful result from running this script.”
--- d = {}
--- d[1] = {“File”, Name = “Select A Source File”, “FileBrowse”, Default = composition_path}
--- d[2] = {“Path”, Name = “New Destination”, “PathBrowse” }
--- d[3] = {“Copies”,Name = “Number of Copies”, “Slider”, Default = 1.0, Integer = true, Min = 1, Max = 5 }
--- d[4] = {“Angle”, Name = “Angle”, “Screw”, Default = 180, Min = 0, Max = 360}
--- d[5] = {“Menu”, Name = “Select One”, “Dropdown”, Options = {“Good”, “Better”, “Best”}, Default = 1}
--- d[6] = {“Center”,Name = “Center”, “Position”, Default = {0.5, 0.5} }
--- d[7] = {“Invert”,Name = “Invert”, “Checkbox”, NumAcross = 2 }
--- d[8] = {“Save”, Name = “Save Settings”, “Checkbox”, NumAcross = 2, Default = 1 }
--- d[9] = {“Msg”, Name = “Warning”, “Text”, ReadOnly = true, Lines = 5, Wrap = true, Default = msg}
--- dialog = composition:AskUser(“A Sample Dialog”, d)
--- if dialog == nil then
---     print(“You cancelled the dialog!”)
--- else
---     dump(dialog)
--- end
--- ```
--- 
---@param title string
---@param controls fu.AskUserControl[] Control definitions
---@return fu.AskUserResult? results Result table or nil if cancelled
function Composition:AskUser(title, controls) end

--- Displays a dialog allowing the user to select a tool from a filtered list.
---
--- The `path` argument defines the tool category or browser path used to
--- populate the selection list.
---
--- Returns the selected tool RegID as a string, or nil if cancelled.
---@param path string Tool browser path filter
---@return string? id Selected tool RegID or nil
function Composition:ChooseTool(path) end

--- Clears the entire undo/redo history for this composition.
---
--- This permanently removes all stored undo states for the current session.
function Composition:ClearUndo() end

--- Closes the composition.
---
--- If the composition is modified and unlocked, the user may be prompted
--- to save changes before closing.
---
--- If the composition is locked, it will close without saving regardless
--- of modification state.
---
--- After closing, the Composition object becomes invalid (nil).
---
---@return boolean? success True if closed successfully, nil if failure
function Composition:Close() end

--- Copies the currently selected tools to the clipboard.
---@return boolean success True if copy succeeded
function Composition:Copy() end

--- Copies a single tool to the clipboard.
---@param tool fu.Tool Tool to copy
---@return boolean success True if copy succeeded
function Composition:Copy(tool) end

--- Copies a list of tools to the clipboard.
---@param toollist fu.Tool[] List of tools to copy
---@return boolean success True if copy succeeded
function Composition:Copy(toollist) end

--- Copies the currently selected tools into a settings table.
---@return table settings Serialized tool settings
function Composition:CopySettings() end

--- Copies a single tool into a settings table.
---@param tool fu.Tool Tool to serialize
---@return table settings Serialized tool settings
function Composition:CopySettings(tool) end

--- Copies a list of tools into a settings table.
---@param toollist fu.Tool[] List of tools to serialize
---@return table settings Serialized tool settings
function Composition:CopySettings(toollist) end

--- Disables (passes through) all currently selected tools.
---
--- This effectively bypasses selected tools in the flow.
function Composition:DisableSelectedTools() end

--- Ends an undo block previously started with StartUndo().
---
--- If `keep` is true, the recorded actions are committed as a single undo step.
--- If false, the undo block is discarded and cannot be reverted.
---
--- If EndUndo is not called, Fusion automatically finalizes the undo block.
---@param keep boolean Whether to keep the undo entry
function Composition:EndUndo(keep) end

--- Executes a script string in the context of this composition.
---
--- By default executes Lua code.
--- Python can be selected using prefixes:
--- - `!Py:`  default Python
--- - `!Py2:` Python 2
--- - `!Py3:` Python 3
---
--- Note: Use `fusion:Execute()` for global Fusion context execution.
---@param code string Script code to execute
function Composition:Execute(code) end

--- Finds the first tool with the given name in the composition.
---@param name string Tool name
---@return fu.Tool? tool Found tool or nil if not found
function Composition:FindTool(name) end

--- Finds the first tool of a given type (RegID).
---
--- This returns only the first matching tool in the composition.
--- To continue searching, pass the previously found tool as `prev`.
---
--- Example:
--- local b1 = comp:FindToolByID("Blur")
--- local b2 = comp:FindToolByID("Blur", b1)
---@param id string Tool RegID (e.g. "Blur", "Merge")
---@param prev fu.Tool? Previous tool to continue search from
---@return fu.Tool? tool First matching tool or nil
function Composition:FindToolByID(id, prev) end

--- Returns all composition PathMaps.
---
--- PathMaps define directory mappings used for resolving file paths.
--- These may include built-in, user-defined, or default mappings depending
--- on the provided flags.
---@param built_ins boolean? Include built-in path maps (default false)
---@param defaults boolean? Include default path maps (default true)
---@return table map PathMap table
function Composition:GetCompPathMap(built_ins, defaults) end

--- Returns the composition console history.
---
--- If no parameters are provided, returns general console statistics
--- including total line count.
---
--- If only `startSeq` is provided, returns history from that point onward.
--- If both `startSeq` and `endSeq` are provided, returns the range.
---
--- Useful for debugging scripts, warnings, and execution logs.
---@param startSeq number? Starting console sequence index
---@param endSeq number? Ending console sequence index
---@return table history Console history table or summary
function Composition:GetConsoleHistory(startSeq, endSeq) end

--- Retrieves persistent custom data stored on the composition.
---
--- Data is stored alongside the composition and persists in .comp files.
--- Nested keys may be accessed using dot notation (e.g. "User.Settings.Theme").
---
--- This is commonly used for storing metadata such as authorship, notes,
--- timestamps, and pipeline state.
---@param name string? Optional data key
---@return number|string|boolean|table value Stored value
function Composition:GetData(name) end

--- Returns all child frame windows in the Fusion UI.
---
--- ChildFrames represent the workspace windows containing viewers and tools.
---@return table frames List of frame objects
function Composition:GetFrameList() end

--- Returns the next keyframe time after a given time.
---
--- If `tool` is provided, only that tool is considered.
--- Otherwise, all tools in the composition are searched.
---@param time number? Start time for search
---@param tool fu.Tool? Optional tool filter
---@return number? time Next keyframe time or nil
function Composition:GetNextKeyTime(time, tool) end

--- Returns composition preferences or a specific preference value.
---
--- If `prefname` is nil, returns full preference table.
--- Dot notation can be used for nested preference keys.
---
--- If `exclude-defaults` is true, default values are omitted.
---@param prefname string? Preference key (dot notation supported)
---@param exclude_defaults boolean? Exclude default values from result
---@return table prefs Preference table or value
function Composition:GetPrefs(prefname, exclude_defaults) end

--- Returns the previous keyframe time before a given time.
---
--- If `tool` is provided, only that tool is searched.
--- Otherwise all tools in the composition are considered.
---@param time number? Reference time for search
---@param tool fu.Tool? Optional tool filter
---@return number? time Previous keyframe time or nil
function Composition:GetPrevKeyTime(time, tool) end

--- Returns the list of available preview views for the composition.
---
--- These represent viewer contexts within the composition.
--- For floating/global previews, use `fusion:GetPreviewList()` instead.
---@param include_globals boolean? Include global views (default false)
---@return table previews List of preview view objects
function Composition:GetPreviewList(include_globals) end

--- Returns all tools in the composition or filtered subsets.
---
--- If `selected` is true, only selected tools are returned.
--- If `regid` is provided, results are filtered by tool type.
--- If no tools match selection criteria, nil may be returned.
---@param selected boolean? Return only selected tools
---@param regid string? Tool RegID filter (e.g. "Loader", "Blur")
---@return fu.Tool[]? tools List of tool handles or nil
function Composition:GetToolList(selected, regid) end

--- Returns all view objects in the composition.
---
--- These represent viewer instances tied to the composition workspace.
---@return table views List of view objects
function Composition:GetViewList() end

--- Heartbeat function used internally for composition update cycles.
function Composition:Heartbeat() end

--- Returns true if the composition is locked (non-interactive mode).
---
--- When locked, dialogs and updates are suppressed.
---@return boolean locked True if comp is locked
function Composition:IsLocked() end

--- Returns true if the composition is currently playing.
---@return boolean playing Playback active state
function Composition:IsPlaying() end

--- Returns true if the composition is rendering or actively processing frames.
---
--- This includes playback rendering and tool evaluation renders.
---@return boolean rendering Render/processing state
function Composition:IsRendering() end

--- Locks the composition from interactive updates.
---
--- While locked, Fusion suppresses dialogs and prevents UI-triggered re-evaluation.
--- This is useful for batch scripts or bulk tool operations.
function Composition:Lock() end

--- Controls looping behavior for composition playback.
---
--- This is an overloaded function accepting either:
--- - boolean enable/disable
--- - string playback mode
---@param mode boolean|string Loop enable flag or mode string
function Composition:Loop(mode) end

--- Expands path maps into absolute filesystem paths.
---
--- Converts Fusion-style paths (e.g. "Comp:", "Fusion:") into literal paths.
--- If no mapping exists, the path is returned unchanged.
---
--- This function respects both global and composition-specific path maps.
---@param path string Input path containing optional map tokens
---@return string mapped Expanded absolute path
function Composition:MapPath(path) end

--- Expands all path mappings in a multi-segment path string.
---
--- Unlike `MapPath()`, this function preserves all segments separated by
--- semicolons and returns each resolved path entry in a table.
---
--- This is used when multiple directories are encoded in a single string.
---@param path string Multi-segment mapped path string
---@return string[] mapped List of expanded absolute paths
function Composition:MapPathSegments(path) end

--- Aborts an active network render session.
function Composition:NetRenderAbort() end

--- Marks the end of a network render session.
function Composition:NetRenderEnd() end

--- Starts a network render session.
function Composition:NetRenderStart() end

--- Returns timing information for network rendering.
---@return number time Render timing value
function Composition:NetRenderTime() end

--- Pastes tools from the clipboard or from a settings table.
---
--- If no settings table is provided, the system clipboard is used.
---@param settings table? Optional tool settings table
---@return boolean success True if paste succeeded
function Composition:Paste(settings) end

--- Starts interactive playback.
---
--- If `reverse` is true, playback runs backwards.
---@param reverse boolean? Play in reverse direction
function Composition:Play(reverse) end

--- Prints a message in the context of this composition.
---
--- Useful when working with multiple compositions and needing isolated logs.
---@param msg string Message to print
function Composition:Print(msg) end

--- Redoes one or more previously undone actions.
---
--- If `count` is negative, this behaves like Undo().
---@param count number Number of redo steps
function Composition:Redo(count) end

--- Starts rendering the composition.
---
--- This function supports both positional arguments and a table-based
--- configuration mode for non-contiguous or advanced render setups.
---
--- When `wait` is true, script execution blocks until render completes.
---
--- See documentation for full table-based render options.
---@param wait boolean? Wait for render completion
---@param start number? Start frame
---@param finish number? End frame
---@param proxy number? Proxy scale factor
---@param hiq boolean? High quality render
---@param motionblur boolean? Enable motion blur
---@return boolean? success True if render started/completed successfully
function Composition:Render(wait, start, finish, proxy, hiq, motionblur) end

----------------------------------------------------------------
--- Start a render of the composition.
---
--- This function supports two different invocation styles:
--- 1. Direct parameter style (legacy positional arguments)
--- 2. Table-based configuration style (recommended for complex renders)
---
--- The render system supports non-contiguous frame ranges, proxy scaling,
--- motion blur toggling, and selective tool rendering.
---
--- If a Tool is provided in the render settings, rendering will stop at that
--- tool and ignore downstream nodes (including savers).
---
--- If Wait is true, the script execution will pause until rendering completes.
---
--- Frame ranges may be continuous or discontinuous (e.g. "1..10,20,30..40").
---
---@param settings fu.CompositionRenderSettings|fu.CompositionRenderTable Render configuration
---@return boolean? success True if render started/completed successfully, nil if failed
function Composition:Render(settings) end

----------------------------------------------------------------
--- Collapses a filesystem path back into Fusion path maps where possible.
---
--- This performs the inverse of MapPath(), converting absolute paths into
--- symbolic path mappings such as Comp:, Fusion:, or custom user-defined maps.
---
--- This is useful for storing portable paths inside compositions or scripts,
--- ensuring that paths remain valid across different systems.
---
---@param mapped string Absolute or expanded filesystem path
---@return string path Path with restored Fusion path mappings
function Composition:ReverseMapPath(mapped) end

----------------------------------------------------------------
--- Executes a script within the composition scripting context.
---
--- The script runs with access to `fusion` and `composition` globals.
--- The filename may be absolute or relative to the comp's Scripts: path.
---
--- Python scripts are supported via:
--- !Py:  (default Python version)
--- !Py2: Python 2
--- !Py3: Python 3
---
---@param filename string Script file path
function Composition:RunScript(filename) end

----------------------------------------------------------------
--- Saves the current composition to disk.
---
--- The filename must be valid from the perspective of the system executing
--- the save operation. In network scenarios, the path is resolved on the
--- remote system performing the save.
---
---@param filename string Full composition file path
---@return boolean success True if saved successfully
function Composition:Save(filename) end

----------------------------------------------------------------
--- Opens a Save As dialog allowing the user to choose a save location.
---
--- This operation is interactive and blocks execution until resolved.
function Composition:SaveAs() end

----------------------------------------------------------------
--- Opens a Save As dialog and saves a copy of the composition.
---
--- The original composition remains unchanged.
function Composition:SaveCopyAs() end

----------------------------------------------------------------
--- Sets the currently active tool in the composition.
---
--- Only one tool can be active at any time.
--- Passing nil clears the active tool selection.
--- Active tool differs from selected tools (selection is multi-tool).
---
---@param tool fu.Tool? Tool to set as active, or nil to clear selection
function Composition:SetActiveTool(tool) end

----------------------------------------------------------------
--- Stores persistent data on the composition.
---
--- Data is saved with the composition file (.comp) and persists across sessions.
--- Keys may use dot notation to create hierarchical tables.
---
--- Storage behavior depends on object context:
--- - Fusion app: stored in Fusion.prefs
--- - Composition: stored in .comp file
--- - Ephemeral objects: may not persist
---
---@param name string Key name (supports "table.subtable" format)
---@param value any Value to store (number, string, boolean, or table)
function Composition:SetData(name, value) end

---------------------------------------------------------------------
--- Sets composition preferences.
---
--- This version accepts a key/value pair for a single preference.
--- It can be used to set or override individual preference entries.
---
--- Preferences are deeply integrated into Fusion's configuration system.
--- Keys may use dot notation to target nested preference tables.
---
--- Example:
--- ```lua
--- comp:SetPrefs("Comp.Interactive.BackgroundRender", true)
--- ```
---
--- WARNING:
--- Invalid values may still return true even if not applied correctly.
---
---@param prefname string Preference key
---@param val any Preference value
---@return boolean success
function Composition:SetPrefs(prefname, val) end

---------------------------------------------------------------------
--- Sets multiple composition preferences using a table.
---
--- The table must follow the format:
--- [prefs_name] = value
---
--- Nested tables are supported and will be merged into preference hierarchy.
---
--- If a preference does not exist, it will be created and persisted.
---
--- Example:
--- ```lua
--- comp:SetPrefs({
---     ["Comp.Unsorted.GlobalStart"] = 0,
---     ["Comp.Unsorted.GlobalEnd"] = 100
--- })
--- ```
---
---@param prefs table<string, any> Preference map
---@return boolean success
function Composition:SetPrefs(prefs) end

---------------------------------------------------------------------
--- Starts an undo block for grouping multiple operations.
---
--- All changes between StartUndo and EndUndo are treated as a single
--- undoable action in the UI.
---
--- IMPORTANT:
--- At least one actual modification must occur for the undo entry
--- to be registered in the undo stack.
---
--- Example:
--- ```lua
--- comp:StartUndo("Add some tools")
--- local bg1 = Background{}
--- local pl1 = Plasma{}
--- local mg1 = Merge{ Background = bg1, Foreground = pl1 }
--- comp:EndUndo(true)
--- ```
---
---@param name string Undo label shown in the UI
function Composition:StartUndo(name) end

---------------------------------------------------------------------
--- Stops interactive playback in the composition:
---
--- Equivalent to pressing the Stop button in the UI transport controls.
function Composition:Stop() end

---------------------------------------------------------------------
--- Performs undo or redo operations.
---
--- If count is positive → Undo
--- If count is negative → Redo
---
---@param count number Number of undo steps (negative = redo)
function Composition:Undo(count) end

---------------------------------------------------------------------
--- Unlocks the composition for interactive UI operations.
---
--- When locked, Fusion suppresses dialogs and disables reactive updates.
--- Unlock restores normal interactive behavior.
---
--- Safe to call even if already unlocked.
function Composition:Unlock() end

---------------------------------------------------------------------
--- Forces all composition views to refresh.
---
--- Used after script-driven changes to ensure UI consistency.
function Composition:UpdateViews() end