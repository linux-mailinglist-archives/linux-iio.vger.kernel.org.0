Return-Path: <linux-iio+bounces-19966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC35AC512B
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 16:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A423116D6A7
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F227A110;
	Tue, 27 May 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="iSgy0law"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B49185E7F;
	Tue, 27 May 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357157; cv=fail; b=r3RBx8x+Fbv57oeksoYHft1h3IfmcI+xB7IYQI6NdgPT24LFIDpT5REYOsxHOondPD6USg4Jol3LzLrtHWqT94rAZ347XBmuHLw13D1m2wTEINt31Pg8GuzaHLHHTEswuqrjTWkDmbJcbbefhTCA9BYIDHKQrpnOzWtfbv87G20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357157; c=relaxed/simple;
	bh=nziuJKMVozVMRXsy26glePr3KqK5bWYZsGNEZSH6Flc=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=epmjWLdWuMvdh/qTyVHv5AbW3VcdcCh3O6nD6N5irVf6ZS777f0uOmx3nNd9BmjWtLF0tETYf4V9A4wf4ncVhQN/xU/Pq+XAvdvX/da8QdQgpbQPc5eFp370aOVGNZ6A3CWMWwQkCY+/ZFtUF3b5fyLQdO0Jgwj/le5Ogumv/F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=iSgy0law; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgiWpUemfEDlSpz0ER/LbnBXrdTCVxS29DVfqt0Sar2O+qAgTBxHHmVfillL/Kq9FqSsULfJ3sfdw6bHhNDOmjl/Mi+paLdpTgjRTwyggR+aBD8qVgvfJqQNBOTUOryGk8BcmBPDqJymJVzu2VuDeGMs0sv/9FN7uw6G7HJPOrZ+s7FbMAAS5UnXsjt4IIEwXBacNV5Ff4QDiFe4KT9JCtTQBTv2A8iLan2OGVg3wCRGRrM24IVRCDInjNRf4oHzjcOjYeRH8LqiN07veqnRln5mG6XX1D8/0cKazIGI2zxM+LbbnzPwmYpHv00t6gdUGpGag7CoIoc7ywl/pYY06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAzDZy7BlcLXZDGEB+MaYbT+/wxZeK0tYMX/+d/TL/o=;
 b=L57wh7Mdwkq5oKoY6Cy1N9CvoB86GTy/LIWpST/0n1S0Y0U0ctO/hAwumQwi8mESSB7WN7X2+bcOgkJ8f++ocTyL/3zaOTVaCXwGau+bODpZDlwnS+R2czuzr62lWzLAHjZs2aiccDlrsmTcjOb21u9OOP80JhqEdvUz8VrF/q44gNtVjvxnXv9WqjlbEPROqDmOkr7sILPollNC/XagPmKcm087YX2L+l5F0B9gauDUXOFOLiS91CMzbZ5x9Vmv35wCfqP7BK+5tKwca5kftiGwlr/54xP/b0BkO64X1Yvp0pxiwsYgZZzmEUWfLL5nVGN2o+pE+BGSzBVvhxZ2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAzDZy7BlcLXZDGEB+MaYbT+/wxZeK0tYMX/+d/TL/o=;
 b=iSgy0lawUQtQkAk6alESlDnMy3HuyNV677nChWGBySa9jMg1O43QyfORW30kfJVXOa+cCuT8laCVxwxy/spLfgseFepObCWzN5a0ylBZzOBsh12IeoR6vCxK9Zk2h3FbeW1ie15c0HjR91C+Dl3XAGr5qgpN/El2+LCiDzCcMFo=
Received: from CWLP265CA0330.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::30)
 by DB9PR02MB7004.eurprd02.prod.outlook.com (2603:10a6:10:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 14:45:51 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:401:57:cafe::83) by CWLP265CA0330.outlook.office365.com
 (2603:10a6:401:57::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Tue,
 27 May 2025 14:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 14:45:51 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 16:45:43 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] iio: Remove unused macro definition for driver and IRQ
 name
