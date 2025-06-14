Return-Path: <linux-iio+bounces-20678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E14ADA030
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 00:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE493B6E26
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 22:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D920299E;
	Sat, 14 Jun 2025 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="aPvMpAwz"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1919F42D;
	Sat, 14 Jun 2025 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749939243; cv=fail; b=k2WMdTHiNoKB9gf2q5pBWyFALQhZa6pcRqb5DKrXi0oXwrAsVcLglyuyZBTzn68V+WQcBmb4b9licgK1mhchk4sEQKSFjIMKPcjQOCcL3/AhyBhwxrPtvY/2KCo6f/JTbDrmgZesycPGN5JMyofw8N99DxMXyRcqgmFCqyNMckw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749939243; c=relaxed/simple;
	bh=xH4aH1ujc3IwrdZ4AWc0odMqcyZx+Y2+a5QG80F79b4=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=ZSTkxM+89/Rumii9pnjMfff19LiZNJ8ruNwFEnJ+jJRDNSWl/4V1yU+7EeiTUvlskJuHqYaTfhaP/3cDc9i56Yr2rC+XjGmrwdBAzNN26yOxqKEEh6TP6oHg7Ku4qNnma7swIzjFBtdaHdaGJFQjkuSC2Nhb3e4H6oI3fRXBi80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=aPvMpAwz; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ675zAbH79V81t/izawERbF8BhXcb1zHsDCz6N4axX+BmTUCXwCDkVhraHuX6aXLUdrdSINuYBUgMBwyTxlhP74fIpWhK107/1CQGcUOSHQgp10RAx8wlHsOT4t3U5n1ffuO+xY9g2fDfeXudZraTmtjQWWX3QaevOBCVgJhjZzp7FWuUk1OTBqi/VmaHkmJ4OqpTBN5nC31FUP0SIdIX+bjiCtaPsBfeML4JCO8mWq0u8s3hqdYKbNZZu1+/MRJANONH/lkpr0pgPG2xpeY43LCU5PUN30Fq6VfGW1JT91i7HDV8FxSWQ/LOYQo55+RA+51+Ax6GAraTYvzoSfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uH/wJqBrK4GkuSk295IulBTbyMiUxylgWpuoKKZdog=;
 b=UR6HwwTCInCcZSw8PUa9/d+6OcCWlQjD0iZB46ieSLPCtC2KdKhpI8oE0Uwkp5MCO3B/EJApOiYbp7snLhglm1HlQ7zuOC4yW6dZlFLi2Spi1icXFJbAvwIDnh1gi/IyxkW8eSTFvZgngoKxojNQGqKGKpLDP2pDHTNwnr3MBo6On2Og18nNmSyE4rtWUim7E9mzzwU7BONzsyIFUQaAQDoJlMH3gz9Sw8IuKfLUJEgitbAHGSBjdm274MXJTH/Ng0XWevOlszgrEGSEAfqeisl8UzYSZQu2aERDLe2djJl4PqTnaxP3pE0T4bb76A9W0Bsg+9WSYSON/6BpUIaP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uH/wJqBrK4GkuSk295IulBTbyMiUxylgWpuoKKZdog=;
 b=aPvMpAwzv1eVh6T/7ZaCQfbiCS3q89h1HpW31hFkh3pnB5VQhFjYJgffnNtoJ1Xo96E31Z0q0W2J5Oj3G79NsdWMa+ChPIEfhvlT8euepOLNYs2o9S2TJKEPnFBxfPgXyJN+pFFZ8Iu5+WdsJGaSjkXuXCFvEijSjiwG478KCC0=
Received: from DU7P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::12)
 by VI0PR02MB10995.eurprd02.prod.outlook.com (2603:10a6:800:25e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 22:13:56 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::f1) by DU7P195CA0029.outlook.office365.com
 (2603:10a6:10:54d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Sat,
 14 Jun 2025 22:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 22:13:55 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sun, 15 Jun
 2025 00:13:52 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/3] Add driver for Nicera D3-323-AA PIR sensor
