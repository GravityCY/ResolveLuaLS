---@meta

local t = {};

---@class fu.FusionAttrs
---@field FUSIONS_FileName string The path to the Fusion.exe file.
---@field FUSIONS_Version string The version of FUSION that we are connected to, in either string (FUSION_Version) or numeric (FUSIONI_VersionHi, FUSIONI_ VersionLo) format.
---@field FUSIONI_SerialHi integer The serial number of the Fusion licensethat we are connected to.
---@field FUSIONI_SerialLo integer The serial number of the Fusion licensethat we are connected to.
---@field FUSIONS_MachineType string The type (OS and CPU) of machine.
---@field FUSIONI_NumProcessors integer The number of processors present in themachine running Fusion.
---@field FUSIONB_IsManager boolean Indicates if this Fusion is currently a render master.
---@field FUSIONI_MemoryLoad integer The current Memory load percentage of the machine, from 0 to 100.
---@field FUSIONI_PhysicalRAMTotalMB integer The total amount of physical RAM, in MB.
---@field FUSIONI_PhysicalRAMFreeMB integer The amount of physical RAM free, in MB.
---@field FUSIONI_VirtualRAMTotalMB integer The total amount of virtual RAM, in MB.
---@field FUSIONI_VirtualRAMUsedMB integer The total amount of virtual RAM in use, in MB.
---@field FUSIONB_IsPost boolean Indicates if this Fusion is a Post license.
---@field FUSIONB_IsDemo boolean Indicates if this Fusion is a Demo license.
---@field FUSIONB_IsRenderNode boolean Indicates if this Fusion is a Render Node license.
---@field FUSIONH_CurrentComp table Returns a handle to the current composition that has the focus in Fusion.
---@field FUSIONI_VersionHi integer
---@field FUSIONI_VersionLo integer

---@class fu.Fusion
---@field Build integer
---@field Version integer
---@field Bins fu.BinManager
---@field CacheManager fu.ImageCacheManager
---@field CurrentComp fu.Comp
---@field FontManager fu.FontList
---@field HotkeyNanager fu.HotkeyManager
---@field QueueManager fu.QueueManager
---@field RenderManager fu.QueueManager
local Fusion = {};

fu = Fusion;
fusion = Fusion;

---@return fu.FusionAttrs
function Fusion:GetAttrs() end

---@return boolean
function Fusion:AllowNetwork() end

--- Clears the log if started with the /log argument
function Fusion:ClearFileLog() end

--- Creates a new FloatView
function Fusion:CreateFloatingView() end

--- Returns an object handle that can be manipulated with other mail related functions.
--- Within Fusion there are a number of scripts that can be used to send information to people
--- through email. This could be utilized to notify a user when their render is complete, or if any
--- errors have occurred with a render.
--- 
--- **Usage:**
--- ```
---     mail = fusion:CreateMail()
---     mail:AddRecipients(“vfx@studio.com, myself@studio.com”)
---     mail:SetSubject(“Render Completed”)
---     mail:SetBody(“The job completed.”)
---     ok,errmsg = mail:Send()
---     print(ok)
---     print(errmsg)
--- ```
---@return fu.MailMessage
function Fusion:CreateMail() end

--- Writes the state of all current Cg shaders to the given file
---@param filename string
function Fusion:DumpCgObjects(filename) end

--- Writes the state of all current OpenGL objects to the given file
---@param filename string
function Fusion:DumpGLObjects(filename) end

--- Writes the information of the graphics hardware to the given file
---@param filename string
function Fusion:DumpGraphicsHardwareInfo(filename) end

--- Writes the information of the OpenCL device to the given file
---@param filename string
function Fusion:DumpOpenCLDeviceInfo(filename) end

--- Executes a script string for the fusion instance
---@see fu.Comp.Execute
function Fusion:Execute() end

--- Finds a registry object by name.
--- 
--- An optional type restricts the search. Some valid type constants include
--- - CT_Tool
--- - CT_Filter
--- - CT_FilterSource
--- - CT_ParticleTool
--- - CT_ImageFormat
---@param id string
---@param type string?
---@return fu.Registry?
function Fusion:FindReg(id, type) end

