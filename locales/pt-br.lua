Lang = {}

Lang.Fail = {
    tooFar = '%s Estava muito longe para ativar %s',
}
Lang.Vendor = {
    targetLabel = 'Comprar mochila',
    targetIcon = 'fas fa-shopping-bag',
    price = 'R$ %s',
    inputTitle = 'Comprar mochila',
    inputDesc = 'Forma de pagamento',
    inputOption1 = 'Dinheiro',
    inputOption2 = 'Banco',
    menuTitle = 'Comprar mochilas',
}

Lang.Interact = {
    targetLabel = 'Abrir Stash',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Digite a Senha',
    inputDesc = 'Digite a senha',
    inputHeader = 'Senha',
    drawTextobj = '[E] Colocar  \n  [DEL] Cancelar  \n  [<-] Esquerda  \n  [->] Direita',
    drawTextCoords = 'Coordenadas Raycast:  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] copiar  \n[DEL] cancelar',
}
Lang.Notify = {
    wrongPass = 'Você digitou a senha errada',
    noAccess = 'Você não tem acesso a este Stash'
}

Lang.giveBag = {
    help = 'Dar uma mochila a um jogador',
    invalidPlayer = 'ID de jogador inválido',
    invalidItem = 'Item de mochila inválido',
    noAccess = 'Você não tem permissão para usar este comando',
    given = 'Você deu um %s para %s',
    received = 'Você recebeu um %s de %s',
    pid = 'ID do jogador',
    pidHelp = 'ID do jogador alvo',
    item = 'Nome do item',
    itemHelp = 'Nome do item da mochila'
}


Lang.Ui = {
    edit = {
        header = 'Editar Stash',
        id = "ID",
        obj = "Objeto",
        coords = "Coordenadas",
        del = "Excluir",
        changeLoc = "Alterar Localização",
        edit = "Editar Dados",
        go2 = 'Ir Para'
    },
    create = {
        header = 'Configuração do Stash',
        name = "Nome do Stash",
        job = "Empregos",
        jobRank = "Rank Mínimo do Emprego",
        gang = "Gangues",
        gangRank = "Rank Mínimo da Gangue",
        item = "Itens",
        identifier = "Identificadores",
        weight = "Peso",
        slots = "Slots",
        password = "Senha",
        reset = "Redefinir",
        submit = "Enviar"
    },
    select = {
        header = 'Escolha o Tipo',
        option1head = 'Selecione uma Opção',
        option1coords = 'Coordenadas',
        option1object = 'Objeto',
        objHead = 'Escolha um Objeto:',
        objDesc = 'Selecione um objeto para colocar',
        cancel = 'Cancelar',
        submit = 'Enviar'
    }
}
return Lang