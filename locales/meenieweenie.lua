Lang = {}

Lang.Fail = {
    tooFar = 'Wow, %s — too incompetent to even reach %s? Pathetic.',
}

Lang.Interact = {
    targetLabel = 'Open the damn stash, idiot.',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Type the password. Don’t mess it up.',
    inputDesc = 'If you fail this, I’m revoking your keyboard privileges.',
    inputHeader = 'Password (you better not forget it)',
    drawTextobj = '[E] Place it (don’t screw up)  \n  [DEL] Give up? Typical.  \n  [<-] Move left (use your brain)  \n  [->] Move right (not that hard)',
    drawTextCoords = 'Coordinates (you probably can’t read these):  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] Copy (because you’ll forget)  \n[DEL] Quit (expected)',
}
Lang.Notify = {
    wrongPass = 'Wrong password. Are you even trying?',
    noAccess = 'Access denied. Shocking — you don’t belong here.'
}

Lang.giveBag = {
    help = 'Hand over a stupid backpack to some idiot',
    invalidPlayer = 'Wow, nice job, invalid player ID',
    invalidItem = 'That’s not even a backpack, genius',
    noAccess = 'You don’t have permission, deal with it',
    given = 'Congrats, you wasted a %s on %s',
    received = 'Lucky you, got a crappy %s from %s',
    pid = 'Player ID (duh)',
    pidHelp = 'Target Player ID, figure it out',
    item = 'Item Name (obviously)',
    itemHelp = 'Name of the dumb backpack item'
}

Lang.Ui = {
    edit = {
        header = 'Fix your garbage stash',
        id = "ID (don’t lose it)",
        obj = "Object (try not to break it)",
        coords = "Coords (write them down, genius)",
        del = "Delete (finally, something you’re good at)",
        changeLoc = "Move it (because your first choice sucked)",
        edit = "Edit data (don’t corrupt it)",
        go2 = 'Go to (if you can find it)'
    },
    create = {
        header = 'Configure your sad little stash',
        name = "Name it something less embarrassing",
        job = "Jobs (if you even have one)",
        jobRank = "Min rank (you probably don’t qualify)",
        gang = "Gangs (loser club)",
        gangRank = "Min gang rank (good luck)",
        item = "Items (don’t hoard junk)",
        identifier = "IDs (don’t share them, dummy)",
        weight = "Weight (don’t overload it)",
        slots = "Slots (you’ll fill them with trash)",
        password = "Password (make it strong, unlike you)",
        reset = "Reset (you’ll need to)",
        submit = "Submit (pray it works)"
    },
    select = {
        header = 'Pick something. Anything.',
        option1head = 'Just choose. Stop wasting time.',
        option1coords = 'Coords (you’ll get lost anyway)',
        option1object = 'Object (don’t break it)',
        objHead = 'Pick an object:',
        objDesc = 'Select something. Don’t overthink it.',
        cancel = 'Cancel (giving up already?)',
        submit = 'Submit (do it right this time)'
    }
}
Lang.Vendor = {
    targetLabel = 'Buy your dumb backpack',
    targetIcon = 'fas fa-shopping-bag',
    price = 'It’ll cost ya $ %s, loser',
    inputTitle = 'Backpack ripoff',
    inputDesc = 'Pick your pathetic payment',
    inputOption1 = 'Cash, if you’re broke',
    inputOption2 = 'Bank, if you even have one',
    menuTitle = 'Overpriced backpacks',
}
return Lang