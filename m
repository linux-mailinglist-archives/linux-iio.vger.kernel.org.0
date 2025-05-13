Return-Path: <linux-iio+bounces-19501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F595AB57DE
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 17:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C600189F2B7
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9A2BDC2A;
	Tue, 13 May 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="a5MQWuso"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D851DED53;
	Tue, 13 May 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148508; cv=fail; b=ri45OMEJ7U+tRm2XmCJGDbQUz7L9og4GcWHeecZuHHVwhAeG5gtivPO2He/TzPfZ54nONjkJMaRcSHMyAoXhcyVhZam2di4oHR2eNiObpo7+Oh4FupKlV3Xblho4htFyUuokUmjUmE2KzA8z9CIjxX9+4Qkrv4HpnhnR95gtKR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148508; c=relaxed/simple;
	bh=9B4aYWH6WhEMM+w4Hi/NSO9mw+lN7whPo0IEU7rTork=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6n9z45KHVITwm5sYPnKgXzLZiyqtRKKlUUjVHO79EBGX/rgaMg5i2ejHDpwG+Vh2HWWLpgSbxLXIveHAwR9eQb8Q0x6jE7uNLSJxEeqoemVsTNtd+j6+VHx5n+58Jf+Q7si0S/bMNrCTCh26jyDEvqJQL1Qqi/B/BT0d+GPi8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=a5MQWuso; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIDKcxUllbZVhUsvOAIR2F2OWV5/ub6wXjtXfLuF9LurlcxXzhvHq5HUK77Epn/0F9dtigFxr2VrvJGwM6+VSE5KbgviZxW7pUVKUUBZEb7fXYWQ410+/OM7kx9JKLEpK5aGmZ3iPybbov9Pk5pcqhNIpzrcBDgOITlEnOb/aWz4u6CeuB8IcVEye7+8e/x2H9qlZmAyzwxX23CQRvqodXyGJ5bYoU3yYqAnZ07bVs251uJFdlhPQHXHdUgt7DYajuZTqzGJggWS8a5g78cn7vn9cbtXP8r1wxG6DmNKBZNO4mn/mQ6+l7d2v3qCPnNYBnqHcLm1sL/zQlK4/jQ7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmM9Wv3M+VsqbCBOTaYQ34FX3H2oD6vUV2nxpbGc2Hk=;
 b=rm9ziWcck5T6QdfXRJrsQULWutxf+g3V2YUgXp9MwnenOdvwRsopqL1dfJ5VlARAlSL7WfVAISj/SyrSErsJowc5F7587wogAmIgsP22wykLbAXNxUBYFCat5sbFgPrhQp63bhDY6iVGrwGtGgFXJbCqQtKHbP5ur9/LFerXIxeayY9/mWrJ4ax5IMOxr6vejrpGVt2RM4/fKDUfUn1az5CWzoKSg+kEnCQOZdUEGBk4nganUjJwgsHmbbv4uGwkZ09jxeIIvnFx5y0RmkGQqT72pmtTIeVZWBeFSTrpimi/jkL9PUVaAswoIF5Uh8SQ5SktxOf8jcCuvocASQAWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=temperror action=none header.from=de.bosch.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmM9Wv3M+VsqbCBOTaYQ34FX3H2oD6vUV2nxpbGc2Hk=;
 b=a5MQWuso+t70dV4D69c7Lvd2nfosKnM4CL5QSV+K2AQS3ulTMX2ymMyvm7Eo5oINeypvmNHabblnfMGX5jS8+j0KBG0SKNe9yN+tY/7lfJzlkHfjhXM7f8UQlPUvSXkA+wmQG7sWuEIVzlErZAZwFdd5CVAxVjH2ulzoJacPVLduyVRlvvVtfKzzs2h2Zo4auFXAUGgLtNqkQkzAD0SouHEKdoLwl0bqpDPlZtiEBS1u4+3iARKrLrJkQ6c5h23mWaO9Koh3rS/xHbUw+VGN/kPApZAG/jveF9kiteShzrK/qjjSgEZ4BLzCpfjafj9joCQEzEp9Oddt0oULtQT3sg==
