Return-Path: <linux-iio+bounces-7675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC756934D2E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 14:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59422838FC
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0313B5B3;
	Thu, 18 Jul 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="TuIdjYKx"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610718C36;
	Thu, 18 Jul 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305530; cv=fail; b=hXLnuvp7MSQDjlJpF+bGqce0GO6dTQMlX5U0/O712Un33Rvc58sLKvbvZ3nwlEjO1lw56DqbsTP8owl4P5oGgs/VCHo4Iq5bUciszxnd3mBVzf+yJPWWYlNQAKm3vzizRQGnGoLkLQvtwzmG1+n5Lfn+iJ3ROo5YQ1HV1Z+XyYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305530; c=relaxed/simple;
	bh=6yMoFOsYCneU46zUPdC3UcI4Oo8M+J3ztZ12wF61te8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oqERyU+p5lvbL3BgVz5xSunCgstmuHnLXMlVjFffYPpYOw1nHCUYL8l6iZvZH6xxPpYDvstAxLPgYxjPL2UwCLYTqAcwRVw/Ft1XWp1A2RAFZeuao5HWxp2u4Ravv9JPnb/0UmLTF8fY8CWyG/qwO9t78SfXjPp3shEdCosWy10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=TuIdjYKx; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaqrAMornDPJuYTHrcxqATHJwoqWax4ssdD8bWuIje36VfPsEirxMf70QrPDbWrJ8Rf4de1vfO2scDv1jxuBgPajlPD7nMv67hHBQlS3id4JcYt3PAFS+UQaj5FXZt5NYya2FWcvX5DrmIBeSOXJO0wyfKtWsI6JNE2TIdnHVn3HbY7cmMpcKTcWmsraR1OW2Yxep52B2m2EFMY966h69nRKNnTjZfnnIK4UqRANAhWoQQ693Uag6aNsJPJEnsb+NMaN0UZkDkPUVesuRsH+zi6pQzt0kXLsCKMjInUFn+3IK8qaLofnnmtt8Q9EgLj3YM/mZptOqsxFmii8zAYtyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmRbejm7BwGnh5fnHetbVA2BZEBEpa8nEwPy98DA38M=;
 b=XRxKr/3ibfmQbrUWgXnLzLnW1/jT3sadebRi1BiZUZFsWUSGYre+iONXlGgWjvO7HlQzohiai6H81yH9ZczPe/8OYUvslwkW6KdTQCcNZlo3y2f+EXO4D577Vi1orODc2wuhr22S/KwJYhleH8TCqGz+ycMlrQooj97EDiFlFPKmfKFma9M1J+8IIoBClbubOYHJbX+r10vHnzmtg1ea3hkw+zsQMeSuBgUMyroP/b2nTFVrhHWPrDG9XA91be7dAO1tORDCtTyt3LFEGpRO0bZMUpZstM6+157dL7pj1WbpVTk6YqLrDpY+p939mQPR5pA9bK5VzHhu1n9lEhxBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmRbejm7BwGnh5fnHetbVA2BZEBEpa8nEwPy98DA38M=;
 b=TuIdjYKxgQGGvI7cyyiYm+vdihRtpqO0j27GAeG64uMql7kAIKZzAPSjlSqTyegTibZ0Shv/G0oDB7IfAGDZmdp/KFqOc8JEmxgpuVm1OHjO3FPeaINbp09Ourd785mG9W6ZvZnjE24l9e7kdv0QiBTskxx/D3zzsAe8wYx6YvDb8dhdy0Fiwa+UpdhG2fNBUHZdYKyuiroGt+UEi1tvgMZIvtk8t7Z/D6HK9KdZ2k+8wm6GR9xXa12oEhEEmBzNFI9c2VMpSSaIffnbwn1+LCdgntUBUfSUXP7Gg8vkSc2e4yuGx1CzRNSmeWr7xDeLD7eTtX7msODQm7bygjTckQ==
Received: from AS9PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::14) by DU0PR10MB6701.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:403::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 12:25:19 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::2c) by AS9PR01CA0035.outlook.office365.com
 (2603:10a6:20b:542::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Thu, 18 Jul 2024 12:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 12:25:19 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Jul
 2024 14:25:09 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 14:25:08 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH] drivers: Bosch SMI240 IMU Driver
