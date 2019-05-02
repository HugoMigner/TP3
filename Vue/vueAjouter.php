<?php $titre = "Transactions Telephone"; ?>
<?php
$erreur = '';
if(isset($_GET["erreur"])){
    $erreur = $_GET["erreur"];
}
?>
<?php ob_start(); ?>
<header>
    <h1 id="titreReponses">Ajouter une transaction :</h1>
</header>
<form action="index.php?action=ajouter" method="post">
    <h2>Ajouter une transaction</h2>
    <p>
        <!--<label for="id">ID</label> : <input type="text" name="num" value="" /><br />-->
        <label for="compte_id">Compte ID</label> :  <input type="text" name="compte_id" value="" /><br />
        <label for="commentaire">Commentaire</label> :  <input type="text" name="commentaire" id="auto" /><br />
        <label for="montant">Montant</label>
        <select name="montant">
            <option value="100">100</option>
            <option value="200">200</option>
            <option value="300">300</option>
            <option value="400">400</option>
        </select> <br />
        <input type="radio" name="retard" value="oui" id="oui" checked="checked"/> <label for="oui">Oui</label>
        <input type="radio" name="retard" value="non" id="non"/> <label for="non">Non</label><br />
        <label for="email">Email</label> : <input type="text" name="email">
        <?= ($erreur == 'courriel') ? '<span style="color : red;">Entrez un courriel valide</span>' : '' ?>
        <input type="submit" value="Ajouter" />
    </p>
</form>
<form action="index.php" method="get">
    <p>
        <input type="submit" value="Annuler" />
    </p>
</form>

<?php $contenu = ob_get_clean(); ?>

<?php require 'Vue/gabarit.php'; ?>
