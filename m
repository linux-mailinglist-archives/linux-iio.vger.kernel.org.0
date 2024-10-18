Return-Path: <linux-iio+bounces-10728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D549A4079
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C8CB2238B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855C1F4293;
	Fri, 18 Oct 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="L+eQu/Aj"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6D13AA2A;
	Fri, 18 Oct 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259586; cv=fail; b=K0CcbmokvJij+wMWarNnF6jyJLyQpWjENKIozx/vhE5KRTrZLFZGyPKuqiQ0W03K/BPHJGnCT3MwYTDID/6PemzoR6zLly2Hy+sF5bpUm1/J8JEPmB9wv1wAucWg1rR+/jSJ8MwPTF+ybxpQ+p3pSc5y76LBGKMxQbWA2wRyTU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259586; c=relaxed/simple;
	bh=qgnf9GCaS1BPp2WADpckvMuPPM++eRPevLHUDooy7zs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMnpGO/houA99SWc8BEMiR1U3c0wE6530Na/+d4YTewozB7+HyZnc2oHRnDQoKresXBPE+PXwd1rF2NDIvMy/s7gslDWtXRDC164ZbHJLDQPD5TLG7X0dfwr6vYN8La3b5awp8+6D+iJgly9owXfV05lwapGr9WFHwqBINP/EJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=L+eQu/Aj; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rygXQoRaEg9lKYX+VLiRwSyR7DjkBEk/36LjvVVbOwUJ2Ck/cG/mPJr03p5JC3G5TjDRSy8eXuhEu2tNX1qhR6BHE2LCoDezUy453PRykQLDrGtZXmEfvsFZX34s0+0J+svftUNew1yiuayusdFRj3SD1o3weC4zyP/bCMCGQ7HtXd5NV9cHAgb5HpNWk/sguKvBcfideKEtG+uXhdYZQWbp5jRhVXv6M4gUWNyKAOvGQ27cFLQ9XWcPjMjnZGkCm2pBMdADI4RyVIOJFLn2c9wOii6+m90ui1tUP5azYnxyt+3O4SdQxr1jvpYFzXqoeJl+qmzeubyyywH3hXbRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9VBNrz7dh1ZSAwo0OmU4oHFDqqTN9oo81pd9c5Tb8M=;
 b=tXdGtRC9Ax/mItH8NokF59j55jGeVe73yXhgmyX8KhhOt7XnQCFdwg0jIT0VXTsZrJuytDtAPHgQyWKqq6FL3tQUSKZdTuWQNl0SY9tmKoeJFLYuy+xQoG5l2NxDgfNlEANHDjNuafcKbw5xDEgLNGHCze3CLp303xVmrql3wghQx3y8HdRQJy6xMAaymIxpkxQDYkbI6GuatFp1AaGCJAjS3SOcKKMJpR8qjxOdkmb7vJKRaLqLX/ubV+1O7CmxFOsJUrNN9bX4IYpTfqLB0ik20wGeVQJXTPx1uwnlgbBFubi3BcX41cZicNsgmmqnBLMwfGuZresYX1xk05UXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9VBNrz7dh1ZSAwo0OmU4oHFDqqTN9oo81pd9c5Tb8M=;
 b=L+eQu/AjRVI0Y6W2N7etxkTBzLL59yUzOBbWAX+qi1O3mOUHQc6gkyNOfjI2h2uvEnJpOYjxOlxHxRolflmIpfBW9P1Kzk9vnOev3zfT2Vf2GzwAe+k1H9iwGW+ymWljMuIMHXCu4+f6oRyTfA0/7twrX8wZsS/+mw2DtTU+J2YsPD2QKLy13gbjy6986M4QgoPXy5EKM26Z4k+BV6Fv/VMKB1ihSdVEjhykbmjPPFAOXlCuh0DFFyW3XMLb0M6SOXDMihmucu7/quGfNx6UcAmwG7K+YEFuhvJ6Tit3b8pcDvCBSChUPNGIsNHFX9Oj9lDOjyjdz7sprBeMB+CFMA==
Received: from AS4P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::16)
 by DUZPR10MB8049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7; Fri, 18 Oct
 2024 13:52:57 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::d2) by AS4P191CA0030.outlook.office365.com
 (2603:10a6:20b:5d9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 13:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 13:52:57 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 15:52:56 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 15:52:55 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v9 2/2] iio: imu: smi240: add driver
