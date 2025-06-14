Return-Path: <linux-iio+bounces-20673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163BAD9FFC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 23:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8494E7ABC84
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759B1FF1C8;
	Sat, 14 Jun 2025 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Tkad0Yth"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754C1F7569;
	Sat, 14 Jun 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749938208; cv=fail; b=rXoszyejTD2OWEJLNc+1Td8U4Yk5OauPhLacqWjxBPFNVLDdvYvEDh0+pRH6gseEsgQGlqCF8/K7UE8ExlLsfT3zxFmZHaUN92bLmUOx2z/cxMVDK9+eCDankcFJ1Z+TrUMix0H6kJdWuk43o4/RHaX5IQKrUhCN2R9aurc2pW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749938208; c=relaxed/simple;
	bh=xH4aH1ujc3IwrdZ4AWc0odMqcyZx+Y2+a5QG80F79b4=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=BWLIvmR8NFRTsLhOWizRfH28UonHxDWh7xYX/BkD2c6Dv9VWrjuY22rY7HKZR9jFslPygQUcmjAvA+Jlbb74Vy49Uk0bkATC27e3yCb8JU561XKrFWY2W796TcmXOy2M6/6x7ieMYb0Ad4toXXjGEsLNsKRAM3FCc8AbzZHdvtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Tkad0Yth; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab4Konc1Sg6BR5tRO0m/rQEnEyE0K3X/JdK3kh+Ks9EysaMAYS3KX4ylJr+ujBVJAIjWrZbuqk98BQRZZvX2og35UN7y+o5U4MflHyFH/oChmqpHVjSwyuWzu0X1KRCi6q8fCD/CvzhlxxiUvR1b3dI2LkewStTTWMIQEbMf+jmd2whNsohv+H60Q60x4k+sIKp9I5rZ2QI+X/tRarLj1Al4bEDKlD/1Jc5vI2g0LM9YNlxEt8/Pq0lZ063UUEOBkz0nbFovSrgp+WL9Y7POk1tBs5R1jjqNN5Ii9kzrLTz+j0tjiz3WWhlKlChl9zIra7Q34DiuFeW2aCBcHg//JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uH/wJqBrK4GkuSk295IulBTbyMiUxylgWpuoKKZdog=;
 b=SiN4+UprAx93O69bDnLezXt0PURt12hSutIUm1xbj2n7fRlDbYhuqI45dGP6l16CI4r+Y2OanYps14ONylgC1zakW1h5aQbJ69DNZWscNy7yVDlrqJw1ghGjuewks752TSb9EY0uW30s5goZHUmZyT5H6uSmablcppRUgd+tfnyDT54NwamrAPyv6x4DmG/M8Bb1gvX7o+Xvc3syoPW7z5OkFjx+i8v2Tk41iAAM/5rHzGGByKVulkBnrEWeVWnW0vNFN/4G/+mQ0GeWqKYu0lsY+RDInhuTIxZ0OPpi3sYod++b9zR9Kyl2NNUM/Ur2uAJyjDBPREuExARDokWhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uH/wJqBrK4GkuSk295IulBTbyMiUxylgWpuoKKZdog=;
 b=Tkad0YthSIEEYT18xDiKaUpgQdBagu+cSWFV9wDTefEFM0DFltbHuElQ31Q8IngGXrpECk6S34/9q/UMPlucWMG417MuhE77RSJjl8f4NLY35cOnL830TXmT7/AmV2tw8/mFME7d+HyILKwKlMsMHSYBPkGVHhmboggYw/IOrvA=
Received: from AM0PR04CA0080.eurprd04.prod.outlook.com (2603:10a6:208:be::21)
 by PR3PR02MB6089.eurprd02.prod.outlook.com (2603:10a6:102:6a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Sat, 14 Jun
 2025 21:56:42 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:208:be:cafe::f4) by AM0PR04CA0080.outlook.office365.com
 (2603:10a6:208:be::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Sat,
 14 Jun 2025 21:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 21:56:42 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sat, 14 Jun
 2025 23:56:41 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] Add driver for Nicera D3-323-AA PIR sensor
