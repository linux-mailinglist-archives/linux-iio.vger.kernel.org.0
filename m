Return-Path: <linux-iio+bounces-21359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3AAF97C2
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F521CA67D4
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E16232800A;
	Fri,  4 Jul 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gBPRh8cK"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D4327A24;
	Fri,  4 Jul 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645687; cv=fail; b=P25aGkE5rZMWPS3xOGr7mJc0Fri+Ytd4jQRrIqhLTOkQ5fcl6PTzslCh+yXOZFWIpj/6lo4pKP42HCImV2QdHD4Zm3cFV2OyTzYVr5AjdHv40rgcYJTtAyDxD/XuGnCGV4b57W5X5rOsXrSEQrh6iw3JlKOlm/5j7VUX3TXx3r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645687; c=relaxed/simple;
	bh=tTRcJgCvBnmEapOEsStgxhShxoc1I5iXbcrzmP9fa+U=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=bvWydzwvXr1/3a4nvfQNQKd8dIgsLIFLWcObMWGr+NynP6vcR1TyUPu7yWEolpzf1cTbJmXWJurTvpVem0Vhr7ZCeLKfftG4odEGTS/pK0SwMhKuyT8q/Z4xmvd1/LCIC2y1xTbxkqWogu6kd01U6g7KJtgg9jpoRPHI9QzTFps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gBPRh8cK; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn5JV6LCYYSTpyQIJXKHfSpYjGyuKOXy2FhhlehgqCmO8M4O99dmpVOuoQx2w/LV2HdieOeitmMr2LEQ+mX2OtuC68cwJ2T6CQUTdoh3Ep7BHOafQMfaYeEa4pmwgkYHyYF77syh4wBSWsAxgplsgm64jtb9CIr9j1ixStGvFhtFu2v9B0BiantYZ7F7NbO57/IqVJwZ6oXbk03VSqjRP/EHVrchT4GrhmrY5e4w+y91YgyH4xNwxEl3qx7WRbiLR6Vc57HxEa4ZDmeE1dUsCoTpYOgmHL8Nusn5uVla5MQZTsOkPhQckeyTI0O71TK6vgO0BapU7o/BytL8c4qiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G++KAu1pD4bFRsIXpSlYQpH9I6HpyEmd4mQmMLIS3PE=;
 b=C5Xy0nGdjNlNlMyFRcJUTrH0KzVGe8KrfphkAWz7pfIshawqGrDrXHf8iZiQ7rHiopRt7Nor1DQ8wv6MQVaHJSn/ScOwcF5xyP+eRhW2rlsRIab2SM1mFYCvE9mn4EQEwM2tix3I23hGUtjVOXYRtrLQgvsRFaE0Wr/TpavicQ0B5XSzQdh1biQ6Zn7UMWwL2g8FVEXSom+2ZvyntmL5v2laKYsgqhtowlw6M5nP5Gc3xOe2PbNT0ULbVf8liG3/eTQpj/ZGOqz0PbJiGpwcLpcCZcRLmQBrj3W+/SXLVv46U3FLwugJzHZTj6pmW7B6QjJmImpR/Khyknq6m/pENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G++KAu1pD4bFRsIXpSlYQpH9I6HpyEmd4mQmMLIS3PE=;
 b=gBPRh8cKOdpyTW/yucuBktP08KoH9Vh81+lTiX44LrZRlwTVpfbA93pqx1SZ+jvWuerkyr/szPcJSph1Gnsn/IfViBLMHWJ7roVLCFDcQVLcO3MEn9NNj/ZhNVn2h/jMEctP8X79no+IC5UNhHzxfHyjWSQEMvb+rDSaTtNsnbI=
Received: from AM0PR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::19) by DBBPR02MB10464.eurprd02.prod.outlook.com
 (2603:10a6:10:53b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 16:14:38 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:208:aa:cafe::d3) by AM0PR01CA0150.outlook.office365.com
 (2603:10a6:208:aa::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 16:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 16:14:38 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 18:14:37 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <kernel@axis.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v3 0/3] Add driver for Nicera D3-323-AA PIR sensor
