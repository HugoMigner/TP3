<?php

require 'Modele/Modele.php';

function accueil() {
    $transactions = getTransactions();
    require 'Vue/vueAccueil.php';
}

function transaction($idTransaction, $erreur) {
    $transaction = getTransaction($idTransaction);
    $codesrabais = getCodesRabais($idTransaction);
    require 'Vue/vueTransaction.php';
}

function codeRabais($coderabais) {
    $validation_coupon = filter_var($coderabais['nom'], FILTER_VALIDATE_REGEXP, array("options" => array("regexp"=>"^[a-zA-Z.]{2,30}$")));
    if ($validation_coupon) {
        setCodeRabais($coderabais);
        header('Location: index.php?action=transaction&id=' . $coderabais['transaction_id']);
    } else {
        header('Location: index.php?action=transaction&id=' . $coderabais['transaction_id'] . '&erreur=coupon');
    }
}

function confirmer($id) {
    $coderabais = getCodeRabais($id);
    require 'Vue/vueConfirmer.php';
}

function confirmerModif($id) {
    $coderabais = getCodeRabais($id);
    $transaction = getTransaction($coderabais['transaction_id']);
    require 'Vue/vueConfirmerModif.php';
}

function supprimer($id) {
    $coderabais = getCodeRabais($id);
    deleteCodeRabais($id);
    header('Location: index.php?action=transaction&id=' . $coderabais['transaction_id']);
}

function modifier($coderabais) {
    modifierCodeRabais($coderabais);
    header('Location: index.php?action=transaction&id=' . $coderabais['transaction_id']);
}

function nouvelleTransaction() {
    require 'Vue/vueAjouter.php';
}

function ajouter($transaction) {
    $validation_courriel = filter_var($transaction['email'], FILTER_VALIDATE_EMAIL);
    if ($validation_courriel) {
        setTransaction($transaction);
        header('Location: index.php');
    } else {
        header('Location: index.php?action=nouvelleTransaction&erreur=courriel');
    }
}

function quelsModeles($term) {
    echo searchModele($term);
}
function erreur($msgErreur) {
    require 'Vue/vueErreur.php';
}
