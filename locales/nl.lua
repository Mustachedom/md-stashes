Lang = {}

Lang.Fail = {
    tooFar = '%s Was te ver om %s te activeren',
}

Lang.Interact = {
    targetLabel = 'Stash Openen',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Voer Wachtwoord In',
    inputDesc = 'Voer het wachtwoord in',
    inputHeader = 'Wachtwoord',
    drawTextobj = '[E] Plaatsen  \n  [DEL] Annuleren  \n  [<-] Links  \n  [->] Rechts',
    drawTextCoords = 'Raycast Coördinaten:  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] kopiëren  \n[DEL] annuleren',
}
Lang.Notify = {
    wrongPass = 'Je hebt het verkeerde wachtwoord ingevoerd',
    noAccess = 'Je hebt geen toegang tot deze stash'
}

Lang.giveBag = {
    help = 'Geef een rugzak aan een speler',
    invalidPlayer = 'Ongeldig speler-ID',
    invalidItem = 'Ongeldig rugzak-item',
    noAccess = 'Je hebt geen toestemming om dit commando te gebruiken',
    given = 'Je hebt %s een %s gegeven',
    received = 'Je hebt een %s van %s ontvangen',
    pid = 'Speler-ID',
    pidHelp = 'Doel speler-ID',
    item = 'Itemnaam',
    itemHelp = 'Naam van rugzak-item'
}


Lang.Ui = {
    edit = {
        header = 'Stash Bewerken',
        id = "ID",
        obj = "Object",
        coords = "Coördinaten",
        del = "Verwijderen",
        changeLoc = "Locatie Wijzigen",
        edit = "Gegevens Bewerken",
        go2 = 'Ga Naar'
    },
    create = {
        header = 'Stash Configuratie',
        name = "Stash Naam",
        job = "Beroepen",
        jobRank = "Minimale Beroepsrang",
        gang = "Bendes",
        gangRank = "Minimale Bende Rang",
        item = "Items",
        identifier = "Identificatoren",
        weight = "Gewicht",
        slots = "Slots",
        password = "Wachtwoord",
        reset = "Resetten",
        submit = "Verzenden"
    },
    select = {
        header = 'Kies Type',
        option1head = 'Kies een Optie',
        option1coords = 'Coördinaten',
        option1object = 'Object',
        objHead = 'Kies Object:',
        objDesc = 'Selecteer een object om te plaatsen',
        cancel = 'Annuleren',
        submit = 'Verzenden'
    }
}
Lang.Vendor = {
    targetLabel = 'Koop rugzak',
    targetIcon = 'fas fa-shopping-bag',
    price = '$ %s',
    inputTitle = 'Koop rugzak',
    inputDesc = 'Betaalmethode',
    inputOption1 = 'Contant',
    inputOption2 = 'Bank',
    menuTitle = 'Rugzakken kopen',
}

return Lang