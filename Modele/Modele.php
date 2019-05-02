<?php

function getBdd() {
    $bdd = new PDO('mysql:host=localhost;dbname=facturetelephone;charset=utf8', 'root', 'mysql', array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    return $bdd;
}

function getTransactions() {
    $bdd = getBdd();
    $transactions = $bdd->query('select * from transactions'
        . ' order by id desc');
    return $transactions;
}

function setTransaction($transaction) {
    $bdd = getBdd();
    $resultat = $bdd->prepare('INSERT INTO transactions (compte_id, montant, commentaire, retard) VALUES(?, ?, ?, ?)');
    $resultat->execute(array($transaction['compte_id'], $transaction['montant'], $transaction['commentaire'], $transaction['retard']));
    return $resultat;
}

function getTransaction($idTransaction) {
    $bdd = getBdd();
    $transaction = $bdd->prepare('select * from transactions'
        . ' where id=?');
    $transaction->execute(array($idTransaction));
    if ($transaction->rowCount() == 1)
        return $transaction->fetch();
    else
        throw new Exception("Aucune transaction ne correspond à l'identifiant '$transaction'");
}

function getCodesRabais($idTransaction) {
    $bdd = getBdd();
    $code = $bdd->prepare('select * from codeRabais'
        . ' where transaction_id = ?' . ' AND deleted = 0');
    $code->execute(array($idTransaction));
    return $code;
}

function getCodeRabais($id) {
    $bdd = getBdd();
    $codes = $bdd->prepare('select * from codeRabais'
        . ' where id = ?');
    $codes->execute(array($id));
    if ($codes->rowCount() == 1)
        return $codes->fetch();
    else
        throw new Exception("Aucun code rabais ne correspond à l'identifiant '$id'");
    return $codes;
}

function deleteCodeRabais($id) {
    $bdd = getBdd();
    $result = $bdd->prepare('UPDATE coderabais SET deleted = 1'
        . ' WHERE id = ?');
    $result->execute(array($id));
    return $result;
}

function modifierCodeRabais($coderabais) {
    $bdd = getBdd();
    var_dump($coderabais);
    $result = $bdd->prepare('UPDATE coderabais SET nom = ?, pourcentage = ?'
        . ' WHERE id = ?');
    $result->execute(array($coderabais['nom'], $coderabais['pourcentage'], $coderabais['id']));
    return $result;
}

function setCodeRabais($coderabais) {
    $bdd = getBdd();
    $result = $bdd->prepare('INSERT INTO codeRabais (transaction_id, nom, pourcentage) VALUES(?, ?, ?)');
    $result->execute(array($coderabais['transaction_id'], $coderabais['nom'], $coderabais['pourcentage']));
    return $result;
}

function searchModele($term) {
    $conn = getBdd();
    $stmt = $conn->prepare('SELECT commentaire FROM modelescommentaires WHERE commentaire LIKE :term');
    $stmt->execute(array('term' => '%' . $term . '%'));

    while ($row = $stmt->fetch()) {
        $return_arr[] = $row['commentaire'];
    }

    /* Toss back results as json encoded array. */
    return json_encode($return_arr);
}