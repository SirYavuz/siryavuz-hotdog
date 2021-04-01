ESX                           = nil
--local PlayerData = {}
local gorev = false
local dolap = true
local pisir = false
local birlestir = false
local paketle = false

local spawnfaggio = { x = 42.89, y = -1015.04, z = 29.5 }


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterCommand('sosis', function()
    if PlayerData.job.name == 'sosisci' then
    if not gorev then
        ESX.ShowNotification('Goreve girdin')
        gorev = true
    else
        gorev = false
        ESX.ShowNotification('Gorevden Çıktın')
    end
else
    ESX.ShowNotification('Sosisci mesleğinde olmak zorundasın')
end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
      
        if icecekMarker() then
            if IsControlJustPressed(1, 38) then
            icecekMenu()
            end
        end
        if kasaMarker() then
            if IsControlJustPressed(1, 38) then
                yemekMenu()
            end
        end
        if sosMarker() then
            if IsControlJustPressed(1, 38) then
            sosMenu()
            end
        end
        if not gorev then
            --gorevde değilken mesleği yapamaz. NOT: Buraya bildirim vs  girmeye çalışırsanız saniyede bir verir bilerek boş bıraktım.
        else
            if patronMarker() then
                if IsControlJustPressed(1, 38) then
                        kasaMenusu()
                else

                end      
            end
        if not dolap then
        
        else
         if dolapMarker() then
             if IsControlJustPressed(1, 38) then
                   dolapfun()
                   dolap = false
              end
            end
        end

        if not birlestir then

        else
        if birlestirMarker() then
            if IsControlJustPressed(1, 38) then
                sakinolchamp()
                birlestirfun()
             end
        end
    end
    if not pisir then
    
    else
        if pisirMarker() then
            if IsControlJustPressed(1, 38) then
                pisirfun()
             end
        end
    end
    if not paketle then
    
    else
        if paketMarker() then
            if IsControlJustPressed(1, 38) then
                paketlefun()
             end
        end
    end
        
        
    end
-- else
--     ESX.ShowNotification('Sosisci mesleğinde olmak zorundasın')
-- end

end
 end)

 function dolapfun()
    startAnim("mini@repair", "fixing_a_ped")
    exports['progressBars']:startUI(Config.DolapAnimTime, "Eşyalar alınıyor")
    Citizen.Wait(Config.DolapAnimTime)
    ClearPedTasks(GetPlayerPed(-1))
    ESX.ShowNotification('Hot Dog yapmak için gerekli malzemeleri dolaptan aldın.')
    TriggerServerEvent('dolap:esya:al')
    pisir = true
 end

 function birlestirfun()
    TriggerServerEvent('sosis:birlestir')

 end

 function pisirfun()
    TriggerServerEvent('sosis:pisir')
end


RegisterNetEvent('sosis:pisir')
AddEventHandler('sosis:pisir', function()
    exports['progressBars']:startUI(Config.PisirmeSuresi, "Pisiriyorsun")
    local ped = GetPlayerPed(-1)
    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    SpatelObject = CreateObject(GetHashKey("prop_fish_slice_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(SpatelObject, ped, GetPedBoneIndex(ped, 57005), 0.08, 0.0, -0.02, 0.0, -25.0, 130.0, true, true, false, true, 1, true)
    Citizen.Wait(Config.PisirmeSuresi)
    DetachEntity(SpatelObject)
    DeleteEntity(SpatelObject)
    ClearPedTasksImmediately(ped)
    
    pisir = false
    birlestir = true
    dolap = true
end)

RegisterNetEvent('sosisli:birlestir')
AddEventHandler('sosisli:birlestir', function()
    sakinolchamp()
    TriggerEvent('bicak:al')
    Citizen.Wait(500)
    sakinolchamp()
    startAnim("mp_fbi_heist", "loop")
    exports['progressBars']:startUI(2000, "Eşyaları masaya koyuyorsun")
    Citizen.Wait(3000)
    sakinolchamp()
    startAnim("mp_fbi_heist", "loop")
     exports['progressBars']:startUI(2000, "Ekmeği hazırlıyorsun")
     Citizen.Wait(3000)
     sakinolchamp()
     startAnim("mp_fbi_heist", "loop")
     exports['progressBars']:startUI(2000, "Sosisi koyuyorsun")
     Citizen.Wait(2000)
     sakinolchamp()
     TriggerEvent('bicak:ver')
     ClearPedTasks(GetPlayerPed(-1))
     birlestir = false
     paketle = true
end)

RegisterNetEvent('sosisli:paketledin')
AddEventHandler('sosisli:paketledin', function()
    exports['progressBars']:startUI(Config.PaketlemeSuresi, "Paketliyorsun")
    startAnim("creatures@rottweiler@tricks@", "petting_franklin")
  
    paketle = false
    gorev = false
    
end)

 function paketlefun()
    TriggerServerEvent('sosis:paketle')
end

RegisterNetEvent('bicak:al')
AddEventHandler('bicak:al', function()
    local player = PlayerPedId()
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        GiveWeaponToPed(player, 0x99B507EA, 1, false, true);
    end
end)

RegisterNetEvent('bicak:ver')
AddEventHandler('bicak:ver', function()
    local player = PlayerPedId()
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        RemoveWeaponFromPed(player, 0x99B507EA)
    end
end)


RegisterCommand('bicaksil', function()
    TriggerEvent('bicak:ver')
end)

 --Markers
function dolapMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Dolap) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(43.78, -1008.33, 29.29, Config.DolaptanEsyaAl)
			return true
    end
  end
end

function birlestirMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Birlestir) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(44.09, -1006.48, 29.29, Config.EsyalariBirlestir)
			return true
    end
  end
