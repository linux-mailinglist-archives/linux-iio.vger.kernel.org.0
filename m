Return-Path: <linux-iio+bounces-27430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748ECEABE5
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 23:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8030D301B830
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DA124466C;
	Tue, 30 Dec 2025 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="s0bySZup"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020141.outbound.protection.outlook.com [52.101.186.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305227B33B;
	Tue, 30 Dec 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767132052; cv=fail; b=T5P3sat9tEEU6ESYHDeMnkq9ZE8H2WIN5iF4pOZ3ouxeVUSFbu4E9j36nkVaJk4ZsPGvmvRTLc8F1FCt8+kKddyE1thPZ0ndkFR/8pLLBNHZjY2qLNn98v7dIaT2PwFEFB5rHELMx/gaOr9zfkAz53BhAsrJIiHOwQCOJGIDOuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767132052; c=relaxed/simple;
	bh=VH/Uo8yVdMvYLqPhiRo4Bl9S4dRBPSOW2JNs5UflN1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKp11SvlAFs9fmvykzfFFDoq1RY7E2KRX91L3E4TeMZIkIacB/03X4Hf9YMFrQjZLdlPLUpEIG+HOjpH5/QJalObu4CCwEBwuAYVFkRR0WR8P2tstaAXupCBWyKO51WSHIpENJVzZPTdwR8Z0rAXB7gyrNXRQ0J2FkkI05Ahd5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=s0bySZup; arc=fail smtp.client-ip=52.101.186.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6Y/klIwGNH2xGo69GPKNnGl97IL1TMeBOWI5WbMTkeyf6J0MBuFLv1rbhrdgTPt3xcB4VMo1bZZH2123KqYSvfHKLaTzSwCqwOyh7IWsBuFLt1AB8S2aQjPniF/FtgDVP3tSDL2q28HVCZbXuEBRJgIpqtaOr1aJxz7wraKOcEJX6tuqj6YzLgHlutWZ8lq9UezNycAtKTWdwnfdSiazTu3ygPUlBytBkrJ8UCJTGmU/b3ZTxTnh/Rmp5r/z+kBD6RjZdcX8M7dasHJzQecy9ECM9R89AdOseiV1iwmrd0nVeeJlkfD3eKxJUymzZNl7AL6xBrjVaeUMDGNHPHo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH/Uo8yVdMvYLqPhiRo4Bl9S4dRBPSOW2JNs5UflN1I=;
 b=dPL9QD67bxafZKnmZXkKbgR0gM0O67hJ2OrG5F9eNQWECzWv5AlWujROYAzdNTVo9NTE3faa9b7hnZyndpOGK2CoLBWd0WuVUf7hNvCmt+M39NV22RicJSntXSYc+/9JbeTI7Jy40bDmld4N+DVY5di8qR1XG1wj0CEq3xgNpX6YLeyB9GvU2uNcR4kzkD/IRoa+k6zwHljrSpgrj9skanuZjaDvf4M3ASqtki+2U0idAhKvU8tGCY7JVIDSFPNn5sGfc+ghUR95SgU18IHM/t1aC/BqNqSIBYj8gRKDebZYppVXJblhtYU1nQsXnHYdkVLDfjjGadXyROieEEHd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.31) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH/Uo8yVdMvYLqPhiRo4Bl9S4dRBPSOW2JNs5UflN1I=;
 b=s0bySZupzvaxYBbttn/HThDiPJS9qy41lfWBg7oc3bzp3hXLXWCprulWlYSje1fnJoB/aGdnLPjOd+n001fhe/89YdRlcVMbd+12s7n63IWmodqBflw1WZevxcMDAU0YkigR+ktOW4b/ZLV02gK/p+uhJJcjKcILqkTgeBOCQtk=
Received: from DU2PR04CA0261.eurprd04.prod.outlook.com (2603:10a6:10:28e::26)
 by GV0P278MB0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 22:00:46 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::f9) by DU2PR04CA0261.outlook.office365.com
 (2603:10a6:10:28e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 22:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.31)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.31 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.31; helo=ZRZP278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (2603:10a6:18:3::105) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 22:00:46 +0000
