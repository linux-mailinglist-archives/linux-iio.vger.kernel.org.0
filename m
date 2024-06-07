Return-Path: <linux-iio+bounces-5999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA2900273
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 13:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D764F2879C9
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3719066D;
	Fri,  7 Jun 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lm8ig1iF"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2067.outbound.protection.outlook.com [40.92.42.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31F192B6A;
	Fri,  7 Jun 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760533; cv=fail; b=eWOM9uJgCG0qLIzwB5/NYlJVgX1as1Of0xLsgBqVJbEyE9AO5C2ibccS9H/qmQ2LbyguurR8b8l8t2WoYpQq534mq2vF+r5zxhr1Fo2ykINiG+AIm2azZTvCXxXK3UMCuFWe14p8/dl61ScyhGS1nNE6fJnYkc6DEGQ4MqQkzbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760533; c=relaxed/simple;
	bh=A30asAVwl3LYppASmdiXLLYux0Hsq+otuR/nOKar95o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/tEY2wye9LCyIFd6e0U1bjTCc4GOtCBn2rcxJ6rClXFIF2KhQ3uKhJ/NpY5L3Dsx224iw0mdvBvWLrjYO8NhA2EPE4/60CtfInVNFJszQjGbKv08Qq7nKGcSsrvkOlJNIUOYJf5lnAiItqxFncMRisXa9LWmw/xAhV8uh8+90k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lm8ig1iF; arc=fail smtp.client-ip=40.92.42.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T31ihcwbUpaJ8uFx6zc2PC/bGMLWpNdwbBt1VS93IQEEcY1yUf3Tty8vmLsPw9D+M39wFP51/AIwGkpintLeBTaX/s66Zxx2rQjOAiKSNmuEJtPC88ypjY6oCdLX6hc5DJR8NsBKScJvohEfe52UpNenXbwq0R6si3p/uCMcwni/bNaKn0k3NQoCrCPkNs8j4YjSwtqRw9lDhZ/QVKmUo11TougLzSovC/4pugExq33WohNccjwRHnz0+YWi5CADkSWiG/lkEOki9RKO5vpBiSQ0JRZPxs5L3pM5WLplK083mqSjzCG6S9+IwEBgbDSwHNd73t3GInXIoF0k0JdgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k1GB2lVoquIRj6VG1pxu8AksAVRg5CvG8x501dYZfU=;
 b=Ji97iNKm80pSf3/DsMeCXZQ8X1jlTplfbJ/lO1FGJX2iYXeFEoMvDZCplv9e48klnCRCmsEMiMFbxFWFGnfA6RsJIeefjTwixKYIby/U1yHW7ORAHHrJjOcijasD9sqookhWgPE40PGo3MYzgCcRYZ6a8Y2hOyGzZj8A2CBK8Uk4houlFHpq6XZWLCvd4DU1sI2YJkzz33qTt/QLsbxchfuNVOSoVLFO8QLS26TEUKNTcfRqtDUHBX8FEgl4ziIvmSj0LiViuFo/Ph0fovWSylkRwxOAR0xSAd5oY0NRtOLnYW6sD6AfiFXbx1AeJITP65hF39KgLqqHtfRvrujO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k1GB2lVoquIRj6VG1pxu8AksAVRg5CvG8x501dYZfU=;
 b=lm8ig1iFLowz9TENy2qP3FPzT5+9MMuD/DR4lK8b+n38pATcqzh1wWWiYxbwxbIEeF09uyM35OI5pevOg6786h7hXW8rSAWIr5BbjHAM8aPZujiOJdPpGcRMxUzkRjCitnsnAr3YX8XI05zSJA+zJgipqLqccGSxFSvV1EzjnxyIm0cPbnEb8Vr9dmLAggXrzw4nbJYRUzyYleYd+fIYG5PJMvAezHaXTFG/Ojrx3QJrEFkajn09aznT4fk2ASQXFMovLHny6WONm8S7mjzWtapAg5Mwre3XQFUolU7qnLfxZCMiHPRL3KMjS4koeggoTQWy9aAAcRrl4rHINNA2hw==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 11:42:07 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7611.016; Fri, 7 Jun 2024
 11:42:07 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
To: jic23@kernel.org
Cc: andy.shevchenko@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.a@analog.com,
	swboyd@chromium.org,
	u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
