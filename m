Return-Path: <linux-iio+bounces-24872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74CBC9CF0
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155983A820E
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659C1E32A2;
	Thu,  9 Oct 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="SoLuz0HG"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE591E9B3D;
	Thu,  9 Oct 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023975; cv=fail; b=pBYezLcro7/11MbkzfzjA7DibPJWC+69qMhNObF0mCRF/+jAgNXyncrLBdjvv8ulN5uZAIfmsgkzTq47i1Rp8wuzJuzcLXFH9w11wNO1ig2tQugfHhX4ZxZqEhiFDZBYdVJgdhtoX3x6w/AiRH38XHZcl8brJftO+1HKsA+YTTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023975; c=relaxed/simple;
	bh=t0saXMXh3ba9fNp1Q1wfVsPZjwDfZPVfY0YR5go6wgk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hBV6ndy3stjFvRl0QBUEVS3WPEG4npGMdY58r2DLH2CQSfY4KSl8HNI1F7RGdpU9dNSkEWStP7awra/mo68jPXYRfTm71GUxMB38RI3/sIhJliMpHx+R7J2Oc821A21FfXdxLABKGtY6k3tPE3QtQVohGP0B8dZsjaQpyuHgr3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=SoLuz0HG; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4hencqsaoBPq6mng661uCf8+Mz3g1Qp5eHd1jnbZ+kcdoXMr+og6OElGp1rpMSO9XtDMmu87PbNUCojIuhF5z46JLFH8bZZaHSR0pR8U6Sty2+QWFpxofpZdmr7C8thfZQLVrFTPuEkEcTK5oFnLdpxWr0QqKTtuCrK1HIWGOJI5ZRos6scbJfTOu7y5nvDLvN+wssKRaTTAYVPl2qvapKXKPyZIgOkK1+8uGpRV+uwJq3KJZT5VegjOaQUn/rd2yD65nhMUxLNnCgCLhTy0w23lPQgGx3ptyCoy/Y67QKXbNgHq/dUPV0VJe3GsHLgDxSiM298VbGFAoq/6JdrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs2p4weYYoqCJsGVucmPH05AvAx9LyrVqswKJM8S5eM=;
 b=XyQKdUM3tvNhwgGJFwbV2GO+p+BpUP8mONWS4QHsr+GBxPfF8m1AmNY9Wx/1o8dIelHKVH6yw5z733BpCqnAQnE9YL0zdORl/wsTXvQ0HciSkfCUnsmyMROlbYIlEy804EF/idc0kFU4NV0ZU7eJoDWKQ2Xm4D6GK5GoqxdNRjeeb4fV/cQhIPyVAdL750ImF5lUsPHX1Z4jl4JUtIHpe6DS6PnCD5sWp7z0Qb6EPWbICQbQ4El9sqwDbcCFzEwUD2MDSR+UB2ad3Ip/U2ijl8Tk1aakZrjcVNZTZlIz1cjzENpCHsz+JsJgX7LNwcbrkY1ru93D5GAlKgP3ZBRE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs2p4weYYoqCJsGVucmPH05AvAx9LyrVqswKJM8S5eM=;
 b=SoLuz0HG1JHmKBvbj7Q3+pXPkEH1Ypms52DHpd/EPg1DrlOL3TV7Epm3F9oe5ZwHgXSTFKe69mFaGiZBfvAHdjfLWb3Bb45B7GV+9nSLux+K2X9gxDW8PYsbAf6VkDbXca0etNVk9FXmjCldatZaeusah21qZAUxw1VDfOru+glwlv0bU0T2rHm/sdqpv6TqZ4c5ZXtB/c+Rz/HUBxKb3gKTT0tO7kll/6siJWe6meN8OL+eGw0IJzPqSY9hBpO8U23StjrNx4adUYDoifZZYzz8mFBH8YpiARjTUx8hMG+u/WlPWMCLQpOoZAyrwMATtMpM+ZyYDnulvFJsujJ7GQ==
Received: from AS4P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::9)
 by DB5PR10MB7773.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 15:32:48 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::ed) by AS4P189CA0020.outlook.office365.com
 (2603:10a6:20b:5db::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 15:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 15:32:48 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 9 Oct
 2025 17:32:47 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.188.136) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 17:32:46 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v5 0/2] iio: imu: smi330: add bosch smi330 driver