end

function pisirMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Pisir) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(42.5, -1007.74, 29.29, Config.SosisPisir)
			return true
    end

  end
end

function paketMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Paketleme) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(41.8, -1005.6, 29.29, Config.Paketle)
			return true
    end

  end
end

function icecekMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Icecek) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(45.85, -1009.51, 29.29, Config.IcecekAl)
			return true
    end

  end
end


function sosMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Soslar) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(45.79, -1007.12, 29.29, Config.SosAl)
			return true
    end

  end
end

function kasaMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Kasa) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
    if not gorev then
    if distance <= Config.KasaMarkerDistance then

        DrawMarker(Config.Type, 44.11, -1004.43, 29.10, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
		
            return true
            
    end
end
     end
end

function patronMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Patron) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
   
    if distance <= Config.MarkerDisctances then

        DrawMarker(Config.Type, 43.53, -1005.57, 29.10, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
		
            return true
            
    end
end

end



--gerekli function lar
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end 

function sakinolchamp()
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(0, 32, true) -- W
    DisableControlAction(0, 34, true) -- A
    DisableControlAction(0, 31, true) -- S
    DisableControlAction(0, 30, true) -- D

    DisableControlAction(0, 45, true) -- Reload
    DisableControlAction(0, 22, true) -- Jump
    DisableControlAction(0, 44, true) -- Cover
    DisableControlAction(0, 37, true) -- Select Weapon
    DisableControlAction(0, 23, true) -- Also 'enter'?
 end

--Animations
function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
   end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 5000, 0, 0, false, false, false)
	end)
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end

function icecekMenu()
    Citizen.Wait(120)

    local _elements = {
        {label = ('Kola Satın Al ' ..Config.KolaPrice..'$'), value = 'Kola'},
        {label = ('Sprite Satın Al ' ..Config.SpritePrice..'$'), value = 'Sprite'},

    }

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'busjobdutymenu',
        {
            title = ('İçecek Menusu'),
            align = 'top-left',
            elements = _elements
        },

        function(data, menu)
            if data.current.value == 'Kola' then
                TriggerServerEvent('kola:ver')
            elseif data.current.value == 'Sprite' then
                TriggerServerEvent('sprite:ver')
            end

            menu.close()
        end,

        function(data, menu)
            menu.close()
        end
    )
end

function sosMenu()
    Citizen.Wait(120)

    local _elements = {
        {label = ('Ketçap Al'), value = 'ketcapgetir'},
        {label = ('Hardal  Al'), value = 'hardalgetir'},
    }

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'sosmenu',
        {
            title = ('Sos Menusu'),
            align = 'top-left',
            elements = _elements
        },

        function(data, menu)
            if data.current.value == 'ketcapgetir' then
                TriggerServerEvent('ketcap:koy')
            elseif data.current.value == 'hardalgetir' then
                TriggerServerEvent('hardal:koy')
            end

            menu.close()
        end,

        function(data, menu)
            menu.close()
        end
    )
end


function yemekMenu()
    Citizen.Wait(120)

    local _elements = {
        {label = ('Sosisli Al '..Config.YemekPrice..' $'), value = 'sosislivarmi'},
      --  {label = ('Hardal  Al'), value = 'hardalgetir'},
    }

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'sosismenu',
        {
            title = ('Yemek Menusu'),
            align = 'top-left',
            elements = _elements
        },

        function(data, menu)
            if data.current.value == 'sosislivarmi' then
                TriggerServerEvent('sosisli:satin:al')
            end

            menu.close()
        end,

        function(data, menu)
            menu.close()
        end
    )
end

function kasaMenusu()
    Citizen.Wait(120)

    local _elements = {
        {label = ('Sosis Ekle'), value = 'stokekle'},
        {label = ('Stok Görüntüle'), value = 'stokbak'},
        {label = ('Kasadaki parayı kontrol et'), value = 'kasabak'},
        {label = ('Kasadaki parayı al'), value = 'kasaal'},
        {label = ('Motor Çıkart'), value = 'motorbak'},
    }

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'stokmenu',
        {
            title = ('Çalışan Menusu'),
            align = 'top-left',
            elements = _elements
        },

        function(data, menu)
            if data.current.value == 'stokekle' then
              --  TriggerServerEvent('stok:ekle')
              stoklar()
            elseif data.current.value == 'stokbak' then
                TriggerServerEvent('stok:goster')
            elseif data.current.value == 'kasabak' then
                TriggerServerEvent('para:bak')
            elseif data.current.value == 'kasaal' then
                TriggerServerEvent('para:al')
            elseif data.current.value == 'motorbak' then
                spawn_faggio()
                
            end

            menu.close()
        end,

        function(data, menu)
            menu.close()
        end
    )
end

function stoklar()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stoklar', {
		title = ('Stok Deneme'),
	}, function(data, menu)
        local sayi = string.len(data.value)
        local servergit = (data.value)
		if sayi  then
            TriggerServerEvent('stok:ekle', servergit)
            menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function spawn_faggio()
	Citizen.Wait(0)

	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('faggio2')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, spawnfaggio.x,spawnfaggio.y,spawnfaggio.z, 431.436, - 996.786, 25.1887, true, false)

	local plate = "CTZN"..math.random(100, 300)
    SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleLivery(spawned_car, 2)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end