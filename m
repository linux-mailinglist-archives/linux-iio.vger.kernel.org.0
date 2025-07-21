Return-Path: <linux-iio+bounces-21808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A452B0C228
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BCA178794
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AEF292B4A;
	Mon, 21 Jul 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g0zzrGj9"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B9292B29;
	Mon, 21 Jul 2025 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096077; cv=fail; b=NagFfIMRgm/jhYh/dCOWo2QG18OJYFtgxNupOrOXmewV2alYv0FUS/2PeqMApIRwHCdoD2LjZvhuOOMjEeD8kmOt9yLFAtKtSO9RkkQsimksejMZSqz6ih2C9GDqXBitpwSqYFbj248d037x5+B5Oked059g3QNUJG/jvTiEAWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096077; c=relaxed/simple;
	bh=TJN8frEXo6XVv5nG5lsiYg8LYjDktR7fCzupjpxpxVE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mtoOgdJIDdgNpKz3VtcXlew6AV2+o6kc2Ca1urw20OWeSPJ8lpqOo1xsYJazdwcb8WTFnFMmUy6KVu6tImwSWzXnzI5zXdbdFsu0hl2/v+Gl0+LuyyK0eyXy3IuCck1tf/B8BfUCssP0MJUb0rJULid89QJ/KLI2RL5UCC7Iaic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g0zzrGj9; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI303BT3i9/rAHUBh0pxWOfdzXgTfegzyFuPLfWmTHLfx0LAJraVZniJb2NIyI+lOuj4x8wcpDAShK7ZnKi+MoX+0NNLFbPjwOxxT1lGsZEwYUG5JiK2beWHdYijvwrZ7bk0FE4g7JgD+uZ+1d6Icp4Z23d1+YAJ21jEuI4HnvvDyJMfY8R7yxlyQiExZte1GSvILPMMY61LbZuJjSiAm+fMO95j6nrpv06aHFgBrCan7VTgjVErJL1ndsRD50a/2MGk+qsuu5yD39QL8Yl9cTNgRDis2GCcGKcVdQ8CkxYOW6Jvh82KS4wGK8hKEzpFG85Ffc1rMR/OMbnSWUv1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xn7mUwCcqtIMeVFqJ/xCOT+L0StFwuTWdYRRotMQoG0=;
 b=C+tYk7RjAMSzfYNhzUauY9Lg21ITd5ThFA2IuFm1ny38GPvoRj0uE1Nprlk2A1edBuDj00qk5Nnd0UD1VWQnrpB22ZL2mux7RUVvCyNKutNftBNF66FA9TwW8HNkDdZoNlO0b/niyzrldQB6FwT+tr5UDVP96uNX8LbsnI0ejaw6dIiUUfV5GY2CGUVYtzz2f+FPotI1OoMThRBVoBlPfDzCHodLGrWw+H7dBj8F/GN28vocoCU/IY68ofJ9zlllGOynfOBgN/Ondq8oFTz0tGNtm+53OEiyAZY3xpT7ufNw+Szt+sn4QREb30YPMhisBe1xT4JKNi5/9VM57UVffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn7mUwCcqtIMeVFqJ/xCOT+L0StFwuTWdYRRotMQoG0=;
 b=g0zzrGj9EPABfNEMMzeLJVYZBQp/Qszz6ZYLnVnsWmTw6sVMSf97gLJaO54dvzGI+OhLBpADn3jQmGotGLIVnaenVXWNrgRtVDCIEszI4qEoGLls6fT//DYZHpES4CvmzgcABSHcAnJtZaqgZcwMTkNANOiIOrXa35nK9R6JJ+U=