Date: Fri, 18 Oct 2024 15:52:34 +0200
Message-ID: <20241018135234.5446-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018135234.5446-1-Jianping.Shen@de.bosch.com>
References: <20241018135234.5446-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|DUZPR10MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be7b914-39b2-4abf-653b-08dcef7c2c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTZleXFIcmVXak9MQ1Fub2dpbWxubmhVdG4rdE1PVSs3WGxDT0p2NnJTeVVz?=
 =?utf-8?B?NUpGZjhXUHJPc1hRNlloMUhsaVdLMW5CdmhDTUdHeHdOcEEwM1dneEN3ODRJ?=
 =?utf-8?B?eDFpNDhYc0FFMlBYS21aaU51RHNnKzBCb2xqK2FMdFoxallsUk5VQjExblE2?=
 =?utf-8?B?WUxaSUM0aHBsVTdSZ1BGMU5Ya1pMbFkyM0NmZjBXWHd2UnNSaEVnUXdDUUJP?=
 =?utf-8?B?dG4zSERTL1ZPZGpKbWM1emlJVGE5a1ozV29iaXJwZEJpdWRwc1B5Z3laU0ww?=
 =?utf-8?B?R2I5VHZDK0VvWmNvWEVhQjJtajk4R2JSUFcxa0o3a3lwTVVpN1MrUElLMTFl?=
 =?utf-8?B?eFFHNjk4Q1Y1eEdPRktRbHNZQUJvQVJXamttUi9uVmVqL1RyaWkxa3BBYm5C?=
 =?utf-8?B?QUlYTTUyeGpQQUhqalVUVjNxRXRkdnFQQTRUR0FkRG03d3JjSWV5L1RxYkN2?=
 =?utf-8?B?ZU8ybmxaME9QWnRCTTM5MGpjanN4dFpIZG0zU2hCUTJZbjljVXR4dXNPV1dn?=
 =?utf-8?B?V0VpNjVXWFlaZm9KOFpDQ2xPM0phY3V0QU1SY3E4Rk03WEFZY1JQQlpGTWJF?=
 =?utf-8?B?M05PSVNrNE9aZTBWaVN2U0xZUFUyQURsZktXSmwweUFWTXhlYWtmYUlZSWRr?=
 =?utf-8?B?VUdOSWs5VEJycTRKdlBvWW1iSkxsRDIvTktJVDVGcVM2UU1pcTZZYXNBSTZ4?=
 =?utf-8?B?djNEYkJ5aE00Vmk3NTV4c0UvZElmVDJYYVBLcGVldmNPM1V3YlhJMmtkeUw0?=
 =?utf-8?B?TGNSUUd2V1luS1BsSWVERHgzVmlFeEp3WmJBaHZLMzd2SXJTbVA0aEVoczhQ?=
 =?utf-8?B?dE5zYmRYcUxpdXMyQjFIaStGVGFmRlh4NHRDQll5UTFRU2poRTZ4WDdKZnF4?=
 =?utf-8?B?WUdyR2twZDJycXdvZVhJMlpXQWxuTFplcDdXcURBbnVETnRGVmRvQm9RajI2?=
 =?utf-8?B?NDFsNHQzSEM4RTgvOXUyc1RZL09nSEY0U09mWjJDOTFRVDFDQnVuWDEyTlhH?=
 =?utf-8?B?Y3lmK0JPLzlRZlpPeTlzWlh3RkRkOHVqc2UxLzVxNk1FTDB3dEVUd3JROENL?=
 =?utf-8?B?Uk8wK3BvQkw3UGVPWmdVaUhHNW10Wi8vVEVBS3VkaHljeVJwME5RY0RXcXJG?=
 =?utf-8?B?RVRDVWU3M1Q2YUFvWThWRHRPTmdaeHVPenBRc3llSU1iakx0eGtxVk41NWk4?=
 =?utf-8?B?VmNxeUtoQ0cvWFA2TEJkV2NCWmNDaVpCb2lzT1dKYVliTmgrSTNXN3M0dWUr?=
 =?utf-8?B?QUxCT2xiSlA0U1RVdHVPVTBCQVFJVXdTVFgyS0NmZXpBTXRTVUprbnNxOVd3?=
 =?utf-8?B?c0pEUlFpZnI4Z3NVK1UvRzBBZFo0SlRUMzR0ZWdVd0tmNDlqMjZuZHVUL0ZL?=
 =?utf-8?B?V0M4eEpaWW8yT3RkcE9oUTQvM0Y5Tjh5MlNqd3ArMnBSczBCd0RpZXVJYTh1?=
 =?utf-8?B?ZjBWenlOL1VJMjN6cDlWbFgwaXdMZENYUm00eVRXNTF1OHlGT0p2OVhuK1F5?=
 =?utf-8?B?T1ViZUdPeGdrOGo3V3E0Rm9Vc21iVFJnUUxiN2ZWZmRGZXZtN0IxUVF0VXJi?=
 =?utf-8?B?R3pyV3A2eCtaQklnS2l4SzhHTzhTYzhxanpMMVFvUVBudFk0T3BNU3Z4VDBD?=
 =?utf-8?B?T0N1Q1NkYWlmOGZVRGt2cHlUTG5pcDZ4ZFQ4bFNKNDg1eFFUMFcwV1RmVkJ3?=
 =?utf-8?B?SzlHakFURmJQZG5hcXFFbG5NWExnZUduc3RhN05PRFVsancvNE1vdUJTVUJF?=
 =?utf-8?B?eG42cC9ubEtjeXhKUEVoTnN1TlFJYXMyOENPR0hwQU1rbUEvdjlwUHFTaVpG?=
 =?utf-8?B?TThmRldMRi9iOUJMMkszajFMV1I2UDRDNXZvS1c3cFVtNU5RenFrSWRnL1VX?=
 =?utf-8?B?Vkh2NVpBWXBpaldOaUlkNVJEaEtLRmhhaGZnOFp0bkpBR3VPVjNYYW9IZU42?=
 =?utf-8?Q?rMKvi+Ph+BU=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:52:57.5691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be7b914-39b2-4abf-653b-08dcef7c2c33
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8049

