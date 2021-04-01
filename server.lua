ESX = nil
local yemek = 0
local kasaparasi = 0
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('dolap:esya:al')
AddEventHandler('dolap:esya:al', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('sosis', 1)
    xPlayer.addInventoryItem('sosisekmek', 1)
end)

RegisterNetEvent('sosis:pisir')
AddEventHandler('sosis:pisir', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ekmek = xPlayer.getInventoryItem('sosisekmek').count
     local sosis = xPlayer.getInventoryItem('sosis')
     if sosis.count >= 1 then
         if ekmek >= 1 then
             TriggerClientEvent('sosis:pisir', source)
             xPlayer.removeInventoryItem('sosis', 1)
             xPlayer.addInventoryItem('pismissosis', 1)  
         else
            TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Ekmek yok dolaptan ekmek al!'})
 
         end
     else
        TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Sosin yok dolaptan sosis al!'})
 
     end
end)

RegisterNetEvent('sosis:birlestir')
AddEventHandler('sosis:birlestir', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ekmek = xPlayer.getInventoryItem('sosisekmek').count
     local sosis = xPlayer.getInventoryItem('pismissosis')
     if sosis.count >= 1 then
         if ekmek >= 1 then
             TriggerClientEvent('sosisli:birlestir', source)
             xPlayer.removeInventoryItem('pismissosis', 1)
             xPlayer.removeInventoryItem('sosisekmek', 1)
             xPlayer.addInventoryItem('hotdog', 1)  
         else
            TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Ekmek yok dolaptan ekmek al!'})
            TriggerClientEvent('lanet:motel:npc', source)
         end
     else
        TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Pişmiş Sosise ihtiyacın var!'})
     end
end)

RegisterNetEvent('sosis:paketle')
AddEventHandler('sosis:paketle', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local paket = xPlayer.getInventoryItem('hotdog').count
         if paket >= 1 then
             TriggerClientEvent('sosisli:paketledin', source)
             xPlayer.removeInventoryItem('hotdog', 1)
             xPlayer.addInventoryItem('paketsosisli', 1)  
         else
            TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Sosislin olmadan paketleyemezsin!'})
 
         end
end)

RegisterNetEvent('kola:ver')
AddEventHandler('kola:ver', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local para = xPlayer.getInventoryItem('cash').count
    if para >= Config.KolaPrice then
    xPlayer.removeInventoryItem('cash', Config.KolaPrice)
    xPlayer.addInventoryItem('cocacola', 1)
else
    TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Paran yok ve biz beleşe içirmiyoruz!'})
 end
end)

RegisterNetEvent('sprite:ver')
AddEventHandler('sprite:ver', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local para = xPlayer.getInventoryItem('cash').count
    if para >= Config.SpritePrice then
    xPlayer.removeInventoryItem('cash', Config.SpritePrice)
    xPlayer.addInventoryItem('sprite', 1)
else
    TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Paran yok ve biz beleşe içirmiyoruz!'})
 end
end)

RegisterNetEvent('hardal:koy')
AddEventHandler('hardal:koy', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local hardalekle = xPlayer.getInventoryItem('hotdog').count
    if hardalekle >= 1 then
    xPlayer.removeInventoryItem('hotdog', 1)
    xPlayer.addInventoryItem('hardalsosis', 1)
else
    TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Sosis olmadan ağzına mı sıkacaksın!'})
 end
end)

RegisterNetEvent('ketcap:koy')
AddEventHandler('ketcap:koy', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ketcapekle = xPlayer.getInventoryItem('hotdog').count
    if ketcapekle >= 1 then
    xPlayer.removeInventoryItem('hotdog', 1)
    xPlayer.addInventoryItem('ketcapsosis', 1)
else
    TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Sosis olmadan ağzına mı sıkacaksın!'})
 end
end)

RegisterNetEvent('sosisli:satin:al')
AddEventHandler('sosisli:satin:al', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local yemekparasi = xPlayer.getInventoryItem('cash').count
    if yemek > 0 then
        
        if yemekparasi >= Config.YemekPrice then
        xPlayer.removeInventoryItem('cash', Config.YemekPrice)
        xPlayer.addInventoryItem('hotdog', 1)  
        yemek = yemek - 1
        kasaparasi = kasaparasi + Config.YemekPrice
        else
            TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Paran yok!'})
        end
    else
        TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Yeterli stok yok!'})
    end
end)

RegisterNetEvent('para:al')
AddEventHandler('para:al', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('cash', kasaparasi) 
    kasaparasi = kasaparasi - kasaparasi
end)
RegisterNetEvent('para:bak')
AddEventHandler('para:bak', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Kasadaki para '..kasaparasi..'$'})
     
end)

RegisterNetEvent('stok:ekle')
AddEventHandler('stok:ekle', function(servergit)
    local xPlayer = ESX.GetPlayerFromId(source)
    local stokekleme = xPlayer.getInventoryItem('hotdog').count
    if stokekleme > 0 then 
        xPlayer.removeInventoryItem('hotdog', servergit)  
        yemek = yemek + servergit
        TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Stok sayısı : '..yemek..' '})
       
        else
            TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Sosisin yok Stoğa ekleyemezsin!'})
        end
end)

RegisterNetEvent('stok:goster')
AddEventHandler('stok:goster', function()
    TriggerClientEvent('skavronskyynotify:client:SendAlert', source, {type = 'error', text = 'Stok sayısı : '..yemek..' '})
end)

RegisterNetEvent('soda:ver')
AddEventHandler('soda:ver', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('cash', Config.SodaPrice)
    xPlayer.addInventoryItem('soda', 1)
end)

ESX.RegisterUsableItem('ketcap', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('weed_pooch', 1)

end)

ESX.RegisterUsableItem('hardal', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('weed_pooch', 1)

end)

--Foods / esx_basicneeds
ESX.RegisterUsableItem('hotdog', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hotdog', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEatSteak', source)
end)

ESX.RegisterUsableItem('ketcapsosis', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('ketcapsosis', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEatSteak', source)
end)

ESX.RegisterUsableItem('hardalsosis', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hardalsosis', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEatSteak', source)
end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprite', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onEatSteak', source)
end)

ESX.RegisterUsableItem('paketsosisli', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('paketsosisli', 1)
    xPlayer.addInventoryItem('hotdog', 1)

end)