Date: Fri,  7 Jun 2024 19:41:38 +0800
Message-ID:
 <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607114138.390272-1-yasin.lee.x@outlook.com>
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [93JvojWm+k3OrG/uIQOt4MO4ojC2FeQxKnWiHli3rDL9bpYzVficJEEtLOtEa5WE]
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240607114138.390272-3-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: b7757cfb-7d37-47e7-e4aa-08dc86e6dbe0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	pEmf8G5Yzpn0yMuSFVWI1rH6SvekAivG5Q5ynK0yeIBuI4vtO2AHMjDjYrMoONXEfIGCX29xn/8Vj153cKVjS6G733QYO17UXUlDlf6cawNUMHgnlPR/fZoI9nLl+TCvbp/E/udJA2VkZuSRRcICtYYetE8LrcVsdPs1AR2m2WtbaxsuTSQvd/FVclOAQeLuD3SyvH4VehpDZo5JHhyPZy8oM452AKicQGoyXRVQwAQocrvxwBi9bm8pe0/xXs+5qmhUSc1SG8xUOG86Vj0JIFo6CVqgA3DGz4B/CMPXPul5UB9zPfxNUf7k62Xb3YKLQjbNHu2R7jvbTJn9lXtbMRriUdHJtS1h1ZQtCwJF3z/fdw0Bh7GAAcfMN4EjqHrx2wTCRzI9ztSv5jbGhTmPtYAnpJm+F3Z3C7NewPDX6/2PiFTxAzZ/VWmw0ZP0M+QgfD0gesGVgzQe5N2S9osrR1/VuF7oqsTWNyzT1BET3/Gz4D2dKgnT8iAzfR1kVuOUCnQ5k9NEa8fUTCrBcmAlnMB1W2HV9c1VR4tw3mMsGKsNP0achhqiDQmCoEoBeWPmPmW72SWIdzKH+acoxa2TxEe74DKt684tiS9dRQMCHLEmZq1393tzsCzkJIv/pxoe377ZAwp2EJV6FsvwRxDCud8IzzrS2nnulVVnGQJdT5/WA4Z0akxpHcGMDrufpqyV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4vd7bivQcv/m28otUvCuH/rX14XCYcf4m4evJwf9bixzlzH/fJ2DhuNd10/r?=
 =?us-ascii?Q?Z5T+fhU4r+8h7ZAmcz2XIK/rKVeQ4JSK9qZWVpGsG7zVVl9jRg0Jp9fbr8oJ?=
 =?us-ascii?Q?qyFoP3BgvxmuMQdyBpwyJ3ZDh5vgRqC8JBe+f8RWHGA8AsEy3piqOYP1Bk7X?=
 =?us-ascii?Q?NvhrsPf7kKVYlorRzK3kl90jwNmrxsA0VNlBWGUp0t6e4Wor6BClK4BF5UYv?=
 =?us-ascii?Q?evtGzlkUHqYb4SjNkCSgP1qNrCAOqGr4gA5Z27aFOMq4MqkpCrQy41SpXz1x?=
 =?us-ascii?Q?XYxrhoiN91gUsFcd6x18RgBzao4tu3GnkxfWUA+XQr7xQibcPoMbxOold1ep?=
 =?us-ascii?Q?3lIfyW84D1GdpiIijRHHOPMD2Gx2IXU3lAeFtYnCsXfPJV4PDP6L5risbDLw?=
 =?us-ascii?Q?pJXH/fTbD5iPsdShbMMLG5xT6btzvdFabml74/QovW7/T0+ZXka6Hhsz+TAP?=
 =?us-ascii?Q?c9HlIslLUqwHmY4yTR0gwRHKGTl+94GRFivX1B4BQSxJX6lIKtWX8QCn4tNX?=
 =?us-ascii?Q?wqVXMuLngh2EECa+Ww75REhs9cAQdoh0VH6JftbcGR5YZbEIt62UackMkXXS?=
 =?us-ascii?Q?ikmIX4eCLYHjTHjn63sgcjolH3RR07lcx4vux05gyoBZpVJWNjf3BIrE+GQV?=
 =?us-ascii?Q?8A7jti28o9Xwcg+4mcthUrLc1d3zDQn1vyalM0//nbRglndZyYKA6tyvcoGP?=
 =?us-ascii?Q?TCskJMCICwXBtafM4z+yHw9CixbEDo3GrZ5ZTMMVYgANpt38gN+F++pAH5I6?=
 =?us-ascii?Q?OQY+tfo3vcJ/9KnT8REndtaNOZPJsGWm+hYSLWvwZ3mWDe3AHkaAU2xFKIYe?=
 =?us-ascii?Q?LuPl1GiXBYYM1CR7rk6kbjwK1ajk0hsMvnxtXlcxMdGs9C/jvzxgy7+XULmA?=
 =?us-ascii?Q?ALx0iFt+9aAGCccMotS8zAoKkH0M3tJD3xF/I45SphID/1P9YcF0Yjt2HLvR?=
 =?us-ascii?Q?77QeWlv/Kj9PlYnjB27b9rHpamh4Ibciuxj40jEaDSWXgp0xMvE3/edWOOHy?=
 =?us-ascii?Q?mjZDdwntXmjQ3tZuNlbaxKapiUCkQNtcjYkZXdYGEaMlIYqcvybkqxNDumly?=
 =?us-ascii?Q?sNGzWZHbuj4t0IiRjfV5nqPnwSzT9akcOiCLgTKYKSTH2zFuc6fQs2G4a4uc?=
 =?us-ascii?Q?9A/33pM9VocynUe02UJJjxmd5C2h78RSnTuCNKMmzFbQ9yUOhw7JPu1yqTG7?=
 =?us-ascii?Q?sOnPC04yEcJt1e5JkUj3hhzYALYbseT2wjkOOz4WGDxf45UqOMNYlBvUGLRv?=
 =?us-ascii?Q?hIcGbRkWdoh6zSvfCiU/fJamZ6+Ic9MGi6RlpHLVfe9TpUYm9b24t0/VNm+W?=
 =?us-ascii?Q?Yd8q4xQzKsD1imsYRUmv2tw7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7757cfb-7d37-47e7-e4aa-08dc86e6dbe0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:42:07.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

