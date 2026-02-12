local open = false
local cooldown = false
local COOLDOWN_TIME = 60 -- detik

RegisterCommand('saran', function()
    if cooldown then
        TriggerEvent('chat:addMessage', {
            args = { '^1Sistem', 'Tunggu sebentar sebelum mengirim saran lagi.' }
        })
        return
    end

    open = true
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end)

RegisterNUICallback('close', function(_, cb)
    open = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })

    cb('ok')
end)

RegisterNUICallback('sendSaran', function(data, cb)
    if cooldown then
        cb('cooldown')
        return
    end

    TriggerServerEvent('saran:send', data.saran)

    cooldown = true
    SetTimeout(COOLDOWN_TIME * 1000, function()
        cooldown = false
    end)

    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })

    cb('ok')
end)