User-Agent: a.out
Message-ID: <cover.1751636734.git.waqar.hameed@axis.com>
Date: Fri, 4 Jul 2025 18:14:37 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|DBBPR02MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 92349d94-8135-444c-f16f-08ddbb15dffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZnCQkCslGSmxPL623eapTBTvqrzHYFd7OvRCbbWZBMSH8N7QR903MRnAXMmM?=
 =?us-ascii?Q?N5o/N0HNzJB1IWSlFxVIc3nBjG4rhI6T8SWEnd6pHywh9thkvegim79PfS6R?=
 =?us-ascii?Q?ex/yf9h1iRN6WwAduXMqUTCB6qwTAX8vYgGsXctqOJmIW1oMubD90fSoB1bt?=
 =?us-ascii?Q?clC+Z788jr1GioQ7NN5yhIAg3IJAYda6z2W5LHzTeFsi2jxfc/X57mVTlnmJ?=
 =?us-ascii?Q?Th82Tej5D21vDovqwPCxLfj1IVp94gWp6BL8p4WZTmXKDhQ/SfetUcPtP5PR?=
 =?us-ascii?Q?zHCt+RzpCAmMFT092ujgR9ZAy3UDu22lES7NkC7M8/7LCWn9ie5u3xfoCF6a?=
 =?us-ascii?Q?1ZtFgZXDOBgww4mRnVk3HK6e7zmcOjv9AwvO9dQje+Wtatb6RtQ9Pginn7By?=
 =?us-ascii?Q?nQz6X/TYreHCb/ogq+oA/uFOsiKdvce4bGG4b7iCawe7hMEm7NnumqZXu9Jj?=
 =?us-ascii?Q?rA3jn8osJ7sn2C3VGyOCgrEU0TIroShVb6CatA4WodYAnKWhHZzMlyedBTMU?=
 =?us-ascii?Q?l8+iYeTGALcSZod1IyiJN8WVswgmWmvE/WFhCNs4YZQuTNkuywBheWJKmXhO?=
 =?us-ascii?Q?JFdaFsw4wYjH0tG1o22MhDtOI9Dc8InwXScmz+eCzsH7BfCv+yraUbuZRb0X?=
 =?us-ascii?Q?O1o05VF5tUPk2LxdZdE5/Hw0rZaPAC1WYpTEuPNlwZMJ+tL1/zdGvF1yJ3VK?=
 =?us-ascii?Q?RyuaTXjWxtq6EPTCa0MJNefmu389Re4qEpPNj193gC9xgcYgnZVkFU/Wc6qF?=
 =?us-ascii?Q?kbodYqyMzlVhZh1vzkHrj5g8TO5Zb69JiBETybkrA79ABuavxdfccj6UBhFD?=
 =?us-ascii?Q?lNTVBWwaEkugasajWRLpTwDHEZfDHbz+grSv+H842EheIRxUXY2N0OpKj3Lt?=
 =?us-ascii?Q?B70AGTRdkDjyXm/tT4iyBZGDjjHI4ifVyTQJ6p19VoYn8HSldz+JfNOo3Gy6?=
 =?us-ascii?Q?ROtYUo3G2c7O+rOeocINlLOakQ1UfATK5Flk+GiXVFTe/C+OcEY7D9NWkfss?=
 =?us-ascii?Q?Sx9h5084kBB4SiWPxzhWz2RANb0e/81z8kI1tOlGqrrBeqA3gApR7qpGw1gh?=
 =?us-ascii?Q?PUkfj9qrt7bFu7kXILlz3ZpkxwJHNmOrozJ+ksggrLYqEiSiCcMgBiRyhhst?=
 =?us-ascii?Q?xXTFY3ts8I/PLB/LiPZkqx39ijirphEFyyxicXwacPezrwegNRlpHFcNS1NN?=
 =?us-ascii?Q?3PqDslFtv2iQwVS3QHC0RnQOSTbEMPku4ztmPKVGFe46gJaGBC1jS+2sG3rW?=
 =?us-ascii?Q?Z1FbpBVQZEo0cq0HtuKcOH6wyQg1Ob4HRPvL1e7vuaq7F6yGxOja1VOZyaon?=
 =?us-ascii?Q?coZRqItmpXC5kWRmpErjSCBUw/KWrgvmEx0gdlPZM9oDwka1/+InU9GU7hz8?=
 =?us-ascii?Q?qsuKZKKyRmkPUu8yzQ2q8+oyIViBS8ioOS3mNM0OMgEu5hdWnOfm7KaAI8l4?=
 =?us-ascii?Q?QccM7rKdDqtjbiMBU9tqvA5ICX2w+fYECYEx2ILlQfVpgE4q8kb1VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:14:38.2657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92349d94-8135-444c-f16f-08ddbb15dffc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10464

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

Changes in v3:

[dt-bindings]
* Re-add gpio include header and use a constant from that header.

[iio]
* Convert `irq_reset_count` from `atomic_t` into an `u8`.
* Add a comment in `d3323aa_reset()` explaining
  `regulator_is_enabled()`-check is for `probe()`.
* Use `flseep()` in places where the delay is flexible.
* Rephrase comment about enabling VDD and counting falling edges.
* Declare and use a variable for `struct device*` in `probe()`.
* Remove impossible error print for `devm_add_action_or_reset()`.
* Add a comment for `devm_add_action_or_reset()` call in
  `d3323aa_probe()` explaining when the regulator is enabled.
* Add a comment clarifying the `regulator_is_enabled()` check in
  `d3323aa_disable_regulator()`.
* Change `-ERANGE` return values to `-EINVAL` for the set-functions in
  `d3323aa_write_raw()`.

Link to v2: https://lore.kernel.org/lkml/cover.1749938844.git.waqar.hameed@axis.com/

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

 .../iio/proximity/nicera,d3323aa.yaml         |  62 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/proximity/Kconfig                 |   9 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/d3323aa.c               | 814 ++++++++++++++++++
 5 files changed, 888 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
 create mode 100644 drivers/iio/proximity/d3323aa.c


base-commit: 66701750d5565c574af42bef0b789ce0203e3071
-- 
2.39.5


