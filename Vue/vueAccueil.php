<?php $titre = 'Transactions Telephone'; ?>

<?php ob_start(); ?>
    <a href="index.php?action=nouvelleTransaction">
        <h2 class="titreTransaction">Ajouter une transaction</h2>
    </a>
<?php foreach ($transactions as $transaction):
    ?>

    <article>
        <header>
            <a href="<?= "index.php?action=transaction&id=" . $transaction['id'] ?>">
                <h1 class="titreArticle">Transaction #<?= $transaction['id'] ?></h1>
            </a>
            <p>Facture de <?= $transaction['montant'] ?>$</p>Par compte #<?= $transaction['compte_id'] ?>
        </header>
        <p><?= $transaction['commentaire'] ?></p>
        <p>Retard: <?= $transaction['retard'] ?></p>
        <p>Email: <?= $transaction['email'] ?></p>
    </article>
    <hr />
<?php endforeach; ?>
<?php $contenu = ob_get_clean(); ?>

<?php require 'Vue/gabarit.php'; ?>