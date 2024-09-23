Return-Path: <linux-iio+bounces-9738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56F97EBA6
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D69A1F21CC2
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC3199952;
	Mon, 23 Sep 2024 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="mHKkYE4G"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E991990C0;
	Mon, 23 Sep 2024 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095259; cv=fail; b=XL/ltSqZO0akhMyfeSGYH6t+lJwFAMMKlhlN4WttIHAVDXEffYlGtByn/X3+/5FTQhDrMPn4BsZL4dHePuEczM/j+ppLvZUSFM5ZYSYuBAgsBhRr6TPpHD6/rdsFic1xbE7HSQPbAbPfg8MxfJTKhF38aP4WrqkXli95Xl+N50Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095259; c=relaxed/simple;
	bh=gkGLVUJpTAsqmv75yCzQT2yIOTep+XNP3FNu7Zd5lmg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZDoBQpmJhZCiwVurGAXm0bi+GbOrf8Ua7vUYqeOQqyXQXOfkm83j8toBXRGLaHIsYS4zUtZmnS4CtvddHU/d2Ja/3hgIr+EoQYfbrVCoMSiXfAqmLC8dEyMEtLMitlvQqkshL4vs0TYQ8lZUx01uEljff/FSlZSTfikU+7el0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=mHKkYE4G; arc=fail smtp.client-ip=40.107.241.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQkccB/+iBg1t/xdMDJSw3mmUKKxa+6y2YAajmqiyOB0DEtlBFws0OWwDB7SLywf3iY84gfMxB5ph/AcoKTepWhEFn7FK+KcKM9gYSf+QmGAl/aclasMwLgltAFQSyFZpaiak2QTJI+1LKJK+UCXKI45YanJEQhSnLODZGDl3uMf0g1o4XIgdj010RCF8CLHfzsChyZ57PapXo2yRb4/fERn2cW4UeKrZNnU38XxiuhSqLy8ZyXZ8D7bIyRdOi69z+PPxStGoc9Pk0+YNtbbBFUrmufisEgGHT0lTDNuwGpjLf6FWqG7FzweqJlG1hAFwcHWK0O1pUbLYULKSwMFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g71bxQFob5baq4w/ugBkBlR8CvE9sCBJAPWBL65zDTE=;
 b=R24/GBJ5YXd1bdTm7z1DUcAMOl6hvCiPqfN8LiF+xW+JbyTqlozZPotXNSufa0SVulsKL+C6EyPQfs0vg+T3UhYy5EpeGbTEYQTa1t5j/5BTnKdsXSWuYRKB4+VrvtQC6ynCYQySRAwORFtpZ/VDoXVuo7uBRBQBmpg1MeBDFkC2Cwwb1aww+Re4xFA2Z2pS2chomlK2bNZvN9kSkbgy0fbQvD4tcwtz6VXNDQZqR4AskcC22E/OAumMbFou7rxlBRsrIVl+xP/qrUOCSLBvzB0S+VpQY664Im/+Z6au4oK0u4aXQ/OJoJelKCB1eHepAXoBKX4p8ptGdpdGvQZV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g71bxQFob5baq4w/ugBkBlR8CvE9sCBJAPWBL65zDTE=;
 b=mHKkYE4Gx0X3NCyDEOkRHwY3Yn2fmkYXXolmXJ/ar6qvGwOXEYojvCZ08+0qNhw8j5Wwj7e6uY4VL2B8O0C7FqqeOHHiKFHYd6hW0qrvAJxo8DHk+6FpmYAolA3e2/S4ge1t32FyJq7OlBNCQ9zroZGn3d3vGuAQrN3U+3CSvMILFLybJ6rFjbodM/LVnWMJtGGX0EiF/ZNMlo8USbPL/pkJFJKeGd7rsViYZDuHKTtVYzSmnGkr3z7rQ45siIcyKSLXlthtAk21PBRJOAiE+YymVvqxapxanIalo/4VbYjPEqAfnVfDH97O9P0J8bIv2hTvjUpini5WBGBxhVNrMA==
Received: from AM6PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:20b:6e::43)
 by PAVPR10MB6837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:321::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:40:46 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:6e:cafe::21) by AM6PR02CA0030.outlook.office365.com
 (2603:10a6:20b:6e::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Mon, 23 Sep 2024 12:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 12:40:45 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 14:40:32 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 14:40:31 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v8 2/2] iio: imu: smi240: add driver
Date: Mon, 23 Sep 2024 14:40:17 +0200
Message-ID: <20240923124017.43867-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C711:EE_|PAVPR10MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 105674ed-a37e-4e45-f521-08dcdbccf1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlV4TEdIMzVPTUx0ZkQ0MklGTjUrckl6ZS81OWdHN3hxYkM2eklndDdQWVhr?=
 =?utf-8?B?a3ZtNVZrYmR1ZE94Z0Q4UWxoaUpYU2dQZHYybFJ3azZCY0FIVjVqTXB1Vzdw?=
 =?utf-8?B?SkhVMjloeW9XZ3U4eFcwelMvVHl5VkNIT3dFT252NEkwVnM3T2VWbkY0QzRM?=
 =?utf-8?B?MnZubnFYVGxzN1RRb0NtVjNFT3RYRSsra283Vi83a0FkakpZMVBKWUZweEQ1?=
 =?utf-8?B?cjZTZDViSjRHU1pBcHF3UHpMMjZ2ZEpxMEV0bStHRVR0VXFGa09Xa0Vvamc2?=
 =?utf-8?B?enFQVTBEUGtzUkdYdk5zZ3NCNThLbHhIM2xlRE8wUExidHF3V0lQMnpEbjNy?=
 =?utf-8?B?Ni9RdlZPak1mU2xqUVZYUFA0Ymp6UEVHTFRnRWgxZ09UTURMNEo5b2NKV29l?=
 =?utf-8?B?VDZ4Z2xNNVhLa3RFS2RXWjBudjNkVTg0SjMwblVTT1NtVCtkWm5RQUNzSXFD?=
 =?utf-8?B?a1NmQ3BKdmppRExTTVg1aXhHb2JRZ2dKM3FSbE9VWG1DL21WMHB5aVFsYWZD?=
 =?utf-8?B?UHlOYUFMT1NNUm5OU2JnWWVwMnhQV01sOWdGeWN4MDR4VjZLaDhySkpwVlFJ?=
 =?utf-8?B?N3EwWTF1cHovMk1uSE1VVXdPaHVNK2VpeXllQXJoa281OFRjeGR1dGZYT1gz?=
 =?utf-8?B?Q2VwVlU3SnlYWHcxUWdibDU1NjdWUGlRYUVnUGtVL3V3dXlTVVczK0FvdXFp?=
 =?utf-8?B?bzdqL204Zjk3SG9CeUdIT2ZDdTZ5K0RrU01xM0x2SFZ5bXBNRXd2WW1jRnJV?=
 =?utf-8?B?MWMwRllVcnBRTnRIVzFqZzhWSVZrVGFmdjIybitvRWNZZjdkYlN5RHAreGlD?=
 =?utf-8?B?ME5aU2RNR0hjVE9yUG5TcXBRODJSMmlCUE5IM0RpdjJhdDBnYWJzSEs0WFBm?=
 =?utf-8?B?MjVWa09jcVp6dVVxdktxdkszSXJkdU92cUQ5ZUVJOUNPZUNXM0k4Q0tGMDhV?=
 =?utf-8?B?RjAyWFZhcStJeERiblY2eUQvYjE2MEhNNG56Z0hJc1FpN1Z3SnVpVmQ2UUJI?=
 =?utf-8?B?YW12U3BpUktMbkNQR21zeC9Udy9SUUFlMDhEWlBNQlRTV1lhNW9FZldCV0tI?=
 =?utf-8?B?b0NaUEVsNUlwV2lUZytzUWZOQjN2WkhQeVF5b3UvVWtrQ3kzMUN2bHBmUjZw?=
 =?utf-8?B?UVFnZjlNSnFWNzJVeUY5a0h1NUJwQ1Mrd3pnamI2bEVVL0w4WmdJUnRmeWw4?=
 =?utf-8?B?MGZZTEsxSGdIYmVicXJJT2VuOWhzam4rZGI3ZGhRZTJvVDlwSjhyTGFIY2po?=
 =?utf-8?B?UmhaTDM0TlZ5UWIwVUxtSFFyVFJ4c21tQnBaT2lSWTlMMWNzVyt2UGFmbnR6?=
 =?utf-8?B?RGh4Ym0zbUJBTDhtS09zWmJLTnl1dEpaRDZxZ2tDRFREODV5RXBmVWJ4TEta?=
 =?utf-8?B?RGVuUVF3SStNMUZQRWhKbzBYbTRBUE8vOEVHSXJiTHRTcDl0K3VoNTdVTlM2?=
 =?utf-8?B?U04zcWgxdng4Y01xTUF3U05MMUhxN0JXNG9XTG4wUmgwV1BFWkpSblJIU1NN?=
 =?utf-8?B?elNaczBKMHhpc3JYQTZ0UXI4eXAxRGE5MjZZalNGZU9uOEd4RGtiT0s1bFMz?=
 =?utf-8?B?NHk5NjFnTnhORSt5b0xQcjhTUTJPMHAzL1FUa1JYT0RCaDg1aW1TWTc5dzRn?=
 =?utf-8?B?U01iUlRtcjBSRm0zdDFIU1hpTWt3Z1RObzg0RFlnakNhYVZGR0ozN3hBcy8y?=
 =?utf-8?B?NjdBS2N4bkdGMnJRT0FwWmZJakdMODZrY0cxdzhETnYwQzlWdXZlUDQ0ckRK?=
 =?utf-8?B?TXI1ZHIzMlNrSUdXUENBckE0dWt5T3VSWXRBRENWdkJSVFdFODIraW01dFlo?=
 =?utf-8?B?WjNKUGFBc3ljK241S3JhYzY0bWt6dEliTHowNzNvZ0I5d3RPVzZObzJJWEFa?=
 =?utf-8?B?NWwvcDNsWUtvdVpQMUVMQ3dWUFlsZEkrWXp0ZGgwTGVpWGdlekRoMDFuVWxn?=
 =?utf-8?B?MUFGbFZsdGlQN2hyUzM5VHpiYUhZUlJlSzV1WVBtcDB0andLZk1CazgvaDBt?=
 =?utf-8?B?endITERIWWZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:40:45.7989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 105674ed-a37e-4e45-f521-08dcdbccf1ef
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6837

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
index 00000000000..5b5b59e2529
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
+	*val = cpu_to_le16(FIELD_GET(SMI240_READ_DATA_MASK, response));
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


