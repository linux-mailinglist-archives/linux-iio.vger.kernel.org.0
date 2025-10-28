Return-Path: <linux-iio+bounces-25587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56BEC153DE
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99CE1B24E2A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28933B978;
	Tue, 28 Oct 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="leTCwtAk"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2002550CC;
	Tue, 28 Oct 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662974; cv=fail; b=I8upyH9dwIHxuMTeZ7261dGTvss8mtBEm6GBOc3ZvwV40kX1mzFm9dXDYokXzJ22+Fc39oWjJcCMeXdquAFCKHzgt0F9ojNNPAv676MpZfQ/9f5LSgGNwzicahBhbBr/SOanv0PZJMZFVSxi93xbpNwyhG2t7KvDNEFI0CIc0Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662974; c=relaxed/simple;
	bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IPGlNIqIOlHdz/VE04Y1LbVBHS0QijxErpnCSTTW5r9jDr2L4aDzQANaHnPqQSy5TdkauTpuzYd7QtKtifcB169svQdyeHFhcaIpMAVYxIZwRSEK8lGrmOiIu34ReAjP0ESEqHC8kN04JFiEG89iNOSMhSm3Cysm23/AYXSvkOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=leTCwtAk; arc=fail smtp.client-ip=52.101.83.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1s4WdaM92AcOpdX0o5O7OCvUSPeLKOqv8Sq8r8JV4DmTi5X74OLKYMpdK7zcO46HPNv7f6KSBeXK8uoa54V9bVF9bPUISZ1ijgH6J1iP9qzlW2odr//pH53bmyQyrmkg29ZYHQ+ICM3tz3gdQkqF83iQjYfNTRqZt0lLOKz83fN8N0SKmtToBDYolajPduyX+3MXd9PU809oih//upc2vXYbKndOKNsNuCE7BGmzQH7P3HL4fH0dtLqufz4gcqOglhExTeHGEqL/CXHOouOv81qvIgNwSGkFOt6nH/VpImIOM6lIbbHG2tAZpa6Tr/3F2La5OBNl1LwjG6DgrSK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=tm2Hkf+54i2ytcfkxmwwJwxnM3Zf0h4zENBdAikBrOoSTVnpBTE57gJf/Lc/D2WqiJr5YNWR8WIIdoVQ6GN9Dzyhkcvx1UkpoEbtjfh76MTkWPmKDyWOUQxLWPTgd5lxOu+iEZt0RGTfrA5UfkzBEX5ZFLpob7Jg9RuqoQ2Z9BL20sN7JjE8T6MwjAMbuBQJlTHOClbeWjN84775ZmFcEoie/KfutSN7LH8AxaDLSjcVbvNPnG5zMiPELi4ur+L2MA9Ki7cHMewLNWsxEXpkEtMZWVytazsMuEvniqsRtwKQKrNO57x8k0GZPbonAlTgvcN3hqKkNWmqJI9/9v+h1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=leTCwtAk+H4oqIJcK6wO5eqjnvQk0+ShnprxLL/tWeQbRLH1jxpgRbAiDM4xnVA0d+mqO8wszu9aYSvFt2wYCAHZ0bJ+Wib6ifUd8y65dOAADyEcb9EScdeaA3vEGwZmu0ao0Nr/bgo1UHfE/i/m6jfG+2wdha0zVVgItUKC0FRnVDWIZXxdSxPG9KZ/7A3huKkqTaF7ab8I0T6PKj3gKd6XcdSRzIRl1FH5uxQ6uSNIUMxpPlxODkM6Q+7rCDFzOqUu/Qd93bMYuMrczTJyvsNYNe0iG8McYVLedPflVssNP/nNJ6jxRFfkGP20YGlzoxo7+WnjHf/+BD7F7R1wrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:49:27 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:49:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:48:59 -0400
Subject: [PATCH v8 3/6] i3c: master: svc: Replace bool rnw with union for
 HDR support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-i3c_ddr-v8-3-795ded2db8c2@nxp.com>
