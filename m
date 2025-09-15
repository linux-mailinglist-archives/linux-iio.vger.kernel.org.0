Return-Path: <linux-iio+bounces-24116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA725B581BF
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159711AA3C1D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28396264A8E;
	Mon, 15 Sep 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="HU57z0/c"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F125CC42;
	Mon, 15 Sep 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952739; cv=fail; b=t7rya7SxxEDnhyx65x/ZXuk98crjV1aJyfo/YsGrk4Xrcwmf/okqKPeCycAXr/L8KyhA+lU9bLXq0bD4iPFNq/+A/z/h1e1deX2kO4t567eu8iKBnLEgKJEkivny3Y7NaBMThgqO+XAcW4d40VLSSdyko6cIg9ftoUrMk7WSPLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952739; c=relaxed/simple;
	bh=Ry6scwQBts1yno/A7wwUe1p8vztEbvewtvdq67rwcdw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dm5tvdMHt/GVZDZdl47Stlh7LXqELWoLxv9TR/rGUwBZFh8p+L2xFR3Z7yLuFlceuUqCtcd0ibSJaFq9j+HmZcH2xOgcNIfPt5Yq1GFXeK/bf80EdjAUoHADGid/1FcvKXnccG2G/6YmeBW+NsNLJ4nOpq9/LtgXVly80Xz51fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=HU57z0/c; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDEKXyv3oTQg9zE/1eJdi+chTU5b4+erZJdxk9H8W5SmRmiecApV3WdJVaxR6sZtckHweHzLpWIA6TtJAh5xEp8u9G06B7QOcJLLsiWkJ3OfVV2mU0hqUMHO+B7buOA+P/EY+rklAzQpe5mEYIHH1jksfyGuA6+bP8tpEj8nVq6iK0G1zMEymUyZRiExxZPL7kWlwdPbXWq4xujPj+J88cHfPjZyeau9seVqTmXbWdbEzQyMY2D8FxFoJTT7fgoym7ZXolyNSBwWL6hYNsiVMWR4PqgkDayI+KxcASo7ZCaa0rtP/L9aXNx2chTWDJ63l89vKEeDBPbFg/O6onbkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oST5SWrK549Pmp0RhSZsAkGa0cCoJjfqVSoF+QOs+/E=;
 b=y5IRKJ+sT4Ndf8U+hjTWeefL8F56DAEB/KXy5QfvFFsVtr40kM11T1oKSphUHAGNQnMk//DgAiX6IaVLJ34NtHzsnbOHoE3illUHrqsMhgZzjTWgtoNp4OaTVsaH5weokRr1DsGFKzgE35zrLJnUW7isiFWHZ8E1yBOQ2ockI9+4OuPi+WgjivT/bKmTJiKKQXanzBYn8P3GB73NLRJ6ctGjKdMOryqhJluIgVlCfovToCxlegwkVPv8WQ0QBeqjy42ZqeWlOuMtMSduK6LxCdaq8Hm7RnbutxqL3OqdPtLZGrcmX9fwB4tSt848bB/pht3gMMr2NLioIP5n+V8Ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oST5SWrK549Pmp0RhSZsAkGa0cCoJjfqVSoF+QOs+/E=;
 b=HU57z0/cOWxV2UdHxXL1SRB8zDMaC9dudy/eH3wzNSX/JJadz6CtyQr9KMVF8PIGkMGT+OKLtH24JQX33qdv6hJ8X7GGYJEx3FBzto3TXuxe8ky8nnD+wmTR/38Yz7SIJEhZlxyOiJ4BMtydT6g4AZqrIJYShduNLp9CptmgL6quysRHzt4zPJN4Qq+dMnuGU5bSveWgM1kaRTZlaA47C0qc0a0dkH9x5kNiTnDn35+fC/OEzIj+R9LAgC7TTUYdbetA8cyXtsnc97+jOnwS2msylFe8a3yRu1TYfX3dqmLu3Jrl+9sG9PJixqDa/eYJ9L4V3QdlvnCzackZ8YWiow==
Received: from DU6P191CA0061.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::14)
 by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 16:12:09 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::33) by DU6P191CA0061.outlook.office365.com
 (2603:10a6:10:53e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 16:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 16:12:09 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Mon, 15 Sep
 2025 18:12:01 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.179.220) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 15 Sep 2025 18:10:52 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v4 0/2] iio: imu: smi330: add bosch smi330 driver
