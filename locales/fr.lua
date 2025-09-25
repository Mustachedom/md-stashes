Lang = {}

Lang.Fail = {
    tooFar = '%s Était trop loin pour déclencher %s',
}

Lang.Vendor = {
    targetLabel = 'Acheter un sac à dos',
    targetIcon = 'fas fa-shopping-bag',
    price = '$ %s',
    inputTitle = 'Acheter un sac à dos',
    inputDesc = 'Mode de paiement',
    inputOption1 = 'Espèces',
    inputOption2 = 'Banque',
    menuTitle = 'Acheter des sacs à dos',
}

Lang.Interact = {
    targetLabel = 'Ouvrir le Stash',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Entrez le mot de passe',
    inputDesc = 'Entrez le mot de passe',
    inputHeader = 'Mot de passe',
    drawTextobj = '[E] Placer  \n  [SUPPR] Annuler  \n  [<-] Gauche  \n  [->] Droite',
    drawTextCoords = 'Coordonnées Raycast :  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] copier  \n[SUPPR] annuler',
}
Lang.Notify = {
    wrongPass = 'Vous avez entré le mauvais mot de passe',
    noAccess = 'Vous n’avez pas accès à ce Stash'
}

Lang.giveBag = {
    help = 'Donner un sac à dos à un joueur',
    invalidPlayer = 'ID de joueur invalide',
    invalidItem = 'Article de sac à dos invalide',
    noAccess = 'Vous n’avez pas la permission d’utiliser cette commande',
    given = 'Vous avez donné un %s à %s',
    received = 'Vous avez reçu un %s de %s',
    pid = 'ID du joueur',
    pidHelp = 'ID du joueur ciblé',
    item = 'Nom de l’objet',
    itemHelp = 'Nom de l’objet du sac à dos'
}

Lang.Ui = {
    edit = {
        header = 'Modifier le Stash',
        id = "ID",
        obj = "Objet",
        coords = "Coordonnées",
        del = "Supprimer",
        changeLoc = "Changer l’emplacement",
        edit = "Modifier les données",
        go2 = 'Aller à'
    },
    create = {
        header = 'Configuration du Stash',
        name = "Nom du Stash",
        job = "Métiers",
        jobRank = "Rang minimum du métier",
        gang = "Gangs",
        gangRank = "Rang minimum du gang",
        item = "Objets",
        identifier = "Identifiants",
        weight = "Poids",
        slots = "Emplacements",
        password = "Mot de passe",
        reset = "Réinitialiser",
        submit = "Envoyer"
    },
    select = {
        header = 'Choisir le type',
        option1head = 'Choisissez une option',
        option1coords = 'Coordonnées',
        option1object = 'Objet',
        objHead = 'Choisissez un objet :',
        objDesc = 'Sélectionnez un objet à placer',
        cancel = 'Annuler',
        submit = 'Envoyer'
    }
}
return Lang