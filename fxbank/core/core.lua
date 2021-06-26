FX = nil
msec = nil
Citizen.CreateThread(function()
    while FX == nil do
        TriggerEvent('fx:get', function(core) FX = core end)
        Citizen.Wait(0)
    end
end)

AddBlip

ShowHelpNotification = function(msg, thisFrame, beep, duration)
	AddTextEntry('HelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('HelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('HelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end


Citizen.CreateThread(function()
    Wait(5000)
    while true do
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        inBank = false

        for k, v in pairs(FXConfig.Banks) do
            local distance = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, v.x, v.y, v.z)

            if distance > 25 then
                msec = 2000
            elseif distance < 25 then
                msec = 1000
            elseif distance < 5 then
                msec = 0
                ShowHelpNotification("Estas en la zona bancaria")
                inBank = true
            end
        end

        Wait(msec)
    end
end)

RegisterCommand('inbank', function()
    if inBank then
        ShowNotification("Estas en zona bancaria")
    else
        ShowNotification("No estas en zona bancaria")
    end
end)

RegisterCommand("transferir", function(source, args, rawCommand)
    local xTarget = args[1]
    local quantity = args[2]

    if inBank then
        TriggerServerEvent('fxbanking:transfer', xTarget, quantity)
    else
        ShowNotification("No estas en la zona bancaria")
    end

end)

RegisterCommand("sacardinero", function(source, args, rawCommand)
    local quantity = args[1]

    if inBank then
        TriggerServerEvent('fxbanking:getMoney', quantity)
    else
        ShowNotification("No estas en la zona bancaria")
    end

end)

RegisterCommand("ingresardinero", function(source, args, rawCommand)
    local quantity = args[1]

    if inBank then
        TriggerServerEvent('fxbanking:giveMoney', quantity)
    else
        ShowNotification("No estas en la zona bancaria")
    end

end)