From: Yasin Lee <yasin.lee.x@gmail.com>

A SAR sensor from NanjingTianyihexin Electronics Ltd.

The device has the following entry points:

Usual frequency:
- sampling_frequency

Instant reading of current values for different sensors:
- in_proximity0_raw
- in_proximity1_raw
- in_proximity2_raw
- in_proximity3_raw
- in_proximity4_raw
and associated events in events/

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/Kconfig   |   14 +
 drivers/iio/proximity/Makefile  |    1 +
 drivers/iio/proximity/hx9023s.c | 1162 +++++++++++++++++++++++++++++++
 3 files changed, 1177 insertions(+)
 create mode 100644 drivers/iio/proximity/hx9023s.c

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 2ca3b0bc5eba..0694f625b432 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -32,6 +32,20 @@ config CROS_EC_MKBP_PROXIMITY
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_mkbp_proximity.
 
+config HX9023S
+	tristate "TYHX HX9023S SAR sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here to build a driver for TYHX HX9023S capacitive SAR sensor.
+	  This driver supports the TYHX HX9023S capacitive
+	  SAR sensors. This sensors is used for proximity detection applications.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hx9023s.
+
 config IRSD200
 	tristate "Murata IRS-D200 PIR sensor"
 	select IIO_BUFFER
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index f36598380446..ab381cd27dbb 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
+obj-$(CONFIG_HX9023S)		+= hx9023s.o
 obj-$(CONFIG_IRSD200)		+= irsd200.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
 obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
