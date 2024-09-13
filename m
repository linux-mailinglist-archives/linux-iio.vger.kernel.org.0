Return-Path: <linux-iio+bounces-9489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94318977CAF
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 11:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A262863E7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C51D86C2;
	Fri, 13 Sep 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hVefQoOu"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC31D7E53;
	Fri, 13 Sep 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221456; cv=fail; b=PVfOYl/+VLqqB0ZC/4QKqH6UF8FnPUfimeX24+syUtaEIykDA0mNj2g5DzABNq55CMgoHy6x13n9CPES/HSnG5Q8dVE6vTUKoGVFq0LkoqJcUEOf2E4ennkTs+yqiPSiOVTjCFkmsjJSgP+1oaZb9yzCBfRwNzjeWgV6t9P0ybI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221456; c=relaxed/simple;
	bh=VISKJJYia7Aa4vdw2dFeTCgzjq2obdYcTwso2QuUm4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VjJUZKzWZAyfKCBJCOr360VOXK9QBp1lnd8U82WSSCda+H16Lnqtj7r11GvR3k/9XJrmSFuhgzoKc9sELGb9AxW+JP+bVT/4LtJR5fsMhCCDvS+A9OMefuxVpKU+QnZDKWmvTAA8s7JegvitJvxG3D+MYb1bpcEM6JoZ/iXmZjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hVefQoOu; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOfgnmxUwT4Up9RhRpZYcsxZeRNqgQU1404Ma9t66Y1tz6Dsn0FHmKRuuUss/BSGy6EeRwJbkvU3RUw9SEEkegwg61tMy76FyYwurUOtG2+kugp6GWfwFI/Eqy5mgQcJ/Fu2LVbNhMYYfkUrjkKlj9JY+gbsToadS09OBdoeSXNrA7ZH2tcnXmBR9IA2oxVW0oGWmiSbkel/Z/zkp4ypf6tl2UQCV6wCXRRa502p0ei4WxrY+Siw+XJYJpVcJaEhESWKKy+ORNiFSCc9YL8VLjrDxhuUpmTFuewqLJmuGHGCBepwmV32pwV6hlBm1Oi/dvqJ98eDcYBMy1TvAnR7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuau6s/hloR8fSpT7lZe6PdV9ovjOkQoNcrp/tpud6I=;
 b=t7ZFOwzB3qG+3FsfLwmlgUBohIbOUWGBnkJarmBOS3DIEgxMIUCr6k8DlRAzuA4gIIQcSVkeOvVvgA+aLy0U80DycXYlE7W1q+BqqIwt5XdVowhXvEIhZtVlp4Ukq6XmEoB6OZqsTxhohU3JeZf9thmVdycXDxrcO3k6ACNaxM1JJ3b0y4da5wgBTLtcn5g8gT/RLgO7drOablLqidrdJ8AZ4UlrsjTHwEATj5yi7RGnfezhimdRXwl1o2ngnPahEZpqXicHt0aIq0669racdscvSnJyMF3fT6OQTKPG3s39bARfCLIdB8b/4YwMxCUPqrlkiOAFLH4AoLGe/fvkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuau6s/hloR8fSpT7lZe6PdV9ovjOkQoNcrp/tpud6I=;
 b=hVefQoOuPhzhd7YQKc3T7Iodhp26M6SG6kLcAx4bms7VY2kX6k4pKL4E7UU/YdygVKjhox0J6fKnpvhBIvPcya3kzo/++omyOTUMcnjUVtzQutikE5XdbUDdFMfW4s4IT1kdn71aJQvSU+pweAAulm/PSl4lwosjp4ioVV1OqYo=