--- Returns a table containing information about the current application’s name, executable, version, and build number.
---@return table
function Fusion:GetAppInfo() end

--- Get command line arguments.\
--- Returns Fusion's command line arguments as a table
---@return string[]
function Fusion:GetArgs() end

--- Retrieves the current CPU load of the system as a percentage between 0 and 100
---@return number
function Fusion:GetCPULoad() end

--- Retrieves the tool(s) on the clipboard, as tables and as ASCII text.
---@return string|table|nil
function Fusion:GetClipboard() end

--- Retrieves a table of all compositions currently present.
---@return fu.Comp[]
function Fusion:GetCompList() end

--- Returns the currently active composition
---@return fu.Comp
function Fusion:GetCurrentComp() end

--- Get custom persistent data
---@param name string
---@return any
function Fusion:GetData(name) end

--- Retrieve the value of an enviroment variable
--- 
--- Returns the value of an environment variable on the machine running Fusion. This function is identical to the global os.getenv() function, except that it runs in the context of the Fusion instance, so if the Fusion instance points to a remote copy of Fusion the environment variable will come from the remote machine.
---@param name string
---@return string
function Fusion:GetEnv(name) end

--- Returns a table of all global path maps
---@param builtins boolean
---@param defaults boolean
---@return table
function Fusion:GetGlobalPathMap(builtins, defaults) end

--- Get the window handle for fusion
---@return table
function Fusion:GetMainWindow() end

--- Retrieve a table of preferences
--- 
--- This function is useful for getting the full table of global preferences, or a subtable, or a specific value.\
--- If the argument is omitted all preferences will be returned.\
--- Returns a table of preferences, or a specific preference value.
--- 
--- **Usage:**
--- ```
--- dump(fusion:GetPrefs(“Global.Paths.Map”))
--- print(fusion:GetPrefs(“Global.Controls.GrabDistance”))
--- ```
---@param prefname string
---@param excludeDefaults boolean
---@return any
function Fusion:GetPrefs(prefname, excludeDefaults) end

--- Retrieves a table of global previews.
--- 
--- This function returns a list of preview objects currently available to the Fusion object. The
--- Composition:GetPreviewList function is similar, but it will not return floating views, like this
--- function does.
---@return table
function Fusion:GetPreviewList() end

--- Retrieve information about a registry ID.
--- 
--- The GetRegAttrs() function will return a table with the attributes of a specific individual
--- registry entry in Fusion. The only argument is the ID, a unique numeric identifier possessed
--- by each entry in the registry. The ID identifiers for each registry item can be obtained from
--- fusion:GetRegList(), fusion:FindRegID(), and tool:GetID() functions.
--- 
--- Registry attributes are strictly read only, and cannot be modified in any way.
--- ```
--- -- Dump RegAttrs for the Active tool,
--- -- or prints message if nothing is Active.
--- dump(comp.ActiveTool and
--- fusion:GetRegAttrs(comp.ActiveTool.ID) or
--- “Please set an ActiveTool first.”)
--- ```
---@param id string
---@param type number
function Fusion:GetRegAttrs(id, type) end