From: Shen Jianping <Jianping.Shen@de.bosch.com>

add the iio driver for bosch imu smi240. The smi240 is a combined
three axis angular rate and three axis acceleration sensor module
with a measurement range of +/-300°/s and up to 16g. A synchronous
acc and gyro sampling can be triggered by setting the capture bit
in spi read command.

Implemented features:
* raw data access for each axis through sysfs
* tiggered buffer for continuous sampling
* synchronous acc and gyro data from tiggered buffer

Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/Kconfig  |  14 +
 drivers/iio/imu/Makefile |   2 +
 drivers/iio/imu/smi240.c | 622 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 638 insertions(+)
 create mode 100644 drivers/iio/imu/smi240.c

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 52a155ff325..59d7f3cf8f0 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -96,6 +96,20 @@ config KMX61
 
 source "drivers/iio/imu/inv_icm42600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
+
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
+
 source "drivers/iio/imu/st_lsm6dsx/Kconfig"
 source "drivers/iio/imu/st_lsm9ds0/Kconfig"
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 7e2d7d5c3b7..ca9c4db7725 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -27,5 +27,7 @@ obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
 
+obj-$(CONFIG_SMI240) += smi240.o
+
 obj-y += st_lsm6dsx/
 obj-y += st_lsm9ds0/
