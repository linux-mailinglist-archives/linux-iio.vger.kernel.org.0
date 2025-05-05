Return-Path: <linux-iio+bounces-19109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F10AA9753
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D82616F199
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC326B08F;
	Mon,  5 May 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Ev3Qx7ka"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5E26462E;
	Mon,  5 May 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458284; cv=fail; b=ZnOx2JZ+3j3XXQivLKYf5dyna2QF4zlX1YxFhISYtlWhA9OPp1c+rl3s/7f6uagFIt+nJvSp519T6inz00VEokCyf1VmRTIT4KmJTfrJ2int3e3jjZOkZiVDT8r+HYNJ04wx12nN8WwiHdm3IUFJT4nRs+pl5mqTE73RCAX0dPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458284; c=relaxed/simple;
	bh=pJeYxyWGAXpeHpSAOdYG2oAmVLVuKCRRyq75jXhJDKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EccQyqRJThoXpGyiVCMhqphu6hK12s8ddRIoGI5rt2ADMk8mPAjc79M/Bcg95ISJa3LQq0XZfiPPmR2FfZ88AGR3Cbf10k+WRBn+fqdY7S6bsdti6Q59GKImAIH8jl9WTiyO/Hbju1BT5MNpJXIGtd58hT8Btu8cQ8lPHxSsOHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Ev3Qx7ka; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPnaZQp+z4Wxg2wR955YAvXdtOqvxcUrqMA/+E0DsbM/bm8nR1k6e2WyK1koIkeTO0xZAj7Aq7Pb44Pxp1B0GPcEZPb4ZRzfMrk5x632VezM19M2U+3VPCbIKd5xA97yxB7oUAL0hmJkG/bhkS8TRzAmnOPecQclnjmLMLKlrcxgaS+4jJYttZOn2k4ExU3P0TIeeI6c/7eLqJC4LyAwjbrOLH0GRfFTVBZAb6hjuGSf6wmNrq4tkVYqCXG+uco2i1H/2E8Brd6/kn+95BmmbYr8oy2pVpFBP6HyJOJ9Wgtk+pECtMvmEgYun9CGtiGqZelkHkxbpLsrckUIBLuRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOCaaEu2PKZQCLhYQf2h/IGEBc2fs2ws+izzr+4+R8A=;
 b=GsgEw5ZG6ZT2XCVJrIAuf4FGeApTUjv+bKqIhViXbzU74H+XXBlugleMu5drAgmX61a+scBLVlNh/Trsw45IXm5Uimpq+i93YHPzlPc4CXPnDPYeEYvYM0BewB+85O2nYloBLCyevLYH5pPk6wdyUXup4mDm/rdLam5M+Bq6GgGtS3PlomN2yZEVpORJEqaRfVaw+Kd7YcQfGOHu01MeKeHrt4zDUsZHhBmu3Rk6xcGKMMOhM0Di8M2ZcphOvFvWcHGAcO3t3emNLCpc/WR9eGoOPFQvhSDC/4tMG5bdhuBmpa/H6ZtkmTZXFIpSS/5AONcbIIm6n0Zn49/kP7g7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOCaaEu2PKZQCLhYQf2h/IGEBc2fs2ws+izzr+4+R8A=;
 b=Ev3Qx7kaMsts5hoRltko2MHX5KlY0ah4BLukWeJ35v4mLC2lIQf7YVSKbmHnmgSKcNWK4M4jZAUj2J0JuG/9AJUG84mR/xu+nQBIB0Gv8m15CGPBj2MlidLJ2JSXIGJZnI0MuJxd/l7OmvcmN3TmiXCj2VRlgsgMK3r1flWQ55WlP4wy7EodMPLpykm4r0s11vEHLKAdSDyx4n92F3lT9RkKnjZJI99BSmSonlSxHJP+ND8OqXAR/dEz1KI3/8H4R2w3NxOnbA6yQNZCBCnOmb5BeQ/vPz0YOtNrHITRJT0KG/TbEbGf6BuNQX8cpfabJXeFVSG6gSGX/2tb0gI0bg==
Received: from DUZPR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::12) by AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:dd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 15:17:52 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com (2603:10a6:10:4b3::4)
 by DUZPR01CA0176.outlook.office365.com (2603:10a6:10:4b3::12) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31
 via Frontend Transport; Mon, 5 May 2025 15:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:17:51 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 17:17:47 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Mon, 5 May 2025 17:17:47 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.213.45) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 5 May 2025 17:17:45 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v1 3/3] iio: imu: smi330: Add driver
