Return-Path: <linux-iio+bounces-26538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB7C91AD9
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 11:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A21D347C4F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465030BBA9;
	Fri, 28 Nov 2025 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="Q4K6B4ch"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazhn15012043.outbound.protection.outlook.com [52.102.183.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE2AD2C;
	Fri, 28 Nov 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.183.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326141; cv=fail; b=G5pkf2JWBAmyiSY+ZhKY3iZrdojqoA7sXWi5wFXg3ll65IrAxhJTC17HNAbOKHcPp/Mh5dbYplGVbUwhL7qW0hS5vBU/pL+90sDfeb7mwhbjn6YCydfJpfaVkJM/PaJ6NOfT3TLC1E3DcY/hukjfye09468Mb2T2MS4cyVtK6dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326141; c=relaxed/simple;
	bh=TfmL1VSjsyTtUOyx9CKdn2DYGwknBQGEQanFSpg42Fw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=po1eUnnP4Kyw4nhw8/6WOCWWHLgyoj/5STxhFBy9fh2GPKhM5FnTnGlMQVqHQGX++9U6pXhNJrpMDGt8wBWXAdeWtPAj0SRD8xyQew7+hmzemVKVMSP32neCHh00t+DEk8CDbtb8xfpzlPRnK0P3kfXzyhtQIRiLCzTAM4hWM/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=Q4K6B4ch; arc=fail smtp.client-ip=52.102.183.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dudG1eJBpEnWLMfEW40BZufw/u7BnA+f3FpqGYZ0yDl5XBP0iF38/IM/MlhYarv7NiVBU/WG8Q6aVm6BuVnWBE/o8L4BvW9XrkAHLxbs07IFkCk+piFWqUhPrvIoEtwh9d6YBb9N4glqdGLwxHJkNAXVoTRcQEgd4B2VaMnVmXLGHlaZsbPkoVvHsf0zZMa2fqN4702p88k+kmEWbHUyvkW73pAqKM16CTWHESOx6pSAwB6hoIKmCw6d/XpQNkK2v6kb0aFNwEhqXJCiEH4bvUoAfvwgm6Oy+ZMJbT1tNEfn1UUdSP42mtJeCs+MaetBP9cqayxP+u1Q2TZn5CNNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMcVOgBrmjzHP9TIIMM1YX//tO1SdDWCf5braCNUgUQ=;
 b=Vv3LpfTJpNDaxE90fpxGD1h6q2I9fdeai99uJerTvAw6q4DuL37oPdfnicC9V5L6gyYUtgLajnGEUG512hVQEr7nwDuDlR9qygMvMT8vMxO8QuomqevNRlVXFr1LjcjYcVra1HMtZ3y6fVPREEiD5xQy7ISi/QqhTpZu3H5hTX2FhIXUSi9nZkds2UkR0WX/e0jOB7EkGpvcWdnNeB6yzWfHbRT4Jkuau/MYWiWxLb26ANBtERerysbVCb4AOt4P02KCXlzxCCRW61AAtiDyH6VDYjb/Ci6HHivg/kA+ImujcnxNcbZonQnyE9oewsS4jJ3+JHF1HsqmXE0EvR37eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.86.7) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMcVOgBrmjzHP9TIIMM1YX//tO1SdDWCf5braCNUgUQ=;
 b=Q4K6B4chhtykeMaer+BjVmIuGEY5U+wpjxW9cr1x9nRw5CPRaWCqJwLilH0psVW9k55dfdAc+6ZeoMrXcDTMh9TIWoLTDDC1pKU6aYHB1JEiZEr1f5ZDI2rbWso4k2FAFED2jBm0fVjWdHL1AWmN8pqUFjtOJHvyQT2aKiM98yw=
Received: from AM8P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::26)
 by ZR3P278MB1586.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 10:35:35 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::91) by AM8P191CA0021.outlook.office365.com
 (2603:10a6:20b:21a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 10:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.86.7)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.86.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.86.7; helo=GVAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (162.55.72.218) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Fri, 28 Nov 2025 10:35:34 +0000