User-Agent: a.out
Message-ID: <cover.1749937579.git.waqar.hameed@axis.com>
Date: Sat, 14 Jun 2025 23:56:41 +0200
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|PR3PR02MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6a1084-9521-4891-e7af-08ddab8e58fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nKswCDnHBOqejparcAu1AR5e9IOTsH8c4CNE/+jj48dO1QFPAsKySXF1S75x?=
 =?us-ascii?Q?VUuSSrg5s2Yj13UJ1hWMtLLuoTJegotprf3LSEw1T1pfJ02QSRHWSmY40DLJ?=
 =?us-ascii?Q?09N8cOfo9qP3hc23RqtJBzULtcKfWc2A1f/U9xlqTLs91N7p5b2++h+IxRKa?=
 =?us-ascii?Q?4HBdC7YdNebPVg1IaCySiui1rLAUR5m7rDg9Qd2OspI19/oWD7mA3aGZ0+Jk?=
 =?us-ascii?Q?hldR0+LQNcqZnxtZ0cgSqmSfqnP2Rdgoe/A2G4wR8ZJ3+ALcfCGcmMtNEnBS?=
 =?us-ascii?Q?532ci8/5Ef3vrNiJK1Zp6F/pkFO4ZS8of5m+I9S4YsnuyKAuEWgVze8ZggD4?=
 =?us-ascii?Q?sTSZUuZ5vRiVpaRcASn3XciLgvoB+gQ7EEu1b43iNoQE1LTdJ9B9CESEAEbd?=
 =?us-ascii?Q?HTjdIqESoVN8anfAD3BUJrY5jG+4bqd+qGAVB65GA8Vpgb462pza8+mslCEV?=
 =?us-ascii?Q?qND9GPadZJQCB8ckBa8QzGZc1dYHkhSMRHNieXfm7pnMWRhryIL1sxtCQWXE?=
 =?us-ascii?Q?UzQBXkyxbW2jgsZg9oeKwlUb0CfZfqxqtf6lvZqp3oK2CGNEtY9c3kIazSbq?=
 =?us-ascii?Q?8rbVSVH1dDWeskmFGwGlcjYV9qAfEPHJhZNmvQD4om6Rn48z+fzBFsBqNfZs?=
 =?us-ascii?Q?WwE1wCnKy+NyEb+aljl1xIdRYL3pRr/KpVtB54kppZ3/+C6fdYQRxqbzy7Jp?=
 =?us-ascii?Q?0ijKCunhnqReuAN/MesgjS+LQ9CotvzscmYCiB9evW6Cztfe28fY58Y/bxbu?=
 =?us-ascii?Q?issjQaNYgOEFdZRIGpzhc7KA9t14MCs0hI1GdjoIgL4N6M1QEbp904BydxPM?=
 =?us-ascii?Q?y2iwvEagB3tKO4Y5gEZw27yvddrVPUXzwuC9OzwcmbBPUk7ZbC0KTCSW2oZq?=
 =?us-ascii?Q?L4b263sUhaKD+iQtgKZjk2PXeLNy1gACh1r8BxtEigg8YEjWH8/knqyf/cUw?=
 =?us-ascii?Q?JEb/4bqzqevjdzioWfsbkdPKV75FQDXoKHGeSsx9z77hQbCHUQhepSiL2il7?=
 =?us-ascii?Q?EtL42KYRps1I4AYOxmNC9fQWdvtE4BKTzxXgTnCgmj469rwJX2cuoRTXZmaW?=
 =?us-ascii?Q?wGNUhoT1kRlwHnPH/tEDGGQL9ddyB8G5AJHPI+UeKQt/fcW1x82j3RnB5iRm?=
 =?us-ascii?Q?1hwaGqgVVl30eIRphFd4jLfEHjLLLeGS2jjuEUyMJBTQOAtTzKOifA24mJT0?=
 =?us-ascii?Q?XL5gbmW+oV9a2cxhtE/6n2cKpo9UgS8ANBXX3VBPAAMlfW/uPN4c0s0Wkpxa?=
 =?us-ascii?Q?oPy0eHLVHXz/WOfZ29pY6/Z6T2xuTIAyaLg87qJ9KOL2cCFfqKGjtuD/6V1m?=
 =?us-ascii?Q?trqK8Iw0qMo2F3+anEu7RAvZrd/QjRmtsmH0y4u7pjHKJ13eAVDMr9ef5IAx?=
 =?us-ascii?Q?mzsfO5HDiUltLAge7VtS0NKjACjBcFhUR1Esw0cH8J02TfAjs704xP451ReL?=
 =?us-ascii?Q?4l8jTFVN4Ab8NwQQ9oaRhqRCQtUMnDnLQTtTIijYe3B0EEhxkWnKag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 21:56:42.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6a1084-9521-4891-e7af-08ddab8e58fd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6089

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


