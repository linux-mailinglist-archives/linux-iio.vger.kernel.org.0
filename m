Return-Path: <linux-iio+bounces-9617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1497A4BB
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 17:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2537B2F97C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE61158D80;
	Mon, 16 Sep 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dzj6ArRv"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BB156C76;
	Mon, 16 Sep 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498667; cv=fail; b=gaDBbe+uc139itlz9fGPHJoPHEkBEfYgwpaBk7Yz7mMdKIhe4sfBKIgvxL0CxNL/9v7L1IrsXTN7TApKalFbXqZK5UEr2vdPr5V4HnCmjxlAS0uiXnCvxw5UgC3pPjJtWdW0ZxB2GyEnBQJJ4IYkzkQXeDXX4W+LSbDVOjelnsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498667; c=relaxed/simple;
	bh=2+85WUU5/qz0k/NgQACMjUDSgUWC+9xJNHfJ7d8EmDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gyGQ0OhZaLacEZA38FTUiH9Zw5K8nu5RLTnsT8DxA2l267asVw/5JSuqu3OvTqLZjF03RYLU8+xv8KrH5ZJ2YO/abNr8o2DMu/5t31N1jg9ZK8f/i/msrgbTk/WEnn4GodTIJrjEt1pzbcy0l/5zAU2PRW45JM2oBGsBeYbRjeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dzj6ArRv; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI9SRcSo38Ska6utcxeIMoC8jiny6+LDmx+6AkLY2qvfudM5wXFMVZdQWDLDQDoBcH9SngFkQS+Jk2LhX5HQH1jvkNFI9GR47QgL4UkH86QN/wracJlPqkRpAv2p4xHm62UnCikI3gslEUzVzoEkcTSJSTVvO/bSfKJiEKeVVUz7GreIpbab+KdG3hn+Z2lPLjXq8+kbP15SbavA+ZpBYUJ00s5J6U2J7QzuOMgplYX1sgnFR7ScEuzViQOx7cu8n7Aon34WLt8U9ldZAnjOZcSuiMT0QucOdAKi77mQESuWRX7XyzhfDhUuQkdeqqt81uK0KRbf+eRizVPt/DMc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ip2KQPKJIaWsPmzE7ZZZlFuNxKp87NMVWRV0riojqU=;
 b=XemSclyRMFpIAPEtFlmlsvHu2yhXKSLzeoEqEiqceeYaj1oR2f/181W6fyEAXQtEzPgMWW0wojJMC01khx6q0vhVJUvxJv3Z3uX8XGB1pa7/NpsMtoGBNkfHGtqZ/H/tfefgjNZqqT+NRqGY6RmDrx3KQ1Z6c8EWXy4Qgwi7pws4cUV0JvwQiKw1YRZrlDj8FctSzhIsGhLztPntCEpkTbsbT0D6HI7idTt+cYYqaqnXKi/E98siUqqLMdzOymnGNhZauvHE0i7XnpdxxJOJefO1BuAcn2updbUv1wcH/i6k7Mx3ZRcnl6MPCWtaT07uaTYM+lF131Cajd9f1a6wbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ip2KQPKJIaWsPmzE7ZZZlFuNxKp87NMVWRV0riojqU=;
 b=dzj6ArRvDmypsCNm7oQvetYwahQzf1aumq4kpOq7mYFlTRzqKTlMBVji7lLzOMG9kjYeVhJy2RI9RVYSqwJhEjIlcMc66h919R1jy7BaLkx+N8QoXp8teKr4xxu+bhAvKIw0xGWntBB0iiL8BOO/WFtcs+XE+iFRoRcsbGLWC28=
