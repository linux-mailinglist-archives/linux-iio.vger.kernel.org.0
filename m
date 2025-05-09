Return-Path: <linux-iio+bounces-19388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B0CAB17E3
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C28A21880
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42D23504A;
	Fri,  9 May 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="DJAFM9iv"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE518225A2D;
	Fri,  9 May 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802990; cv=fail; b=YJoc04UyLfjfRM2RVYYy9cnlwubULFFdccVwgao3XO0/IluvpHWfREx8gQFS+iusEwfivtHmOBKTa0Nk5jsiNhOs+9IfWTAWvta5+W6HIp/Oy8cliwZfac6epgLmAVfobCpe7Gb+RmD5GJGYgzEIWGOzV038Zn9px4ofZt1XnnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802990; c=relaxed/simple;
	bh=0h+6eJh20XdcQYKRfFW6cQN2fw1hUpTOhYeVvLDsEmY=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=RsLiAE5untqmNzOVbWpUs50wwsex9O1Tbig4eFnGHW6ooUOfZBd3g3bNcXlVKZxM8SNJYpxDmY7ktGgY7DsU6y0qIPn2ojI+HXAbyxMPR/Dm0wzbklhw7IrLhUPuMe6hgrnQrD7dUPP/bATnqfd3N0+wK3jQc7SNFCj6ixA2I5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=DJAFM9iv; arc=fail smtp.client-ip=40.107.105.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebEirqKEPo4ROmSLhCY+AVwyN43GWprIyv44lV85cAdydKbmugQ5IrKIu8A8tj1JY2BJFpyMuvZfGK1lrFv07siszHOO9Nj4JyfsN80/a6/8+siKhpdLTNm2sAYe5Bz06F40KwVV+WH/pSSffk9rHhYsDASyyYATI8BXhbaVT/Hd6bwMkbj109GSa36sbtxju4+i4bMK544sA6XGQo9aaPHZg6y1gPoujMAc4U5etEab6HWWk8mHhyptuae5ti6eCD4+sbKxJcCLqATkiQF6WlSoTBFeowAqia6FVHdPuC23b+QQ9kMzkoHutcM9rntkyf3EGU8r5j6xtkYWh3qgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPJtrdATGnTgqrWLxmSIu87AgkR+O0nhSGWhIVAbM5g=;
 b=rELIp46Y7ylLQnm5G2oaHwl5KUw+Wywh+cg7HcVQysqQzkHa3xBYx9Sz3Gvckfg4Fk1taL61TtSX+xDpBABI4qX2gq1aYAQNXeFZHA3zKeF/MJKa0dlyHcTntHSsWTgJs9HVXZDPL0vIHuCWGc7NJ6zp7oAqFlj3J81LwgPtduuFhHuJafF5YSwxBPgH0XilpEPzaoXSpLmSq771DkW1VlA31NSsRGk+5A+VwjZEkdBhTfM3kBcErDleGjzZhYV9QZXkc/DhHUtXkAEdiMJkFJdBhggrzsbJixDOdcXsNQygiF1tefWBY/+YjXjBjKtVRaohwk4GvjgEreYzjAGteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPJtrdATGnTgqrWLxmSIu87AgkR+O0nhSGWhIVAbM5g=;
 b=DJAFM9ivtEFmFyBc2Qa5jKJHtpPRtFOtVMH7HbR1+5DAgKZykmVYtU22IOX2zY9cisFJSVTcvz9T7SoBVkgru/TLX9OGYTIB4330Hf9DZN2A5TItBzwLyw6bR+yWHMutaBsnSGk89lfps9msr5HjGYSRH3fgBPZXak781/wehBM=
Received: from DU7P195CA0028.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::28)
 by VI1PR02MB10060.eurprd02.prod.outlook.com (2603:10a6:800:1c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Fri, 9 May
 2025 15:03:03 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::6b) by DU7P195CA0028.outlook.office365.com
 (2603:10a6:10:54d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 15:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:03:03 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 9 May
 2025 17:03:02 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] Add driver for Nicera D3-323-AA PIR sensor