diff --git a/drivers/iio/imu/smi240.c b/drivers/iio/imu/smi240.c
new file mode 100644
index 00000000000..eb292ebf189
--- /dev/null
+++ b/drivers/iio/imu/smi240.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include <asm/unaligned.h>
+
+#define SMI240_CHIP_ID 0x0024
+
+#define SMI240_SOFT_CONFIG_EOC_MASK BIT(0)
+#define SMI240_SOFT_CONFIG_GYR_BW_MASK BIT(1)
+#define SMI240_SOFT_CONFIG_ACC_BW_MASK BIT(2)
+#define SMI240_SOFT_CONFIG_BITE_AUTO_MASK BIT(3)
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
+#define SMI240_BUS_ID 0x00
+#define SMI240_CRC_INIT 0x05
+#define SMI240_CRC_POLY 0x0B
+#define SMI240_CRC_MASK GENMASK(2, 0)
+
+#define SMI240_READ_SD_BIT_MASK BIT(31)
+#define SMI240_READ_DATA_MASK GENMASK(19, 4)
+#define SMI240_READ_CS_BIT_MASK BIT(3)
+
+#define SMI240_WRITE_BUS_ID_MASK GENMASK(31, 30)
+#define SMI240_WRITE_ADDR_MASK GENMASK(29, 22)
+#define SMI240_WRITE_BIT_MASK BIT(21)
+#define SMI240_WRITE_CAP_BIT_MASK BIT(20)
+#define SMI240_WRITE_DATA_MASK GENMASK(18, 3)
+
+/* T°C = (temp / 256) + 25 */
+#define SMI240_TEMP_OFFSET 6400   /* 25 * 256 */
+#define SMI240_TEMP_SCALE 3906250 /* (1 / 256) * 1e9 */
+
+#define SMI240_ACCEL_SCALE 500  /* (1 / 2000) * 1e6 */
+#define SMI240_GYRO_SCALE 10000 /* (1 /  100) * 1e6 */
+
+#define SMI240_LOW_BANDWIDTH_HZ 50
+#define SMI240_HIGH_BANDWIDTH_HZ 400
+
+#define SMI240_BUILT_IN_SELF_TEST_COUNT 3
+
+#define SMI240_DATA_CHANNEL(_type, _axis, _index) {			\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = _index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
+#define SMI240_TEMP_CHANNEL(_index) {			\
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
+		.endianness = IIO_CPU,			\
+	},						\
+}
+
+enum capture_mode { SMI240_CAPTURE_OFF = 0, SMI240_CAPTURE_ON = 1 };
+
+struct smi240_data {
+	struct regmap *regmap;
+	u16 accel_filter_freq;
+	u16 anglvel_filter_freq;
+	u8 built_in_self_test_count;
+	enum capture_mode capture;
+	/*
+	 * Ensure natural alignment for timestamp if present.
+	 * Channel size: 2 bytes.
+	 * Max length needed: 2 * 3 channels + temp channel + 2 bytes padding + 8 byte ts.
+	 * If fewer channels are enabled, less space may be needed, as
+	 * long as the timestamp is still aligned to 8 bytes.
+	 */
+	s16 buf[12] __aligned(8);
+
+	__be32 spi_buf __aligned(IIO_DMA_MINALIGN);
+};
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
+		crc &= SMI240_CRC_MASK;
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
+	if (FIELD_GET(SMI240_READ_SD_BIT_MASK, data) &
+	    FIELD_GET(SMI240_READ_CS_BIT_MASK, data))
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
+	u32 request, response;
+	u16 *val = val_buf;
+	struct spi_device *spi = context;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
+	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
+
+	if (reg_size != 1 || val_size != 2)
+		return -EINVAL;
+
+	request = FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
+	request |= FIELD_PREP(SMI240_WRITE_CAP_BIT_MASK, iio_priv_data->capture);
+	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
+	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
+
+	iio_priv_data->spi_buf = cpu_to_be32(request);
+
+	/*
+	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
+	 * SPI protocol, where the slave interface responds to
+	 * the Master request in the next frame.
+	 * CS signal must toggle (> 700 ns) between the frames.
+	 */
+	ret = spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
+	if (ret)
+		return ret;
+
+	ret = spi_read(spi, &iio_priv_data->spi_buf, sizeof(response));
+	if (ret)
+		return ret;
+
+	response = be32_to_cpu(iio_priv_data->spi_buf);
+
+	if (!smi240_sensor_data_is_valid(response))
+		return -EIO;
+
+	*val = FIELD_GET(SMI240_READ_DATA_MASK, response);
+
+	return 0;
+}
+
+static int smi240_regmap_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	u8 reg_addr;
+	u16 reg_data;
+	u32 request;
+	const u8 *data_ptr = data;
+	struct spi_device *spi = context;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
+	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
+
+	if (count < 2)
+		return -EINVAL;
+
+	reg_addr = data_ptr[0];
+	memcpy(&reg_data, &data_ptr[1], sizeof(reg_data));
+
+	request = FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
+	request |= FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
+	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
+	request |= FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
+	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
+
+	iio_priv_data->spi_buf = cpu_to_be32(request);
+
+	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
+}
+
+static const struct regmap_bus smi240_regmap_bus = {
+	.read = smi240_regmap_spi_read,
+	.write = smi240_regmap_spi_write,
+};
+
+static const struct regmap_config smi240_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+};
+
+static int smi240_soft_reset(struct smi240_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, SMI240_CMD_REG, SMI240_SOFT_RESET_CMD);
+	if (ret)
+		return ret;
+	fsleep(SMI240_DIGITAL_STARTUP_DELAY_US);
+
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
+			      data->built_in_self_test_count - 1);
+
+	ret = regmap_write(data->regmap, SMI240_SOFT_CONFIG_REG, request);
+	if (ret)
+		return ret;
+
+	fsleep(SMI240_MECH_STARTUP_DELAY_US +
+	       data->built_in_self_test_count * SMI240_BITE_SEQUENCE_DELAY_US +
+	       SMI240_FILTER_FLUSH_DELAY_US);
+
+	return 0;
+}
+
+static int smi240_get_low_pass_filter_freq(struct smi240_data *data,
+					   int chan_type, int *val)
+{
+	switch (chan_type) {
+	case IIO_ACCEL:
+		*val = data->accel_filter_freq;
+		return 0;
+	case IIO_ANGL_VEL:
+		*val = data->anglvel_filter_freq;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi240_get_data(struct smi240_data *data, int chan_type, int axis,
+			   int *val)
+{
+	u8 reg;
+	int ret, sample;
+
+	switch (chan_type) {
+	case IIO_TEMP:
+		reg = SMI240_TEMP_CUR_REG;
+		break;
+	case IIO_ACCEL:
+		reg = SMI240_ACCEL_X_CUR_REG + (axis - IIO_MOD_X);
+		break;
+	case IIO_ANGL_VEL:
+		reg = SMI240_GYRO_X_CUR_REG + (axis - IIO_MOD_X);
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
+static irqreturn_t smi240_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct smi240_data *data = iio_priv(indio_dev);
+	int base = SMI240_DATA_CAP_FIRST_REG, i = 0;
+	int ret, chan, sample;
+
+	data->capture = SMI240_CAPTURE_ON;
+
+	iio_for_each_active_channel(indio_dev, chan) {
+		ret = regmap_read(data->regmap, base + chan, &sample);
+		data->capture = SMI240_CAPTURE_OFF;
+		if (ret)
+			goto out;
+		data->buf[i++] = sample;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
+
+out:
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
+	int ret;
+	struct smi240_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = smi240_get_data(data, chan->type, chan->channel2, val);
+		iio_device_release_direct_mode(indio_dev);
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
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = SMI240_TEMP_SCALE / GIGA;
+			*val2 = SMI240_TEMP_SCALE % GIGA;
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = SMI240_ACCEL_SCALE;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ANGL_VEL:
+			*val = 0;
+			*val2 = SMI240_GYRO_SCALE;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = SMI240_TEMP_OFFSET;
+			return IIO_VAL_INT;
+		} else {
+			return -EINVAL;
+		}
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
+	/* Write access to soft config is locked until hard/soft reset */
+	ret = smi240_soft_reset(data);
+	if (ret)
+		return ret;
+
+	return smi240_soft_config(data);
+}
+
+static int smi240_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int smi240_init(struct smi240_data *data)
+{
+	int ret;
+
+	data->accel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
+	data->anglvel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
+	data->built_in_self_test_count = SMI240_BUILT_IN_SELF_TEST_COUNT;
+
+	ret = smi240_soft_reset(data);
+	if (ret)
+		return ret;
+
+	return smi240_soft_config(data);
+}
+
+static const struct iio_info smi240_info = {
+	.read_avail = smi240_read_avail,
+	.read_raw = smi240_read_raw,
+	.write_raw = smi240_write_raw,
+	.write_raw_get_fmt = smi240_write_raw_get_fmt,
+};
+
+static int smi240_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct smi240_data *data;
+	int ret, response;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init(dev, &smi240_regmap_bus, dev,
+				  &smi240_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize SPI Regmap\n");
+
+	data = iio_priv(indio_dev);
+	dev_set_drvdata(dev, indio_dev);
+	data->regmap = regmap;
+	data->capture = SMI240_CAPTURE_OFF;
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
+
+static const struct spi_device_id smi240_spi_id[] = {
+	{ "smi240" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, smi240_spi_id);
+
+static const struct of_device_id smi240_of_match[] = {
+	{ .compatible = "bosch,smi240" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, smi240_of_match);
+
+static struct spi_driver smi240_spi_driver = {
+	.probe = smi240_probe,
+	.id_table = smi240_spi_id,
+	.driver = {
+		.of_match_table = smi240_of_match,
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


