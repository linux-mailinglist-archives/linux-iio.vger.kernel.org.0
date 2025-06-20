Return-Path: <linux-iio+bounces-20792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B070AE12B1
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 06:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC883BE29F
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 04:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5053201000;
	Fri, 20 Jun 2025 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="Ds1DPiIX"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012015.outbound.protection.outlook.com [52.101.71.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260401FCFE2;
	Fri, 20 Jun 2025 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395388; cv=fail; b=JV7wZ3yfFNLgnRDWdcHhzLcGJooU5Z9mIaVIQ/QrzfUu6jrQ9fzNvcMKSuYzQuDRDqXlRJGzhhgohano8ElUjkV+Sn24SHM2/1/JCoHDkx17Hc1/u1fG2p+pCBsj84NHIXQPICR1EUsf9a9pquZjcfxL0f3ptSaWajx5UzybGCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395388; c=relaxed/simple;
	bh=0u0uuQoPDj/V3ScCyT/Q+5SODCh/sgGAPpvyC7WBGho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmf4a1+CekKcTL5ew2tmF5sYpxhFJtOJmIbqqQmI7xgOt2uBuJZY6EaVSvQyUyBkzQQFcG2dSDCfgo+/HimUvqS6hIcSbaFOWnKDXIsQOimwPw0vluXskFs02GC92ILqjC8BcBLI/yMHTIPsXMHCAq8RDS/lCIfcsSXm4MwNfxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com; spf=pass smtp.mailfrom=in.bosch.com; dkim=pass (2048-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b=Ds1DPiIX; arc=fail smtp.client-ip=52.101.71.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=in.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQiEjJfwyPyb7HYXFUZgDHtxUnLdF26jgrX8KYBJsYHmVhC0T8yDuV1Sul1jBTi7lTyBZ6kBjpDMTiF+6MfXgkjgmi+aoBgNlIwIr7WqP3kU2HbRq3Ih8pJo6mJv36NPOg0e7m+DNCOwf/FGWjAFs1O+Qul86ykz4koysWjZNfvO+78YyG8vSDc0dzIM4Uco0Jji2qaypLY9VsuHoDkrJqtaQpLUFRfwDOhTypy4Nn96xCNg8KlSdygPrxKWEcW+ha9J3dBnRRdMsr5ZBd5J5oEZrE8JjjYfz8/O/GOe70KSitD6taXdm+Mj0gxmeSSwAuHZPw7NK6xZLK9LW/Mx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzmHCWjDp3o9atEH8qIsG1v3OHa4L2Kcj3RREZdqBY4=;
 b=Nug9AKJzmTMkWeJNcHpvx6SBYqOGrEvG/D+tgzSkvkSLw7lehGAcuBB9voadXQ/mpiIK8DsJBHRsAT/3Hx93DZiEt0aFqmIAYI0XrdCzN/62Rug3M1NXDHSgrU38t/weFAr0okZPwW6uofOtK68oBx9T70cfqJI0fAXf4B+gFdlZzWmV1eZ9LqwT4PiHXPwpHYjMcc+8fv0DQmexHgd0ybAHRZIb1MnU7nSGEb3Dr/WCoqtaI/KAqe/EK9VzYUWKYjjAGKJbAF8yPsFywJPVWPBhFG1cL1iJ657LfY7NfWeRqCHSR0jAnkd4zBsr59Q3vpSZBEYGumxMHAVfASwGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzmHCWjDp3o9atEH8qIsG1v3OHa4L2Kcj3RREZdqBY4=;
 b=Ds1DPiIXg8GDaz+FNchDavNFw6hoQWItxLufARvPohspLGGHhruZ2kmXWaxOC65vcxv6mGK5jnhoN3pFOOwPQtcvhbH1IcJ5gf5PsV8GxP0JqQKgs22whzQnI8wvmVGD1Ft7/0ViHX1OcNkIpCpCiRYqMaXs+9GzZguoSNQqnZYC6b1U9KD1oD0LcL1tRa1jEvzP9ItQu1NEE6Gxidq9P1i5dOVUFGz2O4VS8drMwhplh16VQjiPZLdXYQTJrqNzW48pQkQ6jfs7O9ysWVfTKv+LFY9anpxMmU5e9Kan8uOblLEoPL9yZ0sC/pcQwZllGUETs+/4F6ZGslmiufD+Rg==
Received: from DU2PR04CA0246.eurprd04.prod.outlook.com (2603:10a6:10:28e::11)
 by GVXPR10MB8341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 04:56:11 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::9d) by DU2PR04CA0246.outlook.office365.com
 (2603:10a6:10:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.36 via Frontend Transport; Fri,
 20 Jun 2025 04:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 04:56:11 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Fri, 20 Jun
 2025 06:55:59 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Fri, 20 Jun 2025 06:55:59 +0200
Received: from COB-C-005HH.cob.apac.bosch.com (10.169.242.187) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 20 Jun 2025 06:55:57 +0200
From: <liquancin.mereenamathai@in.bosch.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<vassilisamir@gmail.com>, <marcelo.schmitt1@gmail.com>,
	<javier.carrasco.cruz@gmail.com>, <Xu.Zhang@cn.bosch.com>,
	<Maoting.Bian@cn.bosch.com>, <Liquancin.MereenaMathai@in.bosch.com>,
	Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
Subject: [PATCH v1 1/2] Add the iio driver for bosch pressure sensor bmp390. The bmp390 is a pressure sensor module. It will support SPI and I2C protocol based on configuration.
Date: Fri, 20 Jun 2025 10:24:54 +0530
Message-ID: <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|GVXPR10MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2f41fb-ade7-494f-1037-08ddafb6c6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JPvqIO8E2zOAxZgh7m8VEngqvkrnlYeOXABMfxouwj/kU8goI6vKMlSjXllB?=
 =?us-ascii?Q?kQtEjb0fO0M3T5DYjO8RX16t3ABuS/E2QjhmQxeI51OGBXOQua8mCrTKHmS1?=
 =?us-ascii?Q?2MNj+meyvoh9GrHN/a+HvEEZ4DvcTtR/jIk5Nl1riFK6OkQGP8FoonQouS9a?=
 =?us-ascii?Q?rIH7IOSQK53aOuHgp6Wr9cgHo1xvdv71oGRQm4IXqoEoV5+8eSpBVvGUzIrZ?=
 =?us-ascii?Q?8KbcYCYcUWUEG/5XmFPLCKPPEnM2+RypsHzFekxDwD04eiynahagH6PvnSa+?=
 =?us-ascii?Q?PjxsCO5nsUVXXmsYnWu7cBHuCf8e/pAYsheUuG/HkGNSJ+U88uw8s5Ezbg9p?=
 =?us-ascii?Q?EtdK+DHyc7GuphKMNgmmpSLbk4k4BLzGJHabXj3UiNtDccQARA5gDpuD4lyJ?=
 =?us-ascii?Q?wcIpyXB1cef/wc+Tp6K09M5UlO9vh4lXsDJd/JgHhxGLtfQKXZxdQ8Jh6ZN3?=
 =?us-ascii?Q?oDL8SjH+V445FMSpVgKCtS5Jq9OdUUV5LV1hZ3PQsbLuG1kRJa63702REmHX?=
 =?us-ascii?Q?k8bqq30C8IfseymGsgBPTWkG+KuYUx8TT5IgGqBPx+cUIAxrwHn/unpo3kE7?=
 =?us-ascii?Q?6hqa9ASHA//PgjXQKax/isKIj6FxOkTrjLzdUpeiy6ViZR1HUR4xGTUpp5AK?=
 =?us-ascii?Q?FMYts+PhWX19KjGBpYS/Ja0vUPdxSRVNHnqXzSt4lvMEybC6hAh/BeC37CaG?=
 =?us-ascii?Q?rj3u4E0rWK2JE0IjJMBYMxobzurkSDyhBA9TQeC1P8k/V+wHJDHidg+pRvrf?=
 =?us-ascii?Q?5HFDGMeYUBt/08yVK5s4VhBjjwLn4e+dhFR4wSYB+7n9tpx0/LPQI0iFbO2c?=
 =?us-ascii?Q?v8SijEIMQPo6WivfALYSsflJJGxt6qUFTNaK3Gx5Ch24G6lg/tCDLPaLaO3X?=
 =?us-ascii?Q?oUbNnYb5PKADZnNVTJBueHNNE96ClihWUqnVRckHEW2/bhVT96uKZdvcQVvn?=
 =?us-ascii?Q?KpQaZRgu6LPT06rYtgcLVZWHMVR7QxBI0CpJfoMvn0dB0g2+MruxkUvqoFL7?=
 =?us-ascii?Q?XKphQ0pyr3BslO+u6X7ygOdl+lfiW+OexKm3Dy883PumJtNSrxFM1iCQW11g?=
 =?us-ascii?Q?kXDQwwVlOmqB+UySC56nIu1X6whgY7uxNolUo/1h3nwzkwtvu1UBs2RhLUjI?=
 =?us-ascii?Q?8XDtVYBQ3lNYlvawOa41uoJ6JoxoyngCak6LGkRrDiHpCz9VEeCXlGQGMLJn?=
 =?us-ascii?Q?oQrQ5aa+dMluJruzPrSzXeTN0JbaRZ74PUjC91bS9QYZfG48C079ASlazph2?=
 =?us-ascii?Q?AmYo3zNPcr6v9aFnvFqPAb1KPnFxV90ipU49grcfla7uWfoPbf8kRTvh7GRE?=
 =?us-ascii?Q?Jpd15C0yA5jEefFxTttBLyy/PJcy5T0PgHovzD3zox8j4pnbfM3CjoqNe0BB?=
 =?us-ascii?Q?NZQnU5rhrOSJ9AkHV8Ze5XJqiurf2s+Y41BhJak0KmGamkBPJjjom49nqtP+?=
 =?us-ascii?Q?wQ2OD0svjadwFwd8zIUZwR35XBcIjYiLIsghAEy2cyASD8qdgSYOmjeOF4Su?=
 =?us-ascii?Q?RKdjvFGx6CJRs11LYqNMy+ZUuiWz/xK6F9Yf6qgxroEC/paLNfLN/NRbMg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 04:56:11.1563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2f41fb-ade7-494f-1037-08ddafb6c6ea
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8341

From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>

Implemented features:
* raw data access for pressure and temp through sysfs
* iio buffer tool support for continuous sampling

Signed-off-by: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
---
 MAINTAINERS                                   |    7 +
 drivers/iio/pressure/Kconfig                  |   26 +
 drivers/iio/pressure/Makefile                 |    1 +
 drivers/iio/pressure/bmp390/Kconfig           |   29 +
 drivers/iio/pressure/bmp390/Makefile          |   32 +
 drivers/iio/pressure/bmp390/bmp3.c            | 2781 +++++++++++++++++
 drivers/iio/pressure/bmp390/bmp3.h            |  537 ++++
 drivers/iio/pressure/bmp390/bmp390_driver.c   | 1604 ++++++++++
 drivers/iio/pressure/bmp390/bmp390_driver.h   |  232 ++
 drivers/iio/pressure/bmp390/bmp390_i2c.c      |  328 ++
 .../iio/pressure/bmp390/bmp390_iio_buffer.c   |  220 ++
 drivers/iio/pressure/bmp390/bmp390_spi.c      |  286 ++
 drivers/iio/pressure/bmp390/bmp3_defs.h       |  871 ++++++
 drivers/iio/pressure/bmp390/bmp3_selftest.c   |  184 ++
 drivers/iio/pressure/bmp390/bmp3_selftest.h   |   93 +
 15 files changed, 7231 insertions(+)
 create mode 100644 drivers/iio/pressure/bmp390/Kconfig
 create mode 100644 drivers/iio/pressure/bmp390/Makefile
 create mode 100644 drivers/iio/pressure/bmp390/bmp3.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp3.h
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.h
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_i2c.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp390_spi.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp3_defs.h
 create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.c
 create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1abec3f7d42b..f962f64d9a9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27447,6 +27447,13 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/pci/hda/patch_senarytech.c
 
+BOSCH SENSORTEC BMP390 PRESSURE IIO DRIVER
+M:	Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml
+F:	drivers/iio/pressure/bmp390/*
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index d2cb8c871f6a..ffa5a1c76e06 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -6,6 +6,32 @@
 
 menu "Pressure sensors"
 
+menu "Bosch BMP390 pressure sensor driver"
+config BMP390_IIO
+    tristate "Bosch BMP390 pressure sensor driver"
+    depends on IIO
+    help
+      Say yes here to build support for the Bosch BMP390 pressure sensor.
+
+
+      The Bosch BMP390 is a high-precision, low-power digital pressure sensor
+      designed for a wide range of applications, including weather monitoring,
+      altitude tracking, and indoor navigation. This driver provides support
+      for interfacing with the BMP390 sensor through the Industrial I/O (IIO)
+      subsystem.
+
+      If you choose to compile this driver as a module, it will be named
+      'bmp390'. This allows the driver to be dynamically loaded and unloaded
+      as needed, providing flexibility in managing the sensor.
+
+      To compile this driver as a module, choose M here: the module will be
+      called bmp390. If you are unsure, it is safe to say 'N' here.
+
+if BMP390_IIO
+    source "drivers/iio/pressure/bmp390/Kconfig"
+endif # BMP390_IIO
+endmenu
+
 config ABP060MG
 	tristate "Honeywell ABP pressure sensor driver"
 	depends on I2C
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 6482288e07ee..09b007419f2f 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
 
 obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
 obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
+obj-$(CONFIG_BMP390_IIO) += bmp390/
diff --git a/drivers/iio/pressure/bmp390/Kconfig b/drivers/iio/pressure/bmp390/Kconfig
new file mode 100644
index 000000000000..657e9506ff15
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/Kconfig
@@ -0,0 +1,29 @@
+#
+# Kconfig for Bosch BMP390 sensors driver.
+#
+config BMP3_SUPPORT_DYNAMIC_KO_MODULE
+    bool "BMP390 driver build dynamic .ko module"
+    depends on I2C && SYSFS
+    help
+      Enable this option to build the Bosch Sensortec BMP390 sensor driver as a dynamic kernel module (.ko).
+      This allows the driver to be loaded and unloaded dynamically at runtime, providing flexibility in managing
+      the driver without requiring a reboot. This is particularly useful for development, testing, and systems
+      that need to manage kernel modules dynamically.
+
+      This option depends on I2C and SYSFS support being enabled in the kernel configuration. If you are unsure,
+      it is safe to say 'N' here.
+
+      Say 'Y' here if you want to support dynamic loading and unloading of the BMP390 sensor driver.
+
+config BMP3_SUPPORT_SPI_BUS
+    bool "BMP390 driver build for SPI interface"
+    depends on SPI_MASTER && SYSFS
+    help
+      Enable this option to build the Bosch Sensortec BMP390 sensor driver with support for the SPI interface.
+      This allows the BMP390 sensor to communicate with the host system using the SPI bus, which can provide
+      faster data transfer rates compared to I2C.
+
+      This option depends on SPI_MASTER and SYSFS support being enabled in the kernel configuration. If you are unsure,
+      it is safe to say 'N' here.
+
+      Say 'Y' here if you want to enable SPI interface support for the BMP390 sensor driver.
diff --git a/drivers/iio/pressure/bmp390/Makefile b/drivers/iio/pressure/bmp390/Makefile
new file mode 100644
index 000000000000..ec6e1ed06b79
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/Makefile
@@ -0,0 +1,32 @@
+
+#
+# Makefile for Bosch BMP390 sensor driver.
+#
+# Define CHECK flag to enable additional checks in the driver code
+ccflags-y += -DCHECK=1
+# Conditional block to handle SPI bus support
+ifeq ($(CONFIG_BMP3_SUPPORT_SPI_BUS), y)
+	ccflags-y += -DBMP3_SUPPORT_SPI_BUS
+# Conditional block for dynamic kernel module support
+	ifeq ($(CONFIG_BMP3_SUPPORT_DYNAMIC_KO_MODULE), y)
+		SRCS   = bmp390_spi.c bmp3.c bmp390_driver.c bmp3_selftest.c bmp390_iio_buffer.c
+		OBJS   = $(SRCS:.c=.o)
+		obj-m += bmp390_spi_driver.o
+
+		bmp390_spi_driver-objs := bmp390_spi.o bmp3.o bmp390_driver.o bmp3_selftest.o bmp390_iio_buffer.o
+	else
+		obj-y 	+= bmp390_spi.o bmp3.o bmp390_driver.o bmp3_selftest.o bmp390_iio_buffer.o
+	endif
+# Conditional block for I2C bus support
+else
+# Conditional block for dynamic kernel module support
+	ifeq ($(CONFIG_BMP3_SUPPORT_DYNAMIC_KO_MODULE), y)
+		SRCS   = bmp390_i2c.c bmp3.c bmp390_driver.c bmp3_selftest.c bmp390_iio_buffer.c
+		OBJS   = $(SRCS:.c=.o)
+		obj-m += bmp390_i2c_driver.o
+
+		bmp390_i2c_driver-objs := bmp390_i2c.o bmp3.o bmp390_driver.o bmp3_selftest.o bmp390_iio_buffer.o
+	else
+		obj-y 	+= bmp390_i2c.o bmp3.o bmp390_driver.o bmp3_selftest.o bmp390_iio_buffer.o
+	endif
+endif
diff --git a/drivers/iio/pressure/bmp390/bmp3.c b/drivers/iio/pressure/bmp390/bmp3.c
new file mode 100644
index 000000000000..8448c5c65a9c
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp3.c
@@ -0,0 +1,2781 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp3.c
+ * @date		2024-12-04
+ * @version		v2.1.0
+ *
+ * @brief		   Sensor driver for BMP3 sensor
+ *
+ */
+
+#include "bmp3.h"
+/***************** Static function declarations ******************************/
+/*!
+ * @brief This internal API reads the calibration data from the sensor, parse
+ * it then compensates it and store in the device structure.
+ *
+ * @param[in] dev : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 get_calib_data(struct bmp3_dev *dev);
+/*!
+ * @brief This internal API is used to parse the calibration data, compensates
+ * it and store it in device structure.
+ *
+ * @param[in] dev : Structure instance of bmp3_dev.
+ * @param[out] reg_data : Contains calibration data to be parsed.
+ *
+ */
+static void parse_calib_data(const u8 *reg_data, struct bmp3_dev *dev);
+/*!
+ * @brief This internal API gets the over sampling, ODR and filter settings
+ * from the sensor.
+ *
+ * @param[in] settings  : Structure instance of bmp3_settings.
+ * @param[in] dev       : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 get_odr_filter_settings(struct bmp3_settings *settings,
+				  struct bmp3_dev *dev);
+/*!
+ * @brief This internal API is used to parse the pressure and temperature data
+ * and store it in the bmp3_uncomp_data structure instance.
+ *
+ * @param[in] reg_data : Contains the register data which needs to be parsed.
+ * @param[out] uncomp_data : Contains the uncompensated press and temp data.
+ *
+ */
+static void parse_sensor_data(const u8 *reg_data,
+			      struct bmp3_uncomp_data *uncomp_data);
+/*!
+ * @brief This internal API is used to compensate the pressure or temperature
+ * or both the data according to the component selected by the user.
+ *
+ * @param[in] sensor_comp : Used to select pressure or temperature.
+ * @param[in] uncomp_data : Contains the uncompensated pressure and
+ * temperature data.
+ * @param[out] comp_data : Contains the compensated pressure and
+ * temperature data.
+ * @param[in] calib_data : Pointer to the calibration data structure.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 compensate_data(u8 sensor_comp,
+			  const struct bmp3_uncomp_data *uncomp_data,
+			  struct bmp3_data *comp_data,
+			  struct bmp3_calib_data *calib_data);
+
+#ifdef BMP3_FLOAT_COMPENSATION
+
+/*!
+ * @brief This internal API is used to compensate the raw temperature data and
+ * return the compensated temperature data.
+ *
+ * @param[out] temperature      : Compensated temperature data in double.
+ * @param[in] uncomp_data       : Contains the uncompensated temperature data.
+ * @param[in] calib_data        : Pointer to calibration data structure.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ *
+ */
+static s8 compensate_temperature(double *temperature,
+				 const struct bmp3_uncomp_data *uncomp_data,
+				 struct bmp3_calib_data *calib_data);
+/*!
+ * @brief This internal API is used to compensate the pressure data and return
+ * the compensated pressure data.
+ *
+ * @param[out] comp_pressure : Compensated pressure data in double.
+ * @param[in] uncomp_data : Contains the uncompensated pressure data.
+ * @param[in] calib_data : Pointer to the calibration data structure.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 compensate_pressure(double *pressure,
+			      const struct bmp3_uncomp_data *uncomp_data,
+			      const struct bmp3_calib_data *calib_data);
+/*!
+ * @brief This internal API is used to calculate the power functionality for
+ * double precision floating point values.
+ *
+ * @param[in] base : Contains the base value.
+ * @param[in] power : Contains the power value.
+ *
+ * @return Output of power function.
+ * @retval Calculated power function output in float.
+ */
+static float pow_bmp3(double base, u8 power);
+
+#else
+
+/*!
+ * @brief This internal API is used to compensate the raw temperature data and
+ * return the compensated temperature data in integer data type.
+ *
+ * @param[out] temperature      : Compensated temperature data in integer.
+ * @param[in] uncomp_data       : Contains the uncompensated temperature data.
+ * @param[in] calib_data        : Pointer to calibration data structure.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 compensate_temperature(s64 *,
+				 const struct bmp3_uncomp_data *uncomp_data,
+				 struct bmp3_calib_data *calib_data);
+/*!
+ * @brief This internal API is used to compensate the pressure data and return
+ * the compensated pressure data in integer data type.
+ *
+ * @param[out] comp_pressure : Compensated pressure data in integer.
+ * @param[in] uncomp_data : Contains the uncompensated pressure data.
+ * @param[in] calib_data : Pointer to the calibration data structure.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 compensate_pressure(u64 *pressure,
+			      const struct bmp3_uncomp_data *uncomp_data,
+			      const struct bmp3_calib_data *calib_data);
+/*!
+ * @brief This internal API is used to calculate the power functionality.
+ *
+ * @param[in] base : Contains the base value.
+ * @param[in] power : Contains the power value.
+ *
+ * @return Output of power function.
+ * @retval Calculated power function output in integer.
+ */
+static u32 pow_bmp3(u8 base, u8 power);
+#endif /* BMP3_FLOAT_COMPENSATION */
+/*!
+ * @brief This internal API is used to identify the settings which the user
+ * wants to modify in the sensor.
+ *
+ * @param[in] sub_settings : Contains the settings subset to identify
+ * particular group of settings which the user is interested to change.
+ * @param[in] settings : Contains the user specified settings.
+ *
+ * @return Indicates whether user is interested to modify the settings which
+ * are related to sub_settings.
+ * @retval True -> User wants to modify this group of settings
+ * @retval False -> User does not want to modify this group of settings
+ */
+static u8 are_settings_changed(u32 sub_settings, u32 settings);
+/*!
+ * @brief This internal API interleaves the register address between the
+ * register data buffer for burst write operation.
+ *
+ * @param[in] reg_addr : Contains the register address array.
+ * @param[out] temp_buff : Contains the temporary buffer to store the
+ * register data and register address.
+ * @param[in] reg_data : Contains the register data to be written in the
+ * temporary buffer.
+ * @param[in] len : No of bytes of data to be written for burst write.
+ *
+ */
+static void interleave_reg_addr(const u8 *reg_addr, u8 *temp_buff,
+				const u8 *reg_data, u32 len);
+/*!
+ * @brief This internal API sets the pressure enable and
+ * temperature enable settings of the sensor.
+ *
+ * @param[in] desired_settings : Contains the settings which user wants to
+ *                               change.
+ * @param[in] settings         : Structure instance of bmp3_settings
+ * @param[in] dev              : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 set_pwr_ctrl_settings(u32 desired_settings,
+				const struct bmp3_settings *settings,
+				struct bmp3_dev *dev);
+
+/*!
+ * @brief This internal API sets the over sampling, ODR and filter settings of
+ * the sensor based on the settings selected by the user.
+ *
+ * @param[in] desired_settings : Variable used to select the settings which
+ * are to be set.
+ * @param[in] settings         : Structure instance of bmp3_settings
+ * @param[in] dev              : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 set_odr_filter_settings(u32 desired_settings,
+				  struct bmp3_settings *settings,
+				  struct bmp3_dev *dev);
+/*!
+ * @brief This internal API sets the interrupt control (output mode, level,
+ * latch and data ready) settings of the sensor based on the settings
+ * selected by the user.
+ *
+ * @param[in] desired_settings : Variable used to select the settings which
+ *                               are to be set.
+ * @param[in] settings         : Structure instance of bmp3_settings
+ * @param[in] dev              : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 set_int_ctrl_settings(u32 desired_settings,
+				const struct bmp3_settings *settings,
+				struct bmp3_dev *dev);
+/*!
+ * @brief This internal API sets the advance (i2c_wdt_en, i2c_wdt_sel)
+ * settings of the sensor based on the settings selected by the user.
+ *
+ * @param[in] desired_settings : Variable used to select the settings which
+ *                               are to be set.
+ * @param[in] settings         : Structure instance of bmp3_settings
+ * @param[in] dev              : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 set_advance_settings(u32 desired_settings,
+			       const struct bmp3_settings *settings,
+			       struct bmp3_dev *dev);
+/*!
+ * @brief This internal API fills the register address and register data of
+ * the over sampling settings for burst write operation.
+ *
+ * @param[in] desired_settings  : Variable which specifies the settings which
+ *                                are to be set in the sensor.
+ * @param[out] addr             : To store the address to fill in
+ * register buffer.
+ * @param[out] reg_data         : To store the osr register data.
+ * @param[out] len              : To store the len for burst write.
+ * @param[in] settings          : Structure instance of bmp3_settings
+ *
+ */
+static void fill_osr_data(u32 desired_settings,
+			  u8 *addr,
+			  u8 *reg_data,
+			  u8 *len,
+			  const struct bmp3_settings *settings);
+/*!
+ * @brief This internal API fills the register address and register data of
+ * the ODR settings for burst write operation.
+ *
+ * @param[out] addr       : To store the address to fill in register buffer.
+ * @param[out] reg_data   : To store the register data to set the odr data.
+ * @param[out] len        : To store the len for burst write.
+ * @param[in] settings    : Structure instance of bmp3_settings
+ *
+ */
+static void fill_odr_data(u8 *addr, u8 *reg_data, u8 *len,
+			  struct bmp3_settings *settings);
+/*!
+ * @brief This internal API fills the register address and register data of
+ * the filter settings for burst write operation.
+ *
+ * @param[out] addr       : To store the address to fill in register buffer.
+ * @param[out] reg_data   : To store the register data to set the filter.
+ * @param[out] len        : To store the len for burst write.
+ * @param[in] settings    : Structure instance of bmp3_settings
+ *
+ */
+static void fill_filter_data(u8 *addr, u8 *reg_data, u8 *len,
+			     const struct bmp3_settings *settings);
+/*!
+ * @brief This internal API is used to validate the device pointer for
+ * null conditions.
+ *
+ * @param[in] dev : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 null_ptr_check(const struct bmp3_dev *dev);
+/*!
+ * @brief This internal API parse the power control(power mode, pressure enable
+ * and temperature enable), over sampling, ODR, filter and interrupt control
+ * settings and store in the device structure.
+ *
+ * @param[in] reg_data    : Register data to be parsed.
+ * @param[in] settings    : Structure instance of bmp3_settings
+ */
+static void parse_sett_data(const u8 *reg_data,
+			    struct bmp3_settings *settings);
+/*!
+ * @brief This internal API parse the power control(power mode, pressure enable
+ * and temperature enable) settings and store in the device structure.
+ *
+ * @param[in] reg_data : Pointer variable which stores the register data to
+ * parse.
+ * @param[out] settings : Structure instance of bmp3_settings.
+ */
+static void parse_pwr_ctrl_settings(const u8 *reg_data,
+				    struct bmp3_settings *settings);
+/*!
+ * @brief This internal API parse the over sampling, ODR and filter
+ * settings and store in the device structure.
+ *
+ * @param[in] reg_data : Pointer variable which stores the register data to
+ * parse.
+ * @param[out] settings : Structure instance of bmp3_odr_filter_settings.
+ */
+static void parse_odr_filter_settings(const u8 *reg_data,
+				      struct bmp3_odr_filter_settings *settings);
+/*!
+ * @brief This internal API parse the interrupt control(output mode, level,
+ * latch and data ready) settings and store in the device structure.
+ *
+ * @param[in] reg_data : Pointer variable which stores the register data to
+ * parse.
+ * @param[out] settings : Structure instance of bmp3_int_ctrl_settings.
+ */
+static void parse_int_ctrl_settings(const u8 *reg_data,
+				    struct bmp3_int_ctrl_settings *settings);
+/*!
+ * @brief This internal API parse the advance (i2c_wdt_en, i2c_wdt_sel)
+ * settings and store in the device structure.
+ *
+ * @param[in] reg_data : Pointer variable which stores the register data to
+ * parse.
+ * @param[out] settings : Structure instance of bmp3_adv_settings.
+ */
+static void parse_advance_settings(const u8 *reg_data,
+				   struct bmp3_adv_settings *settings);
+/*!
+ * @brief This internal API validate the normal mode settings of the sensor.
+ *
+ * @param[out] settings : Structure instance of bmp3_settings.
+ * @param[in] dev : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 validate_normal_mode_settings(struct bmp3_settings *settings,
+					struct bmp3_dev *dev);
+/*!
+ * @brief This internal API validate the over sampling, ODR settings of the
+ * sensor.
+ *
+ * @param[out] settings : Structure instance of bmp3_settings.
+ *
+ * @return Indicates whether ODR and OSR settings are valid or not.
+ * @retval 0 -> Success
+ * @retval <0 -> Fail
+ */
+static s8 validate_osr_and_odr_settings(const struct bmp3_settings *settings);
+/*!
+ * @brief This internal API calculates the pressure measurement duration of the
+ * sensor.
+ *
+ * @param[out] settings : Structure instance of bmp3_settings.
+ *
+ * @return Pressure measurement time
+ * @retval Pressure measurement time in microseconds
+ */
+static u32 calculate_press_meas_time(const struct bmp3_settings *settings);
+/*!
+ * @brief This internal API calculates the temperature measurement duration of
+ * the sensor.
+ *
+ * @param[out] settings : Structure instance of bmp3_settings.
+ *
+ * @return Temperature measurement time
+ * @retval Temperature measurement time in microseconds
+ */
+static u32 calculate_temp_meas_time(const struct bmp3_settings *settings);
+/*!
+ * @brief This internal API checks whether the measurement time and ODR
+ * duration of the sensor are proper.
+ *
+ * @param[in] meas_t : Pressure and temperature measurement time in
+ * microseconds.
+ * @param[in] odr_duration : Duration in microseconds corresponding to the ODR
+ *                           value.
+ *
+ * @return Indicates whether ODR and OSR settings are valid or not.
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ */
+static s8 verify_meas_time_and_odr_duration(u32 meas_t, u32 odr_duration);
+/*!
+ * @brief This internal API puts the device to sleep mode.
+ *
+ * @param[in] dev : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 put_device_to_sleep(struct bmp3_dev *dev);
+/*!
+ * @brief This internal API sets the normal mode in the sensor.
+ *
+ * @param[in] settings  : Structure instance of bmp3_settings.
+ * @param[in] dev       : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 set_normal_mode(struct bmp3_settings *settings,
+			  struct bmp3_dev *dev);
+/*!
+ * @brief This internal API writes the power mode in the sensor.
+ *
+ * @param[out] settings : Structure instance of bmp3_settings.
+ * @param[in] dev       : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 write_power_mode(const struct bmp3_settings *settings,
+			   struct bmp3_dev *dev);
+/*!
+ * @brief This internal API fills the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en) settings in
+ * the reg_data variable so as to burst write in the sensor.
+ *
+ * @param[in] desired_settings : Variable which specifies the settings which
+ *                               are to be set in the sensor.
+ * @param[in] fifo_settings    : Structure instance of bmp3_fifo_settings
+ * @param[in] dev              : Structure instance of bmp3_dev
+ */
+static s8 fill_fifo_config_1(u16 desired_settings,
+			     const struct bmp3_fifo_settings *fifo_settings,
+			     struct bmp3_dev *dev);
+/*!
+ * @brief This internal API fills the fifo_config_2(fifo_sub_sampling,
+ * data_select) settings in the reg_data variable so as to burst write
+ * in the sensor.
+ *
+ * @param[in] desired_settings : Variable which specifies the settings which
+ *                               are to be set in the sensor.
+ * @param[in] fifo_settings    : Structure instance of bmp3_fifo_settings
+ * @param[in] dev              : Structure instance of bmp3_dev
+ */
+static s8 fill_fifo_config_2(u16 desired_settings,
+			     const struct bmp3_fifo_settings *fifo_settings,
+			     struct bmp3_dev *dev);
+/*!
+ * @brief This internal API fills the fifo interrupt control(fwtm_en, ffull_en)
+ * settings in the reg_data variable so as to burst write in the sensor.
+ *
+ * @param[in] desired_settings : Variable which specifies the settings which
+ *                               are to be set in the sensor.
+ * @param[in] fifo_settings    : Structure instance of bmp3_fifo_settings
+ * @param[in] dev              : Structure instance of bmp3_dev
+ */
+static s8 fill_fifo_int_ctrl(u16 desired_settings,
+			     const struct bmp3_fifo_settings *fifo_settings,
+			     struct bmp3_dev *dev);
+/*!
+ * @brief This internal API is used to parse the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en),
+ * fifo_config_2(fifo_subsampling, data_select) and int_ctrl(fwtm_en, ffull_en)
+ * settings and store it in device structure
+ *
+ * @param[in] reg_data       : Pointer variable which stores the fifo settings
+ *                             data read from the sensor.
+ * @param[out] fifo_settings : Structure instance of bmp3_fifo_settings which
+ *                              contains the fifo settings after parsing.
+ */
+static void parse_fifo_settings(const u8 *reg_data,
+				struct bmp3_fifo_settings *fifo_settings);
+/*!
+ * @brief This internal API parse the FIFO data frame from the fifo buffer and
+ * fills the byte count, uncompensated pressure and/or temperature data and no
+ * of parsed frames.
+ *
+ * @param[in] header         : Pointer variable which stores the fifo settings
+ *                             data read from the sensor.
+ * @param[in,out] fifo       : Structure instance of bmp3_fifo
+ * @param[out] byte_index    : Byte count which is incremented according to the
+ *                             of data.
+ * @param[out] uncomp_data   : Uncompensated pressure and/or temperature data
+ *                             which is stored after parsing fifo buffer data.
+ * @param[out] parsed_frames : Total number of parsed frames.
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval <0 -> Fail
+ */
+static u8 parse_fifo_data_frame(u8 header,
+				struct bmp3_fifo_data *fifo,
+				u16 *byte_index,
+				struct bmp3_uncomp_data *uncomp_data,
+				u8 *parsed_frames);
+/*!
+ * @brief This internal API unpacks the FIFO data frame from the fifo buffer
+ * and fills the byte count, uncompensated pressure and/or temperature data.
+ *
+ * @param[out] byte_index : Byte count of fifo buffer.
+ * @param[in] fifo_buffer : FIFO buffer from where the temperature and pressure
+ * frames are unpacked.
+ * @param[out] uncomp_data : Uncompensated temperature and pressure data after
+ * unpacking from fifo buffer.
+ */
+static void unpack_temp_press_frame(u16 *byte_index,
+				    const u8 *fifo_buffer,
+				    struct bmp3_uncomp_data *uncomp_data);
+/*!
+ * @brief This internal API unpacks the FIFO data frame from the fifo buffer
+ * and fills the byte count and uncompensated pressure data.
+ *
+ * @param[out] byte_index : Byte count of fifo buffer.
+ * @param[in] fifo_buffer : FIFO buffer from where the pressure frames are
+ * unpacked.
+ * @param[out] uncomp_data : Uncompensated pressure data after unpacking from
+ * fifo buffer.
+ */
+static void unpack_press_frame(u16 *byte_index, const u8 *fifo_buffer,
+			       struct bmp3_uncomp_data *uncomp_data);
+/*!
+ * @brief This internal API unpacks the FIFO data frame from the fifo buffer
+ * and fills the byte count and uncompensated temperature data.
+ *
+ * @param[out] byte_index : Byte count of fifo buffer.
+ * @param[in] fifo_buffer : FIFO buffer from where the temperature frames
+ * are unpacked.
+ * @param[out] uncomp_data : Uncompensated temperature data after unpacking
+ * from fifo buffer.
+ */
+static void unpack_temp_frame(u16 *byte_index, const u8 *fifo_buffer,
+			      struct bmp3_uncomp_data *uncomp_data);
+/*!
+ * @brief This internal API unpacks the time frame from the fifo data buffer
+ * and fills the byte count and update the sensor time variable.
+ *
+ * @param[out] byte_index : Byte count of fifo buffer.
+ * @param[in] fifo_buffer : FIFO buffer from where the sensor time frames
+ * are unpacked.
+ * @param[out] sensor_time : Variable used to store the sensor time.
+ */
+static void unpack_time_frame(u16 *byte_index, const u8 *fifo_buffer,
+			      u32 *sensor_time);
+/*!
+ * @brief This internal API parses the FIFO buffer and gets the header info.
+ *
+ * @param[out] header : Variable used to store the fifo header data.
+ * @param[in] fifo_buffer : FIFO buffer from where the header data is retrieved.
+ * @param[out] byte_index : Byte count of fifo buffer.
+ */
+static void get_header_info(u8 *header, const u8 *fifo_buffer, u16 *byte_index);
+/*!
+ * @brief This internal API parses the FIFO data frame from the fifo buffer and
+ * fills uncompensated temperature and/or pressure data.
+ *
+ * @param[in] sensor_comp : Variable used to select either temperature or
+ * pressure or both while parsing the fifo frames.
+ * @param[in] fifo_buffer : FIFO buffer where the temperature or pressure or
+ * both the data to be parsed.
+ * @param[out] uncomp_data : Uncompensated temperature or pressure or both the
+ * data after unpacking from fifo buffer.
+ */
+static void parse_fifo_sensor_data(u8 sensor_comp, const u8 *fifo_buffer,
+				   struct bmp3_uncomp_data *uncomp_data);
+/*!
+ * @brief This internal API resets the FIFO buffer, start index,
+ * parsed frame count, configuration change, configuration error and
+ * frame_not_available variables.
+ *
+ * @param[out] fifo : FIFO structure instance where the fifo related variables
+ * are reset.
+ */
+static void reset_fifo_index(struct bmp3_fifo_data *fifo);
+/*!
+ * @brief This API gets the command ready, data ready for pressure and
+ * temperature, power on reset status from the sensor.
+ *
+ * @param[out]        : Structure instance of bmp3_status
+ * @param[in] dev     : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval <0 -> Fail
+ */
+static s8 get_sensor_status(struct bmp3_status *status, struct bmp3_dev *dev);
+/*!
+ * @brief This API gets the interrupt (fifo watermark, fifo full, data ready)
+ * status from the sensor.
+ *
+ * @param[out]        : Structure instance of bmp3_status
+ * @param[in] dev     : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval <0 -> Fail
+ */
+static s8 get_int_status(struct bmp3_status *status, struct bmp3_dev *dev);
+/*!
+ * @brief This API gets the fatal, command and configuration error
+ * from the sensor.
+ *
+ * @param[out]        : Structure instance of bmp3_status
+ * @param[in] dev     : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval <0 -> Fail
+ */
+static s8 get_err_status(struct bmp3_status *status, struct bmp3_dev *dev);
+/*!
+ * @brief This internal API converts the no. of frames required by the user to
+ * bytes so as to write in the watermark length register.
+ *
+ * @param[out] watermark_len : Pointer variable which contains the watermark
+ *                             length.
+ * @param[in] fifo           : Structure instance of bmp3_fifo_data
+ * @param[in] fifo_settings  : Structure instance of bmp3_fifo_settings
+ *
+ * @return Result of API execution status.
+ * @retval 0 -> Success
+ * @retval <0 -> Fail
+ */
+static s8 convert_frames_to_bytes(u16 *watermark_len,
+				  const struct bmp3_fifo_data *fifo,
+				  const struct bmp3_fifo_settings *fifo_settings);
+/****************** Global Function Definitions ******************************/
+/*!
+ *  @brief This API is the entry point.
+ *  It performs the selection of I2C/SPI read mechanism according to the
+ *  selected interface and reads the chip-id
+ *  and calibration data of the sensor.
+ */
+s8 bmp3_init(struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 chip_id = 0;
+
+	/* Check for null pointer in the device structure */
+	rslt = null_ptr_check(dev);
+	/* Proceed if null check is fine */
+	if (rslt == BMP3_OK) {
+		/* Read mechanism according to selected interface */
+		if (dev->intf != BMP3_I2C_INTF) {
+			/* If SPI interface is selected, read extra byte */
+			dev->dummy_byte = 1;
+		} else {
+			dev->dummy_byte = 0;
+		}
+
+		/* Read the chip-id of bmp3 sensor */
+		rslt = bmp3_get_regs(BMP3_REG_CHIP_ID, &chip_id, 1, dev);
+
+		/* Proceed if everything is fine until now */
+		if (rslt == BMP3_OK) {
+			/* Check for chip id validity */
+			if (chip_id == BMP3_CHIP_ID || chip_id == BMP390_CHIP_ID) {
+				dev->chip_id = chip_id;
+				/* Reset the sensor */
+				rslt = bmp3_soft_reset(dev);
+				if (rslt == BMP3_OK) {
+					/* Read the calibration data */
+					rslt = get_calib_data(dev);
+				}
+			} else {
+				rslt = BMP3_E_DEV_NOT_FOUND;
+			}
+		}
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API reads the data from the given
+ * register address of the sensor.
+ */
+s8 bmp3_get_regs(u8 reg_addr, u8 *reg_data, u32 len, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u32 idx;
+	u32 temp_len = len + dev->dummy_byte;
+	u8 temp_buff[REG_BUFF_SIZE];
+
+	/* Check for null pointer in the device structure */
+	rslt = null_ptr_check(dev);
+	/* Proceed if null check is fine */
+	if (rslt == BMP3_OK && reg_data) {
+		/* If interface selected is SPI */
+		if (dev->intf != BMP3_I2C_INTF) {
+			reg_addr = reg_addr | 0x80;
+
+			/* Read the data from the register */
+			dev->intf_rslt = dev->read(reg_addr, temp_buff,
+						   temp_len, dev->intf_ptr);
+			for (idx = 0; idx < len; idx++)
+				reg_data[idx] = temp_buff[idx + dev->dummy_byte];
+		} else {
+			/* Read the data using I2C */
+			dev->intf_rslt = dev->read(reg_addr, reg_data, len, dev->intf_ptr);
+		}
+		/* Check for communication error */
+		if (dev->intf_rslt != BMP3_INTF_RET_SUCCESS)
+			rslt = BMP3_E_COMM_FAIL;
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API writes the given data to the register address
+ * of the sensor.
+ */
+s8 bmp3_set_regs(u8 *reg_addr, const u8 *reg_data, u32 len,
+		 struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 temp_buff[REG_BUFF_SIZE];
+	u32 temp_len;
+	u8 reg_addr_cnt;
+
+	/* Check for null pointer in the device structure */
+	rslt = null_ptr_check(dev);
+
+	/* Check for arguments validity */
+	if (rslt == BMP3_OK && reg_addr && reg_data) {
+		if (len != 0) {
+			temp_buff[0] = reg_data[0];
+
+			/* If interface selected is SPI */
+			if (dev->intf == BMP3_SPI_INTF) {
+				for (reg_addr_cnt = 0; reg_addr_cnt < len; reg_addr_cnt++)
+					reg_addr[reg_addr_cnt] = reg_addr[reg_addr_cnt] & 0x7F;
+			}
+
+			/* Burst write mode */
+			if (len > 1) {
+				/* Interleave register address w.r.t data for
+				 * burst write
+				 */
+				interleave_reg_addr(reg_addr, temp_buff, reg_data, len);
+				temp_len = len * 2;
+			} else {
+				temp_len = len;
+			}
+
+			dev->intf_rslt = dev->write(reg_addr[0], temp_buff,
+						    temp_len, dev->intf_ptr);
+
+			/* Check for communication error */
+			if (dev->intf_rslt != BMP3_INTF_RET_SUCCESS)
+				rslt = BMP3_E_COMM_FAIL;
+		} else {
+			rslt = BMP3_E_INVALID_LEN;
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API sets the power control(pressure enable and
+ * temperature enable), over sampling, ODR and filter
+ * settings in the sensor.
+ */
+s8 bmp3_set_sensor_settings(u32 desired_settings,
+			    struct bmp3_settings *settings,
+			    struct bmp3_dev *dev)
+{
+	s8 rslt = BMP3_OK;
+
+	if (settings) {
+		if (are_settings_changed(BMP3_POWER_CNTL, desired_settings)) {
+			/* Set the power control settings */
+			rslt = set_pwr_ctrl_settings(desired_settings, settings, dev);
+		}
+		if (are_settings_changed(BMP3_ODR_FILTER, desired_settings)) {
+			/* Set the over sampling, ODR and filter settings */
+			rslt = set_odr_filter_settings(desired_settings, settings, dev);
+		}
+
+		if (are_settings_changed(BMP3_INT_CTRL, desired_settings)) {
+			/* Set the interrupt control settings */
+			rslt = set_int_ctrl_settings(desired_settings, settings, dev);
+		}
+		if (are_settings_changed(BMP3_ADV_SETT, desired_settings)) {
+			/* Set the advance settings */
+			rslt = set_advance_settings(desired_settings, settings, dev);
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the power control(power mode, pressure enable and
+ * temperature enable), over sampling, ODR, filter, interrupt control and
+ * advance settings from the sensor.
+ */
+s8 bmp3_get_sensor_settings(struct bmp3_settings *settings,
+			    struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 settings_data[BMP3_LEN_GEN_SETT];
+
+	if (settings) {
+		rslt = bmp3_get_regs(BMP3_REG_INT_CTRL, settings_data,
+				     BMP3_LEN_GEN_SETT, dev);
+
+		if (rslt == BMP3_OK) {
+			/* Parse the settings data */
+			parse_sett_data(settings_data, settings);
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API sets the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en),
+ * fifo_config_2(fifo_subsampling, data_select) and int_ctrl(fwtm_en, ffull_en)
+ * settings in the sensor.
+ */
+s8 bmp3_set_fifo_settings(u16 desired_settings,
+			  const struct bmp3_fifo_settings *fifo_settings,
+			  struct bmp3_dev *dev)
+{
+	s8 rslt;
+	/* Check for null pointer in the device structure */
+	rslt = null_ptr_check(dev);
+
+	/* Proceed if null check is fine */
+	if (rslt == BMP3_OK && fifo_settings) {
+		if (are_settings_changed(BMP3_FIFO_CONFIG_1, desired_settings)) {
+			/* Fill the FIFO config 1 register data */
+			rslt = fill_fifo_config_1(desired_settings, fifo_settings, dev);
+		}
+
+		if (are_settings_changed(desired_settings, BMP3_FIFO_CONFIG_2)) {
+			/* Fill the FIFO config 2 register data */
+			rslt = fill_fifo_config_2(desired_settings, fifo_settings, dev);
+		}
+
+		if (are_settings_changed(desired_settings, BMP3_FIFO_INT_CTRL)) {
+			/* Fill the FIFO interrupt ctrl register data */
+			rslt = fill_fifo_int_ctrl(desired_settings, fifo_settings, dev);
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en),
+ * fifo_config_2(fifo_subsampling, data_select) and int_ctrl(fwtm_en, ffull_en)
+ * settings from the sensor.
+ */
+s8 bmp3_get_fifo_settings(struct bmp3_fifo_settings *fifo_settings,
+			  struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 fifo_sett[3];
+	u8 len = 3;
+
+	/* Proceed if null check is fine */
+	if (fifo_settings) {
+		rslt = bmp3_get_regs(BMP3_REG_FIFO_CONFIG_1, fifo_sett, len, dev);
+
+		/* Parse the fifo settings */
+		parse_fifo_settings(fifo_sett, fifo_settings);
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the fifo data from the sensor.
+ */
+s8 bmp3_get_fifo_data(struct bmp3_fifo_data *fifo,
+		      const struct bmp3_fifo_settings *fifo_settings,
+		      struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u16 fifo_len;
+
+	if (fifo && fifo_settings) {
+		reset_fifo_index(fifo);
+
+		/* Get the total number of bytes available in FIFO */
+		rslt = bmp3_get_fifo_length(&fifo_len, dev);
+		if (rslt == BMP3_OK) {
+			/* For sensor time frame , add additional overhead bytes */
+			if (fifo_settings->time_en)
+				fifo_len = fifo_len + BMP3_SENSORTIME_OVERHEAD_BYTES;
+
+			/* Update the fifo length in the fifo structure */
+			fifo->byte_count = fifo_len;
+
+			/* Read the fifo data */
+			rslt = bmp3_get_regs(BMP3_REG_FIFO_DATA, fifo->buffer,
+					     fifo_len, dev);
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API sets the fifo watermark length according to the frames count
+ * set by the user in the device structure. Refer below for usage.
+ */
+s8 bmp3_set_fifo_watermark(const struct bmp3_fifo_data *fifo,
+			   const struct bmp3_fifo_settings *fifo_settings,
+			   struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_data[2];
+	u8 reg_addr[2];
+	u16 watermark_len;
+
+	reg_addr[0] = BMP3_REG_FIFO_WM;
+	reg_addr[1] = BMP3_REG_FIFO_WM + 1;
+	if (fifo && fifo_settings) {
+		rslt = convert_frames_to_bytes(&watermark_len, fifo, fifo_settings);
+
+		if (rslt == BMP3_OK) {
+			reg_data[0] = BMP3_GET_LSB(watermark_len);
+			reg_data[1] = BMP3_GET_MSB(watermark_len) & 0x01;
+			rslt = bmp3_set_regs(reg_addr, reg_data, 2, dev);
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API sets the fifo watermark length according to the frames count
+ * set by the user in the device structure. Refer below for usage.
+ */
+s8 bmp3_get_fifo_watermark(u16 *watermark_len, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_data[2];
+	u8 reg_addr = BMP3_REG_FIFO_WM;
+
+	if (watermark_len) {
+		rslt = bmp3_get_regs(reg_addr, reg_data, 2, dev);
+		if (rslt == BMP3_OK)
+			*watermark_len = (reg_data[0]) + (reg_data[1] << 8);
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API extracts the temperature and/or pressure data from the FIFO
+ * data which is already read from the fifo.
+ */
+s8 bmp3_extract_fifo_data(struct bmp3_data *data, struct bmp3_fifo_data *fifo,
+			  struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 header;
+	u8 parsed_frames = 0;
+	u8 t_p_frame;
+	struct bmp3_uncomp_data uncomp_data = {0};
+	u16 byte_index = fifo->start_idx;
+
+	rslt = null_ptr_check(dev);
+	if (rslt == BMP3_OK && fifo && data) {
+		while (byte_index < fifo->byte_count) {
+			get_header_info(&header, fifo->buffer, &byte_index);
+			t_p_frame = parse_fifo_data_frame(header, fifo, &byte_index,
+							  &uncomp_data, &parsed_frames);
+			/* If the frame is pressure and/or temperature data */
+			if (t_p_frame) {
+				/* Compensate temperature and pressure data */
+				rslt = compensate_data(t_p_frame, &uncomp_data,
+						       &data[parsed_frames - 1],
+						       &dev->calib_data);
+			}
+		}
+
+		/* Check if any frames are parsed in FIFO */
+		if (parsed_frames != 0) {
+			/* Update the bytes parsed in the device structure */
+			fifo->start_idx = byte_index;
+			fifo->parsed_frames += parsed_frames;
+		} else {
+			/* No frames are there to parse. It is time to
+			 * read the FIFO, if more frames are needed
+			 */
+			fifo->frame_not_available = TRUE;
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the command ready, data ready for pressure and
+ * temperature and interrupt (fifo watermark, fifo full, data ready) and
+ * error status from the sensor.
+ */
+s8 bmp3_get_status(struct bmp3_status *status, struct bmp3_dev *dev)
+{
+	s8 rslt;
+
+	if (status) {
+		rslt = get_sensor_status(status, dev);
+		/* Proceed further if the earlier operation is fine */
+		if (rslt == BMP3_OK) {
+			rslt = get_int_status(status, dev);
+			/* Proceed further if the earlier operation is fine */
+			if (rslt == BMP3_OK) {
+				/* Get the error status */
+				rslt = get_err_status(status, dev);
+			}
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the fifo length from the sensor.
+ */
+s8 bmp3_get_fifo_length(u16 *fifo_length, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_data[2];
+
+	if (fifo_length) {
+		rslt = bmp3_get_regs(BMP3_REG_FIFO_LENGTH, reg_data, 2, dev);
+
+		/* Proceed if read from register is fine */
+		if (rslt == BMP3_OK) {
+			/* Update the fifo length */
+			*fifo_length = BMP3_CONCAT_BYTES(reg_data[1], reg_data[0]);
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API performs the soft reset of the sensor.
+ */
+s8 bmp3_soft_reset(struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_CMD;
+	/* 0xB6 is the soft reset command */
+	u8 soft_rst_cmd = BMP3_SOFT_RESET;
+	u8 cmd_rdy_status;
+	u8 cmd_err_status;
+
+	/* Check for command ready status */
+	rslt = bmp3_get_regs(BMP3_REG_SENS_STATUS, &cmd_rdy_status, 1, dev);
+
+	/* Device is ready to accept new command */
+	if (cmd_rdy_status & BMP3_CMD_RDY && rslt == BMP3_OK) {
+		/* Write the soft reset command in the sensor */
+		rslt = bmp3_set_regs(&reg_addr, &soft_rst_cmd, 1, dev);
+
+		/* Proceed if everything is fine until now */
+		if (rslt == BMP3_OK) {
+			/* Wait for 2 ms */
+			dev->delay_us(2000, dev->intf_ptr);
+
+			/* Read for command error status */
+			rslt = bmp3_get_regs(BMP3_REG_ERR, &cmd_err_status, 1, dev);
+
+			/* check for command error status */
+			if (cmd_err_status & BMP3_REG_CMD || rslt != BMP3_OK) {
+				/* Command not written hence return
+				 * error
+				 */
+				rslt = BMP3_E_CMD_EXEC_FAILED;
+			}
+		}
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API performs the soft reset of the sensor.
+ */
+s8 bmp3_fifo_flush(struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_CMD;
+	u8 fifo_flush_cmd = BMP3_FIFO_FLUSH;
+	u8 cmd_rdy_status;
+	u8 cmd_err_status;
+
+	/* Check for command ready status */
+	rslt = bmp3_get_regs(BMP3_REG_SENS_STATUS, &cmd_rdy_status, 1, dev);
+	/* Device is ready to accept new command */
+	if (cmd_rdy_status & BMP3_CMD_RDY && rslt == BMP3_OK) {
+		/* Write the soft reset command in the sensor */
+		rslt = bmp3_set_regs(&reg_addr, &fifo_flush_cmd, 1, dev);
+
+		/* Proceed if everything is fine until now */
+		if (rslt == BMP3_OK) {
+			/* Wait for 2 ms */
+			dev->delay_us(2000, dev->intf_ptr);
+
+			/* Read for command error status */
+			rslt = bmp3_get_regs(BMP3_REG_ERR, &cmd_err_status, 1, dev);
+
+			/* check for command error status */
+			if (cmd_err_status & BMP3_REG_CMD || rslt != BMP3_OK) {
+				/* Command not written hence return
+				 * error
+				 */
+				rslt = BMP3_E_CMD_EXEC_FAILED;
+			}
+		}
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API sets the power mode of the sensor.
+ */
+s8 bmp3_set_op_mode(struct bmp3_settings *settings, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 last_set_mode;
+	u8 curr_mode = settings->op_mode;
+
+	/* Check for null pointer in the device structure */
+	rslt = null_ptr_check(dev);
+	if (rslt == BMP3_OK && settings) {
+		rslt = bmp3_get_op_mode(&last_set_mode, dev);
+
+		/* If the sensor is not in sleep mode put the device to sleep
+		 * mode
+		 */
+		if (last_set_mode != BMP3_MODE_SLEEP && rslt == BMP3_OK) {
+			/* Device should be put to sleep before transiting to
+			 * forced mode or normal mode
+			 */
+			rslt = put_device_to_sleep(dev);
+
+			/* Give some time for device to go into sleep mode */
+			dev->delay_us(5000, dev->intf_ptr);
+		}
+
+		/* Set the power mode */
+		if (rslt == BMP3_OK) {
+			if (curr_mode == BMP3_MODE_NORMAL) {
+				/* Set normal mode and validate
+				 * necessary settings
+				 */
+				rslt = set_normal_mode(settings, dev);
+			} else if (curr_mode == BMP3_MODE_FORCED) {
+				/* Set forced mode */
+				rslt = write_power_mode(settings, dev);
+			}
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the power mode of the sensor.
+ */
+s8 bmp3_get_op_mode(u8 *op_mode, struct bmp3_dev *dev)
+{
+	s8 rslt;
+
+	if (op_mode) {
+		/* Read the power mode register */
+		rslt = bmp3_get_regs(BMP3_REG_PWR_CTRL, op_mode, 1, dev);
+
+		/* Assign the power mode in the device structure */
+		*op_mode = BMP3_GET_BITS(*op_mode, BMP3_OP_MODE);
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This API reads the pressure, temperature or both data from the
+ * sensor, compensates the data and store it in the bmp3_data structure
+ * instance passed by the user.
+ */
+s8 bmp3_get_sensor_data(u8 sensor_comp, struct bmp3_data *comp_data,
+			struct bmp3_dev *dev)
+{
+	s8 rslt;
+	/* Array to store the pressure and temperature data read from
+	 * the sensor
+	 */
+	u8 reg_data[BMP3_LEN_P_T_DATA] = { 0 };
+	struct bmp3_uncomp_data uncomp_data = { 0 };
+
+	if (comp_data) {
+		/* Read the pressure and temperature data from the sensor */
+		rslt = bmp3_get_regs(BMP3_REG_DATA, reg_data, BMP3_LEN_P_T_DATA, dev);
+
+		if (rslt == BMP3_OK) {
+			/* Parse the read data from the sensor */
+			parse_sensor_data(reg_data, &uncomp_data);
+
+			/* Compensate the pressure/temperature/both data read
+			 * from the sensor
+			 */
+			rslt = compensate_data(sensor_comp, &uncomp_data,
+					       comp_data, &dev->calib_data);
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+
+	return rslt;
+}
+
+/****************** Static Function Definitions ******************************/
+/*!
+ * @brief This internal API converts the no. of frames required by the user to
+ * bytes so as to write in the watermark length register.
+ */
+static s8 convert_frames_to_bytes(u16 *watermark_len,
+				  const struct bmp3_fifo_data *fifo,
+				  const struct bmp3_fifo_settings *fifo_settings)
+{
+	s8 rslt = BMP3_OK;
+
+	if (fifo->req_frames > 0 && fifo->req_frames <= BMP3_FIFO_MAX_FRAMES) {
+		if (fifo_settings->press_en && fifo_settings->temp_en) {
+			/* Multiply with pressure and temperature header len */
+			*watermark_len = fifo->req_frames * BMP3_LEN_P_AND_T_HEADER_DATA;
+		} else if (fifo_settings->temp_en || fifo_settings->press_en) {
+			/* Multiply with pressure or temperature header len */
+			*watermark_len = fifo->req_frames * BMP3_LEN_P_OR_T_HEADER_DATA;
+		} else {
+			/* No sensor is enabled */
+			rslt = BMP3_W_SENSOR_NOT_ENABLED;
+		}
+	} else {
+		/* Required frame count is zero, which is invalid */
+		rslt = BMP3_W_INVALID_FIFO_REQ_FRAME_CNT;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This internal API resets the FIFO buffer, start index,
+ * parsed frame count, configuration change, configuration error and
+ * frame_not_available variables.
+ */
+static void reset_fifo_index(struct bmp3_fifo_data *fifo)
+{
+	/* Loop variable */
+	u16 index;
+	/* Variable for FIFO size */
+	u16 fifo_size = 512;
+
+	/* The size of FIFO in BMP3 is 512 bytes */
+	for (index = 0; index < fifo_size; index++) {
+		/* Initialize data buffer to zero */
+		fifo->buffer[index] = 0;
+	}
+
+	fifo->byte_count = 0;
+	fifo->start_idx = 0;
+	fifo->parsed_frames = 0;
+	fifo->config_change = 0;
+	fifo->config_err = 0;
+	fifo->frame_not_available = 0;
+}
+
+/*!
+ * @brief This internal API parse the FIFO data frame from the fifo buffer and
+ * fills the byte count, uncompensated pressure and/or temperature data and no
+ * of parsed frames.
+ */
+static u8 parse_fifo_data_frame(u8 header,
+				struct bmp3_fifo_data *fifo,
+				u16 *byte_index,
+				struct bmp3_uncomp_data *uncomp_data,
+				u8 *parsed_frames)
+{
+	u8 t_p_frame = FALSE;
+
+	switch (header) {
+	case BMP3_FIFO_ERROR_FRAME:
+		fifo->config_err = 1;
+		*byte_index = *byte_index + 1;
+		break;
+	case BMP3_FIFO_CONFIG_CHANGE:
+		fifo->config_change = 1;
+		*byte_index = *byte_index + 1;
+		break;
+	case BMP3_FIFO_EMPTY_FRAME:
+		*byte_index = fifo->byte_count;
+		break;
+	case BMP3_FIFO_PRESS_FRAME:
+		unpack_press_frame(byte_index, fifo->buffer, uncomp_data);
+		*parsed_frames = *parsed_frames + 1;
+		t_p_frame = BMP3_PRESS;
+		break;
+	case BMP3_FIFO_TEMP_FRAME:
+		unpack_temp_frame(byte_index, fifo->buffer, uncomp_data);
+		*parsed_frames = *parsed_frames + 1;
+		t_p_frame = BMP3_TEMP;
+		break;
+	case BMP3_FIFO_TEMP_PRESS_FRAME:
+		unpack_temp_press_frame(byte_index, fifo->buffer, uncomp_data);
+		*parsed_frames = *parsed_frames + 1;
+		t_p_frame = BMP3_PRESS_TEMP;
+		break;
+	case BMP3_FIFO_TIME_FRAME:
+		unpack_time_frame(byte_index, fifo->buffer, &fifo->sensor_time);
+		break;
+	default:
+		fifo->config_err = 1;
+		*byte_index = *byte_index + 1;
+		break;
+	}
+	return t_p_frame;
+}
+
+/*!
+ * @brief This internal API unpacks the FIFO data frame from the fifo buffer
+ * and fills the byte count, uncompensated pressure and/or temperature data.
+ */
+static void unpack_temp_press_frame(u16 *byte_index,
+				    const u8 *fifo_buffer,
+				    struct bmp3_uncomp_data *uncomp_data)
+{
+	parse_fifo_sensor_data((BMP3_PRESS_TEMP), &fifo_buffer[*byte_index],
+			       uncomp_data);
+	*byte_index = *byte_index + BMP3_LEN_P_T_DATA;
+}
+
+/*!
+ * @brief This internal API unpacks the FIFO data frame from the fifo buffer
+ * and fills the byte count and uncompensated temperature data.
+ */
+static void unpack_temp_frame(u16 *byte_index, const u8 *fifo_buffer,
+			      struct bmp3_uncomp_data *uncomp_data)
+{
+	parse_fifo_sensor_data(BMP3_TEMP, &fifo_buffer[*byte_index], uncomp_data);
+	*byte_index = *byte_index + BMP3_LEN_T_DATA;
+}
+
+/*!
+ * @brief This internal API unpacks the FIFO data frame from the fifo buffer
+ * and fills the byte count and uncompensated pressure data.
+ */
+static void unpack_press_frame(u16 *byte_index, const u8 *fifo_buffer,
+			       struct bmp3_uncomp_data *uncomp_data)
+{
+	parse_fifo_sensor_data(BMP3_PRESS, &fifo_buffer[*byte_index], uncomp_data);
+	*byte_index = *byte_index + BMP3_LEN_P_DATA;
+}
+
+/*!
+ * @brief This internal API unpacks the time frame from the fifo data buffer and
+ * fills the byte count and update the sensor time variable.
+ */
+static void unpack_time_frame(u16 *byte_index, const u8 *fifo_buffer,
+			      u32 *sensor_time)
+{
+	u16 index = *byte_index;
+	u32 xlsb = fifo_buffer[index];
+	u32 lsb = ((uint32_t)fifo_buffer[index + 1]) << 8;
+	u32 msb = ((uint32_t)fifo_buffer[index + 2]) << 16;
+
+	*sensor_time = msb | lsb | xlsb;
+	*byte_index = *byte_index + BMP3_LEN_SENSOR_TIME;
+}
+
+/*!
+ * @brief This internal API parses the FIFO data frame from the fifo buffer and
+ * fills uncompensated temperature and/or pressure data.
+ */
+static void parse_fifo_sensor_data(u8 sensor_comp, const u8 *fifo_buffer,
+				   struct bmp3_uncomp_data *uncomp_data)
+{
+	/* Temporary variables to store the sensor data */
+	u32 data_xlsb;
+	u32 data_lsb;
+	u32 data_msb;
+
+	/* Store the parsed register values for temperature data */
+	data_xlsb = (uint32_t)fifo_buffer[0];
+	data_lsb = (uint32_t)fifo_buffer[1] << 8;
+	data_msb = (uint32_t)fifo_buffer[2] << 16;
+
+	if (sensor_comp == BMP3_TEMP) {
+		/* Update uncompensated temperature */
+		uncomp_data->temperature = data_msb | data_lsb | data_xlsb;
+	}
+
+	if (sensor_comp == BMP3_PRESS) {
+		/* Update uncompensated pressure */
+		uncomp_data->pressure = data_msb | data_lsb | data_xlsb;
+	}
+
+	if (sensor_comp == (BMP3_PRESS_TEMP)) {
+		uncomp_data->temperature = data_msb | data_lsb | data_xlsb;
+
+		/* Store the parsed register values for pressure data */
+		data_xlsb = (uint32_t)fifo_buffer[3];
+		data_lsb = (uint32_t)fifo_buffer[4] << 8;
+		data_msb = (uint32_t)fifo_buffer[5] << 16;
+		uncomp_data->pressure = data_msb | data_lsb | data_xlsb;
+	}
+}
+
+/*!
+ * @brief This internal API parses the FIFO buffer and gets the header info.
+ */
+static void get_header_info(u8 *header, const u8 *fifo_buffer, u16 *byte_index)
+{
+	*header = fifo_buffer[*byte_index];
+	*byte_index = *byte_index + 1;
+}
+
+/*!
+ * @brief This internal API sets the normal mode in the sensor.
+ */
+static s8 set_normal_mode(struct bmp3_settings *settings, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 conf_err_status;
+
+	rslt = validate_normal_mode_settings(settings, dev);
+	/* If OSR and ODR settings are proper then write the power mode */
+	if (rslt == BMP3_OK) {
+		rslt = write_power_mode(settings, dev);
+
+		/* check for configuration error */
+		if (rslt == BMP3_OK) {
+			/* Read the configuration error status */
+			rslt = bmp3_get_regs(BMP3_REG_ERR, &conf_err_status, 1, dev);
+
+			/* Check if conf. error flag is set */
+			if (rslt == BMP3_OK) {
+				if (conf_err_status & BMP3_ERR_CONF) {
+					/* OSR and ODR configuration is not proper */
+					rslt = BMP3_E_CONFIGURATION_ERR;
+				}
+			}
+		}
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API writes the power mode in the sensor.
+ */
+static s8 write_power_mode(const struct bmp3_settings *settings,
+			   struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_PWR_CTRL;
+	u8 op_mode = settings->op_mode;
+	/* Temporary variable to store the value read from op-mode register */
+	u8 op_mode_reg_val;
+
+	/* Read the power mode register */
+	rslt = bmp3_get_regs(reg_addr, &op_mode_reg_val, 1, dev);
+
+	/* Set the power mode */
+	if (rslt == BMP3_OK) {
+		op_mode_reg_val = BMP3_SET_BITS(op_mode_reg_val,
+						BMP3_OP_MODE, op_mode);
+
+		/* Write the power mode in the register */
+		rslt = bmp3_set_regs(&reg_addr, &op_mode_reg_val, 1, dev);
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API puts the device to sleep mode.
+ */
+static s8 put_device_to_sleep(struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_PWR_CTRL;
+	/* Temporary variable to store the value read from op-mode register */
+	u8 op_mode_reg_val;
+
+	rslt = bmp3_get_regs(BMP3_REG_PWR_CTRL, &op_mode_reg_val, 1, dev);
+
+	if (rslt == BMP3_OK) {
+		/* Set the power mode */
+		op_mode_reg_val = op_mode_reg_val & (~(unsigned int)(BMP3_OP_MODE_MSK));
+
+		/* Write the power mode in the register */
+		rslt = bmp3_set_regs(&reg_addr, &op_mode_reg_val, 1, dev);
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API validate the normal mode settings of the sensor.
+ */
+static s8 validate_normal_mode_settings(struct bmp3_settings *settings,
+					struct bmp3_dev *dev)
+{
+	s8 rslt;
+
+	rslt = get_odr_filter_settings(settings, dev);
+
+	if (rslt == BMP3_OK)
+		rslt = validate_osr_and_odr_settings(settings);
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API reads the calibration data from the sensor, parse
+ * it then compensates it and store in the device structure.
+ */
+static s8 get_calib_data(struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_CALIB_DATA;
+	/* Array to store calibration data */
+	u8 calib_data[BMP3_LEN_CALIB_DATA] = { 0 };
+
+	/* Read the calibration data from the sensor */
+	rslt = bmp3_get_regs(reg_addr, calib_data, BMP3_LEN_CALIB_DATA, dev);
+
+	/* Parse calibration data and store it in device structure */
+	parse_calib_data(calib_data, dev);
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API interleaves the register address between the
+ * register data buffer for burst write operation.
+ */
+static void interleave_reg_addr(const u8 *reg_addr, u8 *temp_buff,
+				const u8 *reg_data, u32 len)
+{
+	u32 index;
+
+	for (index = 1; index < len; index++) {
+		temp_buff[(index * 2) - 1] = reg_addr[index];
+		temp_buff[index * 2] = reg_data[index];
+	}
+}
+
+/*!
+ * @brief This internal API parse the power control(power mode, pressure enable
+ * and temperature enable), over sampling, ODR, filter, interrupt control and
+ * advance settings and store in the device structure.
+ */
+static void parse_sett_data(const u8 *reg_data, struct bmp3_settings *settings)
+{
+	/* Parse interrupt control settings and store in device structure */
+	parse_int_ctrl_settings(&reg_data[0], &settings->int_settings);
+
+	/* Parse advance settings and store in device structure */
+	parse_advance_settings(&reg_data[1], &settings->adv_settings);
+
+	/* Parse power control settings and store in device structure */
+	parse_pwr_ctrl_settings(&reg_data[2], settings);
+
+	/* Parse ODR and filter settings and store in device structure */
+	parse_odr_filter_settings(&reg_data[3], &settings->odr_filter);
+}
+
+/*!
+ * @brief This internal API parse the interrupt control(output mode, level,
+ * latch and data ready) settings and store in the device structure.
+ */
+static void parse_int_ctrl_settings(const u8 *reg_data,
+				    struct bmp3_int_ctrl_settings *settings)
+{
+	settings->output_mode = BMP3_GET_BITS_POS_0(*reg_data,
+						    BMP3_INT_OUTPUT_MODE);
+	settings->level = BMP3_GET_BITS(*reg_data, BMP3_INT_LEVEL);
+	settings->latch = BMP3_GET_BITS(*reg_data, BMP3_INT_LATCH);
+	settings->drdy_en = BMP3_GET_BITS(*reg_data, BMP3_INT_DRDY_EN);
+}
+
+static void parse_advance_settings(const u8 *reg_data,
+				   struct bmp3_adv_settings *settings)
+{
+	settings->i2c_wdt_en = BMP3_GET_BITS(*reg_data, BMP3_I2C_WDT_EN);
+	settings->i2c_wdt_sel = BMP3_GET_BITS(*reg_data, BMP3_I2C_WDT_SEL);
+}
+
+/*!
+ * @brief This internal API parse the power control(power mode, pressure enable
+ * and temperature enable) settings and store in the device structure.
+ */
+static void  parse_pwr_ctrl_settings(const u8 *reg_data,
+				     struct bmp3_settings *settings)
+{
+	settings->op_mode = BMP3_GET_BITS(*reg_data, BMP3_OP_MODE);
+	settings->press_en = BMP3_GET_BITS_POS_0(*reg_data, BMP3_PRESS_EN);
+	settings->temp_en = BMP3_GET_BITS(*reg_data, BMP3_TEMP_EN);
+}
+
+/*!
+ * @brief This internal API parse the over sampling, ODR and filter
+ * settings and store in the device structure.
+ */
+static void  parse_odr_filter_settings(const u8 *reg_data,
+				       struct bmp3_odr_filter_settings *settings)
+{
+	u8 index = 0;
+
+	/* ODR and filter settings index starts from one (0x1C register) */
+	settings->press_os = BMP3_GET_BITS_POS_0(reg_data[index], BMP3_PRESS_OS);
+	settings->temp_os = BMP3_GET_BITS(reg_data[index], BMP3_TEMP_OS);
+
+	/* Move index to 0x1D register */
+	index++;
+	settings->odr = BMP3_GET_BITS_POS_0(reg_data[index], BMP3_ODR);
+
+	/* Move index to 0x1F register */
+	index = index + 2;
+	settings->iir_filter = BMP3_GET_BITS(reg_data[index], BMP3_IIR_FILTER);
+}
+
+/*!
+ * @brief This API sets the pressure enable and temperature enable
+ * settings of the sensor.
+ */
+static s8 set_pwr_ctrl_settings(u32 desired_settings,
+				const struct bmp3_settings *settings,
+				struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_PWR_CTRL;
+	u8 reg_data;
+
+	rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+	if (rslt == BMP3_OK) {
+		if (desired_settings & BMP3_SEL_PRESS_EN) {
+			/* Set the pressure enable settings in the
+			 * register variable
+			 */
+			reg_data = BMP3_SET_BITS_POS_0(reg_data, BMP3_PRESS_EN,
+						       settings->press_en);
+		}
+
+		if (desired_settings & BMP3_SEL_TEMP_EN) {
+			/* Set the temperature enable settings in the
+			 * register variable
+			 */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_TEMP_EN,
+						 settings->temp_en);
+		}
+
+		/* Write the power control settings in the register */
+		rslt = bmp3_set_regs(&reg_addr, &reg_data, 1, dev);
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API sets the over sampling, ODR and filter settings
+ * of the sensor based on the settings selected by the user.
+ */
+static s8 set_odr_filter_settings(u32 desired_settings,
+				  struct bmp3_settings *settings,
+				  struct bmp3_dev *dev)
+{
+	s8 rslt;
+	/* No of registers to be configured is 3*/
+	u8 reg_addr[3] = { 0 };
+	/* No of register data to be read is 4 */
+	u8 reg_data[4];
+	u8 len = 0;
+
+	rslt = bmp3_get_regs(BMP3_REG_OSR, reg_data, 4, dev);
+	if (rslt == BMP3_OK) {
+		/* Fill the over sampling register address and
+		 * register data to be written in the sensor
+		 */
+		if (are_settings_changed((BMP3_SEL_PRESS_OS | BMP3_SEL_TEMP_OS),
+					 desired_settings))
+			fill_osr_data(desired_settings, reg_addr, reg_data, &len,
+				      settings);
+
+		if (are_settings_changed(BMP3_SEL_ODR, desired_settings)) {
+			/* Fill the output data rate register address and
+			 * register data to be written in the sensor
+			 */
+			fill_odr_data(reg_addr, reg_data, &len, settings);
+		}
+		if (are_settings_changed(BMP3_SEL_IIR_FILTER, desired_settings)) {
+			/* Fill the iir filter register address and
+			 * register data to be written in the sensor
+			 */
+			fill_filter_data(reg_addr, reg_data, &len, settings);
+		}
+
+		if (settings->op_mode == BMP3_MODE_NORMAL) {
+			/* For normal mode, OSR and ODR settings should
+			 * be proper
+			 */
+			rslt = validate_osr_and_odr_settings(settings);
+		}
+
+		if (rslt == BMP3_OK) {
+			/* Burst write the over sampling, ODR and filter
+			 * settings in the register
+			 */
+			rslt = bmp3_set_regs(reg_addr, reg_data, len, dev);
+		}
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This internal API sets the interrupt control (output mode, level,
+ * latch and data ready) settings of the sensor based on the settings
+ * selected by the user.
+ */
+static s8 set_int_ctrl_settings(u32 desired_settings,
+				const struct bmp3_settings *settings,
+				struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_data;
+	u8 reg_addr;
+	struct bmp3_int_ctrl_settings int_settings;
+
+	reg_addr = BMP3_REG_INT_CTRL;
+	rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+
+	if (rslt == BMP3_OK) {
+		int_settings = settings->int_settings;
+
+		if (desired_settings & BMP3_SEL_OUTPUT_MODE) {
+			/* Set the interrupt output mode bits */
+			reg_data = BMP3_SET_BITS_POS_0(reg_data, BMP3_INT_OUTPUT_MODE,
+						       int_settings.output_mode);
+		}
+
+		if (desired_settings & BMP3_SEL_LEVEL) {
+			/* Set the interrupt level bits */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_INT_LEVEL,
+						 int_settings.level);
+		}
+
+		if (desired_settings & BMP3_SEL_LATCH) {
+			/* Set the interrupt latch bits */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_INT_LATCH,
+						 int_settings.latch);
+		}
+
+		if (desired_settings & BMP3_SEL_DRDY_EN) {
+			/* Set the interrupt data ready bits */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_INT_DRDY_EN,
+						 int_settings.drdy_en);
+		}
+		rslt = bmp3_set_regs(&reg_addr, &reg_data, 1, dev);
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API sets the advance (i2c_wdt_en, i2c_wdt_sel)
+ * settings of the sensor based on the settings selected by the user.
+ */
+static s8 set_advance_settings(u32 desired_settings,
+			       const struct bmp3_settings *settings,
+			       struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr;
+	u8 reg_data;
+	struct bmp3_adv_settings adv_settings = settings->adv_settings;
+
+	reg_addr = BMP3_REG_IF_CONF;
+	rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+
+	if (rslt == BMP3_OK) {
+		if (desired_settings & BMP3_SEL_I2C_WDT_EN) {
+			/* Set the i2c watch dog enable bits */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_I2C_WDT_EN,
+						 adv_settings.i2c_wdt_en);
+		}
+
+		if (desired_settings & BMP3_SEL_I2C_WDT) {
+			/* Set the i2c watch dog select bits */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_I2C_WDT_SEL,
+						 adv_settings.i2c_wdt_sel);
+		}
+
+		rslt = bmp3_set_regs(&reg_addr, &reg_data, 1, dev);
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This internal API gets the over sampling, ODR and filter settings
+ * of the sensor.
+ */
+static s8 get_odr_filter_settings(struct bmp3_settings *settings,
+				  struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_data[4];
+
+	/* Read data beginning from 0x1C register */
+	rslt = bmp3_get_regs(BMP3_REG_OSR, reg_data, 4, dev);
+
+	/* Parse the read data and store it in dev structure */
+	parse_odr_filter_settings(reg_data, &settings->odr_filter);
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API validate the over sampling, ODR settings of the
+ * sensor.
+ */
+static s8 validate_osr_and_odr_settings(const struct bmp3_settings *settings)
+{
+	s8 rslt;
+	/*
+	 * According to BMP388 datasheet at Section 3.9.2. "Measurement rate in
+	 * forced mode and normal mode" there is also the constant of 234us also to
+	 * be considered in the sum.
+	 */
+	u32 meas_t = 234;
+	u32 meas_t_p = 0;
+	/* Sampling period corresponding to ODR in microseconds  */
+	u32 odr[18] = {
+		5000, 10000, 20000, 40000, 80000, 160000, 320000,
+		640000, 1280000, 2560000, 5120000, 10240000, 20480000,
+		40960000, 81920000, 163840000, 327680000, 655360000
+		};
+
+	if (settings->press_en) {
+		/* Calculate the pressure measurement duration */
+		meas_t_p += calculate_press_meas_time(settings);
+	}
+
+	if (settings->temp_en) {
+		/* Calculate the temperature measurement duration */
+		meas_t_p += calculate_temp_meas_time(settings);
+	}
+	/* Constant 234us added to the summation of temperature
+	 * Constant 234us added to the summation of temperature
+	 */
+	meas_t += meas_t_p;
+
+	rslt = verify_meas_time_and_odr_duration(meas_t,
+						 odr[settings->odr_filter.odr]);
+	return rslt;
+}
+
+/*!
+ * @brief This internal API checks whether the measurement time and ODR
+ * duration of the sensor are proper.
+ */
+static s8 verify_meas_time_and_odr_duration(u32 meas_t, u32 odr_duration)
+{
+	s8 rslt;
+
+	if (meas_t < odr_duration) {
+		/* If measurement duration is less than ODR duration
+		 * then OSR and ODR settings are fine
+		 */
+		rslt = BMP3_OK;
+	} else {
+		/* OSR and ODR settings are not proper */
+		rslt = BMP3_E_INVALID_ODR_OSR_SETTINGS;
+	}
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API calculates the pressure measurement duration of the
+ * sensor.
+ */
+static u32 calculate_press_meas_time(const struct bmp3_settings *settings)
+{
+	u32 press_meas_t;
+	struct bmp3_odr_filter_settings odr_filter = settings->odr_filter;
+#ifdef BMP3_FLOAT_COMPENSATION
+	double base = 2.0;
+	float partial_out;
+#else
+	u8 base = 2;
+	u32 partial_out;
+#endif /* BMP3_FLOAT_COMPENSATION */
+
+	partial_out = pow_bmp3(base, odr_filter.press_os);
+	press_meas_t =
+	(uint32_t)(BMP3_SETTLE_TIME_PRESS + partial_out * BMP3_ADC_CONV_TIME);
+
+	/* Output in microseconds */
+	return press_meas_t;
+}
+
+/*!
+ * @brief This internal API calculates the temperature measurement duration of
+ * the sensor.
+ */
+static u32 calculate_temp_meas_time(const struct bmp3_settings *settings)
+{
+	u32 temp_meas_t;
+	struct bmp3_odr_filter_settings odr_filter = settings->odr_filter;
+#ifdef BMP3_FLOAT_COMPENSATION
+	double base = 2.0;
+	float partial_out;
+#else
+	u8 base = 2;
+	u32 partial_out;
+#endif /* BMP3_FLOAT_COMPENSATION */
+
+	partial_out = pow_bmp3(base, odr_filter.temp_os);
+	temp_meas_t =
+	(uint32_t)(BMP3_SETTLE_TIME_TEMP + partial_out * BMP3_ADC_CONV_TIME);
+
+	/* Output in u32 */
+	return temp_meas_t;
+}
+
+/*!
+ * @brief This internal API fills the register address and register data of
+ * the over sampling settings for burst write operation.
+ */
+static void fill_osr_data(u32 desired_settings,
+			  u8 *addr,
+			  u8 *reg_data,
+			  u8 *len,
+			  const struct bmp3_settings *settings)
+{
+	struct bmp3_odr_filter_settings osr_settings = settings->odr_filter;
+
+	if (desired_settings & (BMP3_SEL_PRESS_OS | BMP3_SEL_TEMP_OS)) {
+		/* Pressure over sampling settings check */
+		if (desired_settings & BMP3_SEL_PRESS_OS) {
+			/* Set the pressure over sampling settings in the
+			 * register variable
+			 */
+			reg_data[*len] = BMP3_SET_BITS_POS_0(reg_data[0], BMP3_PRESS_OS,
+							     osr_settings.press_os);
+		}
+
+		/* Temperature over sampling settings check */
+		if (desired_settings & BMP3_SEL_TEMP_OS) {
+			/* Set the temperature over sampling settings in the
+			 * register variable
+			 */
+			reg_data[*len] = BMP3_SET_BITS(reg_data[0], BMP3_TEMP_OS,
+						       osr_settings.temp_os);
+		}
+
+		/* 0x1C is the register address of over sampling register */
+		addr[*len] = BMP3_REG_OSR;
+		(*len)++;
+	}
+}
+
+/*!
+ * @brief This internal API fills the register address and register data of
+ * the ODR settings for burst write operation.
+ */
+static void fill_odr_data(u8 *addr, u8 *reg_data, u8 *len,
+			  struct bmp3_settings *settings)
+{
+	struct bmp3_odr_filter_settings *osr_settings = &settings->odr_filter;
+
+	/* Limit the ODR to 0.001525879 Hz*/
+	if (osr_settings->odr > BMP3_ODR_0_001_HZ)
+		osr_settings->odr = BMP3_ODR_0_001_HZ;
+
+	/* Set the ODR settings in the register variable */
+	reg_data[*len] = BMP3_SET_BITS_POS_0(reg_data[1], BMP3_ODR,
+					     osr_settings->odr);
+	/* 0x1D is the register address of output data rate register */
+	addr[*len] = BMP3_REG_ODR;
+	(*len)++;
+}
+
+/*!
+ * @brief This internal API fills the register address and register data of
+ * the filter settings for burst write operation.
+ */
+static void fill_filter_data(u8 *addr, u8 *reg_data, u8 *len,
+			     const struct bmp3_settings *settings)
+{
+	struct bmp3_odr_filter_settings osr_settings = settings->odr_filter;
+
+	/* Set the iir settings in the register variable */
+	reg_data[*len] = BMP3_SET_BITS(reg_data[3],
+				       BMP3_IIR_FILTER,
+				       osr_settings.iir_filter);
+
+	/* 0x1F is the register address of iir filter register */
+	addr[*len] = BMP3_REG_CONFIG;
+	(*len)++;
+}
+
+/*!
+ *  @brief This internal API is used to parse the pressure or temperature or
+ *  both the data and store it in the bmp3_uncomp_data structure instance.
+ */
+static void parse_sensor_data(const u8 *reg_data,
+			      struct bmp3_uncomp_data *uncomp_data)
+{
+	/* Temporary variables to store the sensor data */
+	u32 data_xlsb;
+	u32 data_lsb;
+	u32 data_msb;
+
+	/* Store the parsed register values for pressure data */
+	data_xlsb = (uint32_t)reg_data[0];
+	data_lsb = (uint32_t)reg_data[1] << 8;
+	data_msb = (uint32_t)reg_data[2] << 16;
+	uncomp_data->pressure = data_msb | data_lsb | data_xlsb;
+
+	/* Store the parsed register values for temperature data */
+	data_xlsb = (uint32_t)reg_data[3];
+	data_lsb = (uint32_t)reg_data[4] << 8;
+	data_msb = (uint32_t)reg_data[5] << 16;
+	uncomp_data->temperature = data_msb | data_lsb | data_xlsb;
+}
+
+/*!
+ * @brief This internal API is used to compensate the pressure or temperature
+ * or both the data according to the component selected by the user.
+ */
+static s8 compensate_data(u8 sensor_comp,
+			  const struct bmp3_uncomp_data *uncomp_data,
+			  struct bmp3_data *comp_data,
+			  struct bmp3_calib_data *calib_data)
+{
+	s8 rslt = BMP3_OK;
+
+	if (uncomp_data && comp_data && calib_data) {
+		/* If pressure and temperature component is selected */
+		if (sensor_comp == BMP3_PRESS_TEMP) {
+			/*
+			 * NOTE : Temperature compensation must be done first.
+			 * Followed by pressure compensation
+			 * Compensated temperature updated in calib structure,
+			 * is needed for pressure calculation
+			 */
+			/* Compensate pressure and temperature data */
+			rslt = compensate_temperature(&comp_data->temperature,
+						      uncomp_data, calib_data);
+
+			if (rslt == BMP3_OK)
+				rslt = compensate_pressure(&comp_data->pressure,
+							   uncomp_data, calib_data);
+		} else if (sensor_comp == BMP3_PRESS) {
+			/*
+			 * NOTE : Temperature compensation must be done first.
+			 * Followed by pressure compensation
+			 * Compensated temperature updated in calib structure,
+			 * is needed for pressure calculation.
+			 * As only pressure is enabled in 'sensor_comp', after calculating
+			 * compensated temperature, assign it to zero.
+			 */
+			(void)compensate_temperature(&comp_data->temperature,
+						     uncomp_data, calib_data);
+			comp_data->temperature = 0;
+
+			/* Compensate the pressure data */
+			rslt = compensate_pressure(&comp_data->pressure,
+						   uncomp_data,
+						   calib_data);
+		} else if (sensor_comp == BMP3_TEMP) {
+			/* Compensate the temperature data */
+			rslt = compensate_temperature(&comp_data->temperature,
+						      uncomp_data, calib_data);
+
+			/*
+			 * As only temperature is enabled in 'sensor_comp'
+			 * make compensated pressure as zero
+			 */
+			comp_data->pressure = 0;
+		} else {
+			comp_data->pressure = 0;
+			comp_data->temperature = 0;
+		}
+	} else {
+		rslt = BMP3_E_NULL_PTR;
+	}
+	return rslt;
+}
+
+#ifdef BMP3_FLOAT_COMPENSATION
+/*!
+ *  @brief This internal API is used to parse the calibration data, compensates
+ *  it and store it in device structure
+ */
+static void parse_calib_data(const u8 *reg_data, struct bmp3_dev *dev)
+{
+	/* Temporary variable to store the aligned trim data */
+	struct bmp3_reg_calib_data *reg_calib_data =
+		&dev->calib_data.reg_calib_data;
+	struct bmp3_quantized_calib_data *quantized_calib_data =
+					 &dev->calib_data.quantized_calib_data;
+	/* Temporary variable */
+	double temp_var;
+
+	/* 1 / 2^8 */
+	temp_var = 0.00390625f;
+	reg_calib_data->par_t1 = BMP3_CONCAT_BYTES(reg_data[1], reg_data[0]);
+	quantized_calib_data->par_t1 = ((double)reg_calib_data->par_t1 / temp_var);
+	reg_calib_data->par_t2 = BMP3_CONCAT_BYTES(reg_data[3], reg_data[2]);
+	temp_var = 1073741824.0f;
+	quantized_calib_data->par_t2 = ((double)reg_calib_data->par_t2 / temp_var);
+	reg_calib_data->par_t3 = (int8_t)reg_data[4];
+	temp_var = 281474976710656.0f;
+	quantized_calib_data->par_t3 = ((double)reg_calib_data->par_t3 / temp_var);
+	reg_calib_data->par_p1 =
+		(int16_t)BMP3_CONCAT_BYTES(reg_data[6], reg_data[5]);
+	temp_var = 1048576.0f;
+	quantized_calib_data->par_p1 =
+		((double)(reg_calib_data->par_p1 - (16384)) / temp_var);
+	reg_calib_data->par_p2 =
+		(int16_t)BMP3_CONCAT_BYTES(reg_data[8], reg_data[7]);
+	temp_var = 536870912.0f;
+	quantized_calib_data->par_p2 =
+		((double)(reg_calib_data->par_p2 - (16384)) / temp_var);
+	reg_calib_data->par_p3 = (int8_t)reg_data[9];
+	temp_var = 4294967296.0f;
+	quantized_calib_data->par_p3 = ((double)reg_calib_data->par_p3 / temp_var);
+	reg_calib_data->par_p4 = (int8_t)reg_data[10];
+	temp_var = 137438953472.0f;
+	quantized_calib_data->par_p4 = ((double)reg_calib_data->par_p4 / temp_var);
+	reg_calib_data->par_p5 = BMP3_CONCAT_BYTES(reg_data[12], reg_data[11]);
+
+	/* 1 / 2^3 */
+	temp_var = 0.125f;
+	quantized_calib_data->par_p5 = ((double)reg_calib_data->par_p5 / temp_var);
+	reg_calib_data->par_p6 = BMP3_CONCAT_BYTES(reg_data[14], reg_data[13]);
+	temp_var = 64.0f;
+	quantized_calib_data->par_p6 = ((double)reg_calib_data->par_p6 / temp_var);
+	reg_calib_data->par_p7 = (int8_t)reg_data[15];
+	temp_var = 256.0f;
+	quantized_calib_data->par_p7 = ((double)reg_calib_data->par_p7 / temp_var);
+	reg_calib_data->par_p8 = (int8_t)reg_data[16];
+	temp_var = 32768.0f;
+	quantized_calib_data->par_p8 = ((double)reg_calib_data->par_p8 / temp_var);
+	reg_calib_data->par_p9 =
+	(int16_t)BMP3_CONCAT_BYTES(reg_data[18], reg_data[17]);
+	temp_var = 281474976710656.0f;
+	quantized_calib_data->par_p9 = ((double)reg_calib_data->par_p9 / temp_var);
+	reg_calib_data->par_p10 = (int8_t)reg_data[19];
+	temp_var = 281474976710656.0f;
+	quantized_calib_data->par_p10 =
+	((double)reg_calib_data->par_p10 / temp_var);
+	reg_calib_data->par_p11 = (int8_t)reg_data[20];
+	temp_var = 36893488147419103232.0f;
+	quantized_calib_data->par_p11 =
+	((double)reg_calib_data->par_p11 / temp_var);
+}
+
+/*!
+ * @brief This internal API is used to compensate the raw temperature data and
+ * return the compensated temperature data in double data type.
+ * Returns temperature (deg Celsius) in double.
+ * For e.g. Returns temperature 24.26 deg Celsius
+ */
+static s8 compensate_temperature(double *temperature,
+				 const struct bmp3_uncomp_data *uncomp_data,
+				 struct bmp3_calib_data *calib_data)
+{
+	s8 rslt = BMP3_OK;
+	s64 uncomp_temp = uncomp_data->temperature;
+	double partial_data1;
+	double partial_data2;
+
+	partial_data1 =
+	(double)(uncomp_temp - calib_data->quantized_calib_data.par_t1);
+	partial_data2 =
+	(double)(partial_data1 * calib_data->quantized_calib_data.par_t2);
+	/*
+	 * Update the compensated temperature in calib structure since this is
+	 * needed for pressure calculation
+	 */
+	calib_data->quantized_calib_data.t_lin = partial_data2 +
+						(partial_data1 * partial_data1) *
+						calib_data->quantized_calib_data.par_t3;
+	/* Returns compensated temperature */
+	if (calib_data->quantized_calib_data.t_lin < BMP3_MIN_TEMP_DOUBLE) {
+		calib_data->quantized_calib_data.t_lin = BMP3_MIN_TEMP_DOUBLE;
+		rslt = BMP3_W_MIN_TEMP;
+	}
+	if (calib_data->quantized_calib_data.t_lin > BMP3_MAX_TEMP_DOUBLE) {
+		calib_data->quantized_calib_data.t_lin = BMP3_MAX_TEMP_DOUBLE;
+		rslt = BMP3_W_MAX_TEMP;
+	}
+
+	(*temperature) = calib_data->quantized_calib_data.t_lin;
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API is used to compensate the raw pressure data and
+ * return the compensated pressure data in double data type.
+ * For e.g. returns pressure in Pascal p = 95305.295
+ */
+static s8 compensate_pressure(double *pressure,
+			      const struct bmp3_uncomp_data *uncomp_data,
+			      const struct bmp3_calib_data *calib_data)
+{
+	s8 rslt = BMP3_OK;
+	const struct bmp3_quantized_calib_data *quantized_calib_data =
+						&calib_data->quantized_calib_data;
+	/* Variable to store the compensated pressure */
+	double comp_press;
+	/* Temporary variables used for compensation */
+	double partial_data1;
+	double partial_data2;
+	double partial_data3;
+	double partial_data4;
+	double partial_out1;
+	double partial_out2;
+
+	partial_data1 = quantized_calib_data->par_p6 * quantized_calib_data->t_lin;
+	partial_data2 =
+	quantized_calib_data->par_p7 * pow_bmp3(quantized_calib_data->t_lin, 2);
+	partial_data3 =
+	quantized_calib_data->par_p8 * pow_bmp3(quantized_calib_data->t_lin, 3);
+	partial_out1 =
+	quantized_calib_data->par_p5 + partial_data1 +
+	partial_data2 + partial_data3;
+	partial_data1 = quantized_calib_data->par_p2 * quantized_calib_data->t_lin;
+	partial_data2 =
+	quantized_calib_data->par_p3 * pow_bmp3(quantized_calib_data->t_lin, 2);
+	partial_data3 =
+	quantized_calib_data->par_p4 * pow_bmp3(quantized_calib_data->t_lin, 3);
+	partial_out2 =
+		uncomp_data->pressure * (quantized_calib_data->par_p1 + partial_data1 +
+				   partial_data2 + partial_data3);
+	partial_data1 = pow_bmp3((double)uncomp_data->pressure, 2);
+	partial_data2 = quantized_calib_data->par_p9 +
+					quantized_calib_data->par_p10 *
+					quantized_calib_data->t_lin;
+	partial_data3 = partial_data1 * partial_data2;
+	partial_data4 =
+		partial_data3 + pow_bmp3((double)uncomp_data->pressure, 3) *
+					quantized_calib_data->par_p11;
+	comp_press = partial_out1 + partial_out2 + partial_data4;
+
+	if (comp_press < BMP3_MIN_PRES_DOUBLE) {
+		comp_press = BMP3_MIN_PRES_DOUBLE;
+		rslt = BMP3_W_MIN_PRES;
+	}
+
+	if (comp_press > BMP3_MAX_PRES_DOUBLE) {
+		comp_press = BMP3_MAX_PRES_DOUBLE;
+		rslt = BMP3_W_MAX_PRES;
+	}
+
+	(*pressure) = comp_press;
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API is used to calculate the power functionality for
+ *  floating point values.
+ */
+static float pow_bmp3(double base, u8 power)
+{
+	float pow_output = 1;
+
+	while (power != 0) {
+		pow_output = (float)base * pow_output;
+		power--;
+	}
+
+	return pow_output;
+}
+#else
+/*!
+ *  @brief This internal API is used to parse the calibration data, compensates
+ *  it and store it in device structure
+ */
+static void parse_calib_data(const u8 *reg_data, struct bmp3_dev *dev)
+{
+	/* Temporary variable to store the aligned trim data */
+	struct bmp3_reg_calib_data *reg_calib_data =
+		&dev->calib_data.reg_calib_data;
+
+	reg_calib_data->par_t1 = BMP3_CONCAT_BYTES(reg_data[1], reg_data[0]);
+	reg_calib_data->par_t2 = BMP3_CONCAT_BYTES(reg_data[3], reg_data[2]);
+	reg_calib_data->par_t3 = (int8_t)reg_data[4];
+	reg_calib_data->par_p1 =
+		(int16_t)BMP3_CONCAT_BYTES(reg_data[6], reg_data[5]);
+	reg_calib_data->par_p2 =
+		(int16_t)BMP3_CONCAT_BYTES(reg_data[8], reg_data[7]);
+	reg_calib_data->par_p3 = (int8_t)reg_data[9];
+	reg_calib_data->par_p4 = (int8_t)reg_data[10];
+	reg_calib_data->par_p5 = BMP3_CONCAT_BYTES(reg_data[12], reg_data[11]);
+	reg_calib_data->par_p6 = BMP3_CONCAT_BYTES(reg_data[14], reg_data[13]);
+	reg_calib_data->par_p7 = (int8_t)reg_data[15];
+	reg_calib_data->par_p8 = (int8_t)reg_data[16];
+	reg_calib_data->par_p9 =
+		(int16_t)BMP3_CONCAT_BYTES(reg_data[18], reg_data[17]);
+	reg_calib_data->par_p10 = (int8_t)reg_data[19];
+	reg_calib_data->par_p11 = (int8_t)reg_data[20];
+}
+
+/*!
+ * @brief This internal API is used to compensate the raw temperature data and
+ * return the compensated temperature data in integer data type.
+ * Returns temperature in integer. Actual temperature is obtained
+ * by dividing by 100
+ * For eg : If returned temperature is 2426 then it is 2426/100 = 24 degCelsius
+ */
+static s8 compensate_temperature(s64 *temperature,
+				 const struct bmp3_uncomp_data *uncomp_data,
+				 struct bmp3_calib_data *calib_data)
+{
+	s8 rslt = BMP3_OK;
+	s64 partial_data1;
+	s64 partial_data2;
+	s64 partial_data3;
+	s64 partial_data4;
+	s64 partial_data5;
+	s64 partial_data6;
+	s64 comp_temp;
+
+	partial_data1 = (int64_t)(uncomp_data->temperature -
+					((int64_t)256 * calib_data->reg_calib_data.par_t1));
+	partial_data2 =
+		(int64_t)(calib_data->reg_calib_data.par_t2 * partial_data1);
+	partial_data3 = (int64_t)(partial_data1 * partial_data1);
+	partial_data4 = (int64_t)partial_data3 * calib_data->reg_calib_data.par_t3;
+	partial_data5 =
+		(int64_t)((int64_t)(partial_data2 * 262144) + partial_data4);
+	partial_data6 = (int64_t)(partial_data5 / 4294967296);
+
+	/* Store t_lin in dev. structure for pressure calculation */
+	calib_data->reg_calib_data.t_lin = (int64_t)partial_data6;
+	comp_temp = (int64_t)((partial_data6 * 25) / 16384);
+
+	if (comp_temp < BMP3_MIN_TEMP_INT) {
+		comp_temp = BMP3_MIN_TEMP_INT;
+		rslt = BMP3_W_MIN_TEMP;
+	}
+
+	if (comp_temp > BMP3_MAX_TEMP_INT) {
+		comp_temp = BMP3_MAX_TEMP_INT;
+		rslt = BMP3_W_MAX_TEMP;
+	}
+
+	(*temperature) = comp_temp;
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API is used to compensate the raw pressure data and
+ * return the compensated pressure data in integer data type.
+ * for eg return if pressure is 9528709 which is 9528709/100 = 95287.09 Pascal
+ */
+static s8 compensate_pressure(u64 *pressure,
+			      const struct bmp3_uncomp_data *uncomp_data,
+			      const struct bmp3_calib_data *calib_data)
+{
+	s8 rslt = BMP3_OK;
+	const struct bmp3_reg_calib_data *reg_calib_data =
+					&calib_data->reg_calib_data;
+	s64 partial_data1;
+	s64 partial_data2;
+	s64 partial_data3;
+	s64 partial_data4;
+	s64 partial_data5;
+	s64 partial_data6;
+	s64 offset;
+	s64 sensitivity;
+	u64 comp_press;
+	s64 temp;
+
+	partial_data1 = (int64_t)(reg_calib_data->t_lin * reg_calib_data->t_lin);
+	partial_data2 = (int64_t)(partial_data1 / 64);
+	partial_data3 = (int64_t)((partial_data2 * reg_calib_data->t_lin) / 256);
+	partial_data4 = (int64_t)((reg_calib_data->par_p8 * partial_data3) / 32);
+	partial_data5 = (int64_t)((reg_calib_data->par_p7 * partial_data1) * 16);
+	partial_data6 =
+		(int64_t)((reg_calib_data->par_p6 * reg_calib_data->t_lin) * 4194304);
+	offset = (int64_t)((reg_calib_data->par_p5 * 140737488355328) +
+						partial_data4 + partial_data5 + partial_data6);
+	partial_data2 = (int64_t)((reg_calib_data->par_p4 * partial_data3) / 32);
+	partial_data4 = (int64_t)((reg_calib_data->par_p3 * partial_data1) * 4);
+	partial_data5 = (int64_t)((reg_calib_data->par_p2 - (int32_t)16384) *
+			 reg_calib_data->t_lin * 2097152);
+	sensitivity =
+	(int64_t)(((reg_calib_data->par_p1 - (int32_t)16384) * 70368744177664) +
+		 partial_data2 + partial_data4 + partial_data5);
+	partial_data1 =
+		(int64_t)((sensitivity / 16777216) * uncomp_data->pressure);
+	partial_data2 = (int64_t)(reg_calib_data->par_p10 * reg_calib_data->t_lin);
+	partial_data3 =
+		(int64_t)(partial_data2 + ((int32_t)65536 * reg_calib_data->par_p9));
+	partial_data4 =
+		(int64_t)((partial_data3 * uncomp_data->pressure) / (int32_t)8192);
+
+	/*
+	 * dividing by 10 followed by multiplying by 10
+	 * To avoid overflow caused by (uncomp_data->pressure * partial_data4)
+	 */
+	temp = div_s64(partial_data4, 10);
+	partial_data5 =
+		(int64_t)((int64_t)temp * (uint64_t)uncomp_data->pressure) / 512;
+	partial_data5 = (int64_t)(partial_data5 * 10);
+	partial_data6 = (int64_t)(uncomp_data->pressure * uncomp_data->pressure);
+	partial_data2 =
+		(int64_t)((reg_calib_data->par_p11 * partial_data6) / (int32_t)65536);
+	partial_data3 = (int64_t)((int64_t)
+					(partial_data2 * uncomp_data->pressure) / 128);
+	partial_data4 = (int64_t)((offset / 4) + partial_data1 +
+					partial_data5 + partial_data3);
+	comp_press = (((uint64_t)partial_data4 * 25) / (uint64_t)1099511627776);
+
+	if (comp_press < BMP3_MIN_PRES_INT) {
+		comp_press = BMP3_MIN_PRES_INT;
+		rslt = BMP3_W_MIN_PRES;
+	}
+	if (comp_press > BMP3_MAX_PRES_INT) {
+		comp_press = BMP3_MAX_PRES_INT;
+		rslt = BMP3_W_MAX_PRES;
+	}
+
+	(*pressure) = comp_press;
+
+	return rslt;
+}
+
+/*!
+ * @brief This internal API is used to calculate the power functionality.
+ */
+static u32 pow_bmp3(u8 base, u8 power)
+{
+	u32 pow_output = 1;
+
+	while (power != 0) {
+		pow_output = base * pow_output;
+		power--;
+	}
+	return pow_output;
+}
+#endif
+/*!
+ * @brief This internal API is used to identify the settings which the user
+ * wants to modify in the sensor.
+ */
+static u8 are_settings_changed(u32 sub_settings, u32 desired_settings)
+{
+	u8 settings_changed = FALSE;
+
+	if (sub_settings & desired_settings) {
+		/* User wants to modify this particular settings */
+		settings_changed = TRUE;
+	} else {
+		/* User don't want to modify this particular settings */
+		settings_changed = FALSE;
+	}
+	return settings_changed;
+}
+
+/*!
+ * @brief This internal API is used to validate the device structure pointer
+ * for null conditions.
+ */
+static s8 null_ptr_check(const struct bmp3_dev *dev)
+{
+	s8 rslt = 0;
+
+	if (!dev || !dev->read || !dev->write || !dev->delay_us) {
+		/* Device structure pointer is not valid */
+		rslt = BMP3_E_NULL_PTR;
+	} else {
+		/* Device structure is fine */
+		rslt = BMP3_OK;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This internal API is used to parse the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en),
+ * fifo_config_2(fifo_subsampling, data_select) and int_ctrl(fwtm_en, ffull_en)
+ * settings and store it in device structure
+ */
+static void parse_fifo_settings(const u8 *reg_data,
+				struct bmp3_fifo_settings *fifo_settings)
+{
+	u8 fifo_config_1_data = reg_data[0];
+	u8 fifo_config_2_data = reg_data[1];
+	u8 fifo_int_ctrl_data = reg_data[2];
+
+	/* Parse fifo config 1 register data */
+	fifo_settings->mode = BMP3_GET_BITS_POS_0(fifo_config_1_data,
+						  BMP3_FIFO_MODE);
+	fifo_settings->stop_on_full_en = BMP3_GET_BITS(fifo_config_1_data,
+						       BMP3_FIFO_STOP_ON_FULL);
+	fifo_settings->time_en = BMP3_GET_BITS(fifo_config_1_data,
+					       BMP3_FIFO_TIME_EN);
+	fifo_settings->press_en = BMP3_GET_BITS(fifo_config_1_data,
+						BMP3_FIFO_PRESS_EN);
+	fifo_settings->temp_en = BMP3_GET_BITS(fifo_config_1_data,
+					       BMP3_FIFO_TEMP_EN);
+
+	/* Parse fifo config 2 register data */
+	fifo_settings->down_sampling = BMP3_GET_BITS_POS_0(fifo_config_2_data,
+							   BMP3_FIFO_DOWN_SAMPLING);
+	fifo_settings->filter_en = BMP3_GET_BITS(fifo_config_2_data,
+						 BMP3_FIFO_FILTER_EN);
+
+	/* Parse fifo related interrupt control data */
+	fifo_settings->ffull_en = BMP3_GET_BITS(fifo_int_ctrl_data,
+						BMP3_FIFO_FULL_EN);
+	fifo_settings->fwtm_en = BMP3_GET_BITS(fifo_int_ctrl_data,
+					       BMP3_FIFO_FWTM_EN);
+}
+
+/*!
+ * @brief This internal API fills the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en) settings in the
+ * reg_data variable so as to burst write in the sensor.
+ */
+static s8 fill_fifo_config_1(u16 desired_settings,
+			     const struct bmp3_fifo_settings *fifo_settings,
+			     struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_FIFO_CONFIG_1;
+	u8 reg_data;
+
+	rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+
+	if (rslt == BMP3_OK) {
+		if (desired_settings & BMP3_SEL_FIFO_MODE) {
+			/* Fill the FIFO mode register data */
+			reg_data = BMP3_SET_BITS_POS_0(reg_data, BMP3_FIFO_MODE,
+						       fifo_settings->mode);
+		}
+		if (desired_settings & BMP3_SEL_FIFO_STOP_ON_FULL_EN) {
+			/* Fill the stop on full data */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_FIFO_STOP_ON_FULL,
+						 fifo_settings->stop_on_full_en);
+		}
+		if (desired_settings & BMP3_SEL_FIFO_TIME_EN) {
+			/* Fill the time enable data */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_FIFO_TIME_EN,
+						 fifo_settings->time_en);
+		}
+		if (desired_settings &
+		    (BMP3_SEL_FIFO_PRESS_EN | BMP3_SEL_FIFO_TEMP_EN)) {
+			/* Fill the pressure enable data */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_FIFO_PRESS_EN,
+						 fifo_settings->press_en);
+			/* Fill the temperature enable data */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_FIFO_TEMP_EN,
+						 fifo_settings->temp_en);
+		}
+		/* Write the power control settings in the register */
+		rslt = bmp3_set_regs(&reg_addr, &reg_data, 1, dev);
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This internal API fills the fifo_config_2(fifo_subsampling,
+ * data_select) settings in the reg_data variable so as to burst write
+ * in the sensor.
+ */
+static s8 fill_fifo_config_2(u16 desired_settings,
+			     const struct bmp3_fifo_settings *fifo_settings,
+			     struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_FIFO_CONFIG_2;
+	u8 reg_data;
+
+	rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+	if (rslt == BMP3_OK) {
+		if (desired_settings & BMP3_SEL_FIFO_DOWN_SAMPLING) {
+			/* To do check Normal mode */
+			/* Fill the down-sampling data */
+			reg_data = BMP3_SET_BITS_POS_0(reg_data, BMP3_FIFO_DOWN_SAMPLING,
+						       fifo_settings->down_sampling);
+		}
+		if (desired_settings & BMP3_SEL_FIFO_FILTER_EN) {
+			/* Fill the filter enable data */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_FIFO_FILTER_EN,
+						 fifo_settings->filter_en);
+		}
+		/* Write the power control settings in the register */
+		rslt = bmp3_set_regs(&reg_addr, &reg_data, 1, dev);
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This internal API fills the fifo interrupt control(fwtm_en, ffull_en)
+ * settings in the reg_data variable so as to burst write in the sensor.
+ */
+static s8 fill_fifo_int_ctrl(u16 desired_settings,
+			     const struct bmp3_fifo_settings *fifo_settings,
+			     struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr = BMP3_REG_INT_CTRL;
+	u8 reg_data;
+
+	rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+	if (rslt == BMP3_OK) {
+		if (desired_settings & BMP3_SEL_FIFO_FWTM_EN) {
+			/* Fill the FIFO watermark interrupt enable data */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_FIFO_FWTM_EN,
+						 fifo_settings->fwtm_en);
+		}
+		if (desired_settings & BMP3_SEL_FIFO_FULL_EN) {
+			/* Fill the FIFO full interrupt enable data */
+			reg_data = BMP3_SET_BITS(reg_data, BMP3_FIFO_FULL_EN,
+						 fifo_settings->ffull_en);
+		}
+		/* Write the power control settings in the register */
+		rslt = bmp3_set_regs(&reg_addr, &reg_data, 1, dev);
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the command ready, data ready for pressure and
+ * temperature, power on reset status from the sensor.
+ */
+static s8 get_sensor_status(struct bmp3_status *status, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_addr;
+	u8 reg_data;
+
+	reg_addr = BMP3_REG_SENS_STATUS;
+	rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+	if (rslt == BMP3_OK) {
+		status->sensor.cmd_rdy = BMP3_GET_BITS(reg_data, BMP3_STATUS_CMD_RDY);
+		status->sensor.drdy_press = BMP3_GET_BITS(reg_data,
+							  BMP3_STATUS_DRDY_PRESS);
+		status->sensor.drdy_temp = BMP3_GET_BITS(reg_data,
+							 BMP3_STATUS_DRDY_TEMP);
+		reg_addr = BMP3_REG_EVENT;
+		rslt = bmp3_get_regs(reg_addr, &reg_data, 1, dev);
+		status->pwr_on_rst = reg_data & 0x01;
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the interrupt (fifo watermark, fifo full, data ready)
+ * status from the sensor.
+ */
+static s8 get_int_status(struct bmp3_status *status, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_data;
+
+	rslt = bmp3_get_regs(BMP3_REG_INT_STATUS, &reg_data, 1, dev);
+	if (rslt == BMP3_OK) {
+		status->intr.fifo_wm = BMP3_GET_BITS_POS_0(reg_data,
+							   BMP3_INT_STATUS_FWTM);
+		status->intr.fifo_full = BMP3_GET_BITS(reg_data, BMP3_INT_STATUS_FFULL);
+		status->intr.drdy = BMP3_GET_BITS(reg_data, BMP3_INT_STATUS_DRDY);
+	}
+	return rslt;
+}
+
+/*!
+ * @brief This API gets the fatal, command and configuration error
+ * from the sensor.
+ */
+static s8 get_err_status(struct bmp3_status *status, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 reg_data;
+
+	rslt = bmp3_get_regs(BMP3_REG_ERR, &reg_data, 1, dev);
+	if (rslt == BMP3_OK) {
+		status->err.fatal = BMP3_GET_BITS_POS_0(reg_data, BMP3_ERR_FATAL);
+		status->err.cmd = BMP3_GET_BITS(reg_data, BMP3_ERR_CMD);
+		status->err.conf = BMP3_GET_BITS(reg_data, BMP3_ERR_CONF);
+	}
+	return rslt;
+}
+
diff --git a/drivers/iio/pressure/bmp390/bmp3.h b/drivers/iio/pressure/bmp390/bmp3.h
new file mode 100644
index 000000000000..15ac6f363728
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp3.h
@@ -0,0 +1,537 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp3.h
+ * @date		2024-12-04
+ * @version		v2.1.0
+ *
+ */
+
+/*!
+ * @defgroup bmp3 BMP3
+ */
+
+#ifndef _BMP3_H
+#define _BMP3_H
+
+/* Header includes */
+#include "bmp3_defs.h"
+
+/*! CPP guard */
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiInit Initialization
+ * @brief Initialize the sensor and device structure
+ */
+
+/*!
+ * \ingroup bmp3ApiInit
+ * \page bmp3_api_bmp3_init bmp3_init
+ * \code
+ * s8 bmp3_init(struct bmp3_dev *dev);
+ * \endcode
+ * @details This API is the entry point.
+ * Performs the selection of I2C/SPI read mechanism according to the
+ * selected interface and reads the chip-id and calibration data
+ * of the sensor.
+ *
+ *  @param[in,out] dev : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_init(struct bmp3_dev *dev);
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiSoftReset Soft reset
+ * @brief Perform soft reset of the sensor
+ */
+
+/*!
+ * \ingroup bmp3ApiSoftReset
+ * \page bmp3_api_bmp3_soft_reset bmp3_soft_reset
+ * \code
+ * s8 bmp3_soft_reset(const struct bmp3_dev *dev);
+ * \endcode
+ * @details This API performs the soft reset of the sensor.
+ *
+ * @param[in] dev : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_soft_reset(struct bmp3_dev *dev);
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiSensorS Sensor settings
+ * @brief Get / Set sensor settings
+ */
+
+/*!
+ * \ingroup bmp3ApiSensorS
+ * \page bmp3_api_bmp3_set_sensor_settings bmp3_set_sensor_settings
+ * \code
+ * s8 bmp3_set_sensor_settings(u32 desired_settings,
+ * struct bmp3_settings *settings, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API sets the power control(pressure enable and
+ * temperature enable), over sampling, odr and filter
+ * settings in the sensor.
+ *
+ * @param[in] desired_settings : Variable used to select the settings which
+ *                               are to be set in the sensor.
+ * @param[in] settings         : Structure instance of bmp3_settings
+ * @param[in] dev              : Structure instance of bmp3_dev.
+ *
+ * @note : Below are the macros to be used by the user for selecting the
+ * desired settings. User can do OR operation of these macros for configuring
+ * multiple settings.
+ *
+ *@verbatim
+ * ---------------------|----------------------------------------------
+ * desired_settings     |   Functionality
+ * ---------------------|----------------------------------------------
+ * BMP3_SEL_PRESS_EN    |   Enable/Disable pressure.
+ * BMP3_SEL_TEMP_EN     |   Enable/Disable temperature.
+ * BMP3_SEL_PRESS_OS    |   Set pressure oversampling.
+ * BMP3_SEL_TEMP_OS     |   Set temperature oversampling.
+ * BMP3_SEL_IIR_FILTER  |   Set IIR filter.
+ * BMP3_SEL_ODR         |   Set ODR.
+ * BMP3_SEL_OUTPUT_MODE |   Set either open drain or push pull
+ * BMP3_SEL_LEVEL       |   Set interrupt pad to be active high or low
+ * BMP3_SEL_LATCH       |   Set interrupt pad to be latched or nonlatched.
+ * BMP3_SEL_DRDY_EN     |   Map/Unmap the drdy interrupt to interrupt pad.
+ * BMP3_SEL_I2C_WDT_EN  |   Enable/Disable I2C internal watch dog.
+ * BMP3_SEL_I2C_WDT     |   Set I2C watch dog timeout delay.
+ * ---------------------|----------------------------------------------
+ *@endverbatim
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_set_sensor_settings(u32 desired_settings,
+			    struct bmp3_settings *settings,
+			    struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiSensorS
+ * \page bmp3_api_bmp3_get_sensor_settings bmp3_get_sensor_settings
+ * \code
+ * s8 bmp3_get_sensor_settings(struct bmp3_settings *settings, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API gets the power control(power mode, pressure enable and
+ * temperature enable), over sampling, odr, filter, interrupt control and
+ * advance settings from the sensor.
+ *
+ * @param[out] settings       : Structure instance of bmp3_settings
+ * @param[in] dev             : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_sensor_settings(struct bmp3_settings *settings, struct bmp3_dev *dev);
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiPowermode Power mode
+ * @brief Set / Get power mode of the sensor
+ */
+
+/*!
+ * \ingroup bmp3ApiPowermode
+ * \page bmp3_api_bmp3_set_op_mode bmp3_set_op_mode
+ * \code
+ * s8 bmp3_set_op_mode(struct bmp3_settings *settings, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API sets the power mode of the sensor.
+ *
+ * @param[in] settings       : Structure instance of bmp3_settings
+ * @param[in] dev            : Structure instance of bmp3_dev.
+ *
+ *@verbatim
+ * ----------------------|-------------------
+ * dev->settings.op_mode |   Macros
+ * ----------------------|-------------------
+ *     0                 | BMP3_MODE_SLEEP
+ *     1                 | BMP3_MODE_FORCED
+ *     3                 | BMP3_MODE_NORMAL
+ * ----------------------|-------------------
+ *@endverbatim
+ *
+ * @note : Before setting normal mode, valid odr and osr settings should be set
+ * in the sensor by using 'bmp3_set_sensor_settings' function.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_set_op_mode(struct bmp3_settings *settings, struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiPowermode
+ * \page bmp3_api_bmp3_get_op_mode bmp3_get_op_mode
+ * \code
+ * s8 bmp3_get_op_mode(u8 *op_mode, const struct bmp3_dev *dev);
+ * \endcode
+ * @details This API gets the power mode of the sensor.
+ *
+ * @param[in] dev      : Structure instance of bmp3_dev.
+ * @param[out] op_mode : Pointer variable to store the op-mode.
+ *
+ *@verbatim
+ * ------------------------------------------
+ *   op_mode             |   Macros
+ * ----------------------|-------------------
+ *     0                 | BMP3_MODE_SLEEP
+ *     1                 | BMP3_MODE_FORCED
+ *     3                 | BMP3_MODE_NORMAL
+ * ------------------------------------------
+ *@endverbatim
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_op_mode(u8 *op_mode, struct bmp3_dev *dev);
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiData Sensor Data
+ * @brief Get Sensor data
+ */
+
+/*!
+ * \ingroup bmp3ApiData
+ * \page bmp3_api_bmp3_get_sensor_data bmp3_get_sensor_data
+ * \code
+ * s8 bmp3_get_sensor_data(u8 sensor_comp, struct bmp3_data *data, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API reads the pressure, temperature or both data from the
+ * sensor, compensates the data and store it in the bmp3_data structure
+ * instance passed by the user.
+ *
+ * @param[in] sensor_comp : Variable which selects which data to be read from
+ * the sensor.
+ *
+ *@verbatim
+ * sensor_comp |   Macros
+ * ------------|-------------------
+ *     1       | BMP3_PRESS
+ *     2       | BMP3_TEMP
+ *     3       | BMP3_ALL
+ *@endverbatim
+ *
+ * @param[out] data : Structure instance of bmp3_data.
+ * @param[in] dev   : Structure instance of bmp3_dev.
+ *
+ * @note : For fixed point the compensated temperature and
+ *         pressure has a multiplication factor of 100.
+ *         Units are degree celsius and Pascal respectively.
+ *         ie. If temperature is 2426 then temperature is 24.26 deg C
+ *         If press is 9528709, then pressure is 95287.09 Pascal.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_sensor_data(u8 sensor_comp, struct bmp3_data *data, struct bmp3_dev *dev);
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiRegs Registers
+ * @brief Read / Write data to the given register address
+ */
+
+/*!
+ * \ingroup bmp3ApiRegs
+ * \page bmp3_api_bmp3_set_regs bmp3_set_regs
+ * \code
+ * s8 bmp3_set_regs(u8 *reg_addr, const u8 *reg_data, u8 len, const struct bmp3_dev *dev);
+ * \endcode
+ * @details This API writes the given data to the register address
+ * of the sensor.
+ *
+ *  @param[in] reg_addr  : Register address to where the data to be written.
+ *  @param[in] reg_data  : Pointer to data buffer which is to be written
+ *                         in the sensor.
+ *  @param[in] len       : No. of bytes of data to write.
+ *  @param[in] dev       : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_set_regs(u8 *reg_addr, const u8 *reg_data, u32 len, struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiRegs
+ * \page bmp3_api_bmp3_get_regs bmp3_get_regs
+ * \code
+ * s8 bmp3_get_regs(u8 reg_addr, u8 *reg_data, u16 length, const struct bmp3_dev *dev);
+ * \endcode
+ * @details This API reads the data from the given register address of the sensor.
+ *
+ *  @param[in] reg_addr  : Register address from where the data to be read
+ *  @param[out] reg_data : Pointer to data buffer to store the read data.
+ *  @param[in] len       : No. of bytes of data to be read.
+ *  @param[in] dev       : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_regs(u8 reg_addr, u8 *reg_data, u32 len, struct bmp3_dev *dev);
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiFIFO FIFO
+ * @brief FIFO operations of the sensor
+ */
+
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_set_fifo_settings bmp3_set_fifo_settings
+ * \code
+ * s8 bmp3_set_fifo_settings(u16 desired_settings, struct bmp3_fifo_settings *fifo_settings,
+ *                             struct bmp3_dev *dev);
+ * \endcode
+ * @details This API sets the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en),
+ * fifo_config_2(fifo_subsampling, data_select) and int_ctrl(fwtm_en, ffull_en)
+ * settings in the sensor.
+ *
+ * @param[in] desired_settings : Variable used to select the FIFO settings which
+ *                               are to be set in the sensor.
+ *
+ * @note : Below are the macros to be used by the user for selecting the
+ * desired settings. User can do OR operation of these macros for configuring
+ * multiple settings.
+ *
+ *@verbatim
+ * --------------------------------|---------------------------------------------
+ *      desired_settings           |  Functionality
+ * --------------------------------|---------------------------------------------
+ * BMP3_SEL_FIFO_MODE              |  Enable/Disable FIFO
+ * BMP3_SEL_FIFO_STOP_ON_FULL_EN   |  Set FIFO stop on full interrupt
+ * BMP3_SEL_FIFO_TIME_EN           |  Enable/Disable FIFO time
+ * BMP3_SEL_FIFO_PRESS_EN          |  Enable/Disable pressure
+ * BMP3_SEL_FIFO_TEMP_EN           |  Enable/Disable temperature
+ * BMP3_SEL_FIFO_DOWN_SAMPLING     |  Set FIFO downsampling
+ * BMP3_SEL_FIFO_FILTER_EN         |  Enable/Disable FIFO filter
+ * BMP3_SEL_FIFO_FWTM_EN           |  Enable/Disable FIFO watermark interrupt
+ * BMP3_SEL_FIFO_FFULL_EN          |  Enable/Disable FIFO full interrupt
+ * --------------------------------|---------------------------------------------
+ *@endverbatim
+ *
+ * @param[in] fifo_settings : Structure instance of bmp3_fifo_settings
+ * @param[in] dev           : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_set_fifo_settings(u16 desired_settings,
+			  const struct bmp3_fifo_settings *fifo_settings,
+			  struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_get_fifo_settings bmp3_get_fifo_settings
+ * \code
+ * s8 bmp3_get_fifo_settings(struct bmp3_fifo_settings *fifo_settings, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API gets the fifo_config_1(fifo_mode,
+ * fifo_stop_on_full, fifo_time_en, fifo_press_en, fifo_temp_en),
+ * fifo_config_2(fifo_subsampling, data_select) and int_ctrl(fwtm_en, ffull_en)
+ * settings from the sensor.
+ *
+ * @param[in] fifo_settings : Structure instance of bmp3_fifo_settings
+ * @param[in] dev           : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_fifo_settings(struct bmp3_fifo_settings *fifo_settings, struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_get_fifo_data bmp3_get_fifo_data
+ * \code
+ * s8 bmp3_get_fifo_data(struct bmp3_fifo_data *fifo,
+ *                         const struct bmp3_fifo_settings *fifo_settings,
+ *                         struct bmp3_dev *dev);
+ * \endcode
+ * @details This API gets the fifo data from the sensor.
+ *
+ * @param[in,out] fifo      : Structure instance of bmp3_fifo_data
+ * @param[in] fifo_settings : Structure instance of bmp3_fifo_settings
+ * @param[in] dev           : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_fifo_data(struct bmp3_fifo_data *fifo,
+		      const struct bmp3_fifo_settings *fifo_settings,
+		      struct bmp3_dev *dev);
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_get_fifo_length bmp3_get_fifo_length
+ * \code
+ * s8 bmp3_get_fifo_length(u16 *fifo_length, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API gets the fifo length from the sensor.
+ *
+ * @param[out] fifo_length : Variable used to store the fifo length.
+ * @param[in] dev          : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status.
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_fifo_length(u16 *fifo_length, struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_extract_fifo_data bmp3_extract_fifo_data
+ * \code
+ * s8 bmp3_extract_fifo_data(struct bmp3_data *data,
+ * struct bmp3_fifo_data *fifo, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API extracts the temperature and/or pressure data from the FIFO
+ * data which is already read from the fifo.
+ *
+ * @param[out] data : Array of bmp3_data structures where the temperature
+ *                    and pressure frames will be stored.
+ * @param[in] fifo  : Structure instance of bmp3_fifo_data
+ * @param[in] dev   : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0  -> Success
+ * @retval <0 -> Error
+ */
+s8 bmp3_extract_fifo_data(struct bmp3_data *data,
+			  struct bmp3_fifo_data *fifo,
+			  struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_set_fifo_watermark bmp3_set_fifo_watermark
+ * \code
+ * s8 bmp3_set_fifo_watermark(const struct bmp3_fifo_data *fifo,
+ *                              const struct bmp3_fifo_settings *fifo_settings,
+ *                              struct bmp3_dev *dev);
+ * \endcode
+ * @details This API sets the fifo watermark length according to the frames count
+ * set by the user in the device structure. Refer below for usage.
+ *
+ * @note: fifo.req_frames = 50;
+ *
+ * @param[in] fifo          : Structure instance of bmp3_fifo_data
+ * @param[in] fifo_settings : Structure instance of bmp3_fifo_settings
+ * @param[in] dev           : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0  -> Success
+ * @retval <0 -> Error
+ */
+s8 bmp3_set_fifo_watermark(const struct bmp3_fifo_data *fifo,
+			   const struct bmp3_fifo_settings *fifo_settings,
+			   struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_get_fifo_watermark bmp3_get_fifo_watermark
+ * \code
+ * s8 bmp3_get_fifo_watermark(u16 *watermark_len, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API gets the fifo watermark length according to the frames count
+ * set by the user in the device structure
+ *
+ * @param[in] watermark_len : Watermark level value
+ * @param[in] dev           : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0  -> Success
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_fifo_watermark(u16 *watermark_len, struct bmp3_dev *dev);
+
+/*!
+ * \ingroup bmp3ApiFIFO
+ * \page bmp3_api_bmp3_fifo_flush bmp3_fifo_flush
+ * \code
+ * s8 bmp3_fifo_flush(const struct bmp3_dev *dev);
+ * \endcode
+ * @details This API performs fifo flush
+ *
+ * @param[in] dev : Structure instance of bmp3_dev.
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Error
+ */
+s8 bmp3_fifo_flush(struct bmp3_dev *dev);
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiStatus Sensor Status
+ * @brief Read status of the sensor
+ */
+
+/*!
+ * \ingroup bmp3ApiStatus
+ * \page bmp3_api_bmp3_get_status bmp3_get_status
+ * \code
+ * s8 bmp3_get_status(struct bmp3_status *status, struct bmp3_dev *dev);
+ * \endcode
+ * @details This API gets the command ready, data ready for pressure and
+ * temperature and interrupt (fifo watermark, fifo full, data ready) and
+ * error status from the sensor.
+ *
+ * @param[out] status : Structure instance of bmp3_status
+ * @param[in] dev     : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status.
+ * @retval 0  -> Success
+ * @retval <0 -> Error
+ */
+s8 bmp3_get_status(struct bmp3_status *status, struct bmp3_dev *dev);
+
+#ifdef __cplusplus
+}
+#endif /* End of CPP guard */
+
+#endif /* _BMP3_H */
+
diff --git a/drivers/iio/pressure/bmp390/bmp390_driver.c b/drivers/iio/pressure/bmp390/bmp390_driver.c
new file mode 100644
index 000000000000..b6f3b2d29bab
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp390_driver.c
@@ -0,0 +1,1604 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp390_driver.c
+ * @date		2025-06-02
+ * @version		v2.2.0
+ *
+ * @brief		 BMP390 Linux IIO Driver
+ *
+ */
+/*********************************************************************/
+/* Own header files */
+/*********************************************************************/
+#include "bmp390_driver.h"
+/*********************************************************************/
+/* System header files */
+/*********************************************************************/
+
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/time.h>
+#include <linux/firmware.h>
+#include <linux/gpio.h>
+#include <linux/math64.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+
+/*********************************************************************/
+/* Local macro definitions */
+/*********************************************************************/
+/*! define driver version */
+#define DRIVER_VERSION "2.2.0"
+/*********************************************************************/
+/* Global data */
+/*********************************************************************/
+/*! define millisecs to microsecs conversion */
+#define MS_TO_US(msec)		UINT32_C((msec) * 1000)
+/*! define max check times for chip id */
+#define CHECK_CHIP_ID_TIME_MAX		UINT8_C(5)
+/*! define sensor i2c address */
+#define BMP_I2C_ADDRESS			BMP3_ADDR_I2C_SEC
+/*! define max I2C packet size */
+#define I2C_PACKET_MAX_SIZE             UINT16_C(256)
+/*! define interrupt GPIO */
+#define BMP_GPIO_ID			UINT8_C(59)
+/*! define default delay time used by input event [unit:ms] */
+#define BMP_DELAY_DEFAULT		UINT16_C(200)
+/*! no action to selftest */
+#define BMP_SELFTEST_NO_ACTION		INT8_C(-1)
+
+/*! define max chars to print using scnprintf */
+#define MAX_CHARS			UINT8_C(128)
+/*! FIFO temperature pressure header frame */
+#define FIFO_TEMP_PRESS_FRAME		UINT8_C(0x94)
+/*! FIFO temperature header frame */
+#define FIFO_TEMP_FRAME			UINT8_C(0x90)
+/*! FIFO pressure header frame */
+#define FIFO_PRESS_FRAME		UINT8_C(0x84)
+/*! FIFO time header frame */
+#define FIFO_TIME_FRAME			UINT8_C(0xA0)
+/*! Converts milliseconds to nanoseconds */
+#define MS_TO_NS(msec)		((msec) * 1000 * 1000)
+/*! Converts milliseconds to microseconds */
+#define MS_TO_US(msec)		UINT32_C((msec) * 1000)
+
+/*Temperature data register address*/
+#define BMP3_REG_TEMP_DATA		UINT8_C(0x07)
+
+/* IIO Module */
+static const struct iio_event_spec bmp390_event = {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE)
+};
+
+/**
+ * BMP390_CHANNELS_CONFIG - Macro to configure BMP390 sensor channels
+ * @device_type: Type of the device (e.g., IIO_PRESSURE)
+ * @si: Scan index for the channel
+ * @mod: Modifier for the channel (e.g., IIO_MOD_X)
+ * @addr: Address of the channel
+ *
+ * This macro sets up the configuration for a BMP390 sensor channel, including
+ * the type, scan index, modifier, address, and scan type details. It also
+ * specifies the event specification and the number of event specifications.
+ *
+ * The scan type details include:
+ * - sign: Sign of the data ('s' for signed)
+ * - realbits: Number of valid data bits
+ * - shift: Bit shift applied to the data
+ * - storagebits: Number of storage bits
+ * - endianness: Endianness of the data (IIO_LE for little-endian)
+ *
+ * The event specification is set to bmp390_event, and the number of event
+ * specifications is set to 1.
+ */
+#define BMP390_CHANNELS_CONFIG(device_type, si, mod, addr) \
+	{ \
+		.type = device_type, \
+		.modified = 1, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+		.scan_index = si, \
+		.channel2 = mod, \
+		.address = addr, \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = 64, \
+			.shift = 0, \
+			.storagebits = 64, \
+			.endianness = IIO_LE, \
+		}, \
+	.event_spec = &bmp390_event,					\
+	.num_event_specs = 1		\
+	}
+
+#define BMP390_BYTE_FOR_PER_AXIS_CHANNEL		2
+
+/* scan element definition */
+enum BMP390_AXIS_SCAN {
+	BMP390_SCAN_TEMP,
+	BMP390_SCAN_PRESS,
+	BMP390_SCAN_TIMESTAMP,
+};
+
+/*iio chan spec for  BMP390 sensor*/
+static const struct iio_chan_spec bmp390_iio_channels[] = {
+/*acc channel*/
+/*lint -e446*/
+BMP390_CHANNELS_CONFIG(IIO_TEMP, BMP390_SCAN_TEMP,
+		       IIO_MOD_TEMP_OBJECT, BMP3_REG_TEMP_DATA),
+BMP390_CHANNELS_CONFIG(IIO_PRESSURE, BMP390_SCAN_PRESS,
+		       IIO_MOD_TEMP_OBJECT, BMP3_REG_DATA),
+/*lint +e446*/
+/*ap timestamp channel*/
+IIO_CHAN_SOFT_TIMESTAMP(BMP390_SCAN_TIMESTAMP)
+
+};
+
+/**
+ * bmp3_config_func_name - Array of strings representing the names of different
+ *                         BMP390 configuration functions.
+ *                         These functions include:
+ *                         - "data ready interrupt"
+ *                         - "fifo full interrupt"
+ *                         - "fifo water mark interrupt"
+ */
+static char *bmp3_config_func_name[] = {
+	"data ready interrupt",
+	"fifo full interrupt",
+	"fifo water mark interrupt"
+};
+
+/**
+ * bmp3_config_en_disable - Array of strings representing the enable/disable
+ *                          states for BMP390 configuration.
+ *                          These states include:
+ *                          - "disabled"
+ *                          - "enabled"
+ */
+static char *bmp3_config_en_disable[] = {
+	"disabled",
+	"enabled"
+};
+
+/**
+ * bmp3_delay_us - Adds a delay in units of microsecs.
+ *
+ * @usec: Delay value in microsecs.
+ */
+static void bmp3_delay_us(u32 usec, void *intf_ptr)
+{
+	if (usec <= (MS_TO_US(20))) {
+		/* Delay range of usec to usec + 1 millisecs
+		 * required due to kernel limitation
+		 */
+		usleep_range(usec, usec + 1000);
+	} else {
+		msleep(usec / 1000);
+	}
+}
+
+/**
+ * check_error -
+ * check error code and print error message if err is non 0.
+ *
+ * @print_msg	: print message to print on if err is not 0.
+ * @err			: error code return to be checked.
+ */
+static void check_error(char *print_msg, int err)
+{
+	if (err)
+		pr_err("%s failed with return code:%d\n", print_msg, err);
+}
+
+/**
+ * chip_id_show - sysfs read callback for reading the
+ * chip id of the sensor.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t chip_id_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	u8 chip_id = {0};
+	int ret;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	ret = bmp3_get_regs(BMP3_REG_CHIP_ID, &chip_id, 1,
+			    &client_data->device);
+	check_error("read chip id register", ret);
+	return scnprintf(buf, 96, "chip_id=0x%x\n", chip_id);
+}
+
+/**
+ * avail_sensor_show -
+ * sysfs read callback which prints sensor supported by
+ * this current driver.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t avail_sensor_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return scnprintf(buf, 32, "bmp390\n");
+}
+
+/*!
+ * @brief sysfs write callback which performs the iio generic buffer test
+ *
+ * @param[in] dev	: Device instance.
+ * @param[in] attr	: Instance of device attribute file.
+ * @param[in] buf	: Instance of the data buffer which serves as input.
+ * @param[in] count : Number of characters in the buffer `buf`.
+ *
+ * @return Number of characters used from buffer `buf`,
+ * which equals count.
+ */
+static ssize_t iio_generic_buffer_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	int rslt;
+	unsigned long iio_test;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	/* Base of decimal number system is 10 */
+	rslt = kstrtoul(buf, 10, &iio_test);
+
+	if (rslt) {
+		pr_err("iio_generic_buffer : invalid input");
+		return -EIO;
+	}
+
+	if (iio_test) {
+		/*lint -e534*/
+		bmp390_iio_allocate_trigger(input);
+		/*lint +e534*/
+	} else {
+		bmp390_iio_deallocate_trigger(input);
+		/*lint -e534*/
+		bmp3_soft_reset(&client_data->device);
+		/*lint +e534*/
+	}
+
+	return count;
+}
+
+/**
+ * reg_sel_show - sysfs read callback which reads register
+ * address and length selected for a read/write operation via reg_val.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t reg_sel_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	return scnprintf(buf, 64, "reg=0X%02X, len=%d\n",
+		client_data->reg_sel, client_data->reg_len);
+}
+
+/**
+ * reg_sel_store - sysfs write callback which sets register address
+ * and length to be selected for a read/write operation via reg_val.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as input.
+ * @count: Number of characters in the buffer `buf`.
+ *
+ * Return: Number of characters used from buffer `buf`,
+ * which equals count.
+ */
+static ssize_t reg_sel_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	int ret;
+	unsigned int sdata[2] = {0};
+
+	mutex_lock(&client_data->lock);
+	ret = sscanf(buf, "%11X %11d", &sdata[0], &sdata[1]);
+	client_data->reg_sel = (u8)sdata[0];
+	client_data->reg_len = (u8)sdata[1];
+	if (ret != 2 || client_data->reg_len > 128 || client_data->reg_sel > 127) {
+		pr_err("Invalid argument");
+		mutex_unlock(&client_data->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&client_data->lock);
+	return count;
+}
+
+/**
+ * reg_val_show - sysfs read callback which read sensor data register
+ * address and length set via reg_sel.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t reg_val_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	int ret;
+	u8 reg_data[128];
+	int i;
+	int pos;
+
+	if (client_data->reg_len == 0) {
+		pr_err("reg_sel length can't be 0, please set reg_sel first");
+		return -EINVAL;
+	}
+	mutex_lock(&client_data->lock);
+	ret = bmp3_get_regs(client_data->reg_sel,
+			    reg_data,
+			    client_data->reg_len,
+			    &client_data->device);
+
+	check_error("reg_val read", ret);
+	pos = 0;
+	for (i = 0; i < client_data->reg_len; ++i) {
+		pos += scnprintf(buf + pos, 16, "%02X", reg_data[i]);
+		buf[pos++] = (i + 1) % 16 == 0 ? '\n' : ' ';
+	}
+	mutex_unlock(&client_data->lock);
+	if (buf[pos - 1] == ' ')
+		buf[pos - 1] = '\n';
+	return pos;
+}
+
+/**
+ * reg_val_store - sysfs write callback which write sensor data register
+ * address and length set via reg_sel.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as input.
+ * @count: Number of characters in the buffer `buf`.
+ *
+ * Return: Number of characters used from buffer `buf`,
+ * which equals count.
+ */
+static ssize_t reg_val_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	int ret;
+	u8 reg_data[128] = {0,};
+	int i, j, status, digit;
+
+	if (client_data->reg_len == 0) {
+		pr_err("reg_sel length can't be 0, please set reg_sel values first\n");
+		return -EINVAL;
+	}
+	status = 0;
+	mutex_lock(&client_data->lock);
+	/* Lint -save -e574 */
+	for (i = j = 0; i < count && j < client_data->reg_len; ++i) {
+		/* Lint -restore */
+		if (buf[i] == ' ' || buf[i] == '\n' || buf[i] == '\t' ||
+		    buf[i] == '\r') {
+			status = 0;
+			++j;
+			continue;
+		}
+		digit = buf[i] & 0x10 ? (buf[i] & 0xF) : ((buf[i] & 0xF) + 9);
+		pr_info("digit is %d\n", digit);
+		switch (status) {
+		case 2:
+			++j;
+			reg_data[j] = digit;
+			status = 1;
+			break;
+		case 0:
+			reg_data[j] = digit;
+			status = 1;
+			break;
+		case 1:
+			reg_data[j] = reg_data[j] * 16 + digit;
+			status = 2;
+			break;
+		}
+	}
+	if (status > 0)
+		++j;
+	if (j > client_data->reg_len) {
+		j = client_data->reg_len;
+	} else if (j < client_data->reg_len) {
+		pr_err("Invalid argument\n");
+		mutex_unlock(&client_data->lock);
+		return -EINVAL;
+	}
+	pr_info("Reg data read as\n");
+	for (i = 0; i < j; ++i)
+		pr_info("%d\n", reg_data[i]);
+	ret = client_data->device.write(client_data->reg_sel, reg_data,
+					client_data->reg_len,
+					client_data->device.intf_ptr);
+	mutex_unlock(&client_data->lock);
+	check_error("reg_val write", ret);
+	return count;
+}
+
+/**
+ * driver_version_show - sysfs read callback which
+ * provides current driver version.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t driver_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return scnprintf(buf, 128,
+		"Driver version: %s\n", DRIVER_VERSION);
+}
+
+/**
+ * op_mode_show - Show the current operating mode of the BMP390 sensor.
+ * @dev: The device object.
+ * @attr: The device attribute.
+ * @buf: The buffer to store the operating mode string.
+ *
+ * This function retrieves the current operating mode of the BMP390 sensor
+ * and stores it in the provided buffer. If the operation is
+ * successful, it returns the number of characters written to the buffer.
+ * Otherwise, it returns an error code.
+ *
+ * Return: Number of characters written to the buffer on success,
+ * or -EIO on failure.
+ */
+static ssize_t op_mode_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	u8 op_mode;
+	s16 status;
+
+	mutex_lock(&client_data->lock);
+	status = bmp3_get_op_mode(&op_mode, &client_data->device);
+	mutex_unlock(&client_data->lock);
+
+	if (status == BMP3_OK)
+		return scnprintf(buf, MAX_CHARS, "op_mode = %u\n", op_mode);
+	else
+		return -EIO;
+}
+
+/*!
+ * @brief Sets the operating mode via a sysfs node.
+ *
+ * This function allows the user to set the operating mode of the BMP390 sensor
+ * by writing to a sysfs node. The input value must be a valid operating mode
+ * (0 to 3). If the input value is invalid, an error message is printed and
+ * the function returns an error code.
+ *
+ * @param dev Pointer to the device structure.
+ * @param attr Pointer to the device attribute structure.
+ * @param buf Buffer containing the input value as a string.
+ * @param count Size of the input buffer.
+ * @return The number of bytes written on success,
+ * or a negative error code on failure.
+ */
+static ssize_t op_mode_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	unsigned long  op_mode;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &op_mode);
+	if (op_mode > 3) {
+		pr_err("Invalid input\nusage:\n");
+		pr_err("echo op_mode > power_mode\n");
+		return -EIO;
+	}
+	mutex_lock(&client_data->lock);
+	client_data->settings.op_mode = op_mode;
+	ret = bmp3_set_op_mode(&client_data->settings, &client_data->device);
+	mutex_unlock(&client_data->lock);
+
+	if (ret == BMP3_OK)
+		return count;
+
+	return ret;
+}
+
+/**
+ * odr_show - Show the output data rate (ODR) of the BMP390 sensor.
+ * @dev: The device from which to retrieve the ODR.
+ * @attr: The device attribute (unused).
+ * @buf: The buffer to store the ODR value.
+ *
+ * This function retrieves the output data rate (ODR) of the BMP390 sensor
+ * and stores it in the provided buffer. If the sensor settings
+ * are successfully retrieved, the ODR value is formatted and stored in the
+ * buffer. Otherwise, an error code is returned.
+ *
+ * Return: The number of characters written to the buffer on success,
+ *         or a negative error code on failure.
+ */
+static ssize_t odr_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	unsigned int odr;
+	s8 status;
+
+	mutex_lock(&client_data->lock);
+	status = bmp3_get_sensor_settings(&client_data->settings,
+					  &client_data->device);
+	odr = client_data->settings.odr_filter.odr;
+	mutex_unlock(&client_data->lock);
+
+	if (status == 0)
+		return scnprintf(buf, MAX_CHARS, "%d\n", odr);
+
+	return -EIO;
+}
+
+/**
+ * odr_store - Store the output data rate (ODR) value for the BMP390 sensor.
+ * @dev: The device structure.
+ * @attr: The device attribute structure.
+ * @buf: The buffer containing the ODR value as a string.
+ * @count: The size of the buffer.
+ *
+ * This function parses the ODR value from the input buffer, validates it,
+ * and updates the sensor settings accordingly.
+ *
+ * Return: The number of bytes processed on success, or a negative error code
+ * on failure.
+ */
+static ssize_t odr_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	unsigned long odr;
+	u16 settings_sel;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &odr);
+	check_error("odr input receive", ret);
+	if (ret) {
+		pr_err("odr invalid input:%ld\n", odr);
+		return -EINVAL;
+	}
+	settings_sel = BMP3_SEL_ODR;
+	mutex_lock(&client_data->lock);
+	client_data->settings.odr_filter.odr = odr;
+	ret = bmp3_set_sensor_settings(settings_sel, &client_data->settings,
+				       &client_data->device);
+	mutex_unlock(&client_data->lock);
+	if (ret == BMP3_OK)
+		return count;
+
+	return ret;
+}
+
+/**
+ * sensor_conf_show - sysfs read callback which reads
+ * pressure sensor configuration parameters.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t sensor_conf_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct bmp3_settings settings = { 0 };
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	mutex_lock(&client_data->lock);
+	ret = bmp3_get_sensor_settings(&settings,
+				       &client_data->device);
+	mutex_unlock(&client_data->lock);
+	check_error("bmp3_get_sensor_settings", ret);
+
+	return scnprintf(buf, PAGE_SIZE,
+					"cfg.odr_filter.odr:%d\ncfg.press_en:%d\ncfg.temp_en:%d\n",
+					settings.odr_filter.odr,
+					settings.press_en,
+					settings.temp_en);
+}
+
+/**
+ * sensor_conf_store - sysfs write callback which sets
+ * pressure sensor configuration parameters.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as input.
+ * @count: Number of characters in the buffer `buf`.
+ *
+ * Return: Number of characters used from buffer `buf`,
+ * which equals count.
+ */
+static ssize_t sensor_conf_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int ret;
+	unsigned int sdata[2] = {0};
+	u16 settings_sel = 0;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	ret = sscanf(buf, "%11d %11d", &sdata[0], &sdata[1]);
+	if (ret != 2) {
+		pr_err("Invalid input\nusage:\n");
+		pr_err("echo odr press_enable/disable > sensor_conf\n");
+		return -EIO;
+	}
+	mutex_lock(&client_data->lock);
+	ret = bmp3_get_sensor_settings(&client_data->settings,
+				       &client_data->device);
+	check_error("bmp3_get_sensor_settings", ret);
+	client_data->settings.odr_filter.odr = (u8)sdata[0];
+	client_data->settings.press_en = (u8)sdata[1];
+	client_data->settings.temp_en = BMP3_ENABLE;
+	settings_sel |= BMP3_SEL_PRESS_EN | BMP3_SEL_PRESS_OS;
+
+	settings_sel |= BMP3_SEL_TEMP_EN | BMP3_SEL_TEMP_OS;
+	client_data->settings.odr_filter.temp_os = BMP3_NO_OVERSAMPLING;
+
+	settings_sel |= BMP3_SEL_ODR;
+
+	ret = bmp3_set_sensor_settings(settings_sel, &client_data->settings,
+				       &client_data->device);
+	mutex_unlock(&client_data->lock);
+	check_error("bmp3_set_sensor_settings", ret);
+	return count;
+}
+
+/**
+ * fifo_conf_show - sysfs read callback which reads
+ * fifo sensor configuration parameters.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t fifo_config_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct bmp3_fifo_settings fifo_settings = { 0 };
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	mutex_lock(&client_data->lock);
+	ret = bmp3_get_fifo_settings(&fifo_settings, &client_data->device);
+	check_error("bmp3_get_fifo_settings", ret);
+	mutex_unlock(&client_data->lock);
+
+	return scnprintf(buf, PAGE_SIZE,
+					"mode:%d\nffull:%d\nfwtm:%d\n"
+					"fifo.press_en:%d\nfifo.temp_en:%d\nfifo.time_en:%d\n",
+					fifo_settings.mode,
+					fifo_settings.ffull_en,
+					fifo_settings.fwtm_en,
+					fifo_settings.press_en,
+					fifo_settings.temp_en,
+					fifo_settings.time_en);
+}
+
+/**
+ * fifo_conf_store - sysfs write callback which sets
+ * fifo configuration parameters.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as input.
+ * @count: Number of characters in the buffer `buf`.
+ *
+ * Return: Number of characters used from buffer `buf`,
+ * which equals count.
+ */
+static ssize_t fifo_config_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int ret;
+	unsigned int sdata[2] = {0};
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	client_data->settings_sel = 0;
+	client_data->settings_fifo = 0;
+	ret = sscanf(buf, "%11d %11d", &sdata[0], &sdata[1]);
+	if (ret != 2) {
+		pr_err("Invalid input\nusage:\n");
+		pr_err("echo press_en/dis time_en/dis > fifo_conf\n");
+		return -EIO;
+	}
+	if (sdata[0] > 1) {
+		pr_err("Invalid input\nusage:\n");
+		pr_err("pressure be 0 or 1\n");
+		pr_err("0 : pressure disable\n 1 : pressure enable\n");
+		return -EIO;
+	}
+	if (sdata[1] > 1) {
+		pr_err("Invalid input\nusage:\n");
+		pr_err("time be 0 or 1\n");
+		pr_err("0 : time disable\n 1 : time enable\n");
+		return -EIO;
+	}
+	mutex_lock(&client_data->lock);
+	client_data->fifo_settings.press_en = 0;
+	client_data->fifo_settings.temp_en = 0;
+	client_data->fifo_settings.time_en = 0;
+	client_data->fifo_settings.filter_en = BMP3_ENABLE;
+	client_data->fifo_settings.down_sampling = BMP3_FIFO_NO_SUBSAMPLING;
+	client_data->fifo.req_frames = FIFO_FRAME_COUNT;
+	client_data->fifo.byte_count = FIFO_MAX_SIZE;
+	client_data->settings_fifo = BMP3_SEL_FIFO_MODE |
+	BMP3_SEL_FIFO_DOWN_SAMPLING | BMP3_SEL_FIFO_FILTER_EN;
+	client_data->settings_fifo |= BMP3_SEL_FIFO_FWTM_EN |
+	BMP3_SEL_FIFO_FULL_EN;
+
+	client_data->fifo_settings.press_en = (u8)sdata[0];
+	client_data->settings.press_en = (u8)sdata[0];
+
+	client_data->fifo_settings.temp_en = BMP3_ENABLE;
+	client_data->settings.temp_en = BMP3_ENABLE;
+
+	client_data->fifo_settings.time_en = (u8)sdata[1];
+
+	client_data->settings_sel |= BMP3_SEL_ODR;
+
+	client_data->settings_sel |= BMP3_SEL_PRESS_EN | BMP3_SEL_PRESS_OS;
+
+	client_data->settings_fifo |= BMP3_SEL_FIFO_PRESS_EN;
+
+	client_data->settings_sel |=  BMP3_SEL_TEMP_EN |  BMP3_SEL_TEMP_OS;
+
+	client_data->settings_fifo |= BMP3_SEL_FIFO_TEMP_EN;
+	client_data->settings_fifo |= BMP3_SEL_FIFO_TIME_EN;
+
+	ret = bmp3_set_sensor_settings(client_data->settings_sel,
+				       &client_data->settings,
+				       &client_data->device);
+	check_error("bmp3_set_fifo_settings", ret);
+	ret = bmp3_set_fifo_settings(client_data->settings_fifo,
+				     &client_data->fifo_settings, &client_data->device);
+	check_error("bmp3_set_fifo_settings", ret);
+	mutex_unlock(&client_data->lock);
+	check_error("bmp3_set_sensor_settings", ret);
+	return count;
+}
+
+/**
+ * soft_reset_store - sysfs write callback which
+ * performs sensor soft reset
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as input.
+ * @count: Number of characters in the buffer `buf`.
+ *
+ * Return: Number of characters used from buffer `buf`,
+ * which equals count.
+ */
+static ssize_t soft_reset_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+	unsigned long soft_reset;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	ret = kstrtoul(buf, 10, &soft_reset);
+	check_error("soft_reset node input receive", ret);
+	if (soft_reset) {
+		ret = bmp3_soft_reset(&client_data->device);
+		check_error("bmp3_soft_reset", ret);
+		if (ret != BMP3_OK)
+			pr_err("Soft reset failed\n");
+		else
+			pr_info("Soft reset success\n");
+	} else {
+		pr_err("Invalid Input\nusage: echo 1 > softreset\n");
+	}
+	return count;
+}
+
+/**
+ * sensor_data_show - sysfs read callback which reads
+ * sensor data registers.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t sensor_data_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	struct bmp3_data comp_data;
+	struct bmp3_status status = { { 0 } };
+
+	ret = bmp3_get_status(&status, &client_data->device);
+	check_error("bmp3_get_status", ret);
+	mutex_lock(&client_data->lock);
+	ret = bmp3_get_sensor_data(BMP3_PRESS_TEMP, &comp_data,
+				   &client_data->device);
+	mutex_unlock(&client_data->lock);
+	check_error("bmp3_get_sensor_data", ret);
+	comp_data.pressure = (client_data->settings.press_en == BMP3_DISABLE)
+						? 0 : comp_data.pressure;
+	comp_data.temperature =
+						(client_data->settings.temp_en == BMP3_DISABLE)
+						? 0 : comp_data.temperature;
+
+	return scnprintf(buf, PAGE_SIZE,
+					"Temperature: %lld deg C,	Pressure:  %llu\n",
+					comp_data.temperature, comp_data.pressure);
+}
+
+/**
+ * config_function_show - sysfs read callback which gives the list of
+ * enabled sensor features.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t config_function_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	return scnprintf(buf, PAGE_SIZE,
+		"drdy%d=%d\nfifo_full%d=%d\nfifo_wm%d=%d\n",
+		BMP3_DATA_READY, client_data->data_ready_en,
+		BMP3_FIFO_FULL, client_data->fifo_full_en,
+		BMP3_FIFO_WM, client_data->fifo_wm_en);
+}
+
+/**
+ * bmp390_sensor_feature_config - function to enable or
+ * disable sensor feature.
+ *
+ * @client_data: client structure that holds device instance
+ *				and parameters
+ * @config_func: feature to be configured
+ * @enable:		 input to enable or disable selected feature.
+ *
+ * Return: 0 if success.
+ */
+static ssize_t bmp3_sensor_feature_config(struct bmp3_client_data *client_data,
+					  int config_func, int enable)
+{
+	int ret;
+
+	if ((config_func < BMP3_DATA_READY || config_func > BMP3_FIFO_WM) &&
+	    (enable != 1 || enable != 0)) {
+		pr_err("Invalid input passed for sensor feature configuration\n");
+		return -EINVAL;
+	}
+	switch (config_func) {
+	case BMP3_DATA_READY:
+		client_data->settings.int_settings.drdy_en = BMP3_ENABLE;
+		client_data->settings.press_en = BMP3_ENABLE;
+		client_data->settings.temp_en = BMP3_ENABLE;
+		client_data->settings.odr_filter.press_os = BMP3_OVERSAMPLING_2X;
+		client_data->settings.odr_filter.temp_os = BMP3_OVERSAMPLING_2X;
+		client_data->settings_sel = BMP3_SEL_PRESS_EN | BMP3_SEL_TEMP_EN
+					| BMP3_SEL_PRESS_OS | BMP3_SEL_TEMP_OS |
+					BMP3_SEL_ODR | BMP3_SEL_DRDY_EN;
+		client_data->data_ready_en = enable;
+		ret = bmp3_set_sensor_settings(client_data->settings_sel,
+					       &client_data->settings,
+					       &client_data->device);
+		check_error("bmp3_set_sensor_settings", ret);
+		break;
+	case BMP3_FIFO_FULL:
+		client_data->fifo_settings.mode = enable;
+		client_data->fifo_settings.ffull_en = enable;
+		ret = bmp3_set_fifo_settings(client_data->settings_fifo,
+					     &client_data->fifo_settings,
+					     &client_data->device);
+		check_error("bmp3_set_fifo_settings", ret);
+		client_data->fifo_full_en = enable;
+		client_data->settings.odr_filter.press_os = BMP3_NO_OVERSAMPLING;
+		client_data->settings.odr_filter.temp_os = BMP3_NO_OVERSAMPLING;
+		ret = bmp3_set_sensor_settings(client_data->settings_sel,
+					       &client_data->settings,
+					       &client_data->device);
+		check_error("bmp3_set_fifo_settings", ret);
+		break;
+	case BMP3_FIFO_WM:
+		client_data->fifo_settings.mode = enable;
+		client_data->fifo_settings.fwtm_en = enable;
+		ret = bmp3_set_fifo_settings(client_data->settings_fifo,
+					     &client_data->fifo_settings,
+					     &client_data->device);
+		check_error("bmp3_set_fifo_settings", ret);
+		if (client_data->fifo_settings.fwtm_en == BMP3_ENABLE) {
+			ret = bmp3_set_fifo_watermark(&client_data->fifo,
+						      &client_data->fifo_settings,
+						      &client_data->device);
+			check_error("bmp3_set_fifo_watermark", ret);
+		}
+		client_data->fifo_wm_en = enable;
+		client_data->settings.odr_filter.press_os = BMP3_OVERSAMPLING_2X;
+		client_data->settings.odr_filter.temp_os = BMP3_OVERSAMPLING_2X;
+		ret = bmp3_set_sensor_settings(client_data->settings_sel,
+					       &client_data->settings,
+					       &client_data->device);
+		check_error("bmp3_set_fifo_settings", ret);
+		break;
+	default:
+		pr_err("Invalid sensor handle: %d\n", config_func);
+		return -EINVAL;
+	}
+
+	if (ret) {
+		pr_err("set int map failed with ret code : %d\n", ret);
+		return -EIO;
+	}
+	pr_info("%s %s\n", bmp3_config_func_name[config_func],
+		bmp3_config_en_disable[enable]);
+	/*lint -e534*/
+	schedule_work(&client_data->irq_work);
+	/*lint -e534*/
+	return ret;
+}
+
+/**
+ * config_function_store - sysfs write callback which enable or disable
+ * the sleected sensor feature.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as input.
+ * @count: Number of characters in the buffer `buf`.
+ *
+ * Return: Number of characters used from buffer `buf`,
+ * which equals count.
+ */
+static ssize_t config_function_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int ret;
+	int config_func = 0;
+	int enable = 0;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	ret = sscanf(buf, "%11d %11d", &config_func, &enable);
+	if (ret != 2) {
+		pr_err("Invalid argument\nusage:\n");
+		pr_err("echo sensor_feature en_disable > config_function\n");
+		return -EINVAL;
+	}
+	ret = bmp3_sensor_feature_config(client_data, config_func, enable);
+	check_error("config function en/disable", ret);
+	return count;
+}
+
+/**
+ * fifo_data_frame_print - sysfs read callback which reads the fifo data
+ * from the sensor.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t fifo_data_frame_print(struct bmp3_client_data *client_data)
+{
+	struct bmp3_data *sensor_data;
+	u16 data_size = 0;
+	s8 rslt = 0;
+	u8 index = 0;
+	u16 fifo_length = 0;
+	u16 watermark = 0;
+	u8 *fifo_data;
+
+	mutex_lock(&client_data->lock);
+	fifo_data = kzalloc(FIFO_MAX_SIZE * FIFO_MAX_SIZE, GFP_KERNEL);
+	if (!fifo_data) {
+		mutex_unlock(&client_data->lock);
+		pr_err("%s memory error %d.\n", SENSOR_NAME, rslt);
+		return -ENOMEM;
+	}
+	rslt = bmp3_get_fifo_length(&fifo_length, &client_data->device);
+	check_error("bmp3_get_fifo_length", rslt);
+	if (client_data->fifo_wm_en == 1) {
+		rslt = bmp3_get_fifo_watermark(&watermark, &client_data->device);
+		check_error("bmp3_get_fifo_watermark", rslt);
+	}
+	client_data->fifo.buffer = fifo_data;
+	client_data->fifo.req_frames = FIFO_FRAME_COUNT;
+	rslt = bmp3_get_fifo_data(&client_data->fifo,
+				  &client_data->fifo_settings,
+				  &client_data->device);
+	check_error("bmp3_get_fifo_data", rslt);
+	client_data->fifo.req_frames = client_data->fifo.byte_count;
+	data_size = client_data->fifo.req_frames * sizeof(struct bmp3_data);
+
+	sensor_data = kzalloc(sizeof(u8) * FIFO_MAX_SIZE * 16, GFP_KERNEL);
+	if (!sensor_data) {
+		mutex_unlock(&client_data->lock);
+		pr_err("%s memory error %d.\n", SENSOR_NAME, rslt);
+		kfree(fifo_data);
+		return -ENOMEM;
+	}
+	if (rslt == BMP3_OK) {
+		if (client_data->fifo_wm_en == 1) {
+			pr_info("Fifo Watermark\n");
+			pr_info("Watermark level : %d\n", watermark);
+		}
+		pr_info("Available fifo length : %d\n", fifo_length);
+		pr_info("Fifo byte count from fifo structure : %d\n",
+			client_data->fifo.byte_count);
+		pr_info("FIFO frames requested : %d\n",
+			client_data->fifo.req_frames);
+
+		rslt = bmp3_extract_fifo_data(sensor_data, &client_data->fifo,
+					      &client_data->device);
+		check_error("bmp3_extract_fifo_data", rslt);
+		data_size =
+		client_data->fifo.parsed_frames * sizeof(struct bmp3_data);
+
+		pr_info("FIFO frames extracted : %d\n",
+			client_data->fifo.parsed_frames);
+
+		for (index = 0; index < client_data->fifo.parsed_frames; index++) {
+			pr_info("Frame[%d] , P : %llu, T :%lld deg C, Time : : %llu\n",
+				index, sensor_data[index].pressure,
+				sensor_data[index].temperature,
+				(u64)client_data->fifo.sensor_time);
+		}
+		data_size = 0;
+	}
+	mutex_unlock(&client_data->lock);
+	kfree(fifo_data);
+	kfree(sensor_data);
+	return data_size;
+}
+
+/*!
+ * @brief get fifo data via sysfs node
+ */
+static ssize_t fifo_data_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	u16 rslt;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+
+	rslt = fifo_data_frame_print(client_data);
+	check_error("fifo_data_frame_print", rslt);
+
+	return rslt;
+}
+
+/**
+ * self_test_show - sysfs read callback which gives the
+ * sensor low gas and high gas variant self test result.
+ *
+ * @dev: Device instance
+ * @attr: Instance of device attribute file
+ * @buf: Instance of the data buffer which serves as output.
+ *
+ * Return: Number of characters returned.
+ */
+static ssize_t self_test_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int err;
+	unsigned long self_test;
+	struct iio_dev *input = dev_to_iio_dev(dev);
+	struct bmp3_client_data *client_data = iio_priv(input);
+	struct bmp3_settings settings = { 0 };
+
+	err = kstrtoul(buf, 10, &self_test);
+	check_error("self test node input receive", err);
+	if (self_test) {
+		mutex_lock(&client_data->lock);
+		err = bmp3_selftest_check(&settings,
+					  &client_data->device);
+		check_error("bmp3_selftest_check", err);
+		mutex_unlock(&client_data->lock);
+		if (err) {
+			pr_err("selftest failed with return code : %d\n", err);
+			return -EIO;
+		}
+		pr_info("self test successful\n");
+	}
+	return count;
+}
+
+/**
+ * bmp390_read_axis_data - Reads axis data from the BMP390 sensor.
+ * @indio_dev: The IIO device structure.
+ * @reg_address: The register address to read data from.
+ * @data: Pointer to store the read data.
+ *
+ * This function reads either temperature or pressure data from the BMP390
+ * sensor based on the provided register address.
+ * It uses the bmp3_get_sensor_data function to retrieve the sensor data and
+ * stores the result in the provided data pointer.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+
+static int bmp390_read_axis_data(struct iio_dev *indio_dev,
+				 u8 reg_address,
+				 s32 *axis_data)
+{
+	int ret;
+	struct bmp3_data comp_data;
+	struct bmp3_client_data *client_data = iio_priv(indio_dev);
+
+	ret = bmp3_get_sensor_data(BMP3_PRESS_TEMP, &comp_data,
+				   &client_data->device);
+	check_error("bmp3_get_sensor_data", ret);
+	if (ret < 0)
+		return ret;
+	if (reg_address == BMP3_REG_TEMP_DATA)
+		*axis_data = comp_data.temperature;
+
+	else
+		*axis_data = (s32)comp_data.pressure;
+
+	return 0;
+}
+
+/**
+ * bmp390_read_raw - Read raw data from the BMP390 sensor
+ * @indio_dev: The IIO device structure
+ * @ch: The IIO channel specification
+ * @val: Pointer to store the raw value
+ * @val2: Pointer to store the second raw value (unused)
+ * @mask: The mask specifying the type of data to read
+ *
+ * This function reads raw data from the BMP390 sensor based on the specified
+ * channel type and mask. It supports reading temperature and pressure data.
+ *
+ * Return: IIO_VAL_INT on success, negative error code on failure.
+ */
+static int bmp390_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *ch, int *val,
+			   int *val2, long mask)
+{
+	int ret, result;
+	s32 tval = 0;
+	struct bmp3_client_data *client_data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case 0:
+	{
+		result = 0;
+		ret = IIO_VAL_INT;
+		mutex_lock(&client_data->lock);
+		switch (ch->type) {
+		case IIO_TEMP:
+			result = bmp390_read_axis_data(indio_dev,
+						       ch->address, &tval);
+			*val = tval;
+			break;
+		case IIO_PRESSURE:
+			result = bmp390_read_axis_data(indio_dev,
+						       ch->address, &tval);
+			*val = tval;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	mutex_unlock(&client_data->lock);
+	if (result < 0)
+		return result;
+	return ret;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * This file defines various IIO device attributes for the BMP390 sensor driver.
+ * Each attribute is associated with specific permissions and corresponding
+ * show and store functions for reading and writing the attribute values.
+ *
+ * Attributes:
+ * - chip_id: Read-only attribute to show the chip ID.
+ * - reg_val: Read-write attribute to show and store register values.
+ * - reg_sel: Read-write attribute to show and store register selection.
+ * - config_function: Read-write attribute to show and store
+ * configuration functions.
+ * - sensor_data: Read-only attribute to show sensor data.
+ * - soft_reset: Write-only attribute to call soft reset.
+ * - sensor_conf: Read-write attribute to show and store sensor configuration.
+ * - driver_version: Read-only attribute to show the driver version.
+ * - avail_sensor: Read-only attribute to show available sensors.
+ * - op_mode: Read-write attribute to show and store operation mode.
+ * - odr: Read-write attribute to show and store output data rate.
+ * - fifo_data: Read-only attribute to show FIFO data.
+ * - fifo_config: Read-write attribute to show and store FIFO configuration.
+ * - self_test: Write-only attribute to store self-test values.
+ * - iio_generic_buffer: Write-only attribute to store generic buffer values.
+ */
+static IIO_DEVICE_ATTR(chip_id, 0444, chip_id_show, NULL, 0);
+static IIO_DEVICE_ATTR(reg_val, 0644, reg_val_show, reg_val_store, 0);
+static IIO_DEVICE_ATTR(reg_sel, 0644, reg_sel_show, reg_sel_store, 0);
+static IIO_DEVICE_ATTR(config_function, 0644, config_function_show,
+						config_function_store, 0);
+static IIO_DEVICE_ATTR(sensor_data, 0444, sensor_data_show, NULL, 0);
+static IIO_DEVICE_ATTR(soft_reset, 0200, NULL, soft_reset_store, 0);
+static IIO_DEVICE_ATTR(sensor_conf, 0644, sensor_conf_show,
+						sensor_conf_store, 0);
+static IIO_DEVICE_ATTR(driver_version, 0444,
+							driver_version_show, NULL, 0);
+static IIO_DEVICE_ATTR(avail_sensor, 0444, avail_sensor_show, NULL, 0);
+static IIO_DEVICE_ATTR(op_mode, 0644, op_mode_show, op_mode_store, 0);
+static IIO_DEVICE_ATTR(odr, 0644, odr_show, odr_store, 0);
+static IIO_DEVICE_ATTR(fifo_data, 0444, fifo_data_show, NULL, 0);
+static IIO_DEVICE_ATTR(fifo_config, 0644, fifo_config_show,
+						fifo_config_store, 0);
+static IIO_DEVICE_ATTR(self_test, 0200, NULL, self_test_store, 0);
+static IIO_DEVICE_ATTR(iio_generic_buffer, 0200, NULL,
+							iio_generic_buffer_store, 0);
+
+/**
+ * bmp3_attributes - Array of pointers to device attributes
+ *
+ * This array contains pointers to various device attributes for the BMP390
+ * sensor driver. Each attribute represents a specific configuration or data
+ * point that can be accessed or modified. The attributes include:
+ *
+ * - chip_id: Identifier for the chip
+ * - reg_val: Value of a specific register
+ * - reg_sel: Selected register
+ * - config_function: Configuration function for the sensor
+ * - sensor_data: Data read from the sensor
+ * - soft_reset: Soft reset control
+ * - sensor_conf: Sensor configuration
+ * - driver_version: Version of the driver
+ * - avail_sensor: Available sensors
+ * - op_mode: Operating mode of the sensor
+ * - odr: Output data rate
+ * - fifo_data: Data from the FIFO buffer
+ * - fifo_config: Configuration of the FIFO buffer
+ * - self_test: Self-test control
+ * - iio_generic_buffer: Generic buffer for IIO
+ *
+ * The array is terminated with a NULL pointer.
+ */
+static struct attribute *bmp3_attributes[] = {
+	&iio_dev_attr_chip_id.dev_attr.attr,
+	&iio_dev_attr_reg_val.dev_attr.attr,
+	&iio_dev_attr_reg_sel.dev_attr.attr,
+	&iio_dev_attr_config_function.dev_attr.attr,
+	&iio_dev_attr_sensor_data.dev_attr.attr,
+	&iio_dev_attr_soft_reset.dev_attr.attr,
+	&iio_dev_attr_sensor_conf.dev_attr.attr,
+	&iio_dev_attr_driver_version.dev_attr.attr,
+	&iio_dev_attr_avail_sensor.dev_attr.attr,
+	&iio_dev_attr_op_mode.dev_attr.attr,
+	&iio_dev_attr_odr.dev_attr.attr,
+	&iio_dev_attr_fifo_data.dev_attr.attr,
+	&iio_dev_attr_fifo_config.dev_attr.attr,
+	&iio_dev_attr_self_test.dev_attr.attr,
+	&iio_dev_attr_iio_generic_buffer.dev_attr.attr,
+	NULL
+};
+
+/**
+ * struct attribute_group bmp3_attribute_group - Defines a group
+ * of attributes for the BMP3 sensor.
+ * @attrs: Pointer to the array of attribute structures.
+ */
+static struct attribute_group bmp3_attribute_group = {
+	.attrs = bmp3_attributes
+};
+
+/**
+ * struct iio_info bmp390_acc_iio_info - Provides information
+ * and operations for the BMP390 accelerometer.
+ * @attrs: Pointer to the attribute group for the BMP390.
+ * @read_raw: Function pointer to read raw data from the BMP390 sensor.
+ */
+static const struct iio_info bmp390_acc_iio_info = {
+	.attrs = &bmp3_attribute_group,
+	/*lint -e546*/
+	.read_raw = &bmp390_read_raw,
+	/*lint +e546*/
+};
+
+#if defined(BMP3_ENABLE_INT1) || defined(BMP3_ENABLE_INT2)
+
+/**
+ * bmp3_irq_work_func - Work function to handle BMP3 interrupts
+ * @work: Pointer to the work_struct associated with the interrupt
+ *
+ * This function is triggered by an interrupt and handles different types of
+ * interrupts from the BMP3 sensor. It checks the interrupt status and performs
+ * the appropriate actions based on the type of interrupt:
+ * - FIFO Watermark Interrupt: Logs the occurrence and processes FIFO data.
+ * - FIFO Full Interrupt: Logs the occurrence and processes FIFO data.
+ * - Data Ready Interrupt: Logs the occurrence, disables
+ * the data ready interrupt, and updates the sensor settings.
+ *
+ * The function uses the bmp3_get_status function to
+ * retrieve the interrupt status
+ * and the check_error function to handle any
+ * errors that occur during processing.
+ */
+static void bmp3_irq_work_func(struct work_struct *work)
+{
+	/*lint -e26 -e10 -e124 -e40 -e831 -e64 -e119 -e413 -e534*/
+	struct bmp3_client_data *client_data = container_of(work,
+		struct bmp3_client_data, irq_work);
+	/*lint +e26  +e10 +e124 +e40 +e831 +e64 +e119 +e413 +e534*/
+	int ret = 0;
+	struct bmp3_status status = { { 0 } };
+
+	ret = bmp3_get_status(&status, &client_data->device);
+	check_error("get int status", ret);
+
+	if (ret == BMP3_OK) {
+		if (status.intr.fifo_wm == BMP3_ENABLE &&
+		    client_data->fifo_wm_en == BMP3_ENABLE) {
+			pr_info("FIFO Watermark Interrupt occurred\n");
+			ret = fifo_data_frame_print(client_data);
+			check_error("fifo_data_frame_print", ret);
+		} else if ((status.intr.fifo_full == BMP3_ENABLE) &&
+				(client_data->fifo_full_en == BMP3_ENABLE)) {
+			pr_info("FIFO Full Interrupt occurred\n");
+			ret = fifo_data_frame_print(client_data);
+			check_error("fifo_data_frame_print", ret);
+		} else if ((status.intr.drdy == BMP3_ENABLE) &&
+			(client_data->data_ready_en == BMP3_ENABLE)) {
+			pr_info("Data ready Interrupt occurred\n");
+			client_data->settings.int_settings.drdy_en = BMP3_DISABLE;
+			client_data->settings_sel = BMP3_SEL_DRDY_EN;
+			client_data->data_ready_en = BMP3_DISABLE;
+			ret = bmp3_set_sensor_settings(client_data->settings_sel,
+						       &client_data->settings,
+						       &client_data->device);
+			check_error("bmp3_set_sensor_settings", ret);
+		}
+	}
+}
+
+/**
+ * bmp3_irq_handle - Interrupt handler for BMP3 sensor.
+ * @irq: The interrupt number.
+ * @handle: Pointer to the client data structure.
+ *
+ * This function is called when an interrupt is triggered by the BMP3 sensor.
+ * It schedules work to be done in the irq_work workqueue.
+ *
+ * Return: Always returns IRQ_HANDLED.
+ */
+static irqreturn_t bmp3_irq_handle(int irq, void *handle)
+{
+	struct bmp3_client_data *client_data = handle;
+	/*lint -e534*/
+	schedule_work(&client_data->irq_work);
+	/*lint +e534*/
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * bmp3_request_irq - Request an IRQ and initialize work for the BMP390 sensor.
+ * @client_data: Pointer to the BMP3 client data structure.
+ *
+ * This function requests an interrupt line for
+ * the BMP390 sensor and initializes
+ * a work structure for handling the interrupt.
+ * It logs the IRQ request and handles
+ * any errors that occur during the request.
+ *
+ * Return: 0 on success, -EIO if the IRQ request fails.
+ */
+static int bmp3_request_irq(struct bmp3_client_data *client_data)
+{
+	int ret = 0;
+
+	pr_info("Request IRQ : %d\n", client_data->IRQ);
+	ret = request_irq(client_data->IRQ, bmp3_irq_handle,
+			  IRQF_TRIGGER_RISING,
+			  SENSOR_NAME, client_data);
+	if (ret < 0) {
+		pr_err("request_irq failed with err:%d\n", ret);
+		return -EIO;
+	}
+	/* Lint  -e69 */
+	INIT_WORK(&client_data->irq_work, bmp3_irq_work_func);
+	/* Lint +e69 */
+
+	return ret;
+}
+#endif
+
+/**
+ * bmp3_probe - Probe function for the BMP390 sensor driver.
+ * @bmp390_iio_private: Pointer to the IIO device structure.
+ *
+ * This function initializes the BMP390 sensor and registers it with the IIO
+ * subsystem. It sets up the necessary device parameters, configures the buffer,
+ * and requests IRQs if needed. If any step fails, it performs cleanup and
+ * returns an appropriate error code.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int bmp3_probe(struct iio_dev *bmp390_iio_private)
+{
+	int ret = 0;
+	struct bmp3_client_data *client_data;
+
+	pr_info("BMP390 function entrance\n");
+
+	client_data = iio_priv(bmp390_iio_private);
+
+	if (!client_data) {
+		pr_err("client_data is NULL\n");
+		return -EINVAL;
+	}
+
+	client_data->device.delay_us = bmp3_delay_us;
+	bmp390_iio_private->channels = bmp390_iio_channels;
+	bmp390_iio_private->num_channels = ARRAY_SIZE(bmp390_iio_channels);
+	bmp390_iio_private->info = &bmp390_acc_iio_info;
+	bmp390_iio_private->modes = INDIO_DIRECT_MODE;
+
+	/*lint -e86*/
+	mutex_init(&client_data->lock);
+	/*lint +e86*/
+	ret = bmp390_iio_configure_buffer(bmp390_iio_private);
+	if (ret) {
+		pr_err("Failed to configure buffer for bmp390: error %d\n", ret);
+		goto exit_err_clean;
+	}
+	ret = iio_device_register(bmp390_iio_private);
+	if (ret) {
+		pr_err("Failed to register iio device for bmp390: error %d\n", ret);
+		goto exit_err_clean;
+	}
+
+	ret = bmp3_init(&client_data->device);
+	bmp3_delay_us(MS_TO_US(10), &client_data->device.intf_ptr);
+	check_error("bmp3_init", ret);
+	if (ret) {
+		pr_err("bmp390 initialization failed with error %d\n", ret);
+		goto exit_err_clean;
+	}
+	/* Request irq and config*/
+	#if defined(BMP3_ENABLE_INT1) || defined(BMP3_ENABLE_INT2)
+	ret = bmp3_request_irq(client_data);
+	if (ret < 0) {
+		pr_err("Failed to request IRQ for bmp390\n");
+		goto exit_err_clean;
+	}
+	#endif
+
+	pr_info("Sensor %s probed successfully\n", SENSOR_NAME);
+
+	return 0;
+
+exit_err_clean:
+	bmp390_iio_unconfigure_buffer(bmp390_iio_private);
+	if (bmp390_iio_private)
+		iio_device_unregister(bmp390_iio_private);
+	pr_err("Error occurred during bmp390 probe\n");
+	return ret;
+}
+
+/**
+ * bmp3_probe - Exported symbol for the BMP3 probe function.
+ *
+ * This symbol is exported for use in other kernel modules. The bmp3_probe
+ * function is responsible for initializing the BMP3 sensor device.
+ */
+/* Lint -save -e19 */
+EXPORT_SYMBOL(bmp3_probe);
+/* Lint -restore */
+
+/**
+ * bmp3_remove - Remove the BMP390 IIO device
+ * @bmp390_iio_private: Pointer to the IIO device structure
+ *
+ * This function performs the necessary cleanup when removing the BMP390
+ * IIO device. It retrieves the client data, introduces a delay, unconfigures
+ * the buffer, unregisters the device, and frees the IRQ.
+ *
+ * Return: Always returns 0.
+ */
+void bmp3_remove(struct iio_dev *bmp390_iio_private)
+{
+	struct bmp3_client_data *client_data;
+
+	client_data = iio_priv(bmp390_iio_private);
+	if (client_data) {
+		bmp3_delay_us(MS_TO_US(300),
+			      &client_data->device.intf_ptr);
+		bmp390_iio_unconfigure_buffer(bmp390_iio_private);
+		if (bmp390_iio_private)
+			iio_device_unregister(bmp390_iio_private);
+		(void)free_irq(client_data->IRQ, client_data);
+	}
+}
+EXPORT_SYMBOL(bmp3_remove);
+
+MODULE_AUTHOR("contact@bosch-sensortec.com");
+MODULE_DESCRIPTION("BMP390 PRESSURE SENSOR DRIVER");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/iio/pressure/bmp390/bmp390_driver.h b/drivers/iio/pressure/bmp390/bmp390_driver.h
new file mode 100644
index 000000000000..6d71ff3b5068
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp390_driver.h
@@ -0,0 +1,232 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp390_driver.h
+ * @date		2025-06-02
+ * @version		v2.2.0
+ *
+ * @brief		 BMP390 Linux IIO Driver Header file
+ *
+ */
+
+#ifndef BMP3_DRIVER_H
+#define BMP3_DRIVER_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+/*********************************************************************/
+/* System header files */
+/*********************************************************************/
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/workqueue.h>
+#include <generated/autoconf.h>
+#include <linux/slab.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+#include <linux/string.h>
+#include <linux/iio/sw_device.h>
+#include <linux/export.h>
+#include <linux/bitmap.h>
+#include <linux/hrtimer.h>
+#include <linux/ktime.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/syscalls.h>
+#include <linux/iio/sw_trigger.h>
+#include <linux/err.h>
+#include <linux/container_of.h>
+
+/*********************************************************************/
+/* Own header files */
+/*********************************************************************/
+#include "bmp3.h"
+#include "bmp3_defs.h"
+#include "bmp3_selftest.h"
+
+/*********************************************************************/
+/* Macro definitions */
+/*********************************************************************/
+/** Name of the device driver and IIO device*/
+#define SENSOR_NAME "bmp390"
+
+/* Enable interrupt 1 */
+#define BMP3_ENABLE_INT1				(1)
+/* Maximum number of retries for I2C transfer. */
+#define BMP3_MAX_RETRY_I2C_XFER			(10)
+/* Delay time for I2C write operations. */
+#define BMP3_I2C_WRITE_DELAY_TIME		(1)
+/* default sampling frequency - 100Hz */
+#define HRTIMER_DEFAULT_SAMPLING_FREQUENCY 100
+/* Defines frame count requested
+ * As, only Pressure is enabled in this example,
+ * Total byte count requested :
+ * FIFO_FRAME_COUNT * BMP3_LEN_P_OR_T_HEADER_DATA
+ */
+#define FIFO_FRAME_COUNT  UINT8_C(50)
+/* Maximum FIFO size */
+#define FIFO_MAX_SIZE     UINT16_C(1024)
+/**
+ * enum bmp3_config_func - Enumerations to select the sensors
+ */
+enum bmp3_config_func {
+	BMP3_DATA_READY,
+	BMP3_FIFO_FULL,
+	BMP3_FIFO_WM
+};
+
+/**
+ * struct iio_hrtimer_info - High-resolution timer information for IIO
+ * @swt: Software trigger associated with the high-resolution timer
+ * @timer: High-resolution timer structure
+ * @sampling_frequency: Sampling frequency for the timer
+ * @period: Timer period in ktime_t format
+ */
+
+struct iio_hrtimer_info {
+	struct iio_sw_trigger swt;
+	struct hrtimer timer;
+	unsigned long sampling_frequency;
+	ktime_t period;
+};
+
+/**
+ *	struct bmp3_client_data - Client structure which holds sensor-specific
+ *	information.
+ */
+struct bmp3_client_data {
+	struct bmp3_dev device;
+	struct device *dev;
+	struct iio_trigger *bmp_init;
+	struct iio_trigger *feat_input;
+	/*! lock: Mutex to protect access to the device data */
+	struct mutex lock;
+	unsigned int IRQ;
+	struct work_struct irq_work;
+	struct bmp3_fifo_settings fifo_settings;
+	struct bmp3_settings settings;
+	struct bmp3_fifo_data fifo;
+	struct iio_hrtimer_info *trig_info;
+	u8 reg_sel;
+	int reg_len;
+	const char *name;
+	u8 data_ready_en;
+	u8 fifo_full_en;
+	u8 fifo_wm_en;
+	u16 settings_sel;
+	u16 settings_fifo;
+};
+
+/**
+ * struct bmp3_sensor_data - Structure to hold BMP390 sensor data.
+ * @temp:  Array to store temperature data as a string.
+ * @press: Array to store pressure data as a string.
+ * @time:  Array to store timestamp data as a string.
+ */
+struct bmp3_sensor_data {
+	char temp[16];
+	char press[16];
+	char time[16];
+};
+
+/*********************************************************************/
+/* Function prototype declarations */
+/*********************************************************************/
+/*extern the iio_dev of three devices*/
+extern struct iio_dev *data_iio_private;
+/**
+ * bmp390_iio_configure_buffer() - register buffer resources
+ * @indo_dev: device instance state
+ */
+int bmp390_iio_configure_buffer(struct iio_dev *indio_dev);
+/**
+ * bmp390_iio_unconfigure_buffer() - release buffer resources
+ * @indo_dev: device instance state
+ */
+void bmp390_iio_unconfigure_buffer(struct iio_dev *indio_dev);
+/**
+ * bmp390_iio_allocate_trigger() - register trigger resources
+ * @indo_dev: device instance state
+ */
+int bmp390_iio_allocate_trigger(struct iio_dev *indio_dev);
+/**
+ * bmp390_iio_deallocate_trigger() - release trigger resources
+ * @indo_dev: device instance state
+ */
+void bmp390_iio_deallocate_trigger(struct iio_dev *indio_dev);
+/**
+ * bmp3_probe - This is the probe function for bmp3 sensor.
+ * Called from the I2C driver probe function to initialize the sensor.
+ *
+ * @client_data : Structure instance of client data.
+ * @dev : Structure instance of device.
+ *
+ * Return : Result of execution status
+ * * 0 - Success
+ * * negative value -> Error
+ */
+int bmp3_probe(struct iio_dev *data_iio_private);
+
+/**
+ * bmp3_suspend - This function puts the driver
+ * and device to suspend mode.
+ *
+ * @dev : Structure instance of device.
+ *
+ * Return : Result of execution status
+ * * 0 - Success
+ * * negative value -> Error
+ */
+int bmp3_suspend(struct device *dev);
+
+/**
+ * bmp3_resume - This function is used to bring back
+ * device from suspend mode.
+ *
+ * @dev	 : Structure instance of device.
+ *
+ * Return : Result of execution status
+ * * 0 - Success
+ * * negative value -> Error
+ */
+int bmp3_resume(struct device *dev);
+
+/**
+ * bmp3_remove - This function removes the driver from the device.
+ *
+ * @dev : Structure instance of device.
+ *
+ * Return : Result of execution status
+ * * 0 - Success
+ */
+void bmp3_remove(struct iio_dev *data_iio_private);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* BMP3_DRIVER_H_	*/
+
diff --git a/drivers/iio/pressure/bmp390/bmp390_i2c.c b/drivers/iio/pressure/bmp390/bmp390_i2c.c
new file mode 100644
index 000000000000..9d0aea7aa1cc
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp390_i2c.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp390_i2c.c
+ * @date		2025-06-02
+ * @version		v2.2.0
+ *
+ * @brief		 BMP390 I2C bus Driver
+ *
+ */
+
+/*********************************************************************/
+/* system header files */
+/*********************************************************************/
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/input.h>
+
+/*********************************************************************/
+/* own header files */
+/*********************************************************************/
+#include "bmp390_driver.h"
+
+/*********************************************************************/
+/* global variables */
+/*********************************************************************/
+static struct i2c_client *bmp3_i2c_client;
+struct iio_dev *iio_i2c_dev;
+
+/**
+ *	bmp390_i2c_init - I2C driver init function.
+ *
+ *	Return : Status of the suspend function.
+ *	* 0 - OK.
+ *	* Negative value - Error.
+ */
+static int __init bmp390_i2c_init(void);
+
+/**
+ *	bmp390_i2c_exit - I2C driver exit function.
+ */
+static void __exit bmp390_i2c_exit(void);
+
+/**
+ * bmp390_i2c_read - The I2C read function.
+ *
+ * @client : Instance of the I2C client
+ * @reg_addr : The register address from where the data is read.
+ * @sdata : The pointer to buffer to return data.
+ * @len : The number of bytes to be read
+ *
+ * Return : Status of the function.
+ * * 0 - OK
+ * * negative value - Error.
+ */
+static s8 bmp390_i2c_read(struct i2c_client *client,
+			  u8 reg_addr, u8 *sdata, u16 len)
+{
+	s32 retry;
+	struct i2c_msg msg[] = {
+		{
+		.addr = client->addr,
+		.flags = 0,
+		.len = 1,
+		.buf = &reg_addr,
+		},
+
+		{
+		.addr = client->addr,
+		.flags = I2C_M_RD,
+		.len = len,
+		.buf = sdata,
+		},
+	};
+
+	for (retry = 0; retry < BMP3_MAX_RETRY_I2C_XFER; retry++) {
+		if (i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg)) > 0)
+			break;
+		usleep_range(BMP3_I2C_WRITE_DELAY_TIME * 1000,
+			     BMP3_I2C_WRITE_DELAY_TIME * 1000);
+	}
+
+	if (retry >= BMP3_MAX_RETRY_I2C_XFER) {
+		pr_err("I2C xfer error\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * bmp390_i2c_write - The I2C write function.
+ *
+ * @client : Instance of the I2C client
+ * @reg_addr : The register address to start writing the data.
+ * @sdata : The pointer to buffer holding data to be written.
+ * @len : The number of bytes to write.
+ *
+ * Return : Status of the function.
+ * * 0 - OK
+ * * negative value - Error.
+ */
+static s8 bmp390_i2c_write(struct i2c_client *client,
+			   u8 reg_addr, const u8 *sdata, u16 len)
+{
+	s32 retry;
+
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.flags = 0,
+		.len = len + 1,
+		.buf = NULL,
+	};
+	msg.buf = kmalloc(len + 1, GFP_KERNEL);
+	if (!msg.buf) {
+		pr_err("Allocate memory failed\n");
+		return -ENOMEM;
+	}
+	msg.buf[0] = reg_addr;
+	memcpy(&msg.buf[1], sdata, len);
+	for (retry = 0; retry < BMP3_MAX_RETRY_I2C_XFER; retry++) {
+		if (i2c_transfer(client->adapter, &msg, 1) > 0)
+			break;
+		usleep_range(BMP3_I2C_WRITE_DELAY_TIME * 1000,
+			     BMP3_I2C_WRITE_DELAY_TIME * 1000);
+	}
+	kfree(msg.buf);
+	if (retry >= BMP3_MAX_RETRY_I2C_XFER) {
+		pr_err("I2C xfer error\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * bmp390_i2c_read_wrapper -
+ * The I2C read function pointer used by BMP390 API.
+ *
+ * @dev_addr : I2c Device address
+ * @reg_addr : The register address to read the data.
+ * @sdata : The pointer to buffer to return data.
+ * @len : The number of bytes to be read
+ *
+ * Return : Status of the function.
+ * * 0 - OK
+ * * negative value - Error.
+ */
+static s8 bmp390_i2c_read_wrapper(u8 reg_addr, u8 *sdata,
+				  u32 len, void *intf_ptr)
+{
+	s8 err;
+
+	err = bmp390_i2c_read(bmp3_i2c_client, reg_addr, sdata, len);
+	return err;
+}
+
+/**
+ * bmp390_i2c_write_wrapper - The I2C write function pointer used by BMP390 API.
+ *
+ * @dev_addr : I2c Device address
+ * @reg_addr : The register address to start writing the data.
+ * @sdata : The pointer to buffer which holds the data to be written.
+ * @len : The number of bytes to be written.
+ *
+ * Return : Status of the function.
+ * * 0 - OK
+ * * negative value - Error.
+ */
+static s8 bmp390_i2c_write_wrapper(u8 reg_addr, const u8 *sdata,
+				   u32 len, void *intf_ptr)
+{
+	s8 err;
+
+	err = bmp390_i2c_write(bmp3_i2c_client, reg_addr, sdata, len);
+	return err;
+}
+
+/**
+ * bmp390_i2c_probe - The I2C probe function called by I2C bus driver.
+ *
+ * @client : The I2C client instance
+ * @id : The I2C device ID instance
+ *
+ * Return : Status of the function.
+ * * 0 - OK
+ * * negative value - Error.
+ */
+static int bmp390_i2c_probe(struct i2c_client *client)
+{
+	int err;
+	u8 dev_id;
+	const struct i2c_device_id *id;
+	struct bmp3_client_data *client_data = NULL;
+
+	pr_info("entrance\n");
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		pr_err("i2c_check_functionality error!\n");
+		pr_err("I2C adapter is not supported\n");
+		err = -EIO;
+		goto exit_err_clean;
+	}
+	id = i2c_client_get_device_id(client);
+	if (!bmp3_i2c_client) {
+		bmp3_i2c_client = client;
+	} else {
+		pr_err("this driver does not support multiple clients\n");
+		err = -EBUSY;
+		goto exit_err_clean;
+	}
+
+	client_data = kzalloc(sizeof(*client_data),
+			      GFP_KERNEL);
+	if (!client_data) {
+		err = -ENOMEM;
+		goto exit_err_clean;
+	}
+	iio_i2c_dev = devm_iio_device_alloc(&client->dev,
+					    sizeof(*client_data));
+	if (!iio_i2c_dev)
+		return -ENOMEM;
+	/* h/w init */
+
+	client_data->device.intf_ptr = client;
+	dev_id = BMP3_I2C_INTF;
+	client_data = iio_priv(iio_i2c_dev);
+	client_data->device.intf_ptr = &dev_id;
+	client_data->device.intf = BMP3_I2C_INTF;
+	client_data->device.read = bmp390_i2c_read_wrapper;
+	client_data->device.write = bmp390_i2c_write_wrapper;
+	client_data->IRQ = client->irq;
+	iio_i2c_dev->dev.parent = &client->dev;
+	iio_i2c_dev->name = "bmp390";
+	iio_i2c_dev->modes = INDIO_DIRECT_MODE;
+	/*only assign iio_i2c_dev*/
+	i2c_set_clientdata(client, iio_i2c_dev);
+	if (id)
+		client_data->name = id->name;
+
+	pr_info("call BMP390 probe\n");
+	return bmp3_probe(iio_i2c_dev);
+
+exit_err_clean:
+	if (err)
+		bmp3_i2c_client = NULL;
+	i2c_set_clientdata(client, NULL);
+	if (iio_i2c_dev)
+		iio_device_free(iio_i2c_dev);
+	return err;
+}
+
+/**
+ *	bmp390_i2c_remove - Callback called when device is unbinded.
+ *	@client : Instance of I2C client device.
+ *
+ *	Return : Status of the suspend function.
+ *	* 0 - OK.
+ *	* Negative value - Error.
+ */
+static void bmp390_i2c_remove(struct i2c_client *client)
+{
+	bmp3_remove(iio_i2c_dev);
+	bmp3_i2c_client = NULL;
+}
+
+static const struct i2c_device_id bmp390_id[] = {
+	{ SENSOR_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bmp390_id);
+
+static const struct of_device_id bmp390_of_match[] = {
+	{ .compatible = "bosch,bmp390", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bmp390_of_match);
+
+static struct i2c_driver bmp390_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = SENSOR_NAME,
+		.of_match_table = bmp390_of_match,
+	},
+	.class = I2C_CLASS_HWMON,
+	.id_table = bmp390_id,
+	.probe = bmp390_i2c_probe,
+	.remove = bmp390_i2c_remove,
+};
+
+/**
+ *	bmp390_i2c_init - I2C driver init function.
+ *
+ *	Return : Status of the suspend function.
+ *	* 0 - OK.
+ *	* Negative value - Error.
+ */
+static int __init bmp390_i2c_init(void)
+{
+	return i2c_add_driver(&bmp390_driver);
+}
+
+/**
+ *	bmp390_i2c_exit - I2C driver exit function.
+ */
+static void __exit bmp390_i2c_exit(void)
+{
+	i2c_del_driver(&bmp390_driver);
+}
+
+MODULE_AUTHOR("contact@bosch-sensortec.com>");
+MODULE_DESCRIPTION("BMP390 SENSOR I2C DRIVER");
+MODULE_LICENSE("GPL");
+/*lint -e19 -e546 -e611*/
+module_init(bmp390_i2c_init);
+module_exit(bmp390_i2c_exit);
+/*lint +e19 +e546 +e611*/
+
diff --git a/drivers/iio/pressure/bmp390/bmp390_iio_buffer.c b/drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
new file mode 100644
index 000000000000..6d7e325fbe06
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp390_iio_buffer.c
+ * @date		2025-06-02
+ * @version		v2.2.0
+ *
+ * @brief		BMP390 Linux Driver IIO Buffer Source
+ *
+ */
+
+#include "bmp390_driver.h"
+
+static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state);
+/**
+ * bmp390_iio_trigger_h() - the trigger handler function
+ * @irq: the interrupt number
+ * @p: private data - always a pointer to the poll func.
+ *
+ */
+static irqreturn_t bmp390_iio_trigger_h(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	u64 *iio_data;
+	unsigned int i, j;
+	int rslt;
+	struct bmp3_client_data *client_data = iio_priv(indio_dev);
+	struct bmp3_data sensor_data = { 0 };
+
+	iio_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (!iio_data)
+		goto done;
+
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
+		for (i = 0, j = 0;
+		     i < bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
+		     i++, j++) {
+			j = find_next_bit(indio_dev->active_scan_mask,
+					  indio_dev->masklength, j);
+
+			rslt = bmp3_get_sensor_data(BMP3_PRESS_TEMP,
+						    &sensor_data,
+						    &client_data->device);
+			if (rslt)
+				pr_err("Failed to get sensor data %d\n", rslt);
+			iio_data[0] = (int64_t)sensor_data.pressure;
+			iio_data[1] = sensor_data.temperature;
+		}
+	}
+	/*lint -e534*/
+	iio_push_to_buffers_with_timestamp(indio_dev, iio_data,
+					   iio_get_time_ns(indio_dev));
+	/*lint +e534*/
+	kfree(iio_data);
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_buffer_setup_ops iio_bmp390_buffer_setup_ops = {
+};
+
+/**
+ * bmp390_iio_configure_buffer() - register buffer resources
+ * @indo_dev: device instance state
+ */
+int bmp390_iio_configure_buffer(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct iio_buffer *buffer;
+
+	buffer = iio_kfifo_allocate();
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	(void)iio_device_attach_buffer(indio_dev, buffer);
+
+	indio_dev->setup_ops = &iio_bmp390_buffer_setup_ops;
+	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
+						 bmp390_iio_trigger_h,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "%s-dev%d", indio_dev->name,
+						 iio_device_id(indio_dev));
+	if (!indio_dev->pollfunc) {
+		ret = -ENOMEM;
+		goto error_free_buffer;
+	}
+
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
+
+	return 0;
+
+error_free_buffer:
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+error_ret:
+	iio_kfifo_free(indio_dev->buffer);
+	return ret;
+}
+
+/**
+ * bmp390_iio_unconfigure_buffer() - release buffer resources
+ * @indo_dev: device instance state
+ */
+void bmp390_iio_unconfigure_buffer(struct iio_dev *indio_dev)
+{
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+	iio_kfifo_free(indio_dev->buffer);
+}
+
+static enum hrtimer_restart iio_hrtimer_trig_handler(struct hrtimer *timer)
+{
+	/*lint -e26 -e10 -e516 -e124 -e40 -e831 -e64 -e119 -e413 -e534*/
+	struct iio_hrtimer_info *info = container_of(timer,
+		struct iio_hrtimer_info, timer);
+	/*lint +e26  +e10 +e516 +e124 +e40 +e831 +e64 +e119 +e413 +e534*/
+	/*lint -e534*/
+	hrtimer_forward_now(timer, info->period);
+	/*lint +e534*/
+	iio_trigger_poll(info->swt.trigger);
+
+	return HRTIMER_RESTART;
+}
+
+static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_hrtimer_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(trig);
+	if (state)
+		hrtimer_start(&trig_info->timer, trig_info->period,
+			      HRTIMER_MODE_REL_HARD);
+	else
+		/*lint -e534*/
+		hrtimer_cancel(&trig_info->timer);
+		/*lint +e534*/
+
+	return 0;
+}
+
+static const struct iio_trigger_ops iio_hrtimer_trigger_ops = {
+	/*lint -e546*/
+	.set_trigger_state = iio_trig_hrtimer_set_state,
+	/*lint +e546*/
+};
+
+/**
+ * bmp390_iio_allocate_trigger() - register trigger resources
+ * @indo_dev: device instance state
+ */
+int bmp390_iio_allocate_trigger(struct iio_dev *indio_dev)
+{
+	struct bmp3_client_data *sdata = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (!sdata->trig_info) {
+		sdata->trig_info = kzalloc(sizeof(*sdata->trig_info), GFP_KERNEL);
+		if (!sdata->trig_info)
+			return -ENOMEM;
+
+		sdata->trig_info->swt.trigger =
+		iio_trigger_alloc(indio_dev->dev.parent,
+				  "%s-dev%d",
+				  indio_dev->name,
+				  iio_device_id(indio_dev));
+		if (!sdata->trig_info->swt.trigger) {
+			ret = -ENOMEM;
+			goto err_free_trig_info;
+		}
+		iio_trigger_set_drvdata(sdata->trig_info->swt.trigger,
+					sdata->trig_info);
+		sdata->trig_info->swt.trigger->ops = &iio_hrtimer_trigger_ops;
+		hrtimer_setup(&sdata->trig_info->timer, iio_hrtimer_trig_handler,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+		sdata->trig_info->sampling_frequency =
+								HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
+		sdata->trig_info->period = ns_to_ktime(10000000);
+		ret = iio_trigger_register(sdata->trig_info->swt.trigger);
+		if (ret)
+			goto err_free_trigger;
+	}
+	return ret;
+err_free_trigger:
+	iio_trigger_free(sdata->trig_info->swt.trigger);
+err_free_trig_info:
+	kfree(sdata->trig_info);
+	return ret;
+}
+
+/**
+ * bmp390_iio_deallocate_trigger() - release trigger resources
+ * @indo_dev: device instance state
+ */
+void bmp390_iio_deallocate_trigger(struct iio_dev *indio_dev)
+{
+	struct bmp3_client_data *sdata = iio_priv(indio_dev);
+
+	if (sdata->trig_info) {
+		iio_trigger_unregister(sdata->trig_info->swt.trigger);
+		/* cancel the timer after unreg to make sure no one rearms it */
+		/*lint -e534*/
+		hrtimer_cancel(&sdata->trig_info->timer);
+		/*lint +e534*/
+		iio_trigger_free(sdata->trig_info->swt.trigger);
+		kfree(sdata->trig_info);
+		sdata->trig_info = NULL;
+	}
+}
+
diff --git a/drivers/iio/pressure/bmp390/bmp390_spi.c b/drivers/iio/pressure/bmp390/bmp390_spi.c
new file mode 100644
index 000000000000..9c171df4cb5f
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp390_spi.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp390_spi.c
+ * @date		2025-06-02
+ * @version		v2.2.0
+ *
+ * @brief		BMP3 SPI bus Driver
+ *
+ */
+
+/*********************************************************************/
+/* system header files */
+/*********************************************************************/
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/input.h>
+
+/*********************************************************************/
+/* own header files */
+/*********************************************************************/
+#include "bmp390_driver.h"
+
+/*********************************************************************/
+/* Local macro definitions */
+/*********************************************************************/
+#define BMP3_MAX_BUFFER_SIZE		32
+
+/*********************************************************************/
+/* global variables */
+/*********************************************************************/
+static struct spi_device *bmp3_spi_client;
+struct iio_dev *iio_spi_dev;
+
+/*!
+ * @brief define spi block write function
+ *
+ * @param[in] reg_addr register address
+ * @param[in] sdata the pointer of data buffer
+ * @param[in] len block size need to write
+ *
+ * @return zero success, non-zero failed
+ * @retval zero success
+ * @retval non-zero failed
+ */
+static s8 bmp3_spi_write_block(u8 reg_addr, const u8 *sdata, u8 len)
+{
+	struct spi_device *client = bmp3_spi_client;
+	u8 buffer[BMP3_MAX_BUFFER_SIZE + 1];
+	struct spi_transfer xfer = {
+		.tx_buf = buffer,
+		.len = len + 1,
+	};
+	struct spi_message msg;
+
+	if (len > BMP3_MAX_BUFFER_SIZE)
+		return -EINVAL;
+
+	buffer[0] = reg_addr & 0x7F;/* write: MSB = 0 */
+	memcpy(&buffer[1], sdata, len);
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	return spi_sync(client, &msg);
+}
+
+/*!
+ * @brief define spi block read function
+ *
+ * @param[in] reg_addr register address
+ * @param[out] sdata the pointer of data buffer
+ * @param[in] len block size need to read
+ *
+ * @return zero success, non-zero failed
+ * @retval zero success
+ * @retval non-zero failed
+ */
+static s8 bmp3_spi_read_block(u8 reg_addr, u8 *sdata, uint16_t len)
+{
+	struct spi_device *client = bmp3_spi_client;
+	u8 reg = reg_addr | 0x80;/* read: MSB = 1 */
+	struct spi_transfer xfer[2] = {
+		[0] = {
+			.tx_buf = &reg,
+			.len = 1,
+		},
+		[1] = {
+			.rx_buf = sdata,
+			.len = len,
+		}
+	};
+	struct spi_message msg;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer[0], &msg);
+	spi_message_add_tail(&xfer[1], &msg);
+	return spi_sync(client, &msg);
+}
+
+/**
+ * bmp3_spi_write_wrapper - The SPI write function pointer used by BMP3 API.
+ *
+ * @reg_addr : The register address to start writing the data.
+ * @sdata : The pointer to buffer which holds the data to be written.
+ * @len : The number of bytes to be written.
+ * @intf_ptr  : Void pointer that can enable the linking of descriptors
+ *			for interface related call backs.
+ *
+ * Return : Status of the function.
+ * * 0 - OK
+ * * negative value - Error.
+ */
+static s8 bmp3_spi_write_wrapper(u8 reg_addr, const u8 *sdata,
+				 u32 len, void *intf_ptr)
+{
+	s8 err;
+
+	err = bmp3_spi_write_block(reg_addr, sdata, len);
+	return err;
+}
+
+/**
+ * bmp3_spi_read_wrapper - The SPI read function pointer used by BMP3 API.
+ *
+ * @reg_addr : The register address to read the data.
+ * @sdata : The pointer to buffer to return data.
+ * @len : The number of bytes to be read
+ *
+ * Return : Status of the function.
+ * * 0 - OK
+ * * negative value - Error.
+ */
+static s8 bmp3_spi_read_wrapper(u8 reg_addr,
+				u8 *sdata, u32 len, void *intf_ptr)
+{
+	s8 err;
+
+	err = bmp3_spi_read_block(reg_addr, sdata, len);
+	return err;
+}
+
+/*!
+ * @brief sensor probe function via spi bus
+ *
+ * @param[in] client the pointer of spi client
+ *
+ * @return zero success, non-zero failed
+ * @retval zero success
+ * @retval non-zero failed
+ */
+static int bmp3_spi_probe(struct spi_device *client)
+{
+	int status;
+	int err = 0;
+	u8 dev_id;
+	struct bmp3_client_data *client_data = NULL;
+
+	if (!bmp3_spi_client) {
+		bmp3_spi_client = client;
+	} else {
+		pr_err("This driver does not support multiple clients!\n");
+		return -EBUSY;
+	}
+	client->bits_per_word = 8;
+	status = spi_setup(client);
+	if (status < 0) {
+		pr_err("spi_setup failed!\n");
+		return status;
+	}
+	client_data = kzalloc(sizeof(*client_data), GFP_KERNEL);
+	if (!client_data) {
+		err = -ENOMEM;
+		goto exit_err_clean;
+	}
+	iio_spi_dev = devm_iio_device_alloc(&client->dev, sizeof(*client_data));
+	if (!iio_spi_dev)
+		return -ENOMEM;
+	client_data = iio_priv(iio_spi_dev);
+	client_data->dev = &client->dev;
+	dev_id = BMP3_SPI_INTF;
+	client_data->device.intf_ptr = &dev_id;
+	client_data->device.intf = BMP3_SPI_INTF;
+	client_data->IRQ = client->irq;
+	client_data->device.read = bmp3_spi_read_wrapper;
+	client_data->device.write = bmp3_spi_write_wrapper;
+	iio_spi_dev->dev.parent = &client->dev;
+	iio_spi_dev->name = "bmp390";
+	iio_spi_dev->modes = INDIO_DIRECT_MODE;
+	dev_set_drvdata(&client->dev, iio_spi_dev);
+
+	return bmp3_probe(iio_spi_dev);
+
+exit_err_clean:
+	if (err)
+		bmp3_spi_client = NULL;
+	if (iio_spi_dev)
+		iio_device_free(iio_spi_dev);
+	return err;
+}
+
+/*!
+ * @brief remove bmi spi client
+ *
+ * @param[in] client the pointer of spi client
+ *
+ * @return zero
+ * @retval zero
+ */
+static void bmp3_spi_remove(struct spi_device *client)
+{
+	bmp3_remove(iio_spi_dev);
+	bmp3_spi_client = NULL;
+}
+
+/*!
+ * @brief register spi device id
+ */
+static const struct spi_device_id bmp3_id[] = {
+	{ SENSOR_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, bmp3_id);
+
+/*!
+ * @brief register bmp3 device id match
+ */
+static const struct of_device_id bmp3_of_match[] = {
+	{ .compatible = "bosch,bmp390", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bmp3_of_match);
+
+/*!
+ * @brief register spi driver hooks
+ */
+static struct spi_driver bmp3_spi_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name  = SENSOR_NAME,
+		.of_match_table = bmp3_of_match,
+	},
+	.id_table = bmp3_id,
+	.probe	  = bmp3_spi_probe,
+	.remove	  = bmp3_spi_remove,
+};
+
+/*!
+ * @brief initialize bmi spi module
+ *
+ * @return zero success, non-zero failed
+ * @retval zero success
+ * @retval non-zero failed
+ */
+static int __init bmp3_spi_init(void)
+{
+	return spi_register_driver(&bmp3_spi_driver);
+}
+
+/*!
+ * @brief remove bmi spi module
+ *
+ * @return no return value
+ */
+static void __exit bmp3_spi_exit(void)
+{
+	spi_unregister_driver(&bmp3_spi_driver);
+}
+
+MODULE_AUTHOR("Contact <contact@bosch-sensortec.com>");
+MODULE_DESCRIPTION("BMP390 SENSOR SPI DRIVER");
+MODULE_LICENSE("GPL");
+/*lint -e19 -e546 -e611*/
+module_init(bmp3_spi_init);
+module_exit(bmp3_spi_exit);
+/*lint +e19 +e546 +e611*/
+
diff --git a/drivers/iio/pressure/bmp390/bmp3_defs.h b/drivers/iio/pressure/bmp390/bmp3_defs.h
new file mode 100644
index 000000000000..e3c69887cf36
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp3_defs.h
@@ -0,0 +1,871 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @brief	   Sensor driver for BMP3 sensor
+ * @file       bmp3_defs.h
+ * @date       2022-07-18
+ * @version    v2.0.7
+ *
+ */
+#ifndef BMP3_DEFS_H_
+#define BMP3_DEFS_H_
+
+/*! CPP guard */
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/********************************************************/
+/* header includes */
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#else
+#include <stdint.h>
+#include <stddef.h>
+#endif
+#include <linux/types.h>
+/*************************** Common macros   *****************************/
+
+#if !defined(UINT8_C) && !defined(INT8_C)
+#define INT8_C(x)    S8_C(x)
+#define UINT8_C(x)   U8_C(x)
+#endif
+
+#if !defined(UINT16_C) && !defined(INT16_C)
+#define INT16_C(x)   S16_C(x)
+#define UINT16_C(x)  U16_C(x)
+#endif
+
+#if !defined(INT32_C) && !defined(UINT32_C)
+#define INT32_C(x)   S32_C(x)
+#define UINT32_C(x)  U32_C(x)
+#endif
+
+#if !defined(INT64_C) && !defined(UINT64_C)
+#define INT64_C(x)   S64_C(x)
+#define UINT64_C(x)  U64_C(x)
+#endif
+
+/**@}*/
+/**\name C standard macros */
+#ifndef NULL
+#ifdef __cplusplus
+#define NULL         0
+#else
+#define NULL         ((void *)0)
+#endif
+#endif
+
+#ifndef TRUE
+#define TRUE         UINT8_C(1)
+#endif
+
+#ifndef FALSE
+#define FALSE        UINT8_C(0)
+#endif
+
+/********************************************************/
+/**\name Compiler switch macros */
+
+#ifndef BMP3_64BIT_COMPENSATION /*< Check if 64bit (using BMP3_64BIT_COMPENSATION) is enabled */
+#ifndef BMP3_FLOAT_COMPENSATION
+/*< If 64 bit integer data type is not enabled then enable BMP3_FLOAT_COMPENSATION  */
+/*#define BMP3_FLOAT_COMPENSATION*/
+#endif
+#endif
+
+/********************************************************/
+/**\name Macro definitions */
+
+/**
+ * BMP3_INTF_RET_TYPE is the read/write interface return
+ * type which can be overwritten by the build system.
+ */
+#ifndef BMP3_INTF_RET_TYPE
+#define BMP3_INTF_RET_TYPE                      s8
+#endif
+
+/**
+ * The last error code from read/write interface is stored in the device structure as intf_rslt.
+ */
+#ifndef BMP3_INTF_RET_SUCCESS
+#define BMP3_INTF_RET_SUCCESS                   INT8_C(0)
+#endif
+
+/**\name I2C addresses */
+#define BMP3_ADDR_I2C_PRIM                      UINT8_C(0x76)
+#define BMP3_ADDR_I2C_SEC                       UINT8_C(0x77)
+
+/**\name BMP3 chip identifier */
+#define BMP3_CHIP_ID                            UINT8_C(0x50)
+#define BMP390_CHIP_ID                          UINT8_C(0x60)
+
+/**\name BMP3 pressure settling time (micro secs)*/
+#define BMP3_SETTLE_TIME_PRESS                  UINT16_C(392)
+
+/**\name BMP3 temperature settling time (micro secs) */
+#define BMP3_SETTLE_TIME_TEMP                   UINT16_C(313)
+
+/**\name BMP3 adc conversion time (micro secs) */
+#define BMP3_ADC_CONV_TIME                      UINT16_C(2000)
+
+/**\name Register Address */
+#define BMP3_REG_CHIP_ID                        UINT8_C(0x00)
+#define BMP3_REG_ERR                            UINT8_C(0x02)
+#define BMP3_REG_SENS_STATUS                    UINT8_C(0x03)
+#define BMP3_REG_DATA                           UINT8_C(0x04)
+#define BMP3_REG_EVENT                          UINT8_C(0x10)
+#define BMP3_REG_INT_STATUS                     UINT8_C(0x11)
+#define BMP3_REG_FIFO_LENGTH                    UINT8_C(0x12)
+#define BMP3_REG_FIFO_DATA                      UINT8_C(0x14)
+#define BMP3_REG_FIFO_WM                        UINT8_C(0x15)
+#define BMP3_REG_FIFO_CONFIG_1                  UINT8_C(0x17)
+#define BMP3_REG_FIFO_CONFIG_2                  UINT8_C(0x18)
+#define BMP3_REG_INT_CTRL                       UINT8_C(0x19)
+#define BMP3_REG_IF_CONF                        UINT8_C(0x1A)
+#define BMP3_REG_PWR_CTRL                       UINT8_C(0x1B)
+#define BMP3_REG_OSR                            UINT8_C(0X1C)
+#define BMP3_REG_ODR                            UINT8_C(0x1D)
+#define BMP3_REG_CONFIG                         UINT8_C(0x1F)
+#define BMP3_REG_CALIB_DATA                     UINT8_C(0x31)
+#define BMP3_REG_CMD                            UINT8_C(0x7E)
+
+/**\name Error status macros */
+#define BMP3_ERR_FATAL                          UINT8_C(0x01)
+#define BMP3_ERR_CMD                            UINT8_C(0x02)
+#define BMP3_ERR_CONF                           UINT8_C(0x04)
+
+/**\name Status macros */
+#define BMP3_CMD_RDY                            UINT8_C(0x10)
+#define BMP3_DRDY_PRESS                         UINT8_C(0x20)
+#define BMP3_DRDY_TEMP                          UINT8_C(0x40)
+
+/**\name Power mode macros */
+#define BMP3_MODE_SLEEP                         UINT8_C(0x00)
+#define BMP3_MODE_FORCED                        UINT8_C(0x01)
+#define BMP3_MODE_NORMAL                        UINT8_C(0x03)
+
+/**\name FIFO related macros */
+/**\name FIFO enable  */
+#define BMP3_ENABLE                             UINT8_C(0x01)
+#define BMP3_DISABLE                            UINT8_C(0x00)
+
+/**\name Interrupt pin configuration macros */
+/**\name Open drain */
+#define BMP3_INT_PIN_OPEN_DRAIN                 UINT8_C(0x01)
+#define BMP3_INT_PIN_PUSH_PULL                  UINT8_C(0x00)
+
+/**\name Level */
+#define BMP3_INT_PIN_ACTIVE_HIGH                UINT8_C(0x01)
+#define BMP3_INT_PIN_ACTIVE_LOW                 UINT8_C(0x00)
+
+/**\name Latch */
+#define BMP3_INT_PIN_LATCH                      UINT8_C(0x01)
+#define BMP3_INT_PIN_NON_LATCH                  UINT8_C(0x00)
+
+/**\name Advance settings  */
+/**\name I2c watch dog timer period selection */
+#define BMP3_I2C_WDT_SHORT_1_25_MS              UINT8_C(0x00)
+#define BMP3_I2C_WDT_LONG_40_MS                 UINT8_C(0x01)
+
+/**\name FIFO Sub-sampling macros */
+#define BMP3_FIFO_NO_SUBSAMPLING                UINT8_C(0x00)
+#define BMP3_FIFO_SUBSAMPLING_2X                UINT8_C(0x01)
+#define BMP3_FIFO_SUBSAMPLING_4X                UINT8_C(0x02)
+#define BMP3_FIFO_SUBSAMPLING_8X                UINT8_C(0x03)
+#define BMP3_FIFO_SUBSAMPLING_16X               UINT8_C(0x04)
+#define BMP3_FIFO_SUBSAMPLING_32X               UINT8_C(0x05)
+#define BMP3_FIFO_SUBSAMPLING_64X               UINT8_C(0x06)
+#define BMP3_FIFO_SUBSAMPLING_128X              UINT8_C(0x07)
+
+/**\name Over sampling macros */
+#define BMP3_NO_OVERSAMPLING                    UINT8_C(0x00)
+#define BMP3_OVERSAMPLING_2X                    UINT8_C(0x01)
+#define BMP3_OVERSAMPLING_4X                    UINT8_C(0x02)
+#define BMP3_OVERSAMPLING_8X                    UINT8_C(0x03)
+#define BMP3_OVERSAMPLING_16X                   UINT8_C(0x04)
+#define BMP3_OVERSAMPLING_32X                   UINT8_C(0x05)
+
+/**\name Filter setting macros */
+#define BMP3_IIR_FILTER_DISABLE                 UINT8_C(0x00)
+#define BMP3_IIR_FILTER_COEFF_1                 UINT8_C(0x01)
+#define BMP3_IIR_FILTER_COEFF_3                 UINT8_C(0x02)
+#define BMP3_IIR_FILTER_COEFF_7                 UINT8_C(0x03)
+#define BMP3_IIR_FILTER_COEFF_15                UINT8_C(0x04)
+#define BMP3_IIR_FILTER_COEFF_31                UINT8_C(0x05)
+#define BMP3_IIR_FILTER_COEFF_63                UINT8_C(0x06)
+#define BMP3_IIR_FILTER_COEFF_127               UINT8_C(0x07)
+
+/**\name Odr setting macros */
+#define BMP3_ODR_200_HZ                         UINT8_C(0x00)
+#define BMP3_ODR_100_HZ                         UINT8_C(0x01)
+#define BMP3_ODR_50_HZ                          UINT8_C(0x02)
+#define BMP3_ODR_25_HZ                          UINT8_C(0x03)
+#define BMP3_ODR_12_5_HZ                        UINT8_C(0x04)
+#define BMP3_ODR_6_25_HZ                        UINT8_C(0x05)
+#define BMP3_ODR_3_1_HZ                         UINT8_C(0x06)
+#define BMP3_ODR_1_5_HZ                         UINT8_C(0x07)
+#define BMP3_ODR_0_78_HZ                        UINT8_C(0x08)
+#define BMP3_ODR_0_39_HZ                        UINT8_C(0x09)
+#define BMP3_ODR_0_2_HZ                         UINT8_C(0x0A)
+#define BMP3_ODR_0_1_HZ                         UINT8_C(0x0B)
+#define BMP3_ODR_0_05_HZ                        UINT8_C(0x0C)
+#define BMP3_ODR_0_02_HZ                        UINT8_C(0x0D)
+#define BMP3_ODR_0_01_HZ                        UINT8_C(0x0E)
+#define BMP3_ODR_0_006_HZ                       UINT8_C(0x0F)
+#define BMP3_ODR_0_003_HZ                       UINT8_C(0x10)
+#define BMP3_ODR_0_001_HZ                       UINT8_C(0x11)
+
+/**\name Soft reset command */
+#define BMP3_SOFT_RESET                         UINT8_C(0xB6)
+
+/**\name FIFO flush command */
+#define BMP3_FIFO_FLUSH                         UINT8_C(0xB0)
+
+/**\name API success code */
+#define BMP3_OK                                 INT8_C(0)
+
+/**\name API error codes */
+#define BMP3_E_NULL_PTR                         INT8_C(-1)
+#define BMP3_E_COMM_FAIL                        INT8_C(-2)
+#define BMP3_E_INVALID_ODR_OSR_SETTINGS         INT8_C(-3)
+#define BMP3_E_CMD_EXEC_FAILED                  INT8_C(-4)
+#define BMP3_E_CONFIGURATION_ERR                INT8_C(-5)
+#define BMP3_E_INVALID_LEN                      INT8_C(-6)
+#define BMP3_E_DEV_NOT_FOUND                    INT8_C(-7)
+#define BMP3_E_FIFO_WATERMARK_NOT_REACHED       INT8_C(-8)
+
+/**\name API warning codes */
+#define BMP3_W_SENSOR_NOT_ENABLED               INT8_C(1)
+#define BMP3_W_INVALID_FIFO_REQ_FRAME_CNT       INT8_C(2)
+#define BMP3_W_MIN_TEMP                         INT8_C(3)
+#define BMP3_W_MAX_TEMP                         INT8_C(4)
+#define BMP3_W_MIN_PRES                         INT8_C(5)
+#define BMP3_W_MAX_PRES                         INT8_C(6)
+
+/**\name Macros to select the which sensor settings are to be set by the user.
+ * These values are internal for API implementation. Don't relate this to
+ * data sheet.
+ */
+#define BMP3_SEL_PRESS_EN                       UINT16_C(1 << 1)
+#define BMP3_SEL_TEMP_EN                        UINT16_C(1 << 2)
+#define BMP3_SEL_DRDY_EN                        UINT16_C(1 << 3)
+#define BMP3_SEL_PRESS_OS                       UINT16_C(1 << 4)
+#define BMP3_SEL_TEMP_OS                        UINT16_C(1 << 5)
+#define BMP3_SEL_IIR_FILTER                     UINT16_C(1 << 6)
+#define BMP3_SEL_ODR                            UINT16_C(1 << 7)
+#define BMP3_SEL_OUTPUT_MODE                    UINT16_C(1 << 8)
+#define BMP3_SEL_LEVEL                          UINT16_C(1 << 9)
+#define BMP3_SEL_LATCH                          UINT16_C(1 << 10)
+#define BMP3_SEL_I2C_WDT_EN                     UINT16_C(1 << 11)
+#define BMP3_SEL_I2C_WDT                        UINT16_C(1 << 12)
+#define BMP3_SEL_ALL                            UINT16_C(0x7FF)
+
+/**\name Macros to select the which FIFO settings are to be set by the user
+ * These values are internal for API implementation. Don't relate this to
+ * data sheet
+ */
+#define BMP3_SEL_FIFO_MODE                      UINT16_C(1 << 1)
+#define BMP3_SEL_FIFO_STOP_ON_FULL_EN           UINT16_C(1 << 2)
+#define BMP3_SEL_FIFO_TIME_EN                   UINT16_C(1 << 3)
+#define BMP3_SEL_FIFO_PRESS_EN                  UINT16_C(1 << 4)
+#define BMP3_SEL_FIFO_TEMP_EN                   UINT16_C(1 << 5)
+#define BMP3_SEL_FIFO_DOWN_SAMPLING             UINT16_C(1 << 6)
+#define BMP3_SEL_FIFO_FILTER_EN                 UINT16_C(1 << 7)
+#define BMP3_SEL_FIFO_FWTM_EN                   UINT16_C(1 << 8)
+#define BMP3_SEL_FIFO_FULL_EN                   UINT16_C(1 << 9)
+
+/**\name Sensor component selection macros
+ * These values are internal for API implementation. Don't relate this to
+ * data sheet.
+ */
+#define BMP3_PRESS                              UINT8_C(1)
+#define BMP3_TEMP                               UINT8_C(2)
+#define BMP3_PRESS_TEMP                         UINT8_C(3)
+
+/**\name Temperature range values in integer and float */
+#define BMP3_MIN_TEMP_INT                       INT64_C(-4000)
+#define BMP3_MAX_TEMP_INT                       INT64_C(8500)
+#define BMP3_MIN_TEMP_DOUBLE                    -40.0f
+#define BMP3_MAX_TEMP_DOUBLE                    85.0f
+
+/**\name Pressure range values in integer and float */
+#define BMP3_MIN_PRES_INT                       UINT64_C(3000000)
+#define BMP3_MAX_PRES_INT                       UINT64_C(12500000)
+#define BMP3_MIN_PRES_DOUBLE                    30000.0f
+#define BMP3_MAX_PRES_DOUBLE                    125000.0f
+
+/**\name Macros for bit masking */
+#define BMP3_ERR_FATAL_MSK                      UINT8_C(0x01)
+
+#define BMP3_ERR_CMD_MSK                        UINT8_C(0x02)
+#define BMP3_ERR_CMD_POS                        UINT8_C(0x01)
+
+#define BMP3_ERR_CONF_MSK                       UINT8_C(0x04)
+#define BMP3_ERR_CONF_POS                       UINT8_C(0x02)
+
+#define BMP3_STATUS_CMD_RDY_MSK                 UINT8_C(0x10)
+#define BMP3_STATUS_CMD_RDY_POS                 UINT8_C(0x04)
+
+#define BMP3_STATUS_DRDY_PRESS_MSK              UINT8_C(0x20)
+#define BMP3_STATUS_DRDY_PRESS_POS              UINT8_C(0x05)
+
+#define BMP3_STATUS_DRDY_TEMP_MSK               UINT8_C(0x40)
+#define BMP3_STATUS_DRDY_TEMP_POS               UINT8_C(0x06)
+
+#define BMP3_OP_MODE_MSK                        UINT8_C(0x30)
+#define BMP3_OP_MODE_POS                        UINT8_C(0x04)
+
+#define BMP3_PRESS_EN_MSK                       UINT8_C(0x01)
+
+#define BMP3_TEMP_EN_MSK                        UINT8_C(0x02)
+#define BMP3_TEMP_EN_POS                        UINT8_C(0x01)
+
+#define BMP3_IIR_FILTER_MSK                     UINT8_C(0x0E)
+#define BMP3_IIR_FILTER_POS                     UINT8_C(0x01)
+
+#define BMP3_ODR_MSK                            UINT8_C(0x1F)
+
+#define BMP3_PRESS_OS_MSK                       UINT8_C(0x07)
+
+#define BMP3_TEMP_OS_MSK                        UINT8_C(0x38)
+#define BMP3_TEMP_OS_POS                        UINT8_C(0x03)
+
+#define BMP3_FIFO_MODE_MSK                      UINT8_C(0x01)
+
+#define BMP3_FIFO_STOP_ON_FULL_MSK              UINT8_C(0x02)
+#define BMP3_FIFO_STOP_ON_FULL_POS              UINT8_C(0x01)
+
+#define BMP3_FIFO_TIME_EN_MSK                   UINT8_C(0x04)
+#define BMP3_FIFO_TIME_EN_POS                   UINT8_C(0x02)
+
+#define BMP3_FIFO_PRESS_EN_MSK                  UINT8_C(0x08)
+#define BMP3_FIFO_PRESS_EN_POS                  UINT8_C(0x03)
+
+#define BMP3_FIFO_TEMP_EN_MSK                   UINT8_C(0x10)
+#define BMP3_FIFO_TEMP_EN_POS                   UINT8_C(0x04)
+
+#define BMP3_FIFO_FILTER_EN_MSK                 UINT8_C(0x18)
+#define BMP3_FIFO_FILTER_EN_POS                 UINT8_C(0x03)
+
+#define BMP3_FIFO_DOWN_SAMPLING_MSK             UINT8_C(0x07)
+
+#define BMP3_FIFO_FWTM_EN_MSK                   UINT8_C(0x08)
+#define BMP3_FIFO_FWTM_EN_POS                   UINT8_C(0x03)
+
+#define BMP3_FIFO_FULL_EN_MSK                   UINT8_C(0x10)
+#define BMP3_FIFO_FULL_EN_POS                   UINT8_C(0x04)
+
+#define BMP3_INT_OUTPUT_MODE_MSK                UINT8_C(0x01)
+
+#define BMP3_INT_LEVEL_MSK                      UINT8_C(0x02)
+#define BMP3_INT_LEVEL_POS                      UINT8_C(0x01)
+
+#define BMP3_INT_LATCH_MSK                      UINT8_C(0x04)
+#define BMP3_INT_LATCH_POS                      UINT8_C(0x02)
+
+#define BMP3_INT_DRDY_EN_MSK                    UINT8_C(0x40)
+#define BMP3_INT_DRDY_EN_POS                    UINT8_C(0x06)
+
+#define BMP3_I2C_WDT_EN_MSK                     UINT8_C(0x02)
+#define BMP3_I2C_WDT_EN_POS                     UINT8_C(0x01)
+
+#define BMP3_I2C_WDT_SEL_MSK                    UINT8_C(0x04)
+#define BMP3_I2C_WDT_SEL_POS                    UINT8_C(0x02)
+
+#define BMP3_INT_STATUS_FWTM_MSK                UINT8_C(0x01)
+
+#define BMP3_INT_STATUS_FFULL_MSK               UINT8_C(0x02)
+#define BMP3_INT_STATUS_FFULL_POS               UINT8_C(0x01)
+
+#define BMP3_INT_STATUS_DRDY_MSK                UINT8_C(0x08)
+#define BMP3_INT_STATUS_DRDY_POS                UINT8_C(0x03)
+
+/**\name    UTILITY MACROS  */
+#define BMP3_SET_LOW_BYTE                       UINT16_C(0x00FF)
+#define BMP3_SET_HIGH_BYTE                      UINT16_C(0xFF00)
+
+/**\name Macro to combine two 8 bit data's to form a 16 bit data */
+#define BMP3_CONCAT_BYTES(msb, lsb)             ((((u16)msb) << 8) | ((u16)lsb))
+
+#define BMP3_SET_BITS(reg_data, bitname, data) (((reg_data) & ~(unsigned int)(bitname##_MSK)) | \
+							(((data) << bitname##_POS) & bitname##_MSK))
+
+/* Macro variant to handle the bitname position if it is zero */
+#define BMP3_SET_BITS_POS_0(reg_data, bitname, data) \
+						(((reg_data) & ~(unsigned int)(bitname##_MSK)) | \
+						((data) & bitname##_MSK))
+
+#define BMP3_GET_BITS(reg_data, bitname)        (((reg_data) & (bitname##_MSK)) >> (bitname##_POS))
+
+/* Macro variant to handle the bitname position if it is zero */
+#define BMP3_GET_BITS_POS_0(reg_data, bitname)  ((reg_data) & (bitname##_MSK))
+
+#define BMP3_GET_LSB(var)                       ((u8)((var) & (BMP3_SET_LOW_BYTE)))
+#define BMP3_GET_MSB(var)                       ((u8)(((var) & ((BMP3_SET_HIGH_BYTE) >> 8))))
+
+/**\name Macros related to size */
+#define BMP3_LEN_CALIB_DATA                     UINT8_C(21)
+#define BMP3_LEN_P_AND_T_HEADER_DATA            UINT8_C(7)
+#define BMP3_LEN_P_OR_T_HEADER_DATA             UINT8_C(4)
+#define BMP3_LEN_P_T_DATA                       UINT8_C(6)
+#define BMP3_LEN_GEN_SETT                       UINT8_C(7)
+#define BMP3_LEN_P_DATA                         UINT8_C(3)
+#define BMP3_LEN_T_DATA                         UINT8_C(3)
+#define BMP3_LEN_SENSOR_TIME                    UINT8_C(3)
+#define BMP3_FIFO_MAX_FRAMES                    UINT8_C(73)
+
+/*! Power control settings */
+#define BMP3_POWER_CNTL                         UINT16_C(0x0006)
+
+/*! Odr and filter settings */
+#define BMP3_ODR_FILTER                         UINT16_C(0x00F0)
+
+/*! Interrupt control settings */
+#define BMP3_INT_CTRL                           UINT16_C(0x0708)
+
+/*! Advance settings */
+#define BMP3_ADV_SETT                           UINT16_C(0x1800)
+
+/*! FIFO settings */
+
+/*! Mask for fifo_mode, fifo_stop_on_full, fifo_time_en, fifo_press_en and
+ * fifo_temp_en settings
+ */
+#define BMP3_FIFO_CONFIG_1                      UINT16_C(0x003E)
+
+/*! Mask for fifo_sub_sampling and data_select settings */
+#define BMP3_FIFO_CONFIG_2                      UINT16_C(0x00C0)
+
+/*! Mask for fwtm_en and ffull_en settings */
+#define BMP3_FIFO_INT_CTRL                      UINT16_C(0x0300)
+
+/*! FIFO Header */
+/*! FIFO temperature pressure header frame */
+#define BMP3_FIFO_TEMP_PRESS_FRAME              0x94
+
+/*! FIFO temperature header frame */
+#define BMP3_FIFO_TEMP_FRAME                    0x90
+
+/*! FIFO pressure header frame */
+#define BMP3_FIFO_PRESS_FRAME                   0x84
+
+/*! FIFO time header frame */
+#define BMP3_FIFO_TIME_FRAME                    0xA0
+
+/*! FIFO error header frame */
+#define BMP3_FIFO_ERROR_FRAME                   0x44
+
+/*! FIFO configuration change header frame */
+#define BMP3_FIFO_CONFIG_CHANGE                 0x48
+
+/*! FIFO empty frame */
+#define BMP3_FIFO_EMPTY_FRAME                   0x80
+
+/*! FIFO sensortime overhead byte count */
+#define BMP3_SENSORTIME_OVERHEAD_BYTES          UINT8_C(20)
+
+#define REG_BUFF_SIZE   1012
+/********************************************************/
+/*!
+ * @brief Interface selection Enums
+ */
+enum bmp3_intf {
+	/*! SPI interface */
+	BMP3_SPI_INTF = 0,
+	/*! I2C interface */
+	BMP3_I2C_INTF
+};
+
+/********************************************************/
+/*!
+ * @brief Type definitions
+ */
+
+/*!
+ * @brief Bus communication function pointer which should be mapped to
+ * the platform specific read functions of the user
+ *
+ * @param[in]     reg_addr : 8bit register address of the sensor
+ * @param[out]    reg_data : Data from the specified address
+ * @param[in]     length   : Length of the reg_data array
+ * @param[in,out] intf_ptr : Void pointer that can enable the linking of descriptors
+ *                           for interface related callbacks
+ * @retval 0 for Success
+ * @retval Non-zero for Failure
+ */
+typedef s8 (*bmp3_read_fptr_t)(u8 reg_addr, u8 *, u32 len, void *intf_ptr);
+/*!
+ * @brief Bus communication function pointer which should be mapped to
+ * the platform specific write functions of the user
+ *
+ * @param[in]     reg_addr : 8bit register address of the sensor
+ * @param[out]    reg_data : Data to the specified address
+ * @param[in]     length   : Length of the reg_data array
+ * @param[in,out] intf_ptr : Void pointer that can enable the linking of descriptors
+ *                           for interface related callbacks
+ * @retval 0 for Success
+ * @retval Non-zero for Failure
+ */
+typedef s8 (*bmp3_write_fptr_t)(u8 reg_addr, const u8 *, u32 len, void *intf_ptr);
+/*!
+ * @brief Delay function pointer which should be mapped to
+ * delay function of the user
+ *
+ * @param[in] period              : Delay in microseconds.
+ * @param[in, out] intf_ptr       : Void pointer that can enable the linking of descriptors
+ *                                  for interface related call backs
+ *
+ */
+typedef void (*bmp3_delay_us_fptr_t)(u32 period, void *intf_ptr);
+/********************************************************/
+/*!
+ * @brief Register Trim Variables
+ */
+struct bmp3_reg_calib_data {
+	/*! Trim Variables */
+	u16 par_t1;
+	u16 par_t2;
+	s8 par_t3;
+	s16 par_p1;
+	s16 par_p2;
+	s8 par_p3;
+	s8 par_p4;
+	u16 par_p5;
+	u16 par_p6;
+	s8 par_p7;
+	s8 par_p8;
+	s16 par_p9;
+	s8 par_p10;
+	s8 par_p11;
+	s64 t_lin;
+};
+
+/*!
+ * @brief bmp3 advance settings
+ */
+struct bmp3_adv_settings {
+	/*! I2C watchdog enable */
+	u8 i2c_wdt_en;
+
+	/*! I2C watchdog select */
+	u8 i2c_wdt_sel;
+};
+
+/*!
+ * @brief bmp3 odr and filter settings
+ */
+struct bmp3_odr_filter_settings {
+	/*! Pressure oversampling */
+	u8 press_os;
+
+	/*! Temperature oversampling */
+	u8 temp_os;
+
+	/*! IIR filter */
+	u8 iir_filter;
+
+	/*! Output data rate */
+	u8 odr;
+};
+
+/*!
+ * @brief bmp3 sensor status flags
+ */
+struct bmp3_sens_status {
+	/*! Command ready status */
+	u8 cmd_rdy;
+
+	/*! Data ready for pressure */
+	u8 drdy_press;
+
+	/*! Data ready for temperature */
+	u8 drdy_temp;
+};
+
+/*!
+ * @brief bmp3 interrupt status flags
+ */
+struct bmp3_int_status {
+	/*! Fifo watermark interrupt */
+	u8 fifo_wm;
+
+	/*! Fifo full interrupt */
+	u8 fifo_full;
+
+	/*! Data ready interrupt */
+	u8 drdy;
+};
+
+/*!
+ * @brief bmp3 error status flags
+ */
+struct bmp3_err_status {
+	/*! Fatal error */
+	u8 fatal;
+
+	/*! Command error */
+	u8 cmd;
+
+	/*! Configuration error */
+	u8 conf;
+};
+
+/*!
+ * @brief bmp3 status flags
+ */
+struct bmp3_status {
+	/*! Interrupt status */
+	struct bmp3_int_status intr;
+
+	/*! Sensor status */
+	struct bmp3_sens_status sensor;
+
+	/*! Error status */
+	struct bmp3_err_status err;
+
+	/*! Power on reset status */
+	u8 pwr_on_rst;
+};
+
+/*!
+ * @brief bmp3 interrupt pin settings
+ */
+struct bmp3_int_ctrl_settings {
+	/*! Output mode */
+	u8 output_mode;
+
+	/*! Active high/low */
+	u8 level;
+
+	/*! Latched or Non-latched */
+	u8 latch;
+
+	/*! Data ready interrupt */
+	u8 drdy_en;
+};
+
+/*!
+ * @brief bmp3 device settings
+ */
+struct bmp3_settings {
+	/*! Power mode which user wants to set */
+	u8 op_mode;
+
+	/*! Enable/Disable pressure sensor */
+	u8 press_en;
+
+	/*! Enable/Disable temperature sensor */
+	u8 temp_en;
+
+	/*! ODR and filter configuration */
+	struct bmp3_odr_filter_settings odr_filter;
+
+	/*! Interrupt configuration */
+	struct bmp3_int_ctrl_settings int_settings;
+
+	/*! Advance settings */
+	struct bmp3_adv_settings adv_settings;
+};
+
+/*!
+ * @brief bmp3 fifo frame
+ */
+struct bmp3_fifo_data {
+	/*!
+	 * Data buffer of user defined length is to be mapped here
+	 * 512 +4
+	 */
+	u8 *buffer;
+
+	/*! Number of bytes of data read from the fifo */
+	u16 byte_count;
+
+	/*! Number of frames to be read as specified by the user */
+	u8 req_frames;
+
+	/*! Will be equal to length when no more frames are there to parse */
+	u16 start_idx;
+
+	/*! Will contain the no of parsed data frames from fifo */
+	u8 parsed_frames;
+
+	/*! Configuration error */
+	u8 config_err;
+
+	/*! Sensor time */
+	u32 sensor_time;
+
+	/*! FIFO input configuration change */
+	u8 config_change;
+
+	/*! All available frames are parsed */
+	u8 frame_not_available;
+};
+
+/*!
+ * @brief bmp3 fifo configuration
+ */
+struct bmp3_fifo_settings {
+	/*! enable/disable */
+	u8 mode;
+
+	/*! stop on full enable/disable */
+	u8 stop_on_full_en;
+
+	/*! time enable/disable */
+	u8 time_en;
+
+	/*! pressure enable/disable */
+	u8 press_en;
+
+	/*! temperature enable/disable */
+	u8 temp_en;
+
+	/*! down sampling rate */
+	u8 down_sampling;
+
+	/*! filter enable/disable */
+	u8 filter_en;
+
+	/*! FIFO watermark enable/disable */
+	u8 fwtm_en;
+
+	/*! FIFO full enable/disable */
+	u8 ffull_en;
+};
+
+#ifdef BMP3_FLOAT_COMPENSATION
+/*!
+ * @brief Quantized Trim Variables
+ */
+struct bmp3_quantized_calib_data {
+	/*! Quantized Trim Variables */
+	double par_t1;
+	double par_t2;
+	double par_t3;
+	double par_p1;
+	double par_p2;
+	double par_p3;
+	double par_p4;
+	double par_p5;
+	double par_p6;
+	double par_p7;
+	double par_p8;
+	double par_p9;
+	double par_p10;
+	double par_p11;
+	double t_lin;
+};
+
+/*!
+ * @brief Calibration data
+ */
+struct bmp3_calib_data {
+	/*! Quantized data */
+	struct bmp3_quantized_calib_data quantized_calib_data;
+
+	/*! Register data */
+	struct bmp3_reg_calib_data reg_calib_data;
+};
+
+/*!
+ * @brief bmp3 sensor structure which comprises of temperature and pressure
+ * data.
+ */
+struct bmp3_data {
+	/*! Compensated temperature */
+	double temperature;
+
+	/*! Compensated pressure */
+	double pressure;
+};
+#else
+/*!
+ * @brief bmp3 sensor structure which comprises of temperature and pressure
+ * data.
+ */
+struct bmp3_data {
+	/*! Compensated temperature */
+	s64 temperature;
+
+	/*! Compensated pressure */
+	u64 pressure;
+};
+
+/*!
+ * @brief Calibration data
+ */
+struct bmp3_calib_data {
+	/*! Register data */
+	struct bmp3_reg_calib_data reg_calib_data;
+};
+#endif /* BMP3_FLOAT_COMPENSATION */
+/*!
+ * @brief bmp3 sensor structure which comprises of un-compensated temperature
+ * and pressure data.
+ */
+struct bmp3_uncomp_data {
+	/*! un-compensated pressure */
+	u64 pressure;
+
+	/*! un-compensated temperature */
+	s64 temperature;
+};
+
+/*!
+ * @brief bmp3 device structure
+ */
+struct bmp3_dev {
+	/*! Chip Id */
+	u8 chip_id;
+
+	/*!
+	 * The interface pointer is used to enable the user
+	 * to link their interface descriptors for reference during the
+	 * implementation of the read and write interfaces to the
+	 * hardware.
+	 */
+	void *intf_ptr;
+
+	/*!
+	 * The interface selection is used to determine whether the
+	 * sensor is communicating via SPI or I2C.
+	 * For SPI, interface = BMP3_SPI_INTF
+	 * For I2C, interface = BMP3_I2C_INTF
+	 */
+	enum bmp3_intf intf;
+
+	/*! To store interface pointer error */
+	BMP3_INTF_RET_TYPE intf_rslt;
+
+	/*! Decide SPI or I2C read mechanism */
+	u8 dummy_byte;
+
+	/*! Read function pointer */
+	bmp3_read_fptr_t read;
+
+	/*! Write function pointer */
+	bmp3_write_fptr_t write;
+
+	/*! Delay function pointer */
+	bmp3_delay_us_fptr_t delay_us;
+
+	/*! Trim data */
+	struct bmp3_calib_data calib_data;
+};
+
+#ifdef __cplusplus
+}
+#endif /* End of CPP guard */
+
+#endif /* BMP3_DEFS_H_ */
+
diff --git a/drivers/iio/pressure/bmp390/bmp3_selftest.c b/drivers/iio/pressure/bmp390/bmp3_selftest.c
new file mode 100644
index 000000000000..5fcf15205d48
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp3_selftest.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp3_selftest.c
+ * @date		2024-12-04
+ * @version		v2.1.0
+ *
+ */
+
+#include "bmp3_selftest.h"
+
+/***************** Static function declarations ******************************/
+/*!
+ * @brief       Function to analyze the sensor data
+ *
+ * @param[in]   data   Structure instance of bmp3_data
+ * (compensated temp & press values)
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 analyze_sensor_data(const struct bmp3_data *data);
+/*!
+ * @brief       Function to calculate the CRC of the trimming parameters.
+ *
+ * @param[in]   seed   CRC of each register
+ * @param[in]   data   register data.
+ *
+ * @return      calculated CRC
+ */
+static s8 cal_crc(u8 seed, u8 data);
+/*!
+ * @brief Function to validate the trimming parameters
+ *
+ * @param [in] dev Structure instance of bmp3_dev structure.
+ *
+ * @return Result of API execution status
+ * @retval 0 -> Success
+ * @retval >0 -> Warning
+ * @retval <0 -> Fail
+ */
+static s8 validate_trimming_param(struct bmp3_dev *dev);
+/****************** Global Function Definitions *******************************/
+
+/*!
+ * @brief       Self-test API for the BMP38X
+ */
+s8 bmp3_selftest_check(struct bmp3_settings *settings, struct bmp3_dev *dev)
+{
+	s8 rslt;
+	/* Variable used to select the sensor component */
+	u8 sensor_comp;
+	/* Variable used to store the compensated data */
+	struct bmp3_data data = { 0 };
+	/* Used to select the settings user needs to change */
+	u16 settings_sel;
+
+	/* Reset the sensor */
+	rslt = bmp3_soft_reset(dev);
+	if (rslt == BMP3_SENSOR_OK) {
+		rslt = bmp3_init(dev);
+		if (rslt == BMP3_E_COMM_FAIL || rslt == BMP3_E_DEV_NOT_FOUND)
+			rslt = BMP3_COMMUNICATION_ERROR_OR_WRONG_DEVICE;
+
+		if (rslt == BMP3_SENSOR_OK)
+			rslt = validate_trimming_param(dev);
+
+		if (rslt == BMP3_SENSOR_OK) {
+			/* Select the pressure and temperature sensor to be enabled */
+			settings->press_en = BMP3_ENABLE;
+			settings->temp_en = BMP3_ENABLE;
+			/*
+			 * Select the output data rate and over sampling settings
+			 * for pressure and temperature
+			 */
+			settings->odr_filter.press_os = BMP3_NO_OVERSAMPLING;
+			settings->odr_filter.temp_os = BMP3_NO_OVERSAMPLING;
+			settings->odr_filter.odr = BMP3_ODR_25_HZ;
+
+			/* Assign the settings which needs to be set in the sensor */
+			settings_sel = BMP3_SEL_PRESS_EN | BMP3_SEL_TEMP_EN |
+			BMP3_SEL_PRESS_OS | BMP3_SEL_TEMP_OS | BMP3_SEL_ODR;
+			rslt = bmp3_set_sensor_settings(settings_sel, settings, dev);
+			if (rslt == BMP3_SENSOR_OK) {
+				settings->op_mode = BMP3_MODE_NORMAL;
+				rslt = bmp3_set_op_mode(settings, dev);
+				if (rslt == BMP3_SENSOR_OK) {
+					dev->delay_us(40000, dev->intf_ptr);
+					/* Sensor component selection */
+					sensor_comp = BMP3_PRESS_TEMP;
+					/*
+					 * Temperature and Pressure data are read and
+					 * stored in the bmp3_data instance
+					 */
+
+					rslt = bmp3_get_sensor_data(sensor_comp, &data, dev);
+				}
+			}
+		}
+		if (rslt == BMP3_SENSOR_OK) {
+			rslt = analyze_sensor_data(&data);
+			/* Set the power mode to sleep mode */
+			if (rslt == BMP3_SENSOR_OK) {
+				settings->op_mode = BMP3_MODE_SLEEP;
+				rslt = bmp3_set_op_mode(settings, dev);
+			}
+		}
+	}
+	return rslt;
+}
+
+/****************** Static Function Definitions *******************************/
+/*!
+ * @brief  Function to analyze the sensor data
+ */
+static s8 analyze_sensor_data(const struct bmp3_data *sens_data)
+{
+	s8 rslt = BMP3_SENSOR_OK;
+
+	if (sens_data->temperature < BMP3_MIN_TEMPERATURE ||
+	    sens_data->temperature > BMP3_MAX_TEMPERATURE)
+		rslt = BMP3_IMPLAUSIBLE_TEMPERATURE;
+
+	if (rslt == BMP3_SENSOR_OK) {
+		if ((sens_data->pressure / 100 < BMP3_MIN_PRESSURE) ||
+		    (sens_data->pressure / 100 > BMP3_MAX_PRESSURE))
+			rslt = BMP3_IMPLAUSIBLE_PRESSURE;
+	}
+	return rslt;
+}
+
+/*
+ * @brief Function to verify the trimming parameters
+ */
+static s8 validate_trimming_param(struct bmp3_dev *dev)
+{
+	s8 rslt;
+	u8 crc = 0xFF;
+	u8 stored_crc;
+	u8 trim_param[21];
+	u8 i;
+
+	rslt = bmp3_get_regs(BMP3_REG_CALIB_DATA, trim_param, 21, dev);
+	if (rslt == BMP3_SENSOR_OK) {
+		for (i = 0; i < 21; i++)
+			crc = (u8)cal_crc(crc, trim_param[i]);
+
+		crc = (crc ^ 0xFF);
+		rslt = bmp3_get_regs(0x30, &stored_crc, 1, dev);
+		if (stored_crc != crc)
+			rslt = BMP3_TRIMMING_DATA_OUT_OF_BOUND;
+	}
+	return rslt;
+}
+
+/*
+ * @brief Function to calculate CRC for the trimming parameters
+ */
+static s8 cal_crc(u8 seed, u8 data)
+{
+	s8 poly = 0x1D;
+	s8 var2;
+	u8 i;
+
+	for (i = 0; i < 8; i++) {
+		if ((seed & 0x80) ^ (data & 0x80))
+			var2 = 1;
+		else
+			var2 = 0;
+		seed = (seed & 0x7F) << 1;
+		data = (data & 0x7F) << 1;
+		seed = seed ^ (u8)(poly * var2);
+	}
+	return (s8)seed;
+}
+
diff --git a/drivers/iio/pressure/bmp390/bmp3_selftest.h b/drivers/iio/pressure/bmp390/bmp3_selftest.h
new file mode 100644
index 000000000000..ab6c4a992011
--- /dev/null
+++ b/drivers/iio/pressure/bmp390/bmp3_selftest.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/**
+ * @section LICENSE
+ * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
+ *
+ * This software program is licensed subject to the GNU General
+ * Public License (GPL).Version 2,June 1991,
+ * available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * @file		bmp3_selftest.h
+ * @date		2024-12-04
+ * @version		v2.1.0
+ *
+ */
+
+#ifndef BMP38X_SELFTEST_H_
+#define BMP38X_SELFTEST_H_
+
+/*! CPP guard */
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "bmp3.h"
+
+#ifndef BMP3_FLOAT_COMPENSATION
+
+/* 0 degree celsius */
+#define BMP3_MIN_TEMPERATURE                                INT16_C(0)
+
+/* 40 degree celsius */
+#define BMP3_MAX_TEMPERATURE                                INT16_C(4000)
+
+/* 900 hecto Pascals */
+#define BMP3_MIN_PRESSURE                                   UINT32_C(90000)
+
+/* 1100 hecto Pascals */
+#define BMP3_MAX_PRESSURE                                   UINT32_C(110000)
+
+#else
+
+/* 0 degree celsius */
+#define BMP3_MIN_TEMPERATURE                                (0.0f)
+
+/* 40 degree celsius */
+#define BMP3_MAX_TEMPERATURE                                (40.0f)
+
+/* 900 hecto Pascals */
+#define BMP3_MIN_PRESSURE                                   (900.0f)
+
+/* 1100 hecto Pascals */
+#define BMP3_MAX_PRESSURE                                   (1100.0f)
+#endif
+
+/* Error codes for self test  */
+#define BMP3_SENSOR_OK                                      UINT8_C(0)
+#define BMP3_COMMUNICATION_ERROR_OR_WRONG_DEVICE            UINT8_C(10)
+#define BMP3_TRIMMING_DATA_OUT_OF_BOUND                     UINT8_C(20)
+#define BMP3_TEMPERATURE_BOUND_WIRE_FAILURE_OR_MEMS_DEFECT  UINT8_C(30)
+#define BMP3_PRESSURE_BOUND_WIRE_FAILURE_OR_MEMS_DEFECT     UINT8_C(31)
+#define BMP3_IMPLAUSIBLE_TEMPERATURE                        UINT8_C(40)
+#define BMP3_IMPLAUSIBLE_PRESSURE                           UINT8_C(41)
+
+/**
+ * \ingroup bmp3
+ * \defgroup bmp3ApiSelftest Self test
+ * @brief Perform self test of sensor
+ */
+
+/*!
+ * \ingroup bmp3ApiSelftest
+ * \page bmp3_api_bmp3_selftest_check bmp3_selftest_check
+ * \code
+ * int8_t bmp3_selftest_check(const struct bmp3_dev *dev);
+ * \endcode
+ * @details Self-test API for the BMP38X
+ *
+ * @param[in] settings : Structure instance of bmp3_settings
+ * @param[in]   dev    : Structure instance of bmp3_dev
+ *
+ * @return Result of API execution status
+ * @retval 0  -> Success
+ * @retval <0 -> Error
+ */
+int8_t bmp3_selftest_check(struct bmp3_settings *settings, struct bmp3_dev *dev);
+
+/*! CPP guard */
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* BMP38X_SELFTEST_H_ */
+
-- 
2.20.1


