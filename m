Return-Path: <linux-iio+bounces-26520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A485C8F62F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 16:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D723ACB5E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73226337BA5;
	Thu, 27 Nov 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="eg6QwIRC"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazhn15010000.outbound.protection.outlook.com [52.102.184.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478933375AE;
	Thu, 27 Nov 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.184.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258982; cv=fail; b=OkhOYWTj/lBBOw0vJe/eTj/1UC2i9uMxmTqO24lehvPhEbdtvqUt+AYXVy8HBtZwD8uHOWu5WuswIJhELN39eMmN5wBzmRblS3E/vOq2CdvlunOJIBt2cFLLFYhqlA8nHwgx3r4TbnaEBmxq+DOBJefK+3XxQocfLUA67W9ONns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258982; c=relaxed/simple;
	bh=ByrkltoefJ34Cct7Wv7ggrkJJW3QZniV65CH4p40X/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQx2sqX24AWW2shUdIaVlAFxYCZgrgG5Y//bbKZXlG+/BbF/A0ZPiCcohCLZ7DYoYFY8jg4WoocnIUQSj+Urpwdjl6MDAwKwYT/3pmBkWMFpHKpUBBo291prfXHwPyQ68Vsbc3MwokaHHOeLjEAWFy6NsoT40ljFDg6+OpSMZxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=eg6QwIRC; arc=fail smtp.client-ip=52.102.184.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyPEI1Ktx5dZj9q/fPa9BJNh5bRZl7RZZVv9/xIuDm2eskK16tH4emIsC7ggQm0x1j2dDePS8zosv60L3Wmzk+YcfUCCC02i5QnCURM4TfR6KMV5i9nPyFYUDVCjo54lWLGffXHcIRGPRR+z0rhwx2YMTEyhP6d/AOYqmkzQCL9p8tomtZC+oFEGHOVk54BhiF19qBuwDt4LQ08dp4n9QL0TXupVczkFcicIkvl57uFnksX1s7Rd8t1lzPCWKPShWYkk4ruiPosNF8oBwMqbNJzavkA3dUKGBG8S67uaj8Gx/RQFVFz15p0Hd+nFFo6puek3S3ugO17vPwO7tj36pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMZuPkxrVr2LisprqLWFwM85lvzA5CIVb0ADg0GfxHo=;
 b=EqeR2Omv/TftajCAk8gdUprPHI80hUWcc0Exvb0hF/R/VxM6q2oensjYFUFvUY9894HENDW2M5ao+pQo2Zk0Iqx8VBThrlrKI5jGhxgVi3XIkDnE0XePQXXBmQWV0G1Y9SPCFTQ/1QWqeaH0qRAvHTRre4MAgqqVgWqG5vVJJSAk6h9oHzbcu5ALexZOjJHgSf0t4fmm6a+vbRCkUJgqv//vfccErBnPZqi6gjID18L+9PfQ7KAVb7qgWt8BuoNyz+vKPAFrgz+6hIYkYEM54TPbCMWVQ5y5Uz5/ncDq68h9vTYOGxTHj6qpV+IWsGakmFKxpK4bfPy1LlQtmICxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.86.3) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMZuPkxrVr2LisprqLWFwM85lvzA5CIVb0ADg0GfxHo=;
 b=eg6QwIRCMs89++i2EE3NJXmqtvJfsNcHn8nVij8+nKiBWiyYnpmyw7/sWICNT8RtdWe8Kz+yz9Wy0jEFmtAOYaDXSFnVXn3R6aTZVMyn4Za8stwgCXJg5pZWDAfGHH+i+qH/2LOXnPJ1WS98QSRlJQ2jV3kypEd5FUra5idkRVA=
Received: from DB9PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::17) by GVAP278MB0881.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:46::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 15:56:16 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::e8) by DB9PR01CA0012.outlook.office365.com
 (2603:10a6:10:1d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.15 via Frontend Transport; Thu,
 27 Nov 2025 15:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.86.3)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.86.3 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.86.3; helo=GVAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 15:56:12 +0000