Date: Thu, 18 Jul 2024 14:24:49 +0200
Message-ID: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DU0PR10MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b0593e-89e8-4640-6c56-08dca724b007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NehTi8jZTegwUQeagNrnQq5NPf7D2TdyI4T0lqPD/n/qKdH6lBEZIYtEFl2m?=
 =?us-ascii?Q?77xZBmvVqbGyupGaIuMFhFtzttosdIxh4s97opws5V284ln7PKNbTB6qSPvq?=
 =?us-ascii?Q?T9zRm+zRIMk5PZY885i76OIpxdHAM6+TpgCkUkbDruORGeWLxY3h86a7P1xM?=
 =?us-ascii?Q?bLq3XmIPu0DLl93Oe5B6kkArhoQGZgoK6wbThUyQtOqYxCZSxi42mLy1exJk?=
 =?us-ascii?Q?8ZfayVIGwid+Qy3/ywwnGseJItfZDbd/BtSHxAWyEJ/gW6yvBfW0uRRI32Am?=
 =?us-ascii?Q?hOmiuayj7Wz2oLpBf81VMlmeBgdLiwl+TLCcAiuS0FWcExWO0jd/n1RgZk57?=
 =?us-ascii?Q?T9uavB1Jm0daUGjfEbQSHIyScfleERbkJeMG3ZpO7dPL7sZW8gk4bafS41Bs?=
 =?us-ascii?Q?EpQ/bpd1TjR6zu2VuPRxapnw26XYOxTF4Hb5nF76FDl8MNa1h6KRLiXF/tYl?=
 =?us-ascii?Q?D1eMx3Jb/9gLFb32yUGBLanfIbDe4DNO1jOooEBeDM0u49g6B1mgIuOFyGml?=
 =?us-ascii?Q?7whwJafhAHG5bDWR9bIaw9D50nQbJ+gYN0preecjl9B29BAFebRkG9LQIYGW?=
 =?us-ascii?Q?T/Qwm5u4f/2dTYcJER6mxH/CbovmlEuhbtC4lt+sYxOb8apoWkCrzP0ziW43?=
 =?us-ascii?Q?X3+ILIkpHFV2icnVTc3cEwSk8ohNGlFzynBE2PuNvfqQZ3+RrdDezv20KebX?=
 =?us-ascii?Q?cJPT4J/vzzQUu5V1gX7xG/bNpR0PwfwHPbMlhaVH+JwebJ5oO38SnagJqUQ1?=
 =?us-ascii?Q?KOlaWOMN3zj59jGDDnPB4UCHfv42FjgByGcOXxdoIKe1Pc8mkZ1JSofkspIj?=
 =?us-ascii?Q?5n7ehohCvSGAL0/nSyx+iJVz/N55aFR2MkHgVatTMlFAByGwY/mU9n4xl1Nr?=
 =?us-ascii?Q?lmJi8Sgfo6J+CKuF/wIwftO+mhiF2YTHGZnd97B3bDZ7qM3gDOlr/+z+g4i/?=
 =?us-ascii?Q?WQ/SjkytUIaP31w8Y13kaWFYN6uFXz3N3WP1blW4GeP7b35iBUp5UyEKZTHW?=
 =?us-ascii?Q?w7+LigY+s/d1AXYceRkyO+GLNbXjMMOPELzBxj+viBdao2ekFlkYG47GcJbi?=
 =?us-ascii?Q?URcgTNO+7ppELLdRWUzqaoUiMeHY3CuaGgDA33tHrWsJYpZpk3Iv64J2APUW?=
 =?us-ascii?Q?KKYb+tffnIo5AmONtbzqybiYxI0QoubY73A3TZTXFVBuuT8hzhIz5BqAg+5z?=
 =?us-ascii?Q?pINskUxonv756lUkh5rJNNiA+4HOOdgfo5yjIiBkxW1AJYkEsLj+v7a0saHn?=
 =?us-ascii?Q?Kq/cI3aVY4GfzJT857kMt3Tr21TAFpj+Ym1lOvq83ujb2UQ2+Z+RkIo9oo1w?=
 =?us-ascii?Q?ZqYeA4xr2Z2bV916I3d/Kp6hktq2yBm1xtnaWbqRdCihAYM9Lcgbj50/dgz9?=
 =?us-ascii?Q?1mj5pFjTCygoxdeisE8uKQRIhw7msHG4jJbO63Az94aAzX0kRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 12:25:19.2924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b0593e-89e8-4640-6c56-08dca724b007
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6701

From: "Shen Jianping (ME-SE/EAD2)" <she2rt@LR-C-0008DVM.rt.de.bosch.com>

Add Bosch SMI240 IMU IIO Driver to iio-for-6.10b

Signed-off-by: Shen Jianping (ME-SE/EAD2) <she2rt@LR-C-0008DVM.rt.de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi240.yaml        |  45 +
 drivers/iio/imu/Kconfig                       |   2 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi240/Kconfig                |  30 +
 drivers/iio/imu/smi240/Makefile               |   8 +
 drivers/iio/imu/smi240/smi240.h               |  31 +
 drivers/iio/imu/smi240/smi240_core.c          | 814 ++++++++++++++++++
 drivers/iio/imu/smi240/smi240_spi.c           | 153 ++++
 8 files changed, 1084 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240/Kconfig
 create mode 100644 drivers/iio/imu/smi240/Makefile
 create mode 100644 drivers/iio/imu/smi240/smi240.h
 create mode 100644 drivers/iio/imu/smi240/smi240_core.c
 create mode 100644 drivers/iio/imu/smi240/smi240_spi.c

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
new file mode 100644
index 00000000000..972819cacff
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BOSCH SMI240
+
+maintainers:
+  - unknown
+
+description: |
+  Inertial Measurement Unit with Accelerometer, Gyroscope 
+  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/
+
+properties:
+  compatible:
+    const: BOSCH,SMI240
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - spi-max-frequency
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // Example
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        smi240@0 {
+            compatible = "BOSCH,SMI240";
+            spi-max-frequency = <10000000>;
+            reg = <0>;
+        };
+    };
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 52a155ff325..2c348ad686a 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -96,6 +96,8 @@ config KMX61
 
 source "drivers/iio/imu/inv_icm42600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
+source "/home/she2rt/dev/smi240-linux-driver-iio/drivers/iio/imu/smi240/Kconfig"
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
index 00000000000..7114c941cc3
--- /dev/null
+++ b/drivers/iio/imu/smi240/Kconfig
@@ -0,0 +1,30 @@
+config SMI240
+	tristate "Bosch Sensor SMI240 Inertial Measurement Unit"
+	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Build driver
+	  for Bosch
+	  SMI240 6-axis IMU
+	  sensor.
+
+config SMI240_MAX_BUFFER_LEN
+	depends on SMI240
+	int "configue read buffer size"
+	default "1024"
+	help
+	  1024 bytes are big
+	  enough for most cases.
+	  Do not change this value
+	  if not sure.
+
+config SMI240_UNIT_TEST
+	tristate "Unit Test for SMI240"
+	depends on KUNIT=y
+	help
+	  Build Unit Test
+	  for Bosch
+	  SMI240 6-axis
+	  IMU sensor.
+
diff --git a/drivers/iio/imu/smi240/Makefile b/drivers/iio/imu/smi240/Makefile
new file mode 100644
index 00000000000..394eaecf5f3
--- /dev/null
+++ b/drivers/iio/imu/smi240/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for Bosch SMI240
+#
+
+obj-$(CONFIG_SMI240) += smi240.o
+smi240-objs := smi240_core.o
+smi240-objs += smi240_spi.o
+
diff --git a/drivers/iio/imu/smi240/smi240.h b/drivers/iio/imu/smi240/smi240.h
new file mode 100644
index 00000000000..5167b25fe44
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ *
+ */
+
+#ifndef _SMI240_H
+#define _SMI240_H
+
+#define SENSOR_NAME    "SMI240"
+#define DRIVER_VERSION "1.0.0"
+
+#define SET_BITS(reg_var, bitname, val)                                        \
+	(((reg_var) & ~(bitname##_MASK)) |                                     \
+	 (((val) << bitname##_POS) & bitname##_MASK))
+
+#define GET_BITS(reg_var, bitname)                                             \
+	(((reg_var) & (bitname##_MASK)) >> (bitname##_POS))
+
+struct smi240_device {
+	uint16_t accel_filter_freq;
+	uint16_t anglvel_filter_freq;
+	uint16_t sign_of_channels;
+	uint8_t bite_reps;
+	int8_t (*xfer)(uint32_t request, uint32_t *data);
+};
+
+int smi240_probe(struct device *dev, struct smi240_device *smi240_dev);
+int smi240_remove(struct device *dev);
+
+#endif /* _SMI240_H */
diff --git a/drivers/iio/imu/smi240/smi240_core.c b/drivers/iio/imu/smi240/smi240_core.c
new file mode 100644
index 00000000000..786cc3064ef
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240_core.c
@@ -0,0 +1,814 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/string.h>
+
+#include "smi240.h"
+
+enum {
+	SMI240_ACC_X_AND_Y_AND_Z,
+	SMI240_GYRO_X_AND_Y_AND_Z,
+	SMI240_TEMP_OBJECT,
+	SMI240_TIMESTAMP,
+};
+
+#define SMI240_CHIP_ID 0x0024
+
+#define SMI240_CRC_INIT 0x05
+#define SMI240_CRC_POLY 0x0B
+#define SMI240_BUS_ID	0x00
+
+#define SMI240_SD_BIT_MASK 0x80000000
+#define SMI240_SD_BIT_POS  31
+#define SMI240_CS_BIT_MASK 0x00000008
+#define SMI240_CS_BIT_POS  3
+
+#define SMI240_WRITE_ADDR_MASK 0x3FC00000
+#define SMI240_WRITE_ADDR_POS  22
+#define SMI240_WRITE_BIT_MASK  0x00200000
+#define SMI240_WRITE_BIT_POS   21
+#define SMI240_WRITE_DATA_MASK 0x0007FFF8
+#define SMI240_WRITE_DATA_POS  3
+#define SMI240_CAP_BIT_MASK    0x00100000
+#define SMI240_CAP_BIT_POS     20
+#define SMI240_READ_DATA_MASK  0x000FFFF0
+#define SMI240_READ_DATA_POS   4
+
+#define SMI240_GYR_BW_MASK    0x0002
+#define SMI240_GYR_BW_POS     1
+#define SMI240_ACC_BW_MASK    0x0004
+#define SMI240_ACC_BW_POS     2
+#define SMI240_BITE_AUTO_MASK 0x0008
+#define SMI240_BITE_AUTO_POS  3
+#define SMI240_BITE_REP_MASK  0x0070
+#define SMI240_BITE_REP_POS   4
+
+#define SMI240_GYR_INVERTX_MASK 0x01
+#define SMI240_GYR_INVERTX_POS	0
+#define SMI240_GYR_INVERTY_MASK 0x02
+#define SMI240_GYR_INVERTY_POS	1
+#define SMI240_GYR_INVERTZ_MASK 0x04
+#define SMI240_GYR_INVERTZ_POS	2
+#define SMI240_ACC_INVERTX_MASK 0x08
+#define SMI240_ACC_INVERTX_POS	3
+#define SMI240_ACC_INVERTY_MASK 0x10
+#define SMI240_ACC_INVERTY_POS	4
+#define SMI240_ACC_INVERTZ_MASK 0x20
+#define SMI240_ACC_INVERTZ_POS	5
+
+#define SMI240_CHIP_ID_REG	0x00
+#define SMI240_SOFT_CONFIG_REG	0x0A
+#define SMI240_SIGN_SFT_CFG_REG 0x0B
+#define SMI240_TEMP_CUR_REG	0x10
+#define SMI240_ACCEL_X_CUR_REG	0x11
+#define SMI240_ACCEL_Y_CUR_REG	0x12
+#define SMI240_ACCEL_Z_CUR_REG	0x13
+#define SMI240_GYRO_X_CUR_REG	0x14
+#define SMI240_GYRO_Y_CUR_REG	0x15
+#define SMI240_GYRO_Z_CUR_REG	0x16
+
+#define SMI240_TEMP_CAP_REG    0x17
+#define SMI240_ACCEL_X_CAP_REG 0x18
+#define SMI240_ACCEL_Y_CAP_REG 0x19
+#define SMI240_ACCEL_Z_CAP_REG 0x1A
+#define SMI240_GYRO_X_CAP_REG  0x1B
+#define SMI240_GYRO_Y_CAP_REG  0x1C
+#define SMI240_GYRO_Z_CAP_REG  0x1D
+
+#define SMI240_CMD_REG	    0x2F
+#define SMI240_BITE_CMD_REG 0x36
+
+#define SMI240_SOFT_RESET_CMD 0xB6
+#define SMI240_BITE_CMD	      0xB17E
+
+#define SMI240_BITE_SEQUENCE_DELAY   140
+#define SMI240_FILTER_FLUSH_DELAY    60
+#define SMI240_DIGITAL_STARTUP_DELAY 120
+#define SMI240_MECH_STARTUP_DELAY    100
+
+#define SMI240_MIN_BITE_REPS 1
+#define SMI240_MAX_BITE_REPS 8
+
+#define SMI240_TEMPERATURE_BASE	 25
+#define SMI240_TEMPERATURE_SHIFT 8
+
+#define SMI240_DATA_CHANNEL(_type, _axis, _index)                              \
+	{                                                                      \
+		.type = _type, .modified = 1, .channel2 = IIO_MOD_##_axis,     \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                  \
+		.info_mask_shared_by_type =                                    \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),      \
+		.info_mask_shared_by_type_available =                          \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),      \
+		.scan_index = _index,                                          \
+		.scan_type = {                                                 \
+			.sign = 's',                                           \
+			.realbits = 16,                                        \
+			.storagebits = 16,                                     \
+			.endianness = IIO_LE,                                  \
+		},                                                             \
+	}
+
+#define SMI240_TEMP_CHANNEL(_index)                                            \
+	{                                                                      \
+		.type = IIO_TEMP, .modified = 1,                               \
+		.channel2 = IIO_MOD_TEMP_OBJECT,                               \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                  \
+		.scan_index = _index,                                          \
+		.scan_type = {                                                 \
+			.sign = 's',                                           \
+			.realbits = 16,                                        \
+			.storagebits = 16,                                     \
+			.endianness = IIO_LE,                                  \
+		},                                                             \
+	}
+
+static const int smi240_low_pass_freqs[] = { 50, 400 };
+
+static const struct iio_chan_spec smi240_channels[] = {
+	SMI240_DATA_CHANNEL(IIO_ACCEL, X_AND_Y_AND_Z, SMI240_ACC_X_AND_Y_AND_Z),
+	SMI240_DATA_CHANNEL(IIO_ANGL_VEL, X_AND_Y_AND_Z,
+			    SMI240_GYRO_X_AND_Y_AND_Z),
+	SMI240_TEMP_CHANNEL(SMI240_TEMP_OBJECT),
+	IIO_CHAN_SOFT_TIMESTAMP(SMI240_TIMESTAMP),
+};
+
+static uint8_t smi240_crc3(uint32_t data, uint8_t init, uint8_t poly)
+{
+	uint8_t crc = init;
+	uint8_t do_xor;
+	int8_t i = 31;
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
+static bool smi240_sensor_data_is_valid(uint32_t data)
+{
+	if (smi240_crc3(data, SMI240_CRC_INIT, SMI240_CRC_POLY))
+		return false;
+
+	if (GET_BITS(data, SMI240_SD_BIT) & GET_BITS(data, SMI240_CS_BIT))
+		return false;
+
+	return true;
+}
+
+static int8_t smi240_get_regs(uint8_t reg_addr, uint16_t *reg_data,
+			      uint16_t len, uint8_t capture,
+			      const struct smi240_device *dev)
+{
+	int ret, i;
+	uint8_t cap;
+	uint32_t request, response;
+
+	for (i = 0; i < len; i++) {
+		cap = capture && (i == 0);
+		request = SMI240_BUS_ID << 30;
+		request = SET_BITS(request, SMI240_CAP_BIT, cap);
+		request = SET_BITS(request, SMI240_WRITE_ADDR, reg_addr + i);
+		request |=
+			smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
+
+		ret = dev->xfer(request, &response);
+
+		if (i > 0) {
+			if (!smi240_sensor_data_is_valid(response))
+				return -EIO;
+
+			reg_data[i - 1] = GET_BITS(response, SMI240_READ_DATA);
+		}
+	}
+
+	ret = dev->xfer(0x0, &response);
+	if (!smi240_sensor_data_is_valid(response))
+		return -EIO;
+
+	reg_data[i - 1] = GET_BITS(response, SMI240_READ_DATA);
+
+	return ret;
+}
+
+static int8_t smi240_set_regs(uint8_t reg_addr, uint16_t *reg_data,
+			      uint16_t len, const struct smi240_device *dev)
+{
+	int ret;
+	int i;
+	uint32_t data;
+
+	for (i = 0; i < len; i++) {
+		data = SMI240_BUS_ID << 30;
+		data = SET_BITS(data, SMI240_WRITE_BIT, 1);
+		data = SET_BITS(data, SMI240_WRITE_ADDR, reg_addr + i);
+		data = SET_BITS(data, SMI240_WRITE_DATA, reg_data[i]);
+		data |= smi240_crc3(data, SMI240_CRC_INIT, SMI240_CRC_POLY);
+		ret = dev->xfer(data, NULL);
+	}
+	return ret;
+}
+
+static void smi240_delay(uint32_t msec)
+{
+	if (msec <= 100)
+		mdelay(msec);
+	else
+		msleep(msec);
+}
+
+static int smi240_self_test(struct smi240_device *dev)
+{
+	int ret;
+	uint16_t response[7];
+	uint16_t request = SMI240_BITE_CMD;
+
+	ret = smi240_set_regs(SMI240_BITE_CMD_REG, &request, 1, dev);
+	smi240_delay(dev->bite_reps * SMI240_BITE_SEQUENCE_DELAY +
+		     SMI240_FILTER_FLUSH_DELAY);
+	if (ret) {
+		pr_err("Sending BITE command failed.");
+		return -EIO;
+	}
+
+	/* Reading from all 7 sensor data capture registers w/o error
+	 * makes sure all channels are valid.
+	 */
+	return smi240_get_regs(SMI240_TEMP_CAP_REG, response, 7, 1, dev);
+}
+
+static int smi240_soft_reset(struct smi240_device *dev)
+{
+	int ret;
+	uint16_t data = SMI240_SOFT_RESET_CMD;
+
+	ret = smi240_set_regs(SMI240_CMD_REG, &data, 1, dev);
+	smi240_delay(SMI240_DIGITAL_STARTUP_DELAY);
+	return ret;
+}
+
+static int smi240_soft_config(struct smi240_device *dev)
+{
+	int ret;
+	uint8_t acc_bw, gyr_bw;
+	uint16_t request = 0x1;
+
+	switch (dev->accel_filter_freq) {
+	case 50:
+		acc_bw = 0x1;
+		break;
+	case 400:
+		acc_bw = 0x0;
+		break;
+	default:
+		pr_err("Soft Config: invalid ACC_BW.");
+		return -EINVAL;
+	}
+
+	switch (dev->anglvel_filter_freq) {
+	case 50:
+		gyr_bw = 0x1;
+		break;
+	case 400:
+		gyr_bw = 0x0;
+		break;
+	default:
+		pr_err("Soft Config: invalid GYR_BW.");
+		return -EINVAL;
+	}
+
+	request = SET_BITS(request, SMI240_GYR_BW, gyr_bw);
+	request = SET_BITS(request, SMI240_ACC_BW, acc_bw);
+	request = SET_BITS(request, SMI240_BITE_AUTO, 1);
+	request = SET_BITS(request, SMI240_BITE_REP, dev->bite_reps - 1);
+
+	ret = smi240_set_regs(SMI240_SIGN_SFT_CFG_REG, &(dev->sign_of_channels),
+			      1, dev);
+	ret |= smi240_set_regs(SMI240_SOFT_CONFIG_REG, &request, 1, dev);
+	if (ret)
+		pr_err("Soft Config: IO error.");
+
+	smi240_delay(SMI240_MECH_STARTUP_DELAY +
+		     dev->bite_reps * SMI240_BITE_SEQUENCE_DELAY +
+		     SMI240_FILTER_FLUSH_DELAY);
+	return ret;
+}
+
+static int smi240_read_raw_multi(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, int max_len,
+				 int *vals, int *val_len, long mask)
+{
+	int ret = 0;
+	int16_t data[3];
+	struct smi240_device *dev = iio_device_get_drvdata(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel2 == IIO_MOD_X_AND_Y_AND_Z) {
+			if (chan->type == IIO_ACCEL)
+				ret = smi240_get_regs(SMI240_ACCEL_X_CAP_REG,
+						      data, 3, 1, dev);
+			else if (chan->type == IIO_ANGL_VEL)
+				ret = smi240_get_regs(SMI240_GYRO_X_CAP_REG,
+						      data, 3, 1, dev);
+			else
+				return -EINVAL;
+
+			if (ret)
+				return -EIO;
+
+			*val_len = 3;
+			vals[0] = data[0];
+			vals[1] = data[1];
+			vals[2] = data[2];
+		} else if (chan->channel2 == IIO_MOD_TEMP_OBJECT) {
+			ret = smi240_get_regs(SMI240_TEMP_CUR_REG, data, 1, 0,
+					      dev);
+
+			if (ret)
+				return -EIO;
+
+			data[0] >>= SMI240_TEMPERATURE_SHIFT;
+			data[0] += SMI240_TEMPERATURE_BASE;
+
+			*val_len = 1;
+			vals[0] = data[0];
+		} else
+			return -EINVAL;
+
+		return IIO_VAL_INT_MULTIPLE;
+
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = smi240_get_regs(SMI240_SOFT_CONFIG_REG, data, 1, 0, dev);
+		if (ret)
+			return -EIO;
+
+		switch (chan->type) {
+		case IIO_ACCEL:
+			switch (GET_BITS(data[0], SMI240_ACC_BW)) {
+			case 0:
+				dev->accel_filter_freq = 400;
+				break;
+			case 1:
+				dev->accel_filter_freq = 50;
+				break;
+			}
+
+			vals[0] = dev->accel_filter_freq;
+			break;
+		case IIO_ANGL_VEL:
+			switch (GET_BITS(data[0], SMI240_GYR_BW)) {
+			case 0:
+				dev->anglvel_filter_freq = 400;
+				break;
+			case 1:
+				dev->anglvel_filter_freq = 50;
+				break;
+			}
+
+			vals[0] = dev->anglvel_filter_freq;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*val_len = 1;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
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
+static int smi240_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	int ret, i;
+	bool valid = false;
+	struct smi240_device *dev = iio_device_get_drvdata(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		for (i = 0; i < ARRAY_SIZE(smi240_low_pass_freqs); ++i) {
+			if (val == smi240_low_pass_freqs[i]) {
+				valid = true;
+				break;
+			}
+		}
+
+		if (!valid)
+			return -EINVAL;
+
+		switch (chan->type) {
+		case IIO_ACCEL:
+			dev->accel_filter_freq = val;
+			break;
+		case IIO_ANGL_VEL:
+			dev->anglvel_filter_freq = val;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smi240_soft_reset(dev);
+	ret |= smi240_soft_config(dev);
+	if (ret)
+		ret = -EIO;
+
+	return ret;
+}
+
+static int smi240_init(struct smi240_device *dev)
+{
+	int ret;
+
+	dev->accel_filter_freq = 400;
+	dev->anglvel_filter_freq = 400;
+	dev->sign_of_channels = 0x00;
+	dev->bite_reps = 3;
+
+	ret = smi240_soft_config(dev);
+	if (ret)
+		pr_info("Soft Config failed.");
+
+	return ret;
+}
+
+static ssize_t in_temp_accel_anglvel_capture_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
+	int16_t data[7];
+
+	ret = smi240_get_regs(SMI240_TEMP_CAP_REG, data, 7, 1, smi240_dev);
+
+	data[0] >>= SMI240_TEMPERATURE_SHIFT;
+	data[0] += SMI240_TEMPERATURE_BASE;
+
+	return snprintf(buf, PAGE_SIZE, "%hd %hd %hd %hd %hd %hd %hd\n",
+			data[0], data[1], data[2], data[3], data[4], data[5],
+			data[6]);
+}
+
+static ssize_t self_test_show(struct device *dev, struct device_attribute *atrr,
+			      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
+
+	if (smi240_self_test(smi240_dev))
+		return snprintf(buf, PAGE_SIZE, "self test fail.\n");
+	else
+		return snprintf(buf, PAGE_SIZE, "self test success.\n");
+}
+
+static ssize_t soft_reset_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int ret;
+	bool success = true;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
+
+	ret = smi240_soft_reset(smi240_dev);
+	if (ret) {
+		dev_err(dev, "Soft reset failed.");
+		success = false;
+	}
+
+	ret = smi240_init(smi240_dev);
+	if (ret) {
+		dev_err(dev, "Device initialization failed.");
+		success = false;
+	}
+
+	if (!success)
+		return snprintf(buf, PAGE_SIZE, "soft reset failed.\n");
+	else
+		return snprintf(buf, PAGE_SIZE, "soft reset performed.\n");
+}
+
+static ssize_t sign_of_channels_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int ret;
+	uint16_t data;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
+
+	ret = smi240_get_regs(SMI240_SIGN_SFT_CFG_REG, &data, 1, 0, smi240_dev);
+	if (ret)
+		return -EIO;
+
+	smi240_dev->sign_of_channels = data;
+
+	return snprintf(
+		buf, PAGE_SIZE, "ax:%d,ay:%d,az:%d,gx:%d,gy:%d,gz:%d\n",
+		GET_BITS(smi240_dev->sign_of_channels, SMI240_ACC_INVERTX),
+		GET_BITS(smi240_dev->sign_of_channels, SMI240_ACC_INVERTY),
+		GET_BITS(smi240_dev->sign_of_channels, SMI240_ACC_INVERTZ),
+		GET_BITS(smi240_dev->sign_of_channels, SMI240_GYR_INVERTX),
+		GET_BITS(smi240_dev->sign_of_channels, SMI240_GYR_INVERTY),
+		GET_BITS(smi240_dev->sign_of_channels, SMI240_GYR_INVERTZ));
+}
+
+static uint16_t calculate_sign_of_channels(const char *buf,
+					   const uint16_t register_val,
+					   size_t count)
+{
+	uint16_t sign_of_channels = register_val;
+	char *sep = ",";
+	char *config;
+	char data[32];
+
+	char *input = data;
+	char *sep2 = ":";
+	char *value;
+	char *channel;
+
+	if (count <= 30) {
+		memset(data, 0, sizeof(data));
+		memcpy(data, buf, count);
+
+		if (data[strlen(data) - 1] == '\n')
+			data[strlen(data) - 1] = '\0';
+
+		config = strsep(&input, sep);
+		while (config != NULL) {
+			channel = strsep(&config, sep2);
+			if (channel != NULL && strcmp(channel, "ax") == 0) {
+				value = strsep(&config, sep2);
+				if (value != NULL && strcmp(value, "0") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_ACC_INVERTX, 0);
+				}
+				if (value != NULL && strcmp(value, "1") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_ACC_INVERTX, 1);
+				}
+			}
+			if (channel != NULL && strcmp(channel, "ay") == 0) {
+				value = strsep(&config, sep2);
+				if (value != NULL && strcmp(value, "0") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_ACC_INVERTY, 0);
+				}
+				if (value != NULL && strcmp(value, "1") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_ACC_INVERTY, 1);
+				}
+			}
+			if (channel != NULL && strcmp(channel, "az") == 0) {
+				value = strsep(&config, sep2);
+				if (value != NULL && strcmp(value, "0") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_ACC_INVERTZ, 0);
+				}
+				if (value != NULL && strcmp(value, "1") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_ACC_INVERTZ, 1);
+				}
+			}
+			if (channel != NULL && strcmp(channel, "gx") == 0) {
+				value = strsep(&config, sep2);
+				if (value != NULL && strcmp(value, "0") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_GYR_INVERTX, 0);
+				}
+				if (value != NULL && strcmp(value, "1") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_GYR_INVERTX, 1);
+				}
+			}
+			if (channel != NULL && strcmp(channel, "gy") == 0) {
+				value = strsep(&config, sep2);
+				if (value != NULL && strcmp(value, "0") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_GYR_INVERTY, 0);
+				}
+				if (value != NULL && strcmp(value, "1") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_GYR_INVERTY, 1);
+				}
+			}
+			if (channel != NULL && strcmp(channel, "gz") == 0) {
+				value = strsep(&config, sep2);
+				if (value != NULL && strcmp(value, "0") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_GYR_INVERTZ, 0);
+				}
+				if (value != NULL && strcmp(value, "1") == 0) {
+					sign_of_channels =
+						SET_BITS(sign_of_channels,
+							 SMI240_GYR_INVERTZ, 1);
+				}
+			}
+			config = strsep(&input, sep);
+		}
+	}
+	return sign_of_channels;
+}
+
+static ssize_t sign_of_channels_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
+
+	if (count > 30)
+		return -EINVAL;
+
+	smi240_dev->sign_of_channels = calculate_sign_of_channels(
+		buf, smi240_dev->sign_of_channels, count);
+
+	ret = smi240_soft_reset(smi240_dev);
+	if (ret) {
+		pr_err("Soft Reset failed.");
+		return -EIO;
+	}
+
+	ret = smi240_soft_config(smi240_dev);
+	if (ret) {
+		pr_err("Soft Config failed.");
+		return -EIO;
+	}
+
+	return count;
+}
+
+static ssize_t bite_repetitions_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int ret;
+	uint16_t data;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
+
+	ret = smi240_get_regs(SMI240_SOFT_CONFIG_REG, &data, 1, 0, smi240_dev);
+	if (ret)
+		return -EIO;
+
+	smi240_dev->bite_reps = GET_BITS(data, SMI240_BITE_REP) + 1;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", smi240_dev->bite_reps);
+}
+
+static ssize_t bite_repetitions_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	int ret;
+	uint8_t bite_reps;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi240_device *smi240_dev = iio_device_get_drvdata(indio_dev);
+
+	ret = kstrtou8(buf, 10, &bite_reps);
+	if (ret || bite_reps < SMI240_MIN_BITE_REPS ||
+	    bite_reps > SMI240_MAX_BITE_REPS)
+		return -EINVAL;
+
+	smi240_dev->bite_reps = bite_reps;
+
+	ret = smi240_soft_reset(smi240_dev);
+	ret |= smi240_soft_config(smi240_dev);
+	if (ret)
+		return -EIO;
+
+	return count;
+}
+
+static IIO_DEVICE_ATTR_RO(in_temp_accel_anglvel_capture, 0);
+static IIO_DEVICE_ATTR_RO(self_test, 0);
+static IIO_DEVICE_ATTR_RO(soft_reset, 0);
+static IIO_DEVICE_ATTR_RW(sign_of_channels, 0);
+static IIO_DEVICE_ATTR_RW(bite_repetitions, 0);
+
+static struct attribute *smi240_attrs[] = {
+	&iio_dev_attr_in_temp_accel_anglvel_capture.dev_attr.attr,
+	&iio_dev_attr_self_test.dev_attr.attr,
+	&iio_dev_attr_soft_reset.dev_attr.attr,
+	&iio_dev_attr_sign_of_channels.dev_attr.attr,
+	&iio_dev_attr_bite_repetitions.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group smi240_attrs_group = {
+	.attrs = smi240_attrs,
+};
+
+static const struct iio_info smi240_info = {
+	.read_raw_multi = smi240_read_raw_multi,
+	.read_avail = smi240_read_avail,
+	.write_raw = smi240_write_raw,
+	.attrs = &smi240_attrs_group,
+};
+
+int smi240_probe(struct device *dev, struct smi240_device *smi240_dev)
+{
+	int ret;
+	int16_t response;
+	struct iio_dev *indio_dev;
+
+	ret = smi240_get_regs(SMI240_CHIP_ID_REG, &response, 1, 0, smi240_dev);
+	if (ret) {
+		pr_err("Read chip id failed.");
+		return ret;
+	}
+
+	if (response == SMI240_CHIP_ID) {
+		pr_info("SMI240 Chip ID: 0x%04x", response);
+	} else {
+		pr_err("Unexpected Chip ID for SMI240: 0x%04x", response);
+		return -ENODEV;
+	}
+
+	ret = smi240_soft_reset(smi240_dev);
+	if (ret) {
+		pr_err("Soft Reset failed.");
+		return ret;
+	}
+
+	ret = smi240_init(smi240_dev);
+	if (ret)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(dev, 0);
+	if (!indio_dev)
+		return -ENOMEM;
+
+	iio_device_set_drvdata(indio_dev, smi240_dev);
+	dev_set_drvdata(dev, indio_dev);
+
+	indio_dev->dev.parent = dev;
+	indio_dev->channels = smi240_channels;
+	indio_dev->num_channels = ARRAY_SIZE(smi240_channels);
+	indio_dev->name = SENSOR_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &smi240_info;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "Register IIO device failed");
+		goto exit_failure;
+	}
+
+	return ret;
+
+exit_failure:
+	smi240_remove(dev);
+	return ret;
+}
+
+int smi240_remove(struct device *dev)
+{
+	dev_info(dev, "unregister SMI240");
+	return 0;
+}
diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
new file mode 100644
index 00000000000..2be6320eaba
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240_spi.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <generated/uapi/linux/version.h>
+
+#include "smi240.h"
+
+#define SMI240_SPI_MAX_BUFFER_SIZE 32
+
+static uint8_t *rx_buf;
+static uint8_t *tx_buf;
+static struct spi_device *smi240_spi_dev;
+static struct smi240_device smi240_dev;
+
+static int8_t smi240_spi_transfer(uint32_t request, uint32_t *response)
+{
+	int8_t ret;
+	struct spi_message msg;
+	struct spi_transfer xfer = {
+		.tx_buf = tx_buf, .rx_buf = rx_buf, .len = 4,
+		//.bits_per_word = 32,
+	};
+
+	if (smi240_spi_dev == NULL)
+		return -ENODEV;
+
+	tx_buf[0] = request >> 24;
+	tx_buf[1] = request >> 16;
+	tx_buf[2] = request >> 8;
+	tx_buf[3] = request;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(smi240_spi_dev, &msg);
+
+	if (ret)
+		return ret;
+
+	if (response != NULL)
+		*response = (rx_buf[0] << 24) | (rx_buf[1] << 16) |
+			    (rx_buf[2] << 8) | rx_buf[3];
+
+	return ret;
+}
+
+static int smi240_spi_probe(struct spi_device *device)
+{
+	int err;
+
+	device->bits_per_word = 8;
+	device->max_speed_hz = 10000000;
+	device->mode = SPI_MODE_0;
+
+	err = spi_setup(device);
+	if (err < 0) {
+		pr_err("spi_setup err!\n");
+		return err;
+	}
+
+	if (rx_buf == NULL)
+		rx_buf = kmalloc(4, GFP_KERNEL);
+	if (!rx_buf)
+		return -ENOMEM;
+
+	if (tx_buf == NULL)
+		tx_buf = kmalloc(4, GFP_KERNEL);
+	if (!tx_buf)
+		return -ENOMEM;
+
+	smi240_spi_dev = device;
+
+	err = smi240_probe(&device->dev, &smi240_dev);
+	if (err) {
+		kfree(rx_buf);
+		rx_buf = NULL;
+		kfree(tx_buf);
+		tx_buf = NULL;
+		smi240_spi_dev = NULL;
+		dev_err(&device->dev,
+			"Bosch Sensor Device %s initialization failed %d",
+			SENSOR_NAME, err);
+	} else
+		dev_info(&device->dev, "Bosch Sensor Device %s initialized",
+			 SENSOR_NAME);
+
+	return err;
+}
+
+static void smi240_spi_remove(struct spi_device *device)
+{
+	if (rx_buf != NULL) {
+		kfree(rx_buf);
+		rx_buf = NULL;
+	}
+
+	if (tx_buf != NULL) {
+		kfree(tx_buf);
+		tx_buf = NULL;
+	}
+	smi240_remove(&device->dev);
+}
+
+static const struct spi_device_id smi240_id[] = { { SENSOR_NAME, 0 }, {} };
+
+MODULE_DEVICE_TABLE(spi, smi240_id);
+
+static const struct of_device_id smi240_of_match[] = {
+	{
+		.compatible = SENSOR_NAME,
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, smi240_of_match);
+
+static struct spi_driver smi240_driver = {
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = SENSOR_NAME,
+		   .of_match_table = smi240_of_match,
+		    },
+	.id_table = smi240_id,
+	.probe = smi240_spi_probe,
+	.remove = smi240_spi_remove,
+};
+
+static int __init smi240_module_init(void)
+{
+	int err = 0;
+
+	smi240_dev.xfer = smi240_spi_transfer;
+
+	err |= spi_register_driver(&smi240_driver);
+	return err;
+}
+
+static void __exit smi240_module_exit(void)
+{
+	spi_unregister_driver(&smi240_driver);
+}
+
+module_init(smi240_module_init);
+module_exit(smi240_module_exit);
+
+MODULE_DESCRIPTION("SMI240 IMU SENSOR DRIVER");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION(DRIVER_VERSION);
-- 
2.34.1


