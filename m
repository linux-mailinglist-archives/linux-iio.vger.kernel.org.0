Return-Path: <linux-iio+bounces-21316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF0AF7CB1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB361896EC8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0322B5A3;
	Thu,  3 Jul 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="bprshSJ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E42CCDB;
	Thu,  3 Jul 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557184; cv=fail; b=m8DsBXjHT26gIumshLMuaMX5uGP9WQ7FlF4UyGzjDb/pWF9N5aObEkz/GFJ28SDRSXd6DBmYZ8KaKY4dhcfmWShbDsue6ud3QftRklOIMd7OkztrXqAaw52KmCij6ZcnlRZTWh/2WKwRxN843Np35FxIxYOkUmvOqjV0rZs2/M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557184; c=relaxed/simple;
	bh=bGFOsdOcdoAFfa17Lhi5p1zPAVK/uAAug2vZOj4Xeps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fa4h9x612gvH+RaQbXYRdB/loZ5jAM3pWtQZNOHHaDKiM731b5PMo1N4pXC0kxKQCfdR0JJuHuye/Gy5uGdjKJvBICy5u5qLhCl6iMW9QvlDe66YnGgPrUhUYCx2YPR3vkOOztxk3wEG3CrGddChMQ2kSJFO4qhJoTsB/QGgcyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=bprshSJ8; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISQOT+J2gPr1Lk3XOG3uw4cy5LOZfIHykxlDeCtYwMnFgnYi2f/HBmKZjo1qLX2TclIORX4UFxXJ7BcfNNHvg8nhs4/O6LC69YUiRTw7D7AIeCNJqEMvvwdAwxtU1lYQMyvwsImFfIvQTuOlqPXbtB2QYeRFCUSQrM2EkaKVv6ez7cNQ9Ns9Zwfn7yw2w5kpOjg1S+wdHrP98OYP5cb7Qb9nNt27imFl3fnJWqLGppOyFPK415RycSBRhH9LYehglraSlKg6cRep1plyIHjXcpxPDqU5ZaeWwe+ykk4/z70ElAWzEqDq0oxjKiy0ixDsUYvMlfGpTVRj8eGAi0zZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJN8GyfE0x1XuG2DeidVJqvE86q7Z3oNEm+pzlIgw/M=;
 b=Cqg9F0SOWP3QNl+zPoXOB/weFtecYhgG6c7eUyc8gb1mXjx99NLEC1W1bO732lqFng9MtrKVZUw7rJjvGQ19fXEAWsFgwhnYNTdqQ0WuUBqwyzHExaln+YZEiz3lOrRgDYMe/l3V0zoHKWLxwKp7s5oVo4pm4fcCGoLqJ82SEdQsefDmDQ/H2+JUT8XPLIlCS90vgL0qPv3KsW2IgOne0ywUCfz6i726amQYVmZb0LI6p1GnD40Hee8HECgFPfby7GnPG8aI7CEi0Lh4V4LbgU1uhCjWkeTZZ5itnhaW/QJhT7yFVqg5EAc5uTG0qh5Ri+7KmoN+lMJcaMgoAvNofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJN8GyfE0x1XuG2DeidVJqvE86q7Z3oNEm+pzlIgw/M=;
 b=bprshSJ8jG1W99EuzpDxW27D/VIkabOgQ0U5tGuSjPjy7mm7/aVEEzUu3zT9izAFxHCxvymrizf+fIsJ7HONi6fMRblZOQa9AxpR9Hi6nmuh8tN1pRwwSpQpwps0Mj0w2vrE6O3o20LH5sRWfR4yhRhkxxU0XQ3mfw0gkWERoIEsrHWJAoXmeq4dS5P+xZieehPU5XllyFRNOBfDjS17Gm6qILqF6vpEqSQ6J/db0m3tfb+RzOakEnca+o0jTVrXTNfwTUIwBuIWp//4IgxFcQSwx6HOddLK4Cg45dfXXW2wGCITgE1ooFVL2mk1NGUeSaXTHV83Do5ILWnPp02/Jg==
