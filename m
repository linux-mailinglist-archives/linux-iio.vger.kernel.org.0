Return-Path: <linux-iio+bounces-21315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FFBAF7C99
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCF516F507
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C429117D7;
	Thu,  3 Jul 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="mg2aorYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93ACEEBA;
	Thu,  3 Jul 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557182; cv=fail; b=iXI09KZZOsn3fXGqgHy73y8GflkjTH3wKgyc2Asv5hCIcnD00Bj6PbQUMxwG93N9lZWoldgp2UQd2GKiXMPsnvw7Od3/23I5pXRq+ZHoR/BJ2pwbGG8ijxl8fw6zx6gIep+dNy0O+7AelESxecQmatHFmgMo87N15hD4aMOKg5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557182; c=relaxed/simple;
	bh=ZW0UUH2xR8Zr0y/w/AeQsM9BKRejlKx7ws9L354+qHQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n78IzK47gIe5hFhTUwUGRxTISca2M/5ZQAZ+bcU+5kvss4F0kYFUdoA0efEFdhJ2URF7fo8RgBNRVzpzdFUFxpumrKecfleWyAwegsgYCdRE6Uq2KSAmz6R6LnfH2cjjpVsvXKlkpY/KO01emXkt3enf8bP0tPdbWtrbCu7b7/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=mg2aorYf; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJvkD1R0nqYTCgA2OjInklpMCzKq55g6VmWctdHhU+ZKj+4JLAfOJZM5+IwvihjQIAV6GqMwyu8F4BQRHWwQIMYR26UCRo1p+KVxoEdZtaGU1nGiS5Ln/wlLFjbxvB0iduz2qPgdx6vfY9pQ7DEr4l/zFsMh8AvOs4WW6NYXcnEMS5VkdHxMqZN0iMw6D/aeOa81OdwKR3i8V8hc5iH+Uac1L1huv2ezQcl0dURt/+MX9ZTeGLm0omHie4XvY/jvnG/J8pcKOeaDhXY2O5jrToqvz7txxC7N2w2P0sO/QGuA67Lse5YSpv9gJ2sqW/DU/QhM9wbYj97yD0W9D8oClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsSA6OAznRAbR8tkV8wl67ovQXJGtsLjTdIAD5RVQcs=;
 b=NVxcdedo/4AqQvxWwzvaOwvTEt6UFZzddKJ+im1m3+Um0XUi+IGMSrkPwzWI6hZ7xRaVfFMacP7NjXBXZbq9/1+TWHzctn7mdu7unGu+n8BcdnNtmL+hQ9dgfciqREyQ5lSda+0pce/o/IfyB00eLtdrSFFEAjFtYH/KDnhTSuaMxFnvC/kQos5/WDBZs8WYKq29T7kL0nRfNRIpMHUobcGOwo02dtRPo9KVxnTeeg8EcZlg5RzJZvKD7Em2zoiq0qNyr/tw97dch7BT9m0SDHytJceAMVzsakASvNd0D/Fx411vi2FoQh2pyFj9l/1VxdmSol3SBo7Kezbo1/0m+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsSA6OAznRAbR8tkV8wl67ovQXJGtsLjTdIAD5RVQcs=;
 b=mg2aorYfOjgR8vl4wRrxqvJWX4CmtESdDpjiTEp//93BYSMKkC7V7QQKUVyFabWWUkzG0Dqcaj3T15tjNGTs/sRof+neaFZVsqiMe2paDPCrxU8eEnxTHHufnYg5DgmpZ4IoMKYVdWQGUijCP2vnT2l61Dp6WvGDrsNuZUieCy8GuYLOYoak01yukh2ln/KKGAAnzE0We2AXfkd5QWAl2ECkt0Vg7BeTwUTWXW7y6I4g50fnp9ZVv2ZMPDPC1qqE/VFRVGKXl+4gCqPKY1RrWids4gEYICJzFy68KyOO1RdtzWGjowaTvWQoREhbyokbu79VhP6sKYKVLzh0WJ8lvA==
