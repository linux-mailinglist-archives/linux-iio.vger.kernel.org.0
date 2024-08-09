Return-Path: <linux-iio+bounces-8351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E9994CF4A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 13:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3155B28465B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75827193060;
	Fri,  9 Aug 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="eorrAgIE"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340E15A86B;
	Fri,  9 Aug 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202229; cv=fail; b=hxhketvBg3LZb8bQHhktkQeGe0bvL4PmdddSHwBqI4a6rG3JhAWqfozBY5EvrnKJeZ81gGjDGtLVmGBpnJ29udo3+vGloi5rdKgqm8sEtWmqbxmbgnbWbiX2Q/Y/OzR5OLJS4v6rsz3zS1xbyt15ZPoMyEn1dSDVbk+nvYvXQHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202229; c=relaxed/simple;
	bh=lwToPlafuVehN/g3zrpxoNZMsE9cFKp3VZIYAERtUKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g19Ou1am+Crl+rEx4OtPT11v8OqzoF4gHpZOsGl6jp4dHkZfJtFUFiUFjwVnHdvzr0U9Co+XWVblCPCmJSLWBo7DT386M9gpwcb8i6b/2PPgI+6b3ViUQqpsWb9UWZeVISorimZwz7al3imEk2z2GNXxBRx6WRe5OqcZKN87+q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=eorrAgIE; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBNdh+1sE+z5J/zsRPdh9Yt/Gy48Dp3Z3APotp/pYIz9lQeTs55DcNKZ5SSzJnoZLEmBzGChtxdfweINMM5x63LSLgBihQapzLULExZGpgYhiYAbSm6SA1go6p33gSnm27A6JRacCO5a/0x4/DOF6tHBmCSKYxR++TlMMwMWH12yMAxB5obUtzuQij0y3+zBTnFOkD6y0mYTcy9WlZw7yLLtdur278PGwoj4mYlrjXwpWeD1705/d1d7sORS6J/gWXTObTV9/YjKIYbv/+H3M8n1QmX5eWwtI5l9U/XkPJ9pkTNHVF9yg9oH24WZDuktVp2kK10XXtSYq5xwbdpp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ythG+xoTUU/deJ34ehi0wuX6Ex5Zx0MEIa0civtpgMQ=;
 b=uz3uKln4RCXtk8+39pPHd4WXZvZTNNKkpmKCgG2J+1zglxDwlJ+rJdIi2Zfi8BL3/m3zTNPOy9XJSOLuVxfKWQ2Vv4Z9vnrW0y2AoRuBts+Y2rjwZ4Bx0CUV2er9VOTUO+kW2QjV6uHnzO3bM+IluCboXsd5zfJoD7ycbYvGEvRHl+S7wgGNePIqtkkmjitkdzgnE6LxXKwJocMwQNZmYRhFx+89SWKhgD2sktA0rZLX/DZ3+54Ay+tF8nsyoXJupylhkm5ZTwxLzMfVgd7AEXL/L6KPbSBOJ/1tbRKRPy2GYHNETsyI/4iBIeGTDWVoE+yk+LGtOdlhAATth25SKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ythG+xoTUU/deJ34ehi0wuX6Ex5Zx0MEIa0civtpgMQ=;
 b=eorrAgIEUwnninvAKjqSGVtFEr4CKhr7Db20g/TBVGu7OrpdYkPvnseE88xPzKcWMT+CwYukz2JAbJ0mDYbNtUjN1kLFgZ2uuNIpr0HtxuR61dx2MDTUCf2j1ibo4fW0mdYsracbzaYPcpbg3/JBDvY/TwQy5bHoRFxVL0RXwMkJn/Z0h1fU6QoC6794BPEviVeV1M0e+EKtRH6Uj4fJUMCBGmhgH9pZZtj2HS0Wbr1tNaTJ2wR7CZYbW0fe74zt7YXz5BVbgt1QSyJlJvxUCdLAwv8mSoUQotMiSRe/2r0E8OAvTsiRduM/3szGXh7Sb27GOW4JtwQ9eeYSmD3hKg==
