<?php $titre = "Modifier - " . $coderabais['nom']; ?>
<?php ob_start(); ?>
<article>
    <header>
        <p><h1>
            Modifier le code rabais
        </h1>
        Coupon #<?= $coderabais['id'] ?> pour la transaction #<?= $transaction['id'] ?>, <?= $coderabais['nom'] ?>
        , donne un rabais de <?= $coderabais['pourcentage'] ?>%.<br/>
        </p>
    </header>
</article>

<form action="index.php?action=modifier" method="post">
    <input type="hidden" name="id" value="<?= $coderabais['id'] ?>" /><br />
    <input type="hidden" name="transaction_id" value="<?= $transaction['id'] ?>" /><br />
    <label for="nom">Description du coupon</label> : <input type="text" name="nom" id="nom" /><br />
    Pourcentage de rabais :
    <select name="pourcentage">
        <option value="10">10</option>
        <option value="15">15</option>
        <option value="20">20</option>
        <option value="25">25</option>
        <option value="30">30</option>
        <option value="35">35</option>
        <option value="40">40</option>
        <option value="45">45</option>
        <option value="50">50</option>
    </select>
    <br />
    <input type="submit" value="Modifier" />
</form>
<form action="index.php" method="get" >
    <input type="hidden" name="action" value="transaction" />
    <input type="hidden" name="id" value="<?= $coderabais['transaction_id'] ?>" />
    <input type="submit" value="Annuler" />
</form>
<?php $contenu = ob_get_clean(); ?>

<?php require 'Vue/gabarit.php'; ?>
