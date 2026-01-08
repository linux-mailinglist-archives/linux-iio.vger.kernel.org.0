Return-Path: <linux-iio+bounces-27556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A95BDD032D5
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 14:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2FDA3008F0D
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E696748A71B;
	Thu,  8 Jan 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="ET6cfcfv"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021122.outbound.protection.outlook.com [40.107.167.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27654828FB;
	Thu,  8 Jan 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880408; cv=fail; b=JpdzbTJDUOfr+btAaDM4pZhWVFMM+IjfyaVpz2ZUoZ5PSyurTD36hkkupAd5xWN7c2qa9sfdMCw6D/via3/AW9xXtUNjb2h1mkGJaoKxqWnNswzwuaij/Qw0cgkIIqLgKiceFpph4o6jiZHSgIvkai8RTS96wGq/NxfTESau6y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880408; c=relaxed/simple;
	bh=s+PtLo6EJ6ITKAMhm17pohAnHSI0LUj97afJ+zr35Oc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A/lH8BhuOKyhor9Ge0eYScSsjsSeXllFFjJaUtZk5G5+MxgNZ1wQiVhueUkk4HpAQf+Inpe9Q4z+aKHzO5UbweZnKVGJupSI3VDgYntPnWmyAPVzUcsv+ZCOvTKb+w+19J0dwwyZPeQbwarjcqhII8JUIeykEyffBVmBXvSgwuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=fail smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=ET6cfcfv; arc=fail smtp.client-ip=40.107.167.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8/zxzubn1Svor8MjjedLkmhOPZXB/Okwpbtie4LFefkvCV/Rgcn1QqdBLO5jeTqMmnEowhT7tuHJ5f5OOaO/MtJZOEyw7MReDgzolmZ4746RBvFeAiZ41gCC9NfwKqU2VjAXv92LAik1hkbv0qhx6vk8YCAtXgIvT/j9+efH8MdpX6ivW4P5pS38YvHY4kmqt+/bPs+xx7shql7XnaphprpV5fj4fJBkUO+JBJbvCy24PdLaNaTWVoWb8CqIm8EaTd/q7RoNRikUaOYj0G/xzcGLnxBGdJdJZXsqtp1RPH/nu6nBTBMNOe/eagoBug/jif3OJ32Qe+LYNisbGS+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s3a9vj+xx6wd1lA9wD3ZG0ji1PHiqJt0UwpHHkSUBc=;
 b=wG5JD1rdhBnOwEgjD9yLqM8psxc79lJQreqctHg2DQYRoMpxNYRYWXLiI0ZsCh0SGioKjtHp8gAIRyRKuJE6uO0IPUDs5KupoqW8/NS0G7q7rLUv+CpM15MY8bWmta52Je41bcGMVT1La745r6dY3kTLrWmAlhit/vHplL9duOmzcLlmhiwqraUt5SKpv4y5UzOcIXTRX3DIkwYnqjC8SNLxjQWnmDbaKi6RKdAESjc54MMp5S6U8LEXkFoeJv/W6Pwue53+DlWN0dHMwzmuWoSK/AejSeYZdCUj1M076eWXY61wz72lXq9LBnNeBHmxSmXvQS9nEk9TIipF5KFx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.54) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s3a9vj+xx6wd1lA9wD3ZG0ji1PHiqJt0UwpHHkSUBc=;
 b=ET6cfcfvJFHUHsaWit1BgTmJ3BUCZf7IVf28QsgC4qA+3umgQSS4PLmsgItr9aZ4hfE9IJKKhHVCcwCN/7blrlgn/kNbaj26HySWhRLI8Rwax8UeMryt98KDkdrWXtANyWJk8zIWOMTzDknZEFOdL9NGEza52rQGbiGSBpQpwqM=
Received: from DU2PR04CA0213.eurprd04.prod.outlook.com (2603:10a6:10:2b1::8)
 by ZR5P278MB2102.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:53:22 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::4e) by DU2PR04CA0213.outlook.office365.com
 (2603:10a6:10:2b1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.54)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.54 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.54; helo=ZR1P278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 8 Jan 2026 13:53:21 +0000
