Return-Path: <linux-iio+bounces-10035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B997B98EF20
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 14:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAC7B21EE8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C0171066;
	Thu,  3 Oct 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AhqnYXNf"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B951547FB;
	Thu,  3 Oct 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958192; cv=fail; b=SfB8siwgyeNiYQXIT5sM5op1IeR2HKhjEWf/eLDVgZBGahhLBdvmKP6+jV3KsfN6xs+zcKzGO8cy2+nAwAUdxC+0rc23+lj+10UT6PRfvF24HA2aM0zbTHRkXJkKWlw0vgu57VCf0toB1eiJdjiFHCNoanN5OxfXJvLrJ9UkvMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958192; c=relaxed/simple;
	bh=+Np1i8xL2Rd3ouGdna1LexAQ9V0EVFUot5mb5P2wE30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IL54k9JxCIMzLbOlZRqTIgY7cMASUJ+dEewxJalco1An/4VCdgMPivpcLF/ELsOB7CucpGFg08o/H++mteNQkt8mf3GfFXuhLBPXb7X7i10BSdqYvmErEx2GRjca3QcLEC3Dq36egKtJ6KyDucmRX3QQY6WoloEMfb1rr7lDCkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AhqnYXNf; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuvDeiwaZAwPSxMOzYJj+aDzWYYoAXT8MVTQ4XLWDPOwYs8dq5MMhJM4efl/OKwQFwV8r5CvtVHtV3Sv0MZ26nqVM8lOX4dt5hTJ3cetMWDyrhdSDgiceT2qhYYgn5SSaRpibWJkvVtINBq23flWbHPiwkGsF6g+00Hg5XDxlltd2vtWbUXIw1ubOFcR0ctRZsyriCEA/lyp7/ztxFipt7mvpuHrqGNFmXq1UGYaKOb8yc9cQv0dbPKBxRJy2RyKVVpwasWD8MRd1UqCVKk1bqX+UmqwCdBxO9Q2ESA9XhoMGGA08JgU6AdVebGcGTNy9mPhzKizOfKpZBd3nJs0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JzVgzd9D6gtlpyjhqF/pFgxQ5aTRbyWrBEbf49pT9A=;
 b=q7dtuE2FLyqP8tvzaR8gUMzCGdX0Jsi5G9YosBll4tGKh0EL1PcHRHfFUhvSDmLhd4xvK8Q0AecOIJeWs7L6T13+SPtvHxhr2zxKt8634UD9mghvlUNElWShPWVaPs/h7jGMNspJ65/pTWRX/dCFsGig298Sfy0jauWXM49qfCgf7iQcmMCUKxPQx+8fhoVW3x7mXbH3hwgNI1KnkatHPO7FDy+Y2d1KnlxwNx7jnih1wyIrVRCiQGLHw1hreuKjNziHN6fZKkagYsl5HvUwe8P4cdzF+WL/gPkDgUltN3/SFxq4iS4cDTpkcfIrGstNz+DNfbpeltUHZDMBmyMGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JzVgzd9D6gtlpyjhqF/pFgxQ5aTRbyWrBEbf49pT9A=;
 b=AhqnYXNf0wbWeLGbMUpVPQ4gfZgRwVqTur62et/uIDCJDS0VUlOj1EEvkkV4sVOKTIm+zxorPYEIiRFqbW8emru2Ooty8A6qerNpcpjtKf481h2K6ryHwOvV0/+b47OaTZRRnmq67k/BchvuJrX1oXC32ZYY7F0ZBHag1jrClbE=
