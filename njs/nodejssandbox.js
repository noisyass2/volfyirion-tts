var fs = require('fs')
var LINQ = require('node-linq').LINQ;


function check()
{
    var metaJson = fs.readFileSync("csvjson.json");
    var metadata = JSON.parse(metaJson);

    var deckJson = fs.readFileSync("VolfyDeckWithName.json");
    
    var deck = JSON.parse(deckJson.toString());
    var cards = deck.ObjectStates[0];


    cards.ContainedObjects.forEach(card => {
        var meta = new LINQ(metadata)
        .Where(function(c) { return c.Name + '\r\n' === card.Nickname || c.Name === card.Nickname;  })
        .First();

        if(meta)
        {
            card.Description = JSON.stringify(meta);
            
        }
        else{
            console.log("NOT FOUND : " + card.Nickname);
            // console.log(card);
        }
    });

    fs.writeFileSync("DeckWithMeta.json",JSON.stringify(deck));
    console.log("DONE");
    //console.log(arr);
}


check();