References: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
In-Reply-To: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761662950; l=3017;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
 b=LJw9RKwMIVKodj92/bBhNlLwsst/bhdZ+2oBpl0ICfUDGLaXJxCqTPxKTN+tmIZMyN6x79is6
 BXZcdnZ98teAszvN6YcF1m28DlaYNdcwcRG7qZq6RtwARQ1jE4oVcP9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: b1eaa38e-8ca9-4ed2-0209-08de1631318a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjRmNEEvc0U2VjkxWEVDTEgxelV1RDIyYy9zUU94K0ZFd3UyYnpINFNPWTlN?=
 =?utf-8?B?eXNzdkV4RXN2WkNZZVBlbE5kTWVLYXhCaTZBSkJZL2tBTUUwVFpvRUNQK3pV?=
 =?utf-8?B?WVc4RUZnSzdmY2Vsd1FYaTVVV0g4cUl6aVFtTWNaY3FPUzExSmczUW9Ya1Z3?=
 =?utf-8?B?eHZxMjNGRStHNWRDM2RRTFJzVTlDYVJFa3dzQk8yWHN0WFF3eTRYSGlPVlNt?=
 =?utf-8?B?QnVtRzhtL0Q5WTZ2bGlMQ1JKNVNIT25GellHT2hlZTRvZFlid1BGSldEU1Nx?=
 =?utf-8?B?dXZRNjRublBzeVdoMmhPL05OU2VDeUxJT21JbG9XcUZ1T0pTbmlFdG9yWktU?=
 =?utf-8?B?dE1hdWVJYWtRQWlqcG1uQ1FFNlNYS1RmVWRWdlNTYmNQTzhYeWYwc0FjWEhD?=
 =?utf-8?B?bnJnRC9TSUFTOVNHc3EwVnI4TEprc2ZGS1oyRGtyeDJLcHlaUEdNcVN6UlJM?=
 =?utf-8?B?anQ4MFJDMGhiTXAwSXNaYkZzanRyY0pqcEo0VVowYUprME9wQjAyR0k5aElq?=
 =?utf-8?B?VHFoaEt0aXhTc0RMcFFtM0ZRUmFIUE1aSDhQcjlqd0Z5Vk1iODlwNktBU3Mv?=
 =?utf-8?B?cWtDSU5qRm5QQmhPS0c1OFBIMVg0ZHFxVktZbXJLQkFhT0FGOHpoaFBRbDNu?=
 =?utf-8?B?VllHRGRMNFlsTklJdWZwbjNJb2lMMXkvenFDK0FjcWtFTzBIOVJMNVF0WEt3?=
 =?utf-8?B?TXVFNnVTV0t5Uzk5YitwYVZRK2lFcXFORjVZNko5ZnA3TWpUaDhOZUdLZ1N2?=
 =?utf-8?B?RnNXTjhKNTlyY1d1Nkc2cDlLS2E3a1cxRHRVUDBTYmorUkdiZG9SYWZkU0R1?=
 =?utf-8?B?NjNYZlYwWHVWNmQzV0JjYWdvMU5pM0F1ZjVXSm81aTBFZkxhd1NsRXpRODlC?=
 =?utf-8?B?QitMbHAyZjhUSTJiQjArclkwcGx6K1lJQ1BVaDhkcEFUWlJiNDU1S2htdFlq?=
 =?utf-8?B?WEFVNUlXTW9qU3lITnFtNE1mVDBkNXgvVUFHM1VkTVdORHdDWmdkRHhFMXAx?=
 =?utf-8?B?L1NDWWI5TXFGaWRkQzE4WWsrYmF5aU0vMW1KMWZLN3R6N1dESmdYRWZ3ZE42?=
 =?utf-8?B?UnFiLzdOcUhibU5SRDJyVGc0SVZha2lMTFZXUy9QbUxxTmVCS1V0bjJQUEgv?=
 =?utf-8?B?U1RMQlVRNjZqZS8zbEhPRENsb0dBa0x6eTE1REZabzJGVUpVYThMTVpKVFJz?=
 =?utf-8?B?TllQcUZPbDNYd05SY296MVFlcmpaL01zeWt4ODdnckZ4dUQ1bjdjSUFoV0Rs?=
 =?utf-8?B?cVdjcTNDTFJYQW9iSkdiY3k2eGdVL1JScHZGQ3hHWldHblZEL25rVlVxMTZY?=
 =?utf-8?B?bjdKbnRGclFxWVNRSnhKZnNqcXVYTGZwTVgxRlVNaU1XRWd5NGRPZzNHaHhh?=
 =?utf-8?B?T1BmbEQzWTR2LzN4MGhPcjh0cmtNazNpNW4wQzVYMGxHSCtFRThQS1ZXU0sw?=
 =?utf-8?B?cjhwemxQdHhPdEFNRi9qaWVzVFY1WkVPWDdZTTVNLzZGM2Z2RWdBaEdPWjY2?=
 =?utf-8?B?ZHVKZ0hFVHdBblB1SGtjVDN5SVhBK0FEZkFyVjU0ZGwxOVlYdlNEbEtQWHFZ?=
 =?utf-8?B?d084V1E2bGl4VVN3eHZCdVJ0Q0t2TGpFTWlGNWFMeXhWMUIrWVdlVVNXR2hC?=
 =?utf-8?B?MUlWQXhEMzJMY0VqNjh6elFRQ3VkV09DbmQwUWNDaU5DNnFoWnBmanZJZ3pn?=
 =?utf-8?B?ZkJ2Q04vdzVaRjZaWk9Qd095K3ViWkVWZjZtelpBOEc4RFp4NEhCb2JyVlB4?=
 =?utf-8?B?QUZhTFM3SU5VcU0yM2VuWHI1STZhVlUxZWdQeWZ5T09kRURCVTduVnpPYmZi?=
 =?utf-8?B?ZEk4NDJyQnpnTVh0UmliWVpwRFM3YlR2aGs2eDEwdmhZVFAzdFdCU0RXNUxD?=
 =?utf-8?B?S2R2YnBSc1YvWG5pdDMrUVNVbjBvYVlReG52OHNFMHZ3OHUxVnBsZEZQSm1S?=
 =?utf-8?B?WmxEM0JTWnp3aW42UHY3ZUM4Z2RNVFliZGh4c2VUMjBhTklLemRURmFLbzFZ?=
 =?utf-8?B?bXJzS2Rlc2liUXpVUnQvTXJNOWNKeDBuSjRjT2FXWC90MW5TQ0lYSWlnRTg2?=
 =?utf-8?Q?qs2jXz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWNrK29Xa29qZUdWVDRzZEdWT3ZSc1FqeGlpcDJHbGw5NmpENGl0VFl6R3BK?=
 =?utf-8?B?RDBPakhJYlR4azJlQXkzUE5Gd3FYZWNDalBhOTMxbG5QL0hienpTSjRsR3lX?=
 =?utf-8?B?SE93QWJnangwQlpIcWFoWHBDVTJ2RG5SRG9qWG05UG5oZCtaUDNtWHBiNkZ3?=
 =?utf-8?B?bGQ5cEJKV3cyK2xadHYrL2o0Mm91czhYN3dZcWFnSENOWVIxUmRaenltNFhU?=
 =?utf-8?B?Z1lvY3R5NXg5WXRZMXllZ05CM3U2dVRJbnpXOUZGeW45RnZDbVdLam9PYU1l?=
 =?utf-8?B?ZWI4NHVnM3EyNEFWT2dKdjFGSlhpUlV5aHNFdFk3ejNoM3VKQURzQncxbllO?=
 =?utf-8?B?WkQzS0NwREkrVlQ1U0RkM3lqaWxKNTVOM3VWRVgxRGx2WWZURmV2S0FVRGdU?=
 =?utf-8?B?UDZleXBVVkRMUHQwdG9CaEhVQ29XWjY3N2xNdFlPdXRqb1VyYzlxelY2d3ZS?=
 =?utf-8?B?MWlYbFp4RUFwK1VKaUVqTEZmdTZGYm56RWVvbXRWSVh0eGZpRS9GY2lmUW1M?=
 =?utf-8?B?N2tiSjRSVTMrUUdIck93WENTTmI4citxQ2tZNTV4aktZazgvdnNLaEhmQU0v?=
 =?utf-8?B?aHROQmVLUldIRkdrSS9WbTJjMFREbEJJT2oyNjZoTnRwQWhycm1JZW82VTd6?=
 =?utf-8?B?VXU1amhiam1NYWIySTVnMGYzdG83UzNkZzlEcGxGUWRaUy8rUkhuNVFqL29m?=
 =?utf-8?B?cjRIQmF6S3dvVnlTWnRYcmU3MVY2RFllZC8yVmhPVXNnT0g1NHQxZHBvZzNz?=
 =?utf-8?B?VGt1djBuRlNoa0txeGx6aXRyaTNHdko3dVhKTkdTSFk5STgxVllrWnJVcUMy?=
 =?utf-8?B?QUJjcXh6VW5ha3JlR3M1a2hMbTMvMTZHVXRIL0FRdnFiNkJVZHpKRXR1am9L?=
 =?utf-8?B?MzRUN0lvdjFmQi9ROUEvQmZMRUNHdG04RzJNV1BZcHhwa3hISFMwaERpRlhH?=
 =?utf-8?B?U0NnRTNhQW1wQm1TbDVOL3FBUkpnOVZpUVI3WHlLc3FpWUZJVUdaSWw3dTcw?=
 =?utf-8?B?Tk9TdnlaZUdqMGlpK3ZEcVA3SkNKMTlIZWZmVDJzelJpQjF1U0RZd2U2UHV0?=
 =?utf-8?B?QXBHb2crdlFpaG5QSnYwMGQvQTdrWCtvR0tIV0xHaldOY0JBOHdYNDZnc1hY?=
 =?utf-8?B?ZDhnTE1FWC90TGxKdUVHc0gzUzNMUCtFeHpMWC85VEhuczFNK2FGR2ZPQ0Jm?=
 =?utf-8?B?LzBxbzdmMGFYZ1MyMk5mdW9GZ3o4N3l0Rkl3TTlJZ0NlMHRpUlFxZmlwZ2I3?=
 =?utf-8?B?N0xFaTByZWNQYjY0NWV5RWIyQjdwUlFCdW13N0dheFo3QWdhbS80MHpMOXAr?=
 =?utf-8?B?THJrZS9QZEFkS1V1UWkrajlUL3NnUjdicVlVR09BNGUxcTR1eHArVGpvNWVG?=
 =?utf-8?B?TzVTWlRzZDZpT0g1TE1tSUo4NmhEUnBvWEhSbjZpRXgrcm43UTFVY1BuRjdL?=
 =?utf-8?B?ano4cEhEQ3puU3VSN1NuaTAvWUk4R0pVWm84MlVyclpFdjdPRUY2Y1pMUlp4?=
 =?utf-8?B?a1J0R3lMZjV3Q1Q0UkhrUlJuYjJ0NnJxUlNkOExYVmg0cVB5LzVyNllBQXA4?=
 =?utf-8?B?WXZiT1g2bytCQXRXcWg1SG5UYmxTd1kveWd3UWsyTUFvZnFiVEVIS1lYMGIz?=
 =?utf-8?B?LzFMT3BkeVVqemRzVXZTNlNXSWg4S1RTSkV4S3pvckxJVXErdXAzSmU5KzQ4?=
 =?utf-8?B?TzFTVFJLUXpvNUhBWXVuZC9sY1A5L0xlWWROZEcySG51dVcyUWthUzV6dDlv?=
 =?utf-8?B?Uk1LWWNNZ2I5Qyt3OE82b1AxektLZVNMeC9LVlRHQWs5aEowZ1IzeXFXcXBO?=
 =?utf-8?B?eGtOQVYxM3pMUmwrcklKL1EzRmIvcFExSmZDaDFIWkR5VTdsNkYvSCtMT1pl?=
 =?utf-8?B?TjBBdTIzK1IyUVhrSkYybUF3emlZTXlDZU14OE9PZTc3ZXpPU2JhVHo5SUJH?=
 =?utf-8?B?dXBTMzIveUVER2xyVFpqbjY3M1VXZy9PTFNEa1djRWhHWnJlbXp3ajNnOWt1?=
 =?utf-8?B?WTh0R2hFSjdUN1I3WmUxRUcvZEphaW10QWtvM3ZmWUlvMnlVSzJodVhsWWUy?=
 =?utf-8?B?cVhLU1lZbjRUM1hzVDEwZE9LRmY0d1NtanZORDY3QUptVDliZFNTaFFlZ3hh?=
 =?utf-8?Q?uUbH7PX9mPmUbB+ynMsAeTCNt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1eaa38e-8ca9-4ed2-0209-08de1631318a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:49:27.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fd9nUkfEfPsrrdcehmqpMQnlKhF1UFzzoN6kLKdcrtukXB1mCDmmwvteNDyAG3z1dKvg+zcR+kHuL933fD5oVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

