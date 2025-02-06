Return-Path: <linux-iio+bounces-15061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BDA2A0CD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 07:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F6D16107B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 06:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9A2248B3;
	Thu,  6 Feb 2025 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RhK0lfMP"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129213FD72;
	Thu,  6 Feb 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822570; cv=fail; b=bLMVVW4UPZOe0fBHHkbMS21N7mPED3WmQCdSbZBR2Ic7Q6OleTPATBbCHt95ALrhO5hDGjs6nuWm4ngRzLAYiD7rUbLZw7rj3BcYlO4qEeBoRLgeiySAlFTJyOI861//VFOUNdTFCfypZqaWhZBytxdZmmAfKq2SJkhdWpQVHww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822570; c=relaxed/simple;
	bh=kTmBUkDZYJK1JxsCpqmzMhnt3MYyOqo3jk6+st9Wfas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDDXPfTQCrHg5nyLIU+s4He3KSy685IioKWE7m7Zz03v0gJ4u5u0PYZAqVHef9Ugw8UMve53cMTUgVZD9SCkjJJb0lwOcixNFrNpOv5TWBb+OGqUVodudjHBOqzUY/fmLPOSIQ6IhhDe3Wo1hZDlEUtJmN7ykPV+COWrhyFubIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RhK0lfMP; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLruVXqHW+TrT1rdotV9H3DVkqDQpYwZ3rypbEAcJhLCQiLo2dn1JJwMzcCqQLDjQ6SYT5TFyNI+9bP/cuiRsXFdqd0Mz6+etqyVuwpF3udZ5c011isM3xLU2xyLvBrYjq4NxU7hOeFf43pOsGK5dOB6r3BLpcvCHvHYKprYpVzdet0SKkzc6nZxOtRia0ssyKSUYz0MF0e9o+qwR66H0y8K2BdfynrBj2OpjIOHSdHmRtWx7gZlfsL0Gz8U7ct1J4nCAcw0nl4MPzSROjJPRAb27JlcgRa2idz1KmO74lYQoEJ47ByTbwHkHuH6ioajh9xsxEpgg/nTBfIGf94FMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlGQItFktrwQyw+IxKzAMePJQST8RFG2qApGLnxAKkI=;
 b=faV6+ldMY6XMyjZ0WXH8dJNT9Rgp2Hfagr/WWi4mmRbIqGND9VCPyH1mKsTYwXwN9nh7WhP/uZVAIJquHQIyXSVdjbvB4YDJvbKzlCfXc1q53NaCyz2IQRy2BcN/gyllBDK9qG22M71pslH81I13p9bVQnkMyPYGDGvGChOWyDO0vIOy62qAbQRD60guF9VX58DxcElLFRgYPYw0gci+nhyyI9QIhPIivz/lGXluaHegMXCvf3z+ce9HaQVnbyoWta9OrihB7ZxMhHGW7T8xFU8shsg9DeupAqBPBWt0qKATPXYeVaC8TgtMvIedML6MRF0yCwmUMUsJNys7nDWlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlGQItFktrwQyw+IxKzAMePJQST8RFG2qApGLnxAKkI=;
 b=RhK0lfMPxLks9XSwNZw0ZnZ7w5fFXD78nHgXmhzT8Lhp9Hwg1/gP856Uorb6pJH5Gn//n8pv+YUFLRXH8UxF/oxt5wxwl1zt66I1bBcjYE/vFDkdc4z8XHAaBO+rXrJlw5GNxhz3Jb9yHecigIXijyW9FmigSFttFCOO/akze64=
