Return-Path: <linux-iio+bounces-26519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A55C8F629
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 16:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB32B3AC60E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0C3376B8;
	Thu, 27 Nov 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="cNWBKcGr"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazhn15010001.outbound.protection.outlook.com [52.102.184.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33533711D;
	Thu, 27 Nov 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.184.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258981; cv=fail; b=gMpO3MyucmvgVGufHD52LP1bOyNNGEwtZ0vwTkTRGFxzOSxDg4gvYa+zb/kgTaIKIyhuFqxGtYN+zc/AKeE+RH3MibueMOWfkBzA/y8KFLa+/IzYRfuZ2st2/SCMUQMLzadOrUjaL0JWkHFz0UQuI0d7juwqr0CsN+ZAKThxnzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258981; c=relaxed/simple;
	bh=FC1ZdviqdGyJNhaENTkLOiBIMf0HogPbDi+64BdKl8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dB2HIjM/utACYrquAQNjuF/TM7M+y70aptQ7YU05tTWjeiV+o736O8LGO4Y5ObjwGl+oUSft4+5dzQ6oSo6uWmFvy4oIzDkeqBgswAnjvn7MkPWx4CWpET9uF0iSCvOZb3Fou/y5SMdxDQlpuu4cx0Fydb4VLdQBN9TPqu1opQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=cNWBKcGr; arc=fail smtp.client-ip=52.102.184.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr++WLgvIccJc5mYHsCeXvKDn6i00tM/kGP833eljgWHLO5NKZMHHsQid0YSCo4rZOdyAH9lHqUFiL8EKLmnbx0vAuSYvZbQp5Svpvs+jmjm6931sGMV62JoWZEWx/rwcntHtly1J8TOTzuptMTBVeaoAzVfCphxA+iProfhqIC5bDdoULOfcIBe1pE1hQdNtj2Yis+CXQvLn3puG3ssg3gTMYKCIFJjelQHISNGQ0YP465gYfFKPYSQIxIK7CbUnU4Mei+PKK9ldKA3UgWZo8jaBaqQiG/8SrWPtMn+Ztow2RrSjpWTh0Daag0ZsDYF/HA2cLpoCty092cUzBiEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sgx3/UoJ59INkSugCrgiedM59bgFfDuT6vf2WYwhXH4=;
 b=dNzopfvF+hvmlO5whIpkZK29BWw7VwKZKRrvBzegLfc1s0S88747sZ4CpR4dLGFC2mj3C6oHv89et81/Sk7THYMcfgKgnfk5EjILKB5CTzKkRqIJWy/UBRoz/mFqjHhKP5EUH0dtCdr5AyORTAwcqsrMaZgUDCQR68sNKvuGJMdwfzSM7HRYjfHw6UkZOB0JxvHBBH2C/r1YbZ8BjnW46R0rJzUj1yuuX4TJx+njjekhnJmCv1SB/AA1MiiL+d7p4L0ZvGDS7+2xYqbE1q+exl66MLGkDolVx0r+hyEPUbsytWkCBi7vLr7hyp1k3mq8KK1LTy4TOfZ7spDpCb3azw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.30) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgx3/UoJ59INkSugCrgiedM59bgFfDuT6vf2WYwhXH4=;
 b=cNWBKcGr1zaNbzSJ9b9M+sCLdkiEHpk6y0vSca+rpBkh/rkoBkuZ7Wysp+3uz3lpVEG1jmhI2M1oKsZxp4W9nMeRw+qygiiTS16fq+1GQOcxxHx4Cc3CjKXy6wIzcj0Kbh1cVbgTjJ9gPMTTk6tPeIsXvsQmz8NqfDUm5PCL4Gs=
Received: from DU6P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::19)
 by ZR0P278MB0824.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 15:56:16 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::f7) by DU6P191CA0002.outlook.office365.com
 (2603:10a6:10:540::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 15:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.30)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.30; helo=ZRZP278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 DB5PEPF00014B8F.mail.protection.outlook.com (2603:10a6:18:3::30b) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 15:56:15 +0000
