Return-Path: <linux-iio+bounces-26518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB60C8F63B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD60E3489F6
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B7337681;
	Thu, 27 Nov 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="BmlDa2sc"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazhn15011022.outbound.protection.outlook.com [52.102.183.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114033711A;
	Thu, 27 Nov 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.183.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258981; cv=fail; b=pz9Vas7RLWqV9mJnkAN37DukGD1OVLxZOF4vFwV0WMvxels7HdKrRsFH6AAf+wsHQX04b1CVjFdva0QHvzqFrid9h1R4sAMEtd3JqmMbJSZ4Ypg9DB2QtYOUi9gAtO7TH6ts6JrHEUdHeau+3D5ZfL8J1db6OdahIXQ1Uw2f5ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258981; c=relaxed/simple;
	bh=J0+iuoYfbvmh3T6t/Bh+EoSNsDFffCahKO3VlOmGo3E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mtBkCwVghAq2cK969GV8xrzGUfNGZuT0ouoy1RKpXb7WOPL091R2JVdHeOHG6laXKm/3CypjxpgeDNWdtijkmG1PvaxK1HYkGoonbB4Yo5ctE4CNETx0vBtX2K4V7rTcSg9tFWFtUqlwo9CZbD4hf3b9DqHDwtS0Ui+au261VWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=BmlDa2sc; arc=fail smtp.client-ip=52.102.183.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7WEaPM0EmdXt3wkcHHp9FcAC8RIJ/KHgD5yPhDhBWDjPy+OPZUdhAvyqLlMXg7jxQoIk22+Q8lnK6vpF5K5HRcV9vtc9UnxHK+wAAlkVYNYtfz5sWHFwOY0gTDlsk44t2X4TnRQXlxKZMIyPh6TByZIl0ImN93oaIbQT1G/rO8BN1tIYvkLfSTeuDYzSfQIIxIxDz4blom3LGyG+ZeKZ5Ga/FJpD9PqyM/aV7u/mbL0cf5CaqAbUre3SQhly7bVlDx4NakCfCDb7fDHw4DD4TnBHWx4xTNZ0LWPHRgN60cJ8l9FthZxUxx0OPQ0PcvWfXdznIXsEDC6GYTj9LUDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cq60AoK5U2717U6AWSxdHPeLxAVFFHkd/ugNWTRKUs=;
 b=DOAJx56IPcRPsibmSA1kCSoUilIjVsyZaKud9zm51GM+kTaokEAUXuJXOQ067M8e9egGjBEUh8ZjSsUoB2OVj47eORAiXaI/4PbtG9983omZtbchFIVO7k7J4qrVLcPFL2Z4nDLthqNATdThCkpQiYJ0ulWAbkMU4xcbP8bfbI9I5FZjLk4DPnfktSh1Rzs/0HDk9kxRfKByWCkjJXDgOKjVAZ6mgrI+MOqBHSKzAp1VN1E+ycPdbaVSDTnp4evWoMdheXZRDsdo35nIYRz2Mtju1sn0AoJJbFgt8vKkRdX58GNNhgRf0P099LfVz3W+lYi7W3F29T29Yd4ynEK9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.86.4) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cq60AoK5U2717U6AWSxdHPeLxAVFFHkd/ugNWTRKUs=;
 b=BmlDa2sczoF9TIbHt3zsaFps5etaJuw3UDYxjxCZMaU9JOnrRxTuS73MP2H6eSbW19Sp4R93m/EXEjwTn5jQpCx9xCow/GLMx3+wn/jiInFnJYezfurPFhiva6tI+QJpUI/e5U6/MwwaduumSOAqrM693GkBhOL3B10/2aPsn8g=
Received: from DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) by ZRZP278MB1790.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 15:56:14 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::61) by DUZPR01CA0036.outlook.office365.com
 (2603:10a6:10:468::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 15:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.86.4)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.86.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.86.4; helo=GVAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver01.de.seppmail.cloud (2a01:4f8:a0:900b::219) by
 DB1PEPF000509EF.mail.protection.outlook.com (2603:10a6:18:3::629) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 15:56:08 +0000
