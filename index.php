<?php

require 'Controleur/Controleur.php';

try {
    if (isset($_GET['action'])) {

        if ($_GET['action'] == 'transaction') {
            if (isset($_GET['id'])) {
                $id = intval($_GET['id']);
                if ($id != 0) {
                    $erreur = isset($_GET['erreur']) ? $_GET['erreur'] : '';
                    transaction($id, $erreur);
                } else
                    throw new Exception("Identifiant de transaction incorrect");
            } else
                throw new Exception("Aucun identifiant de transaction");

        } else if ($_GET['action'] == 'coderabais') {
            if (isset($_POST['transaction_id'])) {
                $id = intval($_POST['transaction_id']);
                if ($id != 0) {
                    $transaction = getTransaction($id);
                    $coderabais = $_POST;
                    codeRabais($coderabais);
                } else
                    throw new Exception("Identifiant de transaction incorrect");
            } else
                throw new Exception("Aucun identifiant de transaction");

        } else if ($_GET['action'] == 'confirmer') {
            if (isset($_GET['id'])) {
                $id = intval($_GET['id']);
                if ($id != 0) {
                    confirmer($id);
                } else
                    throw new Exception("Identifiant de transaction incorrect");
            } else
                throw new Exception("Aucun identifiant de transaction");

        } else if ($_GET['action'] == 'confirmerModif') {
            if (isset($_GET['id'])) {
                $id = intval($_GET['id']);
                if ($id != 0) {
                    confirmerModif($id);
                } else
                    throw new Exception("Identifiant de transaction incorrect");
            } else
                throw new Exception("Aucun identifiant de transaction");

        } else if ($_GET['action'] == 'modifier') {
            if (isset($_POST['id'])) {
                $id = intval($_POST['id']);
                if ($id != 0) {
                    $coderabais = $_POST;
                    modifier($coderabais);
                } else
                    throw new Exception("Identifiant de transaction incorrect");
            } else
                throw new Exception("Aucun identifiant de transaction");

        } else if ($_GET['action'] == 'supprimer') {
            if (isset($_POST['id'])) {
                $id = intval($_POST['id']);
                if ($id != 0) {
                    supprimer($id);
                } else
                    throw new Exception("Identifiant de transaction incorrect");
            } else
                throw new Exception("Aucun identifiant de transaction");

        } else if ($_GET['action'] == 'nouvelleTransaction') {
            nouvelleTransaction();

        } else if ($_GET['action'] == 'ajouter') {
            $transaction = $_POST;
            ajouter($transaction);

        } else if ($_GET['action'] == 'quelsModeles') {
            quelsModeles($_GET['term']);

        } else {
            throw new Exception("Action non valide");
        }
    } else {
        accueil();  // action par défaut
    }
} catch (Exception $e) {
    erreur($e->getMessage());
}