Received: from DU2PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:10:3b::23)
 by DU2PR02MB10230.eurprd02.prod.outlook.com (2603:10a6:10:46e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 12:23:04 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::85) by DU2PR04CA0018.outlook.office365.com
 (2603:10a6:10:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 12:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 12:23:04 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 14:23:03 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 14:23:03 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 49F2212F;
	Thu,  3 Oct 2024 14:23:03 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 5264A2376CC3; Thu,  3 Oct 2024 14:23:03 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Thu, 3 Oct 2024 14:22:17 +0200
Subject: [PATCH v4 2/2] iio: light: opt3001: add support for TI's opt3002
 light sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
In-Reply-To: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|DU2PR02MB10230:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ad6d9f-dbdc-40c2-298c-08dce3a6217e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTBQT1lYRzRWZjBuT3dPbGl4WVo4TjVNOVozZFI0UU15dUQ5RGNyMkVqdDd4?=
 =?utf-8?B?VUtoZ3N4K1BmZFhyVVc3N1hhT1p0NnJzTTRWUnlDcGxsZVVLa2gzVms4cGl4?=
 =?utf-8?B?R2NLRmRWbmJ2RUJ3VVo3Q3RKd0hKajdTSmt1Slk5RDU1MUdaTUdWTnFoZnpS?=
 =?utf-8?B?bmhPWnRuSFBmSGZqRDBKclJ0QmRaWWdDbVJ0d2Q5czFVU1daNHV5eFhTdWtI?=
 =?utf-8?B?bW5LMkhVdmhjMFJKazIwcjRTazlUQUliOEd6WDFkQWs3aFBkNFFhalRKd2ZZ?=
 =?utf-8?B?aWY0SUJ6Sy9wTTl6Zlo5TmMreWxoVHhtMFFYNk1tVEJJRzBsbTFvMEdSb0V6?=
 =?utf-8?B?YzkycE83ZkN2MFZYSTBLNnBBZ01meHVNNkJkZTVoTXV2MTRhMFZyc1cwTS9T?=
 =?utf-8?B?WDVXNE1rQkNGK3YwdHBjdWFkY2xTS2xabFJXdXVCL0g0ODJpZ1FuMUFlcmhu?=
 =?utf-8?B?dWZTMVd6ZFJXeHg1ZUVjeFE4RkFSSW00dVVKOHBSa3RYWmdmbFRNTmhzS0ZK?=
 =?utf-8?B?LzJMeEZJQmFBMDNCdjBTOEo2R3IxSWFsWmdoTkRqdHByYi9XbDBNd1YvdU1M?=
 =?utf-8?B?SzR5MEhGN0phbEFrQjJRV0hObTZxeC9JMnhwRFRGT29tcFo0U0F1VWpvSVZQ?=
 =?utf-8?B?RDdrMTliclZCSHBERjAxU2gydGozdHU3QTZseWlwTExEdmU5TFVvMGlQVDI1?=
 =?utf-8?B?N3VnUTZLcVoySkJWdit1bUhFMWxSU2VSVnVhNzFsRGFGcThEcTI1TkJ1akZa?=
 =?utf-8?B?MC9xakJIQkh2ZTk0QmxUamVtWUFEZ0Y2U1h0dVJWSlpRdEI4WWFITmxTclpB?=
 =?utf-8?B?ZE94a0JWaTVoNnptU3U5bUtveFpCUk9tYVVrdGpJRjJlNlYrT2YzQkpKQW1m?=
 =?utf-8?B?dnJpZi9hZ1UzZjRZbkE4OTYySmNOTHZnb054RmpocHFxMng1OG8yMnBOQ2th?=
 =?utf-8?B?OUdVSi9RQ2Vld0VqdFl4MHU0Y2FJOGxsNDFKTFZveGZVM3htUSs2OVhrenJ4?=
 =?utf-8?B?UnNneWhGUHdKdnlZU21hRlVKTTJXZkJjT0JkS2NielR0TzVvVXN1MUN0QUpL?=
 =?utf-8?B?VlVTU2lLK3hXK1NxbklNdHduSzhGSlRwL2ovd2xhRFFMTlIzeU1CTW1VNXhT?=
 =?utf-8?B?RkwxOXFxSEEvYnpMLzNYMnJJc1FteDE4eUZYKzkrNlhIbFZQU20xaDJ5L3Zu?=
 =?utf-8?B?K05iTDdNd0dlQXZWK2x2YXFLd3Z3aEd6SHR5T0JPY0N3R0VTYkVHdFVOQTNq?=
 =?utf-8?B?WUIwa0xIS1FOVEErN2pqL3c1cCtWdWMrYnpQOFljNFRUYkM3aXgxcWFZZGF0?=
 =?utf-8?B?U3QzcWtxWVJMUkdra2hpaXlNR1hXdEptVmxqOGFpekN6MGF5VUMveTN2TWli?=
 =?utf-8?B?c0dyWjM4VU5wK2ZYRmlTb0tVUkNtUy8renBPWlJWcXpvWkZGUkJvYUQxUnZv?=
 =?utf-8?B?UUFXRHFSV3BtVmZjQlZWODhxelRUOUlZRmU4WStjZTN4dnFvVjAxUjFsa2Ju?=
 =?utf-8?B?TDhoZHRMVGREempGWGJpdkM2RVhCVnlyeWw1YjE0T2x5UFdpVUN6YU15S3Rw?=
 =?utf-8?B?V21zdDFWVnZOenMxZzJGTHJkUXNxMzdXY0p1eXd6SGJKMWRyQzFoQjVrL2JQ?=
 =?utf-8?B?cXE1MnZKRjNTcEJBRk9ZMzhxQm1UZTd2ZkQvdEJXQWk3ZDJIeVBIeFZzNHZS?=
 =?utf-8?B?UGc2OXZESVBHMm0zNnpTOVRVK1l1R2NwS0FOUFozbzdQVjR3cjZvVzFZYlMw?=
 =?utf-8?B?aUxlRXZUd2JQTy9CdEdRN205cWpQelYvWnAzZTlSL0ppUjlLVGJTYzVEZTYz?=
 =?utf-8?B?S2d1UU55RFdZWFdKVkVieUErV2MwZnNUbi9lUEpscEZtVHFmS0dVYXIwWUFw?=
 =?utf-8?Q?xQhldq5DC8Mqf?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 12:23:04.5135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ad6d9f-dbdc-40c2-298c-08dce3a6217e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10230

TI's opt3002 light sensor shares most properties with the opt3001
model, with the exception of supporting a wider spectrum range.

Add support for TI's opt3002 by extending the TI opt3001 driver.

Datasheet: https://www.ti.com/product/OPT3002
Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
 drivers/iio/light/Kconfig   |   2 +-
 drivers/iio/light/opt3001.c | 189 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 157 insertions(+), 34 deletions(-)

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
index 176e54bb48c3..ff7fc0d4b08f 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -70,6 +70,35 @@
 #define OPT3001_RESULT_READY_SHORT	150
 #define OPT3001_RESULT_READY_LONG	1000
 
+struct opt3001_scale {
+	int	val;
+	int	val2;
+};
+
+struct opt3001_chip_info {
+	const struct iio_chan_spec (*channels)[2];
+	enum iio_chan_type chan_type;
+	int num_channels;
+
+	const struct opt3001_scale (*scales)[12];
+	/*
+	 * Factor as specified by conversion equation in datasheet.
+	 * eg. 0.01 (scaled to integer 10) for opt3001.
+	 */
+	int factor_whole;
+	/*
+	 * Factor to compensate for potentially scaled factor_whole.
+	 */
+	int factor_integer;
+	/*
+	 * Factor used to align decimal part of proccessed value to six decimal
+	 * places.
+	 */
+	int factor_decimal;
+
+	bool has_id;
+};
+
 struct opt3001 {
 	struct i2c_client	*client;
 	struct device		*dev;
@@ -79,6 +108,7 @@ struct opt3001 {
 	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;
 	u16			result;
+	const struct opt3001_chip_info *chip_info;
 
 	u32			int_time;
 	u32			mode;
@@ -92,11 +122,6 @@ struct opt3001 {
 	bool			use_irq;
 };
 
-struct opt3001_scale {
-	int	val;
-	int	val2;
-};
-
 static const struct opt3001_scale opt3001_scales[] = {
 	{
 		.val = 40,
@@ -148,21 +173,68 @@ static const struct opt3001_scale opt3001_scales[] = {
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
-
-	for (i = 0; i < ARRAY_SIZE(opt3001_scales); i++) {
-		const struct opt3001_scale *scale = &opt3001_scales[i];
-
+	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
+		const struct opt3001_scale *scale = &(*opt->chip_info->scales)[i];
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
@@ -174,11 +246,14 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
 static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
 		u16 mantissa, int *val, int *val2)
 {
-	int lux;
+	int ret;
+	int whole = opt->chip_info->factor_whole;
+	int integer = opt->chip_info->factor_integer;
+	int decimal = opt->chip_info->factor_decimal;
 
-	lux = 10 * (mantissa << exponent);
-	*val = lux / 1000;
-	*val2 = (lux - (*val * 1000)) * 1000;
+	ret = whole * (mantissa << exponent);
+	*val = ret / integer;
+	*val2 = (ret - (*val * integer)) * decimal;
 }
 
 static void opt3001_set_mode(struct opt3001 *opt, u16 *reg, u16 mode)
@@ -225,7 +300,18 @@ static const struct iio_chan_spec opt3001_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
+static const struct iio_chan_spec opt3002_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME),
+		.event_spec = opt3001_event_spec,
+		.num_event_specs = ARRAY_SIZE(opt3001_event_spec),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 {
 	int ret;
 	u16 mantissa;
@@ -397,14 +483,15 @@ static int opt3001_read_raw(struct iio_dev *iio,
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
 
-	if (chan->type != IIO_LIGHT)
+	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
 	mutex_lock(&opt->lock);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = opt3001_get_lux(opt, val, val2);
+		ret = opt3001_get_processed(opt, val, val2);
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
 		ret = opt3001_get_int_time(opt, val, val2);
@@ -428,7 +515,7 @@ static int opt3001_write_raw(struct iio_dev *iio,
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
 
-	if (chan->type != IIO_LIGHT)
+	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
 	if (mask != IIO_CHAN_INFO_INT_TIME)
@@ -479,6 +566,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	int whole;
+	int integer;
+	int decimal;
 
 	u16 mantissa;
 	u16 value;
@@ -497,7 +587,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		goto err;
 	}
 
-	mantissa = (((val * 1000) + (val2 / 1000)) / 10) >> exponent;
+	whole = opt->chip_info->factor_whole;
+	integer = opt->chip_info->factor_integer;
+	decimal = opt->chip_info->factor_decimal;
+
+	mantissa = (((val * integer) + (val2 / decimal)) / whole) >> exponent;
+
 	value = (exponent << 12) | mantissa;
 
 	switch (dir) {
@@ -610,7 +705,7 @@ static int opt3001_read_id(struct opt3001 *opt)
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
 	if (ret < 0) {
 		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_DEVICE_ID);
+			OPT3001_DEVICE_ID);
 		return ret;
 	}
 
@@ -692,6 +787,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	enum iio_chan_type chan_type = opt->chip_info->chan_type;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -707,13 +803,13 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 			OPT3001_CONFIGURATION_M_CONTINUOUS) {
 		if (ret & OPT3001_CONFIGURATION_FH)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+					IIO_UNMOD_EVENT_CODE(chan_type, 0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_RISING),
 					iio_get_time_ns(iio));
 		if (ret & OPT3001_CONFIGURATION_FL)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+					IIO_UNMOD_EVENT_CODE(chan_type, 0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_FALLING),
 					iio_get_time_ns(iio));
@@ -755,22 +851,25 @@ static int opt3001_probe(struct i2c_client *client)
 	opt = iio_priv(iio);
 	opt->client = client;
 	opt->dev = dev;
+	opt->chip_info = i2c_get_match_data(client);
 
 	mutex_init(&opt->lock);
 	init_waitqueue_head(&opt->result_ready_queue);
 	i2c_set_clientdata(client, iio);
 
-	ret = opt3001_read_id(opt);
-	if (ret)
-		return ret;
+	if (opt->chip_info->has_id) {
+		ret = opt3001_read_id(opt);
+		if (ret)
+			return ret;
+	}
 
 	ret = opt3001_configure(opt);
 	if (ret)
 		return ret;
 
 	iio->name = client->name;
-	iio->channels = opt3001_channels;
-	iio->num_channels = ARRAY_SIZE(opt3001_channels);
+	iio->channels = *opt->chip_info->channels;
+	iio->num_channels = opt->chip_info->num_channels;
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
@@ -825,14 +924,38 @@ static void opt3001_remove(struct i2c_client *client)
 	}
 }
 
+static const struct opt3001_chip_info opt3001_chip_information = {
+	.channels = &opt3001_channels,
+	.chan_type = IIO_LIGHT,
+	.num_channels = ARRAY_SIZE(opt3001_channels),
+	.scales = &opt3001_scales,
+	.factor_whole = 10,
+	.factor_integer = 1000,
+	.factor_decimal = 1000,
+	.has_id = true,
+};
+
+static const struct opt3001_chip_info opt3002_chip_information = {
+	.channels = &opt3002_channels,
+	.chan_type = IIO_INTENSITY,
+	.num_channels = ARRAY_SIZE(opt3002_channels),
+	.scales = &opt3002_scales,
+	.factor_whole = 12,
+	.factor_integer = 10,
+	.factor_decimal = 100000,
+	.has_id = false,
+};
+
 static const struct i2c_device_id opt3001_id[] = {
-	{ "opt3001" },
+	{ "opt3001", (kernel_ulong_t)&opt3001_chip_information },
+	{ "opt3002", (kernel_ulong_t)&opt3002_chip_information },
 	{ } /* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(i2c, opt3001_id);
 
 static const struct of_device_id opt3001_of_match[] = {
-	{ .compatible = "ti,opt3001" },
+	{ .compatible = "ti,opt3001", .data = &opt3001_chip_information },
+	{ .compatible = "ti,opt3002", .data = &opt3002_chip_information },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, opt3001_of_match);

-- 
2.39.2