Received: from AS9PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:20b:46c::25)
 by DB9PR02MB6538.eurprd02.prod.outlook.com (2603:10a6:10:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 06:16:05 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:46c:cafe::4c) by AS9PR07CA0029.outlook.office365.com
 (2603:10a6:20b:46c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Thu,
 6 Feb 2025 06:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:16:05 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 6 Feb
 2025 07:16:04 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 6 Feb
 2025 07:16:04 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 6 Feb 2025 07:16:04 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 15F334A8;
	Thu,  6 Feb 2025 07:16:01 +0100 (CET)
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <lars@metafoo.de>,
	<krzk+dt@kernel.org>
CC: <kernel@axis.com>, Hermes Zhang <Hermes.Zhang@axis.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] iio: add IIO_MOD_NOX modifier
Date: Thu, 6 Feb 2025 14:15:15 +0800
Message-ID: <20250206061521.2546108-2-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|DB9PR02MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: af463cc6-7cd0-43b0-610c-08dd4675bd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|34020700016|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OeD9oW9lf8IdWifr1T07vPBEUa9nG2YpOl0lGJjLmf8xxDnCUgKaiGTb3Aby?=
 =?us-ascii?Q?8TkoqgPfxzeTAnynEYFP0nMR4KL1h2+6I2pl91d1GZ5rERqosMGIAMBG8u/O?=
 =?us-ascii?Q?OCGf6cawzKJf0rOyQcn7bIZZgqO9p40RdZE6SgXjPdNcR8SXGEnZi0ht6DGb?=
 =?us-ascii?Q?1KPj7fxzTi72RnElIZx08RjbFVLtE5E3vJKjr38AePuKNRhplOlsWZwrAO3T?=
 =?us-ascii?Q?WLDUhOlNYg569vuj8lVgwZ52CKblMlqathytG4UXcVrlAoWj5qbY0Bt78J8N?=
 =?us-ascii?Q?kWxSEjKHvAriqFDzqn/oolOG9iln/ldj/tqPebeMSCLdS2rSMHj1YgEhBuU5?=
 =?us-ascii?Q?ZTVqwq3q7TCSSfp46lx14e/FFL6QsR9T0aERYHx4P+ql8CtnEOkOtpiAvoZP?=
 =?us-ascii?Q?5gg0qi3PmiuagPCFIPqbkvpvlrfMP4foZgpIXDngRhkc6C32HtBbWo+st8Tf?=
 =?us-ascii?Q?8jUwhH5SvmbHdZ6KVlo0TdcuSTuYRmdjIH7CGeVN0ccWJl2Gpu/wZzYed3p/?=
 =?us-ascii?Q?L2Ol/n94mrX41YYc1WMMd1glVWi0CzBOoKYohWHBGVCQVUtiu2RaEf6dF1lt?=
 =?us-ascii?Q?sQFB4VBL2rTcX6jnUdIkkegWcPab6ATkXup/5VxKcBavz+1gsV2J0Wfgh4Zs?=
 =?us-ascii?Q?b7NtPw3Cfxngtff1qDYkfL9lVRjjN4SD3xtnyJLBTgyD5kjDB1QVQU8oH0ni?=
 =?us-ascii?Q?kKyRttJvKxxwI/wLV8kYx3N9fxFoTM2AkkKuxhGmSmKPDwDCAR6Phrg59sXd?=
 =?us-ascii?Q?O9olRPcioWIvjxE/td3z0e7AuGY4jEhKWGVObsKuMd3MWgWLKV9SEvQcQaJ5?=
 =?us-ascii?Q?lOFBgktVo9BNlEbBMba3+xf+swaUn5PaxnZP/Qp6g9ksT/Ru6UprggfEvS8C?=
 =?us-ascii?Q?ZkSiMJ5gn5dK71DwF4gKjgh90V1RKDdxyXq2M2KcFYV7AwWt91aY+02PRiC/?=
 =?us-ascii?Q?b+L+7BzjBv1z1iCf9IkqRue/q6UWftfuoKg32YuRQxmr46R+XZsiKBJLb82G?=
 =?us-ascii?Q?5lgCWhdp7sWdTJviv5ONs3JAFG4s/PCNydlNfl3DfwrQPhDaWy2B9+7F0TU3?=
 =?us-ascii?Q?IkNn9GCG3EbV+Tbh7XNnInIhRQ/ddpWHWlZkHXWxzO6V5/RZjxrbr1UC5jrX?=
 =?us-ascii?Q?YnHY8W8533QNY+SIKkUZGNBfLYBwiKrpJLhbpCGA7f1RgWQ9ozQRVZ+k2VAB?=
 =?us-ascii?Q?xEHJtLixDM1UAWAeULRrQFOi37LxLyeV0+4f92Uwn41B8TDGUw9zqGRjhw6q?=
 =?us-ascii?Q?dJ4lmIWv4Jvb5IFnX8RGAUI9g8uwk8MgL85io6HSM9TvBWfb1Gy2d+d8Hr5P?=
 =?us-ascii?Q?ZXrKbKngMkX2AHAcWf0SQ6D2OnUKfOfrto8i6poRDnNqGN4yDJCmOP6eKbsA?=
 =?us-ascii?Q?gy7y41J8LZFaXTkZscREco9M9cNw8UUSgcEfBpiNfg9+qQtZyaDt8qJ8Hv80?=
 =?us-ascii?Q?wdto5pDQS88=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(34020700016)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:16:05.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af463cc6-7cd0-43b0-610c-08dd4675bd26
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6538

Add modifier IIO_MOD_NOX for NOx concentration reporting. NOx (a generic
term for the mono-nitrogen oxides) are used in environment sensor as a
parameter to show the concentration in index format.

An example case: https://www.sensirion.com/media/documents/9F289B95/
6294DFFC/Info_Note_NOx_Index.pdf

Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..c7d54dc1f226 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1898,6 +1898,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_o2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_o2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_nox_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_nox_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a2117ad1337d..6a85688c9148 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -151,6 +151,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PITCH] = "pitch",
 	[IIO_MOD_YAW] = "yaw",
 	[IIO_MOD_ROLL] = "roll",
+	[IIO_MOD_NOX] = "nox",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 12886d4465e4..f7dfc4c71495 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -108,6 +108,7 @@ enum iio_modifier {
 	IIO_MOD_ROLL,
 	IIO_MOD_LIGHT_UVA,
 	IIO_MOD_LIGHT_UVB,
+	IIO_MOD_NOX,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index cccf62ea2b8f..51c6f753e7d4 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -138,6 +138,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_PITCH] = "pitch",
 	[IIO_MOD_YAW] = "yaw",
 	[IIO_MOD_ROLL] = "roll",
+	[IIO_MOD_NOX] = "nox",
 };
 
 static bool event_is_known(struct iio_event_data *event)
@@ -236,6 +237,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_PM4:
 	case IIO_MOD_PM10:
 	case IIO_MOD_O2:
+	case IIO_MOD_NOX:
 		break;
 	default:
 		return false;
-- 
2.45.2


