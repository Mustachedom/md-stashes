Lang = {}

Lang.Fail = {
    tooFar = '%s, %s tetiklemek için çok uzaktaydı',
}
Lang.Vendor = {
    targetLabel = 'Sırt çantası satın al',
    targetIcon = 'fas fa-shopping-bag',
    price = '$ %s',
    inputTitle = 'Sırt çantası satın al',
    inputDesc = 'Ödeme türü',
    inputOption1 = 'Nakit',
    inputOption2 = 'Banka',
    menuTitle = 'Sırt çantaları satın al',
}

Lang.Interact = {
    targetLabel = 'Stash Aç',
    targetIcon = 'fas fa-box-open',
    inputTitle = 'Şifreyi Girin',
    inputDesc = 'Şifreyi girin',
    inputHeader = 'Şifre',
    drawTextobj = '[E] Yerleştir  \n  [DEL] İptal  \n  [<-] Sola  \n  [->] Sağa',
    drawTextCoords = 'Raycast Koordinatları:  \n X: %s,  \n Y: %s,  \n Z: %s  \n[E] kopyala  \n[DEL] iptal',
}
Lang.Notify = {
    wrongPass = 'Yanlış şifre girdiniz',
    noAccess = 'Bu stash’e erişim izniniz yok'
}


Lang.giveBag = {
    help = 'Bir oyuncuya sırt çantası ver',
    invalidPlayer = 'Geçersiz oyuncu ID’si',
    invalidItem = 'Geçersiz sırt çantası öğesi',
    noAccess = 'Bu komutu kullanma iznin yok',
    given = '%s adlı oyuncuya %s verdin',
    received = '%s adlı oyuncudan %s aldın',
    pid = 'Oyuncu ID’si',
    pidHelp = 'Hedef oyuncu ID’si',
    item = 'Eşya adı',
    itemHelp = 'Sırt çantası öğesinin adı'
}

Lang.Ui = {
    edit = {
        header = 'Stash Düzenle',
        id = "ID",
        obj = "Nesne",
        coords = "Koordinatlar",
        del = "Sil",
        changeLoc = "Konumu Değiştir",
        edit = "Verileri Düzenle",
        go2 = 'Git'
    },
    create = {
        header = 'Stash Yapılandırması',
        name = "Stash Adı",
        job = "Meslekler",
        jobRank = "Minimum Meslek Rütbesi",
        gang = "Çeteler",
        gangRank = "Minimum Çete Rütbesi",
        item = "Eşyalar",
        identifier = "Kimlikler",
        weight = "Ağırlık",
        slots = "Yuvalar",
        password = "Şifre",
        reset = "Sıfırla",
        submit = "Gönder"
    },
    select = {
        header = 'Tür Seçin',
        option1head = 'Bir Seçenek Seçin',
        option1coords = 'Koordinatlar',
        option1object = 'Nesne',
        objHead = 'Nesne Seçin:',
        objDesc = 'Yerleştirmek için bir nesne seçin',
        cancel = 'İptal',
        submit = 'Gönder'
    }
}
return Lang