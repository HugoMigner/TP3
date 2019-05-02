-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1:3306
-- Généré le :  Jeu 02 Mai 2019 à 16:48
-- Version du serveur :  5.6.35
-- Version de PHP :  7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `facturetelephone`
--

-- --------------------------------------------------------

--
-- Structure de la table `audit`
--

DROP TABLE IF EXISTS modelescommentaires;
DROP TABLE IF EXISTS audit_archive;
DROP TABLE IF EXISTS audit;
DROP TABLE IF EXISTS code_archive;
DROP TABLE IF EXISTS coderabais;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS compte;
DROP TABLE IF EXISTS users;
DROP EVENT IF EXISTS archive_codes;

CREATE TABLE `audit` (
  `id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL,
  `changetype` enum('NEW','EDIT','DELETE') NOT NULL,
  `changetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `audit_archive`
--

CREATE TABLE `audit_archive` (
  `id` int(11) NOT NULL,
  `code_id` int(111) NOT NULL,
  `changetype` enum('NEW','EDIT','DELETE') NOT NULL,
  `changetime` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `coderabais`
--

CREATE TABLE `coderabais` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pourcentage` int(11) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `coderabais`
--

INSERT INTO `coderabais` (`id`, `transaction_id`, `nom`, `pourcentage`, `deleted`) VALUES
(1, 1, 'Rabais pour les nouveaux clients', 10, 0),
(2, 2, 'Rabais avec un coupon dans un magazine', 15, 0),
(3, 3, 'Rabais de la circulaire de la semaine', 20, 0);

--
-- Déclencheurs `coderabais`
--
DELIMITER $$
CREATE TRIGGER `code_after_insert` AFTER INSERT ON `coderabais` FOR EACH ROW BEGIN
	
		IF NEW.deleted THEN
			SET @changetype = 'DELETE';
		ELSE
			SET @changetype = 'NEW';
		END IF;
    
		INSERT INTO audit (code_id, changetype) VALUES (NEW.id, @changetype);
		
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `code_after_update` AFTER UPDATE ON `coderabais` FOR EACH ROW BEGIN
	
		IF NEW.deleted THEN
			SET @changetype = 'DELETE';
		ELSE
			SET @changetype = 'EDIT';
		END IF;
    
		INSERT INTO audit (code_id, changetype) VALUES (NEW.id, @changetype);
		
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `code_archive`
--

CREATE TABLE `code_archive` (
  `id` int(11) NOT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `pourcentage` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Code posts archive';

-- --------------------------------------------------------

--
-- Structure de la table `compte`
--

CREATE TABLE `compte` (
  `id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `nom_compte` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `compte`
--

INSERT INTO `compte` (`id`, `users_id`, `nom_compte`, `balance`) VALUES
(1, 1, 'GeraldCompte', 1500),
(2, 2, 'PaulineCompte', 2500);

-- --------------------------------------------------------

--
-- Structure de la table `modelescommentaires`
--

CREATE TABLE `modelescommentaires` (
  `id` int(11) NOT NULL,
  `commentaire` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `modelescommentaires`
--

INSERT INTO `modelescommentaires` (`id`, `commentaire`) VALUES
(1, 'Facture mensuelle'),
(2, 'Première visite'),
(3, 'Installation à domicile'),
(4, 'Départ'),
(5, 'Renouvellement'),
(6, 'Démission'),
(7, 'Achat équipement'),
(8, 'Autres');

-- --------------------------------------------------------

--
-- Structure de la table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `compte_id` int(11) NOT NULL,
  `montant` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `commentaire` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `retard` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `transactions`
--

INSERT INTO `transactions` (`id`, `compte_id`, `montant`, `commentaire`, `retard`, `email`) VALUES
(1, 1, '200', 'Facture mensuelle de Gerald', 'Non', 'gerald@gmail.com'),
(2, 2, '300', 'Facture mensuelle de Pauline', 'Non', 'pauline@gmail.com'),
(3, 2, '400', 'Achat d\'un téléphone', 'Oui', 'pauline@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `adresse` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `num_tel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `modele` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `adresse`, `num_tel`, `email`, `modele`) VALUES
(1, 'Gerald', '1799 Boul. Bellerose', '450-999-9999', 'gerald@gmail.com', 'Panasonic'),
(2, 'Pauline', '288 Rue Stalagmite', '514-778-7488', 'pauline@gmail.com', 'V-Tech');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `audit`
--
ALTER TABLE `audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_code_id` (`code_id`),
  ADD KEY `ix_changetype` (`changetype`),
  ADD KEY `ix_changetime` (`changetime`);

--
-- Index pour la table `audit_archive`
--
ALTER TABLE `audit_archive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_code_id` (`code_id`),
  ADD KEY `ix_changetype` (`changetype`),
  ADD KEY `ix_changetime` (`changetime`);

--
-- Index pour la table `coderabais`
--
ALTER TABLE `coderabais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `ix_deleted` (`deleted`);

--
-- Index pour la table `code_archive`
--
ALTER TABLE `code_archive`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `compte`
--
ALTER TABLE `compte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`);

--
-- Index pour la table `modelescommentaires`
--
ALTER TABLE `modelescommentaires`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `compte_id` (`compte_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `audit`
--
ALTER TABLE `audit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `coderabais`
--
ALTER TABLE `coderabais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `compte`
--
ALTER TABLE `compte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `modelescommentaires`
--
ALTER TABLE `modelescommentaires`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT pour la table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `FK_audit_code_id` FOREIGN KEY (`code_id`) REFERENCES `coderabais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `audit_archive`
--
ALTER TABLE `audit_archive`
  ADD CONSTRAINT `FK_audit_code_archive_id` FOREIGN KEY (`code_id`) REFERENCES `code_archive` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `coderabais`
--
ALTER TABLE `coderabais`
  ADD CONSTRAINT `coderabais_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `compte`
--
ALTER TABLE `compte`
  ADD CONSTRAINT `compte_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`compte_id`) REFERENCES `compte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Événements
--
CREATE DEFINER=`root`@`127.0.0.1` EVENT `archive_codes` ON SCHEDULE EVERY 1 MINUTE STARTS '2010-06-02 03:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
	
				INSERT INTO code_archive (id, transaction_id, nom, pourcentage) 
		SELECT id, transaction_id, nom, pourcentage
		FROM coderabais
		WHERE deleted = 1;
	    
				INSERT INTO audit_archive (id, code_id, changetype, changetime) 
		SELECT audit.id, audit.code_id, audit.changetype, audit.changetime 
		FROM audit
		JOIN coderabais ON audit.code_id = coderabais.id
		WHERE coderabais.deleted = 1;
		
				DELETE FROM coderabais WHERE deleted = 1;
	    
END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