Received: from AM6P194CA0009.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::22)
 by DU0PR10MB7051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Fri, 9 Aug
 2024 11:17:01 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:209:90:cafe::5d) by AM6P194CA0009.outlook.office365.com
 (2603:10a6:209:90::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Fri, 9 Aug 2024 11:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 11:17:01 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 13:16:59 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 13:16:59 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v2 2/2] iio: imu: smi240: imu driver
Date: Fri, 9 Aug 2024 13:16:35 +0200
Message-ID: <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|DU0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f228ed8-d5c5-47d4-457b-08dcb864ca90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wjEG7frgcEQ+5zUkVuwcnkbtW0ray67NLlfj4O17viEZeUclKmMXQ7N+3KBR?=
 =?us-ascii?Q?Hbw5oCc1pL/RvX7eKlX2vkX+8MgAB9ugicjxyA2kFuXLYJRqtL3gLuyDwwvF?=
 =?us-ascii?Q?sWw78rABYiUxBOf+ES81/8E+seH1V2Vpg4ZNF/1ZylQ0YxZooclq1594mBn7?=
 =?us-ascii?Q?OsHXFV8x8JWrgdpjbZiW1x1ozQ/9SyOQAJDagqgHhHADBS9/rXMPI9rpjbt6?=
 =?us-ascii?Q?gOHZvXFUx5jfZiHsI38Knfxy3ixaFDdvy18Cr8VJCXwBMzPUAb2tIXs0BT8Q?=
 =?us-ascii?Q?Z7hkXF1MEgWSchWS+lRuFcABWtM+eu2Oz/tebCNul703WgOW+rw6C4ptKgXI?=
 =?us-ascii?Q?qYD8L8gjRe5ywg1IFi7ep2rzq26oca5DKuwR/zQglKEEmbCWPWXdR6vEL/J+?=
 =?us-ascii?Q?RSv3WLOXdLZtIJw0yQNBhKSv04aljhS3HH0bke5xvh0P+toYSyp8mhTikEJ0?=
 =?us-ascii?Q?yZWNKL5edMALcQZYg8x3YtBd2aGw1rv5jgozKEAi7y1DOcsX1ZKakPnofU4s?=
 =?us-ascii?Q?Uro0DRL1cAdBfG+f1NZpN7XhaEFjmazx/OIQtgbnfKV19pfF+oGpBcmwnJpC?=
 =?us-ascii?Q?SuUEIh7Cbsfg6l1jATTWuSEtiyJN8auG/j3eTkOYKOxHMeeY1Wg4MjUXcJZa?=
 =?us-ascii?Q?HU+FGTEp3ZImRRnTKauct+cPZn/pOXOhmIyT0RI8w+3FYyQA52Lgt3/3w6KJ?=
 =?us-ascii?Q?V1c6I0a4YjY6ej/F3iKYEtw66k3xO6JfM3zs2vzF5mKSVdKQgWmP4VzpbDRP?=
 =?us-ascii?Q?PRpEWyMQrO7NZTTP5YzOW725Ii3u2gdqdDl2owR0fM/JjocN2z8wer+yPOpP?=
 =?us-ascii?Q?2UaT66H72yF7oHrlVxGyh868YrH7iAUO1EhvLn9V60URHLlV8p3aX6u6ZzKa?=
 =?us-ascii?Q?wV/l0ocumuC3tI6kU6V7uHeldKhHkoKC7TnN1A4DPCZSKECMWWAUOs2sfa61?=
 =?us-ascii?Q?5Gg9s1rOfoMv/236SGnTJo38VYwUMjRw7c1oQeVuZFTTE4FJsO5cmOQmT6rI?=
 =?us-ascii?Q?5WL0f6ssK1h9ELHsqxUV6sqKZo5VwBB+83U04IdvuX2zOICrZXh99HdhQA+c?=
 =?us-ascii?Q?xD0OsRkckngiLSamIHus5MH+yjsFmYflw37NtDXTh74AoExjUgLZ+rLsH2Nl?=
 =?us-ascii?Q?aBguIebNPwWAdI4vHUAQ6ZIvObXHD+sQ2XZPxzabSxvL4p1V0lEtaNX9lINB?=
 =?us-ascii?Q?ypOuclISu0vBkBuf8aFfv6XwVwOy6AmfjQqH+smTzZxgqXSVOCIFqDdNLfUB?=
 =?us-ascii?Q?ZMaez9jdETUOG6fIbrDSbKF22xOwl4JKYreGKyqroHJfgP/3EUTU3dyrQcz9?=
 =?us-ascii?Q?PMCPTUzgnynkgcuzANe7n4F0ImSXevhGxLtBvWkU0vo8iF6zSGV6yjK2QJ1D?=
 =?us-ascii?Q?q8ps00kVcp57czehxzjj2ua8toJrw+eE0MEdoVYiYJQsYAm/UnIBgSFI8I5m?=
 =?us-ascii?Q?ofvo57PWYr3PBGaV9VFpfYXcmpoJp4FZ5V7Xtx7QrNRZ9BDxBsvTrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 11:17:01.3679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f228ed8-d5c5-47d4-457b-08dcb864ca90
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7051

