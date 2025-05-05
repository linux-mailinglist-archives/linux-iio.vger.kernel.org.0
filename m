Return-Path: <linux-iio+bounces-19108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F02FCAA9756
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCB37A2943
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA5265CA0;
	Mon,  5 May 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="eFYgxqub"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DA25D204;
	Mon,  5 May 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458280; cv=fail; b=LMywYAUymrwzzgG0J29HL7Y0ny4KdYWWcN7mOxQa91ksZ9DwW1f4HptRF57XKNwZ2WsR+iGedb3u3NWnhpaAzsw4s7NFiEY/szdoa/TqXc2ljNZOZvS7LFwMYowcVpY25TSviZQJ4pxSxziTOqi/cM/JUgsqdPrW5IMWXwEXWWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458280; c=relaxed/simple;
	bh=PTj1MP1WIRGuu0nZm4w8Ew+GTkJXFlSXfC9J/2ahsVA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CDue9QFnbpszcvg5yhW41sXwM2WWaMG6feN0GvAzOyOV0Loa/sEqiFkkiOdsg5R4btltfXQDHhd/kSaXu++xqupFFq+4u6VIc02Dzoh/WLPGSaXBGflX3NdOxaFTzMekGyqbH5XlS6JzmglU7SxzUzIcQTWfa2tSP3shrC3pxaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=eFYgxqub; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgQxlsbl9JUnELy17u0nXDZEavJa10Bp33xWmCJvxU/1ArI6FiKGYQ3uUpLgxJctTpO1BhYxDQeCAB35cZOsrtWjkJgp9TiD9MJpId+jhaskyWagt5MFaIpSob1vzDX+bBz8WcmKzF9Xc76CJ+xifJdHfF1J1pS3wP34siYDAuQJ3c/dbNSz+dh8MwVu7wtGwwN3fVdpOOFOBe282TkIwqYrpYzqwrqH/STUtCrqEZfKmJf0ycVDX491vUF+QRdqFFn1RNqyuLiktrq9Ti0m2p7Sgy24qw60Y9hVahesiqPbHi1eT2hRGCMcZSteMQZuqkhX3nlxZPu7gMklxTKpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4RbypwvohzBv2l93lo1dOGouqk8EROORnX2dMZrXzM=;
 b=FjWmOXvp7NEMnEYZGTUrejsJVqUynwjbIrR8chBK3qozgR8h9jRUnVZOMqb9GHB2QltUVevfAAZKWNUoHZ9HJr2Uss1SZdsqSYgRUnjXBwepUqIUc1AXTLhhWZc6dINiypx63jP3CnA1hgwJaDK+QQ+6IBh9Dqi8I9SorGV2AZpKXEi9XOw0H7h0pj9HpTqxjcImFEKBbMKBCdpJYxhLepfjn7bKHgVRmJ/MlMILq++87fYPB+WzGyPr1pz0+FLhlLtgMJgBTsc58bOhbbE1hWR2FzzPsj0g41KkKuEP7dalkM+SXv14t3tRVLBq6j7q1Rr4/u9W+uDAAVKaTCM7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4RbypwvohzBv2l93lo1dOGouqk8EROORnX2dMZrXzM=;
 b=eFYgxqubFdubSutXJk0NmMo+fdpZ/zkIMG98vf18KpIwEChSG3Z3U3gQ2HDI+Bwh4stIWvr/mJcoRj7EElBdb+1rqruVdJ5kSVawwNOI2QWLs/L2IQEzTT/L6T75qI6+Ren6zoEygU2F9c4G2epU2+6om+H/L8/NUr6S7H0ov5crOspy+JzXAyjdoAA1z7o9/ir8NKeZOPailEA8zG+Z3rRVeyVPr30wANd/r/ouCSC7UL1xZPaKrJrrtvw/A5+OEf4kWuoGySsvUwE5Obao41DozHFBX40uRWjXRWr6SX56WpMFtKNQ+IX1oD26FFhKJ68e7JuoYUUn1/AI79Y4gQ==
