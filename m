Return-Path: <linux-iio+bounces-5422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40F8D2BDB
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 06:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FD21F24AAA
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 04:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE215B547;
	Wed, 29 May 2024 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="etCVef5g"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2028.outbound.protection.outlook.com [40.92.41.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3A15B57B;
	Wed, 29 May 2024 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716958714; cv=fail; b=rR3OaTLo9aFW2bqHuRbcNtd5DePldrxtsbvfM+sOJnIqk/PZincXpCaCuXmRRBnxKiOu8JS+vtPMkQuplnQO01kvdkaIIZ7ysIpIkE/KQdJmhA1U2vwHDqX4Q/znyhcuCKI8i4BzMLmxxOTtNvnAEQJDrVCA7q65HqoFH/m1EuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716958714; c=relaxed/simple;
	bh=Wn3NrSKRhRCA986vuysdiAtziqPnJGQU1DWo3fsCzGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUwDnSPYFA/m1RMINz3flUYhbDULAmzGgLRW7za3Yil9aIqBvhkoH3LW2Z+beNwttcVsCVgQmeZgUwYrWs/+If7ai8LkMYWNSdv5qm7zf5yrZxMg3/7oaFM1nu+TyALPP07n0Q0tslZzMlAjz0Gx9tvRpqftamEzt0QBeiH9bEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=etCVef5g; arc=fail smtp.client-ip=40.92.41.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkuww4ivAG52VOMIxUQinO/2NJTtR+8xg1SQRogWR6l1rdTdr57E9yTAHKNrqhjDLwc/xBHqkZ9GIHSOyhOOKJbQFXQbHYRr39lK7wIQd2eD+6optDYlo+AAU5lA3/ll8gC/AsWdmuoaxj7OVWUMh3s0Ir78y7fuf13JRll6qbPdlv2chXMee4IRc9Ise4LOFjHhrCQyppCdCf+3pdqOHkJkJmy2kF2ikXIqt2ikEl0Mn9JUxVgq0CK7rNmBWhL8wie+uKGYHFqhhpHrU2kFmuCy6yHHps/tGekitl3x6sZhxzHn++kNWjA3XmQz04ZaUuyO+1ho0I6mHeITrE23uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF8TNkVz+ZraISPo3fIS4dsN/CIR/cCRADvev/YhI08=;
 b=Ey1ii0oTAky+Kij1SEPxY6JEvyp7/52kxtVjjWUjv1Knvm3IcLMAuIBdXIoWV+kU+K58KURuHpdojYgtITe+UfVpsXedjwKWsgZtlnYFDo9pWf4Eb+6GnvDD3fDsipwyS1uYe4DredjjasWAuYkRxaiT/sCMqDllc9KWj6iRM2B+S+sWU/PyYHi0QgKegdC3Sq+En0q39j3/1ZIk7tESFSwZJfqX29wtf+s2t6FaQtaJ9+weRm3iHlNMGEbvClzMHQCDMNo/KCFsnOk0I0Z+TFmaH2OIbtLdelEm9V6CxLJleVrGICPtvb65Am+CNNMc5rVUJFyxNt7ixeDSLD5yiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF8TNkVz+ZraISPo3fIS4dsN/CIR/cCRADvev/YhI08=;
 b=etCVef5gmuCSvT0BQk3YueoUOIuCdt/ssireHhF93Kivggo535hKPypd1z8irXAeYcLMY6uBbsC2GVzabAQQqXW5PmQDySkQsJbA9qT+IEdV7Ite782w/XGYlgIICRR1Q1+hGv16hYiQOjW+DL4hcmQIzY9Wnla1CoHzR1XAzDqW3ICJKOpaSxx2Il8K47L5TzHaOYFK7I1NvFKJ17PTHiS6D/9NjKSWRP2esch9qS6K+G+O1Laq4ANY+o7Fe8PX+98+fSimwo0MThCzzhQGVqo8wNOgp0JX4U8sWJu2Tftkw/9ht+71tQMoZQr5OPbZQQJXR6MbORSrMxGd+n8NRw==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 04:58:29 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 04:58:29 +0000
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
Subject: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
Date: Wed, 29 May 2024 12:57:49 +0800
Message-ID:
 <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529045749.530039-1-yasin.lee.x@outlook.com>
References: <20240519162438.17af0ff8@jic23-huawei>
 <20240529045749.530039-1-yasin.lee.x@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [p3bD53BxKRqXe1UE0LSq9YKeJd1fnBkQYFhGrguYflCORjQB5h37kVOlccqzJYoN]
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240529045749.530039-3-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: ba75b0d7-9aa4-4b70-95a2-08dc7f9bfad8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	DToRqLH4qg7uXj9OohEknP6GAViaCco7h7PQbcDW/kQjvfpvUDkus5xSV7Z1zYqVYd704YLpwmUahKXJdVcmtQmRipZWdK/k3AWw0VO7gv2iHjjm0obyduf4mILQBwejnrj1ZhZPRQbvjvaJaKm9FHfkPIMZo0k4gQoBUuNgZSOgvoHEbS1tTIASuK9hlinsi0epMTUcuig1B4GHZLbCWs3XayBg1xcYv2HOh+4FCqXMwnhIgCO7WX52V+RGxn6/HhGWqF4odQOnMqI+wEiy5AP5egtrvf+EivZmhFu/00vbaE+g1JY261y7w4mflCAKTu9wDEqxDsR9kKHndIk1biP/VGGQEX9UgoIyp43JrvzXLWMNJx5UTja5nV6a3b9C72dxxvJTFWsdU2+wsLOteAbwhd0AHZGA/qQqDWnN7cA/SmhdG1k+0SQr6jSXN5/DJkTIhKmFG1ibnV/0BdUaLaGcDzgGin8PHMIBK9Ehrk9b3cyeoJQ1fwKPDCsYwUWC6bl5Nheb5A3WDdpJSQ07Y2H246TY7bKlJqR57o6Jj0WBRQw/fVMihgyZn8cwvhOsk32SECJZbg86KWHapPjqByT/al2eXnVcttHzbb9rrgPINPqslt6H3P2vYBGAEl1wKdGM0cCqH4EamIq6/3LVdQrnc7aE4a0TMVePqqbxyfg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VUkvyDvDYw7IOQEQX2n2o/vwn+5c6KXR5/aee/g1Qpe9zJRLMeZVWc6rbrXf?=
 =?us-ascii?Q?wI7NRfGZt5pjdQLkpIho6PXt+A1cfJC25FpIOvDOo/eD1oHPIhMfXowS6v3e?=
 =?us-ascii?Q?UtGWMQ0TnLsotvH6eZN5w2awbc9tV3MV4Y21NGtSudEv4aSYp4ZOVCKB/2hu?=
 =?us-ascii?Q?T6gXLkWpuu7SeGOS49KkIjv/ZrvCIFLXvITHyTeNd34U0po+ZCqGEyZevzZq?=
 =?us-ascii?Q?7Jh/861TYL394I87QxlqbaQKleQWe0x2RuTdHyC81jlrEbFnch8bGbPba3pN?=
 =?us-ascii?Q?3WQAPXD5xS28EJAK8ELnsgD7d3Xxdo5t2jYJdotiMilAaiGB0TTdwb/CcGKe?=
 =?us-ascii?Q?Tj/b1XwXSI6Y0Eg79ru2EtjHD7Ta4Onh5PUFBVRjsbfYyFnbZPeNWdFM75Gf?=
 =?us-ascii?Q?5PoIMiWyIzQ3XqsSYGHJ6VsiBQEk/k08j+Js4TUegM1oHNzJqmd8OJNQqRSb?=
 =?us-ascii?Q?6VarnXZoShkspSEHS5spcq/aaBuFZpJIzKiwxxaFqdlKWUhwPewvTMB0kmys?=
 =?us-ascii?Q?MUDPiRkV08Qj+N4md4ahZRltB2xgUYhD9HTTTRRILNm1R5xpBSqThA4m0HKC?=
 =?us-ascii?Q?VBKm9DI7R3Ts0n5D/2poMOlnBFYO8EboVKMk48xguyySPH8DvnDLY8zXcCkf?=
 =?us-ascii?Q?Rycphgv3heqDwgzAy09sLq1Y0K7A2vx0qrE3Wyd2zdeF5BDLcHMUthPNPnza?=
 =?us-ascii?Q?+5PwfF0wUbH6KIcVbKCrehUKSEmK0x8LOV+aLu03KNxbKi0m6zCLb4itl44h?=
 =?us-ascii?Q?8VWra0eI7NsZdWLnQWtqkcBEuGp9PlspH5H3eM4F0C6y3ErJSpbE0jx/oweX?=
 =?us-ascii?Q?donvirJ/Es4N4bZIj0gdg3SvvQPBkEbhZ8UnDJu/fX/+9uy4Z/smiZ4zQN1A?=
 =?us-ascii?Q?FCn+I0X0Ir+Z0PvbDG5ln8VNrENp9pm6deWYb3YKhRlpwfrCgbWS33xX2Bzn?=
 =?us-ascii?Q?qySQlFq/MD5L9xDzM+UemqUzcUo2rlLroXDs6/DA99G3bvqseTKbDOP4mVLB?=
 =?us-ascii?Q?ax6DuhKYo//o2s1CO/LYbkS0+4I0XWwk7BdI55FdmaUsC3TxPHeRXun1tJmA?=
 =?us-ascii?Q?qiR0t6OTiZEMai1gPoWHaR8DfFB8tc4mPZHPvv+BosghLnPvvnXvUDDBgJ65?=
 =?us-ascii?Q?cJmuhTwBYR5fqz6JH+/XQ3Qs08+Ur6SZpYcUs2I9/m23ugFYWJ/9os93kcZy?=
 =?us-ascii?Q?ri9NCm+DizwmGKIYb73jreD5E5BHjSfFI5IbGgtoV/eHW8HnGGpIlBcUGmYy?=
 =?us-ascii?Q?zzHSQ5EdWCn5r3zBsF0/freofl4Ln2+XJyVlq3/FqVXncilkGzceoZCzob1K?=
 =?us-ascii?Q?9cDycBaAjFrNEwTmrKaHun1z?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba75b0d7-9aa4-4b70-95a2-08dc7f9bfad8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 04:58:28.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

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
 drivers/iio/proximity/Makefile  |    2 +-
 drivers/iio/proximity/hx9023s.c | 1428 +++++++++++++++++++++++++++++++
 3 files changed, 1443 insertions(+), 1 deletion(-)
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
index f36598380446..81144ac47845 100644
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
@@ -21,4 +22,3 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
 obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
-
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
new file mode 100644
index 000000000000..037665227d24
--- /dev/null
+++ b/drivers/iio/proximity/hx9023s.c
@@ -0,0 +1,1428 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
+ * http://www.tianyihexin.com
+ *
+ * Driver for NanjingTianyihexin HX9023S Cap Sensor
+ * Author: Yasin Lee <yasin.lee.x@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/regmap.h>
+
+#include <asm-generic/unaligned.h>
+
+#define HX9023S_CHIP_ID 0x1D
+#define HX9023S_CH_NUM 5
+#define CH_DATA_2BYTES 2
+#define CH_DATA_3BYTES 3
+#define CH_DATA_BYTES_MAX CH_DATA_3BYTES
+#define HX9023S_ODR_MS 200
+#define TYHX_DELAY_MS(x) msleep(x)
+
+#define HX9023S_GLOBAL_CTRL0                   0x00
+#define HX9023S_PRF_CFG                        0x02
+#define HX9023S_CH0_CFG_7_0                    0x03
+#define HX9023S_CH0_CFG_9_8                    0x04
+#define HX9023S_CH1_CFG_7_0                    0x05
+#define HX9023S_CH1_CFG_9_8                    0x06
+#define HX9023S_CH2_CFG_7_0                    0x07
+#define HX9023S_CH2_CFG_9_8                    0x08
+#define HX9023S_CH3_CFG_7_0                    0x09
+#define HX9023S_CH3_CFG_9_8                    0x0A
+#define HX9023S_CH4_CFG_7_0                    0x0B
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
+#define HX9023S_OFFSET_DAC0_9_8                0x16
+#define HX9023S_OFFSET_DAC1_7_0                0x17
+#define HX9023S_OFFSET_DAC1_9_8                0x18
+#define HX9023S_OFFSET_DAC2_7_0                0x19
+#define HX9023S_OFFSET_DAC2_9_8                0x1A
+#define HX9023S_OFFSET_DAC3_7_0                0x1B
+#define HX9023S_OFFSET_DAC3_9_8                0x1C
+#define HX9023S_OFFSET_DAC4_7_0                0x1D
+#define HX9023S_OFFSET_DAC4_9_8                0x1E
+#define HX9023S_SAMPLE_NUM_7_0                 0x1F
+#define HX9023S_SAMPLE_NUM_9_8                 0x20
+#define HX9023S_INTEGRATION_NUM_7_0            0x21
+#define HX9023S_INTEGRATION_NUM_9_8            0x22
+#define HX9023S_GLOBAL_CTRL2                   0x23
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
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH0_1       0x81
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH1_0       0x82
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH1_1       0x83
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH2_0       0x84
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH2_1       0x85
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH3_0       0x86
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH3_1       0x87
+#define HX9023S_PROX_LOW_DIFF_CFG_CH0_0        0x88
+#define HX9023S_PROX_LOW_DIFF_CFG_CH0_1        0x89
+#define HX9023S_PROX_LOW_DIFF_CFG_CH1_0        0x8A
+#define HX9023S_PROX_LOW_DIFF_CFG_CH1_1        0x8B
+#define HX9023S_PROX_LOW_DIFF_CFG_CH2_0        0x8C
+#define HX9023S_PROX_LOW_DIFF_CFG_CH2_1        0x8D
+#define HX9023S_PROX_LOW_DIFF_CFG_CH3_0        0x8E
+#define HX9023S_PROX_LOW_DIFF_CFG_CH3_1        0x8F
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_0       0x9E
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_1       0x9F
+#define HX9023S_PROX_LOW_DIFF_CFG_CH4_0        0xA2
+#define HX9023S_PROX_LOW_DIFF_CFG_CH4_1        0xA3
+#define HX9023S_PROX_THRES_SHIFT_CFG0          0xA8
+#define HX9023S_PROX_THRES_SHIFT_CFG1          0xA9
+#define HX9023S_PROX_THRES_SHIFT_CFG2          0xAA
+#define HX9023S_PROX_THRES_SHIFT_CFG3          0xAB
+#define HX9023S_PROX_THRES_SHIFT_CFG4          0xAC
+#define HX9023S_CH10_SCAN_FACTOR               0xC0
+#define HX9023S_CH32_SCAN_FACTOR               0xC1
+#define HX9023S_CH10_DOZE_FACTOR               0xC4
+#define HX9023S_CH32_DOZE_FACTOR               0xC5
+#define HX9023S_CH4_FACTOR_CTRL                0xC7
+#define HX9023S_DSP_CONFIG_CTRL1               0xC8
+#define HX9023S_DSP_CONFIG_CTRL2               0xC9
+#define HX9023S_DSP_CONFIG_CTRL3               0xCA
+#define HX9023S_RAW_BL_CH0_0                   0xE8
+#define HX9023S_RAW_BL_CH0_1                   0xE9
+#define HX9023S_RAW_BL_CH0_2                   0xEA
+#define HX9023S_RAW_BL_CH1_0                   0xEB
+#define HX9023S_RAW_BL_CH1_1                   0xEC
+#define HX9023S_RAW_BL_CH1_2                   0xED
+#define HX9023S_RAW_BL_CH2_0                   0xEE
+#define HX9023S_RAW_BL_CH2_1                   0xEF
+#define HX9023S_RAW_BL_CH2_2                   0xF0
+#define HX9023S_RAW_BL_CH3_0                   0xF1
+#define HX9023S_RAW_BL_CH3_1                   0xF2
+#define HX9023S_RAW_BL_CH3_2                   0xF3
+#define HX9023S_RAW_BL_CH4_0                   0xB5
+#define HX9023S_RAW_BL_CH4_1                   0xB6
+#define HX9023S_RAW_BL_CH4_2                   0xB7
+#define HX9023S_LP_DIFF_CH0_0                  0xF4
+#define HX9023S_LP_DIFF_CH0_1                  0xF5
+#define HX9023S_LP_DIFF_CH0_2                  0xF6
+#define HX9023S_LP_DIFF_CH1_0                  0xF7
+#define HX9023S_LP_DIFF_CH1_1                  0xF8
+#define HX9023S_LP_DIFF_CH1_2                  0xF9
+#define HX9023S_LP_DIFF_CH2_0                  0xFA
+#define HX9023S_LP_DIFF_CH2_1                  0xFB
+#define HX9023S_LP_DIFF_CH2_2                  0xFC
+#define HX9023S_LP_DIFF_CH3_0                  0xFD
+#define HX9023S_LP_DIFF_CH3_1                  0xFE
+#define HX9023S_LP_DIFF_CH3_2                  0xFF
+#define HX9023S_LP_DIFF_CH4_0                  0xB8
+#define HX9023S_LP_DIFF_CH4_1                  0xB9
+#define HX9023S_LP_DIFF_CH4_2                  0xBA
+
+#define HX9023S_DATA_LOCK_MASK BIT(4)
+#define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
+#define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
+
+struct hx9023s_threshold {
+	int near;
+	int far;
+};
+
+struct hx9023s_addr_val_pair {
+	uint8_t addr;
+	uint8_t val;
+};
+
+struct hx9023s_channel_info {
+	bool enabled;
+	bool used;
+	int state;
+};
+
+static struct hx9023s_addr_val_pair hx9023s_reg_init_list[] = {
+	{ HX9023S_CH_NUM_CFG,                 0x00 },
+	{ HX9023S_GLOBAL_CTRL0,               0x00 },
+	{ HX9023S_GLOBAL_CTRL2,               0x00 },
+
+	{ HX9023S_PRF_CFG,                    0x17 },
+	{ HX9023S_RANGE_7_0,                  0x11 },
+	{ HX9023S_RANGE_9_8,                  0x02 },
+	{ HX9023S_RANGE_18_16,                0x00 },
+
+	{ HX9023S_AVG0_NOSR0_CFG,             0x71 },
+	{ HX9023S_NOSR12_CFG,                 0x44 },
+	{ HX9023S_NOSR34_CFG,                 0x00 },
+	{ HX9023S_AVG12_CFG,                  0x33 },
+	{ HX9023S_AVG34_CFG,                  0x00 },
+
+	{ HX9023S_SAMPLE_NUM_7_0,             0x65 },
+	{ HX9023S_INTEGRATION_NUM_7_0,        0x65 },
+
+	{ HX9023S_LP_ALP_1_0_CFG,             0x22 },
+	{ HX9023S_LP_ALP_3_2_CFG,             0x22 },
+	{ HX9023S_LP_ALP_4_CFG,               0x02 },
+	{ HX9023S_UP_ALP_1_0_CFG,             0x88 },
+	{ HX9023S_UP_ALP_3_2_CFG,             0x88 },
+	{ HX9023S_DN_UP_ALP_0_4_CFG,          0x18 },
+	{ HX9023S_DN_ALP_2_1_CFG,             0x11 },
+	{ HX9023S_DN_ALP_4_3_CFG,             0x11 },
+
+	{ HX9023S_RAW_BL_RD_CFG,              0xF0 },
+	{ HX9023S_INTERRUPT_CFG,              0xFF },
+	{ HX9023S_INTERRUPT_CFG1,             0x3B },
+	{ HX9023S_CALI_DIFF_CFG,              0x07 },
+	{ HX9023S_DITHER_CFG,                 0x21 },
+	{ HX9023S_PROX_INT_HIGH_CFG,          0x01 },
+	{ HX9023S_PROX_INT_LOW_CFG,           0x01 },
+
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH0_0,   0x0A },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH0_1,   0x00 },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH1_0,   0x0A },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH1_1,   0x00 },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH2_0,   0x0A },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH2_1,   0x00 },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH3_0,   0x0A },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH3_1,   0x00 },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH4_0,   0x0A },
+	{ HX9023S_PROX_HIGH_DIFF_CFG_CH4_1,   0x00 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH0_0,    0x08 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH0_1,    0x00 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH1_0,    0x08 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH1_1,    0x00 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH2_0,    0x08 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH2_1,    0x00 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH3_0,    0x08 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH3_1,    0x00 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH4_0,    0x08 },
+	{ HX9023S_PROX_LOW_DIFF_CFG_CH4_1,    0x00 },
+
+	{ HX9023S_PROX_THRES_SHIFT_CFG0,      0x00 },
+	{ HX9023S_PROX_THRES_SHIFT_CFG1,      0x00 },
+	{ HX9023S_PROX_THRES_SHIFT_CFG2,      0x00 },
+	{ HX9023S_PROX_THRES_SHIFT_CFG3,      0x00 },
+	{ HX9023S_PROX_THRES_SHIFT_CFG4,      0x00 },
+
+	{ HX9023S_CH10_SCAN_FACTOR,           0x00 },
+	{ HX9023S_CH32_SCAN_FACTOR,           0x00 },
+	{ HX9023S_CH10_DOZE_FACTOR,           0x00 },
+	{ HX9023S_CH32_DOZE_FACTOR,           0x00 },
+	{ HX9023S_CH4_FACTOR_CTRL,            0x00 },
+	{ HX9023S_DSP_CONFIG_CTRL1,           0x00 },
+	{ HX9023S_DSP_CONFIG_CTRL3,           0x00 },
+};
+
+struct hx9023s_data {
+	struct mutex mutex;
+	struct i2c_client *client;
+	struct iio_trigger *trig;
+	struct regmap *regmap;
+	unsigned long chan_prox_stat;
+	bool trigger_enabled;
+	struct {
+		__be16 channels[HX9023S_CH_NUM];
+
+		s64 ts __aligned(8);
+
+	} buffer;
+	unsigned long chan_read;
+	unsigned long chan_event;
+
+	struct hx9023s_threshold thres[HX9023S_CH_NUM];
+	struct hx9023s_channel_info *chs_info;
+	unsigned long ch_en_stat;
+	unsigned int prox_state_reg;
+	unsigned int accuracy;
+	unsigned long channel_used_flag;
+	unsigned int cs_position[HX9023S_CH_NUM];
+	unsigned int channel_positive[HX9023S_CH_NUM];
+	unsigned int channel_negative[HX9023S_CH_NUM];
+	int raw[HX9023S_CH_NUM];
+	int lp[HX9023S_CH_NUM]; /*low pass*/
+	int bl[HX9023S_CH_NUM]; /*base line*/
+	int diff[HX9023S_CH_NUM]; /*lp - bl*/
+	uint16_t dac[HX9023S_CH_NUM];
+	bool sel_bl[HX9023S_CH_NUM];
+	bool sel_raw[HX9023S_CH_NUM];
+	bool sel_diff[HX9023S_CH_NUM];
+	bool sel_lp[HX9023S_CH_NUM];
+	unsigned int odr;
+	unsigned int integration_sample;
+	unsigned int osr[HX9023S_CH_NUM];
+	unsigned int avg[HX9023S_CH_NUM];
+	unsigned int lp_alpha[HX9023S_CH_NUM];
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
+	3000, 4000
+};
+
+static const struct regmap_config hx9023s_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int hx9023s_interrupt_en(struct hx9023s_data *data, bool en)
+{
+	int ret;
+
+	if (en) {
+		ret = regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
+					HX9023S_INTERRUPT_MASK, HX9023S_INTERRUPT_MASK);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	} else {
+		ret = regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
+					HX9023S_INTERRUPT_MASK, 0x00);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
+{
+	int ret;
+
+	if (locked) {
+		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
+					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	} else {
+		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
+					GENMASK(4, 3), 0x00);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int hx9023s_get_id(struct hx9023s_data *data)
+{
+	int ret;
+	unsigned int rxbuf[1];
+
+	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, rxbuf);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hx9023s_para_cfg(struct hx9023s_data *data)
+{
+	int ret;
+	uint8_t buf[3];
+
+	ret = regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &data->odr, 1);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c write failed\n");
+		return ret;
+	}
+
+	buf[0] = data->integration_sample & 0xFF;
+	buf[1] = data->integration_sample >> 8;
+	ret = regmap_bulk_write(data->regmap, HX9023S_SAMPLE_NUM_7_0, buf, 2);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c write failed\n");
+		return ret;
+	}
+
+	ret = regmap_bulk_write(data->regmap, HX9023S_INTEGRATION_NUM_7_0, buf, 2);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c write failed\n");
+		return ret;
+	}
+
+	buf[0] = (data->avg[2] << 4) | data->avg[1];
+	buf[1] = (data->avg[4] << 4) | data->avg[3];
+	ret = regmap_bulk_write(data->regmap, HX9023S_AVG12_CFG, buf, 2);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c write failed\n");
+		return ret;
+	}
+
+	buf[0] = (data->osr[2] << 4) | data->osr[1];
+	buf[1] = (data->osr[4] << 4) | data->osr[3];
+	ret = regmap_bulk_write(data->regmap, HX9023S_NOSR12_CFG, buf, 2);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c write failed\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, HX9023S_AVG0_NOSR0_CFG, GENMASK(7, 2),
+				((data->avg[0] << 5) | (data->osr[0] << 2)));
+	if (ret < 0) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	buf[0] = data->lp_alpha[4];
+	buf[1] = (data->lp_alpha[1] << 4) | data->lp_alpha[0];
+	buf[2] = (data->lp_alpha[3] << 4) | data->lp_alpha[2];
+	ret = regmap_bulk_write(data->regmap, HX9023S_LP_ALP_4_CFG, buf, 3);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c write failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int hx9023s_ch_cfg(struct hx9023s_data *data)
+{
+	int ret;
+	int i;
+	uint16_t reg;
+	uint8_t reg_list[HX9023S_CH_NUM * 2];
+	uint8_t ch_pos[HX9023S_CH_NUM];
+	uint8_t ch_neg[HX9023S_CH_NUM];
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		if (data->channel_positive[i] == 255)
+			ch_pos[i] = 16;
+		else
+			ch_pos[i] = data->cs_position[data->channel_positive[i]];
+		if (data->channel_negative[i] == 255)
+			ch_neg[i] = 16;
+		else
+			ch_neg[i] = data->cs_position[data->channel_negative[i]];
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		reg = (uint16_t)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));
+		reg_list[i * 2] = (uint8_t)(reg);
+		reg_list[i * 2 + 1] = (uint8_t)(reg >> 8);
+	}
+
+	ret = regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
+	if (ret)
+		dev_err(&data->client->dev, "i2c write failed\n");
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
+		if (ret) {
+			dev_err(&data->client->dev, "i2c write failed\n");
+			return ret;
+		}
+	}
+
+	return ret;
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
+	if (ret < 0) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
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
+	if (ret < 0) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int hx9023s_read_far_debounce(struct hx9023s_data *data, int *val)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_PROX_INT_LOW_CFG, val);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	*val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_read_near_debounce(struct hx9023s_data *data, int *val)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_PROX_INT_HIGH_CFG, val);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	*val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_thres_near(struct hx9023s_data *data, uint8_t ch, int *val)
+{
+	int ret;
+	uint8_t buf[2];
+
+	if (ch == 4) {
+		ret = regmap_bulk_read(data->regmap, HX9023S_PROX_HIGH_DIFF_CFG_CH4_0, buf, 2);
+		if (ret) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	} else {
+		ret = regmap_bulk_read(data->regmap,
+				HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * CH_DATA_2BYTES), buf, 2);
+		if (ret) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	}
+
+	*val = get_unaligned_le16(buf);
+	*val = (*val & GENMASK(9, 0)) * 32;
+	data->thres[ch].near = *val;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_thres_far(struct hx9023s_data *data, uint8_t ch, int *val)
+{
+	int ret;
+	uint8_t buf[2];
+
+	if (ch == 4) {
+		ret = regmap_bulk_read(data->regmap, HX9023S_PROX_LOW_DIFF_CFG_CH4_0, buf, 2);
+		if (ret) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	} else {
+		ret = regmap_bulk_read(data->regmap,
+				HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * CH_DATA_2BYTES), buf, 2);
+		if (ret) {
+			dev_err(&data->client->dev, "i2c read failed\n");
+			return ret;
+		}
+	}
+
+	*val = get_unaligned_le16(buf);
+	*val = (*val & GENMASK(9, 0)) * 32;
+	data->thres[ch].far = *val;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_set_thres_near(struct hx9023s_data *data, uint8_t ch, int val)
+{
+	int ret;
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+
+	data->thres[ch].near = ((val / 32) & GENMASK(9, 0)) * 32;
+
+	if (ch == 4) {
+		ret = regmap_bulk_write(data->regmap, HX9023S_PROX_HIGH_DIFF_CFG_CH4_0,
+					&val_le16, sizeof(val_le16));
+		if (ret)
+			dev_err(&data->client->dev, "i2c write failed\n");
+	} else {
+		ret = regmap_bulk_write(data->regmap,
+					HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * CH_DATA_2BYTES),
+					&val_le16, sizeof(val_le16));
+		if (ret)
+			dev_err(&data->client->dev, "i2c write failed\n");
+	}
+
+	return ret;
+}
+
+static int hx9023s_set_thres_far(struct hx9023s_data *data, uint8_t ch, int val)
+{
+	int ret;
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+
+	data->thres[ch].far = ((val / 32) & GENMASK(9, 0)) * 32;
+
+	if (ch == 4) {
+		ret = regmap_bulk_write(data->regmap, HX9023S_PROX_LOW_DIFF_CFG_CH4_0,
+					&val_le16, sizeof(val_le16));
+		if (ret)
+			dev_err(&data->client->dev, "i2c write failed\n");
+	} else {
+		ret = regmap_bulk_write(data->regmap,
+					HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * CH_DATA_2BYTES),
+					&val_le16, sizeof(val_le16));
+		if (ret)
+			dev_err(&data->client->dev, "i2c write failed\n");
+	}
+
+	return ret;
+}
+
+static void hx9023s_get_prox_state(struct hx9023s_data *data)
+{
+	int ret;
+	unsigned int buf[1];
+
+	data->prox_state_reg = 0;
+	ret = regmap_read(data->regmap, HX9023S_PROX_STATUS, buf);
+	if (ret)
+		dev_err(&data->client->dev, "i2c read failed\n");
+	data->prox_state_reg = buf[0];
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
+		dev_err(&data->client->dev, "i2c read failed\n");
+
+	for (i = 0; i < 4; i++) {
+		data->sel_diff[i] = test_bit(i, &buf[0]);
+		data->sel_lp[i] = !data->sel_diff[i];
+		data->sel_bl[i] = test_bit(i + 4, &buf[0]);
+		data->sel_raw[i] = !data->sel_bl[i];
+	}
+
+	ret = regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, (unsigned int *)buf);
+	if (ret)
+		dev_err(&data->client->dev, "i2c read failed\n");
+
+	data->sel_diff[4] = test_bit(2, &buf[0]);
+	data->sel_lp[4] = !data->sel_diff[4];
+	data->sel_bl[4] = test_bit(3, &buf[0]);
+	data->sel_raw[4] = !data->sel_bl[4];
+}
+
+static int hx9023s_sample(struct hx9023s_data *data)
+{
+	int ret;
+	int i;
+	uint8_t data_size;
+	uint8_t offset_data_size;
+	int value;
+	uint8_t rx_buf[HX9023S_CH_NUM * CH_DATA_BYTES_MAX];
+
+	hx9023s_data_lock(data, true);
+	hx9023s_data_select(data);
+
+	data_size = CH_DATA_3BYTES;
+
+	/*ch0~ch3*/
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, rx_buf,
+				(HX9023S_CH_NUM * data_size) - data_size);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	/*ch4*/
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0,
+				rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		if (data->accuracy == 16) {
+			value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
+			value = sign_extend32(value, 15);
+		} else {
+			value = get_unaligned_le24(&rx_buf[i * data_size]);
+			value = sign_extend32(value, 23);
+		}
+		data->raw[i] = 0;
+		data->bl[i] = 0;
+		if (true == data->sel_raw[i])
+			data->raw[i] = value;
+		if (true == data->sel_bl[i])
+			data->bl[i] = value;
+	}
+
+	/*ch0~ch3*/
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, rx_buf,
+				(HX9023S_CH_NUM * data_size) - data_size);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	/*ch4*/
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0,
+				rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		if (data->accuracy == 16) {
+			value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
+			value = sign_extend32(value, 15);
+		} else {
+			value = get_unaligned_le24(&rx_buf[i * data_size]);
+			value = sign_extend32(value, 23);
+		}
+		data->lp[i] = 0;
+		data->diff[i] = 0;
+		if (true == data->sel_lp[i])
+			data->lp[i] = value;
+		if (true == data->sel_diff[i])
+			data->diff[i] = value;
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		if (true == data->sel_lp[i] && true == data->sel_bl[i])
+			data->diff[i] = data->lp[i] - data->bl[i];
+	}
+
+	/*offset dac*/
+	offset_data_size = CH_DATA_2BYTES;
+	ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, rx_buf,
+				(HX9023S_CH_NUM * offset_data_size));
+	if (ret) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
+		value = value & 0xFFF;
+		data->dac[i] = value;
+	}
+
+	hx9023s_data_lock(data, false);
+	return ret;
+}
+
+static int hx9023s_ch_en(struct hx9023s_data *data, uint8_t ch_id, bool en)
+{
+	int ret;
+	unsigned int rx_buf[1];
+
+	ret = regmap_read(data->regmap, HX9023S_CH_NUM_CFG, rx_buf);
+	if (ret) {
+		dev_err(&data->client->dev, "i2c read failed\n");
+		return ret;
+	}
+	data->ch_en_stat = rx_buf[0];
+
+	if (en) {
+		if (data->ch_en_stat == 0)
+			data->prox_state_reg = 0;
+		set_bit(ch_id, &data->ch_en_stat);
+		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
+		if (ret) {
+			dev_err(&data->client->dev, "i2c write failed\n");
+			return ret;
+		}
+		TYHX_DELAY_MS(10);
+	} else {
+		clear_bit(ch_id, &data->ch_en_stat);
+		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
+		if (ret) {
+			dev_err(&data->client->dev, "i2c write failed\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int hx9023s_ch_en_hal(struct hx9023s_data *data, uint8_t ch_id, bool en)
+{
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	if (en) {
+		ret = hx9023s_ch_en(data, ch_id, en);
+		if (ret) {
+			dev_err(&data->client->dev, "channel enable failed\n");
+			return ret;
+		}
+		data->chs_info[ch_id].state = 0;
+		data->chs_info[ch_id].enabled = true;
+	} else {
+		ret = hx9023s_ch_en(data, ch_id, en);
+		if (ret) {
+			dev_err(&data->client->dev, "channel enable failed\n");
+			return ret;
+		}
+		data->chs_info[ch_id].state = 0;
+		data->chs_info[ch_id].enabled = false;
+	}
+
+	return 0;
+}
+
+static int hx9023s_dts_phase(struct hx9023s_data *data)
+{
+	int ret;
+	struct device_node *np = data->client->dev.of_node;
+	unsigned int channel_used_flag;
+
+	ret = of_property_read_u32(np, "odr", &data->odr);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read odr property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "integration-sample", &data->integration_sample);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read integration_sample property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(np, "osr", data->osr, HX9023S_CH_NUM);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read osr property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(np, "avg", data->avg, HX9023S_CH_NUM);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read avg property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(np, "lp-alpha", data->lp_alpha, HX9023S_CH_NUM);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read lp_alpha property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "accuracy", &data->accuracy);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read accuracy property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "channel-used-flag", &channel_used_flag);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read channel-used-flag property\n");
+		return ret;
+	}
+	data->channel_used_flag = channel_used_flag;
+
+	ret = of_property_read_u32_array(np, "cs-position", data->cs_position, HX9023S_CH_NUM);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read cs-position property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(np, "channel-positive", data->channel_positive,
+					HX9023S_CH_NUM);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read channel-positive property\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(np, "channel-negative", data->channel_negative,
+					HX9023S_CH_NUM);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to read channel-negative property\n");
+		return ret;
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
+		for (i = 0; i < HX9023S_CH_NUM; i++) {
+			if (test_bit(i, &data->channel_used_flag) && test_bit(i, &channels))
+				hx9023s_ch_en_hal(data, i, true);
+			else
+				hx9023s_ch_en_hal(data, i, false);
+		}
+	}
+
+	data->chan_read = chan_read;
+	data->chan_event = chan_event;
+	return 0;
+}
+
+static int hx9023s_get_proximity(struct hx9023s_data *data,
+				const struct iio_chan_spec *chan,
+				int *val)
+{
+	hx9023s_sample(data);
+	hx9023s_get_prox_state(data);
+	*val = data->diff[chan->channel];
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
+{
+	int ret;
+	unsigned int odr;
+	unsigned int buf[1];
+
+	ret = regmap_read(data->regmap, HX9023S_PRF_CFG, buf);
+	if (ret)
+		dev_err(&data->client->dev, "i2c read failed\n");
+
+	odr = hx9023s_samp_freq_table[buf[0]];
+	*val = 1000 / odr;
+	*val2 = ((1000 % odr) * 1000000ULL) / odr;
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
+	uint8_t buf[1];
+
+	period_ms = div_u64(1000000000ULL, (val * 1000000ULL + val2));
+
+	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
+		if (period_ms == hx9023s_samp_freq_table[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(hx9023s_samp_freq_table)) {
+		dev_err(&data->client->dev, "Period:%dms NOT found!\n", period_ms);
+		return -EINVAL;
+	}
+
+	buf[0] = i;
+	ret = regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &buf[0], 1);
+	if (ret)
+		dev_err(&data->client->dev, "i2c read failed\n");
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
+	if (test_bit(chan->channel, &data->channel_used_flag)) {
+		hx9023s_ch_en_hal(data, chan->channel, !!state);
+		if (data->chs_info[chan->channel].enabled)
+			set_bit(chan->channel, &data->chan_event);
+		else
+			clear_bit(chan->channel, &data->chan_event);
+	}
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
+		hx9023s_interrupt_en(data, true);
+	else if (!data->chan_read)
+		hx9023s_interrupt_en(data, false);
+	data->trigger_enabled = state;
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
+	int i = 0;
+
+	guard(mutex)(&data->mutex);
+	hx9023s_sample(data);
+	hx9023s_get_prox_state(data);
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
+		data->buffer.channels[i++] = data->diff[indio_dev->channels[bit].channel];
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
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
+	return 0;
+}
+
+static int hx9023s_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+	hx9023s_update_chan_en(data, 0, data->chan_event);
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
+	int i;
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct hx9023s_data *data;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
+	if (!indio_dev)
+		return dev_err_probe(&client->dev, -ENOMEM, "device alloc failed\n");
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->mutex);
+
+	ret = hx9023s_dts_phase(data);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "dts phase failed\n");
+
+	data->chs_info = devm_kzalloc(&data->client->dev,
+				sizeof(struct hx9023s_channel_info) * HX9023S_CH_NUM, GFP_KERNEL);
+	if (data->chs_info == NULL)
+		return dev_err_probe(&data->client->dev, -ENOMEM, "channel info alloc failed\n");
+
+	for (i = 0; i < HX9023S_CH_NUM; i++)
+		if (test_bit(i, &data->channel_used_flag))
+			data->chs_info[i].used = true;
+
+	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		ret = PTR_ERR(data->regmap);
+		return dev_err_probe(&data->client->dev, ret, "regmap init failed\n");
+	}
+
+	ret = devm_regulator_get_enable(&data->client->dev, "vdd");
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "regulator get failed\n");
+
+	usleep_range(1000, 1100);
+
+	ret = hx9023s_get_id(data);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "id check failed\n");
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
+		return dev_err_probe(&data->client->dev, ret, "device init failed\n");
+
+	ret = hx9023s_ch_cfg(data);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "channel config failed\n");
+
+	ret = hx9023s_para_cfg(data);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "parameter config failed\n");
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
+						hx9023s_irq_thread_handler, IRQF_ONESHOT,
+						"hx9023s_event", indio_dev);
+		if (ret)
+			return dev_err_probe(&data->client->dev, ret, "irq request failed\n");
+
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+						iio_device_id(indio_dev));
+		if (!data->trig)
+			return dev_err_probe(&data->client->dev, -ENOMEM,
+					"iio trigger alloc failed\n");
+
+		data->trig->ops = &hx9023s_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, data->trig);
+		if (ret)
+			return dev_err_probe(&data->client->dev, ret,
+					"iio trigger register failed\n");
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
+					hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret,
+				"iio triggered buffer setup failed\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "iio device register failed\n");
+
+	return 0;
+}
+
+static int hx9023s_suspend(struct device *dev)
+{
+	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
+
+	hx9023s_interrupt_en(data, false);
+	return 0;
+}
+
+static int hx9023s_resume(struct device *dev)
+{
+	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
+
+	hx9023s_interrupt_en(data, true);
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s_resume);
+
+static const struct acpi_device_id hx9023s_acpi_match[] = {
+	{ .id = "TYHX9023", .driver_data = HX9023S_CHIP_ID },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hx9023s_acpi_match);
+
+static const struct of_device_id hx9023s_of_match[] = {
+	{ .compatible = "tyhx,hx9023s", (void *)HX9023S_CHIP_ID },
+	{}
+};
+MODULE_DEVICE_TABLE(of, hx9023s_of_match);
+
+static const struct i2c_device_id hx9023s_id[] = {
+	{ .name = "hx9023s", .driver_data = HX9023S_CHIP_ID },
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