From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>

iio: imu: smi240: driver improvements
Signed-off-by: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>
---

Notes:
    v1 -> v2
    - Use regmap for register access
    - Redefine channel for each singel axis
    - Provide triggered buffer
    - Fix findings in Kconfig
    - Remove unimportant functions

 drivers/iio/imu/Kconfig              |   1 +
 drivers/iio/imu/Makefile             |   1 +
 drivers/iio/imu/smi240/Kconfig       |  12 +
 drivers/iio/imu/smi240/Makefile      |   7 +
 drivers/iio/imu/smi240/smi240.h      |  30 ++
 drivers/iio/imu/smi240/smi240_core.c | 392 +++++++++++++++++++++++++++
 drivers/iio/imu/smi240/smi240_spi.c  | 173 ++++++++++++
 7 files changed, 616 insertions(+)
 create mode 100644 drivers/iio/imu/smi240/Kconfig
 create mode 100644 drivers/iio/imu/smi240/Makefile
 create mode 100644 drivers/iio/imu/smi240/smi240.h
 create mode 100644 drivers/iio/imu/smi240/smi240_core.c
 create mode 100644 drivers/iio/imu/smi240/smi240_spi.c

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 52a155ff325..8808074513d 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -96,6 +96,7 @@ config KMX61
 
 source "drivers/iio/imu/inv_icm42600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
+source "drivers/iio/imu/smi240/Kconfig"
 source "drivers/iio/imu/st_lsm6dsx/Kconfig"
 source "drivers/iio/imu/st_lsm9ds0/Kconfig"
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 7e2d7d5c3b7..b6f162ae4ed 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -27,5 +27,6 @@ obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
 
+obj-y += smi240/
 obj-y += st_lsm6dsx/
 obj-y += st_lsm9ds0/