Date: Thu, 9 Oct 2025 17:31:47 +0200
Message-ID: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|DB5PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 866722f2-be34-4003-7030-08de07491a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wr4EQ6RLfnAuKAi6jwI91pqjnx1bCew79gtisHIIkPmuQGVZLvOXN8JzDKjy?=
 =?us-ascii?Q?x0t7e+d/J6/JvfFBKl7snjOfFXo4IjE4QpScEteUtc4Vos1E9QkgRRIkNdbi?=
 =?us-ascii?Q?maskD92ln+DxyHHLo6JMtOP5b1ziwm8nZcdkXlywvAcqGtIuAF2kMt0gDnp5?=
 =?us-ascii?Q?52KnDpgpwxjh6Or3pWFzH1IsCpgemdXxZXnXrXZQvpFhQFfB9KJ0X5HoW0ii?=
 =?us-ascii?Q?zL7s8qEWk+BfpmoK2W7SKMHbthDAl65tqgE+t2V57JRogrz8SGWanfo59Ikh?=
 =?us-ascii?Q?KRrgE4OSXZ66AV3mk6133dp/eS6TO4HWI7OOwMSp/GQiKo7HMWOD9pRvYoLB?=
 =?us-ascii?Q?Jhe6XOupj9EzfYI0WWNFgOIIswIXYXZ2oXgOcxsTcHXsLT4LRshxT6XV/x9q?=
 =?us-ascii?Q?uDsMfqlDr31vNt02fmtKwl3LsN02GUTZEE95nm1rNHmC2/+aZnYOPjcQVLsN?=
 =?us-ascii?Q?tKxhNsWCth9eQY5Elye/+JOa3Q7iYwA/Z16xR764rzKgmg1A/JPHPgfhOLXQ?=
 =?us-ascii?Q?5xSwphoyuk00TOkp/VCFEAl4nHTWCeHlEyKRoaWb1Kq0SchUDtsqQsGTEIml?=
 =?us-ascii?Q?kx9hoAhykd1s4hL4eAz8zsguN3T1dtzbpc4Ljf9LMTFxnOM83HzJ7U+Uu9da?=
 =?us-ascii?Q?6+WKQzquJfQqG21YWPeR7EWYgWX5OTTvxF9Rg2Si6t7KX2JOZCUg2WoJoY7w?=
 =?us-ascii?Q?Kfgwe1/HO9X9MRKGVa1/6xMuVDh0flOn4kzSFyxrJGxpQvZLxeyyYpWgWRyI?=
 =?us-ascii?Q?dV+tVNJ60t4mFW4FsRGbDZ7jDdceZnZWh52sfT4SdtxP7SzOkuy+pLzmsEoh?=
 =?us-ascii?Q?O4iQM0bEyI0VfHP4joL/QtgeH17k7vWXewCGqT7AgcDjYr1RnKtUu+2JBVwG?=
 =?us-ascii?Q?N03oHgIfQJAEkq92/Rv8CqN7Z4072WUYsBgvrusR1ZGt3feoWy+L4YK6S1Uq?=
 =?us-ascii?Q?fKn9sMga/FYrDNrhdAOsOEkt/fiYKUY0r0F8ocEHR/uvzvLojVOIxLpC8n2y?=
 =?us-ascii?Q?X0DxSfhUGycz6/PihyahOElqQkQAueRd23uVCna7z63M5qL/QZV3080bckvg?=
 =?us-ascii?Q?RSR8koAZxBAi7pwq9WZEo5U31zoVdwZrlfDmYjJ8i6MRFTZvyBC4RhEERdK6?=
 =?us-ascii?Q?TfM1PoLDiQ3XzacS17dbG1qVGIYGhewaqlf2CFiSsYgsvMtRApocgc216KAu?=
 =?us-ascii?Q?n30UnwjZ2Pqc6PHGj8R2At3zAJkCdVano6PLS7VZAWGi8CiQmiiJY2+LFyBX?=
 =?us-ascii?Q?qHznyV8HXUYZg9R1RRxKT2eIS7u6wTuE3lOemdulsxRNDrFuaByhmeWP+Gpv?=
 =?us-ascii?Q?zbME9OxX40MlVrfMxrzZLD1Y806hXySxg5d8NTI//v/2jgXYtBlcJ0sV7hEy?=
 =?us-ascii?Q?tKdQYNnHr2CcMjJDgvQZgYkABXDyPPkPRX7mzdIvxKQmJ2X4O6ZVpTWzD5PD?=
 =?us-ascii?Q?2glH34GraFT3OBHp3J6id01XxKKS7izccnkzCgiYspn/tzRhWfFKE05irqB8?=
 =?us-ascii?Q?9m4dYzqmYao/fJ9bpvkVmhhYIVEVkqbEBcajkM1NRkNPU51afK2J9IGxyEx1?=
 =?us-ascii?Q?AYsIDIimU1dZDSLKlm7yAH+WRevum+3nQr6hcAOY?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:32:48.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866722f2-be34-4003-7030-08de07491a0d
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7773

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

v4 -> v5
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

v3 -> v5
    - fix kernel test robot finding
    - some other minor finding fixes

Jianping Shen (2):
  dt-bindings: iio: imu: smi330: Add binding
  iio: imu: smi330: Add driver

 .../bindings/iio/imu/bosch,smi330.yaml        |  90 ++
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi330/Kconfig                |  33 +
 drivers/iio/imu/smi330/Makefile               |   7 +
 drivers/iio/imu/smi330/smi330.h               |  25 +
 drivers/iio/imu/smi330/smi330_core.c          | 918 ++++++++++++++++++
 drivers/iio/imu/smi330/smi330_i2c.c           | 133 +++
 drivers/iio/imu/smi330/smi330_spi.c           |  85 ++
 9 files changed, 1293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
 create mode 100644 drivers/iio/imu/smi330/Kconfig
 create mode 100644 drivers/iio/imu/smi330/Makefile
 create mode 100644 drivers/iio/imu/smi330/smi330.h
 create mode 100644 drivers/iio/imu/smi330/smi330_core.c
 create mode 100644 drivers/iio/imu/smi330/smi330_i2c.c
 create mode 100644 drivers/iio/imu/smi330/smi330_spi.c

-- 
2.34.1


