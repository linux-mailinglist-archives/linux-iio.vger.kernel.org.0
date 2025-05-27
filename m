Return-Path: <linux-iio+bounces-19964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9932BAC5129
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1908A7A892E
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBE18D649;
	Tue, 27 May 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NmjzYQ6o"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012067.outbound.protection.outlook.com [52.101.71.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AB2CCC0;
	Tue, 27 May 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357150; cv=fail; b=LDocJR4NVxsGt/ok5wS2GZG+U9pPQttELNw0EteiKmcAmB74PFTySNdjRzfI156iQzeid0AujjdZq8hWLcZH22XFCzcbKY1/j4KxI7z5c9jeJzbrwrH44pVBr/3AmDljLM8OL7BMcjY6rQlsFiIpWUQ9njCaD4vxLDZ4VwINKeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357150; c=relaxed/simple;
	bh=M2pGBmRcbGmP+bTKkSCo+8MOZIy9dnHpDwQnbKdBnEQ=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=MqMVPTrY2NVfRMvk9SvZ7y4uTNYa6cJufnFq3rCC/nLxyhNrkKj9aayre1UlFm66fHL01SUpPwHC30bbhN68+1tABxuKjgb60lRC8S4n87U+vtQiw/N1/dXw2SOkheuZX6V6Bhx/bI0fLXpWp2ZcKgKLyEj/g+1Z3zcPpZ5q3RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NmjzYQ6o; arc=fail smtp.client-ip=52.101.71.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCavqkN5lnZ3ApG5ts3YJoqf7VFftbfr04jEwFSVU6CNwnx3nmi/Uq5LaEo5cYZQ5ggt0sgbhg1cnepshcAphl7Trbm7shqOiRp++DmN3mkqi/A+0xnalWlceIQiAPRsX8eMZntwp83zXKueRMjjCfRmyEcg9HnuktfcF02aOhbRZTJLBNpgiyoOI9V+Q9fi27ZNAMi2pZY2/7jt4VRMHdZz7T9YkFKbwYWntG4PnCJXh2Ulk+XTDMKTaJVx+wiAIiKrTvCLJIsUcR25X6GCQiz0usoiyPYNYoC07U07VGYdsAt1f+fU0haV3uLhQ/Df83iULJTVLyjMGYQ/Eeh55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2lLM3k3l6Qc+yabjUq96zR1hbiTWjMSgDJ20kl/0sE=;
 b=ZKWpMaTOH2Mo8ZeDh5JSmUJ6qufPZggEFzjZ05ttv5KQmBTsNeJwvrvRWjkWlzze8U8CQj5upmiUm/qRrmIv9d37bAhOuWA1AwauHDnLQcFd8+0E6IsU3+RtVrFB3AhjodeyvLw745yC0FcoOZjqpN7FisazyOuDHQq4OOQB1863LVQk1I4TvT3D7is3F6zczt1+Sh/Z8czcThU83MLp/K8iL+66utHmy4jhp3sVSM3HiixGrG5rWpZmTC3IXeTvDt5IbTzJPC4RTBdFO9W6eA2W5phJTrXxfJz+cYdz7t8zO33vX5a7lgJnJHdactXpeKBUm493pETQbCeF0EE1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2lLM3k3l6Qc+yabjUq96zR1hbiTWjMSgDJ20kl/0sE=;
 b=NmjzYQ6oQ8x+hYw8kHvbs2WWxnl4ujbOlzxasYCFSPIft9fRuxQMYdtctisA9LpQ+3vM3p0+7XoUh8ERZ/hfaQ8pa1CgE7XctyzOF9t94I2uY7f7a8+ExHxqFEK1I7EnxeMb6svSgldvtzqxx1cxBP7Ewc97Ng3rZM1uMNonuNo=
Received: from CWLP265CA0323.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::23)
 by DU0PR02MB9797.eurprd02.prod.outlook.com (2603:10a6:10:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 14:45:44 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:401:57:cafe::42) by CWLP265CA0323.outlook.office365.com
 (2603:10a6:401:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.25 via Frontend Transport; Tue,
 27 May 2025 14:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 14:45:42 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 16:45:41 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Haibo Chen
	<haibo.chen@nxp.com>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] iio: Clean up macro definitions
