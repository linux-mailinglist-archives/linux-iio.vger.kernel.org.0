Return-Path: <linux-iio+bounces-9140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4CE96BFA1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472BE2873C6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F41DA630;
	Wed,  4 Sep 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Ztv1Phjq"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF431D935E;
	Wed,  4 Sep 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458739; cv=fail; b=OOxQzvQg+B6dPXyBZZyDhFRVeNeToYvSL/TwgLvJXC0S27Akq+swkcSOWt9nI24bEvM1HVEgsYfv8k0/QotUsITV7jnN9+qICb3haPKMFMHboYgQBYFg0pJIjCcvqieDX7kn6i4q1K/GhGEWAVhDpNX5CGGdBLWjLVCuN/yWk64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458739; c=relaxed/simple;
	bh=0xR/3nV5n7JxyUrUM8A/fiRXVgYDqsIto5gubZ2u2Ro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNFlhZajJ5bAPcRW494zoUlv67Tzcg2pUGDJca0WHZCYJz0JfDDNwY5/0M7svdC5tFai6xVq1z9IKH0piagy+NTtgh0DqlxWi7LzeUG/vfCqDjj+KbsMgZuvzdZxL8cr3qFOygaE0B+xu+sR2epWTZiFAPi92ox5OrAHWkHeDvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Ztv1Phjq; arc=fail smtp.client-ip=40.107.249.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv/PPyoQs4vcLkP1B1avgrGv7rkkbKCgKSb3S5rXDXnxw6ufXXqklupOIIGb9/njGqnJ7DOBVMF4XsH7g3KyMiUE0RMI0LWtZf7ARlqEg06Ex1PPzkM3Rntk4Ej+fAF5w1x8n5DpU7ji/NdtaqS8vHXi/S/rmvFHVoMsE50/eLqW0luFSrE+h90dIjW1lViubwGgCvJZOXtKxPRKLptr9JkYObkGhxCpObkhIQiWqjkZxlB+HVoq7WQQpJh2dReQbV24I0f16L2Bqo7/QXj3Sp98VpBw1crtmJjyc7nl88fmfKp8GXQMicV2sJdmQ+Y6ou8vbPqYomm1RSjxqV3G2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMwZnzhcxPkuQP29Ohry7FnWM2TewnNuV8BUcJ/aKC0=;
 b=kIzlsJsdLGJAE5GHvC5p1Z0++yvQfcsrzCfEgyAeZmR02VSN3eElQ7tQEAu5TTHBcOImSKcfNHc/BZjX7rAtxKTdxuVZjhxhnxBpmQYH0KrmS3gkPFptOXL+fckcGc8FMOVamD6QZabk4mFJ2qdeus9TWUUqC9J91Dl02uAG++AEF9qyFavlJfBOM7jNZ3MPEvhL/IfweUhRPkIDyFi/5agVJhITupt1LGqh64s0088P0AixztKqFO3wKJ+abD1w4ag+g+Z89C5LLan5fPjA06RjCGuUIeJOJM7y1iQw1X1Fp8huKID0InlOo1CIq4dqM6j23msFmuS19uo5qw32wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMwZnzhcxPkuQP29Ohry7FnWM2TewnNuV8BUcJ/aKC0=;
 b=Ztv1PhjqXSR+g6ViXWIk1ok1YdEyGQBerAL8QnKYXDRvZPyUQrfh2Q+mmoxnjzkYB2SIGHlpma/PECmVUSknDyNmU8mV6uYv3cVjLh2X4mv/N7CmTuWaLd9HNk0cQRDT62yGBdmDPD01zNrfyJeMsWTTcc22ZL5Icars4eNO0pu5aV4qz7s2d/xs9DR2Wxh58QYLLKyIH9Val1CfqTaQN595IK2TcK4sUxrt+e5zZ8H3U+YLIlypDkMv9JjzkL3ez35W5emwsgFEI2EJ1wnGwClkJbSiAySKSD9eU6R5YOSlwDU+R81Wba6GqRcVTW1qXXlSrRVZLSYU2wAGpMXIow==
