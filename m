Return-Path: <linux-iio+bounces-21360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B81AF97C4
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FA51CA64D9
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AD328014;
	Fri,  4 Jul 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XnZEEwnh"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012016.outbound.protection.outlook.com [52.101.71.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8B327A44;
	Fri,  4 Jul 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645687; cv=fail; b=kXNdYqSd40RvoZM8OGz0uzaL/N0Pyo7CNsiW9w8NnmwOMcKkgQtED/9j40sU5X8MqqPfSgGGHUDkPxwR40yAq/FbrvRIzeKLfdj5YbIQR9MSpYDqyKdjtrbDqpQm3E0NHazwRTiGsfqUT5gCi8Uv52bBa7IL2xaT120iRb+maPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645687; c=relaxed/simple;
	bh=3Lh97zNuUlwWmgiYA9sCScnAF+x2wLc6lXcGCCZksqs=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=hzUyBfCoENAZQ3NyIJLnod4EXk55H5DxmwxZmKh98bVVF2Vxx3Dqj1iuClokn6vJoodAskzu8W3ve6HOw1IMiYX/4RG8Ykv6YDbPy0KPBqPLGe+JXRXcE4cB49G0sdqtVyZWPAxD2pmBExNIrvKqysAxBA4HgSi97VZMw6QzyCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XnZEEwnh; arc=fail smtp.client-ip=52.101.71.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2CXGHTRXSg00NJHhj9ZYgqEX07OMJlZx1KV/h3/gKSIxVUYML67jQPRcHGTRmqM8ifWrvOW6921mulN5E2rUccIKyBKlgyK9rKw7J0eutRZlnftV3FeaiEaNn5svhMZ9QwsnE6Yn/hzjEXEA6JOjedu9ZBL0GX+wTmwwMCxTjc8gNINXojPoBl6PR1RG0dztY04ghsoC+UKoLbX+vu3rWAv+P0QmnYTpci7Kr26ZdUcz4sbrsnrl0XiEfSNVIxTRM56yl4VWkguGdyZD0vGUyyvnnTRtTvgzKD/XZ1ThoR1wiIC5S3vHCnvUtcgA1H3m7SJDNckdUAQb7zGxcQqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zao9i4hK0Igw6t5Um4rKfileXPteOsT34WI+1I/RVzU=;
 b=jgM1uWa6gFpIli/G/UtFxoEn67YUOR5oenPBdif+sY6b2TKiP9Hhelj8cfJLC8oQg7nWUc3sgYN1CQGUcSNzanrTlocbdzFj7QXalqhkYK5KX2phult61ZaukrWyCsS30uKuYo6l2kPVNOumId+EQIm1I0KOePwr6lQZHS1JojvXD6wfIP3ihfbPI4LPaGWo3QX571VRNgCVsgaaAwISylrfQ+DXrS6rc7ar2852EjGxwNHHTEfGeDssS9EKeEjzQOliY2A8rQd1DknEOuSmX0g+gG/YYFvTpLmF/92hliJNrZzboch2EAZJzfVrlVxVbZWYbJJfHcS5MDOONo32Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zao9i4hK0Igw6t5Um4rKfileXPteOsT34WI+1I/RVzU=;
 b=XnZEEwnhNrzB4zTj7DwkK5mdiuHFq/SyjxE8QaKR2+xk6J5fUgh1NLdMjERFgPUL5rLwD6tzzcn+bnKti3cSXmBnZeoTP3McAxlTU2FKjVkmzs81zfqhxl8FeFBRo085ArnRM4Tazx4XXdrOTcYckgLFx6i2ZcAP5NoFYSa1IbE=
