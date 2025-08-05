Return-Path: <linux-iio+bounces-22306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E76B1B126
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 11:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA757A1968
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28226FA7B;
	Tue,  5 Aug 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="nPS4wfwG"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07A26B760;
	Tue,  5 Aug 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386426; cv=fail; b=uBWDr2s12WOpUAyMzm2Gv7+dZivsA9kp4kkT4Q9VfivYwYakToxD6EOkqXgIxe2bpYGfS6RGRCQDuWyqT1pJiDu3nGieAet/XCY4JDGtTBHPkNSzkKGtqayXOHK30ctlwhqoMlzEX1uELZ1HiNs+d/cIGyDm3p+eUl7YvqVXHnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386426; c=relaxed/simple;
	bh=SicUa8+FvCVeTtIsufRWP14BOZww7E8g1JyvxMfpxe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKyXStIDCaHOBHFQCwraRgmiItxBQFFRMiX6GuiMAsxWQ1VCnEzEDAusSup1bNN2Sbjwtjc6nhVnJtzbpktr+a9utmRqddGutSsLpM55WbK7lpIBP2tXfe/w5G+oogGRKpGZTTNFXYrZaWQDayq0EfT0nJ3xhTKCDd+oCwcy6hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=nPS4wfwG; arc=fail smtp.client-ip=52.101.83.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vydsHIKV4zrxcdOLSnzCsb19yTVNJT1X7BCbrovqtLrqCPEtXRbG6kaX/KsAjym3Z5VWnWNHln1ohFu0ER+pV8QFGoeQgM65kpCYps4LO3/sv4Y6FM4feGHpClEOnrB8yMtQkXN8fwwjoNQSaXVwi1j8Yxfcw/YYF4gJd4Ii2xwfK2r5uWP8ZWGA575kLf3fcBwsjelkvMK/jIKr6OE7bDJd/A8M/gDluXY43oeb43HB3+A5QxgJel92+XXbjX/0UmXpNznJWqPUhQ/KrCNFUUeW6b48LyvoH9Qmp/ae2w5320rGnFRdP6Q8skVPHva10AELeSEXTtqQDybBtjAcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/mF2ks3tqR0L4N+3Jta1iEzgyJNsm1D7OlTQETio94=;
 b=Ns+im18hfUu13QbGalZZAWuNb7YLU/G6WpnDyrRissyXGHsnT0t0W56I+DT9SLCjTK9B/3J9NF0gYhgLnRob841Ww2/lAObLJ53fNqn9kFwP5m2MTIuY+5asZ2zenTOMAWybg/PelvP6+UB+EsiS+B3gee8BUf7aVVtQPpuGmvw88xml6oJulGVF0Yx7c98c1olgbjrTfq0afnpc669Yfy6ErW63ErGcZsIO8405f05gq7+KQiWnFBAxM5bnyriRHvgIt9OgDRLo5lsVETNWxAqm1jHGlUTc/IcLZxydUQbLz6HSB1CL5z3bneSA+nL0njpxuDfNST6BERIGJAMuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/mF2ks3tqR0L4N+3Jta1iEzgyJNsm1D7OlTQETio94=;
 b=nPS4wfwG/NGXfYwQ6itOLBlKxPOhLIlR0BqsTCCnseh8G8jO6X4kVwXZ/rzgZRke7+hzY1VRPcGapu24NuOGlTbjakTpc+QzgV6PAlcog8ycNMwWX/9n8WJ+LLb2/oEeUCNqDx1qbb3mrOeQS86EycA6198Et6ElwKqv0QeipnY=
