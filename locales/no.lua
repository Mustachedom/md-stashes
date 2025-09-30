Lang = {}

Lang.Fail = {
    tooFar = '%s Var For Langt Unna Til Å Aktivere %s',
}

Lang.Interact = {
    targetLabel = 'Åpne Stash',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Skriv Inn Passord',
    inputDesc = 'Skriv Inn Passordet',
    inputHeader = 'Passord',
    drawTextobj = '[E] For Å Plassere  \n  [DEL] For Å Avbryte  \n  [<-] For Å Flytte Venstre  \n  [->] For Å Flytte Høyre',
    drawTextCoords = 'Raycast Koordinater:  \n X:  %s,  \n Y:  %s,  \n Z:  %s  \n[E] for å kopiere  \n[DEL] for å avbryte',
}
Lang.Notify = {
    wrongPass = 'Du Skriv Inn Feil Passord',
    noAccess = 'Du Har Ikke Tilgang Til Denne Stashen'
}

Lang.Ui = {
    edit = {
        header = 'Rediger Stash',
        id = "ID",
        obj = "Objekt",
        coords = "Koordinater",
        del = "Slett",
        changeLoc = "Endre Lokasjon",
        edit = "Rediger Data",
        go2 = 'Gå Til'
    },
    create = {
        header = 'Stash Konfigurasjon',
        name = "Stash Navn",
        job = "Jobber",
        jobRank = "Minimum Jobb Rang",
        gang = "Gjenger",
        gangRank = "Minimum Gjeng Rang",
        item = "Gjenstander",
        identifier = "Identifikatorer",
        weight = "Vekt",
        slots = "Slots",
        password = "Passord",
        reset = "Tilbakestill",
        submit = "Bekreft"
    },
    select = {
        header = 'Velg Type',
        option1head = 'Velg Et Alternativ',
        option1coords = 'Koordinater',
        option1object = 'Objekt',
        objHead = 'Velg Objekt:',
        objDesc = 'Velg Et Objekt Å Plassere',
        cancel = 'Avbryt',
        submit = 'Bekreft'
    }
}

Lang.Vendor = {
    targetLabel = 'Kjøp Ryggsekk',
    targetIcon = 'fas fa-shopping-bag',
    price = '$ %s',
    inputTitle = 'Kjøp Ryggsekk',
    inputDesc = 'Betalingsmetode',
    inputOption1 = 'Kontant',
    inputOption2 = 'Bank',
    menuTitle = 'Kjøp Ryggsekker',
}

Lang.giveBag = {
    help = 'Gi en ryggsekk til en spiller',
    invalidPlayer = 'Ugyldig Spiller ID',
    invalidItem = 'Ugyldig Ryggsekk Item',
    noAccess = 'Du Har Ikke Tilgang Til Denne Kommandoen',
    given = 'Du Har Gitt %s en %s',
    received = 'Du Har Mottatt en %s Fra %s',
    pid = 'Spiller ID',
    pidHelp = 'Mål Spiller ID',
    item = 'Item Navn',
    itemHelp = 'Ryggsekk Item Navn'
}
return Lang