Received: from DUZPR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::25) by AM9PR10MB4120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 15:39:34 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::4) by DUZPR01CA0149.outlook.office365.com
 (2603:10a6:10:4bd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 15:39:42 +0000
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
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Thu, 3 Jul
 2025 17:39:05 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Thu, 3 Jul 2025 17:39:05 +0200
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
Subject: [PATCH v3 0/2] iio: imu: smi330: add bosch smi330 driver
Date: Thu, 3 Jul 2025 17:38:21 +0200
Message-ID: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|AM9PR10MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: f98f047b-2b9e-45fd-f644-08ddba47cf6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?min0Pk0ITeSvuFBWq+9HR/Gt6CQVmhuu5vZSpFYH4eU7fDxbkfhBcuf//icj?=
 =?us-ascii?Q?Tszuea6Gqza1bY7NZooZk0lVSWkZuzMXFGGnnG2Yb/KZOGXMZBuu1s5fd9bd?=
 =?us-ascii?Q?7wBMM37QeSzY8ZTHb3zG08DcYPUc31HZnwbtGeL/w9ovBJHLgSZkiOXYUFP6?=
 =?us-ascii?Q?vomQbLPi6GMq5aPr/Qn70TFAxQWCI3TlgdYXPRutz9YUcY/QeBUSuRMitulQ?=
 =?us-ascii?Q?uD3Xzw2Vhp2wwxRejRGfg8LbDxI0cV8UwVJA5/qVR3SUlILz7SlOacghyvol?=
 =?us-ascii?Q?1QWQ1NLxPRSlvbvJd791HrhvEP8hrDM3AUo/b/8HKOR2l6nMuCwXWpfXUGMw?=
 =?us-ascii?Q?epB3SkmTtLDTxbH0c14fFy2OGtZBmEm4iZUGSU42ZJrrMXFoIun2D9vzF57A?=
 =?us-ascii?Q?fPxPp7Lz4lCRJYX+YVHSWmZr/04Mjevkt1GYBEHSivs7nizkjFgrOEQYYVQ+?=
 =?us-ascii?Q?ZSQerQJ5px0bPNO9NHDqP9D92yK5OI8W43Fq5AXME2/0XU9hY8YOze/QtdCU?=
 =?us-ascii?Q?eLy+T0ArxZOLZfxTT0YjN+SQcxvm5UihWMDcIDdfutG+h6IrlgIsSilYfhOy?=
 =?us-ascii?Q?YIAo2VJWUpDQtqJjTEVQPm/k+57p31j/4lHAxM/+c+GrLMZUdKKuhYVCHrBZ?=
 =?us-ascii?Q?se4ej6uSrZBNdXO6XI9mLbxB+oBRupHCJ5VlazaahzUe6didcntluCAVCkQW?=
 =?us-ascii?Q?WSfBIcjInMwPQzPkYkk8437bXduY4fsTgEcN6jrXh1RaN6Xg5Z5u8k/67ShW?=
 =?us-ascii?Q?Uq553mbrBXpuecvVizSt3Wo3pbzWkC82pbyYFdigUcYMT/KhkH04vdyCa6G9?=
 =?us-ascii?Q?5vfzRJdfKeb9xRI1imH9DoBZDB1/sRA5nKBkmD/onzzy9O0DX++88uQ87DIn?=
 =?us-ascii?Q?P+i+yEC7vB9SVZXHHKb6hk+uwsTuIplium6GFagWDg3oEdXkUcFz99AJV27l?=
 =?us-ascii?Q?YrqK/W4LJl5tKfunEhf0rOrgVSz+2UjDvhPFo+pP7TstCfSIxr1jJNXUZvmg?=
 =?us-ascii?Q?RJ6ForkHc6/FtyRVa2SU/V0j9VVKb5o9BoieUS0MiqbOuRl1sxsLL3JinbfT?=
 =?us-ascii?Q?jKy0hz1K3dG1MOT2CsYNmDTMlG2qxOZ9DdD400EuCVC/uTUZE9WSAnbwNXnu?=
 =?us-ascii?Q?LvLFEA51QeX1ZbYPv9TUjsU40Neg/7VYPcnsVlOBCOtUnKn4Bz8iimJcrT6d?=
 =?us-ascii?Q?pa+wfmuHl30S8mdtejHQhTyB/1p8ighkC/eRBiwMPMC+s1C67bGjBqxREEFe?=
 =?us-ascii?Q?y7E8Rq+YnSNr0XXLheF5dcTcCkNU8TE8omhHWm8pBycbRsV8Ba+g/HljrOjg?=
 =?us-ascii?Q?ocNKCMuhpIG29RLDurG5CesdQkSnhfzywBV/Zj4Fs2kQD5QX1mCxT9hZyzHp?=
 =?us-ascii?Q?RAaBvzexQzibsUyEnBp4bzMfGAUpW8eFE89lni4jW+De0+GXGsTMcla53mXg?=
 =?us-ascii?Q?Fj7IXX2lVSXG5ubIDPrpy1mFEHGbhN7CVFAGfpSyS1gRp/iz7wgo6mPkWgER?=
 =?us-ascii?Q?lq4D2rzewzgYml433SDqMkPzBoMrGf39QxJ2HwVblzqtXGw6sxMmpwBgiw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:39:34.0826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98f047b-2b9e-45fd-f644-08ddba47cf6b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4120

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi330. The smi330 is a combined
three axis angular rate and three axis acceleration sensor module.
This driver provides raw data access for each axis through sysfs, 
and tiggered buffer for continuous sampling.

dt-bindings:
v1 -> v2
    - Add missing type to drive-open-drain
    - Adapt description of drive-open-drain

v2 -> v3
    - No Changes

imu driver:
v1 -> v2
    - Strip back to a more minimal initial driver

v2 -> v3
    - reorganize the driver as 1 core module, 1 I2C module, and 1 SPI module.
    - remove build time INT pin choice
    - change temperature channel definition
    - improved reading data from sensor
    - simplified timestamp acquisition
    - some other minor finding fixes

Jianping Shen (2):
  dt-bindings: iio: imu: smi330: Add binding
  iio: imu: smi330: Add driver

 .../bindings/iio/imu/bosch,smi330.yaml        |  90 ++
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi330/Kconfig                |  39 +
 drivers/iio/imu/smi330/Makefile               |   7 +
 drivers/iio/imu/smi330/smi330.h               | 240 ++++++
 drivers/iio/imu/smi330/smi330_core.c          | 779 ++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c           | 136 +++
 drivers/iio/imu/smi330/smi330_spi.c           |  91 ++
 9 files changed, 1384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
 create mode 100644 drivers/iio/imu/smi330/Kconfig
 create mode 100644 drivers/iio/imu/smi330/Makefile
 create mode 100644 drivers/iio/imu/smi330/smi330.h
 create mode 100644 drivers/iio/imu/smi330/smi330_core.c
 create mode 100644 drivers/iio/imu/smi330/smi330_i2c.c
 create mode 100644 drivers/iio/imu/smi330/smi330_spi.c

-- 
2.34.1