Received: from CWLP123CA0001.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::13)
 by GV1PR02MB8562.eurprd02.prod.outlook.com (2603:10a6:150:96::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:33:38 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:401:56:cafe::7c) by CWLP123CA0001.outlook.office365.com
 (2603:10a6:401:56::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 09:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:33:38 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 11:33:34 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Matteo
 Martelli" <matteomartelli3@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Francesco Dolcini <francesco@dolcini.it>, =?utf-8?Q?Jo?=
 =?utf-8?Q?=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>, Mudit Sharma <muditsharma.info@gmail.com>,
	Gerald Loacker <gerald.loacker@wolfvision.net>, Song Qiang
	<songqiang1304521@gmail.com>, Crt Mori <cmo@melexis.com>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-rockchip@lists.infradead.org>
Subject: [PATCH v2] iio: Remove error prints for devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 5 Aug 2025 11:33:33 +0200
Message-ID: <pndectqm7te.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|GV1PR02MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0a34ca-fa97-4edf-8005-08ddd4032844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dp+nadf0yQYWm9HFBz002keRLGMG3a0Hp3I7l8Iq/rOtuIy1SowB47mpdIzy?=
 =?us-ascii?Q?z0YRUbH+SivORvPoT0s4L2rqQm6uAeyrWZLSPzV40NMiZrJUCiUZr4AJltG0?=
 =?us-ascii?Q?P9Op+8qDYb+ArCPu/C0tQXn2cXCetpviJXa3NIx1KsrjKyvqfMUP5c8UQhNa?=
 =?us-ascii?Q?PBFl/Pp3pWWWDToNilgki49gGwXL9/jJUz8J224cAsOukQe+SsSAqjwE8t9C?=
 =?us-ascii?Q?2iBoq7N2N3FBuXTTJ7N3tJNkVfHN6R6o4MLYWYP6MgE78NrFeszBVu7iNbyz?=
 =?us-ascii?Q?ShPGfLJszR/z3nhKi5cISxkqLbEVFSHZsas73K63ed3AyepT5fI/euFQHchx?=
 =?us-ascii?Q?7Mc32enz2QPRiKWwV2Fhu03Rxp/Y9dQuPfWLPg+P+5EPWugzkycOOgyExR8R?=
 =?us-ascii?Q?q6KwxPGgossip8Mq7hdSPFIU8IL53nAJwHYPj+/Sz8Ty/JcU12NY7JXpejaD?=
 =?us-ascii?Q?r3FlzEYiUipZMUEwbnFE1YzbUG4om/CRs4UYmig94X0JLfTl52NSBFVsMo/D?=
 =?us-ascii?Q?FCsvSBqCXi6MNEH8SmfTZvNQzG+31YUo3puYAH0UPFrrOEk5IoBiIDX26C5b?=
 =?us-ascii?Q?O3pdD7/ywYVTVex1QfngAjO7fMvIl5VxnTId9kumf4PT0K+rcpbea88LV8D8?=
 =?us-ascii?Q?K8k/0NTIPZg0XUU+SMuxqI84c9mAhxJuwSGq4B+M5n56TqrEGW9DenJIKvFH?=
 =?us-ascii?Q?AkLAEakHj5G7VtZVMN/LxM169hg36WPtVpFOet40dRjQkfk7Ipri9zlwyYyM?=
 =?us-ascii?Q?Wa4mfUzijmIJjcvUBlndChHQ0HneOMmb7oJalS+a7Dfq9XVuTt1kLsNVYKCW?=
 =?us-ascii?Q?1IuS1y5inCcX5P5XASmJEZxpvluzpETmm3OnLiKNC0H6D9BdWW/FInK7G7wL?=
 =?us-ascii?Q?L4KMp3A3HXMerPUJ+GpEoJnf2ckLF+P+AgaGJ5DWRaTtHk8kpCSgGshfNjos?=
 =?us-ascii?Q?NNbXZDgYr4qqINwu6we5I8DM+7ZDbLmNQt3pDYz3D7yHSzafacD2WirPKU/C?=
 =?us-ascii?Q?QlSQWTgBJhvVC0zYz7IRxKDmbEQ11940zoEWpDqDGNiAGppDJ4UWSWrsexK/?=
 =?us-ascii?Q?srdI8aPMlSKckcPewMys0tA1MVjPTUg8PZnl7/9W+KC716KlO7isCGfQTUck?=
 =?us-ascii?Q?LxUlZl53Qk6VpoeW50MDkyKrjLaPSmPsQ9AkKyltObu9zCVKFDZKo8uYUAaa?=
 =?us-ascii?Q?eU7OJ8l9CQEawnAZL+hGis+BbDEUZ1X1bmUj/HtG8N8w52Jarrh0h5fklOKZ?=
 =?us-ascii?Q?gKqahwa9xibiiN0Hc9mfdPH+rys/pkiiLWcG1b2DiEFptA3i0SNrMT/bDsbY?=
 =?us-ascii?Q?jpjdi6MLuPSjkBMAEV+gRx8aY1jszz1kmXCYkej8+vS/VgQig6sB8e3DAiXf?=
 =?us-ascii?Q?tce0WRtkUmoS6v8vS+TOF6YjAWP0u5cLLnWjpxNooE/LtyJhqLdJzUgvDDnw?=
 =?us-ascii?Q?ev2udHSKAXMsCDOwLEqZcaBlQWsNxQNfjGRgVRvxU8nHC6WQEEwdS17Ta5na?=
 =?us-ascii?Q?tg8x2o9WseBjFRV7R4Tf0gDmgFxr50m+x7ABUFvgY7MTbdn3G5Gj3HHfxw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:33:38.1614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0a34ca-fa97-4edf-8005-08ddd4032844
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8562

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 drivers/iio/accel/msa311.c          | 2 +-
 drivers/iio/adc/ad4130.c            | 3 +--
 drivers/iio/adc/ad7124.c            | 2 +-
 drivers/iio/adc/ad7173.c            | 3 +--
 drivers/iio/adc/mt6577_auxadc.c     | 3 +--
 drivers/iio/adc/pac1921.c           | 3 +--
 drivers/iio/adc/rockchip_saradc.c   | 3 +--
 drivers/iio/adc/ti-ads1119.c        | 3 +--
 drivers/iio/adc/ti-ads7924.c        | 6 ++----
 drivers/iio/frequency/adf4350.c     | 3 +--
 drivers/iio/light/al3000a.c         | 2 +-
 drivers/iio/light/apds9306.c        | 2 +-
 drivers/iio/light/bh1745.c          | 3 +--
 drivers/iio/light/opt4001.c         | 3 +--
 drivers/iio/light/opt4060.c         | 3 +--
 drivers/iio/magnetometer/als31300.c | 2 +-
 drivers/iio/magnetometer/tmag5273.c | 2 +-
 drivers/iio/proximity/vl53l0x-i2c.c | 3 +--
 drivers/iio/temperature/mlx90635.c  | 6 ++----
 19 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 3e10225410e8..2ccb22317bdc 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -1195,7 +1195,7 @@ static int msa311_probe(struct i2c_client *i2c)
 	 */
 	err = devm_add_action_or_reset(dev, msa311_powerdown, msa311);
 	if (err)
-		return dev_err_probe(dev, err, "can't add powerdown action\n");
+		return err;
 
 	err = pm_runtime_set_active(dev);
 	if (err)
diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 6cf790ff3eb5..ff778a44323f 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -2035,8 +2035,7 @@ static int ad4130_probe(struct spi_device *spi)
 
 	ret = devm_add_action_or_reset(dev, ad4130_disable_regulators, st);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to add regulators disable action\n");
+		return ret;
 
 	ret = ad4130_soft_reset(st);
 	if (ret)
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9808df2e9242..4481a4ca7ac3 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1300,7 +1300,7 @@ static int ad7124_probe(struct spi_device *spi)
 		ret = devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
 					       st->vref[i]);
 		if (ret)