In-Reply-To: <cover.1748356671.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <0dec4fe7b2bdc90d06163ac75a53b97d4ae31c21.1748356671.git.waqar.hameed@axis.com>
Date: Tue, 27 May 2025 16:45:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|DB9PR02MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: d49a8a9f-53eb-43a7-6d4e-08dd9d2d2d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDQ3pbJEbMiBcYGAB55OpgQ6Lrcqdk33PuNP0lWSdyShl0R2b7PmVibUxEvx?=
 =?us-ascii?Q?lQPVBawYhk1oz1fRpYJsoBIDYeVkp597Qop2U2nOxtxFqsmcA4IOqwB2e57/?=
 =?us-ascii?Q?0zrxSzzn3PsYBWUXQK65jglJJ8eF3F3a7cZa7QmEYom6w+6ddDQvPOTOskgs?=
 =?us-ascii?Q?zOmFygLKC9xzrxllUlsY7xzX91zzep4m+FCoQud+kVSqbSBIVai1m679YFCe?=
 =?us-ascii?Q?TGhTu7en557k/pBAJIPXiYl8z4ZOfExmwRkVNj6RyLxh0Nj8ZpzHi7bLFXTl?=
 =?us-ascii?Q?Jcvu80OQ56Yy/TptVWQqth5eTluC4NA+WqliSpKM45jyyQcxSYitRBr3ncAq?=
 =?us-ascii?Q?PkIMnue6cxIX/AFV8xyo7ZTYBTsxRFCc9vyIO47C4DZ0/MJxmBCeyMRxpR25?=
 =?us-ascii?Q?wKQVuZRJxdZKVXMFgx29YgszdWtJQhQnctt5qy5vi692iS/MwVJaWa1hK9Nx?=
 =?us-ascii?Q?wJSu+ueZrGwuPSS9aBuaz7yT2wKyOjUUf+/Zjv6JDfB1gqNT4iD3dEm4KTJo?=
 =?us-ascii?Q?tyMY17O4ZXiBMVWnB5zzo4u+IE4Lc9Ifm3F11el0I/Vddob8SXiw8H/Car4r?=
 =?us-ascii?Q?/FoYepFT7XKdbUdrrQmiGV9jIpqCUYvU4rzWwJW4R4znUFTkHQTqwG7j82hN?=
 =?us-ascii?Q?N7qcZ9NtE3rAvOp4n9ZQtKr6wLv3urkCjJXHFRIn/XJkfH1IDVx9PCbhcCAD?=
 =?us-ascii?Q?lGf+JqKuCH9OpYUrszBw5DbdHxogQJQ23rt+xCgMYtqMS6wSgx52zyD8k5SO?=
 =?us-ascii?Q?JqHmotEsM74uDUrdq48n5SVB4095tdW3dRYn5ikVFrSLY0VM+t57/rRNIJUs?=
 =?us-ascii?Q?CYoAvaajRc1xunGZrX7sGD2ateOZs1qSm97g3CzHJuOnshGUkQ8B6AN80xVM?=
 =?us-ascii?Q?MhnhGI53uO2wYkowrJrFUY+lo/C3VErk10wRTl4k5JQkhdmvkjmUS173ZsTn?=
 =?us-ascii?Q?W2M9Y/l26UIX8/3IoFdA0hOrJOfv0641mNKaMWQd0aLOYt3fAzgKfz5X45nf?=
 =?us-ascii?Q?jxfBG871pL1v9FldZ4l3mOzGJ8NmTBrcVkhzwvLWeMfcAW53iNb4EFxr0yTh?=
 =?us-ascii?Q?YuLfEJeaZ+IiHzxiYYE3bn+G/DVE5hEdZsdpRkcoH93JB+a+SvuWVYbbRFYN?=
 =?us-ascii?Q?nh53aJRsjQqL2KftCC8iB+rn856qm5JhaBVhHLEK+WC9ozfsalo33Quyza5L?=
 =?us-ascii?Q?pmhj/a6S53NkMlyvFfoNaPv++CMNbS2Q0gtgVT1X6G2YbThqu1tNKawdgn1r?=
 =?us-ascii?Q?nWk8mG8tOjrHzd8EsynRGV4ppn7uriayzZv700HkqtyLJfrJlUPfTJ4yarbN?=
 =?us-ascii?Q?4xBRCUaUco/iFJPDYFInZsJlOm+/StttWVqcYl7zUxAKSgHosBPJu1si17Ah?=
 =?us-ascii?Q?Frci7ykCL5cpM6npnf2c0oj1nyxY1g8IjnGuVYepTJXIJnpIYlqIJT0gngc3?=
 =?us-ascii?Q?18kdOOlIJvIkSn/Q44wrJyqId4Mvue+EyWle7H08ZxU8y0GIRVpFn/gyfpb7?=
 =?us-ascii?Q?GN8/rYV916BQwYT9mvznYedcwa1PTqBoFNos?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:45:51.4865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49a8a9f-53eb-43a7-6d4e-08dd9d2d2d48
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7004

These macro definitions are completely unused. Remove them.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/accel/bma180.c             | 3 ---
 drivers/iio/accel/bmc150-accel-core.c  | 2 --
 drivers/iio/magnetometer/bmc150_magn.c | 2 --
 3 files changed, 7 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index aa664a923f91..61349e47a209 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -29,9 +29,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define BMA180_DRV_NAME "bma180"
-#define BMA180_IRQ_NAME "bma180_event"
-
 enum chip_ids {
 	BMA023,
 	BMA150,
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 546839d386a9..be5fbb0c5d29 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -25,8 +25,6 @@
 
 #include "bmc150-accel.h"
 
-#define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
-
 #define BMC150_ACCEL_REG_CHIP_ID		0x00
 
 #define BMC150_ACCEL_REG_INT_STATUS_2		0x0B
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index b757ed55e99e..4b665635260c 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -28,8 +28,6 @@
 
 #include "bmc150_magn.h"
 
-#define BMC150_MAGN_DRV_NAME			"bmc150_magn"
-
 #define BMC150_MAGN_REG_CHIP_ID			0x40
 #define BMC150_MAGN_CHIP_ID_VAL			0x32
 
-- 
2.39.5