User-Agent: a.out
Message-ID: <cover.1746802541.git.waqar.hameed@axis.com>
Date: Fri, 9 May 2025 17:03:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|VI1PR02MB10060:EE_
X-MS-Office365-Filtering-Correlation-Id: e12233d7-151b-4acf-3a2f-08dd8f0a98df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KpcDO/XjyJ7hDG+obE6uxIohTmvEcqZrjbOc+SgCxl0kMQo4KeDypDl7ERjo?=
 =?us-ascii?Q?QLyVpcP363BwjMO6U2JHT3cNiVONmFVYixv7R0IIuwg3DolJ0nWQGdJt9HCp?=
 =?us-ascii?Q?Hj3yFf6SrrIQoT2q60wy5qNqPbCZJA5g8rzlHqjZvMe7jykmGYJXi4xvodv1?=
 =?us-ascii?Q?P9fEgjNjhMgbhXRk9UWa3ZjaXe6H2z5gOlprA4CAeKkz17m5lAy1Nmk+RsjM?=
 =?us-ascii?Q?lHOta/JA/UrJOBHYeUMA4m5EcDjfJ+8YaYyEDiG4Tv3WB4ZgSVPgHIRnA3DQ?=
 =?us-ascii?Q?Z/2kM5Z2F0SnFP2Ywe2hGUd0hGSPsbW7rOl1cU48Z+kziHuvz+/LNHwbHcZW?=
 =?us-ascii?Q?yv2oJ830bSPHKcUQ6aHgURSlyEydAL9fKBdmioi+n1fpWuwCJb4ZG7V/SLxm?=
 =?us-ascii?Q?MMjDRXxD7boHH8DNRP3ggRc8OVplteltZTVhdkEkAdPMZLCaaxZoBObvAW3m?=
 =?us-ascii?Q?Hq5qZoRGbLTwUYQLenUycpRaMlHSPVxGTMJy6s0q3jMm2lVkBkbgA3t81y50?=
 =?us-ascii?Q?M5USXnanEe+2+utkAJiH3IBEcWpu0QGPht0m6TEnseKzJvT1hGfD3WLbTYU7?=
 =?us-ascii?Q?dAGxVVoWADwmy9QmGLGmjHdEq3lcZKkXGiIxU7RIMBFo+BhGx2GvV81psoxy?=
 =?us-ascii?Q?u57HK+IlhH9k8ZvSI8ngeU2QCp8vJoEmqBrxoH6yaZlDXxEfVb8R+2e+tNR5?=
 =?us-ascii?Q?oFWPmYJgqzm+AHQ/HF5Zc+HNAF3K0qRmC3c6Cq8pctdF3ajB+z1mk3ttoA4s?=
 =?us-ascii?Q?VmltuASngRq0Z3iL79GoxkHF36MMkRIxHQfKxRJ4I1ni1BioKDsF/ndnt4Yk?=
 =?us-ascii?Q?PY2hBK+rMvE6lVXFP+Ks11Yl1fXLIFZs/zSaIOC5CNxjhn3sWu+8kdnDQy/q?=
 =?us-ascii?Q?EiKCJP5QetHMhV/h71Alp0v3LWHQyBRSo297M8D47/JGO5EDSx38bUh5Em1t?=
 =?us-ascii?Q?XM3sYrNfipDy/z2lRK9PvxP5MrSfQu4Zf2LuzUpWL4his84NjiKCGciYApXg?=
 =?us-ascii?Q?1TSdqnss15ggwjwMTA2OV0cWKV3nunWIIqkoeUgvgq5+dAPJpml9rkEvcF0Y?=
 =?us-ascii?Q?S2New9L29A3pp3/n1NjnzRmNth7s74GczGFHbKWqM/a39yq86C6odgPMOSNy?=
 =?us-ascii?Q?9clft08KkWa+lkQKEKbC7N1kJTjhOu7IvAdEW2QB48+0AV1lxh/nAiFXujkq?=
 =?us-ascii?Q?J0CYjRbKamFT1g9mBLCSwtdHsAjlEkppN8mSN0QMCCBdhjoqEa/bwwfwTanJ?=
 =?us-ascii?Q?ll2tY5n/al46Jry8RvKeqI2dcA8lgyA9sTR7TxUCYQCCf4mQ/7xiRmP6YMC8?=
 =?us-ascii?Q?+kDf7iV5IIjkah5jEd4OGvtBP+eu7dhp4MwLV8NKdggXsphSzD1NPQckXq6i?=
 =?us-ascii?Q?L0Ve6uRXyymsuhwamktMSIvKHxdelQxMUoCvJuy3AQtsKSz90OT1zT+At7hC?=
 =?us-ascii?Q?NkT/+rkxKyyq3KCA/8TTFn4TPDu3/xgAh+dmxxzCYIkG3o0UJnK4Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:03:03.3168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12233d7-151b-4acf-3a2f-08dd8f0a98df
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10060

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

Waqar Hameed (3):
  dt-bindings: vendor-prefixes: Add Nicera
  dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR sensor
  iio: Add driver for Nicera D3-323-AA PIR sensor

 .../iio/proximity/nicera,d3323aa.yaml         |  67 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/Kconfig                 |   9 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/d3323aa.c               | 868 ++++++++++++++++++
 5 files changed, 947 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
 create mode 100644 drivers/iio/proximity/d3323aa.c


base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
-- 
2.39.5


