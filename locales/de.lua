Lang = {}

Lang.Fail = {
    tooFar = '%s war zu weit entfernt, um %s auszulösen',
}

Lang.Interact = {
    targetLabel = 'Stash öffnen',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Passwort eingeben',
    inputDesc = 'Geben Sie das Passwort ein',
    inputHeader = 'Passwort',
    drawTextobj = '[E] Platzieren  \n  [ENTF] Abbrechen  \n  [<-] Nach links  \n  [->] Nach rechts',
    drawTextCoords = 'Raycast-Koordinaten:  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] kopieren  \n[ENTF] abbrechen',
}
Lang.Notify = {
    wrongPass = 'Falsches Passwort eingegeben',
    noAccess = 'Sie haben keinen Zugriff auf diesen Stash'
}

Lang.giveBag = {
    help = 'Einem Spieler einen Rucksack geben',
    invalidPlayer = 'Ungültige Spieler-ID',
    invalidItem = 'Ungültiger Rucksack-Artikel',
    noAccess = 'Du hast keine Berechtigung für diesen Befehl',
    given = 'Du hast %s einen %s gegeben',
    received = 'Du hast einen %s von %s erhalten',
    pid = 'Spieler-ID',
    pidHelp = 'Ziel-Spieler-ID',
    item = 'Artikelname',
    itemHelp = 'Name des Rucksack-Artikels'
}


Lang.Ui = {
    edit = {
        header = 'Stash bearbeiten',
        id = "ID",
        obj = "Objekt",
        coords = "Koordinaten",
        del = "Löschen",
        changeLoc = "Standort ändern",
        edit = "Daten bearbeiten",
        go2 = 'Gehe zu'
    },
    create = {
        header = 'Stash-Konfiguration',
        name = "Stash-Name",
        job = "Jobs",
        jobRank = "Mindest-Job-Rang",
        gang = "Gangs",
        gangRank = "Mindest-Gang-Rang",
        item = "Gegenstände",
        identifier = "Kennungen",
        weight = "Gewicht",
        slots = "Slots",
        password = "Passwort",
        reset = "Zurücksetzen",
        submit = "Absenden"
    },
    select = {
        header = 'Typ auswählen',
        option1head = 'Option wählen',
        option1coords = 'Koordinaten',
        option1object = 'Objekt',
        objHead = 'Objekt auswählen:',
        objDesc = 'Wählen Sie ein Objekt zum Platzieren',
        cancel = 'Abbrechen',
        submit = 'Absenden'
    }
}
Lang.Vendor = {
    targetLabel = 'Rucksack kaufen',
    targetIcon = 'fas fa-shopping-bag',
    price = '$ %s',
    inputTitle = 'Rucksack kaufen',
    inputDesc = 'Zahlungsart',
    inputOption1 = 'Bargeld',
    inputOption2 = 'Bank',
    menuTitle = 'Rucksäcke kaufen',
}
return Lang