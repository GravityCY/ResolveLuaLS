---@meta

---@class fu.GalleryStill
---Opaque object returned by Resolve API. No public methods are exposed.

---@class fu.GalleryStillAlbum
local GalleryStillAlbum = {};

---Returns the list of GalleryStill objects in the album.
---@return fu.GalleryStill[]
function GalleryStillAlbum:GetStills() end

---Returns the label of the given GalleryStill object.
---@param galleryStill fu.GalleryStill
---@return string
function GalleryStillAlbum:GetLabel(galleryStill) end

---Sets the label of the given GalleryStill object.
---@param galleryStill fu.GalleryStill
---@param label string
---@return boolean
function GalleryStillAlbum:SetLabel(galleryStill, label) end

---Imports GalleryStill objects from a list of file paths.
---Returns true if at least one still is successfully imported, otherwise false.
---@param filePaths string[]
---@return boolean
function GalleryStillAlbum:ImportStills(filePaths) end

---Exports a list of GalleryStill objects to a folder.
---Exports using the given file prefix and format.
---Supported formats: dpx, cin, tif, jpg, png, ppm, bmp, xpm, drx.
---@param galleryStills fu.GalleryStill[]
---@param folderPath string
---@param filePrefix string
---@param format string
---@return boolean
function GalleryStillAlbum:ExportStills(galleryStills, folderPath, filePrefix, format) end

---Deletes the specified list of GalleryStill objects from the album.
---@param galleryStills fu.GalleryStill[]
---@return boolean
function GalleryStillAlbum:DeleteStills(galleryStills) end