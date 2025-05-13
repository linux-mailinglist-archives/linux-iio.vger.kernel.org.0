Return-Path: <linux-iio+bounces-19500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC88AB57E0
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159C8862FC7
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A592115ECDF;
	Tue, 13 May 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="B28zLdIt"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AC1ADFFB;
	Tue, 13 May 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148505; cv=fail; b=WR0nM7i4jMYQBGTbL1IIglSmwyhlUZwcjnLyZM+GLdRQcrDPAxDzZPO/CAMXcKSuxIuT1rnbAoCBQWYUP2NltJ0hUhYISDmWMlcHyrzbpkvpnJhydB7r+9nf23Ee7w/umazEBGLeKtt/odTdjWiw0MsHHd5ePzSen+vTjSiLIV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148505; c=relaxed/simple;
	bh=TX6g/CwWnL82sOolqL3XpvMvmum3UQot6/IZQY/huBk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c0s2xI/goO7jg00qs6j5N12xiXftauJE4kvkCZL3xxNrjKZ+P5iV0z/cbgzF3G7f0ld3Ucx/7e0P5fnD8f0dl2R+x1fE2kklaQbVgeQPA/2bm10c+c4CC6QvTXaevitR2yqgwW8LcnO+Pgh2QfZlmiuVuuwJnQLu2MQvx/eA8cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=B28zLdIt; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhyRwehE0BrLBJcFl7fKhnLJPjvBk1GuoNKLpBVGjouyMCQsNB3JUxPFTRPF6yKEZzJex7iXM7JlSYc3LWgK+/h//dOxVtlMufJtVOghcpoD0D2uheB9LQGN/KzSyKv80T96SQxnU1y//k8xFL39vSTL6QvOjr8J2Yz7b8ODmr6IBQ0Cnj3j1D6lhjwkaU8ArG3CU1HzvBIyidVUtPydNMhHGDYCoJg94EuR/PMtjxQWaz7bHZlAdBDyXWvMkVBgP/UdPpPxrMGf5EgFbHRSyKe69RfTF7QlfB+EAQN5dMeEhptKLAkpw29NLy6otm0DAWglEtpm7uU0BbOhkD5D7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHlBb3kmNP4fq+oUH0fSwM4iiyBbuLMVjAfFNh2Li5o=;
 b=v0fbSmBfU2RxlRz/gbBp118XBuM2nUdUw249f/HYp7m0Q0o+caza9QVy6p9EnRKl1gXKtnc9SUIACD5leFrmb6FYtGHi0k7LAqFAhiMTP1znUfJEBo3S2Xnn9RNSo7GS7ccXxVEw+jp4z0RBLJkb/MYXavsPyXboieBO8j1aYvot0ppxKVaPkTQUGFqyoK/v/3j053gB0dP2ZjUuFTSus4EU8sBAgXPvhvi661/kDYhk6MBHIROOnnCKQJujGlDMhKWujbXU9nO7Aa8NKo5OGUUDkB7HcDptUUfhB/B876hfGG760O0ci9GZcSsyKEK+iikqzriGJKQf1HKMmpAJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHlBb3kmNP4fq+oUH0fSwM4iiyBbuLMVjAfFNh2Li5o=;
 b=B28zLdItV2qoOG9dOZHpEoij8kUuv+oVzV2/3AJUBFc4ChcLa2W56B6CC6UeroHUcRqUaPnUHT9bqbpSnghu4U7AyREc3XFXzK+4oKUmusylPUPolLzf1L9yT2P9p3cFWNOOSDdZLnij+I3VfhGFxemmCpYkWxtO4r8CGbCb7gHyL46A7Q8e1WHs80w0BuMQ2IPrcBaj1iiEywKP2WgFfZgA5zd34ViZAz4qwk+YmgnE/WTko1AlP4O3H4qocdKNqItwzq+rNXtTgPIwAnAL2fTyvHW3naS13w+2VoEDM1rlqYWEMpd4PbCr0zvLEqxYqji/7E0RnJxSbjzfYw0NWQ==
Received: from DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) by PAXPR10MB5349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:289::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 13 May
 2025 15:01:37 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::a) by DUZPR01CA0025.outlook.office365.com
 (2603:10a6:10:46b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.31 via Frontend Transport; Tue,
 13 May 2025 15:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 15:01:36 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 17:01:10 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Tue, 13 May 2025 17:01:10 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.215.140) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 May 2025 17:01:08 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v2 0/2] iio: imu: smi330: add bosch smi330 driver