Received: from AM5PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::29) by AS8PR10MB7897.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:63e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 14:05:30 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:206:16:cafe::7f) by AM5PR0101CA0016.outlook.office365.com
 (2603:10a6:206:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 14:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 14:05:30 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 16:05:20 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 16:05:19 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v5 2/2] iio: imu: smi240: add driver
Date: Wed, 4 Sep 2024 16:05:06 +0200
Message-ID: <20240904140506.4741-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904140506.4741-1-Jianping.Shen@de.bosch.com>
References: <20240904140506.4741-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|AS8PR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 067dddc7-4688-4219-5f6f-08dccceaa2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWNWTFhPRzBxNmdNQzhIMVFRUzd5bFl6U2JFQ3pTdWdNMFhnV0xPWHpjMVha?=
 =?utf-8?B?N29BVGFtNmRmVGtnM3o5b0t5N2pGWU5neWZyemVEaVFJWW9GUmp6TkR0dms0?=
 =?utf-8?B?Z3pOL2lKbWpkb0RGRldNaUZHUEhzcGhSTVd2TWZ0U1pzVUhUMzh3T3oyUmlT?=
 =?utf-8?B?cG5tZ0ZKTTE3eU1PcWs1cXdmWjAzNi9Vdko2RDNRanoyYWVKQ1Q4ME5sck5u?=
 =?utf-8?B?MGxlZnF0UmVESktIbCtvNnFKMDlVR3Y3NFh1bU9MTFFjcFR3YXdwZ1ZVdGlJ?=
 =?utf-8?B?NEVzeTI0RndxNXZ0MWlMRFAyZUNaeThhNU91M2owd1lKZFpGNE9QNDFOSlp6?=
 =?utf-8?B?SndoMUtSYkw5T3JOcHJDQTQrdnFtWXJ1TEo5czNaaU9aT2pPWGhPMkRlYkVp?=
 =?utf-8?B?RmJJNlZzVWJKdUM5Um4yOWJYR0gwQW9xVkRFa3RhZkM4WktrMEhqaTU0eUtC?=
 =?utf-8?B?RE9KOFFZQXZkaUgvUHNTR29JUmMyL1BnTkNPS1RNbGJLNXlqVmtRU3ZGN1lK?=
 =?utf-8?B?SlBJU29UWkFWM01ZbnQveEc1MHI5M2tyMFZmZ0FSUzlyaVpudThmUjB3WFd6?=
 =?utf-8?B?eE1JdVdlZm01RWFyK09PbFoydWNFNWZWUUh5alpaMEJ2NGQ2dlUyMzQ3bGFN?=
 =?utf-8?B?QXB1aHlaNEIxZjQ1VHhNUlVtSmpsUXVFTllIYVZGcThKYzZqbkgvNGNFODVa?=
 =?utf-8?B?VVlFdmxxM053TUFUbEZiZmNGdCswdE1SSWIydUVzT0RMZXM5dDhnVE9wRTFD?=
 =?utf-8?B?UFc3QlNGUGhldnQ3MmVSSHo2K1pTUjMvMFF6NWVMdmFFZHd0U3BicXN3TjRF?=
 =?utf-8?B?dVM5NG1qNUt2QVBBRTNuenBFaG9vZ3MvRjJIdmF0VDUrbCtoeGNmMWpvQUFP?=
 =?utf-8?B?RjB4SDJOZ2drRXFRSVVYTUtSMDBmTEkrVW9WUFRlVFF2WTB4YzNGbEZUN0E1?=
 =?utf-8?B?NnY0ZjVFOGp4VzJoaDU2QTVPb29xWVZwNHFlck1Zd3NlZnY3T3lHcDNweWJq?=
 =?utf-8?B?cDdHU1lFK0RqU2thbUNLbm81WXYrbVBMcEJ2a1F3QW1JdGNYSmo2ZEhIUnJw?=
 =?utf-8?B?Sm9KLzcycUlpQm02bTFpZnlWRVBvWFp4YWlVTU15aEtYWTRqbm9XYlFxT1RN?=
 =?utf-8?B?R3FvbDcxdjJwalhiS2NSTit1a1RkMVBFVlFkMmNPUS9IeFR4bDBoL2RSMFdH?=
 =?utf-8?B?MjM3dGZvQXRUbE91aTVtOWZhUmRDYUhlNFRMZzcwaGh1MU1pUTBsZHVDZzh0?=
 =?utf-8?B?SzMwMjRFNGVRZVNwM1JtN3ZuK0NIYzdZRXFaWDR3cDZpZW9kT1lKdTJoU3B6?=
 =?utf-8?B?Q21zUHhaeGR5YTNFZDBvbktiZnVxSCtMMVl5VktCZHJZMGo1eVRTZFFjMjRV?=
 =?utf-8?B?VU9xamJEdFZXTFppeGZ4ZWQ5akFqRE9LNURaaHFObVBKa2ZqUnk5WWVlTldJ?=
 =?utf-8?B?ek9SdjUzTjJjZy9QV3ZUTG42R1REQXBtQkxaSFo2dXc3aGVKUmc1cDdHaVR3?=
 =?utf-8?B?TGU4dVVhMXNyWnlYMXdsb1Zldkp2OExqVnBHZFNkcEExQS9mMEJ1bmFVNzBk?=
 =?utf-8?B?dm5UN2dhN0p5ZlNGc0hnWDJra2g4d2kxY2dnOFY0MDlTZ0lNU2hraDZYa2I1?=
 =?utf-8?B?dWozRkVFV2ZuTjlXemZjNzh0ckgvWTFBTk9IeEc4R1ZBbnAwMUFzdXRMTUVJ?=
 =?utf-8?B?T3NPUUtjQk1wRnkyWFE2TUJzUkVLMlVYVlJQR3MrUGdhcEFJU1cyQjlEb0pm?=
 =?utf-8?B?eXNZdXVqRUk0OUFjS2wzcTZzSDhaMmNNTzFYemdQbERXUG1PcWtJcUpqcjFv?=
 =?utf-8?B?Ry9NWFRNcnVBUWtKVHZRZ0ZsRDlxcmZLQ2VFNEdqVkhSUTR5UjVSQ1cvNUJM?=
 =?utf-8?B?SHRPSmoxQk0ydFNlaVo0dUl3bnRkMy9CR0x6ZkJtUVVKTWhscEJnN0wyWWNz?=
 =?utf-8?B?Uzc5Y2tiazh4TnM3Mnc5ZkpuZU94bFhIWE9qcTlpRUhHR3EyQWx0djdNSlFu?=
 =?utf-8?B?MmFuT3FGcHZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:05:30.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067dddc7-4688-4219-5f6f-08dccceaa2c9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7897