User-Agent: a.out
Message-ID: <cover.1748356671.git.waqar.hameed@axis.com>
Date: Tue, 27 May 2025 16:45:41 +0200
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|DU0PR02MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e5900a-b695-4f18-38cc-08dd9d2d27b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJYOiUIr1lR99KCArc39n8sxXqxYmD5dktK0bMdZrPduAPkQSwlExgJNhqcO?=
 =?us-ascii?Q?AkPG5bSAK9Q8RcxaqqbaX7Zo/K4qRAvaRZ7+G8+x0IxY6m4Bn1AneeyOVyiq?=
 =?us-ascii?Q?5kuWWbspPCxv3R1n2bdK737MePx/NXfW4i+EN9b3EpBiPbQ818XEerlbV+uH?=
 =?us-ascii?Q?E3OLBg13BU6vcfacecyNB8AKjWGal27a3X7jdr7kq5DTH8l+WjuLJSgs64WQ?=
 =?us-ascii?Q?5XV3mm3QqyasDp8PDcUTLZUfMXh3u+UPQs40n0k5AY6RtNd/G5R2pBiSz4qd?=
 =?us-ascii?Q?XUSWBHbYVijoo5uy+67h+RxeYTH4y0PkPCsyqICgV733wcW+V+XDeL1mkHsb?=
 =?us-ascii?Q?fH/Yxz+Gf2yKUFh9qoJS3hxOYrWNRRYO/vad8Talh4ignsgErThMN1OVXZK6?=
 =?us-ascii?Q?fWtLtQvLd3JBidnowtZDu4hBuFDVTonAhrRg0/7TwSUTI6V7iuvs4VblLniC?=
 =?us-ascii?Q?FhcqdqHxCNGDAiOxnHEzaIUlZUUjAR0edak0ypYvCmExtrtOCYHqLt+zChyA?=
 =?us-ascii?Q?roKXV/iPLGsdWsiAj1zTPeUVSgJYn0Agiu/JOOQOcQ4hyW4qpkyBds83VxZr?=
 =?us-ascii?Q?AjZ3+RER3j26zYTiKwgG3zNqy6ErHfEx8u6+uZPJncy5o/AOnxD205k3lbuF?=
 =?us-ascii?Q?MsesmG6haztvvVSR1eIEjwv54Feu+4L7asw6TOUqohWq2j5QItu+kHZadKCy?=
 =?us-ascii?Q?rbFSXM2yacvXfJCC/tqQnY4P9SE5TvgmS2gRngNBLLOuP4IiseeSjvNTn7vz?=
 =?us-ascii?Q?nmpuoWGomShFFs/KPRnywei6ppIUDVTvmZApYb6a39wmigtf1mTe1ft6mK4n?=
 =?us-ascii?Q?n4qTlADF/NXD2xSdUfpaW1dZW+FTWlgxsdAUPnEg6TYvvLruOPVyMrtctgvo?=
 =?us-ascii?Q?VEwvdu3dzFwuxeahMeTDBe2dfS4ylcrsSYkqnAiqsVN+yfWh7Y1gZLArY0Lg?=
 =?us-ascii?Q?hxl4lw5cTW6l7XF7TGmrmFzd/vQxTcdUHhm8Ck26wMc7ETIOv2u25HIDYEzY?=
 =?us-ascii?Q?+RBONRl6tsxp8jmAJFOV4INkreAx7ZxXR5stWqcbWgJS27925nn1MZJxbTTh?=
 =?us-ascii?Q?j+lmi49AQo60w6CY8SMbXhuEgsLOu25MtCRSzm5JDVAL95d6CYCOANNh2oZQ?=
 =?us-ascii?Q?NcLTsz6yUB0hQFp5RkBJxvZQZnVXvG2CEK77Vs/K75MGHj1Lb2vepkro7vhH?=
 =?us-ascii?Q?KnzXlxIudC6GPb3gWAK/ZjGbUo/fggSk3uVAPs6fV8w7sG5uLBKYgfIFHAd9?=
 =?us-ascii?Q?AMHkqi3Y5PhhHz1QtYW/07/1ta60WvuaO7WthJAuN9gNCkx4QF+SyyPpt96c?=
 =?us-ascii?Q?/uXU+oxz0rjVeaqlAt+s80BSr2OOixV6T82QroMFKYOlhLvRuUdjGinyu28X?=
 =?us-ascii?Q?K8pkPj3j5J8jQhJdUxfp9rF0YkLsuaZGRTjKKZ2XsheYnXGHQ02MKKbJziTe?=
 =?us-ascii?Q?tJ/3J5q3ChB9i698iwvvUp7EHbf/UnKl36s4FygNKaQKmjIVxs3VtEvIMciu?=
 =?us-ascii?Q?L0kC3cl+AEww084znMd2/twM8OMThAb6t6sK?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:45:42.1585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e5900a-b695-4f18-38cc-08dd9d2d27b9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9797

