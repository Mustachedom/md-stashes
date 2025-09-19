Lang = {}

Lang.Fail = {
    tooFar = '%s Was Too Far To Trigger %s',
}

Lang.Interact = {
    targetLabel = 'Open Stash',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Enter Password',
    inputDesc = 'Enter The Password',
    inputHeader = 'Password',
    drawTextobj = '[E] To Place  \n  [DEL] To Cancel  \n  [<-] To Move Left  \n  [->] To Move Right',
    drawTextCoords = 'Raycast Coords:  \n X:  %s,  \n Y:  %s,  \n Z:  %s  \n[E] to copy  \n[DEL] to cancel',
}
Lang.Notify = {
    wrongPass = 'You Put In The Wrong Password',
    noAccess = 'You Do Not Have Access To This Stash'
}

Lang.Ui = {
    edit = {
        header = 'Edit Stash',
        id = "ID",
        obj = "Object",
        coords = "Coords",
        del = "Delete",
        changeLoc = "Change Location",
        edit = "Edit Data",
        go2 = 'Go To'
    },
    create = {
        header = 'Stash Configuration',
        name = "Stash Name",
        job = "Jobs",
        jobRank = "Minimum Job Rank",
        gang = "Gangs",
        gangRank = "Minimum Gang Rank",
        item = "Items",
        identifier = "Identifiers",
        weight = "Weight",
        slots = "Slots",
        password = "Password",
        reset = "Reset",
        submit = "Submit"
    },
    select = {
        header = 'Choose Type',
        option1head = 'Select An Option',
        option1coords = 'Coordinates',
        option1object = 'Object',
        objHead = 'Choose Object:',
        objDesc = 'Select An Object To Place',
        cancel = 'Cancel',
        submit = 'Submit'  
    }
}
return Lang