From: Shen Jianping <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi240. The smi240 is a combined
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
 drivers/iio/imu/smi240.c | 578 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 594 insertions(+)
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
index 00000000000..e69d81545eb
--- /dev/null
+++ b/drivers/iio/imu/smi240.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ */
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
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
+#define SMI240_CRC_INIT 0x05
+#define SMI240_CRC_POLY 0x0B
+#define SMI240_BUS_ID 0x00
+
+#define SMI240_SD_BIT_MASK 0x80000000
+#define SMI240_CS_BIT_MASK 0x00000008
+
+#define SMI240_BUS_ID_MASK GENMASK(31, 30)
+#define SMI240_WRITE_ADDR_MASK GENMASK(29, 22)
+#define SMI240_WRITE_BIT_MASK 0x00200000
+#define SMI240_WRITE_DATA_MASK GENMASK(18, 3)
+#define SMI240_CAP_BIT_MASK 0x00100000
+#define SMI240_READ_DATA_MASK GENMASK(19, 4)
+
+/*
+ * T°C = (temp / 256) + 25
+ * Tm°C = 1000 * ((temp * 100 / 25600) + 25)
+ * scale: 100000 / 25600 = 3.906250
+ * offset: 25000
+ */
+#define SMI240_TEMP_OFFSET 25000
+#define SMI240_TEMP_SCALE 3906250
+
+#define SMI240_LOW_BANDWIDTH_HZ 50
+#define SMI240_HIGH_BANDWIDTH_HZ 400
+
+#define SMI240_ACCEL_SCALE 2000
+#define SMI240_GYRO_SCALE 100
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
+		.endianness = IIO_LE,					\
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
+		.endianness = IIO_LE,			\
+	},						\
+}
+
+enum capture_mode { SMI240_CAPTURE_OFF = 0, SMI240_CAPTURE_ON = 1 };
+
+struct smi240_data {
+	struct regmap *regmap;
+	u16 accel_filter_freq;
+	u16 anglvel_filter_freq;
+	u8 bite_reps;
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
+	u32 request, response;
+	struct spi_device *spi = context;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
+	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
+
+	request = FIELD_PREP(SMI240_BUS_ID_MASK, SMI240_BUS_ID);
+	request |= FIELD_PREP(SMI240_CAP_BIT_MASK, iio_priv_data->capture);
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
+	response = FIELD_GET(SMI240_READ_DATA_MASK, response);
+	memcpy(val_buf, &response, val_size);
+
+	return 0;
+}
+
+static int smi240_regmap_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	u32 request;
+	struct spi_device *spi = context;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
+	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
+	u8 reg_addr = ((u8 *)data)[0];
+	u16 reg_data = get_unaligned_le16(&((u8 *)data)[1]);
+
+	request = FIELD_PREP(SMI240_BUS_ID_MASK, SMI240_BUS_ID);
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
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
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
+			      data->bite_reps - 1);
+
+	ret = regmap_write(data->regmap, SMI240_SOFT_CONFIG_REG, request);
+	if (ret)
+		return ret;
+
+	fsleep(SMI240_MECH_STARTUP_DELAY_US +
+	       data->bite_reps * SMI240_BITE_SEQUENCE_DELAY_US +
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
+	int ret, chan, i = 0;
+
+	data->capture = SMI240_CAPTURE_ON;
+
+	for_each_set_bit(chan, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		ret = regmap_read(data->regmap,
+				  SMI240_DATA_CAP_FIRST_REG + chan,
+				  (int *)&data->buf[i]);
+		data->capture = SMI240_CAPTURE_OFF;
+		if (ret)
+			goto out;
+		i++;
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
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_TEMP) {
+			*val = SMI240_TEMP_SCALE / MEGA;
+			*val2 = SMI240_TEMP_SCALE % MEGA;
+			return IIO_VAL_INT_PLUS_MICRO;
+		} else if (chan->type == IIO_ACCEL) {
+			*val = SMI240_ACCEL_SCALE;
+			return IIO_VAL_INT;
+		} else if (chan->type == IIO_ANGL_VEL) {
+			*val = SMI240_GYRO_SCALE;
+			return IIO_VAL_INT;
+		} else
+			return -EINVAL;
+
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = SMI240_TEMP_OFFSET;
+			return IIO_VAL_INT;
+		} else
+			return -EINVAL;
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
+static int smi240_init(struct smi240_data *data)
+{
+	data->accel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
+	data->anglvel_filter_freq = SMI240_HIGH_BANDWIDTH_HZ;
+	data->bite_reps = 3;
+
+	return smi240_soft_config(data);
+}
+
+static const struct iio_info smi240_info = {
+	.read_avail = smi240_read_avail,
+	.read_raw = smi240_read_raw,
+	.write_raw = smi240_write_raw,
+};
+
+static int smi240_probe(struct spi_device *spi)
+{
+	struct device *dev;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct smi240_data *data;
+	int ret, response;
+
+	dev = &spi->dev;
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
+static const struct spi_device_id smi240_spi_id[] = { { "smi240", 0 }, {} };
+MODULE_DEVICE_TABLE(spi, smi240_spi_id);
+
+static const struct of_device_id smi240_of_match[] = {
+	{ .compatible = "bosch,smi240" },
+	{}
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


