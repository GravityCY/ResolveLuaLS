---@meta

---@class fu.CompAttribs
---@field COMPN_CurrentTime number This is the current time that the composition is at. This is the time that the user will see, and any modifications that do not specify a time will set a keyframe at this time.
---@field COMPB_HiQ boolean Indicates if the composition is currently in ‘HiQ’ mode or not.
---@field COMPB_Proxy boolean Indicates if the composition is currently in ‘Proxy’ mode or not
---@field COMPB_Rendering integer Indicates if the composition is currently rendering
---@field COMPN_RenderStart number The render start time of the composition. A render with no start will begin from this time.
---@field COMPN_RenderEnd number The render end time of the composition. A render with no end specified will render this frame last.
---@field COMPN_GlobalStart number The global start time of the comp. This is the start of time at which the composition is valid. Anything before this cannot be rendered or evaluated.
---@field COMPN_GlobalEnd number The global end time of the composition. This is the end of time at which the comp is valid. Anything after this cannot be rendered or evaluated.
---@field COMPN_LastFrameRendered number The most recent frame that has been successfully completed during a render.
---@field COMPN_LastFrameTime number The amount of time taken to render the most recently completed frame, in seconds.
---@field COMPN_AverageFrameTime number The average amount of time taken to render each frame to this point of the render, in seconds
---@field COMPN_TimeRemaining number An estimation of how much more time will be needed to complete this render, in seconds.
---@field COMPS_FileName string The full path and name of the composition file.
---@field COMPS_Name string The name of the composition.
---@field COMPI_RenderFlags integer The flags specified for the current render.
---@field COMPI_RenderStep integer The step value being used for the current render.
---@field COMPB_Locked boolean This indicates if the composition is currently locked

---@class fu.Comp
---@field Activetool fu.Tool Represents the currently active tool on this comp (read-only).
---@field AutoPos boolean Enable autoupdating of XPos/YPos when adding tools.
---@field CurrentFrame fu.FuFrame Represents the currently active frame for this composition (read-only).
---@field CurrentTime number The current time position for this composition.
---@field UpdateMode "Some"|"All"|"None" Represents the Some/All/None mode.
---@field XPos number The X coordinate on the flow of the next added tool.
---@field YPos number The Y coordinate on the flow of the next added tool.
local Comp = {};

--- Stops any current rendering.
function Comp:AbortRender() end

--- Asks the user before aborting the render.
function Comp:AbortRenderUI() end

--- Adds a tool type at a specified position.
--- 
--- - id the RegID of the tool to add.
--- - defsettings specifies whether user-modified default settings should be applied for the new tool (true) or not (false, default).
--- - xpos the X position of the tool in the flow view.
--- - ypos the Y position of the tool in the flow view.
--- 
--- You can use the number -32768 (the smallest negative value of a 16-bit integer) for both
--- x and y position. This will cause Fusion to add the tool as if you had clicked on one of
--- the toolbar icons. The tool will be positioned next to the currently selected one and a
--- connection will automatically be made if possible. If no tool is selected then the last
--- clicked position on the flow will be used. The same behaviour can be achieved with the
--- comp:AddToolAction method.
--- 
--- Returns a tool handle that can be used to control the newly added tool.
--- 
--- **Lua usage:**
--- ```
--- bg = comp:AddTool(“Background”, 1, 1)
--- mg = comp:AddTool(“Merge”, -32768, -32768)
--- ```
---@param id string
---@param defsettings boolean?
---@param xpos number?
---@param ypos number?
---@return fu.Tool
function Comp:AddTool(id, defsettings, xpos, ypos) end

--- Adds a tool to the comp.
--- 
--- If no positions are given it will cause Fusion to add the tool as if you had clicked on one
--- of the toolbar icons. The tool will be positioned next to the currently selected one and a
--- connection will automatically be made if possible. If no tool is selected then the last clicked
--- position on the flow will be used.
--- 
---@param id string
---@param xpos number?
---@param ypos number?
function Comp:AddToolAction(id, xpos, ypos) end

--- Show the Render Settings dialog.
function Comp:AskRenderSettings() end

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
---@param controls table
---@return table
function Comp:AskUser(title, controls) end

--- Displays a dialog with a list of selectable tools.
--- 
--- Returns the RegID of the selected tool or nil if the dialog was canceled.
---@param path string
---@return string
function Comp:ChooseTool(path) end

--- Clears the undo/redo history for the composition.
function Comp:ClearUndo() end