User-Agent: a.out
Message-ID: <cover.1749938844.git.waqar.hameed@axis.com>
Date: Sun, 15 Jun 2025 00:13:52 +0200
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|VI0PR02MB10995:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb7a5bb-12a2-49e4-1380-08ddab90c0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YajtmAPvzqOaA/NAQmbfNQMUveDaGxtOQzR4X4gcvAHA9uTcnNDHmZfHDzX5?=
 =?us-ascii?Q?L4fuZlFVvES0EfC/2I9oOTLBsCItCJyg+Zno0m/ArSRilLZbVg7pLvzwnRk0?=
 =?us-ascii?Q?VIMpz/T/RzqVGMdu5x3UHVGIvIEajqCT2uqZ92zhxwsuSWSd0HDzBZWwRCDk?=
 =?us-ascii?Q?qCdKBWG07JqsrMB5ksVeaJmzrqyvNEgnhikeqmQ8hExqGp6y9q553n0Qt7HJ?=
 =?us-ascii?Q?iHnVV1HvMkbbPJARaMA/+GoQAvNmokRQfUbWeiIAOv4idRw1d1Jj4RVBgSvD?=
 =?us-ascii?Q?Vlr5ie+F8UrMkjYAnzVGnwJfWZzvYz8nhVmTmVixlMzg/bl9mAvRVJaHVC0x?=
 =?us-ascii?Q?uGdD/b6eHBztEktvQdUxUFL1F1x4P6NxWE0nqU4WrTebRcZwMZodQH3yo2fA?=
 =?us-ascii?Q?7S+cmUt4KaH/j+Y0d0044VUAEaH9DdyIg33meczdAIVjEPgbuQh/cvsxPYyP?=
 =?us-ascii?Q?M8br6haOzzvo3igH1Ka5xNDPTxeAAJRx45Gg/Qo7pBhGfDK8b33SajoFkpLy?=
 =?us-ascii?Q?bHHzEaWIcR2a4gUluNDBkbn1mEp0jZDVx2QjMRSEFktpP3YzSN4RGjtsrX9N?=
 =?us-ascii?Q?O1SAAtvcvMZ8YJXYqxXqYKhMclv5ObjpMg/4awaqwwtzsNk/T7C8M8WG5SGc?=
 =?us-ascii?Q?UtCHaSoI0jpUWFwdYF4q9y5A/AQmkF3vHNsxNNZ58Ro03Vai6e4VSedebwXb?=
 =?us-ascii?Q?QIGzfGqFNHki6PyJqkaJYPcO/mXiZijhXSiIfQClgQ2GMuYTTOW4TpY/ASC6?=
 =?us-ascii?Q?ziKjt0mIR0F/2/cLS+SRBtvEI+b+vVBCQMAFsO5xgJ1ZBn4G4LWI1dh7nJlm?=
 =?us-ascii?Q?JwAK+ROBJz4eCQRw/29pIVQomPJxI8lSx2sXHa7fPa2/4gIfEOxydWbAZA4m?=
 =?us-ascii?Q?yIvJLNhWxfuY5WrNPZXm1XaG0FmNM1/oY06AliquXp5wKxAklEgLxNOOSZk4?=
 =?us-ascii?Q?8SiMK4A7HaWLA7GB/vyx2LPDIqFelqJGorxUEYT1TWyhPSPeaPHL14K7bpc4?=
 =?us-ascii?Q?9T2Zu4Bm1ki0r6q0YT4eNkQk7ICsy4nT2ya8dOoQEQq1X0S7nwX45lS7xl0l?=
 =?us-ascii?Q?Af45MyiX7IPTuPlYQdEpMJImJqtBqCEslKvRxv/9HpLiDLkF7Yf/xkMtPPjM?=
 =?us-ascii?Q?lECvwZXzty55rzgIGO1ahwygtC3V/WXcoumxJSzVujV72BCqxtQfA50XlRR7?=
 =?us-ascii?Q?zg64D87/8CL9z34XZWXn0Z10r2ctEXCzyKN4GjrWPwJc6zBex1czTsYLiXxR?=
 =?us-ascii?Q?bC+dv0sQ+bYbLwa2AVe38VsEOyMg3dRton3UrMEpMyfvABVZXdbLs4kH7fBx?=
 =?us-ascii?Q?qTHS2F+nQRY5SMaSSHcBYEVYlctAuUAUUFv5Oz6sshlsz7jwZ0JB4CA/p0yQ?=
 =?us-ascii?Q?vI7KjnPvCCuiJ9YZMt/LLWnh05ptSIiNd0hPGroceT078jHg7RyvQ5B8YliI?=
 =?us-ascii?Q?3NcL45jeeHvZmizboUiX0Z8M4X2vsM7hVLy+CelxDXzb3lPfm2wj0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 22:13:55.4255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb7a5bb-12a2-49e4-1380-08ddab90c0d1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10995