Received: from hz-glue01.de.seppmail.cloud (unknown [10.11.0.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLd761pwz4v4R;
	Thu, 27 Nov 2025 16:56:11 +0100 (CET)
Received: from hz-glue01.de.seppmail.cloud (unknown [172.18.0.7])
	by hz-glue01.de.seppmail.cloud (Postfix) with SMTP id 4dHLd75Jsvz1vkb;
	Thu, 27 Nov 2025 16:56:11 +0100 (CET)
X-SEPP-Suspect: 71d8b62d7cd04a3b9c7b4f914b9d9c60
Received: from hz-scan03.de.seppmail.cloud (unknown [10.11.0.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue01.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLd74cy9z1vkV;
	Thu, 27 Nov 2025 16:56:11 +0100 (CET)
Received: from hz-scan03 (localhost [127.0.0.1])
	by hz-scan03.de.seppmail.cloud (Postfix) with SMTP id 4dHLd73w7Fz2X7B;
	Thu, 27 Nov 2025 16:56:11 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan03.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 27 Nov 2025 16:56:10 +0100 (CET)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010003.outbound.protection.outlook.com [40.93.86.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLd32Knlz1w7c;
	Thu, 27 Nov 2025 16:56:07 +0100 (CET)
Received: from AS9PR0301CA0050.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::19) by ZR1P278MB1715.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:a8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 15:56:03 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::8f) by AS9PR0301CA0050.outlook.office365.com
 (2603:10a6:20b:469::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 15:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 15:56:03 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.53) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 27 Nov 2025 15:56:03 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 GVAP278MB0037.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:23::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.14; Thu, 27 Nov 2025 15:56:00 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 15:56:00 +0000
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
Subject: [PATCH 1/2] mcb: Add missing modpost build support
Date: Thu, 27 Nov 2025 16:54:51 +0100
Message-ID: <20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com>
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
	ZR0P278MB0523:EE_|GVAP278MB0037:EE_|AMS0EPF000001A7:EE_|ZR1P278MB1715:EE_|DB5PEPF00014B95:EE_|GVAP278MB0881:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d45a0c-e3e9-488b-6a2c-08de2dcd7d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?5oYXYlG/TFrrT3pHA2BuJzJ8YaSgFDTMafniF78w62Jo7HQojVKiXVHH2c/q?=
 =?us-ascii?Q?wUEGrrEJ0AHDGs8ll51dDh4HsAFyu0/CVxQz67EMUXXXVwIiRr4yoayM/FeO?=
 =?us-ascii?Q?QxhN0/Aon2n5hplYno5rJGvSqOMu7IdpVjKuoit5KA8YI1Z1IaIO/2ZzaYnE?=
 =?us-ascii?Q?mL+hrEIQFlDwhQNFc5muHIU8Fm7m1llGoRvLRCsuXTinQZENAaFX/1alJWg+?=
 =?us-ascii?Q?Q2qz/Tn3FqwuV7xBP2DiIebam3rSJi0teZtc4+npIazsRAXh4NuQKXsW9t8h?=
 =?us-ascii?Q?TPY4EyDupzIAY/BIkdER5PUhq1NTGJjwt4xiCKUvHSlTg2WcvriI6l9ZLn5C?=
 =?us-ascii?Q?lBtKPx0lRNggFbcjrLnC9gCeUdoC1JAUxiAjPBQhTyuyHMZvNdJvVbAro0Dv?=
 =?us-ascii?Q?ETx0vW8yPjF4dQosRAdBaRbFD5cngyrnkpiP8HLrSpJW9Yos/QqjprCTv6ud?=
 =?us-ascii?Q?M1Gc2ERIGPk/BeAzZeZc75r2E+eb29r0PnwqMEepPJLpRnn1YWkAxZVVbft7?=
 =?us-ascii?Q?gnMnUlRLdk77TS6q6yjzSxsUs+wmL+V5xtkaMv67QPqE+rG/3KqS3+9rvOwI?=
 =?us-ascii?Q?8aI+xCZcTAkex0/yFTfh7M0/nZ5X0Cr4zJz66c5ntCM/0YFrTklfPdluBlP3?=
 =?us-ascii?Q?PExKdiVgoa/lJTP7YZn4+OlswllwARH9m4gqwWZWd17j86elgS9anx9iqPxE?=
 =?us-ascii?Q?oPCDxoQvlFvFUpQHH8k7QsmKFhOQDjm2YIYWKGbqudS2mK2trHwryVMdNCD9?=
 =?us-ascii?Q?83L2jQzx+XxzVAQ/Ja7y4j8hKH+tqwzVWKNjM7CP3cDZJ3QL4unR0S81JZ7Z?=
 =?us-ascii?Q?+fSZUzrfvfoO2NEwn2Qv5hllcMzkzCuVMD/E2nJTwhf66q4RmWxCPDtnC2gk?=
 =?us-ascii?Q?boblmKgjFWfXvwEQpa9vCi0ioHhCI64vdPh7J0rDt+bf3e0+l/pL0RsGt5l0?=
 =?us-ascii?Q?VmPemjVEBy7P2SaLGpeUdGHzRkNZOGbPM9Y3lLZ5KhlvqQXVdflJnWLpNhki?=
 =?us-ascii?Q?L0xmWO581OLE5/n1yFwjeztJS4QDAj7UvejadO5BQ9K/17ne2mE1knH/detz?=
 =?us-ascii?Q?z9DrTGRkd0kctUjzbSqygFJ1V6qOFnPuyAkJUYEARxdtNNgqoYe7nzlc311m?=
 =?us-ascii?Q?J68X6WRkxWm+q0yh1+VbzZiuTF85glVo/corbKh0Pbn8v32Em2AXmuQ1OQzV?=
 =?us-ascii?Q?tddZAO656Qaa1Pc6F37sW0YX5D3nmiyVkr1UDRAf71N7S0Cf/c6spa8svXsg?=
 =?us-ascii?Q?mWenHaFjX0E+HadUCealHKN5xxIAjI64z4gLDrvD3EkO04630BBvQ5/5Jiul?=
 =?us-ascii?Q?NoIe+OXJ5kYXDy+/uyaX9EjYmHwZipjRCYRbaZWgc3tre5nW1zUf1BKHxcr2?=
 =?us-ascii?Q?o84qDfT7v7iT3PF/MaoPsw/n9QqJgg7B6OOZv1nrPeCWT2AvRC5qyZ52VV+E?=
 =?us-ascii?Q?qbSAlTcP99iLtGf0z3Tc0JNaYb6dXu9DMehU501SDa4WhzC7x4ifexBvJ8kG?=
 =?us-ascii?Q?8pCZ3b1sp5hSHX/7SlOadWWTyMkho/NgoOc5wHOKcD91klWEYxuNDcCf7A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0037
X-CodeTwo-MessageID: ffddb7b7-f979-4155-a535-6bf71d58f23e.20251127155603@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 1f36dbc7-fb3c-4d57-6a96-08de2dcd7603
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|14060799003|36860700013|35042699022|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?YK/ft56B5Q2IOGuO+pRV9VuA8zyu8F+WZfnkoE6PGU7dVYdoVjeN9EinyWCU?=
 =?us-ascii?Q?xBKrCd0BBB/txzR7GYLMxF+TtDL8zPT0a5etkiUHqNLmxRmpbY50zXBCjByz?=
 =?us-ascii?Q?/dRYzG9w1InWB8hZ+4Td9MlrfW5/wfrJqclKG9YUrQQkggdiq/3JrSW2Abi3?=
 =?us-ascii?Q?U/Omg9G57BD96z/Ten6LTgqhGBp4jNWj9GByEa1q7sfZ2oua/xP3bzXbqfNe?=
 =?us-ascii?Q?yufEacD10wx/jRhi7++qHrySM2yolZr0X849yFrSjJkq/y7WSfNyRJrC055g?=
 =?us-ascii?Q?vom2vmcBkdv+T6/26ATRqQStBVL35KUWedVmRvRVc1SORK113Tvdq20efOUw?=
 =?us-ascii?Q?Wx/taIkVfKj+CoHhubO9gDnHb7QoSL8z+VonMfQI5ZXp7ZEoSOXVO9XGfpVh?=
 =?us-ascii?Q?EoB6v11zjCALTNeGeaiIHXwrSG4SzD0dHU/oyWAT4ViLioFRef/LZCrVCgh3?=
 =?us-ascii?Q?K5qoeNvPehZOFnpofLeoyauZoddLlWczaUBZRJxdc9esKyaFn+cHYb7m1Vqr?=
 =?us-ascii?Q?Q5y509XCnSYMJFWlaJX1tZjEcD9y/4BvLLgUt9YiW0lJvb6L2Et8M9UiBQGA?=
 =?us-ascii?Q?z9dMS7EZffVsKPAgIwMwfeFZ0Rxg8UuzCD0VsXWemSJxgsWSC5OJ+E5jsV+K?=
 =?us-ascii?Q?E6Vc/EJEckemwYEfb5J6K6ePWXt+69vCM8T8tKzzinjMwlHzYiI/MuuqH23V?=
 =?us-ascii?Q?0UTTIK0YWOFcWVj5ZtJpVGFKiSioVjGVU1Vrr2IR2TiY0dBfH7Am7Y4QtQz2?=
 =?us-ascii?Q?wbLxjQKm/EhX0m9Q5OOj8ORXlbIfOPI0AMO0uSrKFl6Zmlwe/lXL25Tdjz9o?=
 =?us-ascii?Q?gxEBzvuGBlrBHfQ1cZZ1/1MBu1iC5VwQdSxOHO5fM6R3VL7pTWxUK2JbhTpO?=
 =?us-ascii?Q?d1Xdous3y1dKEo63AuF3HlS1JxeVc2UBRM2m9+khngoKk1RvOfsExRRpUdAv?=
 =?us-ascii?Q?9uOmrTnrWwM5KNBynMbQ9TsCD+0uRptf2LrsKBScJJWfoZiR4lor6TtbSGRd?=
 =?us-ascii?Q?txnGiDqMArpD7VG6ZYR7KPzZINkRc+ZUAFYMV55JNFs3y13Ee7ug7wZHEKxM?=
 =?us-ascii?Q?qCoeQS2S0L/OeTChvHtOvc9Vro0fHBFdKIqT4mj34I0wevdzyltrXChjVk9v?=
 =?us-ascii?Q?ZwGN/2MVkF+BMRDn6Ocun4NuoKeTUTZNhZ1JDryDcLLz0EXGIH9m877YeaQk?=
 =?us-ascii?Q?ED6pwauICsbub7cz70K9sdGit4SDTA916Nua8Cj+GOmwD6anCZu54i0c+CmG?=
 =?us-ascii?Q?cwNJ7bNEBMKFotsXQK0LB/74ipZSp3VgRPvTLRqTwU1/KF/4zG9upWF5BkSt?=
 =?us-ascii?Q?a6Vo2YKbsYSF1RgW92FizmECc4lSGcl0YOj01WxEmu5c3fDE+t3lylYr2Krp?=
 =?us-ascii?Q?ehBa2CIQvtcnKFnl0EIN0g0R1yi/Q4DN2k60EeO0B39Mer49nXr3slt6TGco?=
 =?us-ascii?Q?OjRvH3Rwb8uydaxYmtUXK26DnwagaGrN6QVxPoSTBQwJHfeQAH4rJsyjDPuP?=
 =?us-ascii?Q?YXxnmhI7XutB5wnZQgoJRvADkOuhaBLFm4ubklMIx+KllIa6OGdaEmYxtlz0?=
 =?us-ascii?Q?gxN5xjSpC6GdnIWu0VtDYeGyJRjhynoIqiMLN/Oq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(14060799003)(36860700013)(35042699022)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1715
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.86.3];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.86.3];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	feabe6da-fdf2-4e54-22e9-08de2dcd77fe
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|156008|1800799024|35042699022|82310400026|36860700013|34020700016|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RumcFGfcAd9pltqgJ/oZhdV6c6agpT8JFZzW9WaNhCxTLvgzhj2I72eNTPa6?=
 =?us-ascii?Q?asSjtWNtOztTVwjkwGN6EUDrBiHpD1ae53sowCdzG7pfesblZXnv6vUBxpZd?=
 =?us-ascii?Q?RoWdutWVP/fklIrDV2Y5yQa5poY9dU54MZ5oKWlWoZB5+uhBlwkwZKF38EWU?=
 =?us-ascii?Q?eccQg53iY821jVQm4PxAuXc0d7qcweFKR95imxdtFlChU2uU3rpzaCDopxuk?=
 =?us-ascii?Q?ozOqddKDRBjnqo+ij4tCU4y5xROBwwF4aJVgkN+K12BCkpm4BqcSvpP0rak5?=
 =?us-ascii?Q?3KrGSX7W7iWaJxdCG38gXVF9fnWMp64o/dMkBYaEli1RmCiUmCnJJMbIBQaX?=
 =?us-ascii?Q?2E1XmAKgfRQHGXDgJ5KtmSDt0wl3Ym38ocPEySwQrvmU/6aECEpKdFeYU4WC?=
 =?us-ascii?Q?hmquPxAeIATdHeUv56N26sF/ijU9iAEx9y3wjIZSVs2gVlnBaCPY/tT09/ug?=
 =?us-ascii?Q?oZETvT6RPqorzcZNX6zmsVIjWxlAt1eXX1D4DWvUsXk0cGRuuS6eUAgs1FpW?=
 =?us-ascii?Q?10owD69msmIBHneqE3zctCUcyB90Ci5v/lkFBthM7FUhb/JWnvv3sB2YyS+g?=
 =?us-ascii?Q?qV6XvFodY5FaHRh2LmM/ESuezIUPkVds8e+4xJMvu5OIfQ83ox4bFR/N7lXf?=
 =?us-ascii?Q?37G6jye+eygw2vh7r2SqhtjFdLIJlEdok1WCoTfq+QYL15O6UywDmV7x+oKy?=
 =?us-ascii?Q?l+A3aDYTykIk9rqTdl00tlSa6/RRl6jl3vl8jERoUots9TUk6z/xv275wEX+?=
 =?us-ascii?Q?aP/Ap00JVzExAxDaAzBzzjlFrj/qVIn3/wofHxBT/3BfUcXTnPdXa1S2Uv38?=
 =?us-ascii?Q?Ng5SwZe8GRFdtT2/7HWPllwq3E/AVVUPbG67dpUu8EKyIXvWLvIguKk67ys/?=
 =?us-ascii?Q?KeR0UcTgwT7YeNoJqEt7NOThlmmZYyJILAR6mm73rz6MUSkxWDpuy9LJbnWl?=
 =?us-ascii?Q?vYfXU2a5oNRbHgadKWr3v9O5LM8ORSeSsv3KHEcJuf6RX5lb3M5YMUJB9m5+?=
 =?us-ascii?Q?fOkBXBN/RsDRBojLAKn4s/f1gyHAql1XCBsgNQtCmzxObgngTurj7TM+1Bls?=
 =?us-ascii?Q?4Msk4iTYl9c0MuCv5muIOGqd0Pk968T6AxkWdbAwhfP8ykzm8qO4992lMHGS?=
 =?us-ascii?Q?Xwukdm2dTrdYAbtzfReKVj9qRgzlmeWkVkusz8PzHRfpKIC/TnLyJUo=3D?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandwestazlp17010003.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(156008)(1800799024)(35042699022)(82310400026)(36860700013)(34020700016)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 15:56:12.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d45a0c-e3e9-488b-6a2c-08de2dcd7d52
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0881

mcb bus is not prepared to autoload client drivers with the data defined on
the drivers' MODULE_DEVICE_TABLE. modpost cannot access to mcb_table_id
inside MODULE_DEVICE_TABLE so the data declared inside is ignored.

Add modpost build support for accessing to the mcb_table_id coded on device
drivers' MODULE_DEVICE_TABLE.

Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@dua=
gon.com>
---
 scripts/mod/devicetable-offsets.c | 3 +++
 scripts/mod/file2alias.c          | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-of=
fsets.c
index d3d00e85edf7..8e89d07a9337 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -209,6 +209,9 @@ int main(void)
 	DEVID_FIELD(rio_device_id, asm_did);
 	DEVID_FIELD(rio_device_id, asm_vid);
=20
+	DEVID(mcb_device_id);
+	DEVID_FIELD(mcb_device_id, device);
+
 	DEVID(ulpi_device_id);
 	DEVID_FIELD(ulpi_device_id, vendor);
 	DEVID_FIELD(ulpi_device_id, product);
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b3333560b95e..f02dfc186730 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1144,6 +1144,14 @@ static void do_rio_entry(struct module *mod, void *s=
ymval)
 	module_alias_printf(mod, true, "rapidio:%s", alias);
 }
=20
+/* Looks like: mcb:16zN */
+static void do_mcb_entry(struct module *mod, void *symval)
+{
+	DEF_FIELD(symval, mcb_device_id, device);
+
+	module_alias_printf(mod, false, "mcb:16z%03d", device);
+}
+
 /* Looks like: ulpi:vNpN */
 static void do_ulpi_entry(struct module *mod, void *symval)
 {
@@ -1446,6 +1454,7 @@ static const struct devtable devtable[] =3D {
 	{"cpu", SIZE_cpu_feature, do_cpu_entry},
 	{"mei", SIZE_mei_cl_device_id, do_mei_entry},
 	{"rapidio", SIZE_rio_device_id, do_rio_entry},
+	{"mcb", SIZE_mcb_device_id, do_mcb_entry},
 	{"ulpi", SIZE_ulpi_device_id, do_ulpi_entry},
 	{"hdaudio", SIZE_hda_device_id, do_hda_entry},
 	{"sdw", SIZE_sdw_device_id, do_sdw_entry},
--=20
2.51.1