Date: Tue, 13 May 2025 17:00:26 +0200
Message-ID: <20250513150028.42775-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|PAXPR10MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: 664a0f5c-5750-425e-3182-08dd922f0ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQM9RwKZy6OJaNGM/+0ytgN3rJGvTE/ZBjh2HgCCtSqQeol6hv9YesgE8DVn?=
 =?us-ascii?Q?kEU5K5od8OMRIm4WpUKLaaitgGRRT6EwTEScsVxvcGkgYo/IYuRSb8Dk+BqJ?=
 =?us-ascii?Q?XU3BgFxYDWkcn71psM52YMdkoAhBR8PiZM2Qme9khUiQnP923xqUtWBktWP+?=
 =?us-ascii?Q?UZ9NiM+7cFukvxpywhHO9CeJ/MEjCVCJfbNBfjTwMMdlKF3ZAnagveb03rHV?=
 =?us-ascii?Q?fycP+Y/cUUm74BFghjJKeszEQyad35HbipL1PtXtfehgfZ4zX7nnkCzSFOV5?=
 =?us-ascii?Q?4IYsfs4sex/SA5XrX+oJClQ8+xn2c/X2C2rJwsYXcfm5CBMraPjZDi8GSJTt?=
 =?us-ascii?Q?IdS5PUXieMmiyVMEYM15T+ml94SmfVF3j+DUKK47VUfK7qMRpVBm11HR9I6K?=
 =?us-ascii?Q?D68FYpIsNs3WtFLYdJ9h2usQSjeT459kgF8oJmZToqkoMfij60j5jL1CJvbt?=
 =?us-ascii?Q?plAWM5hAUa1bZOTXCRUs3WRuQ4onJ/jdCs5+jl0Vpop906hTAtgZldxPDnsK?=
 =?us-ascii?Q?dEEMt6gB0y6W9wt+1YhfcNytcUpmakatAjTwpv3yuHcZFKHGpA6itX5dsdAz?=
 =?us-ascii?Q?lYmxhnD5egJhqM3jRlZ3g79Xw30ZfMRWBJVJ0nFCeDTDQbeLUFdzA3wLwtYA?=
 =?us-ascii?Q?ddwL0HmAU2dgu/vzLH28914HxoYhFi3HYn5s4NAklANmnFDtiZkpctIJq+4B?=
 =?us-ascii?Q?HN/CriYQyQdUuySvcH/0aBj3FhNqGOWAw8ZXVpnr7b+LdodbU7rrcvgc3Z7Y?=
 =?us-ascii?Q?GM6tSS9t7lV+0lVPk3KH8alm5HAcLT5s7iWB218OIMxNzwWZ28xYNGr3hmLR?=
 =?us-ascii?Q?w4aE/icIz78dB9jAGHkCEMNG+QuPSPJIk1xjqW2+INm7zquMTAR7/PRsK3mK?=
 =?us-ascii?Q?Nvn1pVhq+geLesY2lp8lUtrUPMSDpYI3XG+iZ5rKU02V1Km3pZmtAbki/im/?=
 =?us-ascii?Q?eYfgf186KsP3mvLL4rL7UsjgeYLIt4QeYUgNLYeJLAu58+sC5huytaCGjCGl?=
 =?us-ascii?Q?W+D6ihJVabiaReXT6Wfu1D8KL29TB4dQvYlNZiAlg98fRkE9kaPhNuHjt2WQ?=
 =?us-ascii?Q?07KhrejZbUrO1rY0EhL6MmsqmPBLJWUsz4GUmm58TDVhB4vdbMsqR8b2gEM1?=
 =?us-ascii?Q?LOyVUKRqegCvO0pFGA5PmckNO8SwXCkeZDjKo+703FQ+WOHfiVflc6dTN9oV?=
 =?us-ascii?Q?VISfIHA+o/ZPjTijZ3zhFVfObNsJaIGiRmIVD5bJnJtfhFiwcDNUiHj5yOIk?=
 =?us-ascii?Q?iMukTwuNvlxsAd91jBFPlGy3I9Yr6tqJ8q2bYy3VRqIhphfcvIdVUD3QWUn1?=
 =?us-ascii?Q?tLhe/eW6Pwn5FtklEEHMybXCBxqBgV4zGsG4xACeTV/ncUP/WZh4tdawKPqh?=
 =?us-ascii?Q?kp7F7CZHCiN+ICRRwr+T3QqjVbS9y3dJgoFM+61R1M7Hxx9xcJWqMGpTE1oi?=
 =?us-ascii?Q?9/irVNxvrC5UkGrKh6/uWvYQ5F7FrWbJ7yGEwuxInEwJ7jlDZ/jbZ/0Pn3x+?=
 =?us-ascii?Q?ygoI+PY2HXlUxyyoveUZBI62WrDrKBxBjagip0lbZdZ3wRLfoTWw+HYQkQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:01:36.4495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664a0f5c-5750-425e-3182-08dd922f0ec8
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5349

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi330. The smi330 is a combined
three axis angular rate and three axis acceleration sensor module.
This driver provides raw data access for each axis through sysfs, 
and tiggered buffer for continuous sampling.

dt-bindings:
v1 -> v2
    - Add missing type to drive-open-drain
    - Adapt description of drive-open-drain

imu driver:
v1 -> v2
    - Strip back to a more minimal initial driver

Jianping Shen (2):
  dt-bindings: iio: imu: smi330: Add binding
  iio: imu: smi330: Add driver

 .../bindings/iio/imu/bosch,smi330.yaml        |  90 ++
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi330/Kconfig                |  91 ++
 drivers/iio/imu/smi330/Makefile               |   5 +
 drivers/iio/imu/smi330/smi330.h               | 249 ++++++
 drivers/iio/imu/smi330/smi330_core.c          | 824 ++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c           | 139 +++
 drivers/iio/imu/smi330/smi330_spi.c           |  76 ++
 9 files changed, 1476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
 create mode 100644 drivers/iio/imu/smi330/Kconfig
 create mode 100644 drivers/iio/imu/smi330/Makefile
 create mode 100644 drivers/iio/imu/smi330/smi330.h
 create mode 100644 drivers/iio/imu/smi330/smi330_core.c
 create mode 100644 drivers/iio/imu/smi330/smi330_i2c.c
 create mode 100644 drivers/iio/imu/smi330/smi330_spi.c

-- 
2.34.1