Received: from hz-glue05.de.seppmail.cloud (unknown [10.11.0.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLd41nWvz4wwq;
	Thu, 27 Nov 2025 16:56:08 +0100 (CET)
Received: from hz-glue05.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue05.de.seppmail.cloud (Postfix) with SMTP id 4dHLd41NXwz1yPB;
	Thu, 27 Nov 2025 16:56:08 +0100 (CET)
X-SEPP-Suspect: 1a2a149948974ce7889ef4d8e95fe5d3
Received: from hz-scan05.de.seppmail.cloud (unknown [10.11.0.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue01.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLd40h9Vz1vkR;
	Thu, 27 Nov 2025 16:56:08 +0100 (CET)
Received: from hz-scan05 (localhost [127.0.0.1])
	by hz-scan05.de.seppmail.cloud (Postfix) with SMTP id 4dHLd375TXz8mlM;
	Thu, 27 Nov 2025 16:56:07 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan05.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 27 Nov 2025 16:56:06 +0100 (CET)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010004.outbound.protection.outlook.com [40.93.86.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4dHLcz1lc2z1w0b;
	Thu, 27 Nov 2025 16:56:03 +0100 (CET)
Received: from DU2PR04CA0326.eurprd04.prod.outlook.com (2603:10a6:10:2b5::31)
 by ZR1P278MB1311.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 15:56:00 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::54) by DU2PR04CA0326.outlook.office365.com
 (2603:10a6:10:2b5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Thu,
 27 Nov 2025 15:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 15:55:59 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.27) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 27 Nov 2025 15:55:59 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR3P278MB1712.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Thu, 27 Nov 2025 15:55:56 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 15:55:56 +0000
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
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH 0/2] mcb: Add modpost support for processing MODULE_DEVICE_TABLE
Date: Thu, 27 Nov 2025 16:54:50 +0100
Message-ID: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.51.1
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
	ZR0P278MB0523:EE_|ZR3P278MB1712:EE_|DB5PEPF00014B9B:EE_|ZR1P278MB1311:EE_|DB1PEPF000509EF:EE_|ZRZP278MB1790:EE_
X-MS-Office365-Filtering-Correlation-Id: 493695d0-2290-4a39-4f58-08de2dcd7b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Lrd35Dbp1INiSehYT0+9K+o2VuPsQFAfxutui1ChVH32II+U+KrcH8zRAppb?=
 =?us-ascii?Q?NSASvRYPR20YRJE7asPL6GGmqhnW3f7+o1Jp5AKRxR1mKHY7Wy0lN7wVt6TX?=
 =?us-ascii?Q?gmLjfMSNL7CVIXn8RxSfTfuFJxaaVEzBYAc75ph7zUPlAX1LrscCB/41IFs7?=
 =?us-ascii?Q?prv+5RiJm61EqzJWmGAuMYY7hTJ+UGHeYuIfTS1rXWZ3TWRQJCacxBlyGCE2?=
 =?us-ascii?Q?zXK/Zxk/1Xs8qCkTupj52J3RkGb1HZbrYCYzQy+l8gKQBvXmG6Xf4Q2EIqo4?=
 =?us-ascii?Q?aB6n1HYdmk/eyrgHOjEMUWU3xltxE3Nc9QYK65QlyNVqDje5smqXx7W99Tsn?=
 =?us-ascii?Q?jO31RLTiBCIE5xRV9/xhQWCglDmH/iGUz9qVKkxFRs+v4XttUPBKlN+ya3+N?=
 =?us-ascii?Q?VXNrW3IxhaC4MB0G4eHdKcaIZsBZqZ/3SxOPolFRk1KubUPY0UhkCslGJv7R?=
 =?us-ascii?Q?C6iLKcNX0lIcIYB2+DLYg+8InTIooEl7Vs3uT5v0MEjPruTddJ7AaLJ7XACf?=
 =?us-ascii?Q?cS/vZuRaLkfo859kNSJ65cXShXb76kqtgdL5mlyIVZkHOr2RR5RBZbejq/xQ?=
 =?us-ascii?Q?tcZnIRUJGWYZk81Kol+hZk2yvCXQQxr0yuTw5X9LGtfc1/jxKFJg0u35jF5A?=
 =?us-ascii?Q?psMBhiUEb12pyuc9NCjhVS0ig0OF36PMGot1Ja/mfkKNIIPHE6Vp/HdRyz7e?=
 =?us-ascii?Q?cktVIR5ey5hrwNtX2gMhqv8n3fDortP1bPTMMB5FPuNAeKM4git38cnLj4Bg?=
 =?us-ascii?Q?bb/cBgrLhNKAZNcU36IOfo2afZuRKV6Zv1c37TZHwzXe0fOM11wlTxviBhej?=
 =?us-ascii?Q?QdDTmahxYhxv0d3MQWD32bnK0AfccshG2MKmodwnM5D8U253VARyVqw19nEQ?=
 =?us-ascii?Q?22EA1Ud44K9jwNShO02JSRX0TFZbdWc8GbxTAi8QosDXOXZgGRpaoKA7jR9x?=
 =?us-ascii?Q?UUo+akwHIavt/hy38mWQkZd4gyk2EIWsTNYXSes8bkiAZ8jezozeAWeo/ZJQ?=
 =?us-ascii?Q?PDZAOaVbcTJFXFlSM9vEZ8orLJOqDJDScEnFPKFLmee6pTyMv9/u+uGdZnu1?=
 =?us-ascii?Q?T8e3rbdFolftsBYn92j/Y4Fxnq3bbsfPcHDFOcrBj40dfx8Lc5Liu2UPaVnp?=
 =?us-ascii?Q?hRWHFcq9IwPDnVmpg+1wKXiCktVAXhsJCme8LZtGYuIIvdnlj0sTD/SCuBhS?=
 =?us-ascii?Q?6o1N06L6to/ujSurJ/qmZBIwvinOxgUxphWgVmsEOm6IqWgZJ+R7H07Z/Zkg?=
 =?us-ascii?Q?Cvzr740pb2RIm4eVJVgrqLgcc7DBiPzbZRw2juA+E9DrG/vHKPxdv5Nd7Vd6?=
 =?us-ascii?Q?ccHJt2rv43Xzo6sFBPFfsDQa8nZGGZ9mNGJ5gbK7RHr/I3EtmROiU0j612QT?=
 =?us-ascii?Q?5EdIzF4Ee40RzahKZUINAFD/nK7PBQop3CVkQPohj+dcjrr2OErA8NmpWyxR?=
 =?us-ascii?Q?4g2oB87S3nGdSuY7PdIa5VXLQtOWpcPWfQUyZs8P7RGBqTyiTCz0Ode6eSIX?=
 =?us-ascii?Q?XjMsaJ4YC8JgCEwhc4sPkV1Shf6K/wNNDNl234Ts35Yw4cianwSCGDW8Ng?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1712
X-CodeTwo-MessageID: 6715bcc0-f1be-4db0-8442-25b9585bb3e0.20251127155559@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 ed4f6889-da84-401d-e487-08de2dcd733b
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|14060799003|376014|36860700013|7416014|82310400026|35042699022|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?g2lnCb/3lK/3sEEydUo/L5R83aGuM04uBpJ4UQ9pT4WLtsGF0OYuAyRZvv6C?=
 =?us-ascii?Q?J+VP9vYVd7P8sf1G+1OjKlGNgrAI1yxqSevsqREx8SjxwJn+0wU22zP61G2z?=
 =?us-ascii?Q?Pq5U+Jz/WP2cbRlh4wQ0hwVC9SZ1paFyoacksyqFqtUGBs6JB2+36Dgdz+Zr?=
 =?us-ascii?Q?STsRUmWym6+tDueSzROXJQq5z+UpmRWFYR+itXuDiPlxc605HFGGcMlNlNbl?=
 =?us-ascii?Q?RGmL/ukuZ9fNW84vzTGQsxk0AnZtAre/ZMlMqt2M6hMZTJEwNurFBvN+5P1s?=
 =?us-ascii?Q?MUzCnrxM/nytu9Y3R1FGBsDF9KOgRAyCrT2CvkyjCiz5PTjOLiSwYfG4Hj2p?=
 =?us-ascii?Q?seArFL6IdHwICvjd3ZBbpk6i31EfDythNVH7O/R5d4seVv4tjGTef9FHAGw4?=
 =?us-ascii?Q?vLcMcFWsAguSdG9rY9VazPsmSiDCNCZFKOnEegrLiLEQTL2sUxB7Ysul3hVz?=
 =?us-ascii?Q?Zm/o9IfhvGWV8ecHFg1F2+xOnZa+j8fkDr5uz3/vcBnJS6DXq/PWefcQb65M?=
 =?us-ascii?Q?ur/4lpCb6MopWvhEKvFkJfXFgJ5l81Kte4gYhrnrxLuSgJ2wj03DitNcdXGC?=
 =?us-ascii?Q?fwIB8VfMVlouejOI6jQZ2S96XY8Ib4cFezYTiNlqZhSc4KAtF/KEhbIX33nq?=
 =?us-ascii?Q?dmDmr1S6iN+JNJYlUzTmgB1lgiIbpZ8RXKfKCPmsXt8qu2HnPASMcNw871HS?=
 =?us-ascii?Q?G5G9lNxMw5Xg0XY1L9kfI1Nv7O7/joYnrXsRyATETGKrR4UvO4oVKs0OZ+ss?=
 =?us-ascii?Q?uFueHktxdcfYteIyhqaLn385o9+X4NVFHOmYcK6s6PEId+dipr2MvgFKR2oT?=
 =?us-ascii?Q?DI0ABJJOkARhHBC80DMSrMKeyhdcHkYQGMNPrqfOkv1yerJDvNhgW97g2oha?=
 =?us-ascii?Q?2Qpj3UHIIPLDRf+DBFn02x+vfEHk+NQ0POivsxMZSIFifAZCNIHMaf/jqUTJ?=
 =?us-ascii?Q?50bEBKF+XrbT78uEBoQc9j1IJYOhWSFsmndykTK42FqhxPXhiVy7xhsS/2Yy?=
 =?us-ascii?Q?3GkgO8FaeNwHj40e+7OO21NuGVcZpPs5knZiip/EIV3LEuvh6Frm0LaPs/E4?=
 =?us-ascii?Q?b24HSQMFjRxzGLekQSlmmQ9fw9NFZN3TwlBTfP0GQaWFHTQVoghyl2ZRoi2a?=
 =?us-ascii?Q?7r0tydzxmVlfBHrcHDlrhjDfaTt8mv6gm7O9V9jw6d8j1EriCu4pzsJybdSG?=
 =?us-ascii?Q?y7zDL451hweig5ssu7MN57diIz1/+4OnChs3RAE6Oxn8AWXaz1/99Ua9QBFl?=
 =?us-ascii?Q?A8almTgfs/2ikc/Q+UCc6csUMY1ACQ6lKUfcWb5UYTbMGvoHO5+HN/J81XHD?=
 =?us-ascii?Q?9HWFIacMdcZJHhLVouLFWMPzR06ffZgTgkBggnwDmGN1uwBYWwI2QyAfqAzu?=
 =?us-ascii?Q?7MTtyWHpbunVDXtQc51wCLVPhtL7LlNsEkcUzMjXQ4cBxrQ6yXR+9cX5wfEP?=
 =?us-ascii?Q?f0ioAEEzMyXoVS3eWowPa5OpSbUCXY16E8vKk3eNRGJ2SDpOzRNDrZD6c+Sb?=
 =?us-ascii?Q?05cVDVDp58G0wvxMrMz1WEwoMhuH2rjqgCSHtKDk6XtnEURTjvNhRSIS/fBu?=
 =?us-ascii?Q?2qkoxTBDrIQMCFA+eG0FspRNOA3COfZYgNPYvDfZ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(36860700013)(7416014)(82310400026)(35042699022)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1311
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.86.4];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.86.4];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e9405041-2c6d-4424-9af5-08de2dcd7600
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|82310400026|7416014|10070799003|36860700013|376014|34020700016|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hZuqF6MHypqEnR/tn6CwjLSJe8Z+cQZXoH5ddd00aVWhvkg1WGVWMq+1tQd0?=
 =?us-ascii?Q?LOXKkz4pBhhNAnhlDdxB7o/Tr2C5Q0nb5MPsKjWCSWjH2hcG68v4lvl1tyYQ?=
 =?us-ascii?Q?Jeb9/5jqI/wcoamgF3PqmktOS3HhfFRgie+L3pMbLbaRSvZB3dz1lX5nUptp?=
 =?us-ascii?Q?CvzJSjEQd0Rc5IDCq7sz1ws87jYxXYOX/lwTanWQc1i/hP26muIBXFpagxr0?=
 =?us-ascii?Q?aymcb/Vh+ChkjeaEQHjRvihomWcpC98F1W4v5KXunFx/EaeF867j8tO7QQGW?=
 =?us-ascii?Q?RB16foK01QlN2G5jYz95bkBV9UX30LnboesidMKy7/8Zbz4l6CkpV9hda8bE?=
 =?us-ascii?Q?A8f3R3CHdcswsa881VZ97yopFag3O3zSfy0X0pac1fggQwBIPDosHFZO4WfY?=
 =?us-ascii?Q?qr3G6YrUbqIUfj5IZmoLhMqjzVMhPRGZnzumP/s5aRle/bOvuEhZLz8VH5fL?=
 =?us-ascii?Q?9oolQzU7t+IAN6EXmwpMB6UQp4aVBZFX3wlL1BI8uIS6dopD+6wjd+asP1X5?=
 =?us-ascii?Q?k4owzX9Fcq+R6n4A7X75cRCwd0DMAi69e+bKGqeyef/osE60IiQr+dKnbu6N?=
 =?us-ascii?Q?FAc479tXWcEkJOqW/0t2lrKS+PfPZBe7SY8mHvOepkwL9MrmviUbH2PSJ6q7?=
 =?us-ascii?Q?XFYEP3u0UJU3sNSuB7v3DbAwQ/lWn4nUJEfiNSvNsVkOQhDCtvafZIl1LMEt?=
 =?us-ascii?Q?km6z73WqIcfHlJpZEOuwQMtdfXWviUsepK+PpqK28xdK4ZiTlX7VXkqDq3yY?=
 =?us-ascii?Q?sBUevho7dxhg0nGs0sxIwDFFf+xEEmXsiS3b9vpr5fYCbLUDZ99OAsyXhocu?=
 =?us-ascii?Q?mRpZN7Ln3IbKSLK8sc4rIl9U0FOTpq/R3k1W3gHfnZ//vZHGGS98I1AaYnZ6?=
 =?us-ascii?Q?GiLDw5rmTK71NrTsynt7IJUTByyNS37H/duiNTpxH47j7aLyA3qmDUm0VmpE?=
 =?us-ascii?Q?BqHKO6T/zed0G8KrVUO7R2LRqq9ZgyN3qkambGQNCZDRE1+vw7c1nkI1Bm/p?=
 =?us-ascii?Q?ZCdRC7CaUtk/tdnXxk6f9VBNLq3Tx2omHfcO0vBU9yboAaTEyvX2TzFbDtKg?=
 =?us-ascii?Q?rQQv7WidIEzVtAyqxWu5MiVHIf3d8a2I1q647afovP8Oo4pNvpjfMKzNQEZX?=
 =?us-ascii?Q?CRHaN0RUGiomnryujSMSL6Z/YWx+Rc8rQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:a0:900b::219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandwestazlp17010004.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(82310400026)(7416014)(10070799003)(36860700013)(376014)(34020700016)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 15:56:08.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493695d0-2290-4a39-4f58-08de2dcd7b12
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:a0:900b::219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRZP278MB1790

During the process of update of one of the device drivers that are part of
mcb bus (gpio-menz127.c), one maintainer of the GPIO subsystem asked me
why I was adding new MODULE_ALIAS when I also added the same new
information on MODULE_DEVICE_TABLE.

You can find the messages here:

https://lore.kernel.org/linux-gpio/80a20b13-7c6a-4483-9741-568424f957ef@ker=
nel.org/

After a deeper analysis, I came across that the mcb_table_id defined inside
MODULE_DEVICE_TABLE on all device drivers was being ignored as modpost was
not processing the mcb MODULE_DEVICE_TABLE entries. For this reason, former
contributors were using MODULE_ALIAS for enabling mcb to autoload the
device drivers.

My proposal with these changes is to complete the mcb bus by adding
modpost support for processing mcb MODULE_DEVICE_TABLE and removing
MODULE_ALIAS from all device drivers as they are no longer needed.

Jose Javier Rodriguez Barbarin (2):
  mcb: Add missing modpost build support
  mcb: Remove MODULE_ALIAS from all mcb client drivers

 drivers/gpio/gpio-menz127.c            | 1 -
 drivers/iio/adc/men_z188_adc.c         | 1 -
 drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
 drivers/tty/serial/men_z135_uart.c     | 1 -
 drivers/watchdog/menz69_wdt.c          | 1 -
 scripts/mod/devicetable-offsets.c      | 3 +++
 scripts/mod/file2alias.c               | 9 +++++++++
 7 files changed, 12 insertions(+), 7 deletions(-)

--=20
2.51.1

