---@meta

---@class fu.Gallery
local Gallery = {};

---Returns the name of a GalleryStillAlbum object.
---@param galleryStillAlbum fu.GalleryStillAlbum
---@return string
function Gallery:GetAlbumName(galleryStillAlbum) end

---Sets the name of a GalleryStillAlbum object.
---@param galleryStillAlbum fu.GalleryStillAlbum
---@param albumName string
---@return boolean
function Gallery:SetAlbumName(galleryStillAlbum, albumName) end

---Returns the current album as a GalleryStillAlbum object.
---@return fu.GalleryStillAlbum
function Gallery:GetCurrentStillAlbum() end

---Sets the current album to the given GalleryStillAlbum object.
---@param galleryStillAlbum fu.GalleryStillAlbum
---@return boolean
function Gallery:SetCurrentStillAlbum(galleryStillAlbum) end

---Returns all still albums in the gallery as a list of GalleryStillAlbum objects.
---@return fu.GalleryStillAlbum[]
function Gallery:GetGalleryStillAlbums() end

---Returns all PowerGrade albums in the gallery as a list of GalleryStillAlbum objects.
---@return fu.GalleryStillAlbum[]
function Gallery:GetGalleryPowerGradeAlbums() end

---Creates a new Still album in the gallery.
---Returns the newly created GalleryStillAlbum object, or nil if creation fails.
---@return fu.GalleryStillAlbum|nil
function Gallery:CreateGalleryStillAlbum() end

---Creates a new PowerGrade album in the gallery.
---Returns the newly created GalleryStillAlbum object, or nil if creation fails.
---@return fu.GalleryStillAlbum|nil
function Gallery:CreateGalleryPowerGradeAlbum() end