Nicera D3-323-AA is a PIR sensor for human detection. It has support for
raw data measurements and detection notification. The communication
protocol is custom made and therefore needs to be GPIO bit banged.

Previously, there has been an attempt to add a driver for this device
[1]. However, that driver was written for the wrong sub-system. `hwmon`
is clearly not a suitable framework for a proximity device.

In this series, we add a driver for support for event notification for
detections through IIO (the more appropriate sub-system!). The various
settings have been mapped to existing `sysfs` ABIs in the IIO framework.

The public datasheet [2] is quite sparse. A more detailed version can be
obtained through the company.

[1] https://lore.kernel.org/lkml/20241212042412.702044-2-Hermes.Zhang@axis.com/
[2] https://www.endrich.com/Datenbl%C3%A4tter/Sensoren/D3-323-AA_e.pdf

Changes in v2:

[dt-bindings]
* Convert `vdd-gpio` to a `vdd-supply`.
* Rename `clk-vout-gpio` to `vout-clk-gpios`.
* Add description for `data-gpios` explaining the rename to a more
  descriptive name.
* Drop all references to driver.
* Remove unused gpio include in examples.
* Re-phrase commit message to only describe the hardware.

[iio]
* Add newline after variable definitions inside the for-loop in
  `d3323aa_set_lp_filter_freq()`.
* Remove error code in string in `dev_err_probe()`.
* Remove driver name macro and use it inline instead.
* Format filter gain arrays into one line.
* Drop structure comment in `probe()`.
* Format sentinel value in `of_device_id` with a space.
* Rename `gpiod_clk_vout` to `gpiod_clkin_detectout`.
* Request `vout-clk` GPIO to match rename in dt-bindings.
* Use the regulator framework for supply voltage.
* Use only one IRQ handler for both reset and detection.
* Reword comment about Vout/CLK ramp-up behavior (it's because of VDD charging
  up).
* Add comment for why we have both `IRQF_TRIGGER_RISING` and
  `IRQF_TRIGGER_FALLING`.
* Rename `regmap` to `regbitmap` to not confuse with the `regmap`-framework.
* Move `d3323aa_setup()` into the set-functions.
* Use state variables in `d3323aa_data` instead of bitmap and move bitmap
  handling to read/write settings functions.
* Pad bitmap with compulsory end pattern in `d3323aa_write_settings()`.
* Add `d3323aa_set_hp_filter_freq()` and allow userspace to set it.

Link to v1: https://lore.kernel.org/lkml/cover.1746802541.git.waqar.hameed@axis.com/

Waqar Hameed (3):
  dt-bindings: vendor-prefixes: Add Nicera
  dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR sensor
  iio: Add driver for Nicera D3-323-AA PIR sensor

 .../iio/proximity/nicera,d3323aa.yaml         |  60 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/Kconfig                 |   9 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/d3323aa.c               | 808 ++++++++++++++++++
 5 files changed, 880 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
 create mode 100644 drivers/iio/proximity/d3323aa.c


base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
-- 
2.39.5


