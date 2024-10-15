Return-Path: <linux-iio+bounces-10611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B099E2A9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80951F24C18
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566331D9669;
	Tue, 15 Oct 2024 09:21:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2128.outbound.protection.outlook.com [40.107.239.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A131BE854;
	Tue, 15 Oct 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984085; cv=fail; b=oKhL7oaMuASiQnODFnnfWFNjqf+U76RXJeofOpkgNbVWpoH5d1ZPPaNeDSj3Oynp0ishratbvBmGJnTBqlCC5ybdghGeCkJy5YsxI81WazxfG8srGQqLr48nFl2u10G9Bzumnh+OhkiJLlCGqucPkKYcKVm1YwYq3MIGJyMoeYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984085; c=relaxed/simple;
	bh=hweBPPP8kne6WmL5v9TJLsYG77EGLwnU9nX/6lOTCjw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jcK7rXvIrtvZ31w1FHBdqfWqKHcq8b8Ev6LcL9AhGwJaS6E1XUTZkaU0u+pqSXqE4UFo09qndUqXXYunJqKsykS6VLqaEpvbtrDj2Bw3tkI5wtTVYX12ISu0KY8UfcHZIzvcoGgV9eKeezHAVqylsoUE8T9NEuGOfnjbc+rJOKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozXoCpC59dTSX+aJ0r38GW76M+nUeu4yRiNLymWfgtC8xBbtiG8opTp50njsmRurQhf7kctAZj1bjTugXxW3kaHXn187gkSPE5EaI8ycfuywZtN/G73K3reUmde20W45du4LpwQwpXKop0YNsBBYQf6DnBwb4J936VG3rsKJBhM0VwqrBl15HdiSrghPEngeRCMDqBTL/KD12qg7ImHEmQhM1QFmnesX7+MVdQYU1c8g3i9iBFIlQIP9AFWy84IZ/P6yMfX9s+vSx8ozktQk/ir191ymdmkhIa7XgyFxygRntWq3V0Ue14dxa8TuKJ29MFnzxrmrc7c/Z+MKLO9ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZZxn1IuFFURrZ9wNLJ3GT6she6wzTsqDjNPafep0vU=;
 b=rbvQbUm7tlFb38oWf2DvtRaSbtZLCzn74VDUXW0BkrI3C2S61wblhmn7gUFL2o+iXpDKzH9Ucdd3wUvi+mWMr1NodIKVwmWUPDlFdNXmt1bqOA5Xcfndtjay11NmUjn1mzdnF2rijRor3Yn6DbzOLESm0WENHsB3Uy6/UBNTNq4c0OfJo9iSnLigbMOByKoe5HqvKi7/7Mhg+Y+KCfEeLOoJkZxo26+KCQ51y9tnhl9lrstnvl3Wyug2H+dMkgjX2z5Y+MW2jAhANi9ANOStu6w9YHe51rRmkqWgNRBgqOT4Cgs3Gi/nj7Q1+52FhZ7KefqONIHHaDYNKlukyjIk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB0995.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 09:21:18 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:21:17 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: jic23@kernel.org,
	jmaneyrol@invensense.com,
	lars@metafoo.de
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
Date: Tue, 15 Oct 2024 14:50:03 +0530
Message-ID: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::21) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN0P287MB0995:EE_
X-MS-Office365-Filtering-Correlation-Id: efdebc33-5285-4b84-9456-08dcecfab98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BmHChfCaZ0X3kniTegVSAd4WJcUWyNo7bFkhD7WGEQNJ/YlSo8r6DYH7qaV8?=
 =?us-ascii?Q?JMzulV1tZDRNjfb63RRb/pCUyeIqO4brqEq62/liegXNkry6nvIQb04HqClm?=
 =?us-ascii?Q?xEbDu3PaszE4aAgg8ChKr3wpqIyGLsOZQj5+oCC4DKGn/qztF35dzQ9ka5r2?=
 =?us-ascii?Q?ugRzAUco6DkztjcMjhLK5CcS+ci9hyUx3b4agjMlAv3KmNwRSRx8nhrlUAjS?=
 =?us-ascii?Q?7C0Juo94RgYa62E3q88OG0gExKX0SylkVvK7visllp+1qKYP5uOHVD4HP+mg?=
 =?us-ascii?Q?/X+bA8M/YLro4otDA5fLDi+JiGeZVy8bfm9t8SFBlCeu3894OKQkw+cVOB4x?=
 =?us-ascii?Q?JVy8HP0GE0Qkl0a53mG0GAvr5Ofv2OxSRN+RrmULobgkXVAoyaazwu7+6TY+?=
 =?us-ascii?Q?VgWIu1E94JaEQwc102xwQrro9ltXQbVKfLt//na1R1Jf0bNzxEHiGoUVgEbz?=
 =?us-ascii?Q?PnbSXmaKTlCB/tuOgpVrqQX84SAHZN1Gyga4QF28PONkxfASCh67znpFFHvm?=
 =?us-ascii?Q?hRDZv4Bv4dNz69uuqKicIrRXsbpPZ2GT4SPULXtdF7g1hAvoKU6aH8uh8trw?=
 =?us-ascii?Q?xrUPG9dTcEuyI44HgsRpq2Dfizl0Yg87dRuZn7Y4IGwmtqM95Y2Zf4gXTY5m?=
 =?us-ascii?Q?hOUMm7ctl9nE/hi6GaKg1wILpIA9XExBRxvFaUhMREd7t6WT5PIR+JfIfn5H?=
 =?us-ascii?Q?Fkuj4b2Y66iKrkl+ek3KrPaaIqHTHGrZSypzHZ8zu1eFVHmr9qGTLWrDx20b?=
 =?us-ascii?Q?vEMMjALl/1UD0RGdEIoVMncP3CleQ/chVLn7Eo5YOIITrVoRNB/iMco36iik?=
 =?us-ascii?Q?SV+eYmLThvj1YXu/Kp6Dq2Z3OR9jRu3CQdVKkCFMKcX05YfV97DCtSYCgVIK?=
 =?us-ascii?Q?PXHlZT8iIUvjInpD4M0Y5uMgbePoxUdjJwWCm8oHu5bcigefHqDK7vxmB18v?=
 =?us-ascii?Q?aWXTJ4Ipsv2NJGa0bI3yBXbdbkBvmYGDRUsyg4ct130W9Jxov5wKBfGhkd8g?=
 =?us-ascii?Q?y5bJumqDw4fDV0S9hWXchC3YBNv6egW35d/BtZNFahtu6eADNmGHyczNA4FP?=
 =?us-ascii?Q?BMVKIB3BGIljAWJFf1cr71qw3Li++fNzp7u03IHCaUxMoNTlJzbM6jbPmKwL?=
 =?us-ascii?Q?9RcLRHdZOxxhGWFLsGf3znd11wuWtTg5IyOHjeg1jmg9fRkga5Ii3Gg3KLAJ?=
 =?us-ascii?Q?9xCgLLD5BwM0D8amENY8DdTyNbRmTvta5D2xjyoS13GcZ7nIXuAqPUKcCFBk?=
 =?us-ascii?Q?5kGldHMtfhA0iOOT4p4QcR1WWHXVM29AkC08pZSb5Nsc0ZFp9Zx+2QkEBqzO?=
 =?us-ascii?Q?3NwtFw4jp2if6AKbjstlb9QqfIYoiOzSvIy7hnQ4cBL8RbUxa137lbtsFNY9?=
 =?us-ascii?Q?hdh91QM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(3613699012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HoSW4pjUy2ndQj8Fgulgl5IDFJzuwVlva9D3LtEBLVHU8D80HhRmS6Lg5eM?=
 =?us-ascii?Q?qTJ9G/blVTdaSJzSHIY5ZZQL3BATdvHsfLtqmCI6ojrix8RosY94j/yPTywn?=
 =?us-ascii?Q?48+9+ygUUE52dZTiY5o+ajl+UgYj33WGVBgZx7reZ360nJ8YEuxrSGKFS7Ay?=
 =?us-ascii?Q?/eu25qYWlHMNe1cTdLGXeqSZzRbFDdr8aQ9ZFpHmiuCyiOcrCEhIyXZ69mjw?=
 =?us-ascii?Q?BB9FVLNRQEpLKUodgZHRUA1317qB6G+cNnuTogq3++pIH3VHX4v2Uho3B7jK?=
 =?us-ascii?Q?hQkT01e32vJWr5FvtnAqmiOi8pEK9ucovWaxT5Y8/881qiapLscoyyaWZiVd?=
 =?us-ascii?Q?TV9MdMWYCUzNBOuPbsGfbBZPP+fdICE8zkgZSFHek4ta7Cryg+rx9r1DmhS9?=
 =?us-ascii?Q?e/jBoK3rGhAdviasnLCyevoAfBACULrR5p2VubtCT4LE8VpD/uV286/QwG+O?=
 =?us-ascii?Q?IGiESscXpR1TbLU28wt14dd2QYxUGz57GdaOQPfjJQ5NLSsY1Xh+oUopYgHx?=
 =?us-ascii?Q?7qL2aexZJVPSzJdc2DylW8nBs/Yv/rRFNuV+a2aapfQTA8mM74RdONQtakfV?=
 =?us-ascii?Q?R+DvlTchYTtGYIULl0lL1gvyQQ81tlzRTR2vP5x8ZdMlcU4XetcmSyspV48M?=
 =?us-ascii?Q?QcniwZGkv2Uo37JvPKymZ2W6oZ6oVn7H6iZbASZqsAhYiCXBaK78fydiGVl5?=
 =?us-ascii?Q?yj1Uym/bN8zZ3h5vfU1mtsrNo+A5GcjAqS30NuHMNCtUUuQQfYpjpycZVEHn?=
 =?us-ascii?Q?Ei2c0RHdZUyUbsHgT/XVAqR3I/DzaKJ5cdhTQi3jF0RaXMes53HT6fCy3w1k?=
 =?us-ascii?Q?G5rb+/Bzcd/h4YYJNx5CJr4J6FOFRlxpEQmWROiwPbS80toJeNrS/62BYMBz?=
 =?us-ascii?Q?o3Z1e2GirAFsVokYWzRIlOfisB2ddcQgulPITmbLn2d/+CD4yFLATkLHOjdQ?=
 =?us-ascii?Q?6sqV+bwuAntjqKyucolrA4YYv9r6IaaYucocvVopAgKyoSgRqIoRC4IBS/Dh?=
 =?us-ascii?Q?Eod1FEpPaxLntL4SVXnetX3S+AqMfVu2uv4sGCGuxa2O3AZZWc03ytJlo8e5?=
 =?us-ascii?Q?/p4W0LKSg9D8qWkqHHN26//WMRFjf36O4/p38halZbnk9OD1FyyuygsBjE7L?=
 =?us-ascii?Q?7q2o6k7Io7vCnux8Z77V5JoiE2RZapCcNintiKvN8dAruxttADuWax6hkHln?=
 =?us-ascii?Q?/TMlg3Bw2CEZLme9e6KRg9QHSlcFJ5Vha4EnGGQqPcJlT0DBuLv7k2jdVKQE?=
 =?us-ascii?Q?eL7KITB0FrKFGCBXSNEWDdJ96p1rXqkGo7PXRJTEQ8Bv5zn/1O8YjkDP0/VK?=
 =?us-ascii?Q?Rpif08bQuhAMHcPsFyLh7F7gD9h54hionYgAIP7dsmu9RVvBlAsS0v5ljpQM?=
 =?us-ascii?Q?igBb79N9Xx8JsfxMBGYvHrMkM76wMuyttO4VwuyNQTFzKsuBg9jMhm5o3W99?=
 =?us-ascii?Q?5BKy6xjLV93UEixmphzqD5XlaF1KPrr6AMLAkD2i8O5ET0+O+gEVneers0GU?=
 =?us-ascii?Q?2N7ylFEH7Ruk3+msrTRr63u67yDCj6LMdmoXjsbNVvfJi26EfWwlkYdotpe8?=
 =?us-ascii?Q?5p2M0vcbbifYCy2ijEMr4VHCl22nIC9GRmWo/Q+jXK8iBNF7K2wMU3WPp/s+?=
 =?us-ascii?Q?CpeFOWkVlInDRCD32iX6qbcItqbvZN7X90B4ZCHI2MW2?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: efdebc33-5285-4b84-9456-08dcecfab98a
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:21:17.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmmWHrH4rp0no7b2srH3NlPu6qJFPz6FjtFeYgU0Q91Yx4pH3j7BPUKlrIvXmTBH3cEi/D1MZSxAgezWP11OcKJxoOKIW+BKu1Lq7gHXZi7nr8ea4v2G7V0uhIV9I/U4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0995

Enables pedometer functionality in the ICM42605 IMU sensor.

The pedometer feature allows for step counting, which is accessible through
a new sysfs entry. Interrupts are triggered when a step event occurs, enabling
step event detection.

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  16 ++
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 165 ++++++++++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  36 +++-
 3 files changed, 211 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3a07e43e4cf1..c3471b73152e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -122,6 +122,7 @@ struct inv_icm42600_sensor_conf {
 	int filter;
 };
 #define INV_ICM42600_SENSOR_CONF_INIT		{-1, -1, -1, -1}
+#define INV_ICM42600_SENSOR_CONF_APEX		{ 2, 0, 9, 6}
 
 struct inv_icm42600_conf {
 	struct inv_icm42600_sensor_conf gyro;
@@ -141,6 +142,8 @@ struct inv_icm42600_suspended {
  *  @chip:		chip identifier.
  *  @name:		chip name.
  *  @map:		regmap pointer.
+ *  @pedometer_enable	status of pedometer function
+ *  @pedometer_value	status of steps event occurnce
  *  @vdd_supply:	VDD voltage regulator for the chip.
  *  @vddio_supply:	I/O voltage regulator for the chip.
  *  @orientation:	sensor chip orientation relative to main hardware.
@@ -157,6 +160,8 @@ struct inv_icm42600_state {
 	enum inv_icm42600_chip chip;
 	const char *name;
 	struct regmap *map;
+	bool pedometer_enable;
+	bool pedometer_value;
 	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
 	struct iio_mount_matrix orientation;
@@ -301,6 +306,15 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(_f)	\
 		FIELD_PREP(GENMASK(3, 0), (_f))
 
+/* Pedometer functionality */
+#define INV_ICM42600_REG_APEX_CONFIG0                  0x0056
+#define INV_ICM42600_DMP_ODR_50Hz                      BIT(1)
+#define INV_ICM42600_PED_ENABLE                        BIT(5)
+#define INV_ICM42600_REG_INT_STATUS3                   0x0038
+#define INV_ICM42600_STEP_DET_INT                      BIT(5)
+#define INV_ICM42600_REG_APEX_DATA                     0x0031 // 2 Byte little-endian
+
+
 #define INV_ICM42600_REG_TMST_CONFIG			0x0054
 #define INV_ICM42600_TMST_CONFIG_MASK			GENMASK(4, 0)
 #define INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN	BIT(4)
@@ -373,6 +387,8 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN		BIT(0)
 
 /* User bank 4 (MSB 0x40) */
+#define INV_ICM42600_REG_INT_SOURCE6                    0x404D
+#define INV_ICM42600_STEP_DET_INT1_EN              	BIT(5)
 #define INV_ICM42600_REG_INT_SOURCE8			0x404F
 #define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN		BIT(5)
 #define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN		BIT(4)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 56ac19814250..90fe4c9e15ab 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -160,6 +160,13 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	{},
 };
 
+static const struct iio_event_spec icm42600_step_event = {
+	.type = IIO_EV_TYPE_CHANGE,
+	.dir = IIO_EV_DIR_NONE,
+	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+	                       BIT(IIO_EV_INFO_VALUE),
+};
+
 static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,
 				inv_icm42600_accel_ext_infos),
@@ -169,6 +176,14 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
+	{
+	        .type = IIO_STEPS,
+	        .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	        .scan_index = -1,
+	        .event_spec = &icm42600_step_event,
+	        .num_event_specs = 1,
+	},
+
 };
 
 /*
@@ -668,6 +683,31 @@ static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
 	return ret;
 }
 
+static int inv_icm42600_steps_read_raw(struct iio_dev *indio_dev,
+                               struct iio_chan_spec const *chan,
+                               int *val, int *val2, long mask)
+{
+       struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+       __le16 steps;
+       int ret;
+
+       if (mask == IIO_CHAN_INFO_PROCESSED) {
+               ret = iio_device_claim_direct_mode(indio_dev);
+               if (ret)
+                       return ret;
+               ret = regmap_bulk_read(st->map, INV_ICM42600_REG_APEX_DATA, &steps, sizeof(steps));
+               if (ret)
+                       return ret;
+               iio_device_release_direct_mode(indio_dev);
+               if (ret)
+                       return ret;
+               *val = steps;
+               return IIO_VAL_INT;
+       }
+
+       return -EINVAL;
+}
+
 static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 				       struct iio_chan_spec const *chan,
 				       int *val, int *val2, long mask)
@@ -681,6 +721,8 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_TEMP:
 		return inv_icm42600_temp_read_raw(indio_dev, chan, val, val2, mask);
+	case IIO_STEPS:
+		return inv_icm42600_steps_read_raw(indio_dev, chan, val, val2, mask);
 	default:
 		return -EINVAL;
 	}
@@ -824,6 +866,126 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
 	return ret;
 }
 
+/*****************Pedometer Functionality**************/
+static int inv_icm42600_step_en(struct inv_icm42600_state *st, int state)
+{
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_APEX;
+	int ret, value;
+
+	if (state) {
+
+		ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0,
+		                        INV_ICM42600_DMP_ODR_50Hz);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
+		                        INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET);
+		if (ret)
+			return ret;
+		msleep(1);
+
+		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
+		                        INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->map, INV_ICM42600_REG_INT_SOURCE6,
+		                        INV_ICM42600_STEP_DET_INT1_EN);
+		if (ret)
+			return ret;
+
+		value = INV_ICM42600_DMP_ODR_50Hz | INV_ICM42600_PED_ENABLE;
+		ret = regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0, value);
+		if (ret)
+			return ret;
+
+		st->pedometer_enable = true;
+
+	} else {
+
+		ret = regmap_write(st->map, INV_ICM42600_REG_APEX_CONFIG0, 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->map, INV_ICM42600_REG_INT_SOURCE6, 0);
+		if (ret)
+			return ret;
+
+		st->pedometer_enable = false;
+	 }
+
+	return 0;
+}
+
+static int inv_icm42600_write_event_config(struct iio_dev *indio_dev,
+                                     const struct iio_chan_spec *chan,
+                                     enum iio_event_type type,
+                                     enum iio_event_direction dir, int state)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if(chan->type != IIO_STEPS)
+	        return -EINVAL;
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_step_en(st, state);
+
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int inv_icm42600_read_event_config(struct iio_dev *indio_dev,
+                                    const struct iio_chan_spec *chan,
+                                    enum iio_event_type type,
+                                    enum iio_event_direction dir)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int value;
+
+	if (chan->type != IIO_STEPS)
+	        return -EINVAL;
+
+	regmap_read(st->map, INV_ICM42600_REG_APEX_CONFIG0, &value);
+
+	if (value & INV_ICM42600_PED_ENABLE)
+	        return 1;
+	else
+	        return 0;
+}
+
+static int inv_icm42600_read_event_value(struct iio_dev *indio_dev,
+                                   const struct iio_chan_spec *chan,
+                                   enum iio_event_type type,
+                                   enum iio_event_direction dir,
+                                   enum iio_event_info info,
+                                   int *val, int *val2)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+
+	mutex_lock(&st->lock);
+
+	if (type == IIO_EV_TYPE_CHANGE) {
+		if (st->pedometer_value == true) {
+			*val = 1;
+		        st->pedometer_value = false;
+		} else {
+		        *val = 0;
+		}
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	}
+
+	mutex_unlock(&st->lock);
+	return -EINVAL;
+}
+
 static const struct iio_info inv_icm42600_accel_info = {
 	.read_raw = inv_icm42600_accel_read_raw,
 	.read_avail = inv_icm42600_accel_read_avail,
@@ -833,6 +995,9 @@ static const struct iio_info inv_icm42600_accel_info = {
 	.update_scan_mode = inv_icm42600_accel_update_scan_mode,
 	.hwfifo_set_watermark = inv_icm42600_accel_hwfifo_set_watermark,
 	.hwfifo_flush_to_buffer = inv_icm42600_accel_hwfifo_flush,
+	.write_event_config = inv_icm42600_write_event_config,
+	.read_event_config  = inv_icm42600_read_event_config,
+	.read_event_value   = inv_icm42600_read_event_value,
 };
 
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index c3924cc6190e..4d78cb5ca396 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -15,7 +15,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-
+#include <linux/iio/events.h>
+#include <linux/of_irq.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42600.h"
@@ -533,6 +534,19 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
 
 	mutex_lock(&st->lock);
 
+	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS3, &status);
+	if (ret)
+	        goto out_unlock;
+
+	if (status & INV_ICM42600_STEP_DET_INT) {
+	        iio_push_event(st->indio_accel, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
+	                                                     IIO_NO_MOD,
+	                                                     IIO_EV_TYPE_CHANGE,
+	                                                     IIO_EV_DIR_NONE),
+	                                                        st->timestamp.accel);
+	        st->pedometer_value = true;
+	}
+
 	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &status);
 	if (ret)
 		goto out_unlock;
@@ -860,12 +876,20 @@ static int inv_icm42600_runtime_suspend(struct device *dev)
 	mutex_lock(&st->lock);
 
 	/* disable all sensors */
-	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
-					 INV_ICM42600_SENSOR_MODE_OFF, false,
-					 NULL);
-	if (ret)
-		goto error_unlock;
+	if (st->pedometer_enable) {
+		ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
+						 INV_ICM42600_SENSOR_MODE_LOW_POWER,
+						false, NULL);
+		if (ret)
+			goto error_unlock;
+	} else {
 
+		ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
+						 INV_ICM42600_SENSOR_MODE_OFF,
+						 false, NULL);
+		if (ret)
+			goto error_unlock;
+	}
 	regulator_disable(st->vddio_supply);
 
 error_unlock:
-- 
2.43.0


