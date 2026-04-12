---@meta

---@class fu.ProjectManager
local ProjectManager = {};

--- Archives project to provided file path with the configuration as provided by the optional arguments
---@param projectName string
---@param filePath string
---@param isArchiveSrcMedia boolean?
---@param isArchiveRenderCache boolean?
---@param isArchiveProxyMedia boolean?
---@return boolean
function ProjectManager:ArchiveProject(projectName, filePath, isArchiveSrcMedia, isArchiveRenderCache, isArchiveProxyMedia) end

--- Creates and returns a project if projectName (string) is unique, and None if it is not. Accepts an optional argument to set the media location path.
---@return fu.Project
function ProjectManager:CreateProject(projectName, mediaLocationPath) end

--- Delete project in the current folder if not currently loaded
---@return boolean
function ProjectManager:DeleteProject(projectName) end

--- Loads and returns the project with name = projectName (string) if there is a match found, and None if there is no matching Project.
---@return fu.Project
function ProjectManager:LoadProject(projectName) end

--- Returns the currently loaded Resolve project.
---@return fu.Project
function ProjectManager:GetCurrentProject() end

--- Saves the currently loaded project with its own name. Returns True if successful.
---@return boolean
function ProjectManager:SaveProject() end

--- Closes the specified project without saving.
---@param project string
---@return boolean
function ProjectManager:CloseProject(project) end

--- Creates a folder if folderName (string) is unique.
---@param folderName string
---@return boolean
function ProjectManager:CreateFolder(folderName) end

--- Deletes the specified folder if it exists. Returns True in case of success.
---@param folderName string
---@return boolean
function ProjectManager:DeleteFolder(folderName) end

--- Returns a list of project names in current folder.
---@return string[]
function ProjectManager:GetProjectListInCurrentFolder() end

--- Returns a list of folder names in current folder.
---@return string[]
function ProjectManager:GetFolderListInCurrentFolder() end

--- Opens root folder in database.
---@return boolean
function ProjectManager:GotoRootFolder() end

--- Opens parent folder of current folder in database if current folder has parent.
---@return boolean
function ProjectManager:GotoParentFolder() end

--- Returns the current folder name.
---@return string
function ProjectManager:GetCurrentFolder() end

--- Opens folder under given name.
---@param folderName string
---@return boolean
function ProjectManager:OpenFolder(folderName) end

--- Imports a project from the file path provided with given project name, if any. Returns True if successful.
---@param filePath string
---@param projectName string?
---@return boolean
function ProjectManager:ImportProject(filePath, projectName) end

--- Exports project to provided file path, including stills and LUTs if withStillsAndLUTs is True (enabled by default). Returns True in case of success.
---@param projectName string
---@param filePath string
---@param withStillsAndLUTs boolean?
---@return boolean
function ProjectManager:ExportProject(projectName, filePath, withStillsAndLUTs)end

--- Restores a project from the file path provided with given project name, if any. Returns True if successful.
---@param filePath string
---@param projectName string?
---@return boolean
function ProjectManager:RestoreProject(filePath, projectName) end

--- Returns a dictionary (with keys 'DbType', 'DbName' and optional 'IpAddress') corresponding to the current database connection
---@return table
function ProjectManager:GetCurrentDatabase() end

--- Returns a list of dictionary items (with keys 'DbType', 'DbName' and optional 'IpAddress') corresponding to all the databases added to Resolve
---@return table[]
function ProjectManager:GetDatabaseList() end

--- Switches current database connection to the database specified by the keys below, and closes any open project.
--- - 'DbType': 'Disk' or 'PostgreSQL' (string)
--- - 'DbName': database name (string)
--- - 'IpAddress': IP address of the PostgreSQL server (string, optional key - defaults to '127.0.0.1')
---@param dbInfo table
---@return boolean
function ProjectManager:SetCurrentDatabase(dbInfo) end

--- Creates and returns a cloud project.
---@param cloudSettings table Check 'Cloud Projects Settings' subsection below for more information.
---@return fu.Project 
function ProjectManager:CreateCloudProject(cloudSettings) end

--- Loads and returns a cloud project with the following cloud settings if there is a match found, and None if there is no matching cloud project.
---@param cloudSettings table Check 'Cloud Projects Settings' subsection below for more information.
---@return fu.Project
function ProjectManager:LoadCloudProject(cloudSettings) end

--- Returns True if import cloud project is successful; False otherwise
---@param filePath string filePath of file to import
---@param cloudSettings table Check 'Cloud Projects Settings' subsection below for more information.
---@return boolean
function ProjectManager:ImportCloudProject(filePath, cloudSettings) end

--- Returns True if restore cloud project is successful; False otherwise
---@param folderPath string path of folder to restore
---@param cloudSettings table
---@return boolean Check 'Cloud Projects Settings' subsection below for more information.
function ProjectManager:RestoreCloudProject(folderPath, cloudSettings) end
