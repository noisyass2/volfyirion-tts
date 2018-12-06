
function onload()
    assetSpread = getObjectFromGUID('7e4572')

    assetSpread.call('shuffleDeck')
    assetSpread.call("clickrefillassets")
    shuffleWonders()
    refillWonders()

    --findPosition('d3ae38')
end

function onPlayerEndTurn()
    assetSpread = getObjectFromGUID('7e4572')
   

    assetSpread.call("clickrefillassets")

    -- trash cards


    refillWonders()

    
    increaseBP('10a63e',8)

end

function trashCards()
    trashZone = getObjectFromGUID('bb2afe')
    trashObjects = trashZone.getObjects()

    for _,obj in ipairs(trashObjects) do
        print(obj)        
    end
end

function shuffleWonders()
    assetdeck = findObjectsAtPosition( { -15.291,2.462, 12.309})

    if(#assetdeck > 0) then
        for _, obj in ipairs(assetdeck) do
    --print(assetdeck)
         obj.shuffle()
        end
    end


end

function refillWonders()

    slots = {
        {-11.293, 2.523, 8.07},
        {-11.293, 2.521, 10.525}
    }

    for _, obj in ipairs(slots) do
        card = findObjectsAtPosition(obj)
        if(card == nil or #card == 0 ) then
            dealoneto(obj)
        end
    end
end


function findObjectsAtPosition(localPos)
    --We convert that local position to a global table position
    local globalPos = self.positionToWorld(localPos)
    --We then do a raycast of a sphere on that position to find objects there
    --It returns a list of hits which includes references to what it hit
    local objList = Physics.cast({
        origin=globalPos, --Where the cast takes place
        direction={0,1,0}, --Which direction it moves (up is shown)
        type=2, --Type. 2 is "sphere"
        size={0.5,0.5,0.5}, --How large that sphere is
        max_distance=1, --How far it moves. Just a little bit
        debug=false --If it displays the sphere when casting.
    })

    --Now we have objList which contains any and all objects in that area.
    --But we only want decks and cards. So we will create a new list
    local decksAndCards = {}
    --Then go through objList adding any decks/cards to our new list
    -- print(objList)
    -- print(#objList)
    for _, obj in ipairs(objList) do
        if obj.hit_object.tag == "Deck" or obj.hit_object.tag == "Card" then
            table.insert(decksAndCards, obj.hit_object)
        end
    end

    --Now we return this to where it was called with the information
    return decksAndCards
end

function dealoneto(targetpos)
   
    assetdeck = findObjectsAtPosition( { -15.290,2.306, 12.308})

    if(#assetdeck > 0) then
        for _, obj in ipairs(assetdeck) do

            if obj.name == "Deck" then

                obj.takeObject({position = self.positionToWorld(targetpos), flip=true})
                return
            elseif obj.name == "Card" then

                obj.flip()
                obj.setPositionSmooth(self.positionToWorld(targetpos))
                return
            end

        end
   
    end
end


function findPosition(guid)
    local pos = self.positionToLocal(getObjectFromGUID(guid).getPosition())
    print(pos.x)
    print(pos.y)
    print(pos.z)
end


function increaseBP(guid,num)
    local token = getObjectFromGUID(guid)
    token.call("increasecustom",num);
end
