Return-Path: <linux-iio+bounces-9185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834796D5F5
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10330B260DD
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFE19E7F8;
	Thu,  5 Sep 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bDlL+Fqo"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E8199FC5;
	Thu,  5 Sep 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531735; cv=fail; b=ajuL1et+XCCR92DiJO9/2Hi5+mkj8dA1yS3Yk4k50ShtsSGpA4aFOPH950pDg1rKVgeXdn+/MMTTg8zxOpBCyM2GlGO9EvgPXnXllwIa7HNEuQ7idRP6sVhw6vnrhutdm8KYXdynZF29lBhhewo4/g0JSbuLTUxphFNnvEbqgdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531735; c=relaxed/simple;
	bh=BIB8ZDciXXFymqc4yOQh/xte7qV/DQy/ClOcA0+kCuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mhaG+G7AuBzGWbrs6U/iHiJFjXt6M55CFqoAJ1oqKyZEaNgKTONEMI620udG74vF8XdSyY+/NFbCAZuILFOX8N6i6X5I8fqIkXEWJnUcTD3ASqDgbEw4o8UC9JpOoAbKv+mTlYz1LEbcnKL6LXzIY6hAy/1EsaVH+V01E3fWjXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bDlL+Fqo; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi32GbwE87u1U9YWC2ydQpNuIz975JezgJI9I30QMWRYiugskwnYlJVDpfndAmy65fPWGrV/FXRhU4jHBtYK3sF1xNw+u5TrrDdIemZMIZKS51419SyPpEJkwHmbyO4ZuQU6iqkDUuqawTe1jqz2Oc5jCVDnE4vBESCs4Yg9T5iFSQUZsWTqTQwcf2VJfkviyjsNU3Mx5lvjt9wC0nlP1zGMeUZk4eA/sGghyvLegHMWENN35+76GHpgYfz5rti2MG+wxyW3w9Hi4Ld4zHE6cQVSVQ5bux/CvKhsyU7Fct6o2kaz0UQv7iqoIXQYLQuNW91eTdw1t7fH+stboKwN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSQpsVZ17hEH1jUgCp/f/aHUqt+MVyXFjSldi3Ehgn8=;
 b=jJO+8tzrV8ilDQ7O+H/leYidgxihHG1E7czFCbhIumdBXC5lil3ndHBFI3BoQJZ9TZQkrKlqqLV2RFieVKX7wt4qADD9e228FsZgqGHL0GCFfmdU2u/KpjqG2xYwUJ4BmRalMZZk3md5z0YHGJkplPib8SW4r6pcAn5CII9N9qKcCdrm90IuTv+0Net80FYo6KxL5NS99F9zUbKJDWZI7mCnLVUs6kF3SjUUnaTriAmt1dEnDz7RIP4gqXbQCXwVcVU6ilqqx/mUY31ra0L/pbOKLIaYpyOcMCTXcSEiXLd65qi6Wf/Oc/cfYkvzL3089VoJeXYw/RamLZKHd7SEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSQpsVZ17hEH1jUgCp/f/aHUqt+MVyXFjSldi3Ehgn8=;
 b=bDlL+FqodMSVseRZkPZ/f5RaOyPCVBvyJGGI14tz6azrnybodUzznh3lbNY1q4q/d8Wc5wqoBzVDnNm8b7JaIRYH0dC+KfJ+/OqX5odWjj6Cggvr4bJpDaznEe8H5O339wOMiN+tcwxNiuZeowSdhvk1oaL2Bx3n8uUIULI/2Mg=