--- Retrieve a list of all registry objects known to the system.
--- 
--- The Fusion registry stores information about the configuration and capabilities of a
--- particular installation of Fusion. Details like which file formats are supported, and which
--- tools are installed are found in the registry. Note that this is NOT the same thing as the
--- operating system registry, the registry accessed by this function is unique to Fusion.
--- 
--- The only argument accepted by GetRegAttrs is a mask constant, which is used to filter the
--- registry for specific registry types. The constants represent a particular type of registry
--- entry, for example CT_Any will return all entries in the registry, while CT_Source will only
--- return entries describing tools from the source category of tools (Loader, Plasma, Text...). A
--- complete list of valid constants can be found here.
--- 
--- Returns a table, which contains a list of the Numeric ID values for each registry entry. The
--- numeric ID is constant from machine to machine, e.g. the numeric ID for the QuickTime
--- format would be 1297371438, regardless of the installation or version of Fusion.
--- 
--- These ID’s are used as arguments to the GetRegAttrs() function, which provides access to
--- the actual values stored in the specific registry setting.
--- typemask a predefined constant that determines the type of registry entry returned by
--- the function.
--- 
--- Some valid Mask constants:
--- - CT_Tool all tools
--- - CT_Mask mask tools only
--- - CT_SourceTool creator tools (images/3D/particles) all of which don’t require an input image
--- - CT_ParticleTool Particle tools
--- - CT_Modifier Modifiers
--- - CT_ImageFormat ImageFormats
--- - CT_View Different sections of the interface
--- - CT_GLViewer All kinds of viewers
--- - CT_PreviewControl PreviewControls in the viewer
--- - CT_InputControl Input controls
--- - CT_BinItem Bin items
--- 
--- **Usage:**
--- ```
--- -- this example will print out all of the
--- -- image formats supported by this copy
--- -- of Fusion
--- reg = fusion:GetRegList(CT_ImageFormat)
--- reg.Attrs = {}
--- for i = 1, #reg do
---     reg.Attrs[i] = fusion:GetRegAttrs(reg[i].ID)
---     name = reg.Attrs[i].REGS_MediaFormat_FormatName
---     if name == nil then
---         name = reg.Attrs[i].REGS_Name
---     end
---     --dump(reg.Attrs[i])
---     if reg.Attrs[i].REGB_MediaFormat_CanSave == true then
---         print(name)
---     else
---         print(name .. “ (Cannot Save)”)
---     end
--- end
--- ```
---@param typemask number
---@return table
function Fusion:GetRegList(typemask) end

--- Retrieve a list of basic info for all registry objects known to the system.
--- 
--- This function is useful for getting the full table of global preferences, or a subtable, or a
--- specific value.
--- 
--- Returns a table containing a summary of the Name, ID, ClassType, and OpIconString of
--- every item in the registry. Useful for returning a lightweight version of the information
--- presented by Fusion:GetRegList.
---@param typemask number
---@param hidden boolean
---@return table
function Fusion:GetRegSummary(typemask, hidden) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Loads an existing composition.
--- 
--- auto-close a true or false value to determine if the composition will close automatically
--- when the script exits. Defaults to false.
--- 
--- hidden if this value is true, the comp will be created invisibly, and no UI will be available to
--- the user. Defaults to false.
--- 
--- Returns a handle to the opened composition.
---@param filename string
---@param quiet boolean
---@param autoclose boolean
---@param hidden boolean
---@return fu.Comp
function Fusion:LoadComp(filename, quiet, autoclose, hidden) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Loads an existing composition.
--- 
--- Returns a handle to the opened composition.
---@param filename string
---@param options table
---@return fu.Comp
function Fusion:LoadComp(filename, options) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Loads an existing composition.
--- 
--- Returns a handle to the opened composition.
---@param savedcomp fu.MemBlock
---@param options table
---@return fu.Comp
function Fusion:LoadComp(savedcomp, options) end

--- Reloads all current global preferences.
--- 
--- Reloads all global preferences from the specified file and (optionally) an overriding master
--- prefs file.
---@param filename string?
---@param mastername string?
---@return boolean
function Fusion:LoadPrefs(filename, mastername) end

--- Loads an composition from the recent file list.
--- 
--- index the most recent composition is 1. The index is the same as in the Recent Files menu.
--- 
--- auto-close a true or false value to determine if the composition will close automatically
--- when the script exits. Defaults to false.
--- 
--- hidden if this value is true, the comp will be created invisibly, and no UI will be available to
--- the user. Defaults to false.
---@param index integer
---@param quiet boolean?
---@param autoclose boolean?
---@param hidden boolean?
---@return fu.Comp
function Fusion:LoadRecentComp(index, quiet, autoclose, hidden) end