Received: from hz-glue03.de.seppmail.cloud (unknown [10.11.0.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5w11c6kz4wvs;
	Thu,  8 Jan 2026 14:53:21 +0100 (CET)
Received: from hz-glue03.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue03.de.seppmail.cloud (Postfix) with SMTP id 4dn5w11DGDz1yWK;
	Thu,  8 Jan 2026 14:53:21 +0100 (CET)
X-SEPP-Suspect: 0973722a4f214e35bfea48e634481558
Received: from hz-scan03.de.seppmail.cloud (unknown [10.11.0.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue01.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5w10dr0z1vfL;
	Thu,  8 Jan 2026 14:53:21 +0100 (CET)
Received: from hz-scan03 (localhost [127.0.0.1])
	by hz-scan03.de.seppmail.cloud (Postfix) with SMTP id 4dn5w06rylz2XGP;
	Thu, 08 Jan 2026 14:53:20 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan03.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 08 Jan 2026 14:53:19 +0100 (CET)
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012054.outbound.protection.outlook.com [40.93.85.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4dn5vw6KT7z1wLk;
	Thu,  8 Jan 2026 14:53:16 +0100 (CET)
Received: from AS9PR0301CA0057.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::11) by ZR4P278MB1955.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:53:14 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:469:cafe::58) by AS9PR0301CA0057.outlook.office365.com
 (2603:10a6:20b:469::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 13:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:53:14 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.50) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 08 Jan 2026 13:53:13 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR0P278MB1672.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.3; Thu, 8 Jan 2026 13:53:11 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:53:11 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com
CC: andriy.shevchenko@intel.com,
	dev-jorge.sanjuangarcia@duagon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH v2 0/1] iio: Remove MODULE_ALIAS from men_z188_adc
Date: Thu, 8 Jan 2026 14:53:00 +0100
Message-ID: <20260108135301.26448-1-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
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
	ZR0P278MB0523:EE_|ZR0P278MB1672:EE_|AM4PEPF00027A68:EE_|ZR4P278MB1955:EE_|DB1PEPF00039233:EE_|ZR5P278MB2102:EE_
X-MS-Office365-Filtering-Correlation-Id: 401898a7-9eb3-4bfa-250f-08de4ebd4960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?dAWqZLroX5jg6XN7bYS0HVqCt2HKQJFlwOqicXo1i/ygTaP1Kkvx8Qob90y4?=
 =?us-ascii?Q?yH2g0SGXU810X+KyDsJtMEPsUpEx1qJgxVXarwLNyGAsvwnPoEcdvjBMYbvs?=
 =?us-ascii?Q?Xu4xoWrVJ2KsHjWsESNu7rqtzUuXllOdDkjx/tzfHOUWSr7wB3BHAKsuEBp4?=
 =?us-ascii?Q?EgKu5X8F9IQ6c3JD1uDkbdljrUt3ZHTYR7jwRhFoDUJ0iBNTyhQ5QIU4Qk+z?=
 =?us-ascii?Q?zQ0GdbGCDOOPYnzSneRyzalGBdSL8Q/WKzuP7UNI2bAu0ujXjC00sWi0pUSZ?=
 =?us-ascii?Q?0h+C2GRvu3DJibGQTm8rYPr3aYWpUWgPb3Q/Gj1g5GnGAeAgld/7Ft5QQlgR?=
 =?us-ascii?Q?5MN4vSv40PR7EXrXYWH2tGt/nAlFBmHj2dywQ6AUsMylpZXglTRWMsRZch04?=
 =?us-ascii?Q?5j37S13N27z06UbO23UeNpvW9GS3DWaPWg9Z4AvRbkO+DkXQc9UyFlv19BGN?=
 =?us-ascii?Q?c4wIHJFUtT5AWTbd/om1qc/+hWeXfh0WOiKZVYrcdJ91+l6AJ1/sivkGwKKU?=
 =?us-ascii?Q?/2vyU094Xu+1SVb6iBZsEp1EiehlO4LceZU2F5u6IYFgmEeAu8HXeVgU9QWr?=
 =?us-ascii?Q?7uMx7+hfAXfrQAJAEiOZfv7kHwmaL3PTAWPSpcaBYRLzSOa2ghzKI93lDiKJ?=
 =?us-ascii?Q?PAMVUnEHZAn4RnmCcpzLr+8lKtpj3rE6ZKb7jWntkgh0gy4sfBeKJ2LbG/Se?=
 =?us-ascii?Q?QcgmPsy74gC8qQR/N7Max3iIg7fxHy6lOXxm9yEZd8KX4jQEHCrFvYXBBn4Q?=
 =?us-ascii?Q?WnwI5SmRft3C+D2Gmdb1wHTyrT6OBxnMtHsPci8Q459w2vjYLXtQsyrrGAaH?=
 =?us-ascii?Q?dl/zqiQ7oBjM6nHA1VZUDRuT4Sc6iRx7QAb9U7j5LosoBcj9N4rOXjr0RlIk?=
 =?us-ascii?Q?FiOpO3/w/h3VwY8KMcKmHUaj7TBQjOuTDjcQkWdtKzfvVXj2DIUAHzXWNMNd?=
 =?us-ascii?Q?VkWxYcDknJ/4uCVLn7uPay1/s+FBATe5R68ZndUmInThRAXCNnM2Km67AeUa?=
 =?us-ascii?Q?O+PRcC/ihj8nUVhTteaylWouNQffYv0XLLqN8rFhE9C6lhofMBWybAP8z4aV?=
 =?us-ascii?Q?ExlSxf9EEz2JOYoCtc3YPGHLAWB5vTEfka/8FOvF9mjCYDyrlKQo424nahGT?=
 =?us-ascii?Q?8j5LuB3OyyLTw0UpdG07agXHsh4Yy2BdogXzeVox3aJTaao8s9EK7UdS4itw?=
 =?us-ascii?Q?38GXi6TUMa42I+HPketrN7hqlCVl8/IXKthsp6LJaDOMfF2Ww0kddgQYX/QK?=
 =?us-ascii?Q?4yXtfLZZWRLVNyi6K9UG5M6cU2vwrDDFO9Vjk8pry7DfbDrwhbopEelpSIuM?=
 =?us-ascii?Q?erCxuA1F3HzSWo39Ig142IEFTGfBLUnASNC7MJS8nZ/RxVgbN9kxpW4n3E9C?=
 =?us-ascii?Q?HLc7JwK5tUvF49VYqk+xnnzqA+Zqz36NfeLvHWXrW7/e6/8DP6QJ+cpYBA2o?=
 =?us-ascii?Q?+DsDgXpOQUePuNvLFm1ecLV6u7xb/eTyWVGMjEPWR+vdhm6EcqnKMeaIYliG?=
 =?us-ascii?Q?F/ND3WEoP3w3933CKD0ip+XuBEn6PWxItspu?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1672
X-CodeTwo-MessageID: 1706388c-7dce-467e-84c4-1a6be78aded4.20260108135313@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 de4ef799-d5b9-492f-8471-08de4ebd42fd
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|1800799024|14060799003|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?hGTcnd90LHUt10zryuvnP7v6r/0scGKQ6u5A/QjLo4W2nYuk0Ic53J50xD2x?=
 =?us-ascii?Q?2y5NxTr8yY95wBqq/w6CLZN5PpBMQ7JJAnxkAt0KXPSkkPyPJ4mdeSSG1qhc?=
 =?us-ascii?Q?uEiKvMxPmqv1T5t5JRLkp6FHenbMDUruPh8nNDHB+KbPuWe7rF2HnzmNBWx6?=
 =?us-ascii?Q?rMerM510aP6Jn07mSyfEBsTWfBQLfjhm8HHCdy2M2TlW6f2v/HJV6QpZUMsG?=
 =?us-ascii?Q?yWh4u5qUv610wLi2oZg38K2b9O4yYRrzesJSeY8DQro/IOCMBryGuHptH6B/?=
 =?us-ascii?Q?zgtZgIq7UEyYoVjY9gUlrXSe1YWuNvw7uD7gtqNDy4O4r2bfQ9G/qXP1gt+w?=
 =?us-ascii?Q?FJPCzptZU88NEqq15wzy+Cpn2YEAET0uSEDaUrDOx6Q0CBFAczYjEKz/h3HB?=
 =?us-ascii?Q?BAwsjJFbKewDxIrYGIwP8IqFcgQ9OZWZ617BaB+3y/8mzRZQJRY2+VH1rwAH?=
 =?us-ascii?Q?Zd/NZ+nsmAqIMTz1nKBuNAKZr3pN0cc/CxZC8FI6UX03PI0JPbbQZbyRIsjM?=
 =?us-ascii?Q?aC0XrHSKbZgX5gOy2WeTskPmQbc+mJlUaRNd35UPh0dO49HuQWN3fW+e7xBT?=
 =?us-ascii?Q?f6DWLseVeDm5KesSew7dtj1bmYZLB2t5dnobVa3IfCkg7zrc7Mz0IkOPrRoN?=
 =?us-ascii?Q?cuhH0COiXss3mzf0Y9gHY0tkTfjrNMBoXzDhQl45apA/Dm6Ug8LgtLXphyDM?=
 =?us-ascii?Q?B9NhtvqLGExJR4zRB/L3yExebLMYZeTTC+6QbdhyyhGSTlHglcxeauNCCFrm?=
 =?us-ascii?Q?Lp3BTDC+QRriJD78xcmVD2sSWLltk3gAW2naOuNaIxBxhDHgJNa1WMywCi7a?=
 =?us-ascii?Q?jHicYFQELDrSr0lhzHH4frPus/bqjW91YacfRJ6NaSjedKxOtVAO3daRWPRY?=
 =?us-ascii?Q?JRYv5AaSFILKw2wN4cIecXQc8WPsK3tBlrvZbr3t6fSgndkT9QVYNUuba7x0?=
 =?us-ascii?Q?bkoG//zLeHFWEk3c2BnLnSz2jHuOkcX2LV7GYbz9hljmWBVnhViLjhC4wwHZ?=
 =?us-ascii?Q?+st/z9y2gTNsIq5Kxa9Hv34/Kf2CcCJME6mx0Qw/x2p/frqKe4pnItbiBNmD?=
 =?us-ascii?Q?b35+z93mMjIJ+d2U8KzVEuLu5C0r7rTYvJkhsLa+RkfIUkQEc1loiPZ4T70T?=
 =?us-ascii?Q?pfBL9xc2RiQTDcY78Y4n/kH/3Q+JLG3hAGBaL+3m0Fs+y1RXNnDAsY/MJOTx?=
 =?us-ascii?Q?cSbZjVW7BehjxlKDYQ+cZ9Mr/Y1vKrGIFDtk2uh+RwJ10Bmo0vVsQA9Zembu?=
 =?us-ascii?Q?vMUnILZJJ2eOfFHzxpoIV8ktT+606cQfb6XyZ9KnjMZBzzJ7D9+ZjgHCUJbX?=
 =?us-ascii?Q?siFranWhNGqX9NRnXYAwPx3EbjQc0dcFm0CykcOcoBgoAMFWItxIkZc0HYtu?=
 =?us-ascii?Q?TE2SYC9vYeKR+nfcpGWW5NznI0XlKoLYKAD0Qe7Ekg03LkFA1mvlM2aR6zYK?=
 =?us-ascii?Q?Ojpo9gLYG87EXbtOioor0dWxvvbdbtNou7XOTeoGru8MWdAKQG02qYdg2eYS?=
 =?us-ascii?Q?5QgJa9r4JSGhR+ogifbEJC1LozZQxTk7UgJ8HOk8oBhjt0vad/dGVKswGzkb?=
 =?us-ascii?Q?c53VwXLdGmri5j+1Yko=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(35042699022)(36860700013)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1955
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.54];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.54];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7f71c422-6603-4026-9e2f-08de4ebd44ce
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|156008|35042699022|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H2tvKSNIqOfQQo0jUFKCau3c6whcSBuDPvWLBN7DjHywsb+Qvl94SWErOFks?=
 =?us-ascii?Q?CS2u2/kI1B4/JMKk3RdLoAxDsavx6E4jPBe0WntrackChxBshc/clv1uzySV?=
 =?us-ascii?Q?IBS2n5w8xvCzeREW5J011OzvHfA6p0Z9q9Ls5xSpAHZqltvFc6m9N4VkLZRn?=
 =?us-ascii?Q?VnIvrKJVlGawdJBhzFPHQ8zB3xQfTaH0RIo9kFcpvgKUW+/S3iVDWuZ0fvAY?=
 =?us-ascii?Q?q27sxR0jMmNIqAvwGEZn95e+stnyfdOjpqqxu2+crj129l07hA7sWj8/pjeG?=
 =?us-ascii?Q?ZvpGWucl6hF+ZpIuzu9Pli8QU/6gAIsXE1gR1Fi6esjYkkczLAD6Zzx8wPDw?=
 =?us-ascii?Q?7pd9+vqyB4ewrMcT9+OE8ONIcqd0x0Xjm7gYNMztQLFO2W1v5SZQN3DnEkeP?=
 =?us-ascii?Q?QQ1/iNwGPnZHWkWkJTqx83TTVJ+PediiA7floYE+0rMfyQ99JI72MlT5wutB?=
 =?us-ascii?Q?e+dUf2mCAjCJLwd+XGsC27a6ynX7pdp6rO1CJ97VlLBp7T8vzeSi3uqx1919?=
 =?us-ascii?Q?d/+9jOCOA1fxLMUYRBbdQApfXPnRq3r0NhVOovUHtKLQu4+2ZwopOVb+U90H?=
 =?us-ascii?Q?B7ah/k4/DDAZ4YttD2GyQTczDXGNXR4p2PEFmsA+6FtGtH2REX0RhdaTufVm?=
 =?us-ascii?Q?vug70gSUUdO69WRIUi7zsETQN2/dgkalSVdUEg1KGJl3XyvhJWmLljNng8pA?=
 =?us-ascii?Q?uY/rGiVda5O1oSYIN3WMeWoHubJpiJgPmwxaTVZB0wMuQFOVDO9/qbohOoSN?=
 =?us-ascii?Q?Ft4J2arg+xdlYeVopC35QATeTrAkj5tWvDU8LZsipYzdEmvwlgpi7D3waVSZ?=
 =?us-ascii?Q?LdSYhYBB725yvPcn8SJKraw3c+ZjDM/8e+XeQjt2O+uY2kVZILuQ0l7HmsSx?=
 =?us-ascii?Q?GYzEIYwbjVYFQ42p1G0pnz9/pvcHxlmhwviaF2Hf1sWWW5t1VU3Y6NsPXJut?=
 =?us-ascii?Q?gE4ngk1vDBTVisZG5V1G463OPYcte9T26Ccp8GXcvhBu1EN/vsiztKAh/xLH?=
 =?us-ascii?Q?Bg1vAAeydPah9xzoxiY3F2pTPiCYS5xjAATIg5bGidKq6Zt/EyFPX7FWwkMY?=
 =?us-ascii?Q?z9uQ4uG6hSj3H1W+Qw4/q5x/P8o9S9C5qmxRTk3NlFCYyi70cPDeF9tF8Wfh?=
 =?us-ascii?Q?I4/hdhX5ogiK?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17012054.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(376014)(156008)(35042699022)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:53:21.8721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401898a7-9eb3-4bfa-250f-08de4ebd4960
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR5P278MB2102

The first patches I sent for fixing the autoload problem encountered
on mcb device drivers were 2. The first [1] was focused on updating the
modpost process for letting kbuild to access to the data within
MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
on all mcb client drivers.

They were rejected and Andy suggested me to split the second patch
in a per-driver basis instead of sending all drivers' changes in a
single patch once the first patch was merged.

The first patch is already merged on Linus's Git repository for 6.19-rc4

commit 1f4ea4838b13 ("mcb: Add missing modpost build support")

So now I am sending this patch for removing MODULE_ALIAS on the mcb driver
in this subsystem as it is no longer required. This cleanup is being sent
to each affected subsystem separately, as per the review suggestion to ease
the handling for maintainers.

[1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodri=
guez@duagon.com/
[2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodri=
guez@duagon.com/

changes in v2:
- Renane commit message

Jose Javier Rodriguez Barbarin (1):
  iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS

 drivers/iio/adc/men_z188_adc.c | 1 -
 1 file changed, 1 deletion(-)

--=20
2.52.0

