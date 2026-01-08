Return-Path: <linux-iio+bounces-27555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F724D032CF
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 616A73007644
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2D482CF3;
	Thu,  8 Jan 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="GconySHc"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021092.outbound.protection.outlook.com [40.107.167.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21347D93A;
	Thu,  8 Jan 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880407; cv=fail; b=U2w/9twpCSuMbIx3aFA5+2A6kQFiyKO7d2yaiSWehzBH8xT0j8/0iZDXAn+SBpLQTTkRqzeJaKc2u7dpGnyNNRcAQRVFkH4sfUx0pjkVEtbBJtV9JfJh4Bqx9uBKacM9binFsUpWKpr4n10laSPhLblMGDXwCgLMxrHPCJ//0q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880407; c=relaxed/simple;
	bh=Wu2mzgDxqvnxkmyH0b/M/XwgWKT/ANrn+5kB0TeXLz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajClF/T+s809cwebVfOV5QXYJIUhEC4GS0h1ksSpE4VCxmp7VuAUQxjRuPtPvkeKuZv9d84+TmQ2Ajef4PmJnDJfTXN5efsYhq454m772Dfo9CSxoULu9lZmGW3cbCvoifZa0YPJyQbG7u7onEQCJ0Af/IArwP5+ZV/64aaiHHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=GconySHc; arc=fail smtp.client-ip=40.107.167.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxpjMSw7JqHl49RBeByDvJjK9VIHqnrWDK6QjLes/gbxPcIptZkq77Ev/YHKYZT0CjiKdbYM6/SzHnQdUFbl5FFh/VM0QQPYWSnFxId9SBZoNS/p+iwmhyiHwZisGR26+rvm1ggmiwUxjeXEvxMdGDOCWtmpyTyZqQqGpYf8AtkahRJ7W4SjhsDMa86++c87x4Zvl8ikOiKnd+FkW1khFLtwG2ZxfAOCsEhqO830UbTjyeL2kpufDsmGBv+NyXyo3ksY9cETfFsOowWjz4y9JYqRzIAHSEWB+Xfy+tVOKX6qcTubsYgaUcp9xBlO/IPhK/dXEUW+dIoFX1N6CHh1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu2mzgDxqvnxkmyH0b/M/XwgWKT/ANrn+5kB0TeXLz4=;
 b=jHMht5F4n64BGsWVgQ3yha4JDW/p9XXo9WZyCMM7uQdXkM0RDxz/kQUNTjpl1zaqUDbpuXpL74G8g4c5Jf6mbOU9K5OZHQHnKE3/FuXe93qGLm2Ui+mGtwkIThvV3SRcl+yBJjuQfk3nelQnogKMiaXaZ+MEfFsQ4uGNxYKS3T00ocBvrKX+L7k2Va+sOpHK1Dq3k9yo18iFS0eYVWrcL7ymN8JZWFpQu7Q6tDO+vpGQYRyXASikngRwsg5Kl1pCv7twC0/QdCCwyqoMFMP0MMXXyt9iSlh08VefevaegT+Hqw5MAak1g3LL+JTAXcoCOPhDDqOP4ZCc71AbTARTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.86.3) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu2mzgDxqvnxkmyH0b/M/XwgWKT/ANrn+5kB0TeXLz4=;
 b=GconySHcIBbFgjoam5IQgkmTdv70xZ5xNEdO+hZnC3q8XISf+FnQskW6OC2GgflUBw5VFiVpT5Z/8kjH/mlFE5FDkZY/Q4ZMPpF6csdgU8ciFgJFMm575xdgd1zlExILwLAABgfNLKkjrdNPzGw4CI8fJdR2KIGdfEtoBRhLy+Y=
Received: from DB7PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:10:36::35)
 by GV0P278MB1581.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:53:21 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::2f) by DB7PR05CA0022.outlook.office365.com
 (2603:10a6:10:36::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.86.3)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.86.3 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.86.3; helo=GVAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (2603:10a6:18:3::106) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:53:20 +0000