--- Expands path mappings in a path string.
--- 
--- **Usage:**
--- ```
--- print(MapPath(“Fusion:”))
--- ```
---@see fu.Comp.MapPath
---@param path string
---@return string
function Fusion:MapPath(path) end

--- Expands all path mappings in a multipath.
--- 
---@see fu.Comp.MapPathSegments
---@param path string
---@return table
function Fusion:MapPathSegments(path) end

--- Creates a new composition.
--- 
--- auto-close a true or false value to determine if the composition will close automatically
--- when the script exits. Defaults to false.
--- 
--- hidden if this value is true, the comp will be created invisibly, and no UI will be available to
--- the user. Defaults to false.
---@param quiet boolean?
---@param autoclose boolean?
---@param hidden boolean?
---@return fu.Comp
function Fusion:NewComp(quiet, autoclose, hidden) end

--- Open a file.
--- 
--- filename specifies the full path and name of the file to open
--- mode specifies the mode(s) of file access required, from a combination of the following
--- constants:
--- 
--- FILE_MODE_READ Read access FILE_MODE_WRITE Write access FILE_MODE_
--- 
--- UNBUFFERED Unbuffered access FILE_MODE_SHARED Shared access
--- 
--- Returns a file object or nil if the open fails.
--- 
--- **Lua usage:**
--- ```
--- fusion:OpenFile([[c:\\fusion.log]], FILE_MODE_READ)
--- line = f:ReadLine()
--- while line do
---     print(line)
--- line = f:ReadLine()
--- end
--- ```
--- > Return type: File
---@param filename string
---@param mode number
---@return file*
function Fusion:OpenFile(filename, mode) end

--- OpenLibrary
function Fusion.OpenLibrary() end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- Queue a composition to be rendered locally.
--- 
--- The QueueComp function submits a composition from disk to the render manager. If the
--- render start and end are not provided then the render manager will render the range saved
--- with the composition. Otherwise these arguments will override the saved range.
--- 
--- Returns true if it succeeds in adding the composition to the Queue, and false if it fails.
--- 
--- Specifies the slave group to use for this job. The following keys are valid:
--- - **FileName:** The Comp to queue 
--- - **QueuedBy:** Who queued this comp 
--- - **Groups:** Slave groups to render on 
--- - **Start:** Render Start 
--- - **End:** Render End 
--- - **FrameRange:** Frame range string, used in place of start/end above 
--- - **RenderStep:** Render Step 
--- - **ProxyScale:** Proxy Scale to render at
--- - **TimeOut:** Frame timeout
--- 
--- **Lua usage:**
--- ```
--- -- QueueComp with additional options
--- fusion:QueueComp({
---     FileName = [[c:\example.comp]],
---     QueuedBy = “Bob Lloblaw”,
---     Start = 1,
---     End = 25,
---     Step = 5,
---     ProxyScale = 2
--- })
--- -- Specify a non-sequential frame range
--- fusion:QueueComp({
---     FileName=[[c:\example.comp]],
---     FrameRange = “1..10,20,30,40..50”
--- })
--- ```
---@param args table
---@return fu.RenderJob
function Fusion:QueueComp(args) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- Queue a composition to be rendered locally.
--- 
--- The QueueComp function submits a composition from disk to the render manager. If the
--- render start and end are not provided then the render manager will render the range saved
--- with the composition. Otherwise these arguments will override the saved range.
--- 
--- Returns true if it succeeds in adding the composition to the Queue, and false if it fails.
--- 
--- filename a string describing the full path to the composition which is to be queued.
--- 
--- start a number which describes the first frame in the render range.
--- 
--- end a number which describes the last frame in the render range.
--- 
--- group specifies the slave group to use for this job.
--- 
---@param filename string
---@param start number?
---@param fin number?
---@param group string?
---@return fu.RenderJob
function Fusion:QueueComp(filename, start, fin, group) end

--- Quit Fusion.
--- 
--- The Quit command will cause the copy of Fusion referenced by the Fusion instance object
--- to exit. The Fusion instance object will then be set to nil.
---@param exitcode number
function Fusion:Quit(exitcode) end