Received: from DBBPR09CA0013.eurprd09.prod.outlook.com (2603:10a6:10:c0::25)
 by GV2PR02MB8458.eurprd02.prod.outlook.com (2603:10a6:150:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 09:57:24 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::c7) by DBBPR09CA0013.outlook.office365.com
 (2603:10a6:10:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:57:24 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 11:57:22 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 11:57:22 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 02839343;
	Fri, 13 Sep 2024 11:57:22 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id F3EE122F8D75; Fri, 13 Sep 2024 11:57:21 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Fri, 13 Sep 2024 11:57:04 +0200
Subject: [PATCH v2 3/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240913-add_opt3002-v2-3-69e04f840360@axis.com>
References: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
In-Reply-To: <20240913-add_opt3002-v2-0-69e04f840360@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|GV2PR02MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8f0129-89e2-4451-06fa-08dcd3da77aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjRLN25HVFVkZjdWdEdXeFU3V296NGM4VDNYZktjRUozZWp3V0JJUmN1aW1t?=
 =?utf-8?B?bHNQQWFsazV1RE1tM2IvQXVJT2xTWjNDWmExZGVjTFZJU0ZEN0c0SS9CRmhO?=
 =?utf-8?B?ejdncXlVMzhzUnhicWxXZnFYTmo3RUhYcDhia2NNbmRiNnJtb3RIR3pzSGFQ?=
 =?utf-8?B?NHo5dS9Sczc5U1lmZlRmQnJZZjUwMVQ4WXRCMUdqOXNEcmhkV0UwbEVTRkhF?=
 =?utf-8?B?VHI4Z21YaGxpRXhWNUQ0TWJ6c0JDOVUwZ1lyQVRzejUzWEtDK2Jsb3E4ZWNr?=
 =?utf-8?B?bVVFVXdRcUxyRzJjc2E4bXhaZGpkeDhwdjFMZE8yWHVLd1hEdUZ4L214c2l6?=
 =?utf-8?B?RTJOUEtWSEhXVVE3ZTJjcWhiRDBQSnVFakIzaDdTcEtJYXR6OENpUjNsWHVG?=
 =?utf-8?B?WnNSUGJnZkRpS2l3V3UyMlArbkhvZVArQnIxckxlMW5EL1p4dGtEWWhUZG15?=
 =?utf-8?B?cXU1Q0lhSWJmN1NuN2RYR2l1TUhENlJWRjJoTnE5U1U3VDFtR2d0MjlEdU1H?=
 =?utf-8?B?VFFDTE1ZOC9RWDRaVHU2WWE2N3c0UzN6bit0bkt1NVBkTlZHdGhhQW03aWRQ?=
 =?utf-8?B?RnJ4SUVDOUpMSlNQQmFlRVljZkx0SkI1cDZXcHhuQjhoWlpSY2kzU2duVjNn?=
 =?utf-8?B?cHB0emh4TW1VREpsUlF2QkFOMEtvclN4V0hXUWprcWx3bXgzUXpvTGhZNDd4?=
 =?utf-8?B?OEhEK0JhR2Q3LzYyeVhjdXBwY2l1M2hqdE1ZYngwN3dLRjJCUVJFVHNEYzJZ?=
 =?utf-8?B?dmY1R1pvYWZpRjlsa3oxdUFHVU9lY2pmTStuWjhzdmZVRjZ6cFpmMnRrOE05?=
 =?utf-8?B?MHhsV1k4K0owdDd0KytKTENRdm5KaEwvdlh0VVVPSDI2Si9JcnQrRHFOVXNz?=
 =?utf-8?B?T2tub0Y3b1pvUkxWRlpZd0ZLeThYT2J0enBHNGFUU09rSG5DTlZBZzV0VEZo?=
 =?utf-8?B?NDl5RWQ4SEJqanBuazRadTRTZG1zUjJrbWZCNTF5alFYcUJTV0U5a285VHpK?=
 =?utf-8?B?Y0tFZ3ZoVGttL2t1NVZzKysxSjBtaXJ1di9CM1NLWElMT01rZGlveGJaU2xh?=
 =?utf-8?B?U1NPcWkxa1I4WFg0SzhadTlOVDEwMDU1eXcyNE10L2Y4bXA4MWtaaG9CUUR5?=
 =?utf-8?B?UHN5NzBwcXpHb1M0ZnpId2hIZ2p0U05tblV1dll2Q3FHL1VhN3hMQ0gzdDl0?=
 =?utf-8?B?aW9FcWR0K3pnTmVFTHNLVG9scDR5aXk0VUhEWVpJVTlzdjdtMS8wMVZVOGZE?=
 =?utf-8?B?QmpkL05vWFBGeTZHODB0NC8zb3l0YVZsTy83R3hrRTEzT1lMTnAwRkpyT0NU?=
 =?utf-8?B?aXRtSkNUTFpyUG8wRDc5dGpLUkxDNFdpQnR5L1BKLzlYa3c1TUlEL3ljSjNY?=
 =?utf-8?B?a2VhM3BBZm1KRmNsRDdKWjlEUXF6U1pObCsrb282QTJtYnZjYmVjZmJmMFdL?=
 =?utf-8?B?c0NPR0V4TzJWY09qa3BRTzBZZTE0WHJIZ3pWZ0UzT2gvZmZ5MTZNRVVuQ0hv?=
 =?utf-8?B?Uko0Q2dleitqd3ZYMjJDMXNQUWZKTmN1UE5EMU8zKzJwbStnMlZEUHlNejE0?=
 =?utf-8?B?em1yeFVPeXNSWVJFclB3Ynphbno3ZkFFK1k5Y2IyV1BQMWJVbGlpenNNalg1?=
 =?utf-8?B?bVgyb2RqWSt1ZllhRnlLOVJzU0J4aUZzdm1qTmRwdC9JL2FxMVZJRVRDQzAy?=
 =?utf-8?B?QW5uWExuYjZ0ejVlN3pENUdkNFNKbE15cmZIQy9EMG1WRWE0RlFRek5Vd2dk?=
 =?utf-8?B?eW1ITHRSL3hjQ2dDSUl5ZTE4UHF2NUZ6WDI4NzBPcVI4VU92K2xZTjlyN3lR?=
 =?utf-8?B?RU91WnFUOGNCYkFGc2l5TWNXd09yUldFeXAwMVRiZnl2c1dwUVp2KzY5N1Zr?=
 =?utf-8?B?UTlXdjFudjRQc0VNQXRtaDhFVHhHdG1lS0FjSnNIakhod1l6NXpRdm5tQ3RV?=
 =?utf-8?Q?QIHtobGU/0pyfQe+6M3+eWMtwos4tGgP?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:57:24.2949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8f0129-89e2-4451-06fa-08dcd3da77aa
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8458

TI's opt3002 light sensor shares most properties with the opt3001
model, with the exception of supporting a wider spectrum range.

Add support for TI's opt3002 by extending the TI opt3001 driver.

Datasheet: https://www.ti.com/product/OPT3002

Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
 drivers/iio/light/Kconfig   |   2 +-
 drivers/iio/light/opt3001.c | 169 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 138 insertions(+), 33 deletions(-)

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
index 176e54bb48c3..83c49f4517b7 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -70,6 +70,21 @@
 #define OPT3001_RESULT_READY_SHORT	150
 #define OPT3001_RESULT_READY_LONG	1000
 
+struct opt3001_scale {
+	int	val;
+	int	val2;
+};
+
+struct opt300x_chip_info {
+	const struct iio_chan_spec (*channels)[2];
+	enum iio_chan_type chan_type;
+	const struct opt3001_scale (*scales)[12];
+	int factor_whole;
+	int factor_integer;
+	int factor_decimal;
+	bool has_id;
+};
+
 struct opt3001 {
 	struct i2c_client	*client;
 	struct device		*dev;
@@ -79,6 +94,7 @@ struct opt3001 {
 	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;
 	u16			result;
+	const struct opt300x_chip_info *chip_info;
 
 	u32			int_time;
 	u32			mode;
@@ -92,11 +108,6 @@ struct opt3001 {
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
@@ -148,21 +159,68 @@ static const struct opt3001_scale opt3001_scales[] = {
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
@@ -174,11 +232,14 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
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
@@ -225,7 +286,18 @@ static const struct iio_chan_spec opt3001_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
+static const struct iio_chan_spec opt3002_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
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
@@ -397,14 +469,14 @@ static int opt3001_read_raw(struct iio_dev *iio,
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
@@ -428,7 +500,7 @@ static int opt3001_write_raw(struct iio_dev *iio,
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
 
-	if (chan->type != IIO_LIGHT)
+	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
 	if (mask != IIO_CHAN_INFO_INT_TIME)
@@ -479,6 +551,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	int whole;
+	int integer;
+	int decimal;
 
 	u16 mantissa;
 	u16 value;
@@ -497,7 +572,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
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
@@ -610,7 +690,7 @@ static int opt3001_read_id(struct opt3001 *opt)
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
 	if (ret < 0) {
 		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_DEVICE_ID);
+			OPT3001_DEVICE_ID);
 		return ret;
 	}
 
@@ -692,6 +772,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	enum iio_chan_type chan_type = opt->chip_info->chan_type;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -707,13 +788,13 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
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
@@ -746,7 +827,7 @@ static int opt3001_probe(struct i2c_client *client)
 	struct iio_dev *iio;
 	struct opt3001 *opt;
 	int irq = client->irq;
-	int ret;
+	int ret = 0;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*opt));
 	if (!iio)
@@ -755,12 +836,14 @@ static int opt3001_probe(struct i2c_client *client)
 	opt = iio_priv(iio);
 	opt->client = client;
 	opt->dev = dev;
+	opt->chip_info = device_get_match_data(&client->dev);
 
 	mutex_init(&opt->lock);
 	init_waitqueue_head(&opt->result_ready_queue);
 	i2c_set_clientdata(client, iio);
 
-	ret = opt3001_read_id(opt);
+	if (opt->chip_info->has_id)
+		ret = opt3001_read_id(opt);
 	if (ret)
 		return ret;
 
@@ -769,8 +852,8 @@ static int opt3001_probe(struct i2c_client *client)
 		return ret;
 
 	iio->name = client->name;
-	iio->channels = opt3001_channels;
-	iio->num_channels = ARRAY_SIZE(opt3001_channels);
+	iio->channels = *opt->chip_info->channels;
+	iio->num_channels = ARRAY_SIZE(*opt->chip_info->channels);
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
@@ -825,14 +908,36 @@ static void opt3001_remove(struct i2c_client *client)
 	}
 }
 
+static const struct opt300x_chip_info opt3001_chip_info = {
+	.channels = &opt3001_channels,
+	.chan_type = IIO_LIGHT,
+	.scales = &opt3001_scales,
+	.factor_whole = 10,
+	.factor_integer = 1000,
+	.factor_decimal = 1000,
+	.has_id = true,
+};
+
+static const struct opt300x_chip_info opt3002_chip_info = {
+	.channels = &opt3002_channels,
+	.chan_type = IIO_INTENSITY,
+	.scales = &opt3002_scales,
+	.factor_whole = 12,
+	.factor_integer = 10,
+	.factor_decimal = 100000,
+	.has_id = false,
+};
+
 static const struct i2c_device_id opt3001_id[] = {
-	{ "opt3001" },
+	{ "opt3001", (kernel_ulong_t)&opt3001_chip_info },
+	{ "opt3002", (kernel_ulong_t)&opt3002_chip_info },
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