Date: Mon, 5 May 2025 17:16:41 +0200
Message-ID: <20250505151641.52878-4-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505151641.52878-1-Jianping.Shen@de.bosch.com>
References: <20250505151641.52878-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|AM7PR10MB3175:EE_
X-MS-Office365-Filtering-Correlation-Id: 0def0959-5c18-4a05-b7b9-08dd8be800ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHBlRTRNZm44SzFjL3RDb1N0eGdHM2tJbjF2UXNCMTUxYjhGQ3R4b1JHRnpH?=
 =?utf-8?B?alU1K2RkZmllR0xzTEc3ZkpTT1p6eFVWZWlNbDlFT0gxQ0NGZEtQVDhHUUdt?=
 =?utf-8?B?YXE0YSt2anFYSDNWOFpSZXNrYWdQY1drMDlMUW1OMXYxWk5zdlN0QXB0N3Bq?=
 =?utf-8?B?M2IxM09xQzd3SUR3Z2JHTGZvOWtjMkJwSUx1Q21jTS9nVVhNeldXRlFSVXVW?=
 =?utf-8?B?TDA4ZUsrUS92Wlhka0lJaDM4T2wzbGVNSGdLZHdBcmtoQSt1NmM5a3hsR2ZB?=
 =?utf-8?B?OUh5R0Q2TlVaekxFbWI1R1o2UEVyZFhnemxrU3NiRnZuam9Uc0xWUFVMWk1k?=
 =?utf-8?B?Z2EvSXpnb2svamhpcVZhZ2l3VXhkbEk5L2lPR1A5eUNuQXFpWGI2VTdDTTc5?=
 =?utf-8?B?S0cyYnZTaDFYWFZYVjB2Z1g5MFIyRFI5cEh5bVRYVTBITWtHS0srV2lySzQv?=
 =?utf-8?B?aEpFZzlMTTIrU2NMakoxWWZRMkEwVWhLblU3Ly9ENXhudURkRFJYUXluOVNM?=
 =?utf-8?B?TDZRQnRZUzFwZS92dmRqUXJOYU1UZWtEV3c0aUluUzQ0MEFJVFhEOEc3bi9a?=
 =?utf-8?B?TnZyamdlcXN1OE9mTXRnbmU3Z3pHTkpSUkRzeWltQUcrcDZBNDhBRmNnUW5a?=
 =?utf-8?B?NUtSNnd2d2ZNbmZzTkZRQ1JmdjI2UmRaWm9nRC9hc09QY251QzhwWGhSaENh?=
 =?utf-8?B?QzZJdGhLZnVYbmcvRDlSTFpuQmZOVWRrTnFiZjJnZlZnK1R4UW4rVy9RNzU3?=
 =?utf-8?B?SElGSW02SDIvZjNBYW4yY1NXNEFEVllMSTZzeGhCaTdlUkVsUUx0TC9GTmNm?=
 =?utf-8?B?REVqNUxaM2ViNUI2UUhLcVdEMmdUZE12cE5iQnN2ek1BMDB0RHFPbHNqelZ1?=
 =?utf-8?B?ZnJtcVdEalU2RWNIZFJhbldLU3EzS0pmVkpacnBZYVNLcFhLWnc3cXFOMEI2?=
 =?utf-8?B?aXJxN25Tc1dINCtScFZBMVdrRGo5Z3JuWnBXdG1DZ2YzeDlkN3VEa01IS1Uw?=
 =?utf-8?B?U0o5ZzZCQWxYV3NUeTRjWUxLcStTK1NlTVZOL3NmREVIbDVKdndabWdxWDNr?=
 =?utf-8?B?b0lSQmdmOFh5aTdWVTR3a1JvVEp6dWcwbzFYUUkvZ28yOU92d0puVVJhWE53?=
 =?utf-8?B?UUxIeDdSVWhpWW5CMnFxYzZuOVVxTDZzd1JRNkVrdjJub1lMMmJXTDlrZDc0?=
 =?utf-8?B?RXo2ZXc1S0dlV1htMm1yczVNT0o1NzVZLzdwTUlLbEorZTZrYXRMd0QyWS84?=
 =?utf-8?B?SndRUndQdFRacEVEYVBiWjF2ckdOaGEvL3JQYzFJcGRiYWZsWndKS1J2eHpx?=
 =?utf-8?B?SEJ2RVRhUzBmaFV0UEFoUVdBSDZjbUdIM0xkV3NMN3dMbjk3ZXBDOERnWWZE?=
 =?utf-8?B?bWFKekxCYnpPNElZOSt2U1JiTEVadWRySW0vVEp2alVMbEJ0Z2VVT2QvclpW?=
 =?utf-8?B?T0NBTjcvTUsrL0JhSEk4YWlTRXhSUFdzL2NodnIwVGpRT1F5STAweHQ1MUtE?=
 =?utf-8?B?ZUFJK3U4ejZpZlo1Ykx0d3JMOUdsRnpLbXZQOWJwdG9uUlNMY0thdFNpL1hQ?=
 =?utf-8?B?bXNqOTVpdmxuSlliZGc0a1NpWUNhci9HQndsdG5HQUVwVlBXZU9BWnZNcDk1?=
 =?utf-8?B?T3dxa2V1VzFQTGgyTDE4M2VpTWdIWm8wR2tuSFU3L0pJV0NTeVhRRE1UTUt2?=
 =?utf-8?B?M0dGSzVJYVRBanVuaGhMZEFlZTlLdU5xY25vcHhIQkpROEU2VExobkJuOGNa?=
 =?utf-8?B?emFhZm9xNTBNcGx4NENmcmVUSXB6QkN0d3dKdVpKZXRYS3FkaUdMWDFLWTk0?=
 =?utf-8?B?WGg5YUt5czRqZWUwUUJYOFdsWGJ6NlF2RHl5YVdFaFM0bEl4aXNJajdxdGtS?=
 =?utf-8?B?SE1WKytHTGNmLzVnems4STVPVHhGd2F6TEhtM1pONUFLWDdtOUJpNmI4NXVZ?=
 =?utf-8?B?TGxCY3BtbTN4blFVWFZRUndLN1VpdEFmWkhpeWdGUG5KdGJRVnBuTWRGbk1u?=
 =?utf-8?B?N3d1T2dSaVFNWllWWnFBT3NYckpIM2haY0lGY1UwSGJQNGU4YXVxd3hZdkR4?=
 =?utf-8?B?Um5pOW0wdldtRFpZNDNlcUhQNEJaQ1NYNEdRdz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:17:51.7718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0def0959-5c18-4a05-b7b9-08dd8be800ce
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3175

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi330. The smi330 is a combined
three axis angular rate and three axis acceleration sensor.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/Kconfig              |    1 +
 drivers/iio/imu/Makefile             |    1 +
 drivers/iio/imu/smi330/Kconfig       |  129 ++
 drivers/iio/imu/smi330/Makefile      |    5 +
 drivers/iio/imu/smi330/smi330.h      |  351 ++++
 drivers/iio/imu/smi330/smi330_core.c | 2608 ++++++++++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c  |  140 ++
 drivers/iio/imu/smi330/smi330_spi.c  |   77 +
 8 files changed, 3312 insertions(+)
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
index 00000000000..71ef01c66f2
--- /dev/null
+++ b/drivers/iio/imu/smi330/Kconfig
@@ -0,0 +1,129 @@
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
+choice
+	prompt "Map advanced features interrupt"
+	default SMI330_IRQ_ADV_FEAT_NONE
+	help
+	  Map advanced features interrupt to INT1 or INT2.
+
+	  NONE: advanced features interrupt disabled
+	  INT1: advanced features interrupt mapped to INT1
+	  INT2: advanced features interrupt mapped to INT2
+
+	config SMI330_IRQ_ADV_FEAT_NONE
+		bool "NONE"
+		help
+		  Advanced features interrupt disabled.
+
+		  In this mode no-motion, any-motion or tilt detection
+		  is disabled.
+		  To enable these features choose INT1 or INT2.
+
+	config SMI330_IRQ_ADV_FEAT_INT1
+		bool "INT1"
+		help
+		  Advanced features interrupt mapped to INT1.
+
+		  In this mode no-motion, any-motion or tilt detection
+		  is enabled.
+		  The interrupt is triggered when the feature is detected.
+
+	config SMI330_IRQ_ADV_FEAT_INT2
+		bool "INT2"
+		help
+		  Advanced features interrupt mapped to INT1.
+
+		  In this mode no-motion, any-motion or tilt detection
+		  is enabled.
+		  The interrupt is triggered when the feature is detected.
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
index 00000000000..20e72107b0a
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330.h
@@ -0,0 +1,351 @@
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
+#include <linux/mutex.h>
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
+#define SMI330_FIFO_SIZE 2048
+#define SMI330_FIFO_MAX_LENGTH 1024
+#define SMI330_FIFO_MAX_FRAME_LENGTH 8
+
+#define SMI330_CHIP_ID 0x42
+
+#define SMI330_SPI_WR_MASK GENMASK(6, 0)
+#define SMI330_SPI_RD_MASK BIT(7)
+
+#define SMI330_SOFT_RESET_DELAY 2000
+#define SMI330_FEAT_ENG_POLL 10000
+#define SMI330_FEAT_ENG_TIMEOUT 1000000
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
+/* Extended register map */
+#define SMI330_GYRO_SC_ST_VALUES_EX_REG U8_C(0x28)
+#define SMI330_GYRO_SC_SELECT_EX_REG U8_C(0x26)
+#define SMI330_ST_SELECT_EX_REG U8_C(0x25)
+#define SMI330_ST_RESULT_EX_REG U8_C(0x24)
+#define SMI330_ALT_CONF_CHG_EX_REG U8_C(0x23)
+#define SMI330_TILT_2_EX_REG U8_C(0x22)
+#define SMI330_TILT_1_EX_REG U8_C(0x21)
+#define SMI330_NOMO_3_EX_REG U8_C(0x0A)
+#define SMI330_NOMO_2_EX_REG U8_C(0x09)
+#define SMI330_NOMO_1_EX_REG U8_C(0x08)
+#define SMI330_ANYMO_3_EX_REG U8_C(0x07)
+#define SMI330_ANYMO_2_EX_REG U8_C(0x06)
+#define SMI330_ANYMO_1_EX_REG U8_C(0x05)
+
+/* Extended register mask */
+#define SMI330_GYRO_SC_SELECT_ALL_MASK GENMASK(2, 0)
+#define SMI330_ST_SELECT_ACC_GYR_MASK GENMASK(1, 0)
+#define SMI330_ALT_CONF_CHG_USER_MASK GENMASK(7, 4)
+#define SMI330_ALT_CONF_CHG_ALT_MASK GENMASK(3, 0)
+#define SMI330_TILT2_BETA_ACC_MEAN_MASK GENMASK(15, 0)
+#define SMI330_TILT1_MIN_ANGLE_MASK GENMASK(15, 8)
+#define SMI330_TILT1_SEGMENT_SIZE_MASK GENMASK(7, 0)
+#define SMI330_MOTION3_WAIT_TIME_MASK GENMASK(15, 13)
+#define SMI330_MOTION3_DURATION_MASK GENMASK(12, 0)
+#define SMI330_MOTION2_HYSTERESIS_MASK GENMASK(9, 0)
+#define SMI330_MOTION1_ACC_REF_MASK BIT(12)
+#define SMI330_MOTION1_SLOPE_THRES_MASK GENMASK(11, 0)
+
+/* Extended register values */
+#define SMI330_SC_ST_VALUE_0 0x5A2E
+#define SMI330_SC_ST_VALUE_1 0x9219
+#define SMI330_SC_ST_VALUE_2 0x5637
+#define SMI330_SC_ST_VALUE_3 0xFFE8
+#define SMI330_SC_ST_VALUE_4 0xFFEF
+#define SMI330_SC_ST_VALUE_5 0x000D
+#define SMI330_SC_ST_VALUE_6 0x07CA
+#define SMI330_SC_ST_VALUE_7 0xFFCD
+#define SMI330_SC_ST_VALUE_8 0xEF6C
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
+	SMI330_ODR_0_78125_HZ = U8_C(0x01),
+	SMI330_ODR_1_5625_HZ = U8_C(0x02),
+	SMI330_ODR_3_125_HZ = U8_C(0x03),
+	SMI330_ODR_6_25_HZ = U8_C(0x04),
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
+enum smi330_auto_op_adv_feat {
+	A_NO_MOTION = U8_C(0x01),
+	B_ANY_MOTION = U8_C(0x02),
+	H_TILT_DETECTION = U8_C(0x08)
+};
+
+enum smi330_auto_op_use {
+	SMI330_AUTO_OP_USER_A,
+	SMI330_AUTO_OP_USER_B,
+	SMI330_AUTO_OP_USER_H,
+	SMI330_AUTO_OP_ALT_A,
+	SMI330_AUTO_OP_ALT_B,
+	SMI330_AUTO_OP_ALT_H,
+};
+
+enum smi330_operation_mode {
+	SMI330_IDLE,
+	SMI330_DATA_READY,
+	SMI330_FIFO,
+};
+
+enum smi330_auto_op_setup {
+	SMI330_AUTO_OP_RESET,
+	SMI330_AUTO_OP_SET,
+};
+
+enum smi330_auto_op_mode {
+	SMI330_AUTO_OP_EN_ACC,
+	SMI330_AUTO_OP_EN_GYR,
+	SMI330_AUTO_OP_EN_ALL,
+	SMI330_AUTO_OP_DISABLE,
+};
+
+enum smi330_auto_op_config {
+	SMI330_AUTO_OP_CONFIG_USER,
+	SMI330_AUTO_OP_CONFIG_ALT,
+};
+
+enum smi330_sensor {
+	SMI330_ACCEL,
+	SMI330_GYRO,
+	SMI330_ALT_ACCEL,
+	SMI330_ALT_GYRO,
+};
+
+enum smi330_sensor_conf_select {
+	SMI330_ODR,
+	SMI330_RANGE,
+	SMI330_BW,
+	SMI330_AVG_NUM,
+	SMI330_MODE,
+};
+
+enum smi330_int_out {
+	SMI330_INT_DISABLED,
+	SMI330_INT_1,
+	SMI330_INT_2,
+	SMI330_INT_I3C_IBI,
+};
+
+struct smi330_sysfs_attr {
+	int *reg_vals;
+	int *vals;
+	int len;
+	int type;
+};
+
+struct smi330_cfg {
+	s64 odr_ns;
+	enum smi330_operation_mode op_mode;
+	enum smi330_int_out data_irq;
+	enum smi330_int_out feat_irq;
+};
+
+struct smi330_pwr_savestate {
+	int acc_pwr;
+	int gyr_pwr;
+	int alt_acc_pwr;
+	int alt_gyr_pwr;
+};
+
+struct smi330_data {
+	struct regmap *regmap;
+	struct smi330_cfg cfg;
+	struct smi330_pwr_savestate savestate;
+	s64 current_timestamp;
+	s64 last_timestamp;
+	atomic64_t irq_timestamp;
+	struct mutex lock;
+	struct iio_trigger *trig;
+	s16 fifo[SMI330_FIFO_MAX_LENGTH];
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
+extern const struct dev_pm_ops smi330_pm_ops;
+
+int smi330_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _SMI330_H */
diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
new file mode 100644
index 00000000000..97cc5d36c8f
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -0,0 +1,2608 @@
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
+#include <linux/mutex.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "smi330.h"
+
+static struct iio_event_spec smi330_accel_events[] = {
+	/* Any-Motion */
+	{
+		.type = IIO_EV_TYPE_ROC,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all =
+			BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_PERIOD) |
+			BIT(IIO_EV_INFO_HYSTERESIS) | BIT(IIO_EV_INFO_TIMEOUT),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+	/* No-Motion */
+	{
+		.type = IIO_EV_TYPE_ROC,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all =
+			BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_PERIOD) |
+			BIT(IIO_EV_INFO_HYSTERESIS) | BIT(IIO_EV_INFO_TIMEOUT),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+	/* Tilt-Detection */
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_PERIOD) |
+				      BIT(IIO_EV_INFO_LOW_PASS_FILTER_3DB),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+// clang-format off
+#define SMI330_ACCEL_CHANNEL(_type, _axis, _index) {			\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_ENABLE) |				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_ENABLE) |				\
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
+	.event_spec = smi330_accel_events,				\
+	.num_event_specs = ARRAY_SIZE(smi330_accel_events),		\
+}
+
+#define SMI330_GYRO_CHANNEL(_type, _axis, _index) {			\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_ENABLE) |				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |			\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_ENABLE) |				\
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
+static const struct smi330_sysfs_attr smi330_mode_attr = {
+	.reg_vals = (int[]){ SMI330_MODE_SUSPEND, SMI330_MODE_LOW_POWER,
+			     SMI330_MODE_NORMAL, SMI330_MODE_HIGH_PERF },
+	.vals = (int[]){ 0, 3, 4, 7 },
+	.len = 4,
+	.type = IIO_VAL_INT
+};
+
+static const struct smi330_sysfs_attr smi330_mode_alt_gyro_attr = {
+	.reg_vals = (int[]){ SMI330_MODE_SUSPEND, SMI330_MODE_GYRO_DRIVE,
+			     SMI330_MODE_LOW_POWER, SMI330_MODE_NORMAL,
+			     SMI330_MODE_HIGH_PERF },
+	.vals = (int[]){ 0, 1, 3, 4, 7 },
+	.len = 5,
+	.type = IIO_VAL_INT
+};
+
+static const struct smi330_sysfs_attr smi330_accel_scale_attr = {
+	.reg_vals = (int[]){ SMI330_ACCEL_RANGE_2G, SMI330_ACCEL_RANGE_4G,
+			     SMI330_ACCEL_RANGE_8G, SMI330_ACCEL_RANGE_16G },
+	.vals = (int[]){ 0, 61035, 0, 122070, 0, 244140, 0, 488281 },
+	.len = 8,
+	.type = IIO_VAL_INT_PLUS_NANO
+};
+
+static const struct smi330_sysfs_attr smi330_gyro_scale_attr = {
+	.reg_vals = (int[]){ SMI330_GYRO_RANGE_125, SMI330_GYRO_RANGE_250,
+			     SMI330_GYRO_RANGE_500 },
+	.vals = (int[]){ 0, 3814697, 0, 7629395, 0, 15258789 },
+	.len = 6,
+	.type = IIO_VAL_INT_PLUS_NANO
+};
+
+static const struct smi330_sysfs_attr smi330_average_attr = {
+	.reg_vals = (int[]){ SMI330_AVG_NUM_1, SMI330_AVG_NUM_2,
+			     SMI330_AVG_NUM_4, SMI330_AVG_NUM_8,
+			     SMI330_AVG_NUM_16, SMI330_AVG_NUM_32,
+			     SMI330_AVG_NUM_64 },
+	.vals = (int[]){ 1, 2, 4, 8, 16, 32, 64 },
+	.len = 7,
+	.type = IIO_VAL_INT
+};
+
+static const struct smi330_sysfs_attr smi330_bandwidth_attr = {
+	.reg_vals = (int[]){ SMI330_BW_2, SMI330_BW_4 },
+	.vals = (int[]){ 2, 4 },
+	.len = 2,
+	.type = IIO_VAL_INT
+};
+
+static const struct smi330_sysfs_attr smi330_odr_attr = {
+	.reg_vals = (int[]){ SMI330_ODR_0_78125_HZ, SMI330_ODR_1_5625_HZ,
+			     SMI330_ODR_3_125_HZ, SMI330_ODR_6_25_HZ,
+			     SMI330_ODR_12_5_HZ, SMI330_ODR_25_HZ,
+			     SMI330_ODR_50_HZ, SMI330_ODR_100_HZ,
+			     SMI330_ODR_200_HZ, SMI330_ODR_400_HZ,
+			     SMI330_ODR_800_HZ, SMI330_ODR_1600_HZ,
+			     SMI330_ODR_3200_HZ, SMI330_ODR_6400_HZ },
+	.vals = (int[]){ 0, 1, 3, 6, 12, 25, 50, 100, 200, 400, 800, 1600, 3200,
+			 6400 },
+	.len = 14,
+	.type = IIO_VAL_INT
+};
+
+static int smi330_dev_init(struct smi330_data *data);
+
+static int smi330_get_regs_dma(u8 reg_addr, int *reg_data,
+			       struct smi330_data *data)
+{
+	int ret, status;
+
+	ret = regmap_read(data->regmap, SMI330_FEATURE_DATA_STATUS_REG,
+			  &status);
+	if (ret)
+		return ret;
+
+	if (!FIELD_GET(SMI330_FEATURE_DATA_STATUS_TX_READY_MASK, status))
+		return -EBUSY;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+			   reg_addr);
+	if (ret)
+		return ret;
+
+	return regmap_read(data->regmap, SMI330_FEATURE_DATA_TX_REG, reg_data);
+}
+
+static int smi330_set_regs_dma(u8 reg_addr, int reg_data,
+			       struct smi330_data *data)
+{
+	int ret, status;
+
+	ret = regmap_read(data->regmap, SMI330_FEATURE_DATA_STATUS_REG,
+			  &status);
+	if (ret)
+		return ret;
+
+	if (!FIELD_GET(SMI330_FEATURE_DATA_STATUS_TX_READY_MASK, status))
+		return -EBUSY;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+			   reg_addr);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, SMI330_FEATURE_DATA_TX_REG, reg_data);
+}
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
+	case SMI330_MODE:
+		if (sensor == SMI330_ALT_GYRO)
+			*attr = &smi330_mode_alt_gyro_attr;
+		else
+			*attr = &smi330_mode_attr;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi330_get_odr_ns(enum smi330_odr odr, s64 *odr_ns)
+{
+	switch (odr) {
+	case SMI330_ODR_0_78125_HZ:
+		*odr_ns = 1280000000;
+		break;
+	case SMI330_ODR_1_5625_HZ:
+		*odr_ns = 640000000;
+		break;
+	case SMI330_ODR_3_125_HZ:
+		*odr_ns = 320000000;
+		break;
+	case SMI330_ODR_6_25_HZ:
+		*odr_ns = 160000000;
+		break;
+	case SMI330_ODR_12_5_HZ:
+		*odr_ns = 80000000;
+		break;
+	case SMI330_ODR_25_HZ:
+		*odr_ns = 40000000;
+		break;
+	case SMI330_ODR_50_HZ:
+		*odr_ns = 20000000;
+		break;
+	case SMI330_ODR_100_HZ:
+		*odr_ns = 10000000;
+		break;
+	case SMI330_ODR_200_HZ:
+		*odr_ns = 5000000;
+		break;
+	case SMI330_ODR_400_HZ:
+		*odr_ns = 2500000;
+		break;
+	case SMI330_ODR_800_HZ:
+		*odr_ns = 1250000;
+		break;
+	case SMI330_ODR_1600_HZ:
+		*odr_ns = 625000;
+		break;
+	case SMI330_ODR_3200_HZ:
+		*odr_ns = 312500;
+		break;
+	case SMI330_ODR_6400_HZ:
+		*odr_ns = 156250;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smi330_get_avg_num(enum smi330_avg_num avg, int *avg_num)
+{
+	int i;
+
+	for (i = 0; i < smi330_average_attr.len; i++) {
+		if (smi330_average_attr.reg_vals[i] == avg) {
+			*avg_num = smi330_average_attr.vals[i];
+			return 0;
+		}
+	}
+
+	return -EINVAL;
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
+	case SMI330_ALT_ACCEL:
+		*reg = SMI330_ALT_ACCEL_CFG_REG;
+		return 0;
+	case SMI330_ALT_GYRO:
+		*reg = SMI330_ALT_GYRO_CFG_REG;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi330_validate_sensor_config(enum smi330_mode mode,
+					 enum smi330_odr odr,
+					 enum smi330_avg_num avg)
+{
+	int ret, avg_num;
+	s64 odr_ns, min_odr_ns, skipped_samples;
+
+	switch (mode) {
+	case SMI330_MODE_LOW_POWER:
+		if (odr > SMI330_ODR_400_HZ)
+			return -EINVAL;
+
+		ret = smi330_get_odr_ns(SMI330_ODR_6400_HZ, &min_odr_ns);
+		if (ret)
+			return ret;
+
+		ret = smi330_get_odr_ns(odr, &odr_ns);
+		if (ret)
+			return ret;
+
+		ret = smi330_get_avg_num(avg, &avg_num);
+		if (ret)
+			return ret;
+
+		skipped_samples = div_s64(odr_ns, min_odr_ns) - avg_num;
+
+		if (skipped_samples <= 0)
+			return -EINVAL;
+		return 0;
+
+	case SMI330_MODE_NORMAL:
+	case SMI330_MODE_HIGH_PERF:
+		if (odr <= SMI330_ODR_6_25_HZ)
+			return -EINVAL;
+		return 0;
+
+	default:
+		return 0;
+	}
+}
+
+static int smi330_get_sensor_config_reg(struct smi330_data *data,
+					enum smi330_sensor sensor, int *cfg)
+{
+	int ret, reg;
+
+	ret = smi330_get_config_reg(sensor, &reg);
+	if (ret)
+		return ret;
+
+	return regmap_read(data->regmap, reg, cfg);
+}
+
+static int smi330_get_sensor_config(struct smi330_data *data,
+				    enum smi330_sensor sensor,
+				    enum smi330_sensor_conf_select config,
+				    int *value)
+
+{
+	int ret, reg_val, i;
+	const struct smi330_sysfs_attr *attr;
+
+	ret = smi330_get_sensor_config_reg(data, sensor, &reg_val);
+	if (ret)
+		return ret;
+
+	switch (config) {
+	case SMI330_ODR:
+		reg_val = FIELD_GET(SMI330_CFG_ODR_MASK, reg_val);
+		break;
+	case SMI330_RANGE:
+		reg_val = FIELD_GET(SMI330_CFG_RANGE_MASK, reg_val);
+		break;
+	case SMI330_BW:
+		reg_val = FIELD_GET(SMI330_CFG_BW_MASK, reg_val);
+		break;
+	case SMI330_AVG_NUM:
+		reg_val = FIELD_GET(SMI330_CFG_AVG_NUM_MASK, reg_val);
+		break;
+	case SMI330_MODE:
+		reg_val = FIELD_GET(SMI330_CFG_MODE_MASK, reg_val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smi330_get_sysfs_attr(config, sensor, &attr);
+	if (ret)
+		return ret;
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
+static int smi330_set_sensor_config_reg(struct smi330_data *data,
+					enum smi330_sensor sensor, int mask,
+					int val)
+{
+	int ret, reg, cfg, error;
+	enum smi330_mode mode;
+	enum smi330_odr odr;
+	enum smi330_avg_num avg;
+	struct device *dev = regmap_get_device(data->regmap);
+
+	ret = smi330_get_config_reg(sensor, &reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, reg, &cfg);
+	if (ret)
+		return ret;
+
+	cfg = (val & mask) | (cfg & ~mask);
+
+	mode = FIELD_GET(SMI330_CFG_MODE_MASK, cfg);
+	odr = FIELD_GET(SMI330_CFG_ODR_MASK, cfg);
+	avg = FIELD_GET(SMI330_CFG_AVG_NUM_MASK, cfg);
+
+	ret = smi330_validate_sensor_config(mode, odr, avg);
+	if (ret) {
+		dev_err(dev, "Invalid sensor configuration\n");
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, reg, cfg);
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
+	return smi330_get_odr_ns(odr, &data->cfg.odr_ns);
+}
+
+static int smi330_set_sensor_config(struct smi330_data *data,
+				    enum smi330_sensor sensor,
+				    enum smi330_sensor_conf_select config,
+				    int value, bool is_reg_value)
+{
+	int ret, i, reg_value, mask;
+	const struct smi330_sysfs_attr *attr;
+
+	if (is_reg_value) {
+		reg_value = value;
+	} else {
+		ret = smi330_get_sysfs_attr(config, sensor, &attr);
+		if (ret)
+			return ret;
+
+		ret = -EINVAL;
+		for (i = 0; i < attr->len; i++) {
+			if (attr->vals[i] == value) {
+				if (attr->type == IIO_VAL_INT)
+					reg_value = attr->reg_vals[i];
+				else
+					reg_value = attr->reg_vals[i / 2];
+				ret = 0;
+			}
+		}
+		if (ret)
+			return ret;
+	}
+
+	switch (config) {
+	case SMI330_ODR:
+		mask = SMI330_CFG_ODR_MASK;
+		reg_value = FIELD_PREP(mask, reg_value);
+		break;
+	case SMI330_RANGE:
+		mask = SMI330_CFG_RANGE_MASK;
+		reg_value = FIELD_PREP(mask, reg_value);
+		break;
+	case SMI330_BW:
+		mask = SMI330_CFG_BW_MASK;
+		reg_value = FIELD_PREP(mask, reg_value);
+		break;
+	case SMI330_AVG_NUM:
+		mask = SMI330_CFG_AVG_NUM_MASK;
+		reg_value = FIELD_PREP(mask, reg_value);
+		break;
+	case SMI330_MODE:
+		mask = SMI330_CFG_MODE_MASK;
+		reg_value = FIELD_PREP(mask, reg_value);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return smi330_set_sensor_config_reg(data, sensor, mask, reg_value);
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
+	case IIO_CHAN_INFO_ENABLE:
+		*vals = smi330_mode_attr.vals;
+		*length = smi330_mode_attr.len;
+		*type = smi330_mode_attr.type;
+		return IIO_AVAIL_LIST;
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
+	case IIO_CHAN_INFO_ENABLE:
+		ret = smi330_get_sensor_config(data, sensor, SMI330_MODE, val);
+		return ret ? ret : IIO_VAL_INT;
+
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
+	case IIO_CHAN_INFO_ENABLE:
+		ret = smi330_set_sensor_config(data, sensor, SMI330_MODE, val,
+					       false);
+		if (ret)
+			return ret;
+
+		if (sensor == SMI330_ACCEL)
+			data->savestate.acc_pwr = val;
+		else
+			data->savestate.gyr_pwr = val;
+		return 0;
+	case IIO_CHAN_INFO_SCALE:
+		return smi330_set_sensor_config(data, sensor, SMI330_RANGE,
+						val2, false);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return smi330_set_sensor_config(data, sensor, SMI330_AVG_NUM,
+						val, false);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return smi330_set_sensor_config(data, sensor, SMI330_BW, val,
+						false);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = smi330_set_sensor_config(data, SMI330_ACCEL, SMI330_ODR,
+					       val, false);
+		if (ret)
+			return ret;
+
+		return smi330_set_sensor_config(data, SMI330_GYRO, SMI330_ODR,
+						val, false);
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
+static u16 smi330_get_fifo_length(struct smi330_data *data)
+{
+	int ret, fill_level;
+
+	ret = regmap_read(data->regmap, SMI330_FIFO_FILL_LEVEL_REG,
+			  &fill_level);
+	if (ret)
+		return 0;
+
+	return fill_level & SMI330_FIFO_FILL_LEVEL_MASK;
+}
+
+static int smi330_get_fifo_frame_length(struct iio_dev *indio_dev)
+{
+	int chan;
+	int fifo_frame_length = 0;
+
+	iio_for_each_active_channel(indio_dev, chan) {
+		fifo_frame_length++;
+	}
+
+	return fifo_frame_length;
+}
+
+static int smi330_config_auto_op_mode(struct smi330_data *data,
+				      enum smi330_auto_op_mode auto_op_mode)
+{
+	switch (auto_op_mode) {
+	case SMI330_AUTO_OP_EN_ALL:
+		return regmap_update_bits(data->regmap, SMI330_ALT_CONF_REG,
+					  SMI330_ALT_CONF_EN_MASK,
+					  SMI330_ALT_CONF_EN_MASK);
+	case SMI330_AUTO_OP_EN_ACC:
+		return regmap_update_bits(data->regmap, SMI330_ALT_CONF_REG,
+					  SMI330_ALT_CONF_EN_MASK,
+					  SMI330_ALT_CONF_ACC_EN_MASK);
+	case SMI330_AUTO_OP_EN_GYR:
+		return regmap_update_bits(data->regmap, SMI330_ALT_CONF_REG,
+					  SMI330_ALT_CONF_EN_MASK,
+					  SMI330_ALT_CONF_GYR_EN_MASK);
+	case SMI330_AUTO_OP_DISABLE:
+		return regmap_update_bits(data->regmap, SMI330_ALT_CONF_REG,
+					  SMI330_ALT_CONF_EN_MASK, 0);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int smi330_auto_op_cond(struct smi330_data *data,
+			       enum smi330_auto_op_config auto_op_config,
+			       enum smi330_auto_op_adv_feat auto_op_adv_feat)
+{
+	int ret, val, mask;
+
+	ret = smi330_get_regs_dma(SMI330_ALT_CONF_CHG_EX_REG, &val, data);
+	if (ret)
+		return ret;
+
+	switch (auto_op_config) {
+	case SMI330_AUTO_OP_CONFIG_ALT:
+		if (FIELD_GET(SMI330_ALT_CONF_CHG_USER_MASK, val) !=
+		    auto_op_adv_feat) {
+			mask = SMI330_ALT_CONF_CHG_ALT_MASK;
+			break;
+		}
+		return -EIO;
+	case SMI330_AUTO_OP_CONFIG_USER:
+		if (FIELD_GET(SMI330_ALT_CONF_CHG_ALT_MASK, val) !=
+		    auto_op_adv_feat) {
+			mask = SMI330_ALT_CONF_CHG_USER_MASK;
+			break;
+		}
+		return -EIO;
+	default:
+		return -EINVAL;
+	}
+
+	/* FIELD_PREP is not possible with non-const mask */
+	val = ((auto_op_adv_feat << (__builtin_ffs(mask) - 1)) & mask) |
+	      (val & ~mask);
+
+	return smi330_set_regs_dma(SMI330_ALT_CONF_CHG_EX_REG, val, data);
+}
+
+static int smi330_get_st_result(struct smi330_data *data)
+{
+	int ret, st_result, io1_data;
+
+	ret = regmap_read_poll_timeout(
+		data->regmap, SMI330_FEATURE_IO1_REG, io1_data,
+		FIELD_GET(SMI330_FEATURE_IO1_SC_COMPLETE_MASK, io1_data) == 1,
+		SMI330_FEAT_ENG_POLL, SMI330_FEAT_ENG_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(SMI330_FEATURE_IO1_ST_RESULT_MASK, io1_data)) {
+		ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+				   SMI330_ST_RESULT_EX_REG);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(data->regmap, SMI330_FEATURE_DATA_TX_REG,
+				  &st_result);
+		if (ret)
+			return ret;
+
+		if (st_result != SMI330_ST_SUCCESS_MASK)
+			return -EIO;
+	} else {
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int smi330_disable_alt_conf_acc_gyr_mode(struct smi330_data *data)
+{
+	int ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_ACCEL, SMI330_MODE,
+				       SMI330_MODE_SUSPEND, true);
+	if (ret)
+		return ret;
+
+	return smi330_set_sensor_config(data, SMI330_ALT_GYRO, SMI330_MODE,
+					SMI330_MODE_SUSPEND, true);
+}
+
+static int smi330_st_precondition(struct smi330_data *data)
+{
+	int mask, acc_cfg;
+
+	mask = SMI330_CFG_MODE_MASK | SMI330_CFG_ODR_MASK;
+
+	acc_cfg = FIELD_PREP(SMI330_CFG_MODE_MASK, SMI330_MODE_NORMAL) |
+		  FIELD_PREP(SMI330_CFG_ODR_MASK, SMI330_ODR_100_HZ);
+
+	return smi330_set_sensor_config_reg(data, SMI330_ACCEL, mask, acc_cfg);
+}
+
+static int smi330_trigger_self_test(struct smi330_data *data)
+{
+	int ret;
+
+	ret = smi330_st_precondition(data);
+	if (ret)
+		return ret;
+
+	ret = smi330_disable_alt_conf_acc_gyr_mode(data);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, SMI330_CMD_REG, SMI330_CMD_SELF_TEST);
+}
+
+static int smi330_set_gyro_filter_coefficients(struct smi330_data *data)
+{
+	int ret;
+	s16 data_array[9];
+
+	data_array[0] = SMI330_SC_ST_VALUE_0;
+	data_array[1] = SMI330_SC_ST_VALUE_1;
+	data_array[2] = SMI330_SC_ST_VALUE_2;
+	data_array[3] = SMI330_SC_ST_VALUE_3;
+	data_array[4] = SMI330_SC_ST_VALUE_4;
+	data_array[5] = SMI330_SC_ST_VALUE_5;
+	data_array[6] = SMI330_SC_ST_VALUE_6;
+	data_array[7] = SMI330_SC_ST_VALUE_7;
+	data_array[8] = SMI330_SC_ST_VALUE_8;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+			   SMI330_GYRO_SC_ST_VALUES_EX_REG);
+	if (ret)
+		return ret;
+
+	return regmap_bulk_write(data->regmap, SMI330_FEATURE_DATA_TX_REG,
+				 data_array, ARRAY_SIZE(data_array));
+}
+
+static int smi330_set_self_test_mode(struct smi330_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+			   SMI330_ST_SELECT_EX_REG);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, SMI330_FEATURE_DATA_TX_REG,
+			    SMI330_ST_SELECT_ACC_GYR_MASK);
+}
+
+static int smi330_perform_self_test(struct smi330_data *data)
+{
+	int ret, acc_cfg, cfg_restore;
+	s16 data_array[9] = { 0 };
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+			   SMI330_GYRO_SC_ST_VALUES_EX_REG);
+	if (ret == 0)
+		ret = regmap_bulk_write(data->regmap,
+					SMI330_FEATURE_DATA_TX_REG, data_array,
+					ARRAY_SIZE(data_array));
+	if (ret == 0)
+		ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+				   SMI330_GYRO_SC_ST_VALUES_EX_REG);
+	if (ret == 0)
+		ret = regmap_bulk_read(data->regmap, SMI330_FEATURE_DATA_TX_REG,
+				       data_array, ARRAY_SIZE(data_array));
+
+	if (ret == 0 && (data_array[3] != SMI330_SC_ST_VALUE_3 &&
+			 (data_array[0] != SMI330_SC_ST_VALUE_0 ||
+			  data_array[1] != SMI330_SC_ST_VALUE_1 ||
+			  data_array[2] != SMI330_SC_ST_VALUE_2 ||
+			  data_array[4] != SMI330_SC_ST_VALUE_4 ||
+			  data_array[5] != SMI330_SC_ST_VALUE_5 ||
+			  data_array[6] != SMI330_SC_ST_VALUE_6 ||
+			  data_array[7] != SMI330_SC_ST_VALUE_7 ||
+			  data_array[8] != SMI330_SC_ST_VALUE_8))) {
+		ret = smi330_set_gyro_filter_coefficients(data);
+	}
+
+	if (ret == 0)
+		ret = smi330_set_self_test_mode(data);
+
+	/*
+	 * Save accel configurations in separate variable to
+	 * restore configuration independent from other errors.
+	 */
+	cfg_restore =
+		smi330_get_sensor_config_reg(data, SMI330_ACCEL, &acc_cfg);
+	ret = cfg_restore;
+
+	if (ret == 0)
+		ret = smi330_trigger_self_test(data);
+
+	if (ret == 0)
+		ret = smi330_get_st_result(data);
+
+	if (cfg_restore == 0)
+		/* Restore accel configurations */
+		ret = smi330_set_sensor_config_reg(data, SMI330_ACCEL,
+						   SMI330_CFG_MASK, acc_cfg);
+
+	return ret;
+}
+
+static int smi330_self_calib_select(struct smi330_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_DATA_ADDR_REG,
+			   SMI330_GYRO_SC_SELECT_EX_REG);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, SMI330_FEATURE_DATA_TX_REG,
+			    SMI330_GYRO_SC_SELECT_ALL_MASK);
+}
+
+static int smi330_self_calib_preconfig(struct smi330_data *data)
+{
+	int ret, acc_cfg;
+	int mask = SMI330_CFG_MODE_MASK | SMI330_CFG_ODR_MASK;
+
+	acc_cfg = FIELD_PREP(SMI330_CFG_MODE_MASK, SMI330_MODE_HIGH_PERF) |
+		  FIELD_PREP(SMI330_CFG_ODR_MASK, SMI330_ODR_100_HZ);
+
+	ret = smi330_set_sensor_config_reg(data, SMI330_ACCEL, mask, acc_cfg);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_ACCEL, SMI330_MODE,
+				       SMI330_MODE_SUSPEND, true);
+	if (ret)
+		return ret;
+
+	return smi330_set_sensor_config(data, SMI330_ALT_GYRO, SMI330_MODE,
+					SMI330_MODE_SUSPEND, true);
+}
+
+static void smi330_self_calib_restore_config(struct smi330_data *data,
+					     int accel_config,
+					     int accel_alt_config,
+					     int gyro_alt_config)
+{
+	smi330_set_sensor_config_reg(data, SMI330_ACCEL, SMI330_CFG_MASK,
+				     accel_config);
+
+	smi330_set_sensor_config_reg(data, SMI330_ALT_ACCEL, SMI330_CFG_MASK,
+				     accel_alt_config);
+
+	smi330_set_sensor_config_reg(data, SMI330_ALT_GYRO, SMI330_CFG_MASK,
+				     gyro_alt_config);
+}
+
+static int smi330_self_calibration(struct smi330_data *data,
+				   struct iio_dev *indio_dev)
+{
+	int ret, io1_data, acc_cfg, acc_alt_cfg, gyr_alt_cfg;
+
+	ret = regmap_read(data->regmap, SMI330_FEATURE_IO1_REG, &io1_data);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(SMI330_FEATURE_IO1_STATE_MASK, io1_data))
+		return -EBUSY;
+
+	ret = smi330_self_calib_select(data);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_sensor_config_reg(data, SMI330_ACCEL, &acc_cfg);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_sensor_config_reg(data, SMI330_ALT_ACCEL,
+					   &acc_alt_cfg);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_sensor_config_reg(data, SMI330_ALT_GYRO, &gyr_alt_cfg);
+	if (ret)
+		return ret;
+
+	ret = smi330_self_calib_preconfig(data);
+	if (ret)
+		goto out;
+
+	ret = regmap_write(data->regmap, SMI330_CMD_REG,
+			   SMI330_CMD_SELF_CALIBRATION);
+	if (ret)
+		goto out;
+
+	ret = regmap_read_poll_timeout(
+		data->regmap, SMI330_FEATURE_IO1_REG, io1_data,
+		FIELD_GET(SMI330_FEATURE_IO1_SC_COMPLETE_MASK, io1_data) == 1,
+		SMI330_FEAT_ENG_POLL, SMI330_FEAT_ENG_TIMEOUT);
+
+out:
+	smi330_self_calib_restore_config(data, acc_cfg, acc_alt_cfg,
+					 gyr_alt_cfg);
+	return ret;
+}
+
+static int smi330_enable_feature_engine(struct smi330_data *data)
+{
+	int ret, io1;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_IO2_REG,
+			   SMI330_FEATURE_IO2_STARTUP_CONFIG);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_IO_STATUS_REG,
+			   SMI330_FEATURE_IO_STATUS_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, SMI330_FEATURE_CTRL_REG,
+			   SMI330_FEATURE_CTRL_ENABLE);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(data->regmap, SMI330_FEATURE_IO1_REG,
+					io1,
+					FIELD_GET(SMI330_FEATURE_IO1_ERROR_MASK,
+						  io1) == 1,
+					SMI330_FEAT_ENG_POLL,
+					SMI330_FEAT_ENG_TIMEOUT);
+}
+
+static int smi330_enable_adv_feat(struct smi330_data *data, int mask, int val)
+{
+	int ret, io_status;
+
+	/* update advanced feature config */
+	ret = regmap_update_bits(data->regmap, SMI330_FEATURE_IO0_REG, mask,
+				 val);
+	if (ret)
+		return ret;
+
+	/* sync settings */
+	io_status = FIELD_PREP(SMI330_FEATURE_IO_STATUS_MASK, 1);
+	ret = regmap_write(data->regmap, SMI330_FEATURE_IO_STATUS_REG,
+			   io_status);
+	return ret;
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
+	if (ret)
+		return ret;
+
+	if (data->cfg.feat_irq != SMI330_INT_DISABLED)
+		ret = smi330_enable_feature_engine(data);
+
+	return ret;
+}
+
+static int smi330_fifo_handler(struct iio_dev *indio_dev)
+{
+	int ret, index, chan, i, fifo_frame_length, fifo_length, frame_count;
+	struct smi330_data *data = iio_priv(indio_dev);
+	s16 *iio_buffer_iter = data->buf;
+	s16 *fifo_iter = data->fifo;
+	s64 tsamp = data->cfg.odr_ns;
+	s64 timestamp;
+
+	/* Ignore if buffer disabled */
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	fifo_frame_length = smi330_get_fifo_frame_length(indio_dev);
+	fifo_length = smi330_get_fifo_length(data);
+	frame_count = fifo_length / fifo_frame_length;
+
+	if (data->last_timestamp != 0 && frame_count != 0)
+		tsamp = div_s64(data->current_timestamp - data->last_timestamp,
+				frame_count);
+
+	ret = regmap_noinc_read(data->regmap, SMI330_FIFO_DATA_REG, data->fifo,
+				fifo_length * sizeof(s16));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < frame_count; i++) {
+		index = 0;
+		fifo_iter = &data->fifo[i * fifo_frame_length];
+
+		iio_for_each_active_channel(indio_dev, chan) {
+			iio_buffer_iter[index++] = fifo_iter[chan];
+		}
+		timestamp =
+			data->current_timestamp - tsamp * (frame_count - i - 1);
+		iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
+						   timestamp);
+	}
+
+	data->last_timestamp = data->current_timestamp;
+
+	return 0;
+}
+
+static irqreturn_t smi330_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct smi330_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret, sample, chan;
+	int i = 0;
+
+	/* Ignore if buffer disabled */
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	if (data->cfg.op_mode == SMI330_FIFO) {
+		dev_warn(dev, "Can't use trigger when FIFO enabled\n");
+		return -EBUSY;
+	}
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
+	guard(mutex)(&data->lock);
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
+	if (FIELD_GET(SMI330_INT_STATUS_FWM_MASK, int_stat) ||
+	    FIELD_GET(SMI330_INT_STATUS_FFULL_MASK, int_stat)) {
+		ret = smi330_fifo_handler(indio_dev);
+		if (ret)
+			return IRQ_NONE;
+	}
+
+	if (FIELD_GET(SMI330_INT_STATUS_ACC_DRDY_MASK, int_stat) ||
+	    FIELD_GET(SMI330_INT_STATUS_GYR_DRDY_MASK, int_stat)) {
+		iio_trigger_poll_nested(data->trig);
+	}
+
+	if (FIELD_GET(SMI330_INT_STATUS_ANYMO_MASK, int_stat)) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_ROC,
+						  IIO_EV_DIR_RISING),
+			       data->current_timestamp);
+	}
+
+	if (FIELD_GET(SMI330_INT_STATUS_NOMO_MASK, int_stat)) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_ROC,
+						  IIO_EV_DIR_FALLING),
+			       data->current_timestamp);
+	}
+
+	if (FIELD_GET(SMI330_INT_STATUS_TILT_MASK, int_stat)) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_CHANGE,
+						  IIO_EV_DIR_EITHER),
+			       data->current_timestamp);
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
+	int ret, mask, val;
+
+	val = active_high ? SMI330_IO_INT_CTRL_LVL : 0;
+	val |= open_drain ? SMI330_IO_INT_CTRL_OD : 0;
+	val |= SMI330_IO_INT_CTRL_EN;
+
+	switch (irq_num) {
+	case SMI330_INT_1:
+		mask = SMI330_IO_INT_CTRL_INT1_MASK;
+		val = FIELD_PREP(mask, val);
+		break;
+	case SMI330_INT_2:
+		mask = SMI330_IO_INT_CTRL_INT2_MASK;
+		val = FIELD_PREP(mask, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, SMI330_IO_INT_CTRL_REG, mask,
+				 val);
+	if (ret)
+		return ret;
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
+	} else if (cfg->data_irq == SMI330_INT_1 ||
+		   cfg->feat_irq == SMI330_INT_1) {
+		return -ENODEV;
+	}
+
+	irq = fwnode_irq_get_byname(fwnode, "INT2");
+	if (irq > 0) {
+		ret = smi330_setup_irq(dev, indio_dev, irq, SMI330_INT_2);
+		if (ret)
+			return ret;
+	} else if (cfg->data_irq == SMI330_INT_2 ||
+		   cfg->feat_irq == SMI330_INT_2) {
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int smi330_hw_fifo_enable(struct iio_dev *indio_dev)
+{
+	int ret, cfg, chan;
+	int val = 0;
+	enum smi330_mode acc_mode = SMI330_MODE_SUSPEND;
+	enum smi330_mode gyr_mode = SMI330_MODE_SUSPEND;
+	struct smi330_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	data->last_timestamp = 0;
+
+	ret = smi330_get_sensor_config_reg(data, SMI330_ACCEL, &cfg);
+	if (ret)
+		return ret;
+
+	acc_mode = FIELD_GET(SMI330_CFG_MODE_MASK, cfg);
+	ret = smi330_get_sensor_config_reg(data, SMI330_GYRO, &cfg);
+	if (ret)
+		return ret;
+
+	gyr_mode = FIELD_GET(SMI330_CFG_MODE_MASK, cfg);
+
+	if (acc_mode == SMI330_MODE_LOW_POWER ||
+	    gyr_mode == SMI330_MODE_LOW_POWER) {
+		dev_warn(dev, "Fifo can't be enabled in low power mode");
+		return -EINVAL;
+	}
+
+	iio_for_each_active_channel(indio_dev, chan) {
+		switch (chan) {
+		case SMI330_SCAN_ACCEL_X:
+		case SMI330_SCAN_ACCEL_Y:
+		case SMI330_SCAN_ACCEL_Z:
+			val |= FIELD_PREP(SMI330_FIFO_CONF_ACC_MASK, 1);
+			break;
+		case SMI330_SCAN_GYRO_X:
+		case SMI330_SCAN_GYRO_Y:
+		case SMI330_SCAN_GYRO_Z:
+			val |= FIELD_PREP(SMI330_FIFO_CONF_GYR_MASK, 1);
+			break;
+		case SMI330_TEMP_OBJECT:
+			val |= FIELD_PREP(SMI330_FIFO_CONF_TEMP_MASK, 1);
+			break;
+		default:
+			break;
+		}
+	}
+
+	ret = regmap_update_bits(data->regmap, SMI330_FIFO_CONF_REG,
+				 SMI330_FIFO_CONF_MASK, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(SMI330_INT_MAP2_FIFO_WM_MASK, data->cfg.data_irq) |
+	      FIELD_PREP(SMI330_INT_MAP2_FIFO_FULL_MASK, data->cfg.data_irq);
+	ret = regmap_update_bits(data->regmap, SMI330_INT_MAP2_REG,
+				 SMI330_INT_MAP2_FIFO_MASK, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, SMI330_FIFO_CTRL_REG,
+			   SMI330_FIFO_CTRL_FLUSH_MASK);
+	if (ret)
+		return ret;
+
+	data->cfg.op_mode = SMI330_FIFO;
+
+	return 0;
+}
+
+static int smi330_hw_fifo_disable(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = regmap_update_bits(data->regmap, SMI330_FIFO_CONF_REG,
+				 SMI330_FIFO_CONF_MASK, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, SMI330_INT_MAP2_REG,
+				 SMI330_INT_MAP2_FIFO_MASK, 0);
+	if (ret)
+		return ret;
+
+	data->cfg.op_mode = SMI330_IDLE;
+
+	return 0;
+}
+
+static int smi330_hwfifo_set_watermark(struct iio_dev *indio_dev,
+				       unsigned int val)
+{
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	unsigned int fifo_frame_length =
+		smi330_get_fifo_frame_length(indio_dev);
+	unsigned int abs_max_wm = (SMI330_FIFO_MAX_LENGTH - 1);
+	unsigned int max_wm = abs_max_wm - 3 * max(fifo_frame_length, 3u);
+	unsigned int watermark = min(fifo_frame_length * val, max_wm);
+
+	return regmap_write(data->regmap, SMI330_FIFO_WATERMARK_REG, watermark);
+}
+
+static int smi330_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	if (data->cfg.data_irq != SMI330_INT_DISABLED)
+		return smi330_hw_fifo_enable(indio_dev);
+
+	return 0;
+}
+
+static int smi330_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	/* Don't break the current interrupt thread handler */
+	mutex_lock(&data->lock);
+
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	if (data->cfg.data_irq != SMI330_INT_DISABLED)
+		return smi330_hw_fifo_disable(indio_dev);
+
+	return 0;
+}
+
+static int smi330_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static int smi330_set_drdy_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	int val;
+	struct smi330_data *data = iio_trigger_get_drvdata(trig);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	if (data->cfg.op_mode == SMI330_FIFO) {
+		dev_warn(dev, "Can't set trigger when FIFO enabled\n");
+		return -EBUSY;
+	}
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
+static int smi330_read_odr_reg_value(struct smi330_data *data,
+				     enum smi330_odr *odr)
+{
+	int ret, cfg, acc_odr, gyr_odr;
+
+	ret = smi330_get_sensor_config_reg(data, SMI330_ACCEL, &cfg);
+	if (ret)
+		return ret;
+	acc_odr = FIELD_GET(SMI330_CFG_ODR_MASK, cfg);
+
+	ret = smi330_get_sensor_config_reg(data, SMI330_GYRO, &cfg);
+	if (ret)
+		return ret;
+	gyr_odr = FIELD_GET(SMI330_CFG_ODR_MASK, cfg);
+
+	if (acc_odr == gyr_odr)
+		*odr = acc_odr;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t alt_odr_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	int ret, acc_odr, gyr_odr;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_get_sensor_config(data, SMI330_ALT_ACCEL, SMI330_ODR,
+				       &acc_odr);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_sensor_config(data, SMI330_ALT_GYRO, SMI330_ODR,
+				       &gyr_odr);
+	if (ret)
+		return ret;
+
+	if (acc_odr == gyr_odr)
+		return snprintf(buf, PAGE_SIZE, "%d\n", acc_odr);
+
+	return snprintf(buf, PAGE_SIZE,
+			"ODR read failed, potential ACC and GYRO mismatch\n");
+}
+
+static ssize_t alt_status_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int ret, status;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, SMI330_ALT_STATUS_REG, &status);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", status);
+}
+
+static ssize_t alt_acc_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int ret, mode;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_get_sensor_config(data, SMI330_ALT_ACCEL, SMI330_MODE,
+				       &mode);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t alt_acc_avg_num_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	int ret, avg_num;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_get_sensor_config(data, SMI330_ALT_ACCEL, SMI330_AVG_NUM,
+				       &avg_num);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", avg_num);
+}
+
+static ssize_t alt_gyr_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int ret, mode;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_get_sensor_config(data, SMI330_ALT_GYRO, SMI330_MODE,
+				       &mode);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t alt_gyr_avg_num_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	int ret, avg_num;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_get_sensor_config(data, SMI330_ALT_GYRO, SMI330_AVG_NUM,
+				       &avg_num);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", avg_num);
+}
+
+static ssize_t hwfifo_watermark_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int ret, watermark;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, SMI330_FIFO_WATERMARK_REG, &watermark);
+	if (ret)
+		return ret;
+
+	return snprintf(buf, PAGE_SIZE, "%ld\n",
+			watermark & SMI330_FIFO_WATERMARK_MASK);
+}
+
+static ssize_t hwfifo_watermark_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", 1);
+}
+
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", SMI330_FIFO_MAX_LENGTH - 1);
+}
+
+static ssize_t hwfifo_fill_level_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	int fill_level = smi330_get_fifo_length(data);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", fill_level);
+}
+
+static ssize_t hwfifo_enabled_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	if (data->cfg.op_mode == SMI330_FIFO)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t control_auto_op_mode_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 op_mode;
+
+	ret = kstrtou16(buf, 10, &op_mode);
+	if (ret)
+		return ret;
+
+	if (op_mode != SMI330_AUTO_OP_EN_ACC &&
+	    op_mode != SMI330_AUTO_OP_EN_GYR &&
+	    op_mode != SMI330_AUTO_OP_EN_ALL &&
+	    op_mode != SMI330_AUTO_OP_DISABLE) {
+		return -EINVAL;
+	}
+
+	ret = smi330_config_auto_op_mode(data, op_mode);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t config_user_overwrite_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 user_overwrite;
+
+	ret = kstrtou16(buf, 10, &user_overwrite);
+	if (ret)
+		return ret;
+
+	if (user_overwrite != SMI330_AUTO_OP_RESET &&
+	    user_overwrite != SMI330_AUTO_OP_SET) {
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, SMI330_ALT_CONF_REG,
+				 SMI330_ALT_CONF_RST_CONF_EN_MASK,
+				 FIELD_PREP(SMI330_ALT_CONF_RST_CONF_EN_MASK,
+					    user_overwrite));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t set_auto_op_mode_cond_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 option;
+
+	ret = kstrtou16(buf, 10, &option);
+	if (ret)
+		return ret;
+
+	switch (option) {
+	case SMI330_AUTO_OP_USER_A:
+		ret = smi330_auto_op_cond(data, SMI330_AUTO_OP_CONFIG_USER,
+					  A_NO_MOTION);
+		break;
+
+	case SMI330_AUTO_OP_USER_B:
+		ret = smi330_auto_op_cond(data, SMI330_AUTO_OP_CONFIG_USER,
+					  B_ANY_MOTION);
+		break;
+
+	case SMI330_AUTO_OP_USER_H:
+		ret = smi330_auto_op_cond(data, SMI330_AUTO_OP_CONFIG_USER,
+					  H_TILT_DETECTION);
+		break;
+
+	case SMI330_AUTO_OP_ALT_A:
+		ret = smi330_auto_op_cond(data, SMI330_AUTO_OP_CONFIG_ALT,
+					  A_NO_MOTION);
+		break;
+
+	case SMI330_AUTO_OP_ALT_B:
+		ret = smi330_auto_op_cond(data, SMI330_AUTO_OP_CONFIG_ALT,
+					  B_ANY_MOTION);
+		break;
+
+	case SMI330_AUTO_OP_ALT_H:
+		ret = smi330_auto_op_cond(data, SMI330_AUTO_OP_CONFIG_ALT,
+					  H_TILT_DETECTION);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t alt_odr_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 odr;
+
+	ret = kstrtou16(buf, 10, &odr);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_ACCEL, SMI330_ODR, odr,
+				       false);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_GYRO, SMI330_ODR, odr,
+				       false);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t alt_acc_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 mode;
+
+	ret = kstrtou16(buf, 10, &mode);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_ACCEL, SMI330_MODE,
+				       mode, false);
+	if (ret)
+		return ret;
+
+	data->savestate.alt_acc_pwr = mode;
+
+	return count;
+}
+
+static ssize_t alt_acc_avg_num_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 avg_num;
+
+	ret = kstrtou16(buf, 10, &avg_num);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_ACCEL, SMI330_AVG_NUM,
+				       avg_num, false);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t alt_gyr_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 mode;
+
+	ret = kstrtou16(buf, 10, &mode);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_GYRO, SMI330_MODE, mode,
+				       false);
+	if (ret)
+		return ret;
+
+	data->savestate.alt_gyr_pwr = mode;
+
+	return count;
+}
+
+static ssize_t alt_gyr_avg_num_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+	u16 avg_num;
+
+	ret = kstrtou16(buf, 10, &avg_num);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_GYRO, SMI330_AVG_NUM,
+				       avg_num, false);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t self_test_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_perform_self_test(data);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t self_cal_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_self_calibration(data, indio_dev);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t soft_reset_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_soft_reset(data);
+	if (ret)
+		return ret;
+
+	ret = smi330_dev_init(data);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static int smi330_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	int ret, cfg;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, SMI330_FEATURE_IO0_REG, &cfg);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_ROC:
+		if (dir == IIO_EV_DIR_RISING) {
+			switch (chan->channel2) {
+			case IIO_MOD_X:
+				return FIELD_GET(SMI330_FEATURE_IO0_ANYMO_X_EN_MASK,
+						 cfg);
+			case IIO_MOD_Y:
+				return FIELD_GET(SMI330_FEATURE_IO0_ANYMO_Y_EN_MASK,
+						 cfg);
+			case IIO_MOD_Z:
+				return FIELD_GET(SMI330_FEATURE_IO0_ANYMO_Z_EN_MASK,
+						 cfg);
+			default:
+				return 0;
+			}
+		}
+		if (dir == IIO_EV_DIR_FALLING) {
+			switch (chan->channel2) {
+			case IIO_MOD_X:
+				return FIELD_GET(SMI330_FEATURE_IO0_NOMO_X_EN_MASK,
+						 cfg);
+			case IIO_MOD_Y:
+				return FIELD_GET(SMI330_FEATURE_IO0_NOMO_Y_EN_MASK,
+						 cfg);
+			case IIO_MOD_Z:
+				return FIELD_GET(SMI330_FEATURE_IO0_NOMO_Z_EN_MASK,
+						 cfg);
+			default:
+				return 0;
+			}
+		}
+		return 0;
+	case IIO_EV_TYPE_CHANGE:
+		if (dir == IIO_EV_DIR_EITHER)
+			return FIELD_GET(SMI330_FEATURE_IO0_TILT_EN_MASK, cfg);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static int smi330_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, bool state)
+{
+	int ret, int_mask, int_val, en_mask, en_val;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_ROC:
+		if (dir == IIO_EV_DIR_RISING) {
+			switch (chan->channel2) {
+			case IIO_MOD_X:
+				en_mask = SMI330_FEATURE_IO0_ANYMO_X_EN_MASK;
+				en_val = FIELD_PREP(en_mask, state);
+				break;
+			case IIO_MOD_Y:
+				en_mask = SMI330_FEATURE_IO0_ANYMO_Y_EN_MASK;
+				en_val = FIELD_PREP(en_mask, state);
+				break;
+			case IIO_MOD_Z:
+				en_mask = SMI330_FEATURE_IO0_ANYMO_Z_EN_MASK;
+				en_val = FIELD_PREP(en_mask, state);
+				break;
+			default:
+				break;
+			}
+			int_mask = SMI330_INT_MAP1_ANYMO_MASK;
+			int_val = FIELD_PREP(int_mask, data->cfg.feat_irq);
+			break;
+		} else if (dir == IIO_EV_DIR_FALLING) {
+			switch (chan->channel2) {
+			case IIO_MOD_X:
+				en_mask = SMI330_FEATURE_IO0_NOMO_X_EN_MASK;
+				en_val = FIELD_PREP(en_mask, state);
+				break;
+			case IIO_MOD_Y:
+				en_mask = SMI330_FEATURE_IO0_NOMO_Y_EN_MASK;
+				en_val = FIELD_PREP(en_mask, state);
+				break;
+			case IIO_MOD_Z:
+				en_mask = SMI330_FEATURE_IO0_NOMO_Z_EN_MASK;
+				en_val = FIELD_PREP(en_mask, state);
+				break;
+			default:
+				break;
+			}
+			int_mask = SMI330_INT_MAP1_NOMO_MASK;
+			int_val = FIELD_PREP(int_mask, data->cfg.feat_irq);
+			break;
+		}
+		return -EINVAL;
+	case IIO_EV_TYPE_CHANGE:
+		if (dir == IIO_EV_DIR_EITHER) {
+			en_mask = SMI330_FEATURE_IO0_TILT_EN_MASK;
+			en_val = FIELD_PREP(en_mask, state);
+			int_mask = SMI330_INT_MAP1_TILT_MASK;
+			int_val = FIELD_PREP(int_mask, data->cfg.feat_irq);
+			break;
+		}
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smi330_enable_adv_feat(data, en_mask, en_val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, SMI330_INT_MAP1_REG, int_mask,
+				  int_val);
+}
+
+static int smi330_get_event_reg_mask(enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int *reg,
+				     int *mask)
+{
+	switch (type) {
+	case IIO_EV_TYPE_ROC:
+		if (dir == IIO_EV_DIR_RISING) {
+			switch (info) {
+			case IIO_EV_INFO_PERIOD:
+				*reg = SMI330_ANYMO_3_EX_REG;
+				*mask = SMI330_MOTION3_DURATION_MASK;
+				return 0;
+			case IIO_EV_INFO_VALUE:
+				*reg = SMI330_ANYMO_1_EX_REG;
+				*mask = SMI330_MOTION1_SLOPE_THRES_MASK;
+				return 0;
+			case IIO_EV_INFO_HYSTERESIS:
+				*reg = SMI330_ANYMO_2_EX_REG;
+				*mask = SMI330_MOTION2_HYSTERESIS_MASK;
+				return 0;
+			case IIO_EV_INFO_TIMEOUT:
+				*reg = SMI330_ANYMO_3_EX_REG;
+				*mask = SMI330_MOTION3_WAIT_TIME_MASK;
+				return 0;
+			default:
+				return -EINVAL;
+			}
+		} else if (dir == IIO_EV_DIR_FALLING) {
+			switch (info) {
+			case IIO_EV_INFO_PERIOD:
+				*reg = SMI330_NOMO_3_EX_REG;
+				*mask = SMI330_MOTION3_DURATION_MASK;
+				return 0;
+			case IIO_EV_INFO_VALUE:
+				*reg = SMI330_NOMO_1_EX_REG;
+				*mask = SMI330_MOTION1_SLOPE_THRES_MASK;
+				return 0;
+			case IIO_EV_INFO_HYSTERESIS:
+				*reg = SMI330_NOMO_2_EX_REG;
+				*mask = SMI330_MOTION2_HYSTERESIS_MASK;
+				return 0;
+			case IIO_EV_INFO_TIMEOUT:
+				*reg = SMI330_NOMO_3_EX_REG;
+				*mask = SMI330_MOTION3_WAIT_TIME_MASK;
+				return 0;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_CHANGE:
+		if (dir == IIO_EV_DIR_EITHER) {
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				*reg = SMI330_TILT_1_EX_REG;
+				*mask = SMI330_TILT1_MIN_ANGLE_MASK;
+				return 0;
+			case IIO_EV_INFO_PERIOD:
+				*reg = SMI330_TILT_1_EX_REG;
+				*mask = SMI330_TILT1_SEGMENT_SIZE_MASK;
+				return 0;
+			case IIO_EV_INFO_LOW_PASS_FILTER_3DB:
+				*reg = SMI330_TILT_2_EX_REG;
+				*mask = SMI330_TILT2_BETA_ACC_MEAN_MASK;
+				return 0;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smi330_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	int ret, reg, mask, config;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_get_event_reg_mask(type, dir, info, &reg, &mask);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_regs_dma(reg, &config, data);
+	if (ret)
+		return ret;
+
+	/* FIELD_GET is not possible with non-const mask */
+	*val = ((config) & (mask)) >> (__builtin_ffs(mask) - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int smi330_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val, int val2)
+{
+	int ret, reg, mask, config;
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_get_event_reg_mask(type, dir, info, &reg, &mask);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_regs_dma(reg, &config, data);
+	if (ret)
+		return ret;
+
+	/* FIELD_PREP is not possible with non-const mask */
+	config = ((val << (__builtin_ffs(mask) - 1)) & mask) | (config & ~mask);
+
+	return smi330_set_regs_dma(reg, config, data);
+}
+
+static int smi330_suspend(struct device *dev)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = iio_device_suspend_triggering(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ACCEL, SMI330_MODE,
+				       SMI330_MODE_SUSPEND, true);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_GYRO, SMI330_MODE,
+				       SMI330_MODE_SUSPEND, true);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_ACCEL, SMI330_MODE,
+				       SMI330_MODE_SUSPEND, true);
+	if (ret)
+		return ret;
+
+	return smi330_set_sensor_config(data, SMI330_ALT_GYRO, SMI330_MODE,
+					SMI330_MODE_SUSPEND, true);
+}
+
+static int smi330_resume(struct device *dev)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct smi330_data *data = iio_priv(indio_dev);
+
+	ret = smi330_set_sensor_config(data, SMI330_ACCEL, SMI330_MODE,
+				       data->savestate.acc_pwr, true);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_GYRO, SMI330_MODE,
+				       data->savestate.gyr_pwr, true);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_ACCEL, SMI330_MODE,
+				       data->savestate.alt_acc_pwr, true);
+	if (ret)
+		return ret;
+
+	ret = smi330_set_sensor_config(data, SMI330_ALT_GYRO, SMI330_MODE,
+				       data->savestate.alt_gyr_pwr, true);
+	if (ret)
+		return ret;
+
+	if (data->cfg.op_mode == SMI330_FIFO) {
+		ret = regmap_write(data->regmap, SMI330_FIFO_CTRL_REG,
+				   SMI330_FIFO_CTRL_FLUSH_MASK);
+		if (ret)
+			return ret;
+	}
+
+	return iio_device_resume_triggering(indio_dev);
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(smi330_pm_ops, smi330_suspend, smi330_resume);
+
+static IIO_DEVICE_ATTR_WO(control_auto_op_mode, 0);
+static IIO_DEVICE_ATTR_WO(set_auto_op_mode_cond, 0);
+static IIO_DEVICE_ATTR_WO(config_user_overwrite, 0);
+
+static IIO_DEVICE_ATTR_WO(self_test, 0);
+static IIO_DEVICE_ATTR_WO(self_cal, 0);
+static IIO_DEVICE_ATTR_WO(soft_reset, 0);
+
+static IIO_DEVICE_ATTR_RW(alt_acc_mode, 0);
+static IIO_DEVICE_ATTR_RW(alt_acc_avg_num, 0);
+static IIO_DEVICE_ATTR_RW(alt_gyr_mode, 0);
+static IIO_DEVICE_ATTR_RW(alt_gyr_avg_num, 0);
+static IIO_DEVICE_ATTR_RW(alt_odr, 0);
+static IIO_DEVICE_ATTR_RO(alt_status, 0);
+
+static struct attribute *smi330_event_attributes[] = {
+	&iio_dev_attr_control_auto_op_mode.dev_attr.attr,
+	&iio_dev_attr_set_auto_op_mode_cond.dev_attr.attr,
+	&iio_dev_attr_config_user_overwrite.dev_attr.attr,
+	&iio_dev_attr_self_test.dev_attr.attr,
+	&iio_dev_attr_self_cal.dev_attr.attr,
+	&iio_dev_attr_soft_reset.dev_attr.attr,
+	&iio_dev_attr_alt_acc_mode.dev_attr.attr,
+	&iio_dev_attr_alt_acc_avg_num.dev_attr.attr,
+	&iio_dev_attr_alt_gyr_mode.dev_attr.attr,
+	&iio_dev_attr_alt_gyr_avg_num.dev_attr.attr,
+	&iio_dev_attr_alt_odr.dev_attr.attr,
+	&iio_dev_attr_alt_status.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group smi330_event_attribute_group = {
+	.attrs = smi330_event_attributes,
+};
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_fill_level, 0);
+
+static const struct iio_dev_attr *smi330_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_watermark_min, &iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,	    &iio_dev_attr_hwfifo_enabled,
+	&iio_dev_attr_hwfifo_fill_level,    NULL,
+};
+
+static const struct iio_buffer_setup_ops smi330_buffer_ops = {
+	.postenable = smi330_buffer_postenable,
+	.predisable = smi330_buffer_predisable,
+	.postdisable = smi330_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops smi330_trigger_ops = {
+	.set_trigger_state = &smi330_set_drdy_trigger_state,
+};
+
+static struct iio_info smi330_info = {
+	.read_event_config = smi330_read_event_config,
+	.read_event_value = smi330_read_event_value,
+	.write_event_config = smi330_write_event_config,
+	.write_event_value = smi330_write_event_value,
+	.read_avail = smi330_read_avail,
+	.read_raw = smi330_read_raw,
+	.write_raw = smi330_write_raw,
+	.write_raw_get_fmt = smi330_write_raw_get_fmt,
+	.hwfifo_set_watermark = smi330_hwfifo_set_watermark,
+};
+
+static int smi330_dev_init(struct smi330_data *data)
+{
+	int ret, chip_id, val;
+	enum smi330_odr odr;
+	struct device *dev = regmap_get_device(data->regmap);
+	struct smi330_cfg *cfg = &data->cfg;
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
+	ret = smi330_read_odr_reg_value(data, &odr);
+	if (ret)
+		return ret;
+
+	ret = smi330_get_odr_ns(odr, &cfg->odr_ns);
+	return ret;
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
+	mutex_init(&data->lock);
+
+	if (IS_ENABLED(CONFIG_SMI330_IRQ_DATA_INT1))
+		data->cfg.data_irq = SMI330_INT_1;
+	else if (IS_ENABLED(CONFIG_SMI330_IRQ_DATA_INT2))
+		data->cfg.data_irq = SMI330_INT_2;
+	else
+		data->cfg.data_irq = SMI330_INT_DISABLED;
+
+	if (IS_ENABLED(CONFIG_SMI330_IRQ_ADV_FEAT_INT1))
+		data->cfg.feat_irq = SMI330_INT_1;
+	else if (IS_ENABLED(CONFIG_SMI330_IRQ_ADV_FEAT_INT2))
+		data->cfg.feat_irq = SMI330_INT_2;
+	else
+		data->cfg.feat_irq = SMI330_INT_DISABLED;
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
+	data->savestate.acc_pwr = SMI330_MODE_SUSPEND;
+	data->savestate.gyr_pwr = SMI330_MODE_SUSPEND;
+	data->savestate.alt_acc_pwr = SMI330_MODE_SUSPEND;
+	data->savestate.alt_gyr_pwr = SMI330_MODE_SUSPEND;
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
+		 * Set default operation mode to data ready,
+		 * remove the trigger if you want to use HW fifo.
+		 */
+		indio_dev->trig = iio_trigger_get(data->trig);
+	}
+
+	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+						  iio_pollfunc_store_time,
+						  smi330_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  &smi330_buffer_ops,
+						  smi330_fifo_attributes);
+	if (ret)
+		return dev_err_probe(dev, ret, "IIO buffer setup failed\n");
+
+	if (data->cfg.feat_irq != SMI330_INT_DISABLED)
+		smi330_info.event_attrs = &smi330_event_attribute_group;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Register IIO device failed\n");
+
+	return 0;
+}
+
+MODULE_AUTHOR("Roman Huber <roman.huber@de.bosch.com>");
+MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
+MODULE_DESCRIPTION("Bosch SMI330 driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/iio/imu/smi330/smi330_i2c.c b/drivers/iio/imu/smi330/smi330_i2c.c
new file mode 100644
index 00000000000..42bfc01389b
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_i2c.c
@@ -0,0 +1,140 @@
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
+#define SMI330_I2C_MAX_RX_BUFFER_SIZE (NUM_DUMMY_BYTES + SMI330_FIFO_SIZE)
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
+		    .pm = pm_sleep_ptr(&smi330_pm_ops),
+	},
+};
+module_i2c_driver(smi330_i2c_driver);
diff --git a/drivers/iio/imu/smi330/smi330_spi.c b/drivers/iio/imu/smi330/smi330_spi.c
new file mode 100644
index 00000000000..833732ae281
--- /dev/null
+++ b/drivers/iio/imu/smi330/smi330_spi.c
@@ -0,0 +1,77 @@
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
+		    .pm = pm_sleep_ptr(&smi330_pm_ops),
+	},
+};
+module_spi_driver(smi330_spi_driver);
-- 
2.34.1