--- The Close function is used to close a composition. The Fusion Composition object that
--- calls the function will then be set to nil.
--- 
--- If the comp is in locked mode, then the Close function will not attempt to save the comp,
--- whether the comp has been modified or not since its last save. If modifications have been
--- made that should be kept, call the Save() function first.
--- 
--- If the comp is unlocked, it will ask if the comp should be saved before closing.
--- 
---@return boolean?
function Comp:Close() end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Copy tools to the Clipboard.
--- 
--- Accepts no parameters (currently selected tools), a tool or a list of tools.
---@return boolean
function Comp:Copy() end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Copy tools to the Clipboard.
--- 
--- Accepts no parameters (currently selected tools), a tool or a list of tools.
--- 
--- Returns true if successful, else false.
--- 
---@param tool fu.Tool
---@return boolean
function Comp:Copy(tool) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Copy tools to the Clipboard.
--- 
--- Accepts no parameters (currently selected tools), a tool or a list of tools.
--- 
--- Returns true if successful, else false.
---@param toollist table
---@return boolean
function Comp:Copy(toollist) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Copy a tools to a settings table.
--- 
--- Accepts no parameters (currently selected tools), a tool or a list of tools.
---@return table
function Comp:CopySettings() end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Copy a tools to a settings table.
--- 
--- Accepts no parameters (currently selected tools), a tool or a list of tools.
--- 
--- Returns the toollist as settings table.
---@param tool fu.Tool
---@return table
function Comp:CopySettings(tool) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Copy a tools to a settings table.
---@param toollist table
function Comp:CopySettings(toollist) end

--- Collapses a path into best-matching path map.
--- 
--- Whereas MapPath() is used to expand any Fusion path maps within a pathname to get an
--- ordinary literal path, ReverseMapPath() will perform the opposite process, and re-insert
--- those path maps.
--- 
--- This is often useful if the path is to be stored for later usage (within a comp or script, for
--- example). It allows the path to be used with the same meaning for another system or
--- situation, where the literal location of the path may be different.
--- 
--- In addition to handling all the global path maps like Fusion:ReverseMapPath(),
--- Comp:ReverseMapPath() also handles any path maps listed in the composition’s
--- Path Maps preferences page, as well as the built-in Comp: path map (see MapPath()).
--- 
--- Returns a path with the Fusion path map handles re-inserted wherever possible.
---@param mapped string
---@return string
function Comp:ReverseMapPath(mapped) end

--- Run a script within the composition’s script context.
--- 
--- Use this function to run a script in the composition environment. This is similar to launching
--- a script from the comp’s Scripts menu.
--- 
--- The script will be started with ‘fusion’ and ‘composition’ variables set to the Fusion and
--- currently active Composition objects. The filename given may be fully specified, or may be
--- relative to the comp’s Scripts: path.
--- 
--- Fusion supports .py .py2 and .py3 extensions to differentiate python script versions.
---@param filename string
function Comp:RunScript(filename) end

--- Save the composition
--- 
--- This function causes the composition to be saved to disk. The compname argument must
--- specify a path relative to the filesystem of the Fusion which is saving the composition. In
--- other words - if system ‘a’ is using the Save() function to instruct a Fusion on system ‘b’ to
--- save a composition, the path provided must be valid from the perspective of system ‘b’.
--- 
--- filename is the complete path and name of the composition to be saved.
---@param filename string
---@return boolean
function Comp:Save(filename) end

--- Prompt user with a Save As dialog box to save the composition.
function Comp:SaveAs() end

--- Prompt user with a Save As dialog box to save the composition as copy.
function Comp:SaveCopyAs() end

--- Set the currently active tool.
--- 
--- This function will set the currently active tool to one specified by script. It can be read with
--- ActiveTool.
--- 
--- To deselect all tools, omit the parameter or use nil.
--- 
--- Note that ActiveTool also means the tool is selected, while selected tools are not automativally
--- Active. Only one tool can be Active at a time. To select tools use FlowView:Select().
---@param tool fu.Tool
function Comp:SetActiveTool(tool) end

