-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 04 sep. 2023 à 16:47
-- Version du serveur : 8.1.0
-- Version de PHP : 8.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tpbonus`
--

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent` smallint DEFAULT NULL,
  `libelle` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `parent`, `libelle`) VALUES
(1, NULL, 'Ordinateurs'),
(2, NULL, 'Smartphones'),
(3, NULL, 'Accessoires'),
(4, NULL, 'Composant PC'),
(5, NULL, 'Moniteur'),
(6, NULL, 'Appareil Photo');

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `price` decimal(8,2) NOT NULL,
  `stock` int NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `date_add` date NOT NULL,
  `date_edit` datetime DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD12469DE2` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `reference`, `label`, `description`, `price`, `stock`, `published`, `date_add`, `date_edit`, `category_id`) VALUES
(77, 'APL-I13', 'Apple iPhone 13', 'Le dernier iPhone d\'Apple avec des fonctionnalités avancées.', '999.99', 100, 0, '2022-05-20', '2023-09-04 16:31:24', 2),
(78, 'SAM-GS20', 'Samsung Galaxy S20', 'Un smartphone Android puissant avec un écran magnifique.', '799.99', 150, 0, '2022-05-21', '2023-09-04 16:31:36', 2),
(79, 'HP-ENVY15', 'HP Envy 15', 'Un ordinateur portable élégant et performant pour les professionnels.', '1299.99', 50, 0, '2022-05-22', '2023-09-04 16:31:46', 1),
(80, 'LOG-K780', 'Logitech K780 Clavier', 'Un clavier sans fil multi-dispositif avec une expérience de frappe exceptionnelle.', '69.99', 200, 0, '2022-05-23', '2023-09-04 16:31:57', 3),
(81, 'SAM-SSD500', 'Samsung SSD 500 Go', 'Un disque SSD rapide pour améliorer les performances de votre ordinateur.', '119.99', 75, 0, '2022-05-24', '2023-09-04 16:32:04', 4),
(82, 'DELL-XPS13', 'Dell XPS 13', 'Un ultrabook puissant avec un superbe écran InfinityEdge.', '1499.99', 30, 0, '2022-05-25', '2022-05-25 08:40:55', 1),
(83, 'LOG-MXMast', 'Logitech MX Master 3 Souris', 'Une souris ergonomique avec une précision exceptionnelle.', '79.99', 100, 0, '2022-05-26', '2023-09-04 16:32:20', 3),
(84, 'SAM-MON32', 'Samsung Moniteur 32 pouces', 'Un moniteur grand format pour une expérience visuelle immersive.', '499.99', 20, 0, '2022-05-27', '2023-09-04 16:32:30', 5),
(85, 'ASUS-ROGSt', 'Asus ROG Strix Carte graphique', 'Une carte graphique haute performance pour les joueurs.', '699.99', 40, 0, '2022-05-28', '2023-09-04 16:32:40', 4),
(86, 'CRUCIAL-SS', 'Crucial SSD 1 To', 'Un SSD rapide avec une grande capacité de stockage.', '129.99', 60, 0, '2022-05-29', '2023-09-04 16:32:46', 4),
(87, 'MSI-GS66', 'MSI GS66 Gaming Laptop', 'Un ordinateur portable gaming avec une puissance de traitement exceptionnelle.', '1799.99', 25, 0, '2022-05-30', '2022-05-30 13:20:05', 1),
(88, 'RAZER-Deat', 'Razer DeathAdder Elite Souris', 'Une souris de jeu avec un capteur optique avancé.', '59.99', 80, 0, '2022-05-31', '2023-09-04 16:33:19', 3),
(89, 'LG-4KMonit', 'LG 4K Moniteur 27 pouces', 'Un moniteur 4K pour des images nettes et lumineuses.', '349.99', 15, 0, '2022-06-01', '2023-09-04 16:33:27', 5),
(90, 'INTEL-i9CP', 'Intel Core i9 Processeur', 'Un processeur haute performance pour les tâches exigeantes.', '449.99', 30, 0, '2022-06-02', '2023-09-04 16:33:37', 4),
(91, 'CANON-DSLR', 'Canon EOS DSLR Camera', 'Un appareil photo reflex numérique pour des photos de haute qualité.', '899.99', 10, 0, '2022-06-03', '2023-09-04 16:33:58', 6),
(92, 'SEAGATE-HD', 'Seagate Disque dur 2 To', 'Un disque dur de grande capacité pour le stockage de données.', '79.99', 50, 0, '2022-06-04', '2023-09-04 16:34:06', 4),
(93, 'LENOVO-Thi', 'Lenovo ThinkPad X1 Carbon', 'Un ordinateur portable professionnel ultraléger.', '1399.99', 20, 0, '2022-06-05', '2022-06-05 12:40:25', 1),
(94, 'MICROSOFT-', 'Microsoft Surface Pro 7', 'Une tablette 2-en-1 polyvalente pour le travail et le divertissement.', '899.99', 15, 0, '2022-06-06', '2022-06-06 15:55:50', 1),
(95, 'LOG-Wirele', 'Logitech Wireless Mouse', 'Une souris sans fil fiable pour une utilisation quotidienne.', '29.99', 100, 0, '2022-06-07', '2023-09-04 16:34:24', 3);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
