
function onload()
    self.createButton({
        click_function="clickdiscard", function_owner=self,
        position={0,0.1,0}, height=1000, width=3000, color={1,1,1,0}
    })
    playzone = 'b58a77'
    discardzone = {15.805,4.583,-9.860}
end

function clickdiscard()
    -- get zone
    zone = getObjectFromGUID(playzone)
    zoneObjects = zone.getObjects()

    for _, obj in ipairs(zoneObjects) do
        if obj.name == "Deck" or obj.name == "Card" then
            obj.setPositionSmooth(discardzone, false, true)

        end
    end
end