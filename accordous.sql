-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 31-Out-2020 às 20:48
-- Versão do servidor: 10.1.38-MariaDB
-- versão do PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `accordous`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `contratos`
--

CREATE TABLE `contratos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email_contratante` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_contratante` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_pessoa` enum('PF','PJ') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf_cnpj` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imovel_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `contratos`
--

INSERT INTO `contratos` (`id`, `email_contratante`, `nome_contratante`, `tipo_pessoa`, `cpf_cnpj`, `imovel_id`) VALUES
(1, 'marli@santos', 'Marli Santos', 'PF', '123', 1),
(2, 'roberto@teste.com.br', 'Roberto Fernandes', 'PF', '456', 6),
(3, 'pedro.pereira@uol.com.br', 'Pedro Pereira', 'PF', '123', 5),
(4, 'renato@teste.com.br', 'Renato Xavier', 'PF', '123', 4),
(5, 'felipe@phenix.com.br', 'Felipe Coutinho', 'PJ', '452', 22),
(6, 'iane@yahoo.com.br', 'Iane Cristina', 'PF', '893', 13),
(7, 'lucas@yahoo.com.br', 'Lucas Régis', 'PF', '378.3', 21),
(8, 'louis@louis.com.br', 'Louis Gomes', 'PF', '299.782.158-40', 19),
(9, 'peterson@pires.com.br', 'Peterson', 'PF', '078.042.358-52', 9);

-- --------------------------------------------------------

--
-- Estrutura da tabela `estados`
--

CREATE TABLE `estados` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `estado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uf` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `estados`
--

INSERT INTO `estados` (`id`, `estado`, `uf`) VALUES
(1, 'Acre', 'AC'),
(2, 'Alagoas', 'AL'),
(3, 'Amapá', 'AP'),
(4, 'Amazonas', 'AM'),
(5, 'Bahia', 'BA'),
(6, 'Ceará', 'CE'),
(7, 'Espírito Santo', 'ES'),
(8, 'Goiás', 'GO'),
(9, 'Maranhão', 'MA'),
(10, 'Mato Grosso', 'MT'),
(11, 'Mato Grosso do Sul', 'MS'),
(12, 'Minas Gerais', 'MG'),
(13, 'Pará', 'PA'),
(14, 'Paraíba', 'PB'),
(15, 'Paraná', 'PR'),
(16, 'Pernambuco', 'PE'),
(17, 'Piauí', 'PI'),
(18, 'Rio de Janeiro', 'RJ'),
(19, 'Rio Grande do Norte', 'RN'),
(20, 'Rio Grande do Sul', 'RS'),
(21, 'Rondônia', 'RO'),
(22, 'Roraima', 'RR'),
(23, 'Santa Catarina', 'SC'),
(24, 'São Paulo', 'SP'),
(25, 'Sergipe', 'SE'),
(26, 'Tocantins', 'TO'),
(27, 'Distrito Federal', 'DF');

-- --------------------------------------------------------

--
-- Estrutura da tabela `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `imovels`
--

CREATE TABLE `imovels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email_proprietario` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rua` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `complemento` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bairro` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cidade` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Contratado','Não contratado') COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `imovels`
--

INSERT INTO `imovels` (`id`, `email_proprietario`, `rua`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `image`, `status`) VALUES
(1, 'darciofjunior81@gmail.com', 'Rua Lafaiete Pereirassss', '3444', 'null', 'Parque Savoy City', 'São Paulo', 'SP', 'darciofjunior81.jpeg', 'Não contratado'),
(4, 'roberto_fnd@hotmail.com', 'Rua Doutor Pelágio Marques', '733', NULL, 'Vila Dalila', 'Rio de Janeiro', 'RJ', NULL, 'Não contratado'),
(5, 'franciele@gmail.com', 'Av. Pires do Rio', '145', NULL, 'São Miguel', 'São Paulo', 'SP', NULL, 'Não contratado'),
(6, 'fabio.petroni@grupoalbafer.com.br', 'Rua Dias da Silva', '2000', '2 números', 'Vila Maria', 'São Paulo', 'SP', NULL, 'Não contratado'),
(7, 'tereza@bol.com.br', 'Av. Presidente Prudente', '783', NULL, 'Vila Lobos', 'São Paulo', 'SP', NULL, 'Não contratado'),
(8, 'terezinha@gmail.com', 'Travessa Passarela', '78', NULL, 'Vila Olímpia', 'São Paulo', 'SP', NULL, 'Não contratado'),
(9, 'patrick.beraldo@terra.com.br', 'Av. dos Latinos', '789', NULL, 'Jardim Santa Terezinha', 'São Paulo', 'SP', NULL, 'Não contratado'),
(10, 'zequinha4001@gmail.com', 'Rua Antonio Lobo', '85', NULL, 'Penha', 'São Paulo', 'SP', NULL, 'Não contratado'),
(13, 'pepe@hotmail.com', 'Tr. dos Trilhos', '783', 'null', 'Móoca', 'São Paulo', 'SP', '', 'Não contratado'),
(16, 'marlisantosouza@google.com.br', 'Agora tem mais de 10', '987', NULL, 'Vila Diva', 'São Paulo', 'SP', NULL, 'Não contratado'),
(19, 'marliiiiiiiiiiiii@yahoo.com.br', 'Rua Dezenove', '33', NULL, 'Vila Diva', 'São Paulo', 'SP', 'marliiiiiiiiiiiii.jpeg', 'Não contratado'),
(21, 'joaquina.peres@hotmail.com', 'Viela Xavier', '145', NULL, 'Vila Olímpia', 'São Paulo', 'SP', NULL, 'Não contratado'),
(22, 'karen@ig.com.br', 'Tr. Lincoln', '1458', 'Casa da Frente', 'Anhanguera', 'Campinas', 'SP', 'karen.png', 'Não contratado');

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_10_20_235100_create_imovels_table', 1),
(5, '2020_10_25_171851_create_estados_table', 1),
(6, '2020_10_28_235140_create_contratos_table', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contratos_email_contratante_unique` (`email_contratante`),
  ADD UNIQUE KEY `contratos_imovel_id_unique` (`imovel_id`);

--
-- Indexes for table `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `imovels`
--
ALTER TABLE `imovels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `imovels_email_proprietario_unique` (`email_proprietario`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `estados`
--
ALTER TABLE `estados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `imovels`
--
ALTER TABLE `imovels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `contratos_imovel_id_foreign` FOREIGN KEY (`imovel_id`) REFERENCES `imovels` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
