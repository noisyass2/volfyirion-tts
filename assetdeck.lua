function onload()
    self.createButton({
        click_function="clickrefillassets", function_owner=self,
        position={-2.554,0.171,-0.821}, height=300, width=820, color={1,1,1,0}
    })

    -- always shuffle deck
    shuffleDeck()
end

function shuffleDeck()
    assetdeck = getObjectFromGUID('48f9be')

    assetdeck.shuffle()
end

function clickrefillassets()
    slots = {
        {1.532,0.171,0.221},
        {0.440,0.171,0.221},
        {-0.654,0.171,0.221},
        {-1.74,0.171,0.221},
        {-2.833,0.171,0.221}
    }
    -- getcount(slots)
    -- print(getcount(slots))
    for _, obj in ipairs(slots) do
        card = findObjectsAtPosition(obj)
        if(card == nil or getcount(card) == 0 ) then
            dealoneto(obj)
        end
    end
end

function dealoneto(targetpos)

    assetdeck = findObjectsAtPosition({2.88,0.27,0.21})

    if(getcount(assetdeck) > 0) then
        for _, obj in ipairs(assetdeck) do

            obj.takeObject({position = self.positionToWorld(targetpos)})
         
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
        size={2,2,2}, --How large that sphere is
        max_distance=1, --How far it moves. Just a little bit
        debug=false --If it displays the sphere when casting.
    })

    --Now we have objList which contains any and all objects in that area.
    --But we only want decks and cards. So we will create a new list
    local decksAndCards = {}
    --Then go through objList adding any decks/cards to our new list
    for _, obj in ipairs(objList) do
        if obj.hit_object.tag == "Deck" or obj.hit_object.tag == "Card" then
            table.insert(decksAndCards, obj.hit_object)
        end
    end

    --Now we return this to where it was called with the information
    return decksAndCards
end

function getcount(tbl)
    tct = 0
    for _, obj in ipairs(tbl) do
        tct = tct + 1
        --print(obj)
    end

    return tct
end
-- position={1.532,0.171,0.221}
-- position={0.440,0.171,0.221}
-- position={-0.654,0.171,0.221}
-- position={-1.74,0.171,0.221}
-- position={-2.833,0.171,0.221}