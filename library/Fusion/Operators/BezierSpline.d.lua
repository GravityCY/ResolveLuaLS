---@meta

---@class fu.BezierHandle
---@field x number X position of the spline handle
---@field y number Y position of the spline handle

---@class fu.BezierKeyframe
---@field value number Value at this keyframe
---@field LH fu.BezierHandle? Left handle (optional). Controls incoming curve tangency.
---@field RH fu.BezierHandle? Right handle (optional). Controls outgoing curve tangency.

---@alias fu.BezierKeyframeMap table<number, fu.BezierKeyframe>

--- A BezierSpline modifier represents animation on a numeric input using Bezier interpolation.
---
--- Keyframes are stored as time-indexed values, where each keyframe can optionally define
--- left and right Bezier handles to shape interpolation curvature.
---
--- This is used for smooth animated transitions between values (e.g. opacity, blend factors).
--- For animating point-based motion, use a Path instead of a BezierSpline.
---
--- Python usage:
--- comp.Merge1.Blend = comp.BezierSpline()
--- comp.Merge1.Blend[1] = 1
--- comp.Merge1.Blend[50] = 0
---
--- Lua usage:
--- Merge1.Blend = BezierSpline()
--- Merge1.Blend[1] = 1
--- Merge1.Blend[50] = 0
--- (Adds keyframes at frame 1 and 50)
---@class fu.BezierSpline : fu.Spline
local BezierSpline = {}

--- Set, offset, or scale a range of keyframes within the spline.
---
--- This operation modifies keyframe timing and/or values over the specified time range.
--- The operation mode determines behavior:
--- - "set"    : directly sets values
--- - "offset" : shifts existing values by x/y
--- - "scale"  : scales values relative to a pivot point
---
--- pivotx and pivoty define the origin for scaling operations and default to 0 if omitted.
---@param start number Start time of keyframe range (inclusive)
---@param _end number End time of keyframe range (inclusive)
---@param x number Time offset or scale factor (depending on operation)
---@param y number Value offset or scale factor (depending on operation)
---@param operation string Operation mode ("set", "offset", or "scale")
---@param pivotx number? Pivot X for scaling operations. Default is 0.
---@param pivoty number? Pivot Y for scaling operations. Default is 0.
function BezierSpline:AdjustKeyFrames(start, _end, x, y, operation, pivotx, pivoty) end

--- Delete keyframes within a specified time range.
---
--- If only start is provided, a single keyframe at that time is removed.
--- If both start and end are provided, all keyframes in the inclusive range are deleted.
---@param start number Start time (or single keyframe time)
---@param _end number? Optional end time for range deletion
function BezierSpline:DeleteKeyFrames(start, _end) end

--- Get a full description of the spline’s keyframes and Bezier curvature.
---
--- Unlike generic keyframe queries, this returns full curvature data including
--- optional left/right handle positions for each keyframe.
---
--- The returned table is indexed by keyframe time. Each entry contains:
--- - numeric value at that time
--- - optional LH (left handle) and RH (right handle) subtables
---
--- Example structure:
--- {
---   [0.0] = { 2.0, RH = { 12.6, 2.0 } },
---   [38.0] = { 3.86, LH = { 25.3, 3.66 }, RH = { 46.0, 4.0 } },
---   [62.0] = { 2.5, LH = { 54.0, 2.5 } }
--- }
---
--- Python usage:
--- splineout = comp.Merge1.Blend.GetConnectedOutput()
--- spline = splineout.GetTool()
--- splinedata = spline.GetKeyFrames()
---
--- Lua usage:
--- splineout = Merge1.Blend:GetConnectedOutput()
--- spline = splineout:GetTool()
--- splinedata = spline:GetKeyFrames()
---
---@return fu.BezierKeyframeMap
function BezierSpline:GetKeyFrames() end

--- Set the spline’s keyframes and full Bezier curvature data.
---
--- This replaces or updates the spline animation using a structured keyframe table.
--- Each entry is indexed by time and may include optional LH/RH handle definitions
--- to control interpolation curvature.
---
--- If replace is true, existing keyframes are fully replaced. Otherwise, behavior
--- depends on the host application’s merge rules.
---
--- Example:
--- {
---   [0.0] = { 2.0, RH = { 12.6, 2.0 } },
---   [38.0] = { 3.86, LH = { 25.3, 3.66 }, RH = { 46.0, 4.0 } },
---   [62.0] = { 2.5, LH = { 54.0, 2.5 } }
--- }
---@param keyframes fu.BezierKeyframeMap Keyframes indexed by time with optional Bezier handles
---@param replace boolean? If true, replace existing keyframes entirely
function BezierSpline:SetKeyFrames(keyframes, replace) end