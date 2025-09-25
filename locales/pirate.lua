Lang = {}

Lang.Fail = {
    tooFar = 'Arrr, %s be too far to trigger %s, ye scallywag!',
}
Lang.Vendor = {
    targetLabel = 'Plunder a backpack, arr!',
    targetIcon = 'fas fa-shopping-bag',
    price = '$ %s doubloons',
    inputTitle = 'Grab ye pack',
    inputDesc = 'What treasure ye be spendin’?',
    inputOption1 = 'Gold coins',
    inputOption2 = 'Yer bank chest',
    menuTitle = 'Backpacks fer sale, matey!',
}
Lang.Interact = {
    targetLabel = 'Open the Stash, matey!',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Enter the Password, or walk the plank!',
    inputDesc = 'Type the secret code, or feed the sharks!',
    inputHeader = 'Password (don’t ye be forgettin’ it!)',
    drawTextobj = '[E] Place it, ye dog!  \n  [DEL] Abandon ship!  \n  [<-] Port side!  \n  [->] Starboard!',
    drawTextCoords = 'Raycast Coords, savvy?  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] Copy it, ye landlubber!  \n[DEL] Scuttle the ship!',
}
Lang.Notify = {
    wrongPass = 'Wrong password, ye bilge rat!',
    noAccess = 'No access for the likes o’ you, ye scurvy dog!'
}

Lang.giveBag = {
    help = 'Give a matey a backpack, arrr!',
    invalidPlayer = 'That be no proper sailor ID!',
    invalidItem = 'That backpack item be cursed!',
    noAccess = 'Ye lack the captain’s permission!',
    given = 'Ye gave %s a fine %s!',
    received = 'Ye be handed a %s from %s!',
    pid = 'Matey ID',
    pidHelp = 'Target sailor ID',
    item = 'Item name',
    itemHelp = 'Backpack item name',
}

Lang.Ui = {
    edit = {
        header = 'Edit the Stash, ye salty dog!',
        id = "ID (mark it well!)",
        obj = "Object (don’t break it, or ye’ll pay!)",
        coords = "Coords (write ‘em in yer log!)",
        del = "Delete (send it to Davy Jones!)",
        changeLoc = "Move the stash (find better loot!)",
        edit = "Edit the data (don’t ye corrupt it!)",
        go2 = 'Sail to'
    },
    create = {
        header = 'Configure yer Stash, Captain!',
        name = "Stash Name (give it a fearsome title!)",
        job = "Crew Jobs (who’s worthy?)",
        jobRank = "Min Job Rank (no lubbers allowed!)",
        gang = "Crew Gangs (pick yer pirates!)",
        gangRank = "Min Gang Rank (prove yer worth!)",
        item = "Treasure (gold, jewels, and plunder!)",
        identifier = "Ship IDs (keep ‘em secret!)",
        weight = "Weight (don’t sink the ship!)",
        slots = "Hold Slots (fill ‘em with loot!)",
        password = "Password (guard it with yer life!)",
        reset = "Abandon Stash (coward!)",
        submit = "Set Sail! ⚓"
    },
    select = {
        header = 'Choose yer course, Captain!',
        option1head = 'Pick yer fate!',
        option1coords = 'Map Coords (X marks the spot!)',
        option1object = 'Treasure Object (choose wisely!)',
        objHead = 'Pick yer treasure:',
        objDesc = 'Select an object to place, ye scallywag!',
        cancel = 'Abandon ship!',
        submit = 'Commit to the voyage!'
    }
}
return Lang