Date: Mon, 15 Sep 2025 18:09:32 +0200
Message-ID: <20250915160934.89208-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|DB3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a74447-2600-4d19-fc14-08ddf4729f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BDAVkcPgfAqdNLcse9aW2OJ6BT2PR+p5wULaGuUr7ip3P34ZunZkqhgnL3Sg?=
 =?us-ascii?Q?Wu8We8+fmUXqnN3109ARnx2Q0bfs5FKSQ3Tl0js1kpsKL0wNhcR9JK2F1prt?=
 =?us-ascii?Q?e8157CGXVzaJAmBi3rOnuRTHVH1hnbweLC1A9vBFZRojZHIJTmy0lkhHAfjg?=
 =?us-ascii?Q?/aDLs4j5u/Yxr6nvmym04XFy/Fx1OGTpm3udeZiLHzOfRDQhAm8rUoQer1i1?=
 =?us-ascii?Q?zqkM3m+0ZsA3Oh3bbw7UPSLa6wAPusaOri4CHIC7Tlo9sfc1vqHwUNR+JbuP?=
 =?us-ascii?Q?z7De5BdttPAV/u3uvtg7nklCAYbUFZ5B/agBLOlOVHFwiQsEA1yvndCqvMLz?=
 =?us-ascii?Q?bPvx8efaloVXg5nhJWU5RO3Bj4tfMY1T1/rvmQrJ/DZ9XBHSWYFJ9Q31Gxp/?=
 =?us-ascii?Q?2lUqL7O79tq1lPWMF26LYciJy26wJKZS2KAIpDWn0HGv0zWGOAaLUGGpSvVO?=
 =?us-ascii?Q?ClUit+Ym1LaSPzsdp2J7nJ/YRbdZYM3WNKgaQ/dkKjyA9vJ895wgzHdjlPe9?=
 =?us-ascii?Q?xXRfcXAbdLVNpO9n0sFdZiKzMf7emV5X3o/FFSLlBb4jubpNrZ3aWCaUYL6M?=
 =?us-ascii?Q?Q6yV4nxfReaHUIQvyPC0Uk1qoz+RpHfVGmTlmKhlspdlK1pPFitI7IE4cezx?=
 =?us-ascii?Q?sADD+3DKknYRSgyMPh5ZISGiuM/+yb3c1OqtkFa8cylOWrn+rmTS0oXucXfo?=
 =?us-ascii?Q?eJJ5+pqHWbXOu7g/xlwD6hi3nxGm61QhvbFYrKF4HqrE59OkRy635xB+UKUR?=
 =?us-ascii?Q?1iiAKZcK5dVvhQ9ZcgFroUC54kYlAxaRnhEdEqdiJgCNPF7u2HxyTVEmGSU7?=
 =?us-ascii?Q?3uhIHPpTl383zfu9LiK5n1/PK2NbvSsmWykSc0utOyrwZLWLJhGO/HHvKm1W?=
 =?us-ascii?Q?G1m9aNe/f2Ujj6HYVbHQuCGJUy/SZyhS/NG1moMNTGy948LM2vF5Wntx+OCW?=
 =?us-ascii?Q?S8nHaCHAV+94/WWfdyYamheHNVbTE8mmZLEP8U9aipivIdbtQNW7+gzNRVA2?=
 =?us-ascii?Q?EuW4xOS/kp9LcSEG+0C8IQkAPePy2tqo0hQoGLdbAKhO/sTM7nBUstCdjMRv?=
 =?us-ascii?Q?Qy+bCq57Gh2ApaTzwrD0WIaN248L6yTG4+JIzx+2Z5luBFVOnkKvP1SRR7E2?=
 =?us-ascii?Q?pr3NvcTJF8Oo0nk3pvBsbfJzF4jHa7+Diax07vdnk2ZrnylNX8v94BApoA7I?=
 =?us-ascii?Q?ToYZ9sA9t6UaY92bfEhFS36ddNKdZs2MnxB3V6pk0FLfDFwt/9Ky6t0fbMrL?=
 =?us-ascii?Q?QN5y4aJ5lZuhUglp+WkeAY0qqEc60YRbZrrXF6okwumqCv55Q+8BNUUSgmkV?=
 =?us-ascii?Q?9U4OZKoMq2sDtGDqbKXLX2krHkt2mM+FNXAvBv7yyjElIBqyAXeMH150AOrT?=
 =?us-ascii?Q?RwcOoqKNftATdWFuUQJQP5N81miO2JOTXc+k4I8TrIXzUiO8+y1Mi82JaEtF?=
 =?us-ascii?Q?vK5XlujCb+ngf0UFjfOjMTBLsbXgjE07A3bQt8Uo0Kkc/wmfhhABRVYuqwZo?=
 =?us-ascii?Q?OhIozAy1GovoKqc5f28TW7EgzIrr63ATHGz/RU+GkTiHakEFDCRRXnroBQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 16:12:09.5200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a74447-2600-4d19-fc14-08ddf4729f84
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6835

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

v3 -> v4
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

v3 -> v4
    - move #define from header to c file
    - add sanity check to i2c message size
    - use available_scan_masks to simplfy the copying data to buffer (dependent on [PATCH RFT] iio: Fix core buffer demux failure to account for unwanted channels at tail)
    - allow setting output data rate for acc and gyro separately
    - some other minor finding fixes

Jianping Shen (2):
  dt-bindings: iio: imu: smi330: Add binding
  iio: imu: smi330: Add driver

 .../bindings/iio/imu/bosch,smi330.yaml        |  90 ++
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi330/Kconfig                |  39 +
 drivers/iio/imu/smi330/Makefile               |   7 +
 drivers/iio/imu/smi330/smi330.h               |  25 +
 drivers/iio/imu/smi330/smi330_core.c          | 919 ++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c           | 133 +++
 drivers/iio/imu/smi330/smi330_spi.c           |  85 ++
 9 files changed, 1300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
 create mode 100644 drivers/iio/imu/smi330/Kconfig
 create mode 100644 drivers/iio/imu/smi330/Makefile
 create mode 100644 drivers/iio/imu/smi330/smi330.h
 create mode 100644 drivers/iio/imu/smi330/smi330_core.c
 create mode 100644 drivers/iio/imu/smi330/smi330_i2c.c
 create mode 100644 drivers/iio/imu/smi330/smi330_spi.c

-- 
2.34.1


