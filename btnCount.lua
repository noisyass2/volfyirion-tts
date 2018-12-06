
function onload()
    self.createButton({
        click_function="clickcount", function_owner=self,
        position={0,0.1,0}, height=1000, width=3000, color={1,1,1,0}
    })
    
    discardzone = {13.190,2.560,9.602}
end

function clickcount()
    local playzone = '9735ac' -- 'f0611d'
    CP = 'b6f970' --'10d5de'
    BP = 'a425b8' --'10a63e'
    KP = '9efa9f' --'0f289f'
    -- get zone
    zone = getObjectFromGUID(playzone)
    zoneObjects = zone.getObjects()
    resetCount(CP)
    resetCount(BP)
    resetCount(KP)
    
    for _, obj in ipairs(zoneObjects) do
        if  obj.name == "Card" and obj.getName() != 'City' then
            print(obj.getName())
            local desc = obj.getDescription()
            if(desc != nil) then
                    
                local meta = JSON.decode(obj.getDescription())
                increaseCount(CP, meta.CP)
                increaseCount(BP, meta.BP)
                increaseCount(KP, meta.KP)
            end
        end
    end
end

function increaseCount(guid,num)
    local token = getObjectFromGUID(guid)
    token.call("increasecustom",num);
end

function resetCount(guid)
    local token = getObjectFromGUID(guid)
    token.setDescription('0')
    token.call("customSet")
end