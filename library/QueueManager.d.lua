---@meta

---@class fu.QueueManagerAttribs
---@field RQUEUEB_Paused boolean True if rendering is currently paused, and no jobs are being rendered.
---@field RQUEUEB_Verbose boolean True if Verbose Logging is currently enabled.
---@field RQUEUES_QueueName string The name of the file the queue has been loaded from, or saved to, if any.

---@class fu.QueueManager
local QManager = {};

--- AddItem
function QManager:AddItem() end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Adds a job to the list.
--- 
--- This function allows a user to add jobs remotely to the Fusion Render Manager, either
--- through a standalone script or through the Fusion interface. This is potentially useful for the
--- batch adding of jobs.
--- 
--- filename A valid path for a job to be added to the render manager.
--- 
--- groups A string listing the slave groups (comma separated) to render this job on. Defaults to “all”.
--- 
--- frames The set of frames to render, e.g. “1..150,155,160”. If nil or unspecified, the comp’s saved frame range will be used.
--- 
--- endscript Full pathname of a script to be executed when this job has completed (available from the RenderJob object as the RJOBS_CompEndScript attribute).
--- 
--- Returns the RenderJob object just created in the queue manager.
---@param filename string
---@param groups string?
---@param frames string?
---@param endscript string?
---@return fu.RenderJob
function QManager:AddJob(filename, groups, frames, endscript) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Adds a job to the list.
--- 
--- This function allows a user to add jobs remotely to the Fusion Render Manager, either
--- through a standalone script or through the Fusion interface. This is potentially useful for the
--- batch adding of jobs.
--- 
--- filename A valid path for a job to be added to the render manager.
--- 
--- groups A string listing the slave groups (comma separated)
--- to render this job on. Defaults to “all”.
--- 
--- frames The set of frames to render, e.g. “1..150,155,160”. If nil or
--- unspecified, the comp’s saved frame range will be used.
--- 
--- endscript Full pathname of a script to be executed when this job has completed
--- (available from the RenderJob object as the RJOBS_CompEndScript attribute).
--- 
--- Returns the RenderJob object just created in the queue manager.
---@param args table
---@return fu.RenderJob
function QManager:AddJob(args) end

--- Adds a slave to the slave list.
--- 
--- This function allows a user to add jobs remotely to the Fusion Render Manager, either
--- through a standalone script or through the Fusion interface. This is potentially useful for the
--- batch adding of jobs.
--- 
--- name the slave’s hostname or IP address.
--- 
--- groups the render groups to join (this defaults to “all”).
--- 
--- Returns the RenderSlave object just created in the queue manager.
---@param name string
---@param groups string?
---@param unused boolean?
---@return fu.RenderSlave
function QManager:AddSlave(name, groups, unused) end

--- AddWatch
function QManager:AddWatch() end

--- DeleteItem
function QManager:DeleteItem() end

--- Get a list of all slave groups.
--- 
--- Returns a table of all the various groups used by the slaves within this QueueManager
---@return string[]
function QManager:GetGroupList() end

--- GetID
function QManager:GetID() end

--- GetItemList
function QManager:GetItemList() end

--- GetJobFromID
function QManager:GetJobFromID() end

--- Get the list of jobs to render.
--- 
--- Returns a table with RenderJob objects that represent the jobs currently in the queue
--- manager. Like any other object within Fusion, these objects have attributes that indicate
--- information about the status of the object, and functions that can query or manipulate
--- the object.
--- > Lua usage:
--- -- Print all RenderJobs in Queue.
--- qm = fusion.RenderManager
--- joblist = qm:GetJobList()
--- for i, job in pairs(joblist) do
--- print(job:GetAttrs().RJOBS_Name)
--- end
--- > Returns: jobs
--- > Return type: table
function QManager:GetJobList() end

--- Get tables with current RenderJob information.
function QManager:GetJobs() end

--- GetRootData
function QManager:GetRootData() end

--- GetSchemaList
function QManager:GetSchemaList() end

--- GetSlaveFromID
function QManager:GetSlaveFromID() end

--- Get the list of available slaves.
--- This function returns a table with RenderSlave objects that represent
--- the slaves currently listed in the queue manager.
--- > Lua usage:
--- -- Print all RenderSlaves in Queue.
--- qm = fusion.RenderManager
--- slavelist = qm:GetSlaveList()
--- for i, slave in pairs(slavelist) do
--- print(slave:GetAttrs().RSLVS_Name)
--- end
--- > Returns: slaves
--- > Return type: table
function QManager:GetSlaveList() end

--- Get tables with current RenderSlave information.
function QManager:GetSlaves() end

--- Loads a list of jobs to do.
--- This function allows a script to load a Fusion Studio Render Queue file,
--- containing a list of jobs to complete, into the queue manager.
--- filename path to the queue to load.
--- > Parameters:
--- filename (string) – filename
function QManager:LoadQueue(filename) end

--- Loads a list of slaves to use.
--- > Parameters:
--- filename (string) – filename
--- > Returns: success
--- > Return type: boolean
function QManager:LoadSlaveList(filename) end

--- Writes a message to the Render Log.
--- Write messages to the render manager’s log. This is useful for triggering
--- custom notes for compositions submitted to the manager.
--- > Parameters:
--- message (string) – message
function QManager:Log(message) end

--- Moves a job up or down the list.
--- 
--- Changes the priority of jobs in the render manager by an offset.
--- job the RenderJob to move.
--- 
--- offset how far up or down the job list to move it (negative numbers will move it upwards).
--- 
--- **Lua usage:**
--- ```
--- -- Moves all jobs called “master” to the top of the queue
--- -- or at least up one hundred entries.
--- qm = fusion.RenderManager
--- jl = qm:GetJobList()
--- for i, job in pairs(jl) do
---     if job:GetAttrs().RJOBS_Name:find(“master”) then
---         qm:MoveJob(job,-100)
---     end
--- end
--- ```
---@param job fu.RenderJob
---@param offset number
function QManager:MoveJob(job, offset) end

--- NetJoinRender
function QManager:NetJoinRender() end

--- Removes a job from the list.
---@param job fu.RenderJob
function QManager:RemoveJob(job) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Removes a slave from the slave list.
---@param slave fu.RenderSlave
function QManager:RemoveSlave(slave) end

--- Note: This method is overloaded and has alternative parameters. See other definitions.
--- 
--- Removes a slave from the slave list.
---@param slave string
function QManager:RemoveSlave(slave) end

--- RemoveWatch
function QManager:RemoveWatch() end

--- Saves the current list of jobs.
--- 
--- filename the location to save the queue in.
--- 
--- This function save the currently loaded queue in the render manager to a file.
---@param filename string
function QManager:SaveQueue(filename) end

--- Saves the current list of slaves.
---@param filename string?
---@return boolean
function QManager:SaveSlaveList(filename) end

--- Scans local network for new slaves.
--- 
--- This function locates all machines on the local network (local subnet only), queries each
--- to find out if they are currently running a copy of Fusion then adds them to the manager’s
--- Slaves list.
function QManager:ScanForSlaves() end

--- Start
function QManager:Start() end

--- Stop
function QManager:Stop() end

--- UpdateItem
function QManager:UpdateItem() end