Received: from DUZPR01CA0138.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::14) by DB8PR10MB3912.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:169::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 15:01:39 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::7c) by DUZPR01CA0138.outlook.office365.com
 (2603:10a6:10:4bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.27 via Frontend Transport; Tue,
 13 May 2025 15:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 139.15.153.205) smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=de.bosch.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of de.bosch.com: DNS Timeout)
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 15:01:37 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 17:01:11 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Tue, 13 May 2025 17:01:11 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.215.140) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 May 2025 17:01:08 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v2 2/2] iio: imu: smi330: Add driver
Date: Tue, 13 May 2025 17:00:28 +0200
Message-ID: <20250513150028.42775-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
References: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|DB8PR10MB3912:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d57916a-d41e-4d2e-28fd-08dd922f0f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1E5b0hUM0x2U2ZBSGRUUDFrZzFubVNVOXVtbWRtVTI3SVBpcnpmOGpidkxF?=
 =?utf-8?B?bGZJaWpIN01ZSmdlTHVLdkpqdThpM0Z1VmQrTEtxY0pyMEdiZkYvb2luSTQ4?=
 =?utf-8?B?cDJuRjg2UVBTMXJwMWhETUJNcVNJbnFTU3VlajYvemNWNEVLQjZ5dW5TdXh2?=
 =?utf-8?B?UXU0cFFjSEs5dzZFTkVDSmN2RVZoVzdTYWRCQzIxaVlnMFJMbHZwbjlJcnZ2?=
 =?utf-8?B?QVBZbUpZTUN3UWJKSExpU2lBTkI2VFEvLzJxam1URlBCRU9xQUtmUm0wclc5?=
 =?utf-8?B?YlpQOEU1andocVJWK1JCQlY1QzFFY2VhTnNDVzl2T1RBWmZmNW1RQU1xbHFN?=
 =?utf-8?B?ajVLODVrSmV6WVZiVXFmSkJtRW9FSnNEQmVRZU1iT3NWazFOU1NTM3R3R1Bi?=
 =?utf-8?B?RTVlTFA1NFZkV3RoYVltSzhtRVp1YjBRenpkUkJSb09sSEtmQVRZT1JwazVY?=
 =?utf-8?B?MU93a205ZitQVkV1YWRxVTZ5dXVkV0x5dGV1cmJ0Mko5MDMxYVN1am43ZXlN?=
 =?utf-8?B?dWViVStpaVo5RkxWM0dpTnVxVWNJTHhadkJid1JNM2lOUGJGNW1HSHhWRng1?=
 =?utf-8?B?RkVwbStXd0pjbC8rWmorL0VqR0pLQ2dSVnZxNUdZa2tVRlBUeU85eHc4NmFn?=
 =?utf-8?B?akFSY1VKT041clR1alJ4dEltR0E2d203Q2FyZ1hzRzJCK1Bnd1lJUmFFOVZI?=
 =?utf-8?B?MEtucWpJcHVNZW8vQ3dCckJKQ0hodnp1ZmdZbWtrSjJGTjd1RThsdEVhNzEy?=
 =?utf-8?B?a3BJcmZmeUcvKzB3NmRsVGFIamVnOTZnQS9ReGhOdURORG51a0M3VFJTYWpE?=
 =?utf-8?B?YzhmVUtnMklIa1l4U2hmejhobEVtZ0ZsMDZpZUQ1WndBZGFzbTh2SmJCMVB2?=
 =?utf-8?B?YjVGVmRiQ1VnR1pKMmdFRE4yUUNaRFp6Uk5BQTlvemtRa2ZKU0ZDemFuZHRy?=
 =?utf-8?B?VXRXVEZmM204RVpKWDJvWHRBYTlCdzNtTGprR1BldmpPK2VyRUJoYU52WGdD?=
 =?utf-8?B?YXZQTy91QlBNalgrZS9PNUdJbEpoTitDR2psazdZMGxobE5rYnR4N3paK203?=
 =?utf-8?B?djh6ekEyRXlBdUh6dG1vU0R3VGp0YmV6NDdncmtOeWYvOGNLKzlwN0RJVHRa?=
 =?utf-8?B?bjRoYWN4TlRwclYvOFpVYndWelI1Nlk2RnRmVEhBR1h6VGUyY2lvVENMYm83?=
 =?utf-8?B?N055REQzOVRQWllJZnZZZktwYzNSL1NGdUkyQXY0YnpHSEdiV0p1bkZLbGpp?=
 =?utf-8?B?amZvbFBBb1M0OE94TjF1UTBBTElFMEdjWjNmTFFUbXpheGhhT1NYRnVEWUh3?=
 =?utf-8?B?LzNSTG5sUllyRHR2VUt6Q1N4dnRGM2loUU5vaDFzL285UElxKzQ4QkJmVnJt?=
 =?utf-8?B?R0Z1Z2wrOEZvZm1INElkQ2k3S08zZEpsNFNaV2xzSjRxaFdMSjl1YTJscDNo?=
 =?utf-8?B?ZmJ3ZFc3MFpXOVRMeVZYaEZFNGxJTkp4aDFSb3RXRGltZ1pGK085QkZDY2dZ?=
 =?utf-8?B?WnRNRG8wOWJleU1UWXNCM0xrVDduRVdjcTZYWjJxQisyTnZCbE1JTnA3cG1m?=
 =?utf-8?B?dDVjNlpRWG1EZE9JQmJlYU1hL1N1a2pvRHpRSFBnVlNlMzM1Z2dKemREc2cz?=
 =?utf-8?B?RWppZm1SWmhHVEhyWTJwZjZVT2dSNG93NDZSSmM1MGtwZFpIWWVyR2JVbnMv?=
 =?utf-8?B?YXduM0IwVjhXQnlxRDQ1OEhVQWVuL0ZpaktOMmg3ZG0zcGVnci9mWXlhU1lG?=
 =?utf-8?B?aCsza0NFQkpMY0lPV2NVWVNRdHBIczJrWlRHMUtmZjVJb2IzNkpIVTViSTFa?=
 =?utf-8?B?c3VEZFRkbkoyN25Ga2U4ckhuM00yNjVjRlRPaC9mUG5ueUhRaVZVYTBMVG5P?=
 =?utf-8?B?T3FzWUlvcnQ3YkY5Nnd1WmNneHBIY3R5WDJhS2s5Q1hISm42bU9UV2ZPUlJk?=
 =?utf-8?B?N1FqQzFVcmhDK2dtbHJUcUJ3L2ZiRkhSQUo0YnFRejRyeEFsNGc0eXNPMVV0?=
 =?utf-8?B?Rm5WODBsZytxcWdjbzNEVmVoRmpPcm5XYk11eVNaSExmNkgvUFJpdHVpeHVj?=
 =?utf-8?B?NnRoSHZ3ZlovZVN2TFA3RDNRcFk0Z1lNaXFLUT09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:01:37.8225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d57916a-d41e-4d2e-28fd-08dd922f0f9a
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3912

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi330. The smi330 is a combined
three axis angular rate and three axis acceleration sensor.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/Kconfig              |   1 +
 drivers/iio/imu/Makefile             |   1 +
 drivers/iio/imu/smi330/Kconfig       |  91 +++
 drivers/iio/imu/smi330/Makefile      |   5 +
 drivers/iio/imu/smi330/smi330.h      | 249 ++++++++
 drivers/iio/imu/smi330/smi330_core.c | 824 +++++++++++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c  | 139 +++++
 drivers/iio/imu/smi330/smi330_spi.c  |  76 +++
 8 files changed, 1386 insertions(+)
 create mode 100644 drivers/iio/imu/smi330/Kconfig
 create mode 100644 drivers/iio/imu/smi330/Makefile
 create mode 100644 drivers/iio/imu/smi330/smi330.h
 create mode 100644 drivers/iio/imu/smi330/smi330_core.c
 create mode 100644 drivers/iio/imu/smi330/smi330_i2c.c
 create mode 100644 drivers/iio/imu/smi330/smi330_spi.c

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 15612f0f189..01d21e4034c 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -124,6 +124,7 @@ config SMI240
 	  This driver can also be built as a module. If so, the module will be
 	  called smi240.
 
+source "drivers/iio/imu/smi330/Kconfig"
 source "drivers/iio/imu/st_lsm6dsx/Kconfig"
 source "drivers/iio/imu/st_lsm9ds0/Kconfig"
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index e901aea498d..25948247df9 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -31,5 +31,6 @@ obj-$(CONFIG_KMX61) += kmx61.o
 
 obj-$(CONFIG_SMI240) += smi240.o
 
+obj-y += smi330/
 obj-y += st_lsm6dsx/
 obj-y += st_lsm9ds0/