--- Set custom persistent data.
--- 
--- - name name of the data. This name can be in “table.subtable” format, to allow persistent
--- data to be stored within subtables.
--- - value to be recorded in the object’s persistent data. It can be of almost any type.
--- 
--- Persistent data is a very useful way to store names, dates, filenames, notes, flags, or anything
--- else, in such a way that they are permanently associated with this instance of the object,
--- and are stored along with the object using SetData(), and can be retrieved at any time with
--- GetData().
--- 
--- The method of storage varies by object: SetData() called on the Fusion app itself will
--- save its data in the Fusion.prefs file, and will be available whenever that copy of Fusion is
--- running. Calling SetData() on any object associated with a Composition will cause the data
--- to be saved in the .comp file, or in any settings files that may be saved directly from that
--- object. Some ephemeral objects that are not associated with any composition and are not
--- otherwise saved in any way, may not have their data permanently stored at all, and the data
--- will only persist as long as the object itself does.
--- 
--- **Lua usage:**
--- ```
--- tool:SetData(“Modified.Author”, fusion:GetEnv(“USERNAME”))
--- tool:SetData(“Modified.Date”, os.date())
--- dump(tool:GetData(“Modified”))
--- ```
---@param name string
---@param value any
function Comp:SetData(name, value) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Set preferences from a table of attributes.
--- 
--- The SetPrefs function can be used to specify the values of virtually all preferences in Fusion.
--- 
--- Its can take a table of values, identified by name, or a single name and value.
--- 
--- The table provided as an argument should have the format [prefs_name] = value. Subtables
--- are allowed.
--- 
--- It is possible to set a preference that does not exist. For example, setting fusion:SetPrefs
--- ({Comp.FrameFormat.Stuff = “Bob”}) will create a new preference which will be thereafter
--- preserved in the Fusion preferences file.
--- 
--- Returns false if any of the arguments provided to it are invalid, and true otherwise. Note
--- that the function will still return true if an attempt is made to set a preference to an invalid
--- value. For example, attempting to setting the FPS to “Bob” will fail, but the function will still
--- return true.
--- 
--- **Lua usage:**
--- ```
--- comp:SetPrefs({ [“Comp.Unsorted.GlobalStart”]=0, [“Comp.Unsorted.GlobalEnd”]=100 })
--- comp:SetPref(“Comp.Interactive.BackgroundRender”, true)
--- ```
---@param prefname string
---@param val any
function Comp:SetPrefs(prefname, val) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Set preferences from a table of attributes.
--- 
--- The SetPrefs function can be used to specify the values of virtually all preferences in Fusion.
--- 
--- Its can take a table of values, identified by name, or a single name and value.
--- 
--- The table provided as an argument should have the format [prefs_name] = value. Subtables
--- are allowed.
--- 
--- It is possible to set a preference that does not exist. For example, setting fusion:
--- SetPrefs({Comp.FrameFormat.Stuff = “Bob”}) will create a new preference which will be
--- thereafter preserved in the Fusion preferences file.
--- 
--- Returns false if any of the arguments provided to it are invalid, and true otherwise.
--- 
--- Note that the function will still return true if an attempt is made to set a preference to an
--- invalid value. For example, attempting to setting the FPS to “Bob” will fail, but the function
--- will still return true.
--- 
--- **Lua usage:**
--- ```
--- comp:SetPrefs({ [“Comp.Unsorted.GlobalStart”]=0, [“Comp.Unsorted.GlobalEnd”]=100 })
--- comp:SetPref(“Comp.Interactive.BackgroundRender”, true)
--- ```
---@param prefs table
function Comp:SetPrefs(prefs) end

--- Start an undo event.
--- 
--- The StartUndo() function is always paired with an EndUndo() function. Any changes made
--- to the composition by the lines of script between StartUndo() and EndUndo() are stored as
--- a single Undo event.
--- 
--- Changes captured in the undo event can be undone from the GUI using CTRL-Z, or the Edit
--- menu. They can also be undone from script, by calling the Undo function.
--- 
--- Should be used sparingly, as the user (or script) will have no way to undo the
--- preceding commands.
--- 
--- - name specifies the name displayed in the Edit/Undo menu of the Fusion GUI a string
--- containing the complete path and name of the composition to be saved.
--- 
--- Actual changes must be made to the composition (forcing a “dirty” event) before the undo
--- will be added to the stack.
--- 
--- **Lua usage:**
--- ```
--- composition:StartUndo(“Add some tools”)
--- bg1 = Background{}
--- pl1 = Plasma{}
--- mg1 = Merge{ Background = bg1, Foreground = pl1 }
--- composition:EndUndo(true)
--- ```
---@param name string
function Comp:StartUndo(name) end

--- Stops interactive playback.
--- 
--- Use this function in the same way that you would use the Stop button in the composition’s
--- playback controls.
function Comp:Stop() end

--- Undo one or more changes to the composition.
--- 
--- The Undo function triggers an undo event in Fusion. The count argument determines how
--- many undo events are triggered.
--- 
--- Note that the value of count can be negative, in which case Undo will behave as a Redo,
--- acting exactly as the Redo() function does.
--- 
--- - count specifies how many undo events to trigger.
---
---@param count number
function Comp:Undo(count) end

--- Unlock the composition.
--- 
--- The Unlock() function returns a composition to interactive mode. This allows Fusion to show
--- dialog boxes to the user, and allows re-rendering in response to changes to the controls.
--- Calling Unlock() will have no effect unless the composition has been locked with the Lock()
--- function first.
--- 
--- It is often useful to surround a script with Lock() and Unlock(), especially when adding tools
--- or modifying a composition. Doing this ensures Fusion won’t pop up a dialog to ask for user
--- input, e.g. when adding a Loader, and can also speed up the operation of the script since
--- no time will be spent rendering until the comp is unlocked.
--- 
--- **Lua usage:**
--- ```
--- comp:Lock()
--- -- Will not open the file dialog, since the composition is locked
--- my_loader = Loader()
--- comp:Unlock()
--- ```
function Comp:Unlock() end

--- UpdateViews
function Comp:UpdateViews() end
