Return-Path: <linux-iio+bounces-6317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F015909C3A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 09:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5767F1F21376
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAE1822C9;
	Sun, 16 Jun 2024 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DPvs6Z89"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2015.outbound.protection.outlook.com [40.92.40.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F417994F;
	Sun, 16 Jun 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523492; cv=fail; b=i9xEAh142EPozUd6GiAyrIEmW1pMVPLgLlJ0/AMP2TGbgwMLm5vMOd3Wl8Sbqsf+4muK8lx0EdCVMh45Zbc5fuawLQBTlavSNmNzBFiGuao1oOxLZFbRezbHptIN1opRL8LULnXGl86XsQf3lhgj6iqZzH2mbZj2aywvcjHHchI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523492; c=relaxed/simple;
	bh=33yafXeztjdEe0f2f2onb4dB5ujda/kZ+nZ6apw1Hxw=;
	h=From:Date:Subject:Content-Type:Message-ID:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cgrDhIqKnBw7HaqzfrWyXuqWFcHZvIPS++vyV4urVabmSFVJT4J5ntc+klOS7PuBfzaiyD8JGVWzbsM0MRMRnb6mJCHXm9C4fcDgRd00PkW0eM/manUy1S599+xn00WaBgH6e8CMghtsL2ftnjE1iGxJW9X0y7bMUX9OXoxlYLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DPvs6Z89; arc=fail smtp.client-ip=40.92.40.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdrJSR+4n+Lbz0tq6H4sGYKmmwCZtUcF8IaWicELU5StMUQ3bzsuh5eUfi5AAsyi5HOJhbeG3AHMAEJyLat5C8474RLYBFoc1rpP80bdsV5PA3nP01e72vVfUlHmFl9IjoCEHLwZjBq6VzccI8aLdHTQ+EiGcsG91uOscvmbw+oXvz2/KQjPnGyk+3k6yajx1zSW6SnAnAE1NoS6IwNchOA+TdcD3FhDoioK4hx9tNyMeYhwXdtlriKyaOgAHltfE1AxgmsWeuLf7goCfJLNH4m/LxN7qu5+g5NImYf+5a2eDk1XxF8zRG8rZ5vBNrxLjWPbXsFB/7eptUCsnFyzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKMpVIwfWoL2pcobrWbM/6JBsUtTTVewBL2bg2DVTC0=;
 b=gHr68CCTQiaaK9WCVZWV1QdQ0hGXnKUqWLLwD2eS4MWgegMO4tnpR72Vp/BED93HYihUyuwQc8EJGiXVeTad2nvPk6zLyCtRvIsE+m3dcdoPeCbZmW0OpHMq3V/kC1GRYIP6duecjtAkOIg1WJzkQgUo7bvgK716BTLoOlX3oy4VLuXKkD0b0vARI6NZ9wotGwz5Y+YqXZ9f///4lcrI/sTyczGNiAKBOhZnOZhSbErzs86DDoKBGJGT9NoXtpD9kSHGrv/4lpKJDqYaqMxsDyTdjWpKHKmlPyISWPoxkxaSXcTQWh0MaJqrZNWcDH/ExDdhXnFNojx5BE9Qdmpq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKMpVIwfWoL2pcobrWbM/6JBsUtTTVewBL2bg2DVTC0=;
 b=DPvs6Z89FD6IBSrBtzH/3/Xm8OSXQmRmbaYIVEgp+5Mz/OX9hAOja79GWc8hnwV4np1kl9Zm7BH/KPETh2Jv5Xx3o6IAPX9mJkeRn9eOhgcEi2LValehRNnEcIHLpz5aWtG48oJBvWILEULhzsHAhhs9BEY9ZN4KEU9XurOq7QD0ILSsLNEVZD+5o82/qsJtubAT+guMZMBv0stnpP7AxvDthjDSUi+3u7pb86DJXgZ65X+CDWBzRr5YiIxAEh+gTrUrm//UW+B0whoRKJMslvyyZWNJxuYm3wzTSVBA5Y1tP1sLvQnRDnmrCv27M7AoLgwAAUP23I/HOMfPgmcFFw==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Sun, 16 Jun
 2024 07:38:07 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Sun, 16 Jun 2024
 07:38:07 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
