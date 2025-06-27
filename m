Return-Path: <linux-iio+bounces-21004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8FAEBE9A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 19:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4745F1C61D7B
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015A2EAB8C;
	Fri, 27 Jun 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sesame.org.jo header.i=@sesame.org.jo header.b="ZyBUfD7D"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023088.outbound.protection.outlook.com [40.107.162.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4E2EA148;
	Fri, 27 Jun 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046688; cv=fail; b=jc9jYd5bxYqIlwxj1c4xk5rLiQCZHCnvQDPdIz2YXU+1b5p6EEqtHbB1+p47QP2Kz/a+Zm/sQM2LpTbn5ZjsXz6Gvz1SQTujO3v8DEtvOjU0GmVB9pUHjW1E45mgY7hTTvDVDquTIHzhtGKJYI6b9pZZT7CkFIjMOH3wPMl/Fh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046688; c=relaxed/simple;
	bh=B5LbD6sfzcRd4pwEStTdKe6tMaI8Dnjp9K7t1Ggr1w8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=miBto7vzYKx803EWCOYKeX2m3bgsolh5l/4OIxo3FvYOngF24MYQn+H9vwbtOKphskrEBizFcebeeJpZq5vqhBzz6ACf0pD9VXkMZX1C5kq8StUz+J1fhkq7zyOsKgAok5e9sRNtiuFTE/8xiJUVfv5gjPAn7Iq8+/3DM7HFbUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sesame.org.jo; spf=pass smtp.mailfrom=sesame.org.jo; dkim=pass (1024-bit key) header.d=sesame.org.jo header.i=@sesame.org.jo header.b=ZyBUfD7D; arc=fail smtp.client-ip=40.107.162.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sesame.org.jo
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sesame.org.jo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtdJKNfwXNeCiFxgKUXfBftcssM4yP8Z6XNu73OuMTedTQqpnw9htW4PBux4EXFYelGzFcLxe6fwArSqwnTNC+jrcW25SaTji3iXsSC4vpOP78kt+8nxto53RfhUfq2FCToxZZPF523YpoRWqMkILnIpvcMX23ewh8aT/HOaQzrIvNaQ02HgykKO5LPGZVxGJc8NBBCOqw69RiMWj/CsRDWBO+k3yr1GvagDLyoAZEitloaIwqH4/QLZNvYQROgd4huow12/JJRhgrp+PBHsdtBjAr7gKNYK9wRK6F2OUNMdWfomaZPWnePllRjwJHY6xB2j9Xkygaf1WDCZlZgGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KESVAxK5UpgNFFfS1dic0yDQrcUFcwdvtxMXpBfymMU=;
 b=iHGhsoHz7vEyjc49BRs3WOZWV19GiBobsvErbyKS1juEwrtFYbnUZByVl0QgkQnykSxKZQX6nsOVuqPVtMX+7w7XhyepWFZmO4b8jO8UJ1Ru4oHKSWD7c0WYJrFKx+cnSc5gb39hev3Qq2vudbKYCtYxaMKKG5oRu+CTV4QaIlBXqITXTmTi0+3CaLhAWBAzsgAl3tvBPPoDF7D1Q16DnLLEVkbpd9kWvkwVF8P/mtJmkgCKa7B6npIiguh46DmD9ktbMsU2cdV0C0cwx4tvteJ0nHmbWRUUKjWGo9TXoU/UOKUyJgOKTCPivg8HUkziGQv1lrGgSQLMedPjMat6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 80.90.171.68) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sesame.org.jo;
 dmarc=bestguesspass action=none header.from=sesame.org.jo; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sesame.org.jo;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KESVAxK5UpgNFFfS1dic0yDQrcUFcwdvtxMXpBfymMU=;
 b=ZyBUfD7DnKpifSaVymAxFmGcf2wTeM/JpddADrL9agFSzeAlViHmvpb+Vvow7yyTQ+Sv8Hp+tm+qw88aN4aAqOmpQjOPwF9bWZdk/QtIpwo7jtvnOK92nMYDxJlUY2vfGuIZ2HGCXME8wEo8J5WNmLOJn7Z8qHlbY/6ag9HmYpM=
Received: from AM0PR06CA0083.eurprd06.prod.outlook.com (2603:10a6:208:fa::24)
 by PAWPR08MB9541.eurprd08.prod.outlook.com (2603:10a6:102:2eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 17:51:21 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:208:fa:cafe::58) by AM0PR06CA0083.outlook.office365.com
 (2603:10a6:208:fa::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 17:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 80.90.171.68)
 smtp.mailfrom=sesame.org.jo; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=sesame.org.jo;