Received: from AM0PR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::44) by GV2PR02MB8625.eurprd02.prod.outlook.com
 (2603:10a6:150:76::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 16:14:39 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:208:aa:cafe::49) by AM0PR01CA0175.outlook.office365.com
 (2603:10a6:208:aa::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 16:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 16:14:39 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 18:14:37 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, Rob Herring <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Nicera
In-Reply-To: <cover.1751636734.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <b52e82aa312a52c03d2b6c58cf329884d1829d29.1751636734.git.waqar.hameed@axis.com>
Date: Fri, 4 Jul 2025 18:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|GV2PR02MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5174fd-bffc-4ff4-3026-08ddbb15e06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2MFdARVk+Kzsjr6sU6Zpqc7inaBKL2J14LvUzf3gCxCsB0JmKRfjGPlr20R?=
 =?us-ascii?Q?GniC2+LRWzy6BzpBRHH2zY6ShapWCWUjMAnNLMXkldzpK6jveYpgIuIL2GsQ?=
 =?us-ascii?Q?oCXzV1Y1BOBCwnO2R9Qlqs+nLgyShT56rP+QuZ4BiGbP1cOsOlzcaD93ij3U?=
 =?us-ascii?Q?O1yhT8fLhXUlPNdm5f1N0U6X0HoHwF2mRIfS2sJg7HbbB8T8P3DLGT/pVum+?=
 =?us-ascii?Q?KpulpYnUAag93C5CvosBM9CdviAZQOGgOuGJ5e/ewIuR3ZzrK3oDbYgoGqLB?=
 =?us-ascii?Q?bO01iS4fB2cm2zdXj3OlxVrqPQpQjs1dID9f979w9b7dXSs+Yq0XmKAbiLee?=
 =?us-ascii?Q?a/5sIO5caonHDAPuXceC73ciZ7ke0bxQOYa6dk3NuGIuiuLjrcYRVKZyMbcX?=
 =?us-ascii?Q?DV/Qpnr2AiFNWg+uh7YropcQWbA9hztpO5oQfNV/MqUH79joZjfYheOsOVcX?=
 =?us-ascii?Q?mdU64g77jf09UqypvLrxPKrhFtopcCjYa+BX7FufWRz7amz+D/RXdBTwkCRm?=
 =?us-ascii?Q?qsrfiDMrAPtfyE/rmrQ1H8G+n7sJylIjrnJomKZTpbBmphAT0yB5Sje+Be0P?=
 =?us-ascii?Q?tY8oW1NU5oNm3qPftdp8ERIjCzMgElZD1qD2E/igWk+FempKYA5LqtZ85N19?=
 =?us-ascii?Q?sHxiFeg9ooZMM0djr1IOgpC21DVrjKJkqSbE4PI2bF8LNW+ZIHb/e+DkvNtl?=
 =?us-ascii?Q?bai7rBBOgccLHyO2S49WPQl7lAE0S6bU4MtLJ14oIoOVQlLwkedW0sQMBL6P?=
 =?us-ascii?Q?YDr7MnDKAD5OEDuhYfVslallLRdm89i4SAydlyb6ykcdn4ya0JH8IgD5ZnGp?=
 =?us-ascii?Q?eo+SA6d/m+dT0KcU3/iVJb04bDWe8boXGGiCAsC+D5XrkjIJSl0okytv5ipD?=
 =?us-ascii?Q?brQneKrKIqgaCqL736khIvLzFI+h5usFhGOaT0p3qZBnftDAmW++f8+F/miQ?=
 =?us-ascii?Q?bLm2JTq3AjUozIDJ3q4qoWvwTNxJIP08J31NOQCftZfUFx5WVs1kw4fFDr8N?=
 =?us-ascii?Q?m53BUv78OXvmHx/bavAzPVa9lqmC7GUwqlXAYdyyE24oTUsqLLwsINxZQvo8?=
 =?us-ascii?Q?r45t4z6Z8X2E5sTuI0g/xc/i+k7CBLAjHX2FSrFAo0Df+TjT3oAPZ474iOLe?=
 =?us-ascii?Q?mNisXPrCjW604D76csBibSvfBsEBJYAciObBR9MuhHKbk3pRI05JXCTKpZPZ?=
 =?us-ascii?Q?biDW1VG4TjPYZk1j0vrAXzKvE5tFg7/agwBtWE69Imwz8lI2JoyXcKkI7KLN?=
 =?us-ascii?Q?dDiX07QzLNRnHlWvAh+PVt8egBbkU1puafRdTHiEJrx0Ga88MwZk2dFKwdxz?=
 =?us-ascii?Q?ia9OwhkqXBYenHbhHoqWC8O9W925PhPmpjfhRZodW5looKuFekt4iZYpPtPZ?=
 =?us-ascii?Q?YeccV5QuRwSXZTT95Sxhsgv5Ic1URI/wcXXhabwewKRhyisyUbx+HUHkoYhZ?=
 =?us-ascii?Q?RMPDn9Mdx9C+XD/mur/tg3mwf5hLilk3W57/laNtia46F+VKUrlVEdpqmqdf?=
 =?us-ascii?Q?x5dKwNB1AFhsnxHY3vpv4XlpGNAcLowBy9Dh?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:14:39.0139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5174fd-bffc-4ff4-3026-08ddbb15e06f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8625

Nicera (Nippon Ceramic Co.) is a manufacturer of a wide range of
sensors. For example infrared, ultrasonic, gas sensors and much more.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..9df4cb54eea9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1067,6 +1067,8 @@ patternProperties:
     description: Next Thing Co.
   "^ni,.*":
     description: National Instruments
+  "^nicera,.*":
+    description: Nippon Ceramic Co., Ltd.
   "^nintendo,.*":
     description: Nintendo
   "^nlt,.*":
-- 
2.39.5


