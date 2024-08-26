Return-Path: <linux-iio+bounces-8807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F34195F38D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C8E1C21650
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4C18D656;
	Mon, 26 Aug 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="kZibLIBL"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158918BB92;
	Mon, 26 Aug 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681191; cv=fail; b=Ci8PGiPp7KNCCaBS7qcRKXC7SWSEuO6md2ypcAHnruLwJbDf7JfKkZNGydvKy5JD2N5ETmTmHMQvIy47bge1W0WlUfLnMad5OZNJscp3NMnkKZQopQUtqEdOyiqbYfsivoKV38FHnjBB7COLZmv5F2PbFtL2O08KAMUY2eOH+30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681191; c=relaxed/simple;
	bh=EQUof6WarfMKyP2OF23bNPGSPOI9GsGO0JUtDhXpJIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7/wRotQcIefe1z8APThA5Zduz/Pk/l1KZSMgdfMzfRTfZK9WUDGn4mL5P6v8mrmkWMo8vf+/q64JJSOCY8caRL1gEBnQgEL7U29XYLP3xOuEMS2JLiOpxHoAZYo2Ah6DLJ6STn4GuSDfSeBkbgrhDZmZFb8fr7gx3CzGPdeLjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=kZibLIBL; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeluhqJeAgkiHTmuummq28LZCqanx2FZwR8IWoKdDPxHMoFluDSKD35Yg0Civ3Cu4vJXbJogemyoFsbTSqkdkfInMZ1jwDghHgSBkxSNgt2Ql/ygYYoHgViq5QQhAH2dUC3H2gJ1ChKqGSjcJrRoKmPrpXGMetZDwwWJ3KTmjVmsk5xpACbGwVzneJXuN23TzpKjXphKhB43YFDcggW8wWqUxvXYJQSfZAyuxKTXCgTvQRxbl9AxeuUZ3tf35uMD96AqyP2E6TWLf9mMykWOrR2L+Ne2DlIAxLw5W+3yWH3GhlCCzXOY2FvRR3YroyPxvV28SISBWLej4k2IsadPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf5FFHKwjQvRACNlaKVLOvUo+koKZFuhp7bevS5+oqs=;
 b=MQsy6C7HhUP1gsGEFmhEo/zkLAfYMcI+CRfmNvMguUihxf7IyUM5y7+cKMW8z9nQwgyb/pO7r5YpbzuqlCkP1jKyU7bxbyLJEobWG7/3AcPFZUire5SfNmtWrUo2SkqEHmssi8e/dwMudV1qGnJQxWI6FwGtNMuS74th+XBE1Oku5kwIkeLLRkh2/DlRb4FytRRLf10C7P/lGOEgezXtuxHhTba/ajiNT4hweHjEPeBEUveQwE28E7r6Vy9eiE7eNkI+tMBYWnRiUudDBD/RAZJ+kXavD0C4nmkvMxB9zSa3PLmqgJezbyVW3r3XLBpUgmTe42B1l5g4kgNwdOyi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf5FFHKwjQvRACNlaKVLOvUo+koKZFuhp7bevS5+oqs=;
 b=kZibLIBLS1G4YtHm9wx6Joty5VOooO9f6HlOBZ+sqMwnZ3iiCgtyz6YL9UxTOW3ZMXo9a3o4UnxSj+jtPhqByCRSMj4Pk2itUU8KQuq/6z0baNbt9hcQ8QgV6zp4SizVHMrW8KP+EPvtHUg/2gD8pHthkPkYscYzZGNx55UPAhT+HgCqXKel+IV4/xXnHCAxD4LknOKj22+eP7Az6vPHRKyGrvLBYvA44dhqxp8PAQ5l1v9vycM7nANv1xyKIO5Vk//EWF6MaBP3E8Fr+3vR+LMFiQMQ9E2kHbpmPFdkm6yXDhNlnkXmenEl5U2e3PIM2d7I2M30M9I6s8beJtVfMQ==
Received: from AM6PR0502CA0038.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::15) by PAVPR10MB7140.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:312::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 14:06:22 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:56:cafe::9e) by AM6PR0502CA0038.outlook.office365.com
 (2603:10a6:20b:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 14:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 14:06:22 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:06:07 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 16:06:06 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v4 2/2] iio: imu: smi240: imu driver
Date: Mon, 26 Aug 2024 16:05:45 +0200
Message-ID: <20240826140545.4085-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826140545.4085-1-Jianping.Shen@de.bosch.com>
References: <20240826140545.4085-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|PAVPR10MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f120a29-4499-4ea5-264b-08dcc5d8442d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGhhbTIvcmFTbXBvWW1hUlNvSjEvT0tiRXRLalIvUUZGb0d5SERoQndlOWsy?=
 =?utf-8?B?di9TcDlEUFhCd0JGWWRPMU9lb29KSk1FY0Y3Q1czaFd3czZqRDRHSXJNU1pu?=
 =?utf-8?B?OHJpTmF3KzFrbUFtOVVKa1YxblArVTZScEp1SzhnNkJlN3VFcUp1ZVpaOUFo?=
 =?utf-8?B?MGcvQ2UyNGJudS9kZFZjZCs4S2RjTGdDaGw0QUE4TUVsZFVMdnYvb1p3OXh0?=
 =?utf-8?B?THY5UFRZYTJEc21PNkpWRGVUQXR2UHE0NTZOY0hLVUhtaEowK3BKVkluMGd0?=
 =?utf-8?B?K1hHanQyK1hFa0FpK2RuUjhoSS9vajg0NStKNDEzQkczcnhWbHVsSjMxZGsz?=
 =?utf-8?B?T1E2QllDMm9DaHlpS2p0KyszZ3JrSkRHUU5URHUwY2J4QjVoMjZnQ3dKQmlZ?=
 =?utf-8?B?OWxCZ25aYld5Q29NdUNQTURCSTJrWlQ0aENqcUdXdTJyVXpyT0E2QWJhK25o?=
 =?utf-8?B?WitlOGVRR0wwL28yNVVnb2ZZZU5UZ2pCcmhaL28xMzNhalZaN1cxbzU4Qjg4?=
 =?utf-8?B?ZTBBTEtyOUlZaEtuYzdlNVRuR0ZqN2lFMUp0c0tXMnp4VG5mVEFObWlDTzhR?=
 =?utf-8?B?aFY5NWsycENMUVRnNm9mNHNxY0VIellzUHZjV3lXYnU4dUU5S1FkUWQ0TVFx?=
 =?utf-8?B?RkV3WGxkUVZoakZVL2Z0Q2gwOU0zemhPYXpDWkRDVHRjLzdmaW1wY044NHND?=
 =?utf-8?B?RGNUT3RPbWU3TkRoVUx6anYxdmRGRkswTFRCVHF4OGFtbmhKYXhnb0dPejI2?=
 =?utf-8?B?VFpZZkRRcVBSWlpuRUxHZUpObElieWUwK3lkcS9zQzU5Y3NoV2FwdGc3dE5C?=
 =?utf-8?B?UWJEWStMRkFUOHkxWDR6SWNIWDliRkQ1R08zL3J5ajRoeitWdmZkTnVPR0Z2?=
 =?utf-8?B?eUh5dWU3eWIrNjRYd05BVFhqN1FNL3B2TkN0QmloTit1WWJvU1p1MlFxZ25G?=
 =?utf-8?B?YVVlcXVUYU5NTk5SVDZTTmxWSjhIdyt0Vy9Lb0R5U3Nyb0h6WTF2SExSeFFM?=
 =?utf-8?B?Z3NJLzErM0VxSlRCc0ZMNkM2TDVDNzRLcitJdU91T3o0Z0J2NkJubE9uRXd4?=
 =?utf-8?B?RDVXQkRPNDJBWncyU0ZyS3dpMHNEeUdrZEo5dGxnbGFySmJKT3FmOVp1M1lG?=
 =?utf-8?B?allySlpBREp3c2NMaGh6eSs2dUtaTEswTjJ0RXNMcC9OMFNQSUxTRHVPYkho?=
 =?utf-8?B?ZDRCYXdmbFF6SW16SXpQaVFrdnIwSUtoWUd0VTFKUjk1cUljdDB1dzVwMnJh?=
 =?utf-8?B?NDVHUThaRFhBRWpKcDBOWU9sMG9XUEp1WnhnWlJ4cEJYSm5IYVBjM2pwSkVa?=
 =?utf-8?B?NmxjeThIeTVWL1Ewd3FwSHcrVHlnSHNCMk5GTTJrVEU2UFhDdTdxdkFhNWQy?=
 =?utf-8?B?aFhGbEVEdnZDcy9IY2t3cFNDenNYbmt4Q240UlpocHZscXB1bExQWDBjc2gz?=
 =?utf-8?B?YW9VUUo5SUdXKzFJdDRKbWpCVW1VdjlobGRQZ0xtT1ZpVGs3c2w5YUxDSVVQ?=
 =?utf-8?B?OUFSMmMyQXN4dVZxQlZxRkZrQ2lqdkdjVHQ5bldROWZBVjl3bVB5cjlpOE5s?=
 =?utf-8?B?K0ptcU5PTUJOdW1PeXdrZkVBM3J5a1RNMUZyZUUzdDFUWERCTERoSDExYUZo?=
 =?utf-8?B?NDVsTS9YTVE1REFaRXNOSW04RTNxeDBLbTVGV3ZDdCtEbXpEeE91Z0hZenFi?=
 =?utf-8?B?dDVtQmNyOW05NS9uNVQ3TU1JVk0zZmdkZjNocXBBTmRuUVBLdVdTbzZwbStq?=
 =?utf-8?B?VDI3Y2xYQVpORGV3WW05VnhnVS9pSDNDaDRlc1l2dVRWOFRLWENUajhZL1dK?=
 =?utf-8?B?T2xHOG1na1B3aGxHWXFNTWQ3ekpOemJ2OVpld25ocFc5enR2REtPenEwN0Nx?=
 =?utf-8?B?TTlmNlg4ME94OG1PWnZQY1RrT01YU3VzUXV4YnRqaXhVQTA4clZCYUpFelVr?=
 =?utf-8?B?cG1vZ2taUXF4RVVnSlFyREd6SmFVOU9Vd2hubjZRa1RmaktzMzYyYzY4cUY5?=
 =?utf-8?B?VWxnbndweHNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:06:22.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f120a29-4499-4ea5-264b-08dcc5d8442d
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7140

From: Shen Jianping <Jianping.Shen@de.bosch.com>

This patch adds the iio driver for bosch imu smi240. The smi240
is a combined three axis angular rate and three axis acceleration
sensor module with a measurement range of +/-300°/s and up to 16g.
Smi240 does not support interrupt. A synchronous acc and gyro
sampling can be triggered by setting the capture bit in spi read
command.

Implemented features:
* raw data access for each axis through sysfs
* tiggered buffer for continuous sampling
* synchronous acc and gyro data from tiggered buffer

Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/Kconfig              |   1 +
 drivers/iio/imu/Makefile             |   1 +
 drivers/iio/imu/smi240/Kconfig       |  12 +
 drivers/iio/imu/smi240/Makefile      |   7 +
 drivers/iio/imu/smi240/smi240.h      |  35 +++
 drivers/iio/imu/smi240/smi240_core.c | 385 +++++++++++++++++++++++++++
 drivers/iio/imu/smi240/smi240_spi.c  | 172 ++++++++++++
 7 files changed, 613 insertions(+)
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
index 00000000000..b1690793f9b
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ */
+#ifndef _SMI240_H
+#define _SMI240_H
+
+#include <linux/iio/iio.h>
+
+struct regmap;
+struct device;
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
+int smi240_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _SMI240_H */
diff --git a/drivers/iio/imu/smi240/smi240_core.c b/drivers/iio/imu/smi240/smi240_core.c
new file mode 100644
index 00000000000..fc0226af843
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240_core.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ */
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
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
+#define SMI240_DATA_CHANNEL(_type, _axis, _index)              \
+	{                                                          \
+		.type = _type,                                         \
+		.modified = 1,                                         \
+		.channel2 = IIO_MOD_##_axis,                           \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),          \
+		.info_mask_shared_by_type =                            \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \
+		.info_mask_shared_by_type_available =                  \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),  \
+		.scan_index = _index,                                  \
+		.scan_type = {                                         \
+			.sign = 's',                                       \
+			.realbits = 16,                                    \
+			.storagebits = 16,                                 \
+			.endianness = IIO_LE,                              \
+		},                                                     \
+	}
+
+#define SMI240_TEMP_CHANNEL(_index)                            \
+	{                                                          \
+		.type = IIO_TEMP,                                      \
+		.modified = 1,                                         \
+		.channel2 = IIO_MOD_TEMP_OBJECT,                       \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |         \
+				      BIT(IIO_CHAN_INFO_OFFSET) |              \
+				      BIT(IIO_CHAN_INFO_SCALE),                \
+		.scan_index = _index,                                  \
+		.scan_type = {                                         \
+			.sign = 's',                                       \
+			.realbits = 16,                                    \
+			.storagebits = 16,                                 \
+			.endianness = IIO_LE,                              \
+		},                                                     \
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
+	/*
+	 * T°C = (temp / 256) + 25
+	 * Tm°C = 1000 * ((temp * 100 / 25600) + 25)
+	 * scale: 100000 / 25600 = 3.906250
+	 * offset: 25000
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 3;
+		*val2 = 906250;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 25000;
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
+int smi240_core_probe(struct device *dev, struct regmap *regmap)
+{
+	struct iio_dev *indio_dev;
+	struct smi240_data *data;
+	int ret, response;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
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
diff --git a/drivers/iio/imu/smi240/smi240_spi.c b/drivers/iio/imu/smi240/smi240_spi.c
new file mode 100644
index 00000000000..d308f6407da
--- /dev/null
+++ b/drivers/iio/imu/smi240/smi240_spi.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024 Robert Bosch GmbH.
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <asm/unaligned.h>
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
+	u32 request, response;
+	struct spi_device *spi = context;
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
+	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
+
+	request = SMI240_BUS_ID << 30;
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
+	request = SMI240_BUS_ID << 30;
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
+static int smi240_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
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
+static const struct spi_device_id smi240_spi_id[] = {
+	{ "smi240", 0 },
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
+	.probe = smi240_spi_probe,
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