new file mode 100644
index 000000000000..b4a583105e03
--- /dev/null
+++ b/drivers/iio/proximity/hx9023s.c
@@ -0,0 +1,1162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
+ * http://www.tianyihexin.com
+ *
+ * Driver for NanjingTianyihexin HX9023S Cap Sensor
+ * Author: Yasin Lee <yasin.lee.x@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/byteorder/generic.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/types.h>
+
+#define HX9023S_CHIP_ID 0x1D
+#define HX9023S_CH_NUM 5
+#define HX9023S_2BYTES 2
+#define HX9023S_3BYTES 3
+#define HX9023S_BYTES_MAX HX9023S_3BYTES
+
+#define HX9023S_PRF_CFG                        0x02
+#define HX9023S_CH0_CFG_7_0                    0x03
+#define HX9023S_CH4_CFG_9_8                    0x0C
+#define HX9023S_RANGE_7_0                      0x0D
+#define HX9023S_RANGE_9_8                      0x0E
+#define HX9023S_RANGE_18_16                    0x0F
+#define HX9023S_AVG0_NOSR0_CFG                 0x10
+#define HX9023S_NOSR12_CFG                     0x11
+#define HX9023S_NOSR34_CFG                     0x12
+#define HX9023S_AVG12_CFG                      0x13
+#define HX9023S_AVG34_CFG                      0x14
+#define HX9023S_OFFSET_DAC0_7_0                0x15
+#define HX9023S_OFFSET_DAC4_9_8                0x1E
+#define HX9023S_SAMPLE_NUM_7_0                 0x1F
+#define HX9023S_INTEGRATION_NUM_7_0            0x21
+#define HX9023S_CH_NUM_CFG                     0x24
+#define HX9023S_LP_ALP_4_CFG                   0x29
+#define HX9023S_LP_ALP_1_0_CFG                 0x2A
+#define HX9023S_LP_ALP_3_2_CFG                 0x2B
+#define HX9023S_UP_ALP_1_0_CFG                 0x2C
+#define HX9023S_UP_ALP_3_2_CFG                 0x2D
+#define HX9023S_DN_UP_ALP_0_4_CFG              0x2E
+#define HX9023S_DN_ALP_2_1_CFG                 0x2F
+#define HX9023S_DN_ALP_4_3_CFG                 0x30
+#define HX9023S_RAW_BL_RD_CFG                  0x38
+#define HX9023S_INTERRUPT_CFG                  0x39
+#define HX9023S_INTERRUPT_CFG1                 0x3A
+#define HX9023S_CALI_DIFF_CFG                  0x3B
+#define HX9023S_DITHER_CFG                     0x3C
+#define HX9023S_DEVICE_ID                      0x60
+#define HX9023S_PROX_STATUS                    0x6B
+#define HX9023S_PROX_INT_HIGH_CFG              0x6C
+#define HX9023S_PROX_INT_LOW_CFG               0x6D
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH0_0       0x80
+#define HX9023S_PROX_LOW_DIFF_CFG_CH0_0        0x88
+#define HX9023S_PROX_LOW_DIFF_CFG_CH3_1        0x8F
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_0       0x9E
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_1       0x9F
+#define HX9023S_PROX_LOW_DIFF_CFG_CH4_0        0xA2
+#define HX9023S_PROX_LOW_DIFF_CFG_CH4_1        0xA3
+#define HX9023S_CAP_INI_CH4_0                  0xB3
+#define HX9023S_LP_DIFF_CH4_2                  0xBA
+#define HX9023S_RAW_BL_CH4_0                   0xB5
+#define HX9023S_LP_DIFF_CH4_0                  0xB8
+#define HX9023S_DSP_CONFIG_CTRL1               0xC8
+#define HX9023S_CAP_INI_CH0_0                  0xE0
+#define HX9023S_RAW_BL_CH0_0                   0xE8
+#define HX9023S_LP_DIFF_CH0_0                  0xF4
+#define HX9023S_LP_DIFF_CH3_2                  0xFF
+
+#define HX9023S_DATA_LOCK_MASK BIT(4)
+#define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
+#define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
+
+struct hx9023s_addr_val_pair {
+	u8 addr;
+	u8 val;
+};
+
+struct hx9023s_ch_data {
+	int raw;
+	int lp; /* low pass */
+	int bl; /* base line */
+	int diff; /* lp-bl */
+
+	struct {
+		int near;
+		int far;
+	} thres;
+
+	u16 dac;
+	u8 cs_position;
+	u8 channel_positive;
+	u8 channel_negative;
+	bool sel_bl;
+	bool sel_raw;
+	bool sel_diff;
+	bool sel_lp;
+	bool enable;
+};
+
+struct hx9023s_data {
+	struct iio_trigger *trig;
+	struct regmap *regmap;
+	unsigned long chan_prox_stat;
+	unsigned long chan_read;
+	unsigned long chan_event;
+	unsigned long ch_en_stat;
+	unsigned long chan_in_use;
+	unsigned int prox_state_reg;
+	bool trigger_enabled;
+
+	struct {
+		__be16 channels[HX9023S_CH_NUM];
+		s64 ts __aligned(8);
+	} buffer;
+
+	struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];
+	struct mutex mutex;
+};
+
+static struct hx9023s_addr_val_pair hx9023s_reg_init_list[] = {
+	/* scan period */
+	{ HX9023S_PRF_CFG,                    0x17 },
+
+	/* full scale of conversion phase of each channel */
+	{ HX9023S_RANGE_7_0,                  0x11 },
+	{ HX9023S_RANGE_9_8,                  0x02 },
+	{ HX9023S_RANGE_18_16,                0x00 },
+
+	/* adc avg number and osr number of each channel */
+	{ HX9023S_AVG0_NOSR0_CFG,             0x71 },
+	{ HX9023S_NOSR12_CFG,                 0x44 },
+	{ HX9023S_NOSR34_CFG,                 0x00 },
+	{ HX9023S_AVG12_CFG,                  0x33 },
+	{ HX9023S_AVG34_CFG,                  0x00 },
+
+	/* sample & integration frequency of the adc */
+	{ HX9023S_SAMPLE_NUM_7_0,             0x65 },
+	{ HX9023S_INTEGRATION_NUM_7_0,        0x65 },
+
+	/* coefficient of the first order low pass filter during each channel */
+	{ HX9023S_LP_ALP_1_0_CFG,             0x22 },
+	{ HX9023S_LP_ALP_3_2_CFG,             0x22 },
+	{ HX9023S_LP_ALP_4_CFG,               0x02 },
+
+	/* up coefficient of the first order low pass filter during each channel */
+	{ HX9023S_UP_ALP_1_0_CFG,             0x88 },
+	{ HX9023S_UP_ALP_3_2_CFG,             0x88 },
+	{ HX9023S_DN_UP_ALP_0_4_CFG,          0x18 },
+
+	/* down coefficient of the first order low pass filter during each channel */
+	{ HX9023S_DN_ALP_2_1_CFG,             0x11 },
+	{ HX9023S_DN_ALP_4_3_CFG,             0x11 },
+
+	/* output data */
+	{ HX9023S_RAW_BL_RD_CFG,              0xF0 },
+
+	/* enable the interrupt function */
+	{ HX9023S_INTERRUPT_CFG,              0xFF },
+	{ HX9023S_INTERRUPT_CFG1,             0x3B },
+	{ HX9023S_DITHER_CFG,                 0x21 },
+
+	/* threshold of the offset compensation */
+	{ HX9023S_CALI_DIFF_CFG,              0x07 },
+
+	/* proximity persistency number(near & far) */
+	{ HX9023S_PROX_INT_HIGH_CFG,          0x01 },
+	{ HX9023S_PROX_INT_LOW_CFG,           0x01 },
+
+	/* disable the data lock */
+	{ HX9023S_DSP_CONFIG_CTRL1,           0x00 },
+};
+
+static const struct iio_event_spec hx9023s_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+#define HX9023S_CHANNEL(idx)					\
+{								\
+	.type = IIO_PROXIMITY,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+	.indexed = 1,						\
+	.channel = idx,						\
+	.address = 0,						\
+	.event_spec = hx9023s_events,				\
+	.num_event_specs = ARRAY_SIZE(hx9023s_events),		\
+	.scan_index = idx,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_BE,				\
+	},							\
+}
+
+static const struct iio_chan_spec hx9023s_channels[] = {
+	HX9023S_CHANNEL(0),
+	HX9023S_CHANNEL(1),
+	HX9023S_CHANNEL(2),
+	HX9023S_CHANNEL(3),
+	HX9023S_CHANNEL(4),
+	IIO_CHAN_SOFT_TIMESTAMP(5),
+};
+
+static const unsigned int hx9023s_samp_freq_table[] = {
+	2, 2, 4, 6, 8, 10, 14, 18, 22, 26,
+	30, 34, 38, 42, 46, 50, 56, 62, 68, 74,
+	80, 90, 100, 200, 300, 400, 600, 800, 1000, 2000,
+	3000, 4000,
+};
+
+static const struct regmap_range hx9023s_wr_reg_ranges[] = {
+	regmap_reg_range(HX9023S_DSP_CONFIG_CTRL1, HX9023S_DSP_CONFIG_CTRL1),
+	regmap_reg_range(HX9023S_CH0_CFG_7_0, HX9023S_CH4_CFG_9_8),
+	regmap_reg_range(HX9023S_PROX_HIGH_DIFF_CFG_CH0_0, HX9023S_PROX_LOW_DIFF_CFG_CH3_1),
+	regmap_reg_range(HX9023S_PROX_HIGH_DIFF_CFG_CH4_0, HX9023S_PROX_HIGH_DIFF_CFG_CH4_1),
+	regmap_reg_range(HX9023S_PROX_LOW_DIFF_CFG_CH4_0, HX9023S_PROX_LOW_DIFF_CFG_CH4_1),
+	regmap_reg_range(HX9023S_OFFSET_DAC0_7_0, HX9023S_OFFSET_DAC4_9_8),
+};
+
+static const struct regmap_range hx9023s_volatile_reg_ranges[] = {
+	regmap_reg_range(HX9023S_CAP_INI_CH4_0, HX9023S_LP_DIFF_CH4_2),
+	regmap_reg_range(HX9023S_CAP_INI_CH0_0, HX9023S_LP_DIFF_CH3_2),
+	regmap_reg_range(HX9023S_PROX_STATUS, HX9023S_PROX_STATUS),
+};
+
+static const struct regmap_access_table hx9023s_wr_regs = {
+	.yes_ranges = hx9023s_wr_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hx9023s_wr_reg_ranges),
+};
+
+static const struct regmap_access_table hx9023s_volatile_regs = {
+	.yes_ranges = hx9023s_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hx9023s_volatile_reg_ranges),
+};
+
+static const struct regmap_config hx9023s_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.wr_table = &hx9023s_wr_regs,
+	.volatile_table = &hx9023s_volatile_regs,
+};
+
+static int hx9023s_interrupt_enable(struct hx9023s_data *data)
+{
+	return regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
+				HX9023S_INTERRUPT_MASK, HX9023S_INTERRUPT_MASK);
+}
+
+static int hx9023s_interrupt_disable(struct hx9023s_data *data)
+{
+	return regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
+				HX9023S_INTERRUPT_MASK, 0x00);
+}
+
+static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
+{
+	int ret;
+
+	if (locked)
+		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
+					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
+	else
+		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1, GENMASK(4, 3), 0);
+
+	return ret;
+}
+
+static int hx9023s_ch_cfg(struct hx9023s_data *data)
+{
+	int ret;
+	int i;
+	u16 reg;
+	u8 reg_list[HX9023S_CH_NUM * 2];
+	u8 ch_pos[HX9023S_CH_NUM];
+	u8 ch_neg[HX9023S_CH_NUM];
+
+	data->ch_data[0].cs_position = 0;
+	data->ch_data[1].cs_position = 2;
+	data->ch_data[2].cs_position = 4;
+	data->ch_data[3].cs_position = 6;
+	data->ch_data[4].cs_position = 8;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		if (data->ch_data[i].channel_positive == 255)
+			ch_pos[i] = 16;
+		else
+			ch_pos[i] = data->ch_data[data->ch_data[i].channel_positive].cs_position;
+		if (data->ch_data[i].channel_negative == 255)
+			ch_neg[i] = 16;
+		else
+			ch_neg[i] = data->ch_data[data->ch_data[i].channel_negative].cs_position;
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		reg = (u16)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));
+		reg_list[i * 2] = (u8)(reg);
+		reg_list[i * 2 + 1] = (u8)(reg >> 8);
+	}
+
+	ret = regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
+
+	return ret;
+}
+
+static int hx9023s_reg_init(struct hx9023s_data *data)
+{
+	int i = 0;
+	int ret;
+
+	for (i = 0; i < (int)ARRAY_SIZE(hx9023s_reg_init_list); i++) {
+		ret = regmap_bulk_write(data->regmap, hx9023s_reg_init_list[i].addr,
+					&hx9023s_reg_init_list[i].val, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)
+{
+	int ret;
+
+	if (val > 0xF)
+		val = 0xF;
+
+	guard(mutex)(&data->mutex);
+	ret = regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
+				HX9023S_PROX_DEBOUNCE_MASK, val);
+
+	return ret;
+}
+
+static int hx9023s_write_near_debounce(struct hx9023s_data *data, int val)
+{
+	int ret;
+
+	if (val > 0xF)
+		val = 0xF;
+
+	guard(mutex)(&data->mutex);
+	ret = regmap_update_bits(data->regmap, HX9023S_PROX_INT_HIGH_CFG,
+				HX9023S_PROX_DEBOUNCE_MASK, val);
+
+	return ret;
+}
+
+static int hx9023s_read_far_debounce(struct hx9023s_data *data, int *val)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_PROX_INT_LOW_CFG, val);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_read_near_debounce(struct hx9023s_data *data, int *val)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_PROX_INT_HIGH_CFG, val);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int *val)
+{
+	int ret;
+	u8 buf[2];
+
+	if (ch == 4)
+		ret = regmap_bulk_read(data->regmap, HX9023S_PROX_HIGH_DIFF_CFG_CH4_0, buf, 2);
+	else
+		ret = regmap_bulk_read(data->regmap,
+				HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES), buf, 2);
+
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_le16(buf);
+	*val = (*val & GENMASK(9, 0)) * 32;
+	data->ch_data[ch].thres.near = *val;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
+{
+	int ret;
+	u8 buf[2];
+
+	if (ch == 4)
+		ret = regmap_bulk_read(data->regmap, HX9023S_PROX_LOW_DIFF_CFG_CH4_0, buf, 2);
+	else
+		ret = regmap_bulk_read(data->regmap,
+				HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES), buf, 2);
+
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_le16(buf);
+	*val = (*val & GENMASK(9, 0)) * 32;
+	data->ch_data[ch].thres.far = *val;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
+{
+	int ret;
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+
+	data->ch_data[ch].thres.near = ((val / 32) & GENMASK(9, 0)) * 32;
+
+	if (ch == 4)
+		ret = regmap_bulk_write(data->regmap, HX9023S_PROX_HIGH_DIFF_CFG_CH4_0,
+					&val_le16, sizeof(val_le16));
+	else
+		ret = regmap_bulk_write(data->regmap,
+					HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES),
+					&val_le16, sizeof(val_le16));
+
+	return ret;
+}
+
+static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int val)
+{
+	int ret;
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+
+	data->ch_data[ch].thres.far = ((val / 32) & GENMASK(9, 0)) * 32;
+
+	if (ch == 4)
+		ret = regmap_bulk_write(data->regmap, HX9023S_PROX_LOW_DIFF_CFG_CH4_0,
+					&val_le16, sizeof(val_le16));
+	else
+		ret = regmap_bulk_write(data->regmap,
+					HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES),
+					&val_le16, sizeof(val_le16));
+
+	return ret;
+}
+
+static void hx9023s_get_prox_state(struct hx9023s_data *data)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_PROX_STATUS, &data->prox_state_reg);
+	if (ret)
+		return;
+}
+
+static void hx9023s_data_select(struct hx9023s_data *data)
+{
+	int ret;
+	int i;
+	unsigned long buf[1];
+
+	ret = regmap_read(data->regmap, HX9023S_RAW_BL_RD_CFG, (unsigned int *)buf);
+	if (ret)
+		return;
+
+	for (i = 0; i < 4; i++) {
+		data->ch_data[i].sel_diff = test_bit(i, buf);
+		data->ch_data[i].sel_lp = !data->ch_data[i].sel_diff;
+		data->ch_data[i].sel_bl = test_bit(i + 4, buf);
+		data->ch_data[i].sel_raw = !data->ch_data[i].sel_bl;
+	}
+
+	ret = regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, (unsigned int *)buf);
+	if (ret)
+		return;
+
+	data->ch_data[4].sel_diff = test_bit(2, buf);
+	data->ch_data[4].sel_lp = !data->ch_data[4].sel_diff;
+	data->ch_data[4].sel_bl = test_bit(3, buf);
+	data->ch_data[4].sel_raw = !data->ch_data[4].sel_bl;
+}
+
+static int hx9023s_sample(struct hx9023s_data *data)
+{
+	int ret;
+	int i;
+	u8 data_size;
+	u8 offset_data_size;
+	int value;
+	u8 rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
+
+	hx9023s_data_lock(data, true);
+	hx9023s_data_select(data);
+
+	data_size = HX9023S_3BYTES;
+
+	/* ch0~ch3 */
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, rx_buf,
+				(HX9023S_CH_NUM * data_size) - data_size);
+	if (ret)
+		return ret;
+
+	/* ch4 */
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0,
+				rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
+		value = sign_extend32(value, 15);
+		data->ch_data[i].raw = 0;
+		data->ch_data[i].bl = 0;
+		if (data->ch_data[i].sel_raw == true)
+			data->ch_data[i].raw = value;
+		if (data->ch_data[i].sel_bl == true)
+			data->ch_data[i].bl = value;
+	}
+
+	/* ch0~ch3 */
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, rx_buf,
+				(HX9023S_CH_NUM * data_size) - data_size);
+	if (ret)
+		return ret;
+
+	/* ch4 */
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0,
+				rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
+		value = sign_extend32(value, 15);
+		data->ch_data[i].lp = 0;
+		data->ch_data[i].diff = 0;
+		if (data->ch_data[i].sel_lp == true)
+			data->ch_data[i].lp = value;
+		if (data->ch_data[i].sel_diff == true)
+			data->ch_data[i].diff = value;
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		if (data->ch_data[i].sel_lp == true && data->ch_data[i].sel_bl == true)
+			data->ch_data[i].diff = data->ch_data[i].lp - data->ch_data[i].bl;
+	}
+
+	/* offset dac */
+	offset_data_size = HX9023S_2BYTES;
+	ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, rx_buf,
+				(HX9023S_CH_NUM * offset_data_size));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
+		value = FIELD_GET(GENMASK(11, 0), value);
+		data->ch_data[i].dac = value;
+	}
+
+	hx9023s_data_lock(data, false);
+
+	return 0;
+}
+
+static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
+{
+	int ret;
+	unsigned int buf;
+
+	ret = regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
+	if (ret)
+		return ret;
+
+	data->ch_en_stat = buf;
+
+	if (en) {
+		if (data->ch_en_stat == 0)
+			data->prox_state_reg = 0;
+		set_bit(ch_id, &data->ch_en_stat);
+		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
+		if (ret)
+			return ret;
+		data->ch_data[ch_id].enable = true;
+	} else {
+		clear_bit(ch_id, &data->ch_en_stat);
+		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
+		if (ret)
+			return ret;
+		data->ch_data[ch_id].enable = false;
+	}
+
+	return 0;
+}
+
+static int hx9023s_property_get(struct hx9023s_data *data)
+{
+	int ret, i;
+	u32 temp;
+	struct fwnode_handle *child;
+	struct device *dev = regmap_get_device(data->regmap);
+
+	ret = device_property_read_u32(dev, "channel-in-use", &temp);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read channel-in-use property\n");
+	data->chan_in_use = temp;
+
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32(child, "channel-positive", &temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"Failed to read channel-positive for channel %d\n", i);
+		data->ch_data[i].channel_positive = temp;
+
+		ret = fwnode_property_read_u32(child, "channel-negative", &temp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"Failed to read channel-negative for channel %d\n", i);
+		data->ch_data[i].channel_negative = temp;
+
+		i++;
+	}
+
+	return 0;
+}
+
+static int hx9023s_update_chan_en(struct hx9023s_data *data,
+				unsigned long chan_read,
+				unsigned long chan_event)
+{
+	int i;
+	unsigned long channels = chan_read | chan_event;
+
+	if ((data->chan_read | data->chan_event) != channels) {
+		for_each_set_bit(i, &channels, HX9023S_CH_NUM)
+			hx9023s_ch_en(data, i, test_bit(i, &data->chan_in_use));
+		for_each_clear_bit(i, &channels, HX9023S_CH_NUM)
+			hx9023s_ch_en(data, i, false);
+	}
+
+	data->chan_read = chan_read;
+	data->chan_event = chan_event;
+
+	return 0;
+}
+
+static int hx9023s_get_proximity(struct hx9023s_data *data,
+				const struct iio_chan_spec *chan,
+				int *val)
+{
+	hx9023s_sample(data);
+	hx9023s_get_prox_state(data);
+	*val = data->ch_data[chan->channel].diff;
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
+{
+	int ret;
+	unsigned int odr;
+	unsigned int buf;
+
+	ret = regmap_read(data->regmap, HX9023S_PRF_CFG, &buf);
+	if (ret)
+		return ret;
+
+	odr = hx9023s_samp_freq_table[buf];
+	*val = 1000 / odr;
+	*val2 = div_u64((1000 % odr) * 1000000ULL, odr);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int hx9023s_read_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				int *val, int *val2, long mask)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = hx9023s_get_proximity(data, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return hx9023s_get_samp_freq(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
+{
+	int i;
+	int ret;
+	int period_ms;
+	struct device *dev = regmap_get_device(data->regmap);
+
+	period_ms = div_u64(1000000000ULL, (val * 1000000ULL + val2));
+
+	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
+		if (period_ms == hx9023s_samp_freq_table[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(hx9023s_samp_freq_table)) {
+		dev_err(dev, "Period:%dms NOT found!\n", period_ms);
+		return -EINVAL;
+	}
+
+	ret = regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &i, 1);
+
+	return ret;
+}
+
+static int hx9023s_write_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				int val, int val2, long mask)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	return hx9023s_set_samp_freq(data, val, val2);
+}
+
+static irqreturn_t hx9023s_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (data->trigger_enabled)
+		iio_trigger_poll(data->trig);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static void hx9023s_push_events(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
+	unsigned long prox_changed;
+	unsigned int chan;
+
+	hx9023s_sample(data);
+	hx9023s_get_prox_state(data);
+
+	prox_changed = (data->chan_prox_stat ^ data->prox_state_reg) & data->chan_event;
+
+	for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
+		int dir;
+
+		dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+
+		iio_push_event(indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir),
+			timestamp);
+	}
+	data->chan_prox_stat = data->prox_state_reg;
+}
+
+static irqreturn_t hx9023s_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+	hx9023s_push_events(indio_dev);
+
+	return IRQ_HANDLED;
+}
+
+static int hx9023s_read_event_val(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info, int *val, int *val2)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_get_thres_far(data, chan->channel, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_get_thres_near(data, chan->channel, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_read_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_read_near_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hx9023s_write_event_val(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info, int val, int val2)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_set_thres_far(data, chan->channel, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_set_thres_near(data, chan->channel, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_write_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_write_near_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hx9023s_read_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	return test_bit(chan->channel, &data->chan_event);
+}
+
+static int hx9023s_write_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				int state)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (test_bit(chan->channel, &data->chan_in_use)) {
+		hx9023s_ch_en(data, chan->channel, !!state);
+		if (data->ch_data[chan->channel].enable)
+			set_bit(chan->channel, &data->chan_event);
+		else
+			clear_bit(chan->channel, &data->chan_event);
+	}
+
+	return 0;
+}
+
+static const struct iio_info hx9023s_info = {
+	.read_raw = hx9023s_read_raw,
+	.write_raw = hx9023s_write_raw,
+	.read_event_value = hx9023s_read_event_val,
+	.write_event_value = hx9023s_write_event_val,
+	.read_event_config = hx9023s_read_event_config,
+	.write_event_config = hx9023s_write_event_config,
+};
+
+static int hx9023s_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+	if (state)
+		hx9023s_interrupt_enable(data);
+	else if (!data->chan_read)
+		hx9023s_interrupt_disable(data);
+	data->trigger_enabled = state;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops hx9023s_trigger_ops = {
+	.set_trigger_state = hx9023s_set_trigger_state,
+};
+
+static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	int bit;
+	int i;
+
+	guard(mutex)(&data->mutex);
+	hx9023s_sample(data);
+	hx9023s_get_prox_state(data);
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
+		data->buffer.channels[i++] =
+			cpu_to_be16(data->ch_data[indio_dev->channels[bit].channel].diff);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int hx9023s_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	unsigned long channels;
+	int bit;
+
+	guard(mutex)(&data->mutex);
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
+		__set_bit(indio_dev->channels[bit].channel, &channels);
+
+	hx9023s_update_chan_en(data, channels, data->chan_event);
+
+	return 0;
+}
+
+static int hx9023s_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+	hx9023s_update_chan_en(data, 0, data->chan_event);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops hx9023s_buffer_setup_ops = {
+	.preenable = hx9023s_buffer_preenable,
+	.postdisable = hx9023s_buffer_postdisable,
+};
+
+static int hx9023s_probe(struct i2c_client *client)
+{
+	int ret;
+	unsigned int id;
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct hx9023s_data *data;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM, "device alloc failed\n");
+
+	data = iio_priv(indio_dev);
+	mutex_init(&data->mutex);
+
+	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
+
+	ret = hx9023s_property_get(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "dts phase failed\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "regulator get failed\n");
+
+	fsleep(1000);
+
+	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
+	if (ret)
+		return dev_err_probe(dev, ret, "id check failed\n");
+
+	indio_dev->channels = hx9023s_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
+	indio_dev->info = &hx9023s_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = "hx9023s";
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = hx9023s_reg_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "device init failed\n");
+
+	ret = hx9023s_ch_cfg(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "channel config failed\n");
+
+	ret = regcache_sync(data->regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "regcache sync failed\n");
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
+						hx9023s_irq_thread_handler, IRQF_ONESHOT,
+						"hx9023s_event", indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "irq request failed\n");
+
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+						iio_device_id(indio_dev));
+		if (!data->trig)
+			return dev_err_probe(dev, -ENOMEM,
+					"iio trigger alloc failed\n");
+
+		data->trig->ops = &hx9023s_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, data->trig);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"iio trigger register failed\n");
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
+					hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"iio triggered buffer setup failed\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "iio device register failed\n");
+
+	return 0;
+}
+
+static int hx9023s_suspend(struct device *dev)
+{
+	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
+
+	hx9023s_interrupt_disable(data);
+
+	return 0;
+}
+
+static int hx9023s_resume(struct device *dev)
+{
+	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
+
+	hx9023s_interrupt_enable(data);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s_resume);
+
+static const struct acpi_device_id hx9023s_acpi_match[] = {
+	{ "TYHX9023" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hx9023s_acpi_match);
+
+static const struct of_device_id hx9023s_of_match[] = {
+	{ .compatible = "tyhx,hx9023s" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, hx9023s_of_match);
+
+static const struct i2c_device_id hx9023s_id[] = {
+	{ "hx9023s" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, hx9023s_id);
+
+static struct i2c_driver hx9023s_driver = {
+	.driver = {
+		.name = "hx9023s",
+		.acpi_match_table = hx9023s_acpi_match,
+		.of_match_table = hx9023s_of_match,
+		.pm = &hx9023s_pm_ops,
+
+		/*
+		 * The I2C operations in hx9023s_reg_init() and hx9023s_ch_cfg()
+		 * are time-consuming. prefer async so we don't delay boot
+		 * if we're builtin to the kernel.
+		 */
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = hx9023s_probe,
+	.id_table = hx9023s_id,
+};
+module_i2c_driver(hx9023s_driver);
+
+MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
+MODULE_DESCRIPTION("Driver for TYHX HX9023S SAR sensor");
+MODULE_LICENSE("GPL");
-- 
2.25.1


