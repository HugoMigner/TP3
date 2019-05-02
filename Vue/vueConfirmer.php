<?php $titre = "Supprimer - " . $coderabais['nom']; ?>
<?php ob_start(); ?>
<article>
    <header>
        <p><h1>
            Supprimer le code rabais?
        </h1>
        Coupon #<?= $coderabais['id'] ?>, <?= $coderabais['nom'] ?>
        , donne un rabais de <?= $coderabais['pourcentage'] ?>%.<br/>
        </p>
    </header>
</article>

<form action="index.php?action=supprimer" method="post">
    <input type="hidden" name="id" value="<?= $coderabais['id'] ?>" /><br />
    <input type="submit" value="Oui" />
</form>
<form action="index.php" method="get" >
    <input type="hidden" name="action" value="transaction" />
    <input type="hidden" name="id" value="<?= $coderabais['transaction_id'] ?>" />
    <input type="submit" value="Non" />
</form>
<?php $contenu = ob_get_clean(); ?>

<?php require 'Vue/gabarit.php'; ?>