Received: from DU2PR04CA0317.eurprd04.prod.outlook.com (2603:10a6:10:2b5::22)
 by DB9PR10MB7124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 15:17:51 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::5d) by DU2PR04CA0317.outlook.office365.com
 (2603:10a6:10:2b5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Mon,
 5 May 2025 15:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:17:51 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 5 May
 2025 17:17:46 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Mon, 5 May 2025 17:17:45 +0200
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
Subject: [PATCH v1 0/3] iio: imu: smi330: add bosch smi330 driver
Date: Mon, 5 May 2025 17:16:38 +0200
Message-ID: <20250505151641.52878-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|DB9PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 06aef56c-b950-4e02-3b96-08dd8be800ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vAxD1xf92MPF/kKpZyireSbpnNtOjs9EBxFnVB44FHDp1hTOpvlSH3oep1C?=
 =?us-ascii?Q?KCcsbb1C/MVKspWpjUYGFT5JNHxjn/OTqbHYEvrj0knn2mUbwPK7T2Su/JNk?=
 =?us-ascii?Q?yYNkMKbDzGzMLUx9G7/B96Iw+N8dJVrkqWlqllwdzPEKptkM4Qdi61AFLO0b?=
 =?us-ascii?Q?LHEe0wboS3l8MmUupdDuYT4J/xIJNuo1lEqHzEDhB+jrOUnc37TeXZwAqOp9?=
 =?us-ascii?Q?bFwBzUSEfKk+4EWMWIedisjjcE7eJHDtIoOf056YdvVG1fK16sq4rxsDH+Bj?=
 =?us-ascii?Q?uENtmAk92SZwjqV00FrVyYWdkz0oOsQRCR2uWBtf98nbWOe1h8MFxAxxFjBu?=
 =?us-ascii?Q?KYTAgWTj3765vkHKzRVvR1GjEYccn7nNDh5TjkaXAzNdzdt2vTXzuaaBzJhE?=
 =?us-ascii?Q?xkPvaORnO7x3kEyN5pZArckY2a/eK6jU07HL98vOuN4Upp1F4taY1fmQ6D2q?=
 =?us-ascii?Q?Be3q4OXYAe7eOKMLdmzq4YeVcz1jMA5h2dtSmiAZrDlfNr+TLU4bbhRi0Xf2?=
 =?us-ascii?Q?YkONrVE3V8TNIhO7HX+o2GJDvot5M/9Ot4PvEUfnJJjiOoBcX1c3R4ss/rOJ?=
 =?us-ascii?Q?UyfOptNaLdUCMf8K1rOObDLdMeoQNgH/6P5/0fY0WytG4V518hjszhhexDm/?=
 =?us-ascii?Q?oWtX64AATcka1PKtmvS4HN1cD1kHMo6MFh3SvtdVoy85ynfNmLiM8c6zoYiw?=
 =?us-ascii?Q?qIFJMeJ30nFQ42ZshXz6dpTlgHCvUM/fZRbEDRV9LJRBLT7Ushfh6d/FTdW1?=
 =?us-ascii?Q?MdTxFDWkqDx53+mGVehfoEJRa8Q6W9QKr+Vw3qPX/W1SAKSrTHzYgD3tI3+W?=
 =?us-ascii?Q?1ikhsTSdivzryRZR+lnrC2FMiunhgHJF4phHEB0fsKawguFnWsSvkIFn9EOW?=
 =?us-ascii?Q?dB8p9ri75j9LCpBJMVFHQV78Vv7mse3hbk0dx6U2ogUqSpZls9V8wwqmlpyW?=
 =?us-ascii?Q?Dtu0gHYRUHPKZdTIYcLqy9LyJzs7gbMDKYvtoMsi9A6mXT2GsUEW4J+JdchG?=
 =?us-ascii?Q?6R+JD8ULXaU4NiD9vH/9WEHxx8MPTi7RD7aBXY1xAo+3YBwZIPHkqW7NGFMF?=
 =?us-ascii?Q?X6QkeVnCG2HzeRzSjoUYGVlB23lF1Sp5cdruh3flwV1wSPdushKvuEQK/CKT?=
 =?us-ascii?Q?QEu2bWgWai0R4NoK1S8oK0m6owHlDO/k/cm5De8+ASNsj8zbZJXpttGVlqs7?=
 =?us-ascii?Q?RfO/l4KSHP8KSb2Ndoj5lO1kZ6ucuOozXwFFRjZknazr86lMRjBGLbUemaT2?=
 =?us-ascii?Q?6XHiSqfSeC7rWDgvZVbc8uJPAp/72BUSAzbGG9s9f8Wcrs/r/ZCWPhUqwEkL?=
 =?us-ascii?Q?Cb1hTwCT4vSNWISasUPzr2PhEGKEAyov7kph9RenyIbUIFPQ5df26ba0dTpA?=
 =?us-ascii?Q?f42GDqUSYofhEouwm/taXjXpFUmWReXQE25xIxIiyt2B7K2aQOTHRlQz/5Mm?=
 =?us-ascii?Q?4HUs8cyI03xa6MJW28zLjUFUW6WLWBQVfXScv540z0uMQityKjVNpzZc8paf?=
 =?us-ascii?Q?si7UXQ4chWy5aZwWZPTwsarAYyjK+Yi/qoFRQ28g5nU12ZgQBlHYO+EV8w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:17:51.7345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aef56c-b950-4e02-3b96-08dd8be800ca
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7124

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add the iio driver for bosch imu smi330. The smi330 is a combined
three axis angular rate and three axis acceleration sensor module.
This driver provides raw data access for each axis through sysfs, 
and tiggered buffer for continuous sampling.

Jianping Shen (3):
  docs: iio: imu: smi330: Add ABI documentation
  dt-bindings: iio: imu: smi330: Add binding
  iio: imu: smi330: Add driver

 .../ABI/testing/sysfs-bus-iio-smi330          |  149 +
 .../bindings/iio/imu/bosch,smi330.yaml        |   89 +
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/smi330/Kconfig                |  129 +
 drivers/iio/imu/smi330/Makefile               |    5 +
 drivers/iio/imu/smi330/smi330.h               |  351 +++
 drivers/iio/imu/smi330/smi330_core.c          | 2608 +++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c           |  140 +
 drivers/iio/imu/smi330/smi330_spi.c           |   77 +
 10 files changed, 3550 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-smi330
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
 create mode 100644 drivers/iio/imu/smi330/Kconfig
 create mode 100644 drivers/iio/imu/smi330/Makefile
 create mode 100644 drivers/iio/imu/smi330/smi330.h
 create mode 100644 drivers/iio/imu/smi330/smi330_core.c
 create mode 100644 drivers/iio/imu/smi330/smi330_i2c.c
 create mode 100644 drivers/iio/imu/smi330/smi330_spi.c

-- 
2.34.1


