Return-Path: <linux-iio+bounces-24117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34AB581C1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BD93BC60A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B326B77D;
	Mon, 15 Sep 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="XQQcdzAv"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EE25DAEA;
	Mon, 15 Sep 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952741; cv=fail; b=ZnLP1eMC+auLN3BytAeYgn1U8ANsXkOaOJkbDbJV7j/U6ayJ8SQU4zvT/RGzQnzm6dpHSwMSbD2Pbq0Jpl8apxF79fWc5UFxXh50FIwkC4mz1+cwBbLoOOhwy+iuXw5ZqAs4jxkuFsPy2dW30bZ1KtrLIlcNxhbDrGiokns90rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952741; c=relaxed/simple;
	bh=2JZmKzJ+2vhoIiiXRyYN0McS50XpgLlCcPUpqxq0v1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XztTzvB/5FGSJP45qNzB9rLerzX3UDsWo2qHQoxtMEy0eXuYK4TYNuHWGOn3OPGXT7fsRQS14EzwJKX827fMJY0NigMX8ZmYzSqiBxFztC3hwIDLoJLzjJLNtdYp2jHl0sSiULX8Cg1NPwSqi3bXdnan8JnLtwnvj2/nfk3nT74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=XQQcdzAv; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Srt80wh/FJgK+pFfcEBPswXFFeoS8O2xbMbnxjzKhvbSpBOQeGtUl8zyWA10u9eBVzuE/lQHaqonmC/iwR++TAgAPmvXHh4TZ2etF9oBWnBWZRIW3iOu3oeLsWuS35AKUwVpmYZrEWM00M0Em2vXQ2c1zyvCGgMDeHwE6FkiBbeWF8duuYXmD6iD7vrh4KGZTMKmLKt4qRGxqf+Xzofi8CsVA5wDEv0sCLK6Nzqm/ft5hsU19DI/k1U9YOYUrEBwc5swWfxVOXr0P1KTKFEcZ0RSIT5NkX8bSG4lGHpley3XT7dS+uU4WpMMTe8sIlmktiZO4x3Fx3ttrS3eGtfhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHN4SpUOB9gPNO5AZ3tc0lhgQxx2o1FzAIserCaOu1k=;
 b=yfZjg1pGbLrW7IQhZOYZexXr48hIO5EDOspITRV1bmKKjf+QYUtNYeK1GlJMhk/lcHvFFvoVA3XlJ3wyNrGYUQpXVtf61NyDtsNNZhNvP2Oflliu8idcSODdt68Sk94kVQM2OoP6KzCvIeTymRw+NGmF1lhPZxEwMU1eDBhhUmkQIjzqomt1Sp0457gn1CRQVGZlxvHu3fyieRmX+fE/nK/tAFluBVR1GtMpYJmG3TOJPf3g2kI5+T+dxeMb91JmklopLlksdthQYT5JvdlXL2UpACjrWKuaUgEKHy3X44wMZ9sG47pH9AxuEwth4GbisB87CFmjuW0MizVNSRF9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHN4SpUOB9gPNO5AZ3tc0lhgQxx2o1FzAIserCaOu1k=;
 b=XQQcdzAv6wjDwW6E0vtNEasRf8KH6EradJLn4USSUFmgeLa7/21FSeQcdOrYs9YdASNlGEZ370MQzTZf+XDOcDxhuAZKfmY1/JK3Hr2kgYDzzAqLSXImk+sFpmMDTfauQ/5EWaQY1TMpvXy0Q0SGy/NSS8KpjULDlosqfumatDmHjRdlDpz4v5dmh/gdRjkSIi+tsyD85YZQwRp4vky0b7G5UbohUC7hTcNpD/CbEtRNzFArgmJ5B2Ujt4IjuV9gTVTQ0wPRCV7U4iCQ2wS26fJMd/JRfliLvw3ROAhIlpbJPgIR8wqIlzMmok6ZGYhz83T5xymxNgLw59axP//cQA==
Received: from AM8P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::27)
 by AS4PR10MB5622.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 16:12:09 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::b1) by AM8P190CA0022.outlook.office365.com
 (2603:10a6:20b:219::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 16:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 16:12:09 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Mon, 15 Sep
 2025 18:12:02 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.179.220) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 15 Sep 2025 18:12:00 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v4 2/2] iio: imu: smi330: Add driver