Received: from DU2PR04CA0044.eurprd04.prod.outlook.com (2603:10a6:10:234::19)
 by PAWPR02MB9856.eurprd02.prod.outlook.com (2603:10a6:102:2e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 10:22:06 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::9) by DU2PR04CA0044.outlook.office365.com
 (2603:10a6:10:234::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Thu, 5 Sep 2024 10:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 10:22:06 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 12:22:00 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 12:22:00 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 12:22:00 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5971649B;
	Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 576EC22F8D75; Thu,  5 Sep 2024 12:22:00 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Thu, 5 Sep 2024 12:20:46 +0200
Subject: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
In-Reply-To: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|PAWPR02MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a572cd8-c761-4252-f55b-08dccd9497bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2kxenAxemJRaS81K0ZFeUU2TWlxMDRkRUlJRm90dXBIRTZHOEVGRGJFWFpj?=
 =?utf-8?B?Mzh3d1AwcjBWNTFoaEpVSkV6ZDdHbFpxZlNSM1c2RFhqUDladW5WZU1icU9O?=
 =?utf-8?B?RjQydmFkQU5hUzUzM1pzNU1nOXNzcE1oWUZwOEMrZERnTkFTRTFhc2U2YXpT?=
 =?utf-8?B?WlhEZ1hoRDZ4TjJNVERtMXdXKzhDOWJiOEFZMnYwemJSenpHY2NnSlpZSFlM?=
 =?utf-8?B?QWdSeVhDanpONFlIcVhYMjdJNm1VTk9NQk85VTZJejdZMTZleUV0UjNuK0Jr?=
 =?utf-8?B?REpVUFhmNVpPR2ZIV3hFeG5CS3pMeHVPWlBTYzJLYnZPYjd0WGxQN2xRb3R4?=
 =?utf-8?B?R0Zwd2tQVCtDSk9LZDRzZGJUVGV3N0FOSXlCaEdEeVZRU1lVQTdtQnhGaWgr?=
 =?utf-8?B?MU9ibi93Y01rZlArZll4Tm4wRC9lN1k5UnRDNXBNdjczdzN3bnNVREU0MW5x?=
 =?utf-8?B?UFN5V1lDaFJzWFQySFBBTWVlVGduQmVpZ0IvTDZtYkIvVjhGL3dsVGpSMTg0?=
 =?utf-8?B?Y1JmczRZby8wYlpoVUZaR0JEanI0R0VIWmp5bU94RkZqUWJYOWJyQU5JbzB3?=
 =?utf-8?B?UkcvQkJIS1RCK1RqZWx0Y2l6U1hnT2RLMzRGd1NpUWpSS0d4LzFsUWk5Y1lV?=
 =?utf-8?B?WFp1cGU4N21CdXVyalZtNGJWQ1ZOTVRTQnRmd1ZLQVRBWDU5cDBSOHBFSm0r?=
 =?utf-8?B?QVJaTkdacVFRR3lrckhXTno5c3lkbjB3TWtCcmFnK0N1QnN2bGxaMUlsNllQ?=
 =?utf-8?B?bWcwOWxlYjV5aUdlOFFvNnV1WTVXME5INWtDL1JJc011eXZGU1FYdWJpTHk3?=
 =?utf-8?B?VGQ3YmRaSDVoQjE5TEZqa3lFenhPOEkzaWRwaEhkY3diY2RMU0tDREt3QnpB?=
 =?utf-8?B?MU01RjJqNDB2Y1pyRUFxdm9OYUJ1TWFOaFI3bkV3TlNIUXIyRjRoT0F5czNa?=
 =?utf-8?B?WWI2eG16UWFzWEZvWmpIVGprZFZFUXJkUnVqd1BpY0tsdkdoQXFjbVpQdmNn?=
 =?utf-8?B?QXduclFQb0dNSlptL2RzNHNHajcyWEc1VHNhYU9OWFA3U3BXeFFzbFk3NStt?=
 =?utf-8?B?L0NMNHphMzRocmxkdmNhR1NBRGFoaVJxQ1lIMXJYTjhvdTdJWVVNNDNjRDdw?=
 =?utf-8?B?UU1xTFpVblgxWXh0K2EvdXlhb0YybExRRXoyTUpSdXNJWFpwYjdLeDMzWEZh?=
 =?utf-8?B?UERYZ1U3NTB0aHBwcnVWUGpVUGpRSklUbW5PbXkrOVplUEQzYUFpaTcwWFhs?=
 =?utf-8?B?ZFVGbnB1YWczbmJFOXY1aUNJZWZsVGduc3pXS29sYkxmcHJNOVRmWjNJWHN1?=
 =?utf-8?B?azFqRGZXaU5OeVBFdmgwejZJTFJ5MFQ0VzlhWlplamZVamp5c1RyWUw0MWUy?=
 =?utf-8?B?ZDh3a0dwMmhqbElIT09HN3RLcmxuMWhqTExYVU1lSVlIVFpTUVF0dThWOHpM?=
 =?utf-8?B?dDM1MWF0ZTkrR28yL1JnZnl4bjZrbjBpdVMvc3Fkd3lTU1QrTU9ON0tuVk5l?=
 =?utf-8?B?NVpXTGlOdlVGeUJCbUxKNFo5OHdTa1lvRzl3eHV4ckdwQVFmanp2NUgvNWo2?=
 =?utf-8?B?NlU1OExRNGltR0JCN1FJVnplb3NoelFLekFkOUYzYzZyOVpMMGJqRHVURnVs?=
 =?utf-8?B?Uitwb2tqRjZEM3NnWFVXSWNKeXlUSFBnOFlZSzAyV0RybTMzWE40TEx2OVVu?=
 =?utf-8?B?ZVEyUTBvTXpUTk44YXVXNGVtdkNySEQvRys0TGZFaVh6RWwwdnNhWlE3eDNG?=
 =?utf-8?B?NzJNbi90cDVTT3NINS9ncTdrandpaVYxSG10MThWaFJiY3BCZHY3c29BMjNJ?=
 =?utf-8?B?ZkdCc3B3UmRwZ2pGNERZQW5KQWh6OUl4MHlOTGZMN1ZaV1NWblFiYTVOOG92?=
 =?utf-8?B?UFZWS3JDamV4M0g3UkVRTFZIL1gzSVlIWStjRTVSSW9oU1kwSk00Q3ZKZkhF?=
 =?utf-8?Q?IM88N5Vc7KVilygtfblCg/PkA9xP0epd?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:22:06.3936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a572cd8-c761-4252-f55b-08dccd9497bf
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9856

TI's opt3002 light sensor shares most properties with the opt3001
model, with the exception of supporting a wider spectrum range.

Add support for TI's opt3002 by extending the TI opt3001 driver.

See https://www.ti.com/product/OPT3002 for more information.

Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
 drivers/iio/light/Kconfig   |   2 +-
 drivers/iio/light/opt3001.c | 199 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 167 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index b68dcc1fbaca..c35bf962dae6 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -461,7 +461,7 @@ config OPT3001
 	depends on I2C
 	help
 	  If you say Y or M here, you get support for Texas Instruments
-	  OPT3001 Ambient Light Sensor.
+	  OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor.
 
 	  If built as a dynamically linked module, it will be called
 	  opt3001.
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 176e54bb48c3..e6098f88dd04 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -70,6 +70,19 @@
 #define OPT3001_RESULT_READY_SHORT	150
 #define OPT3001_RESULT_READY_LONG	1000
 
+/* The opt3002 doesn't have a device id register, predefine value instead */
+#define OPT3002_DEVICE_ID_VALUE		3002
+
+enum chip_model {
+	OPT3001,
+	OPT3002,
+};
+
+struct opt300x_chip_info {
+	enum chip_model model;
+	enum iio_chan_type chan_type;
+};
+
 struct opt3001 {
 	struct i2c_client	*client;
 	struct device		*dev;
@@ -79,6 +92,7 @@ struct opt3001 {
 	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;
 	u16			result;
+	const struct opt300x_chip_info *chip_info;
 
 	u32			int_time;
 	u32			mode;
@@ -97,6 +111,16 @@ struct opt3001_scale {
 	int	val2;
 };
 
+static const struct opt300x_chip_info opt3001_chip_info = {
+	.model = OPT3001,
+	.chan_type = IIO_LIGHT,
+};
+
+static const struct opt300x_chip_info opt3002_chip_info = {
+	.model = OPT3002,
+	.chan_type = IIO_INTENSITY,
+};
+
 static const struct opt3001_scale opt3001_scales[] = {
 	{
 		.val = 40,
@@ -148,21 +172,82 @@ static const struct opt3001_scale opt3001_scales[] = {
 	},
 };
 
+static const struct opt3001_scale opt3002_scales[] = {
+	{
+		.val = 4914,
+		.val2 = 0,
+	},
+	{
+		.val = 9828,
+		.val2 = 0,
+	},
+	{
+		.val = 19656,
+		.val2 = 0,
+	},
+	{
+		.val = 39312,
+		.val2 = 0,
+	},
+	{
+		.val = 78624,
+		.val2 = 0,
+	},
+	{
+		.val = 157248,
+		.val2 = 0,
+	},
+	{
+		.val = 314496,
+		.val2 = 0,
+	},
+	{
+		.val = 628992,
+		.val2 = 0,
+	},
+	{
+		.val = 1257984,
+		.val2 = 0,
+	},
+	{
+		.val = 2515968,
+		.val2 = 0,
+	},
+	{
+		.val = 5031936,
+		.val2 = 0,
+	},
+	{
+		.val = 10063872,
+		.val2 = 0,
+	},
+};
+
 static int opt3001_find_scale(const struct opt3001 *opt, int val,
 		int val2, u8 *exponent)
 {
 	int i;
+	const struct opt3001_scale (*scale_arr)[12];
 
-	for (i = 0; i < ARRAY_SIZE(opt3001_scales); i++) {
-		const struct opt3001_scale *scale = &opt3001_scales[i];
+	switch (opt->chip_info->model) {
+	case OPT3001:
+		scale_arr = &opt3001_scales;
+		break;
+	case OPT3002:
+		scale_arr = &opt3002_scales;
+		break;
+	default:
+		dev_err(opt->dev, "scale not configured for chip model\n");
+		return -EINVAL;
+	}
 
+	for (i = 0; i < ARRAY_SIZE(*scale_arr); i++) {
+		const struct opt3001_scale *scale = &(*scale_arr)[i];
 		/*
-		 * Combine the integer and micro parts for comparison
-		 * purposes. Use milli lux precision to avoid 32-bit integer
-		 * overflows.
+		 * Compare the integer and micro parts to determine value scale.
 		 */
-		if ((val * 1000 + val2 / 1000) <=
-				(scale->val * 1000 + scale->val2 / 1000)) {
+		if (val < scale->val ||
+		    (val == scale->val && val2 <= scale->val2)) {
 			*exponent = i;
 			return 0;
 		}
@@ -174,11 +259,20 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
 static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
 		u16 mantissa, int *val, int *val2)
 {
-	int lux;
+	int ret;
 
-	lux = 10 * (mantissa << exponent);
-	*val = lux / 1000;
-	*val2 = (lux - (*val * 1000)) * 1000;
+	switch (opt->chip_info->model) {
+	case OPT3001:
+		ret = 10 * (mantissa << exponent);
+		*val = ret / 1000;
+		*val2 = (ret - (*val * 1000)) * 1000;
+		break;
+	case OPT3002:
+		ret = 12 * (mantissa << exponent);
+		*val = ret / 10;
+		*val2 = (ret - (*val * 10)) * 100000;
+		break;
+	}
 }
 
 static void opt3001_set_mode(struct opt3001 *opt, u16 *reg, u16 mode)
@@ -216,7 +310,18 @@ static const struct iio_event_spec opt3001_event_spec[] = {
 
 static const struct iio_chan_spec opt3001_channels[] = {
 	{
-		.type = IIO_LIGHT,
+		.type = opt3001_chip_info.chan_type,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				BIT(IIO_CHAN_INFO_INT_TIME),
+		.event_spec = opt3001_event_spec,
+		.num_event_specs = ARRAY_SIZE(opt3001_event_spec),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct iio_chan_spec opt3002_channels[] = {
+	{
+		.type = opt3002_chip_info.chan_type,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				BIT(IIO_CHAN_INFO_INT_TIME),
 		.event_spec = opt3001_event_spec,
@@ -225,7 +330,7 @@ static const struct iio_chan_spec opt3001_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
+static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 {
 	int ret;
 	u16 mantissa;
@@ -397,14 +502,14 @@ static int opt3001_read_raw(struct iio_dev *iio,
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
 
-	if (chan->type != IIO_LIGHT)
+	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
 	mutex_lock(&opt->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = opt3001_get_lux(opt, val, val2);
+		ret = opt3001_get_processed(opt, val, val2);
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
 		ret = opt3001_get_int_time(opt, val, val2);
@@ -428,7 +533,7 @@ static int opt3001_write_raw(struct iio_dev *iio,
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
 
-	if (chan->type != IIO_LIGHT)
+	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
 	if (mask != IIO_CHAN_INFO_INT_TIME)
@@ -497,7 +602,15 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		goto err;
 	}
 
-	mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
+	switch (opt->chip_info->model) {
+	case OPT3001:
+		mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
+		break;
+	case OPT3002:
+		mantissa = (((val * 10) + (val2 / 100000)) / 12) >> exponent;
+		break;
+	}
+
 	value = (exponent << 12) | mantissa;
 
 	switch (dir) {
@@ -607,15 +720,22 @@ static int opt3001_read_id(struct opt3001 *opt)
 	manufacturer[0] = ret >> 8;
 	manufacturer[1] = ret & 0xff;
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
-	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
+	switch (opt->chip_info->model) {
+	case OPT3001:
+		ret = i2c_smbus_read_word_swapped(opt->client,
+						  OPT3001_DEVICE_ID);
+		if (ret == 0) {
+			dev_err(opt->dev, "failed to read register %02x\n",
 				OPT3001_DEVICE_ID);
-		return ret;
+			return ret;
+		}
+		device_id = ret;
+		break;
+	case OPT3002:
+		device_id = OPT3002_DEVICE_ID_VALUE;
+		break;
 	}
 
-	device_id = ret;
-
 	dev_info(opt->dev, "Found %c%c OPT%04x\n", manufacturer[0],
 			manufacturer[1], device_id);
 
@@ -707,15 +827,17 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 			OPT3001_CONFIGURATION_M_CONTINUOUS) {
 		if (ret & OPT3001_CONFIGURATION_FH)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_RISING),
+					IIO_UNMOD_EVENT_CODE(
+						      opt->chip_info->chan_type,
+						      0, IIO_EV_TYPE_THRESH,
+						      IIO_EV_DIR_RISING),
 					iio_get_time_ns(iio));
 		if (ret & OPT3001_CONFIGURATION_FL)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_FALLING),
+					IIO_UNMOD_EVENT_CODE(
+						      opt->chip_info->chan_type,
+						      0, IIO_EV_TYPE_THRESH,
+						      IIO_EV_DIR_FALLING),
 					iio_get_time_ns(iio));
 	} else if (ret & OPT3001_CONFIGURATION_CRF) {
 		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
@@ -755,6 +877,7 @@ static int opt3001_probe(struct i2c_client *client)
 	opt = iio_priv(iio);
 	opt->client = client;
 	opt->dev = dev;
+	opt->chip_info = device_get_match_data(&client->dev);
 
 	mutex_init(&opt->lock);
 	init_waitqueue_head(&opt->result_ready_queue);
@@ -769,10 +892,18 @@ static int opt3001_probe(struct i2c_client *client)
 		return ret;
 
 	iio->name = client->name;
-	iio->channels = opt3001_channels;
-	iio->num_channels = ARRAY_SIZE(opt3001_channels);
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
+	switch (opt->chip_info->model) {
+	case OPT3001:
+		iio->channels = opt3001_channels;
+		iio->num_channels = ARRAY_SIZE(opt3001_channels);
+		break;
+	case OPT3002:
+		iio->channels = opt3002_channels;
+		iio->num_channels = ARRAY_SIZE(opt3002_channels);
+		break;
+	}
 
 	ret = devm_iio_device_register(dev, iio);
 	if (ret) {
@@ -826,13 +957,15 @@ static void opt3001_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id opt3001_id[] = {
-	{ "opt3001" },
+	{ "opt3001", 0 },
+	{ "opt3002", 1 },
 	{ } /* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(i2c, opt3001_id);
 
 static const struct of_device_id opt3001_of_match[] = {
-	{ .compatible = "ti,opt3001" },
+	{ .compatible = "ti,opt3001", .data = &opt3001_chip_info },
+	{ .compatible = "ti,opt3002", .data = &opt3002_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, opt3001_of_match);

-- 
2.39.2