Currently there are a bunch of drivers using macro definitions for
string literals that are only used once. There seem to be a "style
guide" to not do this, and this is often mentioned during the reviews
(if caught). And since developers most often look at other drivers for
inspiration (or just trying to figure out the "style guide") when
writing a new one, it is desirable to have some consistency.

In this patch series we identify the drivers that have macro definitions
for string literals that are only used once. The most common one is the
driver name. These can be identified by

  rgrep -A 10 "\.driver" drivers/iio/ | grep "\.name" | grep -v '"'

And then count the number of occurrences of the particular macro
definition (e.g. with `grep -c`). Most drivers use these macro
definitions for `.name` in `struct device_driver` and `indio_dev->name`
(which could be justified with a macro definition). However, the ones
with only one occurrence are identified and removed in this patch
series.

There are also drivers that have a mixture, e.g. macro definition for
`indio_dev->name` but in-line string literal for `.name` in `struct
device_driver`). The following have therefore not been touched (but
should maybe use the macro definition for both places):

  drivers/iio/accel/stk8ba50.c
  drivers/iio/accel/mma7660.c
  drivers/iio/humidity/am2315.c
  drivers/iio/light/stk3310.c

Likewise, there are drivers that only use `KBUILD_MODNAME` in one place.
These have also been left for the same reasons.

Finally, while cleaning up these ones, other similar macro definitions
could be identified with the same "style guide" issue: macro definitions
for IRQ name and `regmap` name. There are even unused macro definitions.
All of these are also addressed in this patch series.

Waqar Hameed (4):
  iio: Remove single use of macro definition for driver name
  iio: Remove single use of macro definition for IRQ name
  iio: Remove single use of macro definition for regmap name
  iio: Remove unused macro definition for driver and IRQ name

 drivers/iio/accel/bma180.c             | 3 ---
 drivers/iio/accel/bmc150-accel-core.c  | 5 +----
 drivers/iio/accel/kxcjk-1013.c         | 7 ++-----
 drivers/iio/accel/mma9551.c            | 6 ++----
 drivers/iio/accel/mma9553.c            | 7 ++-----
 drivers/iio/accel/mxc4005.c            | 6 ++----
 drivers/iio/accel/mxc6255.c            | 3 +--
 drivers/iio/accel/sca3300.c            | 4 +---
 drivers/iio/accel/stk8312.c            | 3 +--
 drivers/iio/accel/stk8ba50.c           | 3 +--
 drivers/iio/adc/hi8435.c               | 4 +---
 drivers/iio/adc/max9611.c              | 4 +---
 drivers/iio/adc/vf610_adc.c            | 5 +----
 drivers/iio/chemical/atlas-sensor.c    | 3 +--
 drivers/iio/dac/max517.c               | 4 +---
 drivers/iio/dac/mcp4725.c              | 4 +---
 drivers/iio/gyro/bmg160_core.c         | 4 +---
 drivers/iio/health/max30100.c          | 3 +--
 drivers/iio/health/max30102.c          | 3 +--
 drivers/iio/humidity/dht11.c           | 4 +---
 drivers/iio/imu/kmx61.c                | 7 ++-----
 drivers/iio/light/adux1020.c           | 3 +--
 drivers/iio/light/apds9160.c           | 4 +---
 drivers/iio/light/apds9300.c           | 3 +--
 drivers/iio/light/apds9960.c           | 3 +--
 drivers/iio/light/jsa1212.c            | 3 +--
 drivers/iio/light/ltr501.c             | 8 ++------
 drivers/iio/light/rpr0521.c            | 6 ++----
 drivers/iio/light/stk3310.c            | 6 ++----
 drivers/iio/light/vcnl4035.c           | 6 ++----
 drivers/iio/magnetometer/bmc150_magn.c | 5 +----
 drivers/iio/magnetometer/mmc35240.c    | 3 +--
 drivers/iio/proximity/sx9500.c         | 3 +--
 drivers/iio/resolver/ad2s1200.c        | 3 +--
 34 files changed, 42 insertions(+), 106 deletions(-)


base-commit: 914873bc7df913db988284876c16257e6ab772c6
-- 
2.39.5