--- Collapses a path into best-matching path map.
--- 
---@see fu.Comp.ReverseMapPath
---@param mapped string
---@return string
function Fusion:ReverseMapPath(mapped) end

--- Run a script within the Fusion’s script context.
--- 
---@see fu.Comp.RunScript
---@param filename string
function Fusion:RunScript(filename) end

--- Saves all current global preferences.
--- 
--- **Lua usage:**
--- ```
--- fusion:SetPrefs(“Comp.AutoSave.Enabled”, true)
--- fusion:SavePrefs()
--- ```
---@param filename string?
function Fusion:SavePrefs(filename) end

--- SetBatch
function Fusion:SetBatch() end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Sets the clipboard to contain the tool(s) as ASCII text.
--- 
--- Sets the clipboard to the text specified.
---@param input string
---@return boolean
function Fusion.SetClipboard(input) end
--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Sets the clipboard to contain the tool(s) specifed by a table
--- 
--- Sets the system clipboard to contain the ASCII for tool(s) specifed by a table
---@param input table
---@return boolean
function Fusion.SetClipboard(input) end

--- Set custom persistent data.
--- 
---@see fu.Comp.SetData
---@param name string
---@param value any
function Fusion.SetData(name, value) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Set preferences
--- 
--- **Lua usage:**
--- ```
--- fusion:SetPrefs(“Global.Controls.AutoClose”, false)
--- ```
--- 
---@param prefname string
---@param val any
function Fusion.SetPrefs(prefname, val) end

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
--- **Lua usage:**
--- ```
--- fusion:SetPrefs({
---     [“Global.Network.Mail.OnJobFailure”]=true,
---     [“Global.Network.Mail.Recipients”]=”admin@studio.com”
--- })
--- ```
--- 
---@param prefs table
function Fusion.SetPrefs(prefs) end

--- Display the About dialog.
function Fusion.ShowAbout() end

--- Display the Preferences dialog.
--- 
--- The ShowPrefs function will display the Preferences dialog. Optional arguments
--- can be used to specify which page or panel of the preferences will be opened.
--- 
--- pageid name of the specific page (or panel) of the preferences to
--- show. 
--- 
--- The name should be chosen from one of the following
--- - PrefsGeneral
--- - Prefs3D
--- - PrefsBinSecurity
--- - PrefsBinServers
--- - PrefsBins
--- - PrefsDefaults
--- - PrefsFlow
--- - PrefsFrameFormat
--- - PrefsEDLImport
--- - PrefsLayout
--- - PrefsLoader
--- - PrefsMemory
--- - PrefsNetwork
--- - PrefsOpenCL
--- - PrefsPathMap
--- - PrefsPreview
--- - PrefsQuickTime
--- - PrefsScript
--- - PrefsSplineViews
--- - PrefsSplines
--- - PrefsTimeline
--- - PrefsTweaks
--- - PrefsUI
--- - PrefsDeckLink
--- - PrefsView
--- 
--- **Lua usage:**
--- ```
--- -- Open Preferences at the view page
--- fu:ShowPrefs(“PrefsView”)
--- -- Print possible prefname for the current Fusion version
--- for i,v in ipairs(fu:GetRegList(CT_Prefs)) do
---     print(v:GetAttrs().REGS_ID)
--- end
--- ```
---@param pageid string?
---@param showall boolean?
---@param comp fu.Comp?
function Fusion.ShowPrefs(pageid, showall, comp) end

--- Show or Hide main window.
--- 
--- This function will show or hide the main window of Fusion. Note that you can only reshow
--- the window after hiding it if you are using the command prompt to control Fusion.
--- 
---@param mode number
function Fusion.ShowWindow(mode) end

--- Idk why this exists but it's in the docs...
function Fusion.Test() end

--- Shows or hides the Bins window
function Fusion.ToggleBins() end

--- Shows or hides the Render Manager.
function Fusion.ToggleRenderManager() end

--- Shows or hides a Utility plugin.
---@param id string
function Fusion.ToggleUtility(id) end