-			return dev_err_probe(dev, ret, "Failed to register disable handler for regulator #%d\n", i);
+			return ret;
 	}
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 4413207be28f..d15e305d3380 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1717,8 +1717,7 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 
 	ret = devm_add_action_or_reset(dev, ad7173_disable_regulators, st);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to add regulators disable action\n");
+		return ret;
 
 	ret = device_property_match_property_string(dev, "clock-names",
 						    ad7173_clk_sel,
diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 3343b54e8e44..fe9e3ece3fda 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -297,8 +297,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(&pdev->dev, mt6577_power_off, adc_dev);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Failed to add action to managed power off\n");
+		return ret;
 
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0)
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 72aa4ca2e5a4..35433250b008 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1279,8 +1279,7 @@ static int pac1921_probe(struct i2c_client *client)
 	ret = devm_add_action_or_reset(dev, pac1921_regulator_disable,
 				       priv->vdd);
 	if (ret)
-		return dev_err_probe(dev, ret,
-			"Cannot add action for vdd regulator disposal\n");
+		return ret;
 
 	msleep(PAC1921_POWERUP_TIME_MS);
 
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index bd62daea0a3e..926971cb50bf 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -527,8 +527,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       rockchip_saradc_regulator_disable, info);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to register devm action\n");
+		return ret;
 
 	ret = regulator_get_voltage(info->vref);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index d2f86e1ec656..3e4f79dfb078 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -778,8 +778,7 @@ static int ads1119_probe(struct i2c_client *client)
 
 	ret = devm_add_action_or_reset(dev, ads1119_powerdown, st);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to add powerdown action\n");
+		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index b1f745f75dbe..46255c530cb4 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -399,8 +399,7 @@ static int ads7924_probe(struct i2c_client *client)
 
 	ret = devm_add_action_or_reset(dev, ads7924_reg_disable, data->vref_reg);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to add regulator disable action\n");
+		return ret;
 
 	ret = ads7924_reset(indio_dev);
 	if (ret < 0)
@@ -414,8 +413,7 @@ static int ads7924_probe(struct i2c_client *client)
 
 	ret = devm_add_action_or_reset(dev, ads7924_set_idle_mode, data);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to add idle mode action\n");
+		return ret;
 
 	/* Use minimum signal acquire time. */
 	ret = regmap_update_bits(data->regmap, ADS7924_ACQCONFIG_REG,
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 47f1c7e9efa9..6665409a9a87 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -673,8 +673,7 @@ static int adf4350_probe(struct spi_device *spi)
 
 	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
 	if (ret)
-		return dev_err_probe(&spi->dev, ret,
-				     "Failed to add action to managed power down\n");
+		return ret;
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
index 6f301c067045..9871096cbab3 100644
--- a/drivers/iio/light/al3000a.c
+++ b/drivers/iio/light/al3000a.c
@@ -94,7 +94,7 @@ static int al3000a_init(struct al3000a_data *data)
 
 	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to add action\n");
+		return ret;
 
 	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
 	if (ret)
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index f676da245aa7..5eb33e8e3ad9 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -1309,7 +1309,7 @@ static int apds9306_probe(struct i2c_client *client)
 
 	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to add action or reset\n");
+		return ret;
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 4e9bd8f831f7..c7c604c96f6e 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -814,8 +814,7 @@ static int bh1745_init(struct bh1745_data *data)
 
 	ret = devm_add_action_or_reset(dev, bh1745_power_off, data);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to add action or reset\n");
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index ba4eb82d9bc2..95167273bb90 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -428,8 +428,7 @@ static int opt4001_probe(struct i2c_client *client)
 					opt4001_chip_off_action,
 					chip);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret,
-				     "Failed to setup power off action\n");
+		return ret;
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 566f1bb8fe2a..7a1b6c703823 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -1299,8 +1299,7 @@ static int opt4060_probe(struct i2c_client *client)
 
 	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);
 	if (ret < 0)
-		return dev_err_probe(dev, ret,
-				     "Failed to setup power off action\n");
+		return ret;
 
 	ret = opt4060_setup_buffer(chip, indio_dev);
 	if (ret)
diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
index f72af829715f..928e1378304c 100644
--- a/drivers/iio/magnetometer/als31300.c
+++ b/drivers/iio/magnetometer/als31300.c
@@ -373,7 +373,7 @@ static int als31300_probe(struct i2c_client *i2c)
 
 	ret = devm_add_action_or_reset(dev, als31300_power_down, data);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
+		return ret;
 
 	indio_dev->info = &als31300_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 2ca5c26f0091..bdb656b031b1 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -642,7 +642,7 @@ static int tmag5273_probe(struct i2c_client *i2c)
 	 */
 	ret = devm_add_action_or_reset(dev, tmag5273_power_down, data);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
+		return ret;
 
 	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index ef4aa7b2835e..b92fbd27755b 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -352,8 +352,7 @@ static int vl53l0x_probe(struct i2c_client *client)
 
 	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
 	if (error)
-		return dev_err_probe(&client->dev, error,
-				     "Failed to install poweroff action\n");
+		return ret;
 
 	indio_dev->name = "vl53l0x";
 	indio_dev->info = &vl53l0x_info;
diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index f7f88498ba0e..1175c7887ae1 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -977,8 +977,7 @@ static int mlx90635_probe(struct i2c_client *client)
 	ret = devm_add_action_or_reset(&client->dev, mlx90635_disable_regulator,
 				       mlx90635);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret,
-				     "failed to setup regulator cleanup action\n");
+		return ret;
 
 	ret = mlx90635_wakeup(mlx90635);
 	if (ret < 0)
@@ -986,8 +985,7 @@ static int mlx90635_probe(struct i2c_client *client)
 
 	ret = devm_add_action_or_reset(&client->dev, mlx90635_sleep, mlx90635);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret,
-				     "failed to setup low power cleanup\n");
+		return ret;
 
 	ret = regmap_read(mlx90635->regmap_ee, MLX90635_EE_VERSION, &dsp_version);
 	if (ret < 0)

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5