Received-SPF: Pass (protection.outlook.com: domain of sesame.org.jo designates
 80.90.171.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=80.90.171.68; helo=SESAME-SMTP.SESAME.LOCAL; pr=C
Received: from SESAME-SMTP.SESAME.LOCAL (80.90.171.68) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.1 via Frontend Transport; Fri, 27 Jun 2025 17:51:20 +0000
Received: from sesame-smtp.sesame.local ([10.1.100.13]) by SESAME-SMTP.SESAME.LOCAL with Microsoft SMTPSVC(10.0.14393.4169);
	 Fri, 27 Jun 2025 20:51:35 +0300
From: Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gabriel Shahrouzi <gshahrouzi@gmail.com>,
	Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>,
	linux-kernel@vger.kernel.org (open list),
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Subject: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO note.
Date: Fri, 27 Jun 2025 20:51:14 +0300
Message-ID: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Jun 2025 17:51:35.0923 (UTC) FILETIME=[20334430:01DBE78C]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|PAWPR08MB9541:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db27b0ef-3458-4889-1c75-08ddb5a339de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|41320700013|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XNQkPo9Yb+ZEU+EpxhdOzanrbfET6h2tZyJForUQkjIcAta9fld6MyNeI1ot?=
 =?us-ascii?Q?5G9Ayw2rtzEaBJ/Cc04nPRgZNwPxbaNzHPZAhBWn9Yv69HJQv9bb7fW+3qFy?=
 =?us-ascii?Q?JeaGi9wXil6vwMJYmJiBnI4Z3/mH3uTmXAR/CJfAVKmY5De88UprmqxFSTgX?=
 =?us-ascii?Q?z2mU/erM+brUloMlfAyZcQJ44F1sFdEULCV9BE3wjBWRgsKgS2t2fjQxbImI?=
 =?us-ascii?Q?9SPLIRg4JjMi+TjmxCL8Vq7E2PjTSTILsuN8MpeSSXAbQwFKzubL/Csn4doQ?=
 =?us-ascii?Q?Wbxo5B1XVYCnxXZGFdpJoRgB7NvAPuyy52ZeEDqNWnkMCsQ4Fuqvwhe/Nwf/?=
 =?us-ascii?Q?Fynyj73y4SHJi2EV4sm00UYRr/n3HQ/AaVE2HIvQpmeRmzdl/JySzXSdFGDP?=
 =?us-ascii?Q?M1dzGdJ3v3hrQ0E3yBEgzKXKBri6bHkFUiIA80De5rbb/pWALKt+fabb7/iO?=
 =?us-ascii?Q?bXCtlc/n1qEH19vthI8Mi/5ajIpImhdhPanbd19g4knaTFlx0PcghWX/ZAbh?=
 =?us-ascii?Q?eMx7SuFXpNvBH0UbONwpyylO3XTBu+DwP3FnHHUV6yNhm2giE9renNEapNoU?=
 =?us-ascii?Q?QmtqGoszWEKD1lC99A3hBrDJJpTT4p2MDPEO6kilOY2m9tzZMwPtFASNyFRT?=
 =?us-ascii?Q?lF1MzVW4R2AxcHM8hzY4NmeroEIcrZQBQ3UljuD4ddyVntBQr6kc65YxO0Zm?=
 =?us-ascii?Q?RTO3bTidLprD8DiWcbJeVXpUWWatJfkmWRTe+lj0UMCPDLxO3iyW2u4ms93e?=
 =?us-ascii?Q?7qXNJQ5t9dbheXnwtiAbxAggf+OSC+ABd9aVpSdEke3hQHhEPpBGPOOLzkFF?=
 =?us-ascii?Q?W3D3/bQzyQaUBhFCivthtjiTtFoDe/t/XUQkJvzk6n0zwyniBJnXAtjKEkQO?=
 =?us-ascii?Q?AICYUJx0mipWKT65mEbdzzg9KB9eUh8UPou7dMZkwGUgY/dG4tAebO9q5W+y?=
 =?us-ascii?Q?ezVov/zKR7AFsFVSjUYvRQ+r+VKGTLozFScBmWJlRsO6nrXhbvDnBbsALNie?=
 =?us-ascii?Q?YLTEeaGxV/OmwyEiDJE/rGSzsdKiPbElqMGr8p3yoqtRZaXNuTPRPCkAXEv/?=
 =?us-ascii?Q?aYBEJ4IimtaznL1oPN4YVOe484oLTwmsPIpRO2QXN1Oi4w2+zc22HpWgpN82?=
 =?us-ascii?Q?ZtRzaA43TVzCZZn9A7NXR3z5XJs38EHQcZlVb4ZIPFJONeaAX6W3CTOZRC3V?=
 =?us-ascii?Q?T+QBYJDW0CwNZ9u0wk21ZBkTQVElkig7DyvPnGiYaOS93KKWdxQSx4ROFAMw?=
 =?us-ascii?Q?/mMC8UsqHoUvCH0QfnxoihBn0kKnNCDKjfZ0lvFRirS4XcbavhFR1UJ0GQLE?=
 =?us-ascii?Q?FSZ7Q6BjF9lTra3zAGDmUJt569YDRBhoX9d3A9B4ZNryDhEpGOMRqV1DDnsl?=
 =?us-ascii?Q?AJ0uF+8aeZAXIsrjzzJuauwb1kT+r4l1JrJsli2XVq1SQEewiIjlu4uCpxC8?=
 =?us-ascii?Q?oWIEHKYuCQKfnD0JjlDUtsTe+BjDPHaFAswgV89tHLCJZdiaP6M3/VSou2ab?=
 =?us-ascii?Q?jaW1gzHqfuvwr2c=3D?=
X-Forefront-Antispam-Report:
	CIP:80.90.171.68;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SESAME-SMTP.SESAME.LOCAL;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(41320700013)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: sesame.org.jo
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 17:51:20.4598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db27b0ef-3458-4889-1c75-08ddb5a339de
X-MS-Exchange-CrossTenant-Id: 0788906c-6e04-423a-b37e-862cc7808738
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0788906c-6e04-423a-b37e-862cc7808738;Ip=[80.90.171.68];Helo=[SESAME-SMTP.SESAME.LOCAL]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9541

- drivers/staging/iio/frequency/ad9832.c: Changed .h file location
- drivers/staging/iio/frequency/ad9832.h: Removed struct definition
- include/linux/iio/dac/ad9832.h: Added header file according to the
  TODO note.

Signed-off-by: Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>
---
 drivers/staging/iio/frequency/ad9832.c |  3 +--
 drivers/staging/iio/frequency/ad9832.h | 23 ------------------
 include/linux/iio/dac/ad9832.h         | 33 ++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/iio/dac/ad9832.h

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 49388da5a684..4c7d618b2572 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -22,8 +22,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
-#include "ad9832.h"
+#include <linux/iio/dac/ad9832.h>
 
 #include "dds.h"
 
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index d0d840edb8d2..a0819042a81e 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -7,27 +7,4 @@
 #ifndef IIO_DDS_AD9832_H_
 #define IIO_DDS_AD9832_H_
 
-/*
- * TODO: struct ad9832_platform_data needs to go into include/linux/iio
- */
-
-/**
- * struct ad9832_platform_data - platform specific information
- * @freq0:		power up freq0 tuning word in Hz
- * @freq1:		power up freq1 tuning word in Hz
- * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
- * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
- * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
- * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
- */
-
-struct ad9832_platform_data {
-	unsigned long		freq0;
-	unsigned long		freq1;
-	unsigned short		phase0;
-	unsigned short		phase1;
-	unsigned short		phase2;
-	unsigned short		phase3;
-};
-
 #endif /* IIO_DDS_AD9832_H_ */
diff --git a/include/linux/iio/dac/ad9832.h b/include/linux/iio/dac/ad9832.h
new file mode 100644
index 000000000000..8259a0b0f981
--- /dev/null
+++ b/include/linux/iio/dac/ad9832.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AD9832 SPI DDS driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ */
+#ifndef IIO_DDS_AD9832_H_
+#define IIO_DDS_AD9832_H_
+
+/*
+ * struct ad9832_platform_data moved from drivers/staging/iio/frequency/
+ */
+
+/**
+ * struct ad9832_platform_data - platform specific information
+ * @freq0:		power up freq0 tuning word in Hz
+ * @freq1:		power up freq1 tuning word in Hz
+ * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
+ * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
+ * @phase2:		power up phase2 value [0..4095] correlates with 0..2PI
+ * @phase3:		power up phase3 value [0..4095] correlates with 0..2PI
+ */
+
+struct ad9832_platform_data {
+	unsigned long		freq0;
+	unsigned long		freq1;
+	unsigned short		phase0;
+	unsigned short		phase1;
+	unsigned short		phase2;
+	unsigned short		phase3;
+};
+
+#endif /* IIO_DDS_AD9832_H_ */
-- 
2.43.0