Received: from hz-glue04.de.seppmail.cloud (unknown [10.11.0.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqSj5qGVz11C4;
	Fri, 28 Nov 2025 11:35:33 +0100 (CET)
Received: from hz-glue04.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue04.de.seppmail.cloud (Postfix) with SMTP id 4dHqSj5PCjz1xXq;
	Fri, 28 Nov 2025 11:35:33 +0100 (CET)
X-SEPP-Suspect: c7dc2019609e4e7eb47d3c93d5caf4ec
Received: from hz-scan04.de.seppmail.cloud (unknown [10.11.0.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue02.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqSj4Z4Cz1vdc;
	Fri, 28 Nov 2025 11:35:33 +0100 (CET)
Received: from hz-scan04 (localhost [127.0.0.1])
	by hz-scan04.de.seppmail.cloud (Postfix) with SMTP id 4dHqSj3Nr7z6q4d;
	Fri, 28 Nov 2025 11:35:33 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan04.de.seppmail.cloud (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 11:35:29 +0100 (CET)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010007.outbound.protection.outlook.com [40.93.86.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqSb111Jz1w9y;
	Fri, 28 Nov 2025 11:35:26 +0100 (CET)
Received: from AS4P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::22)
 by GV0P278MB1078.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 10:35:24 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::f7) by AS4P191CA0047.outlook.office365.com
 (2603:10a6:20b:657::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 10:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 10:35:23 +0000
Received: from GVAP278CU002.outbound.protection.outlook.com (40.93.86.7) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 28 Nov 2025 10:35:22 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR0P278MB1555.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.16; Fri, 28 Nov 2025 10:35:19 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:35:19 +0000
Date: Fri, 28 Nov 2025 11:35:09 +0100
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, morbidrsa@gmail.com, jth@kernel.org,
	wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org,
	nsc@kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Subject: Re: [PATCH 1/2] mcb: Add missing modpost build support
Message-ID: <aSl63fQ0HX2ywKIj@MNI-190>
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
 <20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com>
 <CAHp75VeNtYJPmXtDfWEN3a184YXTKNems657UDeBKp4xpOGovQ@mail.gmail.com>
 <e40e877a-130c-45f5-ad73-560704592815@kernel.org>
 <aSllQThEANDoZPfN@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSllQThEANDoZPfN@smile.fi.intel.com>
X-ClientProxiedBy: MA3P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::17) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR0P278MB1555:EE_|AMS0EPF000001A8:EE_|GV0P278MB1078:EE_|AM3PEPF00009B9C:EE_|ZR3P278MB1586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb8ba24-63d5-4b78-2cff-08de2e69dcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?tQKeMOIa+AcwZQcdRVPOx8G21ktn6/mYnOfkINsO8phKRK5CLvQKEdVMcXkJ?=
 =?us-ascii?Q?3FHGy3EFBcze2xvgCeFTt95ZJd92LXisD/0UNRGnWDi6MYJPJ8Y83ENg987l?=
 =?us-ascii?Q?e1r9I+2B/fC93uvBhBcB0/C6hnq03h2VqndLilp7AH4Wbbbcu0hzbah9SHZs?=
 =?us-ascii?Q?QpFYdGbjDLDcBP6U8z6PZPPk4s3543LZaoBi/Mg8PiKn4YOUv2Xhb67NOQtv?=
 =?us-ascii?Q?MFX2Rvbp+dsMPf09iQZqgrjOT01nfTD8pUbMlZKZch4bvmrNFrkx1kfUFAXD?=
 =?us-ascii?Q?AmzCiK/PqQdqUs72840VytW4o7dCnTU36DQXuvf5MXQ7YPb0hzdvvGiqN8RO?=
 =?us-ascii?Q?Hgf1tvwh/ARI+M45mvskE7GgfI/TBGcmGd2pdRHZO7vcE3OanpQU3mHQqtU8?=
 =?us-ascii?Q?ZicVDCu04FMyqUQbvzkPfOr8gTD0QCvBTUZHXzbUMmnWf3uQ3L92cUyZosQk?=
 =?us-ascii?Q?nAbKMqx3AHb2rYmUZ2zaPZ5O2fLUHtRMU11BH2MV2uVHFgoQScvFydSpBXtl?=
 =?us-ascii?Q?akSAK5Zfb8CGGlnIL4bezaPjuUuT/bjaKk0umabKLsW3455sB9XRpaiJ9FSV?=
 =?us-ascii?Q?kAziOpBT138M2rFrtDQMEw2Z0BYk1tXJyoBsSMYHY4Y+yu3Wt7g6fnhiknLq?=
 =?us-ascii?Q?lGb2xnO43sGleUsmblZIJTOZvpXl6c47wSQbXOAC29mw6Hk5l5pKdWhFLfBf?=
 =?us-ascii?Q?ZL4ldHGlIhVbO0aStm21tcivFlhZtq2kCIVFDa3L7YWH6bon5J3jgRe/g3tk?=
 =?us-ascii?Q?7hkgNbKPu4o0r/lAP4qUiwS5n+L5MLkXi5TR6lT2wtaIr9FDrY2W7z50wgV5?=
 =?us-ascii?Q?yINxvJ0hEuLJw7+KcabXU1gI4WIA1PJ+BFuOwkjFQs58kHmamGSmwYhwvrmU?=
 =?us-ascii?Q?DkVEp21Gh7SP16qXEzvlkmBOfjDnKppolXsJe/UhBujO2Pe7ak4WMFM95OZO?=
 =?us-ascii?Q?poqZNZPukKRFpnG86AdsX1Noi1UaYXBsEa3kGV3pCGeygWPsyJsedIUqQPln?=
 =?us-ascii?Q?53h/7gfqFHH7sM/E0u2mIsWZv45kIXOcJWQNK6jHIelU90ukvFdrmzhy96xc?=
 =?us-ascii?Q?wHVj3cnHqCVPx8F9k14dwee0WxLxE/FWpXz9ypSq/mYrAooMlvBVsz3LQHlr?=
 =?us-ascii?Q?efhUbuW4pUjCE9R0KEZ3LJKICcTpLNMvjR498oDfNoZbujv/B0fEs6pxT14z?=
 =?us-ascii?Q?MChAoVIxIIt0mdHRvQx4ljRm4/uHnUKjKfehGlWJvoORgtZ3mM+mjrhbfeeY?=
 =?us-ascii?Q?FZDfnEnP5NrRYylJuFrtUI8FKSMOnzsD2LnzoiGD71XJKHnNFcjiRyeRpxT/?=
 =?us-ascii?Q?31Tes/23h2tdCkk9i0evlbNC7pU1k+xZYK6Qz9ofwUolG6QnYmDA6dn/zv/3?=
 =?us-ascii?Q?G1+/PVjjrF4jr0qWxtW3824FGnkXjxIQNYJE6Tje/EAyrRvILIM/hJZ1gDbN?=
 =?us-ascii?Q?u7x5UMz5jTV/DB0w6GlmXsxB4BN4wHiVn0pfhpvEN4HPbcDQc2WQeJ3sf3fK?=
 =?us-ascii?Q?s+N60k5W4At0oEWaSQp3Ta4Vvjvi5quIaetz?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1555
X-CodeTwo-MessageID: 4bd12d86-748b-4da7-a249-be8948901b59.20251128103522@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 ca9d51cf-5db4-4f3c-735d-08de2e69d3bf
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|36860700013|35042699022|1800799024|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?p05RTwWNg5AOMQ31GDzjgLWsMmO94G3uT+h5Q83K3c/sMnVH2tYlMmhXKmRR?=
 =?us-ascii?Q?C+Y0cCHOWZqhtkLtpYwE4UIKH+xwORvbsh1BCFEM4XRPpFpLXnif6NnjAwTf?=
 =?us-ascii?Q?cb+jQwpmpjVlj7AIn1X+724D44TqhKBT6a/PoGcecGyXRc4tiGiotmoK0+I7?=
 =?us-ascii?Q?Drl3FATQ+42ZOn2iTImoqJ32A2M0LAVl3l6GxGK44YWXnakRv2a0zHeEdkUP?=
 =?us-ascii?Q?+y+23xZW38dQCqWbq4oJ0/Plm4GcyhcpcPqqziS+Klya4zsqOeR85iORVTwD?=
 =?us-ascii?Q?eesdI8XkI0UOX0ju1vBkGgvdUyhu5qusaa/sRURXY9QTE3pVPR5J7gYuIncN?=
 =?us-ascii?Q?fyo+Ga+0AttoZLcxrFsjte1CK8xCjflQqItoaHVC57jN6psvvOQPQ3mv25/p?=
 =?us-ascii?Q?2AHkXqt4wOfJVCYXyuT4tSEid3pQ817Ici0PqhbVwVSwscL9DsLqEnLloZx3?=
 =?us-ascii?Q?quiCFXZs0gH6Qc084ueymQTW95ZkjhESwjlp3pLeie4Dvl+PA2mJz5AfHmdL?=
 =?us-ascii?Q?HUg8N4Gj3iBEnupgJ4Qn0CBkHzNZwomHrd6StyaFawAaQ7Q+gIAHKJUnbs0y?=
 =?us-ascii?Q?C/y6Cl/+55kGvqTwjQa0LactckR9pgkhoh+hmJ/QN8Xq1d8bhLBeq50tB5EI?=
 =?us-ascii?Q?uqKzsluNGP1YMNhhdM4z2x6kRXbwBOeNQ6vvm3PA25SEQff6Syg/1SicXQ9a?=
 =?us-ascii?Q?I/a+m6i60OLPatJdohLbdh9iXPD8NG7TkEj1KbD4vvgNPA348p07lxPzaZZV?=
 =?us-ascii?Q?qV+hXBdRqo7/t0mnvVIbS4TjBHMso7V0ydelFYuY210VlSWHYfTtuumcpmiz?=
 =?us-ascii?Q?GLO4wMN5ayV0Ok5HKHo8AXOxcuOV78iEq1Pf+9g+/zR3UnO1YpoIHArjsX4b?=
 =?us-ascii?Q?S7Wt1X7EXh4fZpvfXLuO0tG4Eh/Y2GL6U8PeIGPXw/z2kmVYhOLgDqpZuP8n?=
 =?us-ascii?Q?f0HcTkZA1tKyyc7pibaGYV4dRpVwBbh22ijAUcSdeZN+7H29DqPUe+hRj8Fn?=
 =?us-ascii?Q?GOcTv0YCBktI5UQeZijz5YflckJtFKmck3MkWvr1i4PDji9gxkAKgkd/dycD?=
 =?us-ascii?Q?j7SCmqG6yKb7r+b8qbCTzx7xy6ehzc9n30u1H8XxGTKPN+3KT/hrimcQvnAp?=
 =?us-ascii?Q?m9+PS5Qb0ylLUy58aQJYeBdD5ESTcoBKNs1oRbc8V71nTwLfxIxOZJ/N9N+I?=
 =?us-ascii?Q?vFzVE/VvQDca+uaweEFewTh7mvNh1xpI0qhwtvvmepzaURrmvtjVgy58TfvL?=
 =?us-ascii?Q?alM8bdsKKKinXECXSVRNEpiOC1317liMrzhIdGZ2jmWFXGw7AdoATOyjpnHm?=
 =?us-ascii?Q?qIkEpPI8TmJDKzhWxbxJ0D8PffoQHSp58ZVVuN1R/GefjEvEMXjHXSersDhp?=
 =?us-ascii?Q?CMSV15i/5QBQOXkUO6/6bX4C1KzhWU+Ds3kqBrEywaIymZt2XC7YXDf06khS?=
 =?us-ascii?Q?im/IpeeIM6ABcyXqU6AbpCq35i4CVPnozbt9szeukSfrqeutIIVJ6AJsaA8v?=
 =?us-ascii?Q?blaSRsVEOS9DNP3+cZ0wUrvQa99UYSfoFrklystuPvVSexSShc0+KMVztFIh?=
 =?us-ascii?Q?QaWx/uEXNaCEgLpeXZU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1078
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.86.7];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.86.7];domain=GVAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c4a4b128-eec7-4165-cf11-08de2e69d66a
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|156008|34020700016|36860700013|376014|7416014|82310400026|35042699022|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CpnOAB0ptDuNhxRQ1WmEABmAGNVhpwO2BaSnPw04RU2mUmG0sfx3ppl9WS5r?=
 =?us-ascii?Q?5J0QX45h5dRc5Ijwu3s0siJy13RUY1GSXpbMbHRnG1GEtnktEbGj/lmPvfFQ?=
 =?us-ascii?Q?9Nr7IwoY53qWrkcIdHm5FpuuVaCdKuN5Mh+i6Ew8RMUqxqzxSznoy+AXFGmx?=
 =?us-ascii?Q?QT71h+14QUpPCey4z5m7bH17SitYkOxg7L/MaIa/Sas8esbUKphuAfMKODfM?=
 =?us-ascii?Q?tX4i3c+ALzD9hT1F4YybndsxpWEH7g3nKVA1or7krEEeoiQUMtFR/4aZGDVO?=
 =?us-ascii?Q?duqX6OeHWZo6jTK58IuQos++S8Nf80Fl4IwWgIDtljNB0UpB63iB+cpaUywM?=
 =?us-ascii?Q?d8fVnwDqtI1E8XiWZ7Dz6bKRQyF7eoytPRRUueHyaIzYU4nqH/JTHQ8YmKBJ?=
 =?us-ascii?Q?Sq51GSmr63UZ5rtN9d/JON47PBOr79v+0wGozNozbTsXbZp80L9xlgu2Jx/I?=
 =?us-ascii?Q?AtaZfElpwbFc1oNUC9cOlhvPh3b9woYpfZt0C3ogVYAFaesI6gdMmBLdmZKW?=
 =?us-ascii?Q?yIEOoTbwC9I2VooemgBTgwyYUfqgEe1mhwp4H01QwFGOKBvG4qxx05/8zjQl?=
 =?us-ascii?Q?lifr8Cg0lHQUID92radWkR76VSLxeoRKu0e0vYvZyu12JG84JeuJn4ov2r1N?=
 =?us-ascii?Q?2FMUi+eccHLK7KxSFdf2CTtAgOesD1jtEj+sLq91O7ginmd1tK1/TUQdA8qx?=
 =?us-ascii?Q?Nd9mseroQGd28jcNTSPUAImSHRX21lY+3yKk06gem1YnjO72V0BWBrWLi8jL?=
 =?us-ascii?Q?c9Pc/IuHc0RbcXjJfZjmMGcap/sSjUo6Bn4wRDTVMPZ3JS2Iq1geAtn9tSZh?=
 =?us-ascii?Q?Ewszh+g4CGP0i/gXwO8v+f6cI+UN4SxFUc3KcULffriIj2cCQ8ANFmOutNK8?=
 =?us-ascii?Q?wmHPiHeySrn1njFDiSEZY9L4YozQGvT1sncNetUx90dEombHPdzFzohkshFf?=
 =?us-ascii?Q?KdxxzUv0FRZBhuBD1rBgmiQnPm8tQeoBoUHuL7gPPXn4NCszPI0xvAvysmyK?=
 =?us-ascii?Q?pMwADBRhOv90rzGs0fCen4kBMNZNBDPjYFcQl5xi1mlw7Jokd5ArinYaxTj9?=
 =?us-ascii?Q?1oBz917qI/j0o0VcEtSuhJDQstPXQOZcTzQPQ+LlwplX3CVhuD2BYNR5vKq2?=
 =?us-ascii?Q?FvjEWB2CX4dd?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandwestazlp17010007.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(156008)(34020700016)(36860700013)(376014)(7416014)(82310400026)(35042699022)(1800799024)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:35:34.2004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb8ba24-63d5-4b78-2cff-08de2e69dcbd
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1586

On Fri, Nov 28, 2025 at 11:02:57AM +0200, Andy Shevchenko wrote:
> On Fri, Nov 28, 2025 at 08:54:18AM +0100, Jiri Slaby wrote:
> > On 27. 11. 25, 17:10, Andy Shevchenko wrote:
> 
> ...
> 
> > > >   static const struct devtable devtable[] = {
> > > 
> > > >          {"cpu", SIZE_cpu_feature, do_cpu_entry},
> > > >          {"mei", SIZE_mei_cl_device_id, do_mei_entry},
> > > >          {"rapidio", SIZE_rio_device_id, do_rio_entry},
> > > > +       {"mcb", SIZE_mcb_device_id, do_mcb_entry},
> > > 
> > > Perhaps squeeze it to be more ordered (yes, I know that the table is
> > > not so ordered, but given context suggests to put it after "mei").

Thanks your answers,

I put it between "rapidio" and "ulpi" because mcb_device_id is defined in
mod_devicetable.h between rio_device_id and ulpi_device_id so I though it
could be nice to follow the same order on file2alias.c.

> > 
> > s/after/before/ :)
> 
> Right, good catch!
> 

It is OK to me, I will put it before mei ;)

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