Received: from hz-glue04.de.seppmail.cloud (unknown [10.11.0.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8Y6fLGz1196;
	Tue, 30 Dec 2025 23:00:45 +0100 (CET)
Received: from hz-glue04.de.seppmail.cloud (unknown [172.18.0.6])
	by hz-glue04.de.seppmail.cloud (Postfix) with SMTP id 4dgn8Y6Q8Jz1vsv;
	Tue, 30 Dec 2025 23:00:45 +0100 (CET)
X-SEPP-Suspect: a4e6f269efdf4004a4c6aeabb37f7f1c
Received: from hz-scan02.de.seppmail.cloud (unknown [10.11.0.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue02.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8Y5Rkyz1vdp;
	Tue, 30 Dec 2025 23:00:45 +0100 (CET)
Received: from hz-scan02 (localhost [127.0.0.1])
	by hz-scan02.de.seppmail.cloud (Postfix) with SMTP id 4dgn8Y4y8Wz6FKn;
	Tue, 30 Dec 2025 23:00:45 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan02.de.seppmail.cloud (Postfix) with ESMTPS;
	Tue, 30 Dec 2025 23:00:44 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011031.outbound.protection.outlook.com [40.93.85.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4dgn8X1js4z1xZ5;
	Tue, 30 Dec 2025 23:00:44 +0100 (CET)
Received: from AM6PR08CA0023.eurprd08.prod.outlook.com (2603:10a6:20b:b2::35)
 by ZRAP278MB0032.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 22:00:41 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:b2:cafe::32) by AM6PR08CA0023.outlook.office365.com
 (2603:10a6:20b:b2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 22:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 22:00:41 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.51) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 30 Dec 2025 22:00:40 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR1P278MB1410.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:98::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 22:00:39 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 22:00:39 +0000
From: Javier Rodriguez <josejavier.rodriguez@duagon.com>
To: linux-kernel@vger.kernel.org
CC: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH 3/5] iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
Date: Tue, 30 Dec 2025 22:59:26 +0100
Message-ID: <20251230215928.62258-4-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230215928.62258-1-josejavier.rodriguez@duagon.com>
References: <20251230215928.62258-1-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0027.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::16)
 To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR1P278MB1410:EE_|AM3PEPF0000A792:EE_|ZRAP278MB0032:EE_|DU2PEPF0001E9C0:EE_|GV0P278MB0002:EE_
X-MS-Office365-Filtering-Correlation-Id: 31298b6d-d957-4126-7fa3-08de47eee2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?StICf9wB2Gg2+pIwYxGcMoktTHbPmNcAJMyqfwBl2HZEUm5n0ixnfWr9Sw27?=
 =?us-ascii?Q?74DgxvytaLSNmlUMwDhC/KWNhvEKmHoSzuP/b2L7OMuod2nXA67xLs3tasYE?=
 =?us-ascii?Q?9U8vqEz4V7VKHpS6lSuZW5xbTrAELoayYt/mzV1ZmGkxL3wDoPJf9+BJ62Gl?=
 =?us-ascii?Q?QGweJveW4z199Zkd1yub08vCFsDHkLBGiGld/BjTWusG9AeAKb7bCqN3gcRB?=
 =?us-ascii?Q?CClxDKhmG6srjRs+ZFQ1bPv4THPykfwxDLahB0Iqkse7syxAknZ1SNk7DFft?=
 =?us-ascii?Q?kRu58Uu4YsD+lL72JmxT/6W0w6BruGBlgEfPb6XYCtpJKXoDbZoooOnvqPUN?=
 =?us-ascii?Q?6uBM3omTwcZmU/Mvww+/WBBxhAzy+KTG5j1cWm9C/X0cAJ+ESChmD89xZ8Tz?=
 =?us-ascii?Q?mvLWguBySTSdFalYStGRnB45jgULa2LL7aj31+/gv3EjGSmbgwAaXv6ohnF4?=
 =?us-ascii?Q?q223Mzga2lV5Jd8eqn6v5qxaPUwuLpvIzATjk2flHj5AyX77h4F1Es2ADWG6?=
 =?us-ascii?Q?wKVCj8X0YziY5eZCFeLzu/4yXXazauru/4FNNbcYbVRf4kL8SiIsJnKsJD2g?=
 =?us-ascii?Q?X6djbc5j1Skr0f0p1LIhpRFwbpDOvHKvDa7TW+c8QkvDAZkBVny5AeHEOaCG?=
 =?us-ascii?Q?zy+D7d5iqxVIJQJ4jIjDFjdKBpushzzPLoaarSsu6hrFt/8BerZNNbThqwXa?=
 =?us-ascii?Q?OV49nPEZXSk7s7rp+5Ld+N0rxmHb5yg6ZdFHpqVP4c7o+m4PENssVE914s2B?=
 =?us-ascii?Q?tO8D+nL8HenL6O/hs3drFdJF3dyhzWh3OiwfZ1EUd7NpMyZ15eAA85FQvY32?=
 =?us-ascii?Q?Af3xuxzK1YDfcMogOX/9janxZAClOHARSsqWgLEti4dV2Zsn2Z3lJzdzGuDj?=
 =?us-ascii?Q?VlYNqOs9PUqXPT0eYHyey7l3/mcMonjrMtwLMX8hxagA8kxyR0mQR/BFEV4F?=
 =?us-ascii?Q?SgpfHskfjvSbPVxnkVPwlUdy13lRvRqel2TXUIKlI6JmKR4VbCjt3eCcMxtS?=
 =?us-ascii?Q?HC97ztM0gATUB8MQAQ+DSHhOGo3LLt/4MEyx1nZ8tN+qBCpONgeMoUlsdMiC?=
 =?us-ascii?Q?eB2HpkqBQ3DjKJoxUUxMVDPwvcp9AD+0ztxnvIEr6rhoZ6YAmf7EqUZOnpOh?=
 =?us-ascii?Q?5+MoTPEGIUep7b/4fUQ1FBWXWqn33HLeN2P8ZN1moRl3Sh9BT85euKmmX30w?=
 =?us-ascii?Q?avbZjSoYahPNbLzz/VdbDBarz81NsGJ/1FQLiLP8cmXkCvXOtdhJ0bTIMy/k?=
 =?us-ascii?Q?IpzbjHdVHF6ZauefvhRgg+/0rDrpLcBwfSU98d4opzGCvxoEwOqAZbqaiMh8?=
 =?us-ascii?Q?vPHRVzWynfzAywbUetIJ25vgiO4DzPhPy9C7aHUFYbY0KkHzdWAwoJ+JtsV/?=
 =?us-ascii?Q?AONq9xO3VxGsTKQYTPT+w5D4sRSGqmzYEiEE0OF4Yfb53EC2e1nrmu0Aic59?=
 =?us-ascii?Q?mNcu6sq3j5nz5UP2rAKjSf81ZFtMnDYIZPXXWT2HFIkSShzSNDhmxOZ7HalU?=
 =?us-ascii?Q?FJg9vk0IUX9yT4Mqd9vf5zOgz9uGV1LUgN4e?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1410
X-CodeTwo-MessageID: bda59131-9408-4e24-9409-4ba598b97696.20251230220040@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 d676212b-7301-4c58-e55c-08de47eede20
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|35042699022|376014|14060799003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?+EuJK4D2bod5aBlxN55sZtbUIlIOLtxzsXRL+tTLpAQDeNCXuInhCutog5Jt?=
 =?us-ascii?Q?gH3XwFV4M7N2XbmR9H56Dw5pWkEcvcPslaRT2/wrmu7j2rspANmM7rqkUuK4?=
 =?us-ascii?Q?Wtspthw/Jh7pQj+DBbV7mykMGM4w2Nxjup+BtuIxyap645uQ6qLKLYooxUpV?=
 =?us-ascii?Q?75aqGEC2nRg1fmfsIvfYA2h6wZKyV0y8oTFJ14snGcaR0Gpqr+m8oL6qIvug?=
 =?us-ascii?Q?e/v50BwWatl/2KqElBFLXjJrC2jRkxP6dqmANDOV+aRBanlIrhT1HPQ5EAx1?=
 =?us-ascii?Q?EBFzhd5t0e6qN1b6HGJ4+Kh6ppBcXIlV+2SJpa2xz6xfTGYASvq53kIuLGCo?=
 =?us-ascii?Q?wp3OnGzhjQWVfKNSpbdXaAhRp4Z3VLuAD6sS63BJbMpMvjxyQNP7+BPGydlO?=
 =?us-ascii?Q?fJq3OQkD7+Upk0rHwTjnGD/VEYJBaWVmMV8jsMKbnJMIcpPsBU+TwLtS6kUi?=
 =?us-ascii?Q?JKVnZgVZ6x2zFHaEB3Ae8OuLjPQoG4eoXiEwvsnb1Igrvmv6u4M3R+qhRpsa?=
 =?us-ascii?Q?HMpfg4YZBb7I4qni9T6NwjshDbbF99ITAyGUXJoY5Tmnq4M7xpfuamzd9RRd?=
 =?us-ascii?Q?g1DQoz3x8n0TnTKvUWau6sz6rf7xN3z4uPeZ5diYBdsdT7uic9LiEpjQf+R1?=
 =?us-ascii?Q?QsmfvPC6F1JgsiuI/IpA/xForXN8e9Kfe+Kj3GSH3ojSyEggO6y4AjoBzH0n?=
 =?us-ascii?Q?zAJbYtBmMjJ2UoOT2yR6MjKG6HFtnh0//Pjxtuf1pmjPV5yBkQhKjDFtCL6e?=
 =?us-ascii?Q?vn7D4eWfMHTgxDLYGXUrAalOjaoYVV3WnA6d3WKsKJDj4EhijxQ06S6iHtwZ?=
 =?us-ascii?Q?pAKMTZ1+YsujRJgy++j5Wen/PTMYt/X698KK9lNWviz2Kol4OD0b6VDTCx0z?=
 =?us-ascii?Q?RJhEhZ09e8+52HdhQDKfbzMXU6sLwmzPujH8C6pqTq0NQNR6PQmTw8cDv/l8?=
 =?us-ascii?Q?V9uzqYLXCIbHkn+R0iFPod+4jRe0KCUWwI5g6X/4cYGxUnyBzG6U696E7cvv?=
 =?us-ascii?Q?JZpI++D9Oa9hcWQdXHODDuO9PDfuEc+LT2k+U1nJMVo611iGOYlBmlQOMIOm?=
 =?us-ascii?Q?D0OsolDEQyqZZqNqYP/b/S25WI+Z3sLGVcPyMqTmHcy1u3FGkbnydoG7RDb5?=
 =?us-ascii?Q?a6aIwK55FK/UDu/KWE1d31cttVf0poAT4qB4dgDCnqrkRssj2ZiMWYjsypmK?=
 =?us-ascii?Q?SDqSWBlvCmzkUccnt8lun9dHbT1avCWmHB+RLVU+q7TMUOce+MePvfia3PUr?=
 =?us-ascii?Q?hGCFCx95MhWUWhtFg9zJvjZoMR3r9/FpkJcyilOk/1DVErVn4szmB0KbgDCA?=
 =?us-ascii?Q?ZLf91GbfCZdp1NS76QrVTjdj6qxP4m+2qwez9tssbBV7l8rYA9XbFg1hEKxh?=
 =?us-ascii?Q?t4WOffzEZEt99+Zo4SEbMLTCwBQ2GuWbrV2RppvHPYpEujDWi6EjuRv36aY9?=
 =?us-ascii?Q?UOiLCXQymJU0RVwfcApHMqVDzHfMtYgCqAGeTNx6VU7WZmIlc6RRICHmAG2I?=
 =?us-ascii?Q?7RoHMeKnhhOxli3S8esNP8Ruv597cGdxEw47Z7Nr0QlKDiT5Q3FnU+I0Sq3f?=
 =?us-ascii?Q?CX65nQKJcGYKu56DTcs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(376014)(14060799003)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0032
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.31];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.31];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	13e2247e-cc7f-434d-4c7e-08de47eedfb9
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|376014|82310400026|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PoeVhudy7HQs3KQkx5bTd+wQHLviYuTlGe8H4uVxaiHPI8FzsKh4JvGiQE31?=
 =?us-ascii?Q?FHCeDVeDCWNhlQV71TP0eR5pWl/b9GdkV13LAaSkVyVd00f6t+APpD07ADA2?=
 =?us-ascii?Q?YsmOC7bcUzALHKEfWvSrEgHcdhNTdwbcKj1tZSi/1kiHpoblASXPzsKoasUb?=
 =?us-ascii?Q?jSC6iE66MIMv8co85mN4XASutRFg6XihSgGJ9MqO1iXX6Plt37uuctqyOcaD?=
 =?us-ascii?Q?0BRqHuni6zcAIXT8kTNyk57I04DenZIW8vLfJLN/QMDtADVZ5Jl2XN3QC4tS?=
 =?us-ascii?Q?WGWXlW50YxKIGl9QGpkDE8Zd3GFRIXmcwDUcPcJpdQrkzFV58nKxg/hSp6oc?=
 =?us-ascii?Q?5wPaGc82xgtVcaquSIMnnzNz7uhUQ1zEpf19AoRc30Dba7fxOz3MoDttMwle?=
 =?us-ascii?Q?BLoAhCURfY9KML7Gm5+0/VzIbmVDLufWaeCV7ecTThtx/Hyrv0MpbS3mZM2u?=
 =?us-ascii?Q?bQ0ECpAUBeQpoFUbybQCFUbBPunNZdsjk64Ftcf6TxHQkasgN9LQGLycfgXm?=
 =?us-ascii?Q?zP5OpUE+YtkIGYokqQZ7iYGBhwwy29RtwzvDBkZRYC3vQw8BYyGUJ3TUTyt6?=
 =?us-ascii?Q?HL319NFd/MWDIDL+HYTw8m3o1kjbbPvrLNz4KVD4hAP4PrR8zSM5I37lUffR?=
 =?us-ascii?Q?oFO2tvwIgwfKu69zsL9G1g+wfwrJVFXvFEJ/zZBlxvpR6GQyQWtTc5h0Cuyi?=
 =?us-ascii?Q?sGSUGWH1H/LiR/gKQbusGbra0Ktonoa56ju+LZqJD0g5mB6bnnaLs/zFXEL8?=
 =?us-ascii?Q?HJq19w9MVOnqJ4JsE0Q/Y0XdAzEJFyu8WtTwzDXCkVhxUnhdEWxxjsYLF9q/?=
 =?us-ascii?Q?F1BdFVtRF4f2gmYfDynFgpL57ct1KaPtV0Y8MS81K81evgXG/JotopBosEoS?=
 =?us-ascii?Q?7ja6ZOeFzJY5Ca4Q9hyBdEFDP/KfeLb4d1pHRxR2S/Ok8dxg26fqSd+tHyDS?=
 =?us-ascii?Q?fw3WH3Wh8yzGIiKh6CTA4KQuQW6E4ZDG1vRUAeh3tVH0Xq6iGCN8Tilzegdt?=
 =?us-ascii?Q?KnJJzhVz8F4NCm8Fjbow0IiI2bDwrq3QCRkt+V9PHDJIsOxbs5i32X/YFVht?=
 =?us-ascii?Q?F5cwbn8TAp5oA7RkpY8TcMq1wgMzR/ZbpQxrpobJwM9mEmQOe5e5vaalOf4V?=
 =?us-ascii?Q?ELUY2iN2N5hQZMZLike4jZNXr1bj2vAQeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRZP278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17011031.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(376014)(82310400026)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 22:00:46.3190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31298b6d-d957-4126-7fa3-08de47eee2b4
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0002

From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>

The MODULE_ALIAS() is redundant since the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Fixes: 1f4ea4838b13 ("mcb: Add missing modpost build support")
Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org
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