Received: from hz-glue06.de.seppmail.cloud (unknown [10.11.0.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5w00F7Kz11FP;
	Thu,  8 Jan 2026 14:53:20 +0100 (CET)
Received: from hz-glue06.de.seppmail.cloud (unknown [172.18.0.3])
	by hz-glue06.de.seppmail.cloud (Postfix) with SMTP id 4dn5w00377z1yNj;
	Thu,  8 Jan 2026 14:53:20 +0100 (CET)
X-SEPP-Suspect: ddc9d18e4d7c4b61a9af18de58583ac1
Received: from hz-scan08.de.seppmail.cloud (unknown [10.11.0.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue04.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5vz6gNgz23Bw;
	Thu,  8 Jan 2026 14:53:19 +0100 (CET)
Received: from hz-scan08 (localhost [127.0.0.1])
	by hz-scan08.de.seppmail.cloud (Postfix) with SMTP id 4dn5vz67dqz2kCC;
	Thu, 08 Jan 2026 14:53:19 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan08.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 08 Jan 2026 14:53:18 +0100 (CET)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010003.outbound.protection.outlook.com [40.93.86.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5vx3mS2z1xfl;
	Thu,  8 Jan 2026 14:53:17 +0100 (CET)
Received: from AS9PR06CA0548.eurprd06.prod.outlook.com (2603:10a6:20b:485::24)
 by ZR3P278MB1369.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:53:14 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:485:cafe::15) by AS9PR06CA0548.outlook.office365.com
 (2603:10a6:20b:485::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:53:14 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.50) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 08 Jan 2026 13:53:13 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR0P278MB1672.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Thu, 8 Jan 2026 13:53:12 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:53:12 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com
CC: andriy.shevchenko@intel.com,
	dev-jorge.sanjuangarcia@duagon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH v2 1/1] iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
Date: Thu, 8 Jan 2026 14:53:01 +0100
Message-ID: <20260108135301.26448-2-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108135301.26448-1-dev-josejavier.rodriguez@duagon.com>
References: <20260108135301.26448-1-dev-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA3P292CA0063.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::10) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR0P278MB1672:EE_|AM1PEPF000252DE:EE_|ZR3P278MB1369:EE_|DU2PEPF0001E9C1:EE_|GV0P278MB1581:EE_
X-MS-Office365-Filtering-Correlation-Id: 424edd8b-1a08-455d-51ba-08de4ebd489a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?FP7i6TZWVjrND0l0itYSBL+vzyI8E3lUz/FVMRydfRtKn5jfIsaHQ9A/gHBi?=
 =?us-ascii?Q?8ZiGqeiEEiGC2QkreTVeOdSwfAaDb8NoTdDX+HdMHWYCADjDVQMlHGRd3eOG?=
 =?us-ascii?Q?EwA/yB0FIxBSVqCtl4kd+kyBUSAwh6XRhVEqZ3Mxg0JVYU5QAqHCctCX9xpx?=
 =?us-ascii?Q?Mk6IbpwD8q1U6TpDrfMUMGDwmrhAEBAFY4zj9m9vDetjrM6s8XZt5Z18skgv?=
 =?us-ascii?Q?AAOi4vt8c3sCidGUPKZX4Lh2J9OckXPXdkti59A97Fi7//YDPbwfMf4fbREE?=
 =?us-ascii?Q?JvO+IZPJIb6dPkgJgU2py1EWYXlSeyUzqb5XIEAQjr2Ys6WJOEGqAY6KyrKY?=
 =?us-ascii?Q?EITZ0Vpf6SSC+zhEjOsT2GxGK34jwAAYbExJDHjORUGnYrqRc3y6pBFiZVse?=
 =?us-ascii?Q?87IbQfEcpYgjbL3A7xD2ISJMi6Bh2kTqb5L9Rq1bElCvYEYCP/FV4PmJzI+S?=
 =?us-ascii?Q?kdSSfWwOsLgpJh42ioFUUMwpqGTswGQZOAOA5Hzk4diKIU4VX83hROroq21V?=
 =?us-ascii?Q?sb7/lQKEUnlVaOrYN6K0t6kQqAZ6NKZXTgqUhPIaCn4OYf2jSdiBucy2AVoI?=
 =?us-ascii?Q?yALlEnp1qEBYDIQUH7gKcmzR2quZ9dJacdfJqhWRS573IzrPiWZb1jNhVD6g?=
 =?us-ascii?Q?VpqPSMMKw4RxVKcT1dgkh9HkwF0aLDVyjgX5PdQJ3FNDBwsGgRLk+YJtWOBl?=
 =?us-ascii?Q?OHgh44GV7yATrLV9XM6M+puYfWdhkaCNx/axFLuHPlkJGIzYrxTjLXMlps+l?=
 =?us-ascii?Q?PQV2Q/qg0ao2xwsbnFh9SxWYZPHWLDdAs6MilHWjFNfoQTpdLhcOuk3QUhV3?=
 =?us-ascii?Q?xbTjdEVq0MschOQGKEZiyYjyoxGJcmNOw0pJ7dvixyltXl4+9+d8FRquaHYR?=
 =?us-ascii?Q?ESFDh2oTqpmsSmpf24xVRxq8R/aCy8TQu/zfbjWqDeUP27WKh/nIudEjRGrU?=
 =?us-ascii?Q?zFvb/NaDBL0GlzuzrkIhGrsBMoTlfeZw4knD5CwGI2N89ixL24VFebBMg98Q?=
 =?us-ascii?Q?c8VIhqcOOoKTurJ8r33zNsHjgnODub8IhtxcN1jCWVlDQQ8pMEVKEtfn4A0Y?=
 =?us-ascii?Q?cFsJzJde2CaH4cYNJxivwdrW+tKGbfY7QY5mFaYONXgrZ4yDHY5CLxi8rvjr?=
 =?us-ascii?Q?Au1jlysbjPW/qsfTYD/+KuE3KRHM5WrefYR4/GvQd8fwzV6+V/BkcvdyYRFJ?=
 =?us-ascii?Q?50j3hNeHCQVgoLyfYPlv010IG/PZ/Y+DrkFCSTy9jXZzx0zf0FaqV2pdylSQ?=
 =?us-ascii?Q?dzeWI/aweDqoHanhMtHrohmIae8pSqkS78Omi3ZLZ+t8luUMJ1zPfXGezMCL?=
 =?us-ascii?Q?1QUUq/5l8DyFQt61MQtjNyGDcT06BpVXf3GK1qvIGaOfjqNy3w5hg8YqdL9K?=
 =?us-ascii?Q?lP7Mgl2XmRBIB1CojRXFExk3aiXhkKnR1yqWAZi8efYhZINgXT9J6u7csFXv?=
 =?us-ascii?Q?GfUMYefk5ucbahg4hhoLbsYZYLMADjwuqQ3xZ4X25NTgmSdunMP+9scRgnmG?=
 =?us-ascii?Q?crL3oHL3sYGHbw3yIqNaanLbF7L9rwyMP59u?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1672
X-CodeTwo-MessageID: 5417f73b-9a19-43b8-a3e3-9a93a115eb40.20260108135313@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 b0f9aee4-69de-46cd-ef7f-08de4ebd43d0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ydo91mSkdf+4xp+pTH9LXHT+hU1eIWndB67AimzGHzzSLTi1xGkyGT2CNo56?=
 =?us-ascii?Q?qa14s+y+/hoPgSNf+3ZUuAA60m5eND/6FMTm4CO5NSHZawbnIQ86xEaYgM41?=
 =?us-ascii?Q?FbS3t3KVE8vdCBdFtKd3svUsHa/4ruiaVNGEWJaRl5yGhjU9x5zkLKQTUrwp?=
 =?us-ascii?Q?fJvYmqPhfPkq+j0CuWTKtbwzc+ZWyAq8tX5k/OtlnntfBkg7HIzmRTNupOqb?=
 =?us-ascii?Q?tsSPEGWX5gb6900CPD3yU3pjBWCiwtNPmghb29kbaks1dW+a0mpY3CM/yM/3?=
 =?us-ascii?Q?C/EB7NX8XuneynoiQPBNMIV3+f85UNNtBrk71NjXbRFagiiq7GR+Rnvjt0Ko?=
 =?us-ascii?Q?cYuLPOCevqSU3E0pKMw3medCr1ERj48CoN+81Zs03/BRvg1bOnpHK/9qXO54?=
 =?us-ascii?Q?+qY0eDb+6PDg+TWFfzH3ft6hJCrbmX7IH+Aa0uwy1yFs1fH8G0l6NepzqlpA?=
 =?us-ascii?Q?4bjHTWdpIyS7FeEhWiXK1dN0UABajlmW1PyMwBjmVvySY+NVujNOvpLIxYdW?=
 =?us-ascii?Q?rv84xZjF54BU6EfrK8wV+reA3wP0N9z4eHcwWMQ+6DCxrVfaIoTExWxS0z90?=
 =?us-ascii?Q?J2PyyqxEHq0GZC6d02fEbhqUvU+B49lawhm6OW6EZ+isTg2TT24bNsjYO02D?=
 =?us-ascii?Q?sWdVBGTDuYKlJTFKmEOLr2O+4A0flwNA16NljVd3OUiWBOPdeoMI5unBhqqW?=
 =?us-ascii?Q?AFHUqBXLMFtsBSbbZz/JZ7FSfgxf7VrK88QWIxVzjeqwDX2M9Rb932kWhKF3?=
 =?us-ascii?Q?WLRXjEcRygZ8w7YAciK5VAUmUXqiJ4I0apIR9KeBKb3pDD5lz3gdSFR/7DTT?=
 =?us-ascii?Q?nYvFDAhioRMC9Db+XUF3rcY/OBQPTPBHHVF7NvAaeAf4WQp4mQddnfVJeuPv?=
 =?us-ascii?Q?tToReQ4ysRuWq6Sc9YGAcwtlM2S2STL7yW3xFYVk3s2T90naRCVcjwuCBxQu?=
 =?us-ascii?Q?xiJFkmAnM5jlO/TWhAPEePU31kOcXf/fr6HOux8UAkXYcFzkc8J+5vf96zJv?=
 =?us-ascii?Q?QaRVK+E+fBLwIn+ZtNXGKP6IKBWSqqJSv5lLywVf1QePFdUqH2nb1K8tfpvE?=
 =?us-ascii?Q?y0fecNJXj+9kaxGEhPmWd9hxGV0pI3pI6Au4FBWNiGW3k0932YNF0QzNzZym?=
 =?us-ascii?Q?cK7oHQsbYAKSXocDhmkhlnzRV8OmSnSSlqWen8ZlEgzDUJn+qd1C8VhmSnLj?=
 =?us-ascii?Q?vlb5VylqWlaDOluVCP5w8D6qUWhTBdiHlrBY1WkV5qBIdKSPLiiX4N/m5LAG?=
 =?us-ascii?Q?UKTIJBy2mlyJciUOJ61vd0/QReiSN7oOZrTMJ56Er5G6DlJJpCLILk+s3pWE?=
 =?us-ascii?Q?oQCEY+hhCEfre/UIBhEv6n6869oWaYsiOL0OsUC7U226MeRMjGPQiWYPsmaJ?=
 =?us-ascii?Q?u7A+WDTvJM1aiixBPxIpHKBYxjC9uz8yV6HA7fcavwez5EfmGWkl4QYelSbs?=
 =?us-ascii?Q?dH79/+Xu3qwYH1Ezt6VqYEzYKht63w2zyYrruxDjrWKFfKCThBIzgq+dDSip?=
 =?us-ascii?Q?a5AC11YXYo7FMG1k0nYP3Wts3zcJpJ4NeeHvAfsP5YluW93TaerIH/RkIya9?=
 =?us-ascii?Q?yeO5EeuRF7bEbhb7yQI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(35042699022)(14060799003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1369
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.86.3];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.86.3];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5a960c85-aebf-476c-f150-08de4ebd44f5
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|82310400026|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ReI5LA6jdPiv3P04IuUMU7CYZBtMaDYuVa/i4U0cgzkNlJeFwXGuV5MpBJFv?=
 =?us-ascii?Q?Q/9EcRc9Ksk22IdTDMES4FfVTRgX+Xr3ookvg/MCV/SUT5rEbnwkDk7se4s3?=
 =?us-ascii?Q?T6A0QUNOXlON0ASlKx4+/SWfoSn/bKT7Zsk8tKwZOS12bpl8XdQ5DOVmpAWY?=
 =?us-ascii?Q?y4H1LTvBpRksv0SLuQjBQYsqJXse+x3PIR4zhgcCol1NF58EWZzx/skZHH6O?=
 =?us-ascii?Q?VGjT/lYahiBAWOC2sVg6VAQu5ynt3Z+TTR7H9XoFgYuHwHjXOayD5+4KsQuU?=
 =?us-ascii?Q?u2sCD8ji7eyt0NTqmTyxQlhAOsMapUxxpujT33c1sk+hUsTQxvXSoGge43SD?=
 =?us-ascii?Q?rCskqRvSwErj4BnS5pLjAs9Go9wALiLgnk+Bwfcg5eVd1NNfgPFzC5Dkmo6L?=
 =?us-ascii?Q?AJ8oELg3ubQN9I7Yg4khqghXCot095jj05DJKbJ0d4BoDYz/RMbVXEx9/pH+?=
 =?us-ascii?Q?6Oerdru11O535OHTRgDk6st8/V4IaVGpQHx8mJuiiJAvihXhpNq5wAUwprud?=
 =?us-ascii?Q?NwsNF1oYDMWhX072sCdv0KXdBERofdd1zwQv/ghA9C6R06li/1KtrPB++/fw?=
 =?us-ascii?Q?D5y7bxoI1uDFD6YoekTLMr/IWfRUeXALp7ur7O7jXjR4UYGy0wBWsEhLGzPG?=
 =?us-ascii?Q?ULfTyQIntShAQBhvoiUrmuTKjIsOqI60CLn+bH9ez882DQoX/hq3ulWdhIAL?=
 =?us-ascii?Q?qxS0mE6wxhBhsn2GEQStcJ/OMH17bewckW4gBzNl41w7LQsyqsSA97dWlwmh?=
 =?us-ascii?Q?pFvsDX+wxJ5DGlvfvHjXV6t5LgRI/YeCbWaVN7cGiDtFP3+9kc6Ukr6OM7dc?=
 =?us-ascii?Q?1l86eP85iXh7HDDKA/311Qn0gys2P21uez04tSVBXPq2U0Y3yHw91b8AqYMh?=
 =?us-ascii?Q?nZgBPwU7LtddXkH6e5oZVcOxAa6NoOvI7TDbp0A5+rP/2hgx/04yedYJS4+8?=
 =?us-ascii?Q?l1gFycWfb993m7r7XaXg8kK6gjtGg8+GGZHgWjX1VQ5u2QPU5zQ38Jh7o4//?=
 =?us-ascii?Q?PxttTGYFZY0MC3dn4IwFGaGM5LRL4jZufdJgLPMU7Z0LDQLjJ0/H7Dwdqr+L?=
 =?us-ascii?Q?MyQJTtVCj9h4gNLJ2lQjpxTlZltQKi+AWg8TsbyEbe5yJ0cWgsFYV/+c3O0Q?=
 =?us-ascii?Q?FSPu5v9e2uan?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandwestazlp17010003.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(82310400026)(35042699022)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:53:20.5694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424edd8b-1a08-455d-51ba-08de4ebd489a
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1581

Since commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
the MODULE_ALIAS() is redundant as the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@dua=
gon.com>
---
 drivers/iio/adc/men_z188_adc.c | 1 -
 1 file changed, 1 deletion(-)

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
--=20
2.52.0

