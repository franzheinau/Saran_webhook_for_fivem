local WEBHOOK = "https://discord.com/api/webhooks/xxxxxxxxx"-- isi dengan webhook discord kalian bre
local cooldowns = {}
local COOLDOWN_TIME = 60 -- detik

RegisterNetEvent('saran:send', function(saran)
    local src = source
    local now = os.time()

    if cooldowns[src] and now < cooldowns[src] then
        return
    end
    cooldowns[src] = now + COOLDOWN_TIME

    local name = GetPlayerName(src)

    local embed = {
  {
    title = "📩 Kotak Saran Kota",
    color = 5793266,
    description =
      "**👤 Player ID:** " .. src .. "\n" ..
      "**🧑 Nama:** " .. name .. "\n\n" ..
      "**💬 Saran:**\n```" .. saran .. "```",
    footer = {
      text = os.date("%d-%m-%Y %H:%M:%S")
    }
  }
}

    PerformHttpRequest(
        WEBHOOK,
        function() end,
        'POST',
        json.encode({
            username = 'Kotak Saran',
            embeds = embed
        }),
        { ['Content-Type'] = 'application/json' }
    )
end)