Received: from BLAPR03CA0161.namprd03.prod.outlook.com (2603:10b6:208:32f::8)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 11:07:53 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::5a) by BLAPR03CA0161.outlook.office365.com
 (2603:10b6:208:32f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 11:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 11:07:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 06:07:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 06:07:47 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 21 Jul 2025 06:07:44 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <lorenzo@kernel.org>,
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for I3C interface
Date: Mon, 21 Jul 2025 16:37:41 +0530
Message-ID: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e86c955-31ff-4c3e-ce19-08ddc846d67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqS7Li5Drmby2jSuoeFD0WgLQBgMJQrC3RV0DU+4kLhMSGhVeWNPLvyvelM6?=
 =?us-ascii?Q?1aS2kuq+57i1g9lipQI7EQotWAvtO7LJI2ZaKe9evLyvd7rC0eRcOzEsVdji?=
 =?us-ascii?Q?yJSJlo9f5uEbwxRvKnfdhkyDQHxB/dfhZJAJ9WTTO2p+SEgrlpL/lXmpBy5l?=
 =?us-ascii?Q?H5ycy2NTo6SXl4VSR0q7U8q7peWGbRYXoVEvUv21TlZJ976Vw1/USHq1jKXG?=
 =?us-ascii?Q?xb5lAHlaGuBnQaaflMVx1Bb0CWptOmewbzCcmJur2oYpp0OjfH8pMtjjqbBA?=
 =?us-ascii?Q?z4mw4UQqJjOqT7oTpQM1De9OjfWPzyeqXLQbEEgOIeOJWM0nr9dtINpGIcU2?=
 =?us-ascii?Q?Jfvg/vzFRTwmAekJO6nks7Hu3OW1Jo0DRFqNMvw8rwdGVPfUU8mAwwSo5XQ7?=
 =?us-ascii?Q?BBVPtI3Lx7aIVHzvh2tNf6mftlDv9F4oeTTRVD8xW73ic87FrQidgbEyhErW?=
 =?us-ascii?Q?54l3OvAcWfUYDoOw4DoJD114IkGN5QLVvso1IuGmkL6oRjqPyzn+lF/A6iY2?=
 =?us-ascii?Q?AQJm7Lixs9bsO3EDf8pP5zaJvLvY4Rczr9bjp6ZjpmSoOahhwq7LSZVW4mUr?=
 =?us-ascii?Q?qxTAmAditYtLr7Kjb4dzH6dFHLzPGYgTVb0IeYytIy434pveJccykOV5TnlJ?=
 =?us-ascii?Q?JxoOhlGI4r9BgVo2oEku0I1m7lYPdcD+mlqs+5zxGxjQ1rWYcCVhXb+Dwf02?=
 =?us-ascii?Q?Imx5QnZZO+MCDFMzoWyh7FmiSkQ0DVcz5K0CrnZ6+7x2SsUp14WE3hhmNSLX?=
 =?us-ascii?Q?pD6TDlfD+MhRfAU1zvswWuGEqqa533My+0BxM5pC2ZEn1RfVNsSUTGpHlk1N?=
 =?us-ascii?Q?ffComzZpN7ThfmIlpJWoCnl1D1iAi+OugBMDArXqS2RMkNeIjib5FAFJ6cQ7?=
 =?us-ascii?Q?nv8QTgl/dVST37qKcklvZzDaRz9z2fXnWGay0Tc1tKaPCSg8nVgR8UoJoFYj?=
 =?us-ascii?Q?Joholb9Oi9BzqEUk5lTKscESTNIADYP6C3omp/O7NmHXhsJBFZvR/4EZcbDZ?=
 =?us-ascii?Q?FSPa95upb28lb/kp6I4aHtdDqi+suwbUhfM4NwdDdXKc/HKGC457I5eI+UiR?=
 =?us-ascii?Q?tygn83ZpHc1b3uP3RWxAVtzvCM9sGRerjWLTvFhCu7D37UQQ5/fr0pYoN6AV?=
 =?us-ascii?Q?0iEdcrx+vqnZEFmtF2I7w9nIiIzyn0OmYHU0OFAL/kIrNkhodRACMNReyjH4?=
 =?us-ascii?Q?jOx4shM6NvvrQXBAQAefmgr5Xv+HjoEgztr150R4Nm6I80iPivgGMr3Kc3zM?=
 =?us-ascii?Q?d4dRLWLmtU20vfRu8OkHDtiULIY/6nJljl6c9DjAC/s/IqeRyenF4+A5hjMa?=
 =?us-ascii?Q?QxcyRzc/IX9uO0mK9qp09ZBLQdA+/VGeOy4Bo/cseys9pNLBq3aj0Tzdz3t4?=
 =?us-ascii?Q?bcOI7jjiuAT/XMagK6bRzL6LiS+VsYdHWEtXhu9d11S2xKXelYimV7NQNcvb?=
 =?us-ascii?Q?S1ncIgCKibRr/ivTH+pT/7Xouv6CZuBA9qyOHllmbTciaat/qhlhehdPxDAp?=
 =?us-ascii?Q?Znd8GKyR7J/mE+FFyxJ4jLtThSn59fCsIWr5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:07:52.7955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e86c955-31ff-4c3e-ce19-08ddc846d67e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

Add a shutdown handler for the ST LSM6DSx I3C driver to perform a hardware
reset during system shutdown. This ensures the sensor is placed in a
well-defined reset state, preventing issues during subsequent reboots,
such as kexec, where the device may fail to respond correctly during
enumeration.

To support this, the previously static st_lsm6dsx_reset_device() function
is now exported via EXPORT_SYMBOL_NS() under the IIO_LSM6DSX namespace,
allowing it to be invoked from the I3C-specific driver.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..42c0dcfbad49 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -466,6 +466,7 @@ extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
 
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap);
+int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 				 bool enable);
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad49829e7..929b30985d41 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2267,7 +2267,7 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 	return 0;
 }
 
-static int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
+int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_reg *reg;
 	int err;
@@ -2302,6 +2302,7 @@ static int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS(st_lsm6dsx_reset_device, "IIO_LSM6DSX");
 
 static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index cb5c5d7e1f3d..f3d9cdd5a743 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -41,10 +41,24 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
 	return st_lsm6dsx_probe(dev, 0, (uintptr_t)id->data, regmap);
 }
 
+static void st_lsm6dsx_i3c_shutdown(struct device *dev)
+{
+	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
+
+	/*
+	 * Perform device reset to ensure the sensor is in a known
+	 * good state for subsequent re-initialization or power cycles.
+	 * This addresses issues where the sensor might not enumerate
+	 * correctly after a warm reboot (e.g., kexec).
+	 */
+	st_lsm6dsx_reset_device(hw);
+}
+
 static struct i3c_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_i3c",
 		.pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
+		.shutdown = st_lsm6dsx_i3c_shutdown,
 	},
 	.probe = st_lsm6dsx_i3c_probe,
 	.id_table = st_lsm6dsx_i3c_ids,
-- 
2.34.1