Received: from AS9PR06CA0672.eurprd06.prod.outlook.com (2603:10a6:20b:49c::18)
 by AS2PR02MB9979.eurprd02.prod.outlook.com (2603:10a6:20b:605::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 14:57:39 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:49c:cafe::5a) by AS9PR06CA0672.outlook.office365.com
 (2603:10a6:20b:49c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 14:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:57:39 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 16:57:37 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 16:57:37 +0200
Received: from pc55303-2334.se.axis.com (pc55303-2334.se.axis.com [10.94.180.8])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 54C282C1;
	Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
Received: by pc55303-2334.se.axis.com (Postfix, from userid 18269)
	id 5084722FBD58; Mon, 16 Sep 2024 16:57:37 +0200 (CEST)
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Mon, 16 Sep 2024 16:56:39 +0200
Subject: [PATCH v3 3/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240916-add_opt3002-v3-3-984b190cd68c@axis.com>
References: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
In-Reply-To: <20240916-add_opt3002-v3-0-984b190cd68c@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Emil Gedenryd <emil.gedenryd@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.14.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|AS2PR02MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd63465-677f-4018-60ba-08dcd65fe8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlhaWGc4ZWJEZUVGMmhPUjRyNS9rYURXa3JrNHRUK2YzcjFtVFMyMjdCWWhR?=
 =?utf-8?B?WGROR2FMTU5QOUc4WFBLbmxjRlQ0cHNFNnZzQ3pnazRHSC9ma1k1VEJBTVgx?=
 =?utf-8?B?NzBkSFJzRDI1MlE3emZ1Tkl1TFBlUloxRTIrdTZabGlWcXRrU294ZS9YbWhv?=
 =?utf-8?B?clg5dU10YWpMR1BUbExneXd5eklCUHZGNFNNUUQ0V3QrTVJOS2NEVnh6Qlpk?=
 =?utf-8?B?amVReTdJaXVBNld5dGRxZmpDY3FNd3YrS3BuUWhiZDl5c1duS005eEFtNjhv?=
 =?utf-8?B?WStUUW02OFZzRWdMUkl5TFNKTjY3dlh1VHgzS1BIVmpsUnF3SU5IenI5OHpJ?=
 =?utf-8?B?ZEdramk1TUJNcGpFUlNuZ1U3MVdJT1F4Mnp6VFYwZFVYdENRRXJTMzZmeHZu?=
 =?utf-8?B?b09WT1JZQjd6UTI1bnZVVDFEOXBVRWZIVXFhQ0YyekthWFVjVXN5VVREaktZ?=
 =?utf-8?B?WE1TSHpzZDVtamcya29IVWl0azRCNkgySHhlQnI4U2dIaERXTVJMZi95LzNk?=
 =?utf-8?B?ZnpHTkpNQjVLenY3ZFY2c2tyVmJOL2JjdHpoQUk2eW5QTHhTOUxTU29FTG9Z?=
 =?utf-8?B?UVplOWdkenJWREF3bXc3YUtYQmtaK05xMHZYcU91UEM3Qmg5ZlNJOHFrbkZG?=
 =?utf-8?B?MU1rcUFZdUYyZWZuaFk4VExDeUh1WUNBZDYzamdUZ3BieEVUcVl5M202Y3RU?=
 =?utf-8?B?VklySkUvUE1YY0hkRjF4eVVuU1pLdDIyTDMwUEpQdnJlUW5IenI4QWY5T3Jv?=
 =?utf-8?B?ZU9NVncyZ2NKNGFXbXhuaDlTeis0R1NUZFRGbHVLeWQ1YVU2ZEw3RkZEckxk?=
 =?utf-8?B?NVI2b2kyNXcvRjlteXFkNndVbU41dUJ2cDdqNk55TmkvMkRPVWtlazZkbTMz?=
 =?utf-8?B?SHB1UTlKQ01BMkhRY2RMTFdiN0x6SXpaYmo5R0dWZWVFeWRjMGVPeDhJakps?=
 =?utf-8?B?anAzQVA2S2NTSCsvbGxxK0RpTW5aYXV1dWJEOHgzaEdDK3dLR0VFWXB6VzBR?=
 =?utf-8?B?SDBpbDFwMVZCNzlQdjRKalhLVnRXcWx3SmRidVRtQnVjOEwzR2xrUDFSMHp3?=
 =?utf-8?B?QnNNK1JkSlNTWWlGR0RDMEhJK3pkbUtXNWVUcWdFUlpxckIxb0pMWUJGRkNS?=
 =?utf-8?B?Ty9JRGtlQVdSdUJKanJmQVg3aVhsVG92VE1nTDcwLytZMEp4cWhINnYwL1lt?=
 =?utf-8?B?S25tbllObVRmU2hmM1B6V2JBUjlPUU9mekw5L0pjRklTdjdjME5VQmVzMUdV?=
 =?utf-8?B?VnlBTUNwVEdZeUZxK0lYYWwvd1BRSCtUNnBETE1MenVRUXBnYXlJbnk4NXM3?=
 =?utf-8?B?OW1NVXc3U3p3bkh1ZEpram1FWGRFWHRoczE0S3U4S3pOakZaU1Q5MmJoWWVC?=
 =?utf-8?B?TTd6YUpuOGRMaHNDdDlXdkF0VFFYK042N3loell0cWlVMmFkeUlrbW16RC8y?=
 =?utf-8?B?bVg4YVFid3I4dVNKTDNGWUIzbUROMEo3RHBhRG9qZnJvQ2dMRUlxbkN1S0Rv?=
 =?utf-8?B?T0E4aS9BNUgzOHZSbVFzOFhzeHFsUGdCbmtsTFBKcERkUkxKTm1hcE9zeEVP?=
 =?utf-8?B?TmhYcHhTQk9IM0NRTWdmT2syRVc0YzhZcTVsV09FaHVacyszVEJoZHRpMk40?=
 =?utf-8?B?TjBjb081NE1odHFKR0ZNTVFEQWhGcnVyTDJNMnovaG9YaU9vRnd0akZweFp4?=
 =?utf-8?B?VmpTVkFvakhPYVY4NEFjVVAyc2F0VDQwQ1UrUytVbXloQUZoQ3pNbTFhVlRH?=
 =?utf-8?B?NDN2NHBiNFBZaU9zNE0zY0ltMkxPQ0g2cEhoUHRvalZTL3hSMWdsZmxSRzZB?=
 =?utf-8?B?bCtFbEhQTUE3cWxMSHVJa0dqQUowbFoxRHB2Y3BBdjBuby9BMVgvOFVsWUtw?=
 =?utf-8?B?dFF0T2YzcTRRaEE3YTVEK0NXZUNDcnZ5cHJhZUVKNzVRV0lhUDB5eWlLazZy?=
 =?utf-8?Q?QqIWP5rcgylEVZBFsdfFvTes5cjInn3X?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:57:39.5637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd63465-677f-4018-60ba-08dcd65fe8d2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9979

TI's opt3002 light sensor shares most properties with the opt3001
model, with the exception of supporting a wider spectrum range.

Add support for TI's opt3002 by extending the TI opt3001 driver.

Datasheet: https://www.ti.com/product/OPT3002
Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
---
 drivers/iio/light/Kconfig   |   2 +-
 drivers/iio/light/opt3001.c | 186 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 154 insertions(+), 34 deletions(-)

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
index 176e54bb48c3..5e3fe42c5b59 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -70,6 +70,34 @@
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
+	const struct opt3001_scale (*scales)[12];
+
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
@@ -79,6 +107,7 @@ struct opt3001 {
 	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;
 	u16			result;
+	const struct opt3001_chip_info *chip_info;
 
 	u32			int_time;
 	u32			mode;
@@ -92,11 +121,6 @@ struct opt3001 {
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
@@ -148,21 +172,68 @@ static const struct opt3001_scale opt3001_scales[] = {
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
@@ -174,11 +245,14 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
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
@@ -225,7 +299,18 @@ static const struct iio_chan_spec opt3001_channels[] = {
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
@@ -397,14 +482,15 @@ static int opt3001_read_raw(struct iio_dev *iio,
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
@@ -428,7 +514,7 @@ static int opt3001_write_raw(struct iio_dev *iio,
 	if (opt->mode == OPT3001_CONFIGURATION_M_CONTINUOUS)
 		return -EBUSY;
 
-	if (chan->type != IIO_LIGHT)
+	if (chan->type != opt->chip_info->chan_type)
 		return -EINVAL;
 
 	if (mask != IIO_CHAN_INFO_INT_TIME)
@@ -479,6 +565,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
+	int whole;
+	int integer;
+	int decimal;
 
 	u16 mantissa;
 	u16 value;
@@ -497,7 +586,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
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
@@ -610,7 +704,7 @@ static int opt3001_read_id(struct opt3001 *opt)
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
 	if (ret < 0) {
 		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_DEVICE_ID);
+			OPT3001_DEVICE_ID);
 		return ret;
 	}
 
@@ -692,6 +786,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	enum iio_chan_type chan_type = opt->chip_info->chan_type;
 
 	if (!opt->ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
@@ -707,13 +802,13 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
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
@@ -755,22 +850,25 @@ static int opt3001_probe(struct i2c_client *client)
 	opt = iio_priv(iio);
 	opt->client = client;
 	opt->dev = dev;
+	opt->chip_info = device_get_match_data(&client->dev);
 
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
+	iio->num_channels = ARRAY_SIZE(*opt->chip_info->channels);
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
@@ -825,14 +923,36 @@ static void opt3001_remove(struct i2c_client *client)
 	}
 }
 
+static const struct opt3001_chip_info opt3001_chip_information = {
+	.channels = &opt3001_channels,
+	.chan_type = IIO_LIGHT,
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


