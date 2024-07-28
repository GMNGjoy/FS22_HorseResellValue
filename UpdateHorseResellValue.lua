HorseResellValue = {}
local modDir = g_currentModDirectory

local newBuyPrices = {}
table.insert(newBuyPrices, 0, 450)
table.insert(newBuyPrices, 36, 10000)
table.insert(newBuyPrices, 60, 15000)

local newSellPrices = {}
table.insert(newSellPrices, 0, 500)
table.insert(newSellPrices, 36, 50000)
table.insert(newSellPrices, 60, 40000)

--- Register custom fillTypes.
function HorseResellValue:loadAnimals()
    if self.isServer then
        for _, subTypeIndex in ipairs(g_currentMission.animalSystem.nameToType['HORSE'].subTypes) do
            local subType = g_currentMission.animalSystem.subTypes[subTypeIndex]

            for _2, buyPrice in ipairs(subType.buyPrice.keyframes) do
                local time = buyPrice.time
                buyPrice[1] = newBuyPrices[time]
                printf('-- HorseResellValue: %s buyPrice for time:%s set to:%s', subType.name, time, newBuyPrices[time])
            end

            for _3, sellPrice in ipairs(subType.sellPrice.keyframes) do
                local time = sellPrice.time
                sellPrice[1] = newSellPrices[time]
                printf('-- HorseResellValue: %s sellPrice for time:%s set to:%s', subType.name, time, newSellPrices[time])
            end
        end
    end
end

AnimalSystem.loadAnimals = Utils.appendedFunction(AnimalSystem.loadAnimals, HorseResellValue.loadAnimals)