---@meta

---@class fu.MailMessage
---Represents an email message.
---
---If no explicit server settings are set with SetServer, SetLogin and SetPassword,
---the default Preferences (Globals -> Network -> Server Settings ...) are used.
---If these are not set, the recipient server is tried to be reached.
---
---Example usage:
---```lua
---mail = fusion:CreateMail()
---mail:AddRecipients("vfx@studio.com, myself@studio.com")
---mail:SetSubject("Render Completed")
---mail:SetBody("The job completed.")
---local ok, errmsg = mail:Send()
---print(ok)
---print(errmsg)
---```
local MailMessage = {}

---Attaches a filename to the body.
---@param filename string The file path to attach
---@return boolean success Whether the attachment was added successfully
function MailMessage:AddAttachment(filename) end

---Adds recipients to the To: list.
---@param addresses string Comma-separated email addresses
function MailMessage:AddRecipients(addresses) end

---Adds recipients to the To: list.
---@overload fun(self: MailMessage, addresses: string)
---@param addresses table Table of email addresses
function MailMessage:AddRecipients(addresses) end

---Returns the message in the form of a table.
---@return table msg The message data as a table
function MailMessage:GetTable() end

---Removes all attachments from the message.
function MailMessage:RemoveAllAttachments() end

---Removes all recipients from the To: field.
function MailMessage:RemoveAllRecipients() end

---Sends the message.
---Returns the success as boolean and an error message if failed.
---@return boolean success Whether the send was successful
---@return string? errmsg Error message if send failed
function MailMessage:Send() end

---Sets the message body.
---@param bodytext string The plain text body content
function MailMessage:SetBody(bodytext) end

---Sets the message body using HTML.
---@param bodyhtml string The HTML body content
function MailMessage:SetHTMLBody(bodyhtml) end

---Sets the login to use for authentication.
---@param login string The login username
function MailMessage:SetLogin(login) end

---Sets the password to use for authentication.
---@param password string The authentication password
function MailMessage:SetPassword(password) end

---Sets the From: field.
---@param sender string The sender email address
function MailMessage:SetSender(sender) end

---Sets the From: field.
---@overload fun(self: fu.MailMessage, sender: string)
---@param sender table Table containing sender information
function MailMessage:SetSender(sender) end

---Sets the outgoing mail server to use.
---@param servername string The SMTP server address
function MailMessage:SetServer(servername) end

---Sets the Subject: field.
---@param subject string The email subject line
function MailMessage:SetSubject(subject) end