diff --git a/drivers/iio/imu/smi330/Kconfig b/drivers/iio/imu/smi330/Kconfig
new file mode 100644
index 00000000000..1298c59a74a
--- /dev/null
+++ b/drivers/iio/imu/smi330/Kconfig
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# SMI330 IMU driver
+#
+
+config SMI330
+	tristate "Bosch Sensor SMI330 Inertial Measurement Unit"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Enable support for the Bosch SMI330 IMU.
+
+	  The driver supports different operation modes like polling,
+	  data ready or fifo mode and advanced features like no-motion,
+	  no-motion, any-motion or tilt detection.
+
+if SMI330
+
+choice
+	prompt "Select communication interface"
+	help
+	  Choose communication interface for the sensor.
+
+	  Make sure the sensor is connected accordingly.
+	  SPI and I2C are not supported at the same time,
+	  choose either SPI or I2C to build the driver.
+
+	config SMI330_SPI
+		bool "Enable SPI connection"
+		depends on SPI
+		select REGMAP_SPI
+		help
+		  Enables SPI communication interface.
+
+		  Make sure the sensor is connected to the SPI bus.
+		  To specifiy further parameters like max frequency
+		  use the device tree.
+
+	config SMI330_I2C
+		bool "Enable I2C connection"
+		depends on I2C
+		select REGMAP_I2C
+		help
+		  Enables I2C communication interface.
+
+		  Make sure the sensor is connected to the I2C bus.
+		  To specifiy further parameters like the address
+		  use the device tree.
+endchoice
+
+choice
+	prompt "Map data interrupt"
+	default SMI330_IRQ_DATA_INT1
+	help
+	  Map data interrupt to INT1 or INT2.
+
+	  NONE: data interrupt disabled
+	  INT1: data interrupt mapped to INT1
+	  INT2: data interrupt mapped to INT2
+
+	config SMI330_IRQ_DATA_NONE
+		bool "NONE"
+		help
+		  Data interrupt disabled.
+
+		  In this mode only polling is possible.
+		  To activate data ready of fifo mode choose
+		  INT1 or INT2.
+
+	config SMI330_IRQ_DATA_INT1
+		bool "INT1"
+		help
+		  Data interrupt mapped to INT1.
+
+		  In this mode data ready is the default mode.
+		  The interrupt is triggered when new data is available.
+		  When fifo watermark is set, fifo mode is activated.
+		  The interrupt is triggered when fifo watermark level is reached.
+
+	config SMI330_IRQ_DATA_INT2
+		bool "INT2"
+		help
+		  Data interrupt mapped to INT2.
+
+		  In this mode data ready is the default mode.
+		  The interrupt is triggered when new data is available.
+		  When fifo watermark is set, fifo mode is activated.
+		  The interrupt is triggered when fifo watermark level is reached.
+endchoice
+
+endif  # SMI330
diff --git a/drivers/iio/imu/smi330/Makefile b/drivers/iio/imu/smi330/Makefile
new file mode 100644
index 00000000000..3dfb98f6345
--- /dev/null
+++ b/drivers/iio/imu/smi330/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SMI330) += smi330.o
+smi330-$(CONFIG_SMI330) := smi330_core.o
+smi330-$(CONFIG_SMI330_I2C) += smi330_i2c.o
+smi330-$(CONFIG_SMI330_SPI) += smi330_spi.o
diff --git a/drivers/iio/imu/smi330/smi330.h b/drivers/iio/imu/smi330/smi330.h
new file mode 100644
index 00000000000..c7de934df8d
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330.h
@@ -0,0 +1,249 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#ifndef _SMI330_H
+#define _SMI330_H
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#define SMI330_NO_ERROR_MASK (BIT(2) | BIT(0))
+#define SMI330_ST_SUCCESS_MASK GENMASK(6, 0)
+
+#define SMI330_ALL_CHAN_MSK GENMASK(6, 0)
+
+#define SMI330_CHIP_ID 0x42
+
+#define SMI330_SPI_WR_MASK GENMASK(6, 0)
+#define SMI330_SPI_RD_MASK BIT(7)
+
+#define SMI330_SOFT_RESET_DELAY 2000
+
+/* Register map */
+#define SMI330_CHIP_ID_REG U8_C(0x00)
+#define SMI330_ERR_REG U8_C(0x01)
+#define SMI330_STATUS_REG U8_C(0x02)
+#define SMI330_ACCEL_X_REG U8_C(0x03)
+#define SMI330_GYRO_X_REG U8_C(0x06)
+#define SMI330_TEMP_REG U8_C(0x09)
+#define SMI330_INT1_STATUS_REG U8_C(0x0D)
+#define SMI330_FEATURE_IO0_REG U8_C(0x10)
+#define SMI330_FEATURE_IO1_REG U8_C(0x11)
+#define SMI330_FEATURE_IO2_REG U8_C(0x12)
+#define SMI330_FEATURE_IO_STATUS_REG U8_C(0x14)
+#define SMI330_FIFO_FILL_LEVEL_REG U8_C(0x15)
+#define SMI330_FIFO_DATA_REG U8_C(0x16)
+#define SMI330_ACCEL_CFG_REG U8_C(0x20)
+#define SMI330_GYRO_CFG_REG U8_C(0x21)
+#define SMI330_ALT_ACCEL_CFG_REG U8_C(0x28)
+#define SMI330_ALT_GYRO_CFG_REG U8_C(0x29)
+#define SMI330_ALT_CONF_REG U8_C(0x2A)
+#define SMI330_ALT_STATUS_REG U8_C(0x2B)
+#define SMI330_FIFO_WATERMARK_REG U8_C(0x35)
+#define SMI330_FIFO_CONF_REG U8_C(0x36)
+#define SMI330_FIFO_CTRL_REG U8_C(0x37)
+#define SMI330_IO_INT_CTRL_REG U8_C(0x38)
+#define SMI330_INT_CONF_REG U8_C(0x39)
+#define SMI330_INT_MAP1_REG U8_C(0x3A)
+#define SMI330_INT_MAP2_REG U8_C(0x3B)
+#define SMI330_FEATURE_CTRL_REG U8_C(0x40)
+#define SMI330_FEATURE_DATA_ADDR_REG U8_C(0x41)
+#define SMI330_FEATURE_DATA_TX_REG U8_C(0x42)
+#define SMI330_FEATURE_DATA_STATUS_REG U8_C(0x43)
+#define SMI330_CMD_REG U8_C(0x7E)
+#define SMI330_RES_CFG_REG U8_C(0x7F)
+
+/* Register mask */
+#define SMI330_ERR_FATAL_MASK BIT(0)
+#define SMI330_ERR_ACC_CONF_MASK BIT(5)
+#define SMI330_ERR_GYR_CONF_MASK BIT(6)
+#define SMI330_STATUS_POR_MASK BIT(0)
+#define SMI330_INT_STATUS_NOMO_MASK BIT(0)
+#define SMI330_INT_STATUS_ANYMO_MASK BIT(1)
+#define SMI330_INT_STATUS_TILT_MASK BIT(7)
+#define SMI330_INT_STATUS_GYR_DRDY_MASK BIT(12)
+#define SMI330_INT_STATUS_ACC_DRDY_MASK BIT(13)
+#define SMI330_INT_STATUS_FWM_MASK BIT(14)
+#define SMI330_INT_STATUS_FFULL_MASK BIT(15)
+#define SMI330_FEATURE_IO0_NOMO_X_EN_MASK BIT(0)
+#define SMI330_FEATURE_IO0_NOMO_Y_EN_MASK BIT(1)
+#define SMI330_FEATURE_IO0_NOMO_Z_EN_MASK BIT(2)
+#define SMI330_FEATURE_IO0_ANYMO_X_EN_MASK BIT(3)
+#define SMI330_FEATURE_IO0_ANYMO_Y_EN_MASK BIT(4)
+#define SMI330_FEATURE_IO0_ANYMO_Z_EN_MASK BIT(5)
+#define SMI330_FEATURE_IO0_TILT_EN_MASK BIT(11)
+#define SMI330_FEATURE_IO1_ERROR_MASK GENMASK(3, 0)
+#define SMI330_FEATURE_IO1_SC_COMPLETE_MASK BIT(4)
+#define SMI330_FEATURE_IO1_ST_RESULT_MASK BIT(6)
+#define SMI330_FEATURE_IO1_STATE_MASK GENMASK(12, 11)
+#define SMI330_FEATURE_IO_STATUS_MASK BIT(0)
+#define SMI330_FIFO_FILL_LEVEL_MASK GENMASK(10, 0)
+#define SMI330_CFG_MASK GENMASK(15, 0)
+#define SMI330_CFG_ODR_MASK GENMASK(3, 0)
+#define SMI330_CFG_RANGE_MASK GENMASK(6, 4)
+#define SMI330_CFG_BW_MASK BIT(7)
+#define SMI330_CFG_AVG_NUM_MASK GENMASK(10, 8)
+#define SMI330_CFG_MODE_MASK GENMASK(14, 12)
+#define SMI330_ALT_CONF_ACC_EN_MASK BIT(0)
+#define SMI330_ALT_CONF_GYR_EN_MASK BIT(4)
+#define SMI330_ALT_CONF_EN_MASK \
+	(SMI330_ALT_CONF_ACC_EN_MASK | SMI330_ALT_CONF_GYR_EN_MASK)
+#define SMI330_ALT_CONF_RST_CONF_EN_MASK BIT(8)
+#define SMI330_FIFO_WATERMARK_MASK GENMASK(9, 0)
+#define SMI330_FIFO_CONF_MASK GENMASK(11, 9)
+#define SMI330_FIFO_CONF_TEMP_MASK BIT(11)
+#define SMI330_FIFO_CONF_GYR_MASK BIT(10)
+#define SMI330_FIFO_CONF_ACC_MASK BIT(9)
+#define SMI330_FIFO_CTRL_FLUSH_MASK BIT(0)
+#define SMI330_IO_INT_CTRL_INT1_MASK GENMASK(2, 0)
+#define SMI330_IO_INT_CTRL_INT2_MASK GENMASK(10, 8)
+#define SMI330_INT_CONF_LATCH_MASK BIT(0)
+#define SMI330_INT_MAP1_TILT_MASK GENMASK(15, 14)
+#define SMI330_INT_MAP1_ANYMO_MASK GENMASK(3, 2)
+#define SMI330_INT_MAP1_NOMO_MASK GENMASK(1, 0)
+#define SMI330_INT_MAP2_FIFO_FULL_MASK GENMASK(15, 14)
+#define SMI330_INT_MAP2_FIFO_WM_MASK GENMASK(13, 12)
+#define SMI330_INT_MAP2_ACC_DRDY_MASK GENMASK(11, 10)
+#define SMI330_INT_MAP2_GYR_DRDY_MASK GENMASK(9, 8)
+#define SMI330_INT_MAP2_FIFO_MASK \
+	(SMI330_INT_MAP2_FIFO_FULL_MASK | SMI330_INT_MAP2_FIFO_WM_MASK)
+#define SMI330_INT_MAP2_DRDY_MASK \
+	(SMI330_INT_MAP2_ACC_DRDY_MASK | SMI330_INT_MAP2_GYR_DRDY_MASK)
+#define SMI330_FEATURE_DATA_STATUS_TX_READY_MASK BIT(1)
+
+/* Register values */
+#define SMI330_FEATURE_IO2_STARTUP_CONFIG 0x012C
+#define SMI330_IO_INT_CTRL_LVL BIT(0)
+#define SMI330_IO_INT_CTRL_OD BIT(1)
+#define SMI330_IO_INT_CTRL_EN BIT(2)
+#define SMI330_FEATURE_CTRL_ENABLE BIT(0)
+#define SMI330_CMD_SELF_CALIBRATION (BIT(0) | BIT(8))
+#define SMI330_CMD_SELF_TEST BIT(8)
+#define SMI330_CMD_SOFT_RESET 0xDEAF
+
+/* T°C = (temp / 512) + 23 */
+#define SMI330_TEMP_OFFSET 11776 /* 23 * 512 */
+#define SMI330_TEMP_SCALE 1953125 /* (1 / 512) * 1e9 */
+
+enum {
+	SMI330_SCAN_ACCEL_X,
+	SMI330_SCAN_ACCEL_Y,
+	SMI330_SCAN_ACCEL_Z,
+	SMI330_SCAN_GYRO_X,
+	SMI330_SCAN_GYRO_Y,
+	SMI330_SCAN_GYRO_Z,
+	SMI330_TEMP_OBJECT,
+	SMI330_SCAN_TIMESTAMP,
+};
+
+enum smi330_accel_range {
+	SMI330_ACCEL_RANGE_2G = U8_C(0x00),
+	SMI330_ACCEL_RANGE_4G = U8_C(0x01),
+	SMI330_ACCEL_RANGE_8G = U8_C(0x02),
+	SMI330_ACCEL_RANGE_16G = U8_C(0x03)
+};
+
+enum smi330_gyro_range {
+	SMI330_GYRO_RANGE_125 = U8_C(0x00),
+	SMI330_GYRO_RANGE_250 = U8_C(0x01),
+	SMI330_GYRO_RANGE_500 = U8_C(0x02)
+};
+
+enum smi330_odr {
+	SMI330_ODR_12_5_HZ = U8_C(0x05),
+	SMI330_ODR_25_HZ = U8_C(0x06),
+	SMI330_ODR_50_HZ = U8_C(0x07),
+	SMI330_ODR_100_HZ = U8_C(0x08),
+	SMI330_ODR_200_HZ = U8_C(0x09),
+	SMI330_ODR_400_HZ = U8_C(0x0A),
+	SMI330_ODR_800_HZ = U8_C(0x0B),
+	SMI330_ODR_1600_HZ = U8_C(0x0C),
+	SMI330_ODR_3200_HZ = U8_C(0x0D),
+	SMI330_ODR_6400_HZ = U8_C(0x0E)
+};
+
+enum smi330_avg_num {
+	SMI330_AVG_NUM_1 = U8_C(0x00),
+	SMI330_AVG_NUM_2 = U8_C(0x01),
+	SMI330_AVG_NUM_4 = U8_C(0x02),
+	SMI330_AVG_NUM_8 = U8_C(0x03),
+	SMI330_AVG_NUM_16 = U8_C(0x04),
+	SMI330_AVG_NUM_32 = U8_C(0x05),
+	SMI330_AVG_NUM_64 = U8_C(0x06)
+};
+
+enum smi330_mode {
+	SMI330_MODE_SUSPEND = U8_C(0x00),
+	SMI330_MODE_GYRO_DRIVE = U8_C(0x01),
+	SMI330_MODE_LOW_POWER = U8_C(0x03),
+	SMI330_MODE_NORMAL = U8_C(0x04),
+	SMI330_MODE_HIGH_PERF = U8_C(0x07)
+};
+
+enum smi330_bw {
+	SMI330_BW_2 = U8_C(0x00), /* ODR/2 */
+	SMI330_BW_4 = U8_C(0x01) /* ODR/4 */
+};
+
+enum smi330_operation_mode {
+	SMI330_IDLE,
+	SMI330_DATA_READY,
+};
+
+enum smi330_sensor {
+	SMI330_ACCEL,
+	SMI330_GYRO,
+};
+
+enum smi330_sensor_conf_select {
+	SMI330_ODR,
+	SMI330_RANGE,
+	SMI330_BW,
+	SMI330_AVG_NUM,
+};
+
+enum smi330_int_out {
+	SMI330_INT_DISABLED,
+	SMI330_INT_1,
+	SMI330_INT_2,
+};
+
+struct smi330_sysfs_attr {
+	int *reg_vals;
+	int *vals;
+	int len;
+	int type;
+	int mask;
+};
+
+struct smi330_cfg {
+	enum smi330_operation_mode op_mode;
+	enum smi330_int_out data_irq;
+};
+
+struct smi330_data {
+	struct regmap *regmap;
+	struct smi330_cfg cfg;
+	s64 current_timestamp;
+	atomic64_t irq_timestamp;
+	struct iio_trigger *trig;
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
+int smi330_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _SMI330_H */
diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
new file mode 100644
index 00000000000..d82f3f4eeb3
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -0,0 +1,824 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "smi330.h"
+
+// clang-format off
+#define SMI330_ACCEL_CHANNEL(_type, _axis, _index) {			\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_dir =					\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_dir_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = _index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+#define SMI330_GYRO_CHANNEL(_type, _axis, _index) {			\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_dir =					\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_dir_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = _index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+#define SMI330_TEMP_CHANNEL(_index) {			\
+	.type = IIO_TEMP,				\
+	.modified = 1,					\
+	.channel2 = IIO_MOD_TEMP_OBJECT,		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_OFFSET) |		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = _index,				\
+	.scan_type = {					\
+		.sign = 's',				\
+		.realbits = 16,				\
+		.storagebits = 16,			\
+		.endianness = IIO_LE,			\
+	},						\
+}
+
+// clang-format on
+
+static const struct iio_chan_spec smi330_channels[] = {
+	SMI330_ACCEL_CHANNEL(IIO_ACCEL, X, SMI330_SCAN_ACCEL_X),
+	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Y, SMI330_SCAN_ACCEL_Y),
+	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Z, SMI330_SCAN_ACCEL_Z),
+	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, X, SMI330_SCAN_GYRO_X),
+	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Y, SMI330_SCAN_GYRO_Y),
+	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Z, SMI330_SCAN_GYRO_Z),
+	SMI330_TEMP_CHANNEL(SMI330_TEMP_OBJECT),
+	IIO_CHAN_SOFT_TIMESTAMP(SMI330_SCAN_TIMESTAMP),
+};
+
+static const struct smi330_sysfs_attr smi330_accel_scale_attr = {
+	.reg_vals = (int[]){ SMI330_ACCEL_RANGE_2G, SMI330_ACCEL_RANGE_4G,
+			     SMI330_ACCEL_RANGE_8G, SMI330_ACCEL_RANGE_16G },
+	.vals = (int[]){ 0, 61035, 0, 122070, 0, 244140, 0, 488281 },
+	.len = 8,
+	.type = IIO_VAL_INT_PLUS_NANO,
+	.mask = SMI330_CFG_RANGE_MASK
+};
+
+static const struct smi330_sysfs_attr smi330_gyro_scale_attr = {
+	.reg_vals = (int[]){ SMI330_GYRO_RANGE_125, SMI330_GYRO_RANGE_250,
+			     SMI330_GYRO_RANGE_500 },
+	.vals = (int[]){ 0, 3814697, 0, 7629395, 0, 15258789 },
+	.len = 6,
+	.type = IIO_VAL_INT_PLUS_NANO,
+	.mask = SMI330_CFG_RANGE_MASK
+};
+
+static const struct smi330_sysfs_attr smi330_average_attr = {
+	.reg_vals = (int[]){ SMI330_AVG_NUM_1, SMI330_AVG_NUM_2,
+			     SMI330_AVG_NUM_4, SMI330_AVG_NUM_8,
+			     SMI330_AVG_NUM_16, SMI330_AVG_NUM_32,
+			     SMI330_AVG_NUM_64 },
+	.vals = (int[]){ 1, 2, 4, 8, 16, 32, 64 },
+	.len = 7,
+	.type = IIO_VAL_INT,
+	.mask = SMI330_CFG_AVG_NUM_MASK
+};
+
+static const struct smi330_sysfs_attr smi330_bandwidth_attr = {
+	.reg_vals = (int[]){ SMI330_BW_2, SMI330_BW_4 },
+	.vals = (int[]){ 2, 4 },
+	.len = 2,
+	.type = IIO_VAL_INT,
+	.mask = SMI330_CFG_BW_MASK
+};
+
+static const struct smi330_sysfs_attr smi330_odr_attr = {
+	.reg_vals = (int[]){ SMI330_ODR_12_5_HZ, SMI330_ODR_25_HZ,
+			     SMI330_ODR_50_HZ, SMI330_ODR_100_HZ,
+			     SMI330_ODR_200_HZ, SMI330_ODR_400_HZ,
+			     SMI330_ODR_800_HZ, SMI330_ODR_1600_HZ,
+			     SMI330_ODR_3200_HZ, SMI330_ODR_6400_HZ },
+	.vals = (int[]){ 12, 25, 50, 100, 200, 400, 800, 1600, 3200, 6400 },
+	.len = 10,
+	.type = IIO_VAL_INT,
+	.mask = SMI330_CFG_ODR_MASK
+};
+
+static int smi330_get_sysfs_attr(enum smi330_sensor_conf_select config,
+				 enum smi330_sensor sensor,
+				 const struct smi330_sysfs_attr **attr)
+{
+	switch (config) {
+	case SMI330_ODR:
+		*attr = &smi330_odr_attr;
+		return 0;
+	case SMI330_RANGE:
+		if (sensor == SMI330_ACCEL)
+			*attr = &smi330_accel_scale_attr;
+		else
+			*attr = &smi330_gyro_scale_attr;
+		return 0;
+	case SMI330_BW:
+		*attr = &smi330_bandwidth_attr;
+		return 0;
+	case SMI330_AVG_NUM:
+		*attr = &smi330_average_attr;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi330_get_config_reg(enum smi330_sensor sensor, int *reg)
+{
+	switch (sensor) {
+	case SMI330_ACCEL:
+		*reg = SMI330_ACCEL_CFG_REG;
+		return 0;
+	case SMI330_GYRO:
+		*reg = SMI330_GYRO_CFG_REG;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi330_get_sensor_config(struct smi330_data *data,
+				    enum smi330_sensor sensor,
+				    enum smi330_sensor_conf_select config,
+				    int *value)
+
+{
+	int ret, reg, reg_val, i;
+	const struct smi330_sysfs_attr *attr;
+
+	ret = smi330_get_config_reg(sensor, &reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, reg, &reg_val);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_sysfs_attr(config, sensor, &attr);
+	if (ret)
+		return ret;
+
+	/* FIELD_GET is not possible with non-const mask */
+	reg_val = (reg_val & attr->mask) >> (__builtin_ffs(attr->mask) - 1);
+
+	if (attr->type == IIO_VAL_INT) {
+		for (i = 0; i < attr->len; i++) {
+			if (attr->reg_vals[i] == reg_val) {
+				*value = attr->vals[i];
+				return 0;
+			}
+		}
+	} else {
+		for (i = 0; i < attr->len / 2; i++) {
+			if (attr->reg_vals[i] == reg_val) {
+				*value = attr->vals[2 * i + 1];
+				return 0;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int smi330_set_sensor_config(struct smi330_data *data,
+				    enum smi330_sensor sensor,
+				    enum smi330_sensor_conf_select config,
+				    int value)
+{
+	int ret, i, reg, reg_val, error;
+	const struct smi330_sysfs_attr *attr;
+
+	ret = smi330_get_sysfs_attr(config, sensor, &attr);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < attr->len; i++) {
+		if (attr->vals[i] == value) {
+			if (attr->type == IIO_VAL_INT)
+				reg_val = attr->reg_vals[i];
+			else
+				reg_val = attr->reg_vals[i / 2];
+			break;
+		}
+	}
+	if (i == attr->len)
+		return -EINVAL;
+
+	ret = smi330_get_config_reg(sensor, &reg);
+	if (ret)
+		return ret;
+
+	/* FIELD_PREP is not possible with non-const mask */
+	reg_val = ((reg_val << (__builtin_ffs(attr->mask) - 1)) & attr->mask);
+
+	ret = regmap_update_bits(data->regmap, reg, attr->mask, reg_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, SMI330_ERR_REG, &error);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(SMI330_ERR_ACC_CONF_MASK, error) ||
+	    FIELD_GET(SMI330_ERR_GYR_CONF_MASK, error))
+		return -EIO;
+
+	return 0;
+}
+
+static int smi330_get_data(struct smi330_data *data, int chan_type, int axis,
+			   int *val)
+{
+	u8 reg;
+	int ret, sample;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		reg = SMI330_ACCEL_X_REG + (axis - IIO_MOD_X);
+		break;
+	case IIO_ANGL_VEL:
+		reg = SMI330_GYRO_X_REG + (axis - IIO_MOD_X);
+		break;
+	case IIO_TEMP:
+		reg = SMI330_TEMP_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
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
+static int smi330_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, const int **vals,
+			     int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_ACCEL) {
+			*vals = smi330_accel_scale_attr.vals;
+			*length = smi330_accel_scale_attr.len;
+			*type = smi330_accel_scale_attr.type;
+		} else {
+			*vals = smi330_gyro_scale_attr.vals;
+			*length = smi330_gyro_scale_attr.len;
+			*type = smi330_gyro_scale_attr.type;
+		}
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = smi330_average_attr.vals;
+		*length = smi330_average_attr.len;
+		*type = smi330_average_attr.type;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = smi330_bandwidth_attr.vals;
+		*length = smi330_bandwidth_attr.len;
+		*type = smi330_bandwidth_attr.type;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = smi330_odr_attr.vals;
+		*length = smi330_odr_attr.len;
+		*type = smi330_odr_attr.type;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int smi330_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	int ret;
+	struct smi330_data *data = iio_priv(indio_dev);
+	enum smi330_sensor sensor;
+
+	/* valid for all channel types */
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = smi330_get_data(data, chan->type, chan->channel2, val);
+		iio_device_release_direct(indio_dev);
+		return ret ? ret : IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		sensor = SMI330_ACCEL;
+		break;
+	case IIO_ANGL_VEL:
+		sensor = SMI330_GYRO;
+		break;
+	case IIO_TEMP:
+		switch (mask) {
+		case IIO_CHAN_INFO_SCALE:
+			*val = SMI330_TEMP_SCALE / GIGA;
+			*val2 = SMI330_TEMP_SCALE % GIGA;
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_CHAN_INFO_OFFSET:
+			*val = SMI330_TEMP_OFFSET;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	/* valid for acc and gyro channels */
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = smi330_get_sensor_config(data, sensor, SMI330_AVG_NUM,
+					       val);
+		return ret ? ret : IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = smi330_get_sensor_config(data, sensor, SMI330_BW, val);
+		return ret ? ret : IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = smi330_get_sensor_config(data, sensor, SMI330_ODR, val);
+		return ret ? ret : IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		ret = smi330_get_sensor_config(data, sensor, SMI330_RANGE,
+					       val2);
+		return ret ? ret : IIO_VAL_INT_PLUS_NANO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi330_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	int ret;
+	struct smi330_data *data = iio_priv(indio_dev);
+	enum smi330_sensor sensor;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		sensor = SMI330_ACCEL;
+		break;
+	case IIO_ANGL_VEL:
+		sensor = SMI330_GYRO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return smi330_set_sensor_config(data, sensor, SMI330_RANGE,
+						val2);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return smi330_set_sensor_config(data, sensor, SMI330_AVG_NUM,
+						val);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return smi330_set_sensor_config(data, sensor, SMI330_BW, val);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = smi330_set_sensor_config(data, SMI330_ACCEL, SMI330_ODR,
+					       val);
+		if (ret)
+			return ret;
+
+		return smi330_set_sensor_config(data, SMI330_GYRO, SMI330_ODR,
+						val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi330_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int smi330_soft_reset(struct smi330_data *data)
+{
+	int ret, dummy_byte;
+
+	ret = regmap_write(data->regmap, SMI330_CMD_REG, SMI330_CMD_SOFT_RESET);
+	if (ret)
+		return ret;
+	fsleep(SMI330_SOFT_RESET_DELAY);
+
+	/* Performing a dummy read after a soft-reset */
+	regmap_read(data->regmap, SMI330_CHIP_ID_REG, &dummy_byte);
+
+	return 0;
+}
+
+static irqreturn_t smi330_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct smi330_data *data = iio_priv(indio_dev);
+	int ret, sample, chan;
+	int i = 0;
+
+	/* Ignore if buffer disabled */
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	if (data->cfg.op_mode == SMI330_IDLE)
+		data->current_timestamp = iio_get_time_ns(indio_dev);
+
+	if (*indio_dev->active_scan_mask == SMI330_ALL_CHAN_MSK) {
+		ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG,
+				       data->buf, ARRAY_SIZE(smi330_channels));
+		if (ret)
+			goto out;
+	} else {
+		iio_for_each_active_channel(indio_dev, chan) {
+			ret = regmap_read(data->regmap,
+					  SMI330_ACCEL_X_REG + chan, &sample);
+			if (ret)
+				goto out;
+			data->buf[i++] = sample;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
+					   data->current_timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t smi330_irq_thread_handler(int irq, void *indio_dev_)
+{
+	int ret, int_stat;
+	s16 int_status[2] = { 0 };
+	struct iio_dev *indio_dev = indio_dev_;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	data->current_timestamp = atomic64_read(&data->irq_timestamp);
+
+	ret = regmap_bulk_read(data->regmap, SMI330_INT1_STATUS_REG, int_status,
+			       2);
+	if (ret)
+		return IRQ_NONE;
+
+	int_stat = int_status[0] | int_status[1];
+
+	if (FIELD_GET(SMI330_INT_STATUS_ACC_DRDY_MASK, int_stat) ||
+	    FIELD_GET(SMI330_INT_STATUS_GYR_DRDY_MASK, int_stat)) {
+		iio_trigger_poll_nested(data->trig);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t smi330_irq_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	atomic64_set(&data->irq_timestamp, iio_get_time_ns(indio_dev));
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int smi330_set_int_pin_config(struct smi330_data *data,
+				     enum smi330_int_out irq_num,
+				     bool active_high, bool open_drain,
+				     bool latch)
+{
+	int ret, val;
+
+	val = active_high ? SMI330_IO_INT_CTRL_LVL : 0;
+	val |= open_drain ? SMI330_IO_INT_CTRL_OD : 0;
+	val |= SMI330_IO_INT_CTRL_EN;
+
+	switch (irq_num) {
+	case SMI330_INT_1:
+		val = FIELD_PREP(SMI330_IO_INT_CTRL_INT1_MASK, val);
+		ret = regmap_update_bits(data->regmap, SMI330_IO_INT_CTRL_REG,
+					 SMI330_IO_INT_CTRL_INT1_MASK, val);
+		if (ret)
+			return ret;
+		break;
+	case SMI330_INT_2:
+		val = FIELD_PREP(SMI330_IO_INT_CTRL_INT2_MASK, val);
+		ret = regmap_update_bits(data->regmap, SMI330_IO_INT_CTRL_REG,
+					 SMI330_IO_INT_CTRL_INT2_MASK, val);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(data->regmap, SMI330_INT_CONF_REG,
+				  SMI330_INT_CONF_LATCH_MASK,
+				  FIELD_PREP(SMI330_INT_CONF_LATCH_MASK,
+					     latch));
+}
+
+static int smi330_setup_irq(struct device *dev, struct iio_dev *indio_dev,
+			    int irq, enum smi330_int_out irq_num)
+{
+	int ret, irq_type;
+	bool open_drain, active_high, latch;
+	struct smi330_data *data = iio_priv(indio_dev);
+	struct irq_data *desc;
+	struct fwnode_handle *fwnode;
+
+	desc = irq_get_irq_data(irq);
+	if (!desc)
+		return -EINVAL;
+
+	irq_type = irqd_get_trigger_type(desc);
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+		latch = false;
+		active_high = true;
+		break;
+	case IRQF_TRIGGER_HIGH:
+		latch = true;
+		active_high = true;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		latch = false;
+		active_high = false;
+		break;
+	case IRQF_TRIGGER_LOW:
+		latch = true;
+		active_high = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fwnode = dev_fwnode(dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	open_drain = fwnode_property_read_bool(fwnode, "drive-open-drain");
+
+	ret = smi330_set_int_pin_config(data, irq_num, active_high, open_drain,
+					latch);
+	if (ret)
+		return ret;
+
+	return devm_request_threaded_irq(dev, irq, smi330_irq_handler,
+					 smi330_irq_thread_handler, irq_type,
+					 indio_dev->name, indio_dev);
+}
+
+static int smi330_register_irq(struct device *dev, struct iio_dev *indio_dev)
+{
+	int ret, irq;
+	struct smi330_data *data = iio_priv(indio_dev);
+	struct smi330_cfg *cfg = &data->cfg;
+	struct fwnode_handle *fwnode;
+
+	fwnode = dev_fwnode(dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq > 0) {
+		ret = smi330_setup_irq(dev, indio_dev, irq, SMI330_INT_1);
+		if (ret)
+			return ret;
+	} else if (cfg->data_irq == SMI330_INT_1) {
+		return -ENODEV;
+	}
+
+	irq = fwnode_irq_get_byname(fwnode, "INT2");
+	if (irq > 0) {
+		ret = smi330_setup_irq(dev, indio_dev, irq, SMI330_INT_2);
+		if (ret)
+			return ret;
+	} else if (cfg->data_irq == SMI330_INT_2) {
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int smi330_set_drdy_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	int val;
+	struct smi330_data *data = iio_trigger_get_drvdata(trig);
+
+	if (enable)
+		data->cfg.op_mode = SMI330_DATA_READY;
+	else
+		data->cfg.op_mode = SMI330_IDLE;
+
+	val = FIELD_PREP(SMI330_INT_MAP2_ACC_DRDY_MASK,
+			 enable ? data->cfg.data_irq : 0);
+	val |= FIELD_PREP(SMI330_INT_MAP2_GYR_DRDY_MASK,
+			  enable ? data->cfg.data_irq : 0);
+	return regmap_update_bits(data->regmap, SMI330_INT_MAP2_REG,
+				  SMI330_INT_MAP2_DRDY_MASK, val);
+}
+
+static const struct iio_trigger_ops smi330_trigger_ops = {
+	.set_trigger_state = &smi330_set_drdy_trigger_state,
+};
+
+static struct iio_info smi330_info = {
+	.read_avail = smi330_read_avail,
+	.read_raw = smi330_read_raw,
+	.write_raw = smi330_write_raw,
+	.write_raw_get_fmt = smi330_write_raw_get_fmt,
+};
+
+static int smi330_dev_init(struct smi330_data *data)
+{
+	int ret, chip_id, val, mode;
+	struct device *dev = regmap_get_device(data->regmap);
+
+	ret = regmap_read(data->regmap, SMI330_CHIP_ID_REG, &chip_id);
+	if (ret)
+		return ret;
+
+	chip_id &= 0x00FF;
+
+	if (chip_id != SMI330_CHIP_ID)
+		dev_info(dev, "Unknown chip id: 0x%04x\n", chip_id);
+
+	ret = regmap_read(data->regmap, SMI330_ERR_REG, &val);
+	if (ret || FIELD_GET(SMI330_ERR_FATAL_MASK, val))
+		return -ENODEV;
+
+	ret = regmap_read(data->regmap, SMI330_STATUS_REG, &val);
+	if (ret || FIELD_GET(SMI330_STATUS_POR_MASK, val) == 0)
+		return -ENODEV;
+
+	mode = FIELD_PREP(SMI330_CFG_MODE_MASK, SMI330_MODE_NORMAL);
+
+	ret = regmap_update_bits(data->regmap, SMI330_ACCEL_CFG_REG,
+				 SMI330_CFG_MODE_MASK, mode);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, SMI330_GYRO_CFG_REG,
+				  SMI330_CFG_MODE_MASK, mode);
+}
+
+int smi330_core_probe(struct device *dev, struct regmap *regmap)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct smi330_data *data;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	dev_set_drvdata(dev, indio_dev);
+	data->regmap = regmap;
+
+	if (IS_ENABLED(CONFIG_SMI330_IRQ_DATA_INT1))
+		data->cfg.data_irq = SMI330_INT_1;
+	else if (IS_ENABLED(CONFIG_SMI330_IRQ_DATA_INT2))
+		data->cfg.data_irq = SMI330_INT_2;
+	else
+		data->cfg.data_irq = SMI330_INT_DISABLED;
+
+	ret = smi330_soft_reset(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Soft reset failed\n");
+
+	indio_dev->channels = smi330_channels;
+	indio_dev->num_channels = ARRAY_SIZE(smi330_channels);
+	indio_dev->name = "smi330";
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->info = &smi330_info;
+
+	data->cfg.op_mode = SMI330_IDLE;
+
+	ret = smi330_dev_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Init failed\n");
+
+	if (data->cfg.data_irq != SMI330_INT_DISABLED) {
+		ret = smi330_register_irq(dev, indio_dev);
+		if (ret)
+			return dev_err_probe(
+				dev, ret,
+				"Register IRQ failed - check Kconfig and devicetree\n");
+
+		data->trig = devm_iio_trigger_alloc(dev, "%s-drdy-trigger",
+						    indio_dev->name);
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &smi330_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, data);
+
+		ret = devm_iio_trigger_register(dev, data->trig);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "IIO register trigger failed\n");
+
+		/*
+		 * Set default operation mode to data ready.
+		 */
+		indio_dev->trig = iio_trigger_get(data->trig);
+	}
+
+	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+						  iio_pollfunc_store_time,
+						  smi330_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN, NULL,
+						  NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "IIO buffer setup failed\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Register IIO device failed\n");
+
+	return 0;
+}
+MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
+MODULE_AUTHOR("Roman Huber <roman.huber@de.bosch.com>");
+MODULE_AUTHOR("Filip Andrei <Andrei.Filip@ro.bosch.com>");
+MODULE_AUTHOR("Drimbarean Avram Andrei <Avram-Andrei.Drimbarean@ro.bosch.com>");
+MODULE_DESCRIPTION("Bosch SMI330 driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/iio/imu/smi330/smi330_i2c.c b/drivers/iio/imu/smi330/smi330_i2c.c
new file mode 100644
index 00000000000..bd837003ab6
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_i2c.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include "smi330.h"
+
+#define I2C_XFER_MAX_RETRY 10
+#define I2C_WRITE_DELAY_TIME 10
+
+#define NUM_DUMMY_BYTES 2
+#define SMI330_I2C_MAX_RX_BUFFER_SIZE (NUM_DUMMY_BYTES + 32)
+
+struct smi330_i2c_priv {
+	struct i2c_client *i2c;
+	u8 rx_buffer[SMI330_I2C_MAX_RX_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+static int smi330_regmap_i2c_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	struct smi330_i2c_priv *priv = context;
+	int ret, retry;
+
+	/*
+	 * SMI330 I2C read frame:
+	 * <Slave address[6:0], RnW> <x, Register address[6:0]>
+	 * <Slave address[6:0], RnW> <Dummy[7:0]> <Dummy[7:0]> <Data_0[7:0]> <Data_1[15:8]>...
+	 *                                                     <Data_N[7:0]> <Data_N[15:8]>
+	 * Remark: Slave address is not considered part of the frame in the following definitions
+	 */
+	struct i2c_msg msgs[] = {
+		{
+			.addr = priv->i2c->addr,
+			.flags = priv->i2c->flags,
+			.len = reg_size,
+			.buf = (u8 *)reg_buf,
+		},
+		{
+			.addr = priv->i2c->addr,
+			.flags = priv->i2c->flags | I2C_M_RD,
+			.len = NUM_DUMMY_BYTES + val_size,
+			.buf = priv->rx_buffer,
+		},
+	};
+
+	for (retry = 0; retry < I2C_XFER_MAX_RETRY; retry++) {
+		ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
+		if (ret > 0)
+			break;
+
+		usleep_range(I2C_WRITE_DELAY_TIME * 1000,
+			     I2C_WRITE_DELAY_TIME * 1000);
+	}
+
+	if (retry >= I2C_XFER_MAX_RETRY) {
+		dev_err(&priv->i2c->adapter->dev, "Xfer error");
+		return -EIO;
+	}
+
+	memcpy(val_buf, priv->rx_buffer + NUM_DUMMY_BYTES, val_size);
+
+	return 0;
+}
+
+static int smi330_regmap_i2c_write(void *context, const void *data,
+				   size_t count)
+{
+	struct smi330_i2c_priv *priv = context;
+	u8 reg;
+
+	/*
+	 * SMI330 I2C write frame:
+	 * <Slave address[6:0], RnW> <x, Register address[6:0]> <Data_0[7:0]> <Data_1[15:8]>...
+	 *                                                      <Data_N[7:0]> <Data_N[15:8]>
+	 * Remark: Slave address is not considered part of the frame in the following definitions
+	 */
+	reg = *(u8 *)data;
+	return i2c_smbus_write_i2c_block_data(priv->i2c, reg,
+					      count - sizeof(u8),
+					      data + sizeof(u8));
+}
+
+static const struct regmap_bus smi330_regmap_bus = {
+	.read = smi330_regmap_i2c_read,
+	.write = smi330_regmap_i2c_write,
+};
+
+static const struct regmap_config smi330_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int smi330_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct smi330_i2c_priv *priv;
+	struct regmap *regmap;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->i2c = i2c;
+	regmap = devm_regmap_init(dev, &smi330_regmap_bus, priv,
+				  &smi330_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize I2C Regmap\n");
+
+	return smi330_core_probe(dev, regmap);
+}
+
+static const struct i2c_device_id smi330_i2c_device_id[] = {
+	{ .name = "smi330" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, smi330_i2c_device_id);
+
+static const struct of_device_id smi330_of_match[] = {
+	{ .compatible = "bosch,smi330" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, smi330_of_match);
+
+static struct i2c_driver smi330_i2c_driver = {
+	.probe = smi330_i2c_probe,
+	.id_table = smi330_i2c_device_id,
+	.driver = { .of_match_table = smi330_of_match,
+		    .name = "smi330_i2c",
+	},
+};
+module_i2c_driver(smi330_i2c_driver);
diff --git a/drivers/iio/imu/smi330/smi330_spi.c b/drivers/iio/imu/smi330/smi330_spi.c
new file mode 100644
index 00000000000..93672744452
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_spi.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "smi330.h"
+
+static int smi330_regmap_spi_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	struct spi_device *spi = context;
+
+	return spi_write_then_read(spi, reg_buf, reg_size, val_buf, val_size);
+}
+
+static int smi330_regmap_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	struct spi_device *spi = context;
+	u8 *data_buff = (u8 *)data;
+
+	data_buff[1] = data_buff[0];
+	return spi_write(spi, data_buff + 1, count - 1);
+}
+
+static const struct regmap_bus smi330_regmap_bus = {
+	.read = smi330_regmap_spi_read,
+	.write = smi330_regmap_spi_write,
+	.read_flag_mask = 0x80,
+};
+
+static const struct regmap_config smi330_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.pad_bits = 8,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int smi330_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init(&spi->dev, &smi330_regmap_bus, &spi->dev,
+				  &smi330_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to initialize SPI Regmap\n");
+
+	return smi330_core_probe(&spi->dev, regmap);
+}
+
+static const struct spi_device_id smi330_spi_device_id[] = {
+	{ .name = "smi330" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, smi330_spi_device_id);
+
+static const struct of_device_id smi330_of_match[] = {
+	{ .compatible = "bosch,smi330" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, smi330_of_match);
+
+static struct spi_driver smi330_spi_driver = {
+	.probe = smi330_spi_probe,
+	.id_table = smi330_spi_device_id,
+	.driver = { .of_match_table = smi330_of_match,
+		    .name = "smi330_spi",
+	},
+};
+module_spi_driver(smi330_spi_driver);
-- 
2.34.1