Received: from hz-glue04.de.seppmail.cloud (unknown [10.11.0.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLdC2C0cz1145;
	Thu, 27 Nov 2025 16:56:15 +0100 (CET)
Received: from hz-glue04.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue04.de.seppmail.cloud (Postfix) with SMTP id 4dHLdC1mkmz1xXp;
	Thu, 27 Nov 2025 16:56:15 +0100 (CET)
X-SEPP-Suspect: f790aa5b522a46bbaf14ba89f4e417ae
Received: from hz-scan10.de.seppmail.cloud (unknown [10.11.0.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue02.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLdC115Zz1wjK;
	Thu, 27 Nov 2025 16:56:15 +0100 (CET)
Received: from hz-scan10 (localhost [127.0.0.1])
	by hz-scan10.de.seppmail.cloud (Postfix) with SMTP id 4dHLdC0MRmz4gb5;
	Thu, 27 Nov 2025 16:56:15 +0100 (CET)
Received: from hz-m365gate02.de.seppmail.cloud (unknown [10.11.0.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan10.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 27 Nov 2025 16:56:14 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com [40.93.85.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate02.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLd85rs8z2vvf;
	Thu, 27 Nov 2025 16:56:12 +0100 (CET)
Received: from AS4P192CA0050.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::12)
 by ZR5P278MB2072.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 15:56:04 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::9d) by AS4P192CA0050.outlook.office365.com
 (2603:10a6:20b:658::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 15:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 15:56:04 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.54) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 27 Nov 2025 15:56:03 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 GVAP278MB0037.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:23::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.14; Thu, 27 Nov 2025 15:56:02 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 15:56:02 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: linus.walleij@linaro.org,
	brgl@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	morbidrsa@gmail.com,
	jth@kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	nathan@kernel.org,
	nsc@kernel.org
CC: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Subject: [PATCH 2/2] mcb: Remove MODULE_ALIAS from all mcb client drivers
Date: Thu, 27 Nov 2025 16:54:52 +0100
Message-ID: <20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0017.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::20)
 To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|GVAP278MB0037:EE_|AM4PEPF00027A69:EE_|ZR5P278MB2072:EE_|DB5PEPF00014B8F:EE_|ZR0P278MB0824:EE_
X-MS-Office365-Filtering-Correlation-Id: fa260f95-c339-40d3-c647-08de2dcd7f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?HkXUxBOcniopL+7+7TYUtgank2VtCb3jzPWOwakUexxrYU0oicuj99DwYPT8?=
 =?us-ascii?Q?aAvW3Em4ofFygPsBrrJa7GR2VA77ezxttRIVH6s9m9oxF6WLSelJDfpl4qSA?=
 =?us-ascii?Q?weMlX+Nsccegs6LDktjYFbeGrN9pbqdb0zFZQGIMEivjKwZ8HyltZjSwJTYS?=
 =?us-ascii?Q?JTLCH/52FCTK20tzMiBwmJoepkvvKSi3jMp2bSDs71p7CXZTVDg1U4k+rjB8?=
 =?us-ascii?Q?3Mg+LEvrU+tN/J1bDBcO2iemecQzagXeKCzlHRMqkMTfXBt7/zisK4IBzAou?=
 =?us-ascii?Q?Xy6du5fdiMegNurZ8jKABneFiasL/TZ44lXSaQhE3dZUbO6c7ZPpzX3TtRpC?=
 =?us-ascii?Q?qzuPNLWGjXcydZSWQ6i/W+CuwD451c1FxYnI6yt+Oz65iVc/AGLXaNOU42Wt?=
 =?us-ascii?Q?IxS7PTLataQWrIhftCeyFVUd3WDpRB0ENdCsYpRq6fHQK/hd9KQZRi3qKgrO?=
 =?us-ascii?Q?/DR1leXxkAuHL3Lx57kowOo/iYKC1TKRyvv4kbEvAtho1+ew12qXWimmPe4G?=
 =?us-ascii?Q?yHd8EwuKD9vovq3KIobsT84MiWNkqWnsXIZQPpDL2DGX8F+sGcruiE84QpL1?=
 =?us-ascii?Q?Q02YP9Fb/P7oNiYpprBj0a4+h95J3SrFUcYvcZa50DI7RetYmBvQe2l/P7a9?=
 =?us-ascii?Q?H4kA7wZ7G+WZeyCZ9Z1NWdT6FmQkC1hwG/qqqCKKIVyKLNtZdGQNsb0qnt8v?=
 =?us-ascii?Q?Th2AytYNQBeL1ES2rzBTJ9r3oRz5TcvuInJ5XtWnw25nWvpnyk/K/73b+6GQ?=
 =?us-ascii?Q?zLxQOKSssGdkbJa94EpTy14JJKFsII5g9W2ELHpMmFFJjeg6UeXdVU3k4Ok1?=
 =?us-ascii?Q?HSKTXgNd7xmVyAJ/m02h7fB0vo8Z2MIo6GnC6lq6IX0WNFsADF+J5h6VPFaY?=
 =?us-ascii?Q?R+99cbTNZZl/vPgDSolXjS/n96NQyrbInGTW/2YoMXRUvg2H1rSlYJRM8YyR?=
 =?us-ascii?Q?OAe0KO0D7nbWNCdoT/cJQ4hJ9zUYvLhKOGvkvg9eYRBNl09d3uMFV9wRL1I4?=
 =?us-ascii?Q?MND5wfHWC3LaF9WBIF3L/B2kS9Dx4dmCJIjE5GHfQ40frSp1baROT/b+JgtH?=
 =?us-ascii?Q?PEQzGRTIGZ2KiX3gpO1s12UCNOZz7PbKJud3l9sOZHInNU0DBIlAsMMGUYsb?=
 =?us-ascii?Q?Ix3hKwCbwByVIv8CmtcmUfftoY89gLlxTql/DrqNQ2RhUf+v26mdP2SubUjW?=
 =?us-ascii?Q?jhb42yq5SD+TkoXnt8nxR2DLWfwP0aW5aQeGPm3Aqw+2Y71dAIosDx9k9uBw?=
 =?us-ascii?Q?0NKS/XbmS6mzaR/aLEIRZTYESr7/jNRLiSKOvVc/eg4qlJVbTa7/ZM0LLVi5?=
 =?us-ascii?Q?USQuCdBPksU4862/x7PDLNc2jKIrzDcvEy04OsdLHGg72/QmT6RPZTeAS9W8?=
 =?us-ascii?Q?6WV5evsCNOMyLmgYX3U2fta8a7v7YLbITLYg9YOMrl/G8VNR8njIPEiLtCaI?=
 =?us-ascii?Q?rRaDD8uB+bEG2SWsn5ue8wghmhhmoNXncr9SKUvhkxEYc99bTKhj9BgjSM4B?=
 =?us-ascii?Q?JbyqiY5dI3Zg2j5PPQ3Ug/aTFSOYtGuNvux5yxuTNceZQpNVn6kASDTTrw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0037
X-CodeTwo-MessageID: 5bebd144-dfdd-44f1-b742-914363de90f2.20251127155603@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 90ee67d5-4285-498f-73de-08de2dcd7702
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|35042699022|82310400026|1800799024|7416014|376014|14060799003|36860700013|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?dgLOfOeN2NnN8zRUCwfXEUJcUHB6cq0UxOFZJuuEUcCSokPx53tWS+Sa6XSZ?=
 =?us-ascii?Q?9ETGtf7VwtFqZtww0NPF9NdpefHa5jPF/KR0XTMgfLgE5xQL0qrRlPxbCY6r?=
 =?us-ascii?Q?D1ydowxWdQOzyAK/k+wNikcNzKaOqd06JYJ5SU7Rn1qUVf5BK7iS6qxEKio0?=
 =?us-ascii?Q?ndZc0Ccl2qPd3eHWhaiRWpv92nZPffNCgXs9qnLxGXKQQ76pHuq7UsGdW3I4?=
 =?us-ascii?Q?RXGCFTWB1h7BZ//ifBnpMEjjTquAjgP2KDkJswN0CbCVJt/VZpDcL00z+1Ye?=
 =?us-ascii?Q?CqVQHy7+RSH3gSSdS1/pkF1PyeHpUzFqjJebdVOfKKELxJ0C2OXRPM6QpcmT?=
 =?us-ascii?Q?+/kEDm8TYvnJerlQOvHUy4h6mx8HzqXtNo2BjNmcmOnDzJNWtFqyu4zFDOSQ?=
 =?us-ascii?Q?WE0HbPsbpefQrUw64p+lniq9fRcSUsgVSQSNfJPuCwYr7Fx9qd+nb+I5fqZ8?=
 =?us-ascii?Q?CB986hBO5yEoTy6mB6eqPJXzvlYiKDGzMfZyPuUd5yLdtzPrQU72H2CPuh7Q?=
 =?us-ascii?Q?DjwxTMDXr1cIZlf9yyd5qlvvmJUdIhQYB5m6P6Qr8kr8IijREQ9uZOQYVnfi?=
 =?us-ascii?Q?SKQYn8U+cVo6df+QEtFfePHOBhcxNTw//LACSgm9vo9pRm6X+4SVxqzqELsm?=
 =?us-ascii?Q?6CgQCkgavAm0nOn6DK+Rxi/DTPRLeCeVeITvY1HraJ6iao9VfbT8kHf2Ibu4?=
 =?us-ascii?Q?aNKQc4xxZQ/XjA4Bek1v69WKU5bfJYlEQsQhxZWSX5rGadRQNZaHp8d9wB0+?=
 =?us-ascii?Q?oxGPkD8VuI0P6TzXGgbqeh1C0K5TPHksp2y3d/nJ7C2XKkaHUBAezvx1Eo+8?=
 =?us-ascii?Q?ruap+jX7P3kc90kNsfE3E1Gif8Hx0h1MMx8nDEqpG/dqkrx19zgSQK8FsZ50?=
 =?us-ascii?Q?n1EiNTw+/L6nFxH7vRKMvy01Eq42IJLAHzlVK9p9XeCHChyzSVQrgNWSmVMg?=
 =?us-ascii?Q?7rh4y27QCwWY3woxkbePcX/6OStMI6srZPIrz+yClpKgrQ2gOUtXDH7tJiVH?=
 =?us-ascii?Q?nysUybYCgTAQKe+J2a0JWBJ6BAIuUQMGtXSDErh5WAS+Lb59lQgEUeIxUNpb?=
 =?us-ascii?Q?nTMnMKNrBykWllvg2+i3LHNdb8gsZhI1OXac3i5Rexn/WBSeChdPYPVTTzxy?=
 =?us-ascii?Q?d4dxAyPYYsRExtgr4no5LYfzrzReSSIzaY/brzm6p0LQD4dkfCrElUU1AqTF?=
 =?us-ascii?Q?AkxVJQEN9xRfkrUK1o3/P5D3xW6deKaHmatiCzasjb2OBqXutHwgxIhMXHhT?=
 =?us-ascii?Q?eEc0xKKhcqe1wmJWT7XsycZnczjnOwm0/Lu4fe7uWc8ZwhRrwW1qVnT/b1ZZ?=
 =?us-ascii?Q?ChSneFbLQemFjpTAk/sZ2R9gw2ZwZ36LnOWxfEd5TRR+pPlT8gkeJSq/ft8P?=
 =?us-ascii?Q?VWYEDQ+u2j/b4VaPR4mjNN5TgAGA6qtOUBIQy+Q46TAhDzyIoSaF9l28pVwg?=
 =?us-ascii?Q?uxJhYFYmmsXmDNzKiZWV8R1ZbCd7Z8TX+cy5jxp+jShTlazGPOQk9KHTNdWy?=
 =?us-ascii?Q?U/m4VWXF2O8XQKnLyznEnV0dzB5whgFzyzhp3DSCAk2PK53n8p5Relx2YCyg?=
 =?us-ascii?Q?EZcmJfD1h97vxYVtV3185ZFKP2ePAJ46DXEaGqK+?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(7416014)(376014)(14060799003)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR5P278MB2072
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	80615235-d201-4300-3287-08de2dcd7885
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|34020700016|36860700013|10070799003|35042699022|82310400026|1800799024|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ha83xlHpw4SeJU6SRvGCpuWGlrU1N1GpaF4s+WswXAn3PPWfiXuz6oFt+9C?=
 =?us-ascii?Q?jSAJv0/h3ijRJx0WvtDmHW/LsPNJgfMR7q0zTa0oQHy00IJepdCTMUZsMa2u?=
 =?us-ascii?Q?sL7lpG3VQ7TPz3arfkhRredZHwiQxaS0cB1/Ohbvk4wP4nxmmQOUgAPhQyLv?=
 =?us-ascii?Q?JLMFrenfLW5y9Q4N7aD2rrhg70KG9RqEVR8t95wrZSecYzFG5mypX06x78Tl?=
 =?us-ascii?Q?TngkyEwfoDKKS6MhppNrnG4LSXPeW6teqxZlhi+nadJj9ayKOme1QMfOw2/F?=
 =?us-ascii?Q?iB9ZB6X1hjU6pIJ0SnCgDToTZtF2E7Jo8j5+f+timuzus8H0WDngIFAZFWqZ?=
 =?us-ascii?Q?vwPaRynj4/SWwiewwR9e9xJ7vsNh+O0QeEjRQfERKbY1DdOXj858UmZJCLmH?=
 =?us-ascii?Q?TGywAEOmAU5fZXnxrp35gBqifoDrR9dRSVBMKDs4y7tZKN9MwcOjZY9BMhry?=
 =?us-ascii?Q?p2wz+czUyavkGhILxm694AZzb5QnYiPwQpdQQRe7KLOeY9AHSkNQrraSOO7R?=
 =?us-ascii?Q?zUzdiBsWynG1EB9JhfzaWDutZpckfSs7CE+pAVf8EFxKeMKOgWVhhnLsDcDJ?=
 =?us-ascii?Q?acrVU3VPdy5LDMc9cPaMFweoAwuHAGspJFXMOTiJCE7vXQBvrYJ1JfjYup+r?=
 =?us-ascii?Q?KgpOUAvhaeFirnpXLrMvif0JfzINbZASUa0ej6K4F83J+Eysv8FVZKzEPXHw?=
 =?us-ascii?Q?dcxJKZFzG295+BhMu4ql+6pRJ5ELPWEtUISYpF2byafN/njJmlo4Fl63AWv7?=
 =?us-ascii?Q?1kMGtz3NAmBv77AykVUPKVRywD9aPIvNhEzVwOccZQWmpHNf2UHYZGS6XWgh?=
 =?us-ascii?Q?N3imGXIQUj4wMMUNFP/NzZlpwpp3mipq4R7yBOVHm7Nx2+hPR8OqEGc8GSmc?=
 =?us-ascii?Q?hp+LSMH0i/cj2hsHtOGye5DZrDZdG5lkNv2O7O9wTkAXB4iBaZgnBinNVmRO?=
 =?us-ascii?Q?VWfbg5JW4TBf9WzP4RGUladTj6GjW1ea7170XQ6Va8PKsiVzHG7e2JGghLzS?=
 =?us-ascii?Q?w1uL4VXSRhA4PkkS7yoRZrCuJ6l9JiL/TuT504qRqTmHQLkMPi2nzLEmVbxE?=
 =?us-ascii?Q?g6xTeULh7zxvKJJxronlnamAdbuRac1oCIvDPSlHqhWcaKT/xd45qUWixzck?=
 =?us-ascii?Q?/cQnPX63qqK6ApfbPILoU+/8Lk8YwDIDBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRZP278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(34020700016)(36860700013)(10070799003)(35042699022)(82310400026)(1800799024)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 15:56:15.7943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa260f95-c339-40d3-c647-08de2dcd7f50
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0824

MODULE_ALIAS information is no longer needed as now all mcb client
drivers are reporting such information through MODULE_DEVICE_TABLE.

Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@dua=
gon.com>
---
 drivers/gpio/gpio-menz127.c            | 1 -
 drivers/iio/adc/men_z188_adc.c         | 1 -
 drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
 drivers/tty/serial/men_z135_uart.c     | 1 -
 drivers/watchdog/menz69_wdt.c          | 1 -
 5 files changed, 7 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index 52b13c6ae496..f51e7517f551 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -223,5 +223,4 @@ module_mcb_driver(men_z127_driver);
 MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
 MODULE_DESCRIPTION("MEN GPIO Controller");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("mcb:16z127");
 MODULE_IMPORT_NS("MCB");
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.=
c
index cf8a8c0412ec..90919d282e7b 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -171,5 +171,4 @@ module_mcb_driver(men_z188_driver);
 MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IIO ADC driver for MEN 16z188 ADC Core");
-MODULE_ALIAS("mcb:16z188");
 MODULE_IMPORT_NS("MCB");
diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index a78ef35c8187..9774a95f2980 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -268,7 +268,4 @@ module_mcb_driver(mcb_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MEN 8250 UART driver");
 MODULE_AUTHOR("Michael Moese <michael.moese@men.de");
-MODULE_ALIAS("mcb:16z125");
-MODULE_ALIAS("mcb:16z025");
-MODULE_ALIAS("mcb:16z057");
 MODULE_IMPORT_NS("MCB");
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z1=
35_uart.c
index 9cc15449b673..6fad57fee912 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -919,5 +919,4 @@ module_exit(men_z135_exit);
 MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MEN 16z135 High Speed UART");
-MODULE_ALIAS("mcb:16z135");
 MODULE_IMPORT_NS("MCB");
diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index 6e5e4e5c0b56..3fe23451135d 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -163,5 +163,4 @@ module_mcb_driver(men_z069_driver);
 MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
 MODULE_DESCRIPTION("Watchdog driver for the MEN z069 IP-Core");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("mcb:16z069");
 MODULE_IMPORT_NS("MCB");
--=20
2.51.1