Replace the bool rnw field with a union in preparation for adding HDR
support. HDR uses a cmd field instead of the rnw bit to indicate read or
write direction.

Add helper function svc_cmd_is_read() to check transfer direction.

Add a local variable 'rnw' in svc_i3c_master_priv_xfers() to avoid
repeatedly accessing xfers[i].rnw.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v7
none
---
 drivers/i3c/master/svc-i3c-master.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9641e66a4e5f2da3bd84b30fa741e5e19d87465d..7c516e05d0a1a118479ee3d8ea8ae37ae19fea57 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -165,7 +165,11 @@
 
 struct svc_i3c_cmd {
 	u8 addr;
-	bool rnw;
+	union {
+		bool rnw;
+		u8 cmd;
+		u32 rnw_cmd;
+	};
 	u8 *in;
 	const void *out;
 	unsigned int len;
@@ -383,6 +387,11 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 	return master->descs[i];
 }
 
+static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
+{
+	return rnw_cmd;
+}
+
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 {
 	writel(SVC_I3C_MCTRL_REQUEST_STOP, master->regs + SVC_I3C_MCTRL);
@@ -1293,10 +1302,11 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 }
 
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
-			       bool rnw, unsigned int xfer_type, u8 addr,
+			       u32 rnw_cmd, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued, bool repeat_start)
 {
+	bool rnw = svc_cmd_is_read(rnw_cmd, xfer_type);
 	int retry = repeat_start ? 1 : 2;
 	u32 reg;
 	int ret;
@@ -1484,7 +1494,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
-		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
+		ret = svc_i3c_master_xfer(master, cmd->rnw_cmd, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued, i > 0);
@@ -1677,14 +1687,15 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
+		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = xfers[i].rnw;
-		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
+		cmd->rnw = rnw;
+		cmd->in = rnw ? xfers[i].data.in : NULL;
+		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 

-- 
2.34.1