Received: from DUZPR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::12) by PAVPR10MB6767.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:32c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 15:39:34 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::3) by DUZPR01CA0145.outlook.office365.com
 (2603:10a6:10:4bd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 15:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 15:39:34 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Thu, 3 Jul
 2025 17:39:06 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Thu, 3 Jul 2025 17:39:06 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.13.214.229) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 3 Jul 2025 17:39:05 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v3 2/2] iio: imu: smi330: Add driver
Date: Thu, 3 Jul 2025 17:38:23 +0200
Message-ID: <20250703153823.806073-3-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|PAVPR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 576c6c50-4ee1-4785-9909-08ddba47cfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEJEVk9IV21vL1NpdWlUNjBGdGxRMGdYbmlUbFFFN3dCeGVGT3F4WDNmaXE5?=
 =?utf-8?B?cjJtWVhXV21YYThFZm9NbUpMRmRXdm9TRm1wd3VrV3c3R3JXMy9HWWt5Z2Fk?=
 =?utf-8?B?eTY1NXAzRFB0U2VsNmZ6anRnblJJNXNwMG5ObElqbk1wKzVBUDNMRm9KeW1k?=
 =?utf-8?B?NnlxcUdDLzdtNGUrNStrWmJLODExa0Y1dU1VTHF0bmtRNENiV3BnZEI3aVo2?=
 =?utf-8?B?QTNkdU1uZk5xQVlidEJxM0M4VXlCSDFITC9ZZ2tTQVRkeU9ra2tmSzM1dDhU?=
 =?utf-8?B?QVdSOU1xaHZ4emFZdEhiZ0pDcTVOTmV1cXdpS2VybVF4S0JpQlNadXNOSmJ0?=
 =?utf-8?B?ejRZM01PdlJhSGQ3Qkl6QXVuRFdCZVlZSFJvck9CT1lOTzF0NzRCb2tYQ3V0?=
 =?utf-8?B?TUxENlNPUkE3aVpCTHFKdkVvNUVINFpVZHBLME5naExBRkdONGxGbE1FYi9k?=
 =?utf-8?B?M0xNR1NEZENDWTVoOFRJTmtzWDVnaDFCaHRmK1IrREpQZW5WV2RlelFhQmRz?=
 =?utf-8?B?TVhHZE1iNXZhOEtWWU9xWmVCVDhKR2FPS3Bpa0pUaUw3SkU0T1hkNHBiOE1K?=
 =?utf-8?B?ZFJ2N3I3Sm0xQkZCazAyTXB6cXgwOUM0aERqSE92aHczOVBZa0lRTnNab3Ft?=
 =?utf-8?B?a05SZ0UrN1FDRjZTMTJDUVNYRjRLRjZSVGNsNmpaV2hXRmQyZzhacTBoQ1NN?=
 =?utf-8?B?U1lhaTRnVGpXV21wVVFOQ1FDWXYyNjdUMFBTR2Npam1LWU5BclJidFM4V0Z6?=
 =?utf-8?B?bVNOQVVQUVZJZUZIazhKVzdOYm5tdkZzNkZBNjYyN2RJeitCQW1MSGlLQk1r?=
 =?utf-8?B?dVZzaWVoTmFzeVVDOFUxdjNJbG5xWDB5K2toNlR2TlNWdS9CL1QrUmxvZENF?=
 =?utf-8?B?ODAzejVwSThZUVJ3eHQwVW1OS0dXNU13NVh6RzlnVzJsOTRBcmxadVd3V0RT?=
 =?utf-8?B?OTBnemJzL2RLcDJ3MDR5NEJ0bGJwVFZGYUNVc0JTMU9XdUt0R2Fwem1UTE1K?=
 =?utf-8?B?c21SNzV0d1d2UGhWbXBmWE4zZnQrNWVxRnBNem1FdCsvME1aOXVmT3QyT1JI?=
 =?utf-8?B?WHZYWlRqMlBCdGFyaW9GTnB0eGRNbXlTWVRWK0hXZHNqQzBxNFBCWFl3TUV3?=
 =?utf-8?B?cktHcmNINHgvb01ORjU2VUlhSm96TXEyWU5PVWRtZ21BZmJVTzNxODgxTjU0?=
 =?utf-8?B?S0ZzNE1KM2t3SnpKZDRidXBXZGt5ODhya0dCYXNYTDVNbUZRNXU0SHZ0K3pC?=
 =?utf-8?B?K1RPUUVWalNUcWE2Tmg2TEprTTVNKzVTb2JYTVdLdFB1RFFsMktTZEMyZDVs?=
 =?utf-8?B?cUlTWTNKMHdDZnBWcFFnSEtGcGJmWGliam0vaVlRdmw4cU9SK2R0a0ViWFVq?=
 =?utf-8?B?ckF0OWEvQ2xic0pjZktXSDZvL09QdWJna2pZaHdVSXJsU2s1TkpmZElOakJX?=
 =?utf-8?B?K2FBZGlsWGRmTm9tbGNoeEtyd1N1U0JyU0tndTRJOEt5cXZmaWF1Yjc0bkJj?=
 =?utf-8?B?a20yYkh0VmVGNy9pOWc4dG04eFBRMTZaSnB3QkZGRndPeFA1WkVPNTF5Sm1n?=
 =?utf-8?B?d3JNbEVBbFRhcFVYYUtOd2FtNXRjY2V2cThhQk5mVWY1TEZOb2NPTG5aT1Ey?=
 =?utf-8?B?c0xjL0xrY0hxMUgzK041WFhtWEtzYTBCeTU2SlFLaGtQMWtuaTNpd3RBeHhB?=
 =?utf-8?B?OXhYb2cwWTlLTHZMWlVGT3Y4aENPU2w2YTM1NllicjhDRlhoUENtK2k3c1RO?=
 =?utf-8?B?YkpFTXpDQTFNY1ZmaWJ6YkhTNDR0WkRyTHpFNnMvRExTQnQvOWNyVnoyTEp1?=
 =?utf-8?B?cFNVdDBwQXgzd2xBY0J1L0RmUnlLa1V4clQ4RTdJNmpuSmpKZDNoclpZWUlQ?=
 =?utf-8?B?WDViWUVBbEJhTVp0TU5CVmhCKzZkVlJ6NCtNNWVqYjUrNGp6M2xEZEpxT2Ez?=
 =?utf-8?B?SnJtV29Ndkk1Z3p0SERSdGF4S0xGdVUxYng2WHFiRmpnUnFseVc2T1VTUlZP?=
 =?utf-8?B?VmJBQzYzSzJYb1oxWnpWMmIwUWNHc2p0UXl2MWhkZDBjaHZ2NldFdVpFRWxM?=
 =?utf-8?B?RXRYR0hSYTNtQ2FYRVFvdzIyVjFzQmV2VmNTZz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:39:34.4761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576c6c50-4ee1-4785-9909-08ddba47cfa7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6767

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi330. The smi330 is a combined
three axis angular rate and three axis acceleration sensor.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/Kconfig              |   1 +
 drivers/iio/imu/Makefile             |   1 +
 drivers/iio/imu/smi330/Kconfig       |  39 ++
 drivers/iio/imu/smi330/Makefile      |   7 +
 drivers/iio/imu/smi330/smi330.h      | 240 +++++++++
 drivers/iio/imu/smi330/smi330_core.c | 779 +++++++++++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c  | 136 +++++
 drivers/iio/imu/smi330/smi330_spi.c  |  91 ++++
 8 files changed, 1294 insertions(+)
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
index 00000000000..bd896e86977
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330.h
@@ -0,0 +1,240 @@
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
+#define SMI330_CHIP_ID_REG 0x00
+#define SMI330_ERR_REG 0x01
+#define SMI330_STATUS_REG 0x02
+#define SMI330_ACCEL_X_REG 0x03
+#define SMI330_GYRO_X_REG 0x06
+#define SMI330_TEMP_REG 0x09
+#define SMI330_INT1_STATUS_REG 0x0D
+#define SMI330_FEATURE_IO0_REG 0x10
+#define SMI330_FEATURE_IO1_REG 0x11
+#define SMI330_FEATURE_IO2_REG 0x12
+#define SMI330_FEATURE_IO_STATUS_REG 0x14
+#define SMI330_FIFO_FILL_LEVEL_REG 0x15
+#define SMI330_FIFO_DATA_REG 0x16
+#define SMI330_ACCEL_CFG_REG 0x20
+#define SMI330_GYRO_CFG_REG 0x21
+#define SMI330_ALT_ACCEL_CFG_REG 0x28
+#define SMI330_ALT_GYRO_CFG_REG 0x29
+#define SMI330_ALT_CONF_REG 0x2A
+#define SMI330_ALT_STATUS_REG 0x2B
+#define SMI330_FIFO_WATERMARK_REG 0x35
+#define SMI330_FIFO_CONF_REG 0x36
+#define SMI330_FIFO_CTRL_REG 0x37
+#define SMI330_IO_INT_CTRL_REG 0x38
+#define SMI330_INT_CONF_REG 0x39
+#define SMI330_INT_MAP1_REG 0x3A
+#define SMI330_INT_MAP2_REG 0x3B
+#define SMI330_FEATURE_CTRL_REG 0x40
+#define SMI330_FEATURE_DATA_ADDR_REG 0x41
+#define SMI330_FEATURE_DATA_TX_REG 0x42
+#define SMI330_FEATURE_DATA_STATUS_REG 0x43
+#define SMI330_CMD_REG 0x7E
+#define SMI330_RES_CFG_REG 0x7F
+
+/* Register mask */
+#define SMI330_ERR_FATAL_MASK BIT(0)
+#define SMI330_ERR_ACC_CONF_MASK BIT(5)
+#define SMI330_ERR_GYR_CONF_MASK BIT(6)
+#define SMI330_STATUS_POR_MASK BIT(0)
+#define SMI330_INT_STATUS_NOMO_MASK BIT(0)
+#define SMI330_INT_STATUS_ANYMO_MASK BIT(1)
+#define SMI330_INT_STATUS_TILT_MASK BIT(7)
+#define SMI330_INT_STATUS_ACC_GYR_DRDY_MASK GENMASK(13, 12)
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
+	SMI330_SCAN_TEMPERATURE,
+	SMI330_SCAN_TIMESTAMP,
+	SMI330_SCAN_LEN,
+};
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
+	IIO_DECLARE_BUFFER_WITH_TS(s16, buf, SMI330_SCAN_LEN);
+};
+
+int smi330_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _SMI330_H */
diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
new file mode 100644
index 00000000000..23e65c1ed64
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -0,0 +1,779 @@
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
+static const struct iio_chan_spec smi330_channels[] = {
+	SMI330_ACCEL_CHANNEL(IIO_ACCEL, X, SMI330_SCAN_ACCEL_X),
+	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Y, SMI330_SCAN_ACCEL_Y),
+	SMI330_ACCEL_CHANNEL(IIO_ACCEL, Z, SMI330_SCAN_ACCEL_Z),
+	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, X, SMI330_SCAN_GYRO_X),
+	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Y, SMI330_SCAN_GYRO_Y),
+	SMI330_GYRO_CHANNEL(IIO_ANGL_VEL, Z, SMI330_SCAN_GYRO_Z),
+	SMI330_TEMP_CHANNEL(SMI330_SCAN_TEMPERATURE),
+	IIO_CHAN_SOFT_TIMESTAMP(SMI330_SCAN_TIMESTAMP),
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
+	int ret, chan;
+	int i = 0;
+
+	ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG, data->buf,
+			       ARRAY_SIZE(smi330_channels));
+	if (ret)
+		goto out;
+
+	if (*indio_dev->active_scan_mask != SMI330_ALL_CHAN_MSK) {
+		iio_for_each_active_channel(indio_dev, chan)
+			data->buf[i++] = data->buf[chan];
+	}
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
+	chip_id &= 0x00FF;
+
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
index 00000000000..76b88bbd7d2
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_i2c.c
@@ -0,0 +1,136 @@
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
index 00000000000..5b5aaaf0c5d
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_spi.c
@@ -0,0 +1,91 @@
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
+static const struct regmap_config smi330_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
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