Date: Sun, 16 Jun 2024 15:36:49 +0800
Subject: [PATCH v5 3/3] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SN7PR12MB8101D4BC788B5954608D677DA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
In-Reply-To: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718523473; l=36052;
 i=yasin.lee.x@outlook.com; s=20240616; h=from:subject:message-id;
 bh=ouNjH1HSf7UYP0f74epchD8AC5kw+NQJkofZHHVGCRE=;
 b=Ox2hNQZCjaaimp53Cu5hU3YOlqzCmPkQ2/E0V/cSEuT1+azejAerq1k8N37uMv8fmgdPmhW0V
 Br3f79BHsllCYK0QmxdJAfJoPGrX3k5HRiBcbNLUnJHLvwxpJmMAYQZ
X-Developer-Key: i=yasin.lee.x@outlook.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=
X-TMN:
 [N0iOvX5iEukNDF1ND4sXoGSKh5wWaL9Y8QW62tgVgY1eAoF0yJ5F8PpLkHVElwZWOiJt6bymeAY=]
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240616-add-tyhx-hx9023s-sensor-driver-v5-3-ebaf280bbf0e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: fa64d3a8-3780-4a43-42fa-08dc8dd7434d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|4302099010|440099025|1602099009;
X-Microsoft-Antispam-Message-Info:
	ONvy8jGO+GxGcGICq27qhD5Vg5dNv4aIuDswX3YV7MA8aFNupPxpnhDXly2z4l6C6bt9oqdb8Mt1G0yGQbPm+B82Wa7hZ9iRlqzOViWQ2X8VdVvkhtUIP7zhzgTFvbwruZ+a5xqovqupPZsHgduUsZH2xm/zPyF5SHmiF7Lmii3s9NAZUaquQZI5h7n5fFVF83gm7JuqmrzJOMqZLrNCevxj0lveL5l9goAzmjJ3tRmGnsJls22c5f1zeSvSnifR82B1vTb6L69wI3tThQifDyMIseGoknlXDhiR6LiCgp8znmyibShvnqd1ahuWQvmKa3uVqYEal3giy6LZ8TRcc7VxmbXCAZ0HNfqJm81VXWRMIqhvEOABICU4MEqM7ruhZ6+9tpLCZMsBadKtVTRcLmk2ZM3XLxaKW/lNwPdYYSVXEyGWXJ/4j+U+Nd8Ro/BiGQbdglGmhJIiwqYYBIeeFSB/39WhXPbHwPmTEAaLJEBkg/cPdebIFuWPzTuQGbWaWb2+hTSIcZKdfSP4CaOAm4qwnTOCJkMZ27DS4framoFcTcANMxAcJDDlX9duw3Vho76LTXvDBis3d3eJrJXNFUb3HSPVODQ79cgMfDdP1X9foK0R57Suz0scNIXZxh0ooU/WDwybPiutjNYXrvze12URfr6UR/dfuIVMqJ4jDKdvsb3Qlmr2khMaccUIQJCK/9/PFt+3upyHd63hQpMipg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3l1c2xMMVVaQU4vNFlQd0htMmFlV29XczVudHZqVUw0T0NIaW5sdEtxdm1w?=
 =?utf-8?B?c3YvSnUwZVBPVGswUFpPSnE4VVRRVUlFU3FGSEhxdUFSQWZkQXV2cjFwMW1P?=
 =?utf-8?B?WmlUMTJYSTF5b2Nob0tQSlQwNkVTVkxOTlhBWUQ2OHJvdzc5UjlUcXFDaEV3?=
 =?utf-8?B?SHBXaW05SEQybG5qaXZ5TjhqYkV0elA1UDdEWFliTUVabGhDTlFucTEzenpU?=
 =?utf-8?B?SFZ6NlV3UjJJd01QV3dOR1dEOEpwMngwUjZRS0VDZStFbU8yM2FEcjVYUGVK?=
 =?utf-8?B?WEFGZVZuSnpEamZINFBsbThFdlFnYkJqc0JqZE1HUjNOTDdYR24reTRwRCtW?=
 =?utf-8?B?NHpWWkVnSlRJTWFreGJDVEo5Ryt0TEFZdW1vSHFSNUJLcEg2SThqWW9CT3dZ?=
 =?utf-8?B?MkFhU0RQak9RNXpMcU9LelZhQUZ4a0NhaGNLQytxWkZXQnZTWTlWNGFWN1h5?=
 =?utf-8?B?b3lMK2pMcUNVanFVNVNoNDQ0YUI2WjFxRmJWN053KzlVZW1jVXdLeFNOL1hH?=
 =?utf-8?B?SlVjN0ZVaVJSRWJzTjJZTms1OFNpY29hdFRhNDVIWlFLaGFMdHRiQlBsY0Z1?=
 =?utf-8?B?bVVvOFNML1Fsek1jTS81NWQzbTE5Rk9hMkhiSnpWbFhoWWxTVm15WTZqUS9n?=
 =?utf-8?B?cGtzZXJ2bUhlZlA0Q3gyeGdZQm9QYTJQMERSNGd3T0pqSXJjKzRrcGZCYW8r?=
 =?utf-8?B?M3ZQYXRvcktyK0ovYkpLWE9KdkIrNXlMb1B6VVlLZWt6YnZXdXRjUXEwUU53?=
 =?utf-8?B?TzZIV3MxSzVyTWM1U1p3Nm1heUhzR1N6ZHRMOW9Qejlvb0ZuQUt5R2NtOHdF?=
 =?utf-8?B?ZmZacnNqR0EyY2dtdFpZU0FNZmgzR3hHczY4UE9ONFArRkZUelVZOGdnSXRr?=
 =?utf-8?B?Z2VRekNLMTVmUFY3bmVtekNqUzc5aHlCbHZhRVRQSHhZK3JtRk9xdkpUS2lv?=
 =?utf-8?B?cWtWaGF3MWlzMWgva3J0OUtEdXJURVI2cG9nbDFPUUtvL0ZYTnlEYm12ZVBp?=
 =?utf-8?B?RHZGREdxMWk0Z0lPSDdHNElud1R0NmZFcCtJWVFxZ0hFbWQ3RXp2K09VQ0cr?=
 =?utf-8?B?dG1EOU1rbEo0K3M5K09hNnlQM2lVeXhzdlZFNjZRNzFMRngzZ0NzU3pWalBr?=
 =?utf-8?B?T1lOSEllWXlyVHA3SktidEpwVERxQ2QrSGhGRGoxbGw0WnBLaW1RZVNzbzM4?=
 =?utf-8?B?a1d3NXZIMGlwOHpwQUU4TE1wSFl5V3lWMWJFRDc2VzF1dmJCdDZGSTJYOWlW?=
 =?utf-8?B?dVliZVRESnI2M1k1UnJiaDQ1RWUxdHIvc3ZyYjhiV1Z0Ym1rZVZ0S1VsK3Rj?=
 =?utf-8?B?Z0VLcUNpMW5QLy96Yi9PZWNqVG4yZzlqaVNjRHl1K0F4QktXTGZoV2dxb0JU?=
 =?utf-8?B?bTVMT0oyNElIVUNhOW5KVFJVTmV4VmNDeWtmd1NjQkM5NXdSMWN4QUl5dTdH?=
 =?utf-8?B?MEo5N2RRZUF1cVdLSVMxUDU2aWxVNnFCNG54b1hyc3VtNnBnd0JOR2llT0g2?=
 =?utf-8?B?SUI3RnhSeld1b3lhaFl4cGxtSGtyd2xucTJYSVlmUjNYbW9IV0diWWI3WVpH?=
 =?utf-8?B?RWZnRmhEWHR1a29HYk9WMlJTZm8rWUdMYklkVGMxUFZ1VHhVZmtOcXZiK0pj?=
 =?utf-8?B?OGo5Tzk3TmVoOW14K0Npdm5NaFpGSmFSM1o0aDZEODM1aUlZSTkxYitzSk4z?=
 =?utf-8?B?bGYvdkdYVXhJQkhBU0szeFordWt1UUdYUDVoaC9LOG1FaEd1bXJWbS9PUktm?=
 =?utf-8?Q?P/ZCMiC9k13oAKoTJjAznRZo2HlWqMw9p9DtPCs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa64d3a8-3780-4a43-42fa-08dc8dd7434d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2024 07:38:06.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818

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
 drivers/iio/proximity/hx9023s.c | 1149 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1164 insertions(+)

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
index 000000000000..2d2d6a734de6
--- /dev/null
+++ b/drivers/iio/proximity/hx9023s.c
@@ -0,0 +1,1149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
+ * http://www.tianyihexin.com
+ *
+ * Driver for NanjingTianyihexin HX9023S Cap Sensor.
+ * Datasheet available at:
+ * http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
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
+#include <asm/byteorder.h>
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
+#define HX9023S_POS 0x03
+#define HX9023S_NEG 0x02
+#define HX9023S_NOT_CONNECTED 16
+
+#define HX9023S_GLOBAL_CTRL0                   0x00
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
+	int raw; /* Raw Data*/
+	int lp; /* Low Pass Filter Data*/
+	int bl; /* Base Line Data */
+	int diff; /* difference of Low Pass Data and Base Line Data */
+
+	struct {
+		unsigned int near;
+		unsigned int far;
+	} thres;
+
+	u16 dac;
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
+	struct mutex mutex;
+	struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];
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
+	/* ADC average number and OSR number of each channel */
+	{ HX9023S_AVG0_NOSR0_CFG,             0x71 },
+	{ HX9023S_NOSR12_CFG,                 0x44 },
+	{ HX9023S_NOSR34_CFG,                 0x00 },
+	{ HX9023S_AVG12_CFG,                  0x33 },
+	{ HX9023S_AVG34_CFG,                  0x00 },
+
+	/* sample & integration frequency of the ADC */
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
+	/* data select for the Data Mux Register for output data */
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
+static const struct regmap_range hx9023s_rd_reg_ranges[] = {
+	regmap_reg_range(HX9023S_GLOBAL_CTRL0, HX9023S_LP_DIFF_CH3_2),
+};
+
+static const struct regmap_range hx9023s_wr_reg_ranges[] = {
+	regmap_reg_range(HX9023S_GLOBAL_CTRL0, HX9023S_LP_DIFF_CH3_2),
+};
+
+static const struct regmap_range hx9023s_volatile_reg_ranges[] = {
+	regmap_reg_range(HX9023S_CAP_INI_CH4_0, HX9023S_LP_DIFF_CH4_2),
+	regmap_reg_range(HX9023S_CAP_INI_CH0_0, HX9023S_LP_DIFF_CH3_2),
+	regmap_reg_range(HX9023S_PROX_STATUS, HX9023S_PROX_STATUS),
+};
+
+static const struct regmap_access_table hx9023s_rd_regs = {
+	.yes_ranges = hx9023s_rd_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hx9023s_rd_reg_ranges),
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
+	.cache_type = REGCACHE_MAPLE,
+	.rd_table = &hx9023s_rd_regs,
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
+	if (locked)
+		return regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
+					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
+	else
+		return regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
+					HX9023S_DATA_LOCK_MASK, 0);
+}
+
+static int hx9023s_ch_cfg(struct hx9023s_data *data)
+{
+	unsigned int i;
+	u16 reg;
+	u8 reg_list[HX9023S_CH_NUM * 2];
+	u8 ch_pos[HX9023S_CH_NUM];
+	u8 ch_neg[HX9023S_CH_NUM];
+	/* Bit positions corresponding to input pin connections */
+	u8 conn_cs[HX9023S_CH_NUM] = {0, 2, 4, 6, 8};
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		ch_pos[i] = data->ch_data[i].channel_positive == HX9023S_NOT_CONNECTED ?
+			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_positive];
+		ch_neg[i] = data->ch_data[i].channel_negative == HX9023S_NOT_CONNECTED ?
+			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_negative];
+
+		reg = (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_neg[i]);
+		put_unaligned_le16(reg, &reg_list[i * 2]);
+	}
+
+	return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
+}
+
+static int hx9023s_reg_init(struct hx9023s_data *data)
+{
+	unsigned int i = 0;
+	int ret;
+
+	for (i = 0; i < (int)ARRAY_SIZE(hx9023s_reg_init_list); i++) {
+		ret = regmap_write(data->regmap, hx9023s_reg_init_list[i].addr,
+					hx9023s_reg_init_list[i].val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)
+{
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
+				HX9023S_PROX_DEBOUNCE_MASK,
+				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
+}
+
+static int hx9023s_write_near_debounce(struct hx9023s_data *data, int val)
+{
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_HIGH_CFG,
+				HX9023S_PROX_DEBOUNCE_MASK,
+				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
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
+	unsigned int reg, tmp;
+
+	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
+
+	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
+	data->ch_data[ch].thres.near = tmp;
+	*val = tmp;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
+{
+	int ret;
+	u8 buf[2];
+	unsigned int reg, tmp;
+
+	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
+
+	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
+	data->ch_data[ch].thres.far = tmp;
+	*val = tmp;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
+{
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	unsigned int reg;
+
+	data->ch_data[ch].thres.near = ((val / 32) & GENMASK(9, 0)) * 32;
+	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
+
+	return regmap_bulk_write(data->regmap, reg, &val_le16, sizeof(val_le16));
+}
+
+static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int val)
+{
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	unsigned int reg;
+
+	data->ch_data[ch].thres.far = ((val / 32) & GENMASK(9, 0)) * 32;
+	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * HX9023S_2BYTES);
+
+	return regmap_bulk_write(data->regmap, reg, &val_le16, sizeof(val_le16));
+}
+
+static int hx9023s_get_prox_state(struct hx9023s_data *data)
+{
+	return regmap_read(data->regmap, HX9023S_PROX_STATUS, &data->prox_state_reg);
+}
+
+static int hx9023s_data_select(struct hx9023s_data *data)
+{
+	int ret;
+	unsigned int i, buf;
+	unsigned long tmp;
+
+	ret = regmap_read(data->regmap, HX9023S_RAW_BL_RD_CFG, &buf);
+	if (ret)
+		return ret;
+
+	tmp = buf;
+	for (i = 0; i < 4; i++) {
+		data->ch_data[i].sel_diff = test_bit(i, &tmp);
+		data->ch_data[i].sel_lp = !data->ch_data[i].sel_diff;
+		data->ch_data[i].sel_bl = test_bit(i + 4, &tmp);
+		data->ch_data[i].sel_raw = !data->ch_data[i].sel_bl;
+	}
+
+	ret = regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, &buf);
+	if (ret)
+		return ret;
+
+	tmp = buf;
+	data->ch_data[4].sel_diff = test_bit(2, &tmp);
+	data->ch_data[4].sel_lp = !data->ch_data[4].sel_diff;
+	data->ch_data[4].sel_bl = test_bit(3, &tmp);
+	data->ch_data[4].sel_raw = !data->ch_data[4].sel_bl;
+
+	return 0;
+}
+
+static int hx9023s_sample(struct hx9023s_data *data)
+{
+	int ret, value;
+	unsigned int i;
+	u8 data_size, offset_data_size, *p, size, rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
+
+	ret = hx9023s_data_lock(data, true);
+	if (ret)
+		return ret;
+
+	ret = hx9023s_data_select(data);
+	if (ret)
+		return ret;
+
+	data_size = HX9023S_3BYTES;
+
+	/* ch0~ch3 */
+	p = rx_buf;
+	size = (HX9023S_CH_NUM - 1) * data_size;
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, p, size);
+	if (ret)
+		return ret;
+
+	/* ch4 */
+	p = rx_buf + size;
+	size = data_size;
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0, p, size);
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
+	p = rx_buf;
+	size = (HX9023S_CH_NUM - 1) * data_size;
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, p, size);
+	if (ret)
+		return ret;
+
+	/* ch4 */
+	p = rx_buf + size;
+	size = data_size;
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0, p, size);
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
+	/* offset DAC */
+	offset_data_size = HX9023S_2BYTES;
+	p = rx_buf;
+	size = HX9023S_CH_NUM * offset_data_size;
+	ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, p, size);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
+		value = FIELD_GET(GENMASK(11, 0), value);
+		data->ch_data[i].dac = value;
+	}
+
+	ret = hx9023s_data_lock(data, false);
+	if (ret)
+		return ret;
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
+	if (en && data->ch_en_stat == 0)
+		data->prox_state_reg = 0;
+
+	data->ch_data[ch_id].enable = en;
+	__assign_bit(ch_id, &data->ch_en_stat, en);
+
+	return regmap_write(data->regmap, HX9023S_CH_NUM_CFG, data->ch_en_stat);
+}
+
+static int hx9023s_property_get(struct hx9023s_data *data)
+{
+	struct fwnode_handle *child;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+	u32 i, reg, temp, array[2];
+
+	data->chan_in_use = 0;
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		data->ch_data[i].channel_positive = HX9023S_NOT_CONNECTED;
+		data->ch_data[i].channel_negative = HX9023S_NOT_CONNECTED;
+	}
+
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret, "Failed to read reg\n");
+		}
+		__set_bit(reg, &data->chan_in_use);
+
+		if (fwnode_property_read_u32(child, "input-channel", &temp) == 0) {
+			data->ch_data[reg].channel_positive = temp;
+			data->ch_data[reg].channel_negative = HX9023S_NOT_CONNECTED;
+		} else if (fwnode_property_read_u32_array(child, "diff-channels",
+							array, sizeof(array)) == 0) {
+			data->ch_data[reg].channel_positive = array[0];
+			data->ch_data[reg].channel_negative = array[1];
+		} else {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+				"Failed to read channel input for channel %d\n", reg);
+		}
+	}
+
+	return 0;
+}
+
+static int hx9023s_update_chan_en(struct hx9023s_data *data,
+				unsigned long chan_read,
+				unsigned long chan_event)
+{
+	unsigned int i;
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
+	int ret;
+
+	ret = hx9023s_sample(data);
+	if (ret)
+		return ret;
+
+	ret = hx9023s_get_prox_state(data);
+	if (ret)
+		return ret;
+
+	*val = data->ch_data[chan->channel].diff;
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
+{
+	int ret;
+	unsigned int odr, buf;
+
+	ret = regmap_read(data->regmap, HX9023S_PRF_CFG, &buf);
+	if (ret)
+		return ret;
+
+	odr = hx9023s_samp_freq_table[buf];
+
+	*val = 1000 / odr; /* odr in Hz */
+	*val2 = div_u64((1000 % odr) * 1000000ULL, odr); /* odr in micro Hz */
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
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int i, period_ms;
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
+	return regmap_write(data->regmap, HX9023S_PRF_CFG, i);
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
+	for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
+		unsigned int dir;
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
+		__assign_bit(chan->channel, &data->chan_event, data->ch_data[chan->channel].enable);
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
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+	unsigned int bit, i = 0;
+
+	guard(mutex)(&data->mutex);
+	ret = hx9023s_sample(data);
+	if (ret) {
+		dev_warn(dev, "sampling failed\n");
+		goto out;
+	}
+
+	ret = hx9023s_get_prox_state(data);
+	if (ret) {
+		dev_warn(dev, "get prox failed\n");
+		goto out;
+	}
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
+		data->buffer.channels[i++] = data->ch_data[indio_dev->channels[bit].channel].diff;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int hx9023s_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	unsigned long channels = 0;
+	unsigned int bit;
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
+static int hx9023s_id_check(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	int ret;
+	unsigned int id;
+
+	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
+	if (ret)
+		return ret;
+
+	if (id == HX9023S_CHIP_ID) {
+		indio_dev->name = "hx9023s";
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int hx9023s_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct hx9023s_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
+	if (!indio_dev)
+		return -ENOMEM;
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
+	ret = hx9023s_id_check(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "id check failed\n");
+
+	indio_dev->channels = hx9023s_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
+	indio_dev->info = &hx9023s_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
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
+	if (data->trigger_enabled)
+		hx9023s_interrupt_enable(data);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s_resume);
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
+		.of_match_table = hx9023s_of_match,
+		.pm = &hx9023s_pm_ops,
+
+		/*
+		 * The I2C operations in hx9023s_reg_init() and hx9023s_ch_cfg()
+		 * are time-consuming. Prefer async so we don't delay boot
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


