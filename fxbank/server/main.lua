FX = nil
TriggerEvent('fx:get', function(core) FX = core Wait(5000) print("FX Banking Inicializado") end)

RegisterNetEvent('fxbanking:transfer')
RegisterNetEvent('fxbanking:giveMoney')
RegisterNetEvent('fxbanking:getMoney')

AddEventHandler('fxbanking:transfer', function(player, count)
    local xPlayer = FX.GetPlayerById(source)
    local xTarget = FX.GetPlayerById(player)
    local quantity = count

    xPlayer:Bank().removeBank(quantity, "Has mandado una transferencia a la ID " ..player)
    xTarget:Bank().addBank(quantity, "Has recibido una transferencia")
end)

AddEventHandler('fxbanking:giveMoney', function(count)
    local xPlayer = FX.GetPlayerById(source)
    local quantity = count

    xPlayer:Cash().removeCash(quantity, "Has ingresado " ..quantity.. "€")
end)

AddEventHandler('fxbanking:getMoney', function(count)
    local xPlayer = FX.GetPlayerById(source)
    local quantity = count

    xPlayer:Cash().addCash(quantity, "Has sacado " ..quantity.. "€")
end)