Lang = {}

Lang.Fail = {
    tooFar = '%s Estaba demasiado lejos para activar %s',
}

Lang.Vendor = {
    targetLabel = 'Comprar mochila',
    targetIcon = 'fas fa-shopping-bag',
    price = '$ %s',
    inputTitle = 'Comprar mochila',
    inputDesc = 'Tipo de pago',
    inputOption1 = 'Efectivo',
    inputOption2 = 'Banco',
    menuTitle = 'Comprar mochilas',
}

Lang.Interact = {
    targetLabel = 'Abrir Stash',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Introduce la contraseña',
    inputDesc = 'Introduce la contraseña',
    inputHeader = 'Contraseña',
    drawTextobj = '[E] Colocar  \n  [SUPR] Cancelar  \n  [<-] Izquierda  \n  [->] Derecha',
    drawTextCoords = 'Coordenadas Raycast:  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] copiar  \n[SUPR] cancelar',
}
Lang.Notify = {
    wrongPass = 'Introdujiste la contraseña incorrecta',
    noAccess = 'No tienes acceso a esta Stash'
}

Lang.giveBag = {
    help = 'Dar una mochila a un jugador',
    invalidPlayer = 'ID de jugador no válido',
    invalidItem = 'Objeto de mochila no válido',
    noAccess = 'No tienes permiso para usar este comando',
    given = 'Has dado a %s un %s',
    received = 'Has recibido un %s de %s',
    pid = 'ID de jugador',
    pidHelp = 'ID del jugador objetivo',
    item = 'Nombre del objeto',
    itemHelp = 'Nombre del objeto de la mochila'
}

Lang.Ui = {
    edit = {
        header = 'Editar Stash',
        id = "ID",
        obj = "Objeto",
        coords = "Coordenadas",
        del = "Eliminar",
        changeLoc = "Cambiar ubicación",
        edit = "Editar datos",
        go2 = 'Ir a'
    },
    create = {
        header = 'Configuración de Stash',
        name = "Nombre de Stash",
        job = "Trabajos",
        jobRank = "Rango mínimo de trabajo",
        gang = "Bandas",
        gangRank = "Rango mínimo de banda",
        item = "Objetos",
        identifier = "Identificadores",
        weight = "Peso",
        slots = "Espacios",
        password = "Contraseña",
        reset = "Reiniciar",
        submit = "Enviar"
    },
    select = {
        header = 'Elegir tipo',
        option1head = 'Selecciona una opción',
        option1coords = 'Coordenadas',
        option1object = 'Objeto',
        objHead = 'Elige un objeto:',
        objDesc = 'Selecciona un objeto para colocar',
        cancel = 'Cancelar',
        submit = 'Enviar'
    }
}
return Lang