Date: Mon, 15 Sep 2025 18:09:34 +0200
Message-ID: <20250915160934.89208-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915160934.89208-1-Jianping.Shen@de.bosch.com>
References: <20250915160934.89208-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|AS4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 780b44b9-72b9-4f3a-0dda-08ddf4729f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFU3bFJ4ZmN5UnJnb21teVdJNkFhTW50NXJxdTRNVWdxSXIrbHdmN3VRMHo2?=
 =?utf-8?B?NEJPemViY3BhSE9KVlFFa09LZ1Z3cTJpeGhwalp0ZkVUWXlweGFFODY3eEtO?=
 =?utf-8?B?SHVBRHdKM0Y4eThtOG5oaUhuT0V0L2tBT3FBejhlYU5qUzFVTDVTOVIyTjFY?=
 =?utf-8?B?eFYrUm1hR01ZS1o1dXRjWms3ak5sUE51QVFjcVVNUmlMYUh2NkVvR2xXNlFV?=
 =?utf-8?B?VUNIbWZOUU41MXN0VnRwREhZb3I2U2pQcEdPbDlrUU5udDFYanRNNE93WmFH?=
 =?utf-8?B?WTMxWFpHekJyOVBibkFldnczYXRwa2xLNlA5K0l3bHRaVWRENThyZXJ3amcy?=
 =?utf-8?B?dlIxcThET0RudUZqUWdlc3NQWDEzS1h4U1dCYUZRVlczd1dVNkF6YzFIYjB2?=
 =?utf-8?B?UlJxeFZWNGk1ZjZlWEdJZjBpK0Y3dlIyRTl6blZnMjVhZDgvT1NSRy9UQXZD?=
 =?utf-8?B?V2taekJleFUxNklaVXErV0hmMGJETTd2VXluMGc5RFU0MDNBZHlUT0VSS3VQ?=
 =?utf-8?B?MXpLa0V4TktIMUNBM3R2Vm5QOFJGaVYxNktEaTFuNmNpM0w2N25MZHBEN3BZ?=
 =?utf-8?B?QzI1YVV3MXdaU3Jia1daS2c2SHh0YWszU2EzS2taMGtGWGR1YW9DMTFTQUl6?=
 =?utf-8?B?Y0FKZTJRMDVEZTIvdUxXRWtGLzRqeGxnNlZKVDNPREpLbGpiaDJOUFBjQjdE?=
 =?utf-8?B?OXFPbTkrSjNUeWV5Sk9IVW9ZRjg2blNLYngrM2hkS2J6ZVd4M3NBcDNpOTZ0?=
 =?utf-8?B?ZDJZZERLOC8zcVlBcnZ2a1JncUdhU3kvaCtjakgxUmVyOCszTXlIRm1KQWlV?=
 =?utf-8?B?cmw1eVNocnB0NGorajBRRi9vY3hxUktkRnZwSVo3ZDc4OXdseS9LTE5PeXpa?=
 =?utf-8?B?UzlrUnljSzlOY3R3T3pyNUlVdmFUTWdJKzV5bjVMQ3BrSGV4Z3l0NVFoQ0pp?=
 =?utf-8?B?RXVpemxQWHY0cnJzVitvdEEwOXcvWVY5MGN6QjlSR1RRNWhJQkpnWENZL09v?=
 =?utf-8?B?U1Fnc2h4NlFPcEJTWUw5MHFLZmRsdDFTMWxxNUhrQ2RKMXBrQVY3U2Y2WjJQ?=
 =?utf-8?B?YnhsTFZnNmZGamhSa0w1RjhIcVRpMlI3Um1lYnh3YW9JT2YydU5JS1JUZXZt?=
 =?utf-8?B?VSszYzIrTkZ2bllXYVY1TUhUQ0F6aW5PdW5HempTa2lKUk50blN4Qm9LaEIz?=
 =?utf-8?B?anlCeXdhLzNxV0laK0RjdDhoaWN5SXBjZVFNRkF0b24wdVcwajhIRGxDczV2?=
 =?utf-8?B?eXVoRFhKVjg4YkVwaWl0aHdvVmdIdUhXUGhmWDNmbGtxQTVLbjBQRTNGcWw0?=
 =?utf-8?B?bnFXakxTZFlEWmJWbUlaV09aMzU3VmdCVEtBSnBqNHlHcE1VcnBzOG9Tc3Rq?=
 =?utf-8?B?dlNFNlBDclBJSEdqYVZDQ0Z4RWErOWFneG1YT2JrL011VnQzeitaU0hBQ21x?=
 =?utf-8?B?SnNmYjA1SEh2ZGhCbkFwRWZocVgyNnpBaVc3WWx6TTlDQ1QzOUFJOTZWWi9n?=
 =?utf-8?B?QU9KM3JUS2xvNFdhM0tHZVhUVTgxajJacjliWFlrZ0NPMlZqN0FzcVA3R25p?=
 =?utf-8?B?YWlIc2sxWnRXT1kxMEtOVE1HcmNiZzNMcUIvbEU5T3U4TVNNOTVzaUNZUUo1?=
 =?utf-8?B?S2dHSTF6ZjRjUzloZ0xVTGkvYWpwY3dwY1VLTzVtTTh5Yi8veDZ4SjJMVUZn?=
 =?utf-8?B?bDE5aDZxaVZaTFRtYTU0Y3BIalJNU0tlMWR1TDMrVTZ3WWJicmJWeUpMV2dL?=
 =?utf-8?B?cjFNSkwxZldVT3p6NTZXN0ZSR2V4L0ZPYTlRa2JqMVRldVU1dEFPUEN6MTNs?=
 =?utf-8?B?ZlhqT3RsRE1PNEdkeHA2cmdyaG9xNFExNGxzbmNBQml2OFNGMEQ2RTZSR3Rw?=
 =?utf-8?B?bUxuaEpyUUhEWStIVTBsY1NKYW91N091bmx1VFNGNjRIZVA4bkpkZ1l6VXYr?=
 =?utf-8?B?cmZURlZjZFBDazNtL25oWkl2cnZHMjVkYm9qTHFHaC80SXI5bFRvZVhsdVNZ?=
 =?utf-8?B?c1U0bU0zRko0V0dWemY4NStieDFIRmFNM05xWTg4SEVSK2JhQWpyOXhwRzJP?=
 =?utf-8?B?TjIzL0pyYllLTjBYZytRVDdZdVo1WHpsSDhYQT09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 16:12:09.5783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 780b44b9-72b9-4f3a-0dda-08ddf4729f89
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5622

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi330. The smi330 is a combined
three axis angular rate and three axis acceleration sensor.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/Kconfig              |   1 +
 drivers/iio/imu/Makefile             |   1 +
 drivers/iio/imu/smi330/Kconfig       |  39 ++
 drivers/iio/imu/smi330/Makefile      |   7 +
 drivers/iio/imu/smi330/smi330.h      |  25 +
 drivers/iio/imu/smi330/smi330_core.c | 919 +++++++++++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c  | 133 ++++
 drivers/iio/imu/smi330/smi330_spi.c  |  85 +++
 8 files changed, 1210 insertions(+)
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
index 00000000000..95b06f2317e
--- /dev/null
+++ b/drivers/iio/imu/smi330/Kconfig
@@ -0,0 +1,39 @@
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
+config SMI330_I2C
+	tristate "Bosch SMI330 I2C driver"
+	depends on I2C
+	select SMI330
+	select REGMAP_I2C
+	help
+	  Enable support for the Bosch SMI330 6-Axis IMU connected to I2C
+	  interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called smi330_i2c.
+
+config SMI330_SPI
+	tristate "Bosch SMI330 SPI driver"
+	depends on SPI
+	select SMI330
+	select REGMAP_SPI
+	help
+	  Enable support for the Bosch SMI330 6-Axis IMU connected to SPI
+	  interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called smi330_spi.
diff --git a/drivers/iio/imu/smi330/Makefile b/drivers/iio/imu/smi330/Makefile
new file mode 100644
index 00000000000..c663dcb5a9f
--- /dev/null
+++ b/drivers/iio/imu/smi330/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Bosch SMI330 IMU
+#
+obj-$(CONFIG_SMI330) += smi330_core.o
+obj-$(CONFIG_SMI330_I2C) += smi330_i2c.o
+obj-$(CONFIG_SMI330_SPI) += smi330_spi.o
diff --git a/drivers/iio/imu/smi330/smi330.h b/drivers/iio/imu/smi330/smi330.h
new file mode 100644
index 00000000000..a5c765645aa
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#ifndef _SMI330_H
+#define _SMI330_H
+
+#include <linux/iio/iio.h>
+
+enum {
+	SMI330_SCAN_ACCEL_X,
+	SMI330_SCAN_ACCEL_Y,
+	SMI330_SCAN_ACCEL_Z,
+	SMI330_SCAN_GYRO_X,
+	SMI330_SCAN_GYRO_Y,
+	SMI330_SCAN_GYRO_Z,
+	SMI330_SCAN_TIMESTAMP,
+	SMI330_SCAN_LEN = SMI330_SCAN_TIMESTAMP,
+};
+
+extern const struct regmap_config smi330_regmap_config;
+
+int smi330_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _SMI330_H */
diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
new file mode 100644
index 00000000000..fdbc251d1f6
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -0,0 +1,919 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/property.h>
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
+/* Register map */
+#define SMI330_CHIP_ID_REG 0x00
+#define SMI330_ERR_REG 0x01
+#define SMI330_STATUS_REG 0x02
+#define SMI330_ACCEL_X_REG 0x03
+#define SMI330_GYRO_X_REG 0x06
+#define SMI330_TEMP_REG 0x09
+#define SMI330_INT1_STATUS_REG 0x0D
+#define SMI330_ACCEL_CFG_REG 0x20
+#define SMI330_GYRO_CFG_REG 0x21
+#define SMI330_IO_INT_CTRL_REG 0x38
+#define SMI330_INT_CONF_REG 0x39
+#define SMI330_INT_MAP1_REG 0x3A
+#define SMI330_INT_MAP2_REG 0x3B
+#define SMI330_CMD_REG 0x7E
+
+/* Register mask */
+#define SMI330_CHIP_ID_MASK GENMASK(7, 0)
+#define SMI330_ERR_FATAL_MASK BIT(0)
+#define SMI330_ERR_ACC_CONF_MASK BIT(5)
+#define SMI330_ERR_GYR_CONF_MASK BIT(6)
+#define SMI330_STATUS_POR_MASK BIT(0)
+#define SMI330_INT_STATUS_ACC_GYR_DRDY_MASK GENMASK(13, 12)
+#define SMI330_CFG_ODR_MASK GENMASK(3, 0)
+#define SMI330_CFG_RANGE_MASK GENMASK(6, 4)
+#define SMI330_CFG_BW_MASK BIT(7)
+#define SMI330_CFG_AVG_NUM_MASK GENMASK(10, 8)
+#define SMI330_CFG_MODE_MASK GENMASK(14, 12)
+#define SMI330_IO_INT_CTRL_INT1_MASK GENMASK(2, 0)
+#define SMI330_IO_INT_CTRL_INT2_MASK GENMASK(10, 8)
+#define SMI330_INT_CONF_LATCH_MASK BIT(0)
+#define SMI330_INT_MAP2_ACC_DRDY_MASK GENMASK(11, 10)
+#define SMI330_INT_MAP2_GYR_DRDY_MASK GENMASK(9, 8)
+#define SMI330_INT_MAP2_DRDY_MASK \
+	(SMI330_INT_MAP2_ACC_DRDY_MASK | SMI330_INT_MAP2_GYR_DRDY_MASK)
+
+/* Register values */
+#define SMI330_IO_INT_CTRL_LVL BIT(0)
+#define SMI330_IO_INT_CTRL_OD BIT(1)
+#define SMI330_IO_INT_CTRL_EN BIT(2)
+#define SMI330_CMD_SOFT_RESET 0xDEAF
+
+/* T°C = (temp / 512) + 23 */
+#define SMI330_TEMP_OFFSET 11776 /* 23 * 512 */
+#define SMI330_TEMP_SCALE 1953125 /* (1 / 512) * 1e9 */
+
+#define SMI330_CHIP_ID 0x42
+#define SMI330_SOFT_RESET_DELAY 2000
+
+#define SMI330_ACCEL_CHANNEL(_axis) {					\
+	.type = IIO_ACCEL,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_dir_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = SMI330_SCAN_ACCEL_##_axis,			\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+#define SMI330_GYRO_CHANNEL(_axis) {					\
+	.type = IIO_ANGL_VEL,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_dir_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = SMI330_SCAN_GYRO_##_axis,				\
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
+enum smi330_accel_range {
+	SMI330_ACCEL_RANGE_2G = 0x00,
+	SMI330_ACCEL_RANGE_4G = 0x01,
+	SMI330_ACCEL_RANGE_8G = 0x02,
+	SMI330_ACCEL_RANGE_16G = 0x03
+};
+
+enum smi330_gyro_range {
+	SMI330_GYRO_RANGE_125 = 0x0,
+	SMI330_GYRO_RANGE_250 = 0x01,
+	SMI330_GYRO_RANGE_500 = 0x02
+};
+
+enum smi330_odr {
+	SMI330_ODR_12_5_HZ = 0x05,
+	SMI330_ODR_25_HZ = 0x06,
+	SMI330_ODR_50_HZ = 0x07,
+	SMI330_ODR_100_HZ = 0x08,
+	SMI330_ODR_200_HZ = 0x09,
+	SMI330_ODR_400_HZ = 0x0A,
+	SMI330_ODR_800_HZ = 0x0B,
+	SMI330_ODR_1600_HZ = 0x0C,
+	SMI330_ODR_3200_HZ = 0x0D,
+	SMI330_ODR_6400_HZ = 0x0E
+};
+
+enum smi330_avg_num {
+	SMI330_AVG_NUM_1 = 0x00,
+	SMI330_AVG_NUM_2 = 0x01,
+	SMI330_AVG_NUM_4 = 0x02,
+	SMI330_AVG_NUM_8 = 0x03,
+	SMI330_AVG_NUM_16 = 0x04,
+	SMI330_AVG_NUM_32 = 0x05,
+	SMI330_AVG_NUM_64 = 0x06
+};
+
+enum smi330_mode {
+	SMI330_MODE_SUSPEND = 0x00,
+	SMI330_MODE_GYRO_DRIVE = 0x01,
+	SMI330_MODE_LOW_POWER = 0x03,
+	SMI330_MODE_NORMAL = 0x04,
+	SMI330_MODE_HIGH_PERF = 0x07
+};
+
+enum smi330_bw {
+	SMI330_BW_2 = 0x00, /* ODR/2 */
+	SMI330_BW_4 = 0x01 /* ODR/4 */
+};
+
+enum smi330_operation_mode {
+	SMI330_POLLING,
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
+struct smi330_attributes {
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
+	struct iio_trigger *trig;
+	IIO_DECLARE_BUFFER_WITH_TS(__le16, buf, SMI330_SCAN_LEN);
+};
+
+const struct regmap_config smi330_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+EXPORT_SYMBOL_NS_GPL(smi330_regmap_config, "IIO_SMI330");
+
+static const struct iio_chan_spec smi330_channels[] = {
+	SMI330_ACCEL_CHANNEL(X),
+	SMI330_ACCEL_CHANNEL(Y),
+	SMI330_ACCEL_CHANNEL(Z),
+	SMI330_GYRO_CHANNEL(X),
+	SMI330_GYRO_CHANNEL(Y),
+	SMI330_GYRO_CHANNEL(Z),
+	SMI330_TEMP_CHANNEL(-1), /* No buffer support */
+	IIO_CHAN_SOFT_TIMESTAMP(SMI330_SCAN_TIMESTAMP),
+};
+
+static const unsigned long smi330_avail_scan_masks[] = {
+	(BIT(SMI330_SCAN_ACCEL_X) | BIT(SMI330_SCAN_ACCEL_Y) |
+	 BIT(SMI330_SCAN_ACCEL_Z) | BIT(SMI330_SCAN_GYRO_X) |
+	 BIT(SMI330_SCAN_GYRO_Y) | BIT(SMI330_SCAN_GYRO_Z)),
+	0
+};
+
+static const struct smi330_attributes smi330_accel_scale_attr = {
+	.reg_vals = (int[]){ SMI330_ACCEL_RANGE_2G, SMI330_ACCEL_RANGE_4G,
+			     SMI330_ACCEL_RANGE_8G, SMI330_ACCEL_RANGE_16G },
+	.vals = (int[]){ 0, 61035, 0, 122070, 0, 244140, 0, 488281 },
+	.len = 8,
+	.type = IIO_VAL_INT_PLUS_NANO,
+	.mask = SMI330_CFG_RANGE_MASK
+};
+
+static const struct smi330_attributes smi330_gyro_scale_attr = {
+	.reg_vals = (int[]){ SMI330_GYRO_RANGE_125, SMI330_GYRO_RANGE_250,
+			     SMI330_GYRO_RANGE_500 },
+	.vals = (int[]){ 0, 3814697, 0, 7629395, 0, 15258789 },
+	.len = 6,
+	.type = IIO_VAL_INT_PLUS_NANO,
+	.mask = SMI330_CFG_RANGE_MASK
+};
+
+static const struct smi330_attributes smi330_average_attr = {
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
+static const struct smi330_attributes smi330_bandwidth_attr = {
+	.reg_vals = (int[]){ SMI330_BW_2, SMI330_BW_4 },
+	.vals = (int[]){ 2, 4 },
+	.len = 2,
+	.type = IIO_VAL_INT,
+	.mask = SMI330_CFG_BW_MASK
+};
+
+static const struct smi330_attributes smi330_odr_attr = {
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
+static int smi330_get_attributes(enum smi330_sensor_conf_select config,
+				 enum smi330_sensor sensor,
+				 const struct smi330_attributes **attr)
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
+	const struct smi330_attributes *attr;
+
+	ret = smi330_get_config_reg(sensor, &reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, reg, &reg_val);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_attributes(config, sensor, &attr);
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
+	const struct smi330_attributes *attr;
+
+	ret = smi330_get_attributes(config, sensor, &attr);
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
+		return smi330_set_sensor_config(data, sensor, SMI330_ODR, val);
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
+	int ret;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG, data->buf,
+			       SMI330_SCAN_LEN);
+	if (ret)
+		goto out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
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
+	ret = regmap_bulk_read(data->regmap, SMI330_INT1_STATUS_REG, int_status, 2);
+	if (ret)
+		return IRQ_NONE;
+
+	int_stat = int_status[0] | int_status[1];
+
+	if (FIELD_GET(SMI330_INT_STATUS_ACC_GYR_DRDY_MASK, int_stat)) {
+		indio_dev->pollfunc->timestamp = iio_get_time_ns(indio_dev);
+		iio_trigger_poll_nested(data->trig);
+	}
+
+	return IRQ_HANDLED;
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
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
+	ret = smi330_set_int_pin_config(data, irq_num, active_high, open_drain,
+					latch);
+	if (ret)
+		return ret;
+
+	return devm_request_threaded_irq(dev, irq, NULL,
+					 smi330_irq_thread_handler,
+					 irq_type | IRQF_ONESHOT,
+					 indio_dev->name, indio_dev);
+}
+
+static int smi330_register_irq(struct device *dev, struct iio_dev *indio_dev)
+{
+	int ret, irq;
+	struct smi330_data *data = iio_priv(indio_dev);
+	struct fwnode_handle *fwnode;
+
+	fwnode = dev_fwnode(dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	data->cfg.data_irq = SMI330_INT_DISABLED;
+
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq > 0) {
+		ret = smi330_setup_irq(dev, indio_dev, irq, SMI330_INT_1);
+		if (ret)
+			return ret;
+		data->cfg.data_irq = SMI330_INT_1;
+	} else {
+		irq = fwnode_irq_get_byname(fwnode, "INT2");
+		if (irq > 0) {
+			ret = smi330_setup_irq(dev, indio_dev, irq,
+					       SMI330_INT_2);
+			if (ret)
+				return ret;
+			data->cfg.data_irq = SMI330_INT_2;
+		}
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
+		data->cfg.op_mode = SMI330_POLLING;
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
+	chip_id = FIELD_GET(SMI330_CHIP_ID_MASK, chip_id);
+	if (chip_id != SMI330_CHIP_ID)
+		dev_info(dev, "Unknown chip id: 0x%04x\n", chip_id);
+
+	ret = regmap_read(data->regmap, SMI330_ERR_REG, &val);
+	if (ret)
+		return ret;
+	if (FIELD_GET(SMI330_ERR_FATAL_MASK, val))
+		return -ENODEV;
+
+	ret = regmap_read(data->regmap, SMI330_STATUS_REG, &val);
+	if (ret)
+		return ret;
+	if (FIELD_GET(SMI330_STATUS_POR_MASK, val) == 0)
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
+	data->regmap = regmap;
+
+	ret = smi330_soft_reset(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Soft reset failed\n");
+
+	indio_dev->channels = smi330_channels;
+	indio_dev->num_channels = ARRAY_SIZE(smi330_channels);
+	indio_dev->available_scan_masks = smi330_avail_scan_masks;
+	indio_dev->name = "smi330";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &smi330_info;
+
+	data->cfg.op_mode = SMI330_POLLING;
+
+	ret = smi330_dev_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Init failed\n");
+
+	ret = smi330_register_irq(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Register IRQ failed\n");
+
+	if (data->cfg.data_irq != SMI330_INT_DISABLED) {
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
+		/* Set default operation mode to data ready. */
+		indio_dev->trig = iio_trigger_get(data->trig);
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      smi330_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "IIO buffer setup failed\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Register IIO device failed\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(smi330_core_probe, "IIO_SMI330");
+
+MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
+MODULE_AUTHOR("Roman Huber <roman.huber@de.bosch.com>");
+MODULE_AUTHOR("Filip Andrei <Andrei.Filip@ro.bosch.com>");
+MODULE_AUTHOR("Drimbarean Avram Andrei <Avram-Andrei.Drimbarean@ro.bosch.com>");
+MODULE_DESCRIPTION("Bosch SMI330 IMU driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/iio/imu/smi330/smi330_i2c.c b/drivers/iio/imu/smi330/smi330_i2c.c
new file mode 100644
index 00000000000..e5f1825beb7
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_i2c.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "smi330.h"
+
+#define SMI330_NUM_DUMMY_BYTES 2
+#define SMI330_I2C_MAX_RX_BUFFER_SIZE \
+	(SMI330_NUM_DUMMY_BYTES + SMI330_SCAN_LEN * sizeof(s16))
+
+struct smi330_i2c_priv {
+	struct i2c_client *i2c;
+	u8 rx_buffer[SMI330_I2C_MAX_RX_BUFFER_SIZE];
+};
+
+static int smi330_regmap_i2c_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	struct smi330_i2c_priv *priv = context;
+	int ret;
+
+	if (SMI330_NUM_DUMMY_BYTES + val_size > SMI330_I2C_MAX_RX_BUFFER_SIZE)
+		return -EINVAL;
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
+			.len = SMI330_NUM_DUMMY_BYTES + val_size,
+			.buf = priv->rx_buffer,
+		},
+	};
+
+	ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+
+	memcpy(val_buf, priv->rx_buffer + SMI330_NUM_DUMMY_BYTES, val_size);
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
+	.driver = {
+		.of_match_table = smi330_of_match,
+		.name = "smi330_i2c",
+	},
+};
+module_i2c_driver(smi330_i2c_driver);
+
+MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
+MODULE_AUTHOR("Roman Huber <roman.huber@de.bosch.com>");
+MODULE_AUTHOR("Filip Andrei <Andrei.Filip@ro.bosch.com>");
+MODULE_AUTHOR("Drimbarean Avram Andrei <Avram-Andrei.Drimbarean@ro.bosch.com>");
+MODULE_DESCRIPTION("Bosch SMI330 I2C driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS("IIO_SMI330");
diff --git a/drivers/iio/imu/smi330/smi330_spi.c b/drivers/iio/imu/smi330/smi330_spi.c
new file mode 100644
index 00000000000..a6044e02b45
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_spi.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2025 Robert Bosch GmbH.
+ */
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
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
+	/* Insert pad byte for reading */
+	u8 reg[] = { *(u8 *)reg_buf, 0 };
+
+	if (reg_size + 1 != ARRAY_SIZE(reg)) {
+		dev_err(&spi->dev, "Invalid register size %zu\n", reg_size);
+		return -EINVAL;
+	}
+
+	return spi_write_then_read(spi, reg, ARRAY_SIZE(reg), val_buf,
+				   val_size);
+}
+
+static int smi330_regmap_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	struct spi_device *spi = context;
+
+	return spi_write(spi, data, count);
+}
+
+static const struct regmap_bus smi330_regmap_bus = {
+	.read = smi330_regmap_spi_read,
+	.write = smi330_regmap_spi_write,
+	.read_flag_mask = 0x80,
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
+	.driver = {
+		.of_match_table = smi330_of_match,
+		.name = "smi330_spi",
+	},
+};
+module_spi_driver(smi330_spi_driver);
+
+MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
+MODULE_AUTHOR("Roman Huber <roman.huber@de.bosch.com>");
+MODULE_AUTHOR("Filip Andrei <Andrei.Filip@ro.bosch.com>");
+MODULE_AUTHOR("Drimbarean Avram Andrei <Avram-Andrei.Drimbarean@ro.bosch.com>");
+MODULE_DESCRIPTION("Bosch SMI330 SPI driver");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS("IIO_SMI330");
-- 
2.34.1


