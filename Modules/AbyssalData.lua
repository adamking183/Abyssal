local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local setclipboard = setclipboard or (syn and syn.setclipboard) or (Clipboard and Clipboard.set)

local http_service = game:GetService("HttpService")
local user_input_service = game:GetService("UserInputService")

local user_device    
if not user_input_service.MouseEnabled and not user_input_service.KeyboardEnabled and user_input_service.TouchEnabled then
    user_device = "Mobile"
elseif user_input_service.MouseEnabled and user_input_service.KeyboardEnabled and not user_input_service.TouchEnabled then
    user_device = "PC"
end

local discord_invite_code = "Abyssal"
local discord_invite_url = "https://discord.com/invite/" .. discord_invite_code

local AbyssalData; AbyssalData = {
    MainLoaderUrl = "https://raw.githubusercontent.com/adamking183/Abyssal/refs/heads/main/Loader.lua",
    Device = user_device,
    DiscordInviteCode = discord_invite_code,
    DiscordInviteURL = discord_invite_url,
    JoinDiscord = function(self)
        setclipboard(self.discord_invite_url)

        if httprequest and self.user_device == "PC" then
            pcall(function()
                httprequest({
                    Url = 'http://127.0.0.1:6463/rpc?v=1',
                    Method = 'POST',
                    Headers = {
                        ['Content-Type'] = 'application/json',
                        Origin = 'https://discord.com'
                    },
                    Body = http_service:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = http_service:GenerateGUID(false),
                        args = { 
                            code = self.discord_invite_code
                        }
                    })
                })
            end)
        end
    end
}

return AbyssalData