diff --git a/drivers/iio/imu/smi240/Kconfig b/drivers/iio/imu/smi240/Kconfig
new file mode 100644
index 00000000000..b7f3598f6c4
--- /dev/null
+++ b/drivers/iio/imu/smi240/Kconfig
@@ -0,0 +1,12 @@
+config SMI240
+	tristate "Bosch Sensor SMI240 Inertial Measurement Unit"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for SMI240 IMU on SPI with
+	  accelerometer and gyroscope.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called smi240.
diff --git a/drivers/iio/imu/smi240/Makefile b/drivers/iio/imu/smi240/Makefile
new file mode 100644
index 00000000000..0e5f7db7d78
--- /dev/null
+++ b/drivers/iio/imu/smi240/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+#
+# Makefile for Bosch SMI240
+#
+obj-$(CONFIG_SMI240) += smi240.o
+smi240-objs := smi240_core.o
+smi240-objs += smi240_spi.o
diff --git a/drivers/iio/imu/smi240/smi240.h b/drivers/iio/imu/smi240/smi240.h
new file mode 100644
index 00000000000..de79b289532
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ *
+ */
+#ifndef _SMI240_H
+#define _SMI240_H
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+struct smi240_data {
+	struct regmap *regmap;
+	u16 accel_filter_freq;
+	u16 anglvel_filter_freq;
+	u8 bite_reps;
+	u8 capture;
+	/*
+	 * Ensure natural alignment for timestamp if present.
+	 * Channel size: 2 bytes.
+	 * Max length needed: 2 * 3 channels + temp channel + 2 bytes padding + 8 byte ts.
+	 * If fewer channels are enabled, less space may be needed, as
+	 * long as the timestamp is still aligned to 8 bytes.
+	 */
+	s16 buf[12] __aligned(8);
+};
+
+int smi240_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _SMI240_H */
diff --git a/drivers/iio/imu/smi240/smi240_core.c b/drivers/iio/imu/smi240/smi240_core.c
new file mode 100644
index 00000000000..4b2a4a290f3
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240_core.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ *
+ */
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+
+#include "smi240.h"
+
+enum {
+	SMI240_TEMP_OBJECT,
+	SMI240_SCAN_ACCEL_X,
+	SMI240_SCAN_ACCEL_Y,
+	SMI240_SCAN_ACCEL_Z,
+	SMI240_SCAN_GYRO_X,
+	SMI240_SCAN_GYRO_Y,
+	SMI240_SCAN_GYRO_Z,
+	SMI240_SCAN_TIMESTAMP,
+};
+
+#define SMI240_CHIP_ID 0x0024
+
+#define SMI240_SOFT_CONFIG_EOC_MASK BIT_MASK(0)
+#define SMI240_SOFT_CONFIG_GYR_BW_MASK BIT_MASK(1)
+#define SMI240_SOFT_CONFIG_ACC_BW_MASK BIT_MASK(2)
+#define SMI240_SOFT_CONFIG_BITE_AUTO_MASK BIT_MASK(3)
+#define SMI240_SOFT_CONFIG_BITE_REP_MASK GENMASK(6, 4)
+
+#define SMI240_CHIP_ID_REG 0x00
+#define SMI240_SOFT_CONFIG_REG 0x0A
+#define SMI240_TEMP_CUR_REG 0x10
+#define SMI240_ACCEL_X_CUR_REG 0x11
+#define SMI240_GYRO_X_CUR_REG 0x14
+#define SMI240_DATA_CAP_FIRST_REG 0x17
+#define SMI240_CMD_REG 0x2F
+
+#define SMI240_SOFT_RESET_CMD 0xB6
+
+#define SMI240_BITE_SEQUENCE_DELAY_US 140000
+#define SMI240_FILTER_FLUSH_DELAY_US 60000
+#define SMI240_DIGITAL_STARTUP_DELAY_US 120000
+#define SMI240_MECH_STARTUP_DELAY_US 100000
+
+#define SMI240_LOW_BANDWIDTH_HZ 50
+#define SMI240_HIGH_BANDWIDTH_HZ 400
+
+#define SMI240_DATA_CHANNEL(_type, _axis, _index)                          \
+	{                                                                  \
+		.type = _type, .modified = 1, .channel2 = IIO_MOD_##_axis, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),              \
+		.info_mask_shared_by_type =                                \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \
+		.info_mask_shared_by_type_available =                      \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \
+		.scan_index = _index,                                      \
+		.scan_type = {                                             \
+			.sign = 's',                                       \
+			.realbits = 16,                                    \
+			.storagebits = 16,                                 \
+			.endianness = IIO_LE,                              \
+		},                                                         \
+	}
+
+#define SMI240_TEMP_CHANNEL(_index)                           \
+	{                                                     \
+		.type = IIO_TEMP, .modified = 1,              \
+		.channel2 = IIO_MOD_TEMP_OBJECT,              \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.scan_index = _index,                         \
+		.scan_type = {                                \
+			.sign = 's',                          \
+			.realbits = 16,                       \
+			.storagebits = 16,                    \
+			.endianness = IIO_LE,                 \
+		},                                            \
+	}
+
+static const struct iio_chan_spec smi240_channels[] = {
+	SMI240_TEMP_CHANNEL(SMI240_TEMP_OBJECT),
+	SMI240_DATA_CHANNEL(IIO_ACCEL, X, SMI240_SCAN_ACCEL_X),
+	SMI240_DATA_CHANNEL(IIO_ACCEL, Y, SMI240_SCAN_ACCEL_Y),
+	SMI240_DATA_CHANNEL(IIO_ACCEL, Z, SMI240_SCAN_ACCEL_Z),
+	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, X, SMI240_SCAN_GYRO_X),
+	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, Y, SMI240_SCAN_GYRO_Y),
+	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, Z, SMI240_SCAN_GYRO_Z),
+	IIO_CHAN_SOFT_TIMESTAMP(SMI240_SCAN_TIMESTAMP),
+};
+
+static const int smi240_low_pass_freqs[] = { SMI240_LOW_BANDWIDTH_HZ,
+					     SMI240_HIGH_BANDWIDTH_HZ };
+
+static int smi240_soft_reset(struct smi240_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, SMI240_CMD_REG, SMI240_SOFT_RESET_CMD);
+	if (ret)
+		return ret;
+	fsleep(SMI240_DIGITAL_STARTUP_DELAY_US);
+	return 0;
+}
+
+static int smi240_soft_config(struct smi240_data *data)
+{
+	int ret;
+	u8 acc_bw, gyr_bw;
+	u16 request;
+
+	switch (data->accel_filter_freq) {
+	case SMI240_LOW_BANDWIDTH_HZ:
+		acc_bw = 0x1;
+		break;
+	case SMI240_HIGH_BANDWIDTH_HZ:
+		acc_bw = 0x0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (data->anglvel_filter_freq) {
+	case SMI240_LOW_BANDWIDTH_HZ:
+		gyr_bw = 0x1;
+		break;
+	case SMI240_HIGH_BANDWIDTH_HZ:
+		gyr_bw = 0x0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	request = FIELD_PREP(SMI240_SOFT_CONFIG_EOC_MASK, 1);
+	request |= FIELD_PREP(SMI240_SOFT_CONFIG_GYR_BW_MASK, gyr_bw);
+	request |= FIELD_PREP(SMI240_SOFT_CONFIG_ACC_BW_MASK, acc_bw);
+	request |= FIELD_PREP(SMI240_SOFT_CONFIG_BITE_AUTO_MASK, 1);
+	request |= FIELD_PREP(SMI240_SOFT_CONFIG_BITE_REP_MASK,
+			      data->bite_reps - 1);
+
+	ret = regmap_write(data->regmap, SMI240_SOFT_CONFIG_REG, request);
+	if (ret)
+		return ret;
+
+	fsleep(SMI240_MECH_STARTUP_DELAY_US +
+	       data->bite_reps * SMI240_BITE_SEQUENCE_DELAY_US +
+	       SMI240_FILTER_FLUSH_DELAY_US);
+	return 0;
+}
+
+static int smi240_get_low_pass_filter_freq(struct smi240_data *data,
+					   int chan_type, int *val)
+{
+	switch (chan_type) {
+	case IIO_ACCEL:
+		*val = data->accel_filter_freq;
+		break;
+	case IIO_ANGL_VEL:
+		*val = data->anglvel_filter_freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smi240_get_data(struct smi240_data *data, int chan_type, int axis,
+			   int *val)
+{
+	u8 reg;
+	int ret, sample;
+
+	if (chan_type == IIO_TEMP)
+		reg = SMI240_TEMP_CUR_REG;
+	else if (chan_type == IIO_ACCEL)
+		reg = SMI240_ACCEL_X_CUR_REG + (axis - IIO_MOD_X);
+	else if (chan_type == IIO_ANGL_VEL)
+		reg = SMI240_GYRO_X_CUR_REG + (axis - IIO_MOD_X);
+	else
+		return -EINVAL;
+
+	ret = regmap_read(data->regmap, reg, &sample);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(sample, 15);
+
+	return 0;
+}
+
+static irqreturn_t smi240_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct smi240_data *data = iio_priv(indio_dev);
+	int ret, sample, chan, i = 0;
+
+	data->capture = 1;
+
+	for_each_set_bit(chan, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		ret = regmap_read(data->regmap,
+				  SMI240_DATA_CAP_FIRST_REG + chan, &sample);
+		data->capture = 0;
+		if (ret)
+			break;
+		data->buf[i++] = sample;
+	}
+
+	if (ret == 0)
+		iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
+						   pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int smi240_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, const int **vals,
+			     int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = smi240_low_pass_freqs;
+		*length = ARRAY_SIZE(smi240_low_pass_freqs);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi240_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	int ret = 0;
+	struct smi240_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+		ret = smi240_get_data(data, chan->type, chan->channel2, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = smi240_get_low_pass_filter_freq(data, chan->type, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi240_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	int ret, i;
+	struct smi240_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		for (i = 0; i < ARRAY_SIZE(smi240_low_pass_freqs); i++) {
+			if (val == smi240_low_pass_freqs[i])
+				break;
+		}
+
+		if (i == ARRAY_SIZE(smi240_low_pass_freqs))
+			return -EINVAL;
+
+		switch (chan->type) {
+		case IIO_ACCEL:
+			data->accel_filter_freq = val;
+			break;
+		case IIO_ANGL_VEL:
+			data->anglvel_filter_freq = val;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	// Write access to soft config is locked until hard/soft reset
+	ret = smi240_soft_reset(data);
+	if (ret)
+		return ret;
+	ret = smi240_soft_config(data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int smi240_init(struct smi240_data *data)
+{
+	data->accel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
+	data->anglvel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
+	data->bite_reps = 3;
+
+	return smi240_soft_config(data);
+}
+
+static IIO_CONST_ATTR_TEMP_SCALE("1/256");
+static IIO_CONST_ATTR_TEMP_OFFSET("25");
+
+static struct attribute *smi240_attrs[] = {
+	&iio_const_attr_in_temp_scale.dev_attr.attr,
+	&iio_const_attr_in_temp_offset.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group smi240_attrs_group = {
+	.attrs = smi240_attrs,
+};
+
+static const struct iio_info smi240_info = {
+	.read_avail = smi240_read_avail,
+	.read_raw = smi240_read_raw,
+	.write_raw = smi240_write_raw,
+	.attrs = &smi240_attrs_group,
+};
+
+int smi240_core_probe(struct device *dev, struct regmap *regmap)
+{
+	struct iio_dev *indio_dev;
+	struct smi240_data *data;
+	int ret, response;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Allocate iio device failed\n");
+
+	data = iio_priv(indio_dev);
+	dev_set_drvdata(dev, indio_dev);
+	data->regmap = regmap;
+	data->capture = 0;
+
+	ret = regmap_read(data->regmap, SMI240_CHIP_ID_REG, &response);
+	if (ret)
+		return dev_err_probe(dev, ret, "Read chip id failed\n");
+
+	if (response != SMI240_CHIP_ID)
+		dev_info(dev, "Unknown chip id: 0x%04x\n", response);
+
+	ret = smi240_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Device initialization failed\n");
+
+	indio_dev->channels = smi240_channels;
+	indio_dev->num_channels = ARRAY_SIZE(smi240_channels);
+	indio_dev->name = "smi240";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &smi240_info;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      smi240_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Setup triggered buffer failed\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Register IIO device failed\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(smi240_core_probe);
+
+MODULE_AUTHOR("Markus Lochmann <markus.lochmann@de.bosch.com>");
+MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
+MODULE_DESCRIPTION("Bosch SMI240 driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
new file mode 100644
index 00000000000..ac9e37ffa37
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240_spi.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ *
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+
+#include "smi240.h"
+
+#define SMI240_CRC_INIT 0x05
+#define SMI240_CRC_POLY 0x0B
+#define SMI240_BUS_ID 0x00
+
+#define SMI240_SD_BIT_MASK 0x80000000
+#define SMI240_CS_BIT_MASK 0x00000008
+
+#define SMI240_WRITE_ADDR_MASK GENMASK(29, 22)
+#define SMI240_WRITE_BIT_MASK 0x00200000
+#define SMI240_WRITE_DATA_MASK GENMASK(18, 3)
+#define SMI240_CAP_BIT_MASK 0x00100000
+#define SMI240_READ_DATA_MASK GENMASK(19, 4)
+
+static u8 smi240_crc3(u32 data, u8 init, u8 poly)
+{
+	u8 crc = init;
+	u8 do_xor;
+	s8 i = 31;
+
+	do {
+		do_xor = crc & 0x04;
+		crc <<= 1;
+		crc |= 0x01 & (data >> i);
+		if (do_xor)
+			crc ^= poly;
+
+		crc &= 0x07;
+	} while (--i >= 0);
+
+	return crc;
+}
+
+static bool smi240_sensor_data_is_valid(u32 data)
+{
+	if (smi240_crc3(data, SMI240_CRC_INIT, SMI240_CRC_POLY) != 0)
+		return false;
+
+	if (FIELD_GET(SMI240_SD_BIT_MASK, data) &
+	    FIELD_GET(SMI240_CS_BIT_MASK, data))
+		return false;
+
+	return true;
+}
+
+static int smi240_regmap_spi_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	int ret;
+	__be32 request, response;
+	struct spi_device *spi = context;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
+	struct smi240_data *data = iio_priv(indio_dev);
+
+	request = SMI240_BUS_ID << 30;
+	request |= FIELD_PREP(SMI240_CAP_BIT_MASK, data->capture);
+	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
+	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
+	request = cpu_to_be32(request);
+
+	/*
+	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
+	 * SPI protocol, where the slave interface responds to
+	 * the Master request in the next frame.
+	 * CS signal must toggle (> 700 ns) between the frames.
+	 */
+	ret = spi_write(spi, &request, sizeof(request));
+	if (ret)
+		return ret;
+
+	ret = spi_read(spi, &response, sizeof(response));
+	if (ret)
+		return ret;
+
+	response = be32_to_cpu(response);
+
+	if (!smi240_sensor_data_is_valid(response))
+		return -EIO;
+
+	response = FIELD_GET(SMI240_READ_DATA_MASK, response);
+	memcpy(val_buf, &response, val_size);
+
+	return 0;
+}
+
+static int smi240_regmap_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	__be32 request;
+	struct spi_device *spi = context;
+	u8 reg_addr = ((u8 *)data)[0];
+	u16 reg_data = ((u8 *)data)[2] << 8 | ((u8 *)data)[1];
+
+	request = SMI240_BUS_ID << 30;
+	request |= FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
+	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
+	request |= FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
+	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
+	request = cpu_to_be32(request);
+
+	return spi_write(spi, &request, sizeof(request));
+}
+
+static struct regmap_bus smi240_regmap_bus = {
+	.read = smi240_regmap_spi_read,
+	.write = smi240_regmap_spi_write,
+};
+
+static const struct regmap_config smi240_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int smi240_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+
+	u32 max_frequency = 10000000;
+
+	of_property_read_u32(spi->dev.of_node, "spi-max-frequency",
+			     &max_frequency);
+
+	spi->bits_per_word = 8;
+	spi->max_speed_hz = max_frequency;
+	spi->mode = SPI_MODE_0;
+
+	regmap = devm_regmap_init(&spi->dev, &smi240_regmap_bus, &spi->dev,
+				  &smi240_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to initialize SPI Regmap\n");
+
+	return smi240_core_probe(&spi->dev, regmap);
+}
+
+static const struct spi_device_id smi240_spi_id[] = { { "smi240", 0 }, {} };
+MODULE_DEVICE_TABLE(spi, smi240_spi_id);
+
+static const struct of_device_id smi240_of_match[] = {
+	{ .compatible = "bosch,smi240" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, smi240_of_match);
+
+static struct spi_driver smi240_spi_driver = {
+	.probe = smi240_spi_probe,
+	.id_table = smi240_spi_id,
+	.driver = {
+		.of_match_table = of_match_ptr(smi240_of_match),
+		.name = "smi240",
+	},
+};
+module_spi_driver(smi240_spi_driver);
+
+MODULE_AUTHOR("Markus Lochmann <markus.lochmann@de.bosch.com>");
+MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
+MODULE_DESCRIPTION("Bosch SMI240 SPI driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


