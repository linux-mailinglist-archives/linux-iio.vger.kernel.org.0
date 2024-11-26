Return-Path: <linux-iio+bounces-12680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1E9D98F8
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 15:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0488B163BDC
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB621D5AA9;
	Tue, 26 Nov 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FVuf87ST"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B871CC89D;
	Tue, 26 Nov 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629616; cv=fail; b=XoEHZ20WnRpxrJHQHSAWZJNxqmAQZo0Z53LCc1LB0i+F3OjdYWAmZNWy5aQnPfhXHAU4xv2BvlidLgiLTtLZh9zh9WRU45LsaK8I/FDc39RCM2HWd5Rx2Khm+mTY3kLgY6ph/CTHuGFs1w7GbNCxb24NqjNzbeDju3uvDrymiAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629616; c=relaxed/simple;
	bh=UpzWPWWEEwul7Cj8clsMBYcqdEzH/kAyHojL3f3ThFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NP6TxcfyU2OjL/w9OPv9G/U3iXmZN4qTe5jveahpHw5/8d0s3zaJLzV4tkliqvrEcUxqGeaTq05/0/sZqgTqcp8kKZDvd808633Ik/jUqb7Vjb6sJBnvVK1EHdqtIAkZY7kdMwt3ui+JREPgWouC9kc3xN+aWCLpp5vyJYhGbYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FVuf87ST; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHc15BAKd1kvf+CO5CUlBFDRNjC9AzsbCHDOJajOlVKl6NgYNHtfWSFVktseR44rjalWRp4dLvMszfYCVCh8dtIsIyBHL3+XhgPyhHEBs1dXPLt5Cy7nhxajdSNeDieJ5ZBScJ2V+6+n+DfG/LwudcSYY0YFlalw/uCY1DFOtgCLW1gidnLjtR1dpk39fHyTcrQO6E7gH340aoLe84e1K16wP74w1VIjK5M+Y/zQb+963GsHH/36slqVLC1bkCdKCUArF4YmgeBGWzvxO5OhvgBulZHKbL6PHqMir2b/hpPiaATtSBDdl8+xvAhkf2JPJcbqSDRBsXgoZjEdowhpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9OJIaEC3Qwg+OID+0g57PRp2yuMFZPIt2Q7yaoasb8=;
 b=FGaMWN1PQoPEGiGNvuE60cvcKnb/HtYQqv4DUAWyz1bSTzwau2X8aOGwQI2wsFscrl2UbnSsHo9tIwTe5gOR6xAmS5KkIAf4gF9vmZ4xjdhW7H9HRd7ZybFLLsaLfJjXqG+yo999k7Yf1sc6cDgKypDUTYJ6r6kuHoJ4I8n5rGiYPPd5TsYI6oAfqrqyPYTZWDN72M4nsmR0JI0Mo4KUYazgLXWPVGNla+2GtO9i4cYYarWSKm6FfsoiGQB3EOHbiIxYWYwI8pK8iRVoYiucZlAWIZb8eqHbhdbId8nYzEcM8G7uJDMBZUZ5wduDWmMkG8hhCSJJqHAwmgFtgur1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9OJIaEC3Qwg+OID+0g57PRp2yuMFZPIt2Q7yaoasb8=;
 b=FVuf87STsW80gtqcQkJVMG04JjirNIuyFR7WaBcPF1395s6/O3UmCnVzpckDLwz5V9VTSxCnxrNi/gAYtNc09LFSDPfaQh0TtDy8wtnp/libYUKeXRhUE9j5G6CAGHRZhigEnLmFtEqT1gupLW47cOdx8sSUqktzuIjxE+SX7+0=
Received: from DU7P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::21)
 by DU0PR02MB8689.eurprd02.prod.outlook.com (2603:10a6:10:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 14:00:09 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::f2) by DU7P189CA0014.outlook.office365.com
 (2603:10a6:10:552::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Tue,
 26 Nov 2024 14:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 14:00:08 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 15:00:05 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Nov 2024 15:00:05 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 9327C1A3;
	Tue, 26 Nov 2024 15:00:05 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 70C3718E1ECB; Tue, 26 Nov 2024 15:00:05 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v7 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Tue, 26 Nov 2024 15:00:00 +0100
Message-ID: <20241126140002.1564564-1-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|DU0PR02MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 77834fa7-2433-4b36-d7f7-08dd0e22a37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbMrlLeRX04U1uEE+u9sxc68borMfePhiSKPv4IV/wI/qAJmd4NvG/bun9zq?=
 =?us-ascii?Q?PPbErAU5kpLDEEbMASY3A4Grn5jBrK6AM3RsTf7ADCZ+Yi9pUG0OKFckdrOP?=
 =?us-ascii?Q?1GLLix4PnH2+04n2IPEFKvLjenCQrn+RvAWzIr5BpuPeMe0H9ZZWF0dI//p8?=
 =?us-ascii?Q?fRPj5aZu9XXR80quCQC6KpcQ/ZhRZAXl/QUrhNioX7iHANYUorUn3kEM4gvL?=
 =?us-ascii?Q?5pXwGTKNARgjvWrUnNnXyWEsXbKtnGgL8UgGRa8uDUuQfM4zjyB9uWJ9ukEh?=
 =?us-ascii?Q?KDix/DKUClpO3SCz39sxx6KOIWHVw8MsfJLFSAdV40g2xNuTfKKMaAubxnAn?=
 =?us-ascii?Q?dNRYuc8r3AXwkSPcllONbHaOSjcdALPvg3R4WDLuMq+BSnt5YejD/bvv42jI?=
 =?us-ascii?Q?yr5fFe0kgUJiH9cWtLfAiYbvYuxrUGb/4oiIPd/fmuBRcMYl98iX6ErC/N2R?=
 =?us-ascii?Q?P6ZllxjE1/hmmEZuWH3cGlRfAEXIFQYM67LtqRqSQgztlhsgvtRwY4JwGIhu?=
 =?us-ascii?Q?haHlHjNi/IhLzjidpr+on/tlcPzP7EAMhRjAduIFf7HGw128OxC/A/zB/sFT?=
 =?us-ascii?Q?PKg5re820YiU/5urSSR7YErmOYomZ9mEvui/y5zhiRnxf9f0IAFiwuCReE57?=
 =?us-ascii?Q?GR+1+VpnULnS7KIG4ypHgJBGYsWWgHOhGUNoGGG9geChHnhe9Koxtr9UlnQV?=
 =?us-ascii?Q?8fHOvG7XHl+zPTo8Cm0mLCKgROA56EwOgCAY8vLngpc4aegAleM38hFgiz8C?=
 =?us-ascii?Q?VCe1BUykC2oAxaxp7maaMsse477wN6einjrGmQ2SP54HVglJT1LDE/OPoB7u?=
 =?us-ascii?Q?y6Rut4/uKLbllT1J5n3Q06ZbCrzVLymYhQWRjPtpXDuY+nLMP0yGx79Ri5Uw?=
 =?us-ascii?Q?0YHIA0+X8sx9tVVwk23+XSw70HWr/Fgo49rN3Xb37WDKDNEfvM2AnkSEmLVt?=
 =?us-ascii?Q?dyQgQoUsUFVLk7oOwV/a3K5j9utGsvWNhP8oNrBEzf0WeAs0xkK7cPKvDc2W?=
 =?us-ascii?Q?0FTCda8abrcVedgx88Trulfbeo6sr+nCQxEPWK37M2aVATHClCJU4nIWoo5x?=
 =?us-ascii?Q?F8BLolW0TlIYpU3YksDNNbZ3GmEh0rnVIAo8IHROw0zpCBdDbgK0qArqgiLl?=
 =?us-ascii?Q?b4hamvMGf5H8wpjDKY4FmKofL8NfMDPaiKlXiOpOXkKIQEkTZhzDi34mhogv?=
 =?us-ascii?Q?y4yfhEOmO8F7mbbaQZpcAwFNhxPqI2bHhzQLoN45IxWqC5Eyw0TO+lTT2irh?=
 =?us-ascii?Q?+xPOsRK+rN8QFfsXzBuIiClVaIu/mFO1VtpxY4mvVgobl2DDfvu+0b4hXV0F?=
 =?us-ascii?Q?Rw+GNjXGkCRuv58v6TqlR3qV4ZnZe61tcUPiFvCIKp0OLgfMD3/RewWAgTdO?=
 =?us-ascii?Q?pTfbYPhSfIpniek8DfAeGCaZ6D1I1mmtI3IRJAWAaFVKZsGfmCLPY9JtA94V?=
 =?us-ascii?Q?Y6Gc2ZGlAk2g+Tctcyh+ptDy6zl8rO+5?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 14:00:08.9344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77834fa7-2433-4b36-d7f7-08dd0e22a37f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8689

This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
using the i2c interface.

The driver exposes raw adc values for red, green, blue and clear. The
illuminance is exposed as a calculated value in lux, the calculation uses the
wide spectrum green channel as base. The driver supports scaled values for red,
green and blue. The raw values are scaled so that for a particular test light
source, typically white, the measurement intensity is the same across the
different color channels. Integration time can be configured through sysfs as
well. The OPT4060 sensor supports both rising and falling threshold interrupts.
These interrupts are exposed as IIO events. The driver also implements an IIO
triggered buffer with a trigger for conversion ready interrupts.

Changes in v7:
- Calculation for scaled values changed to remove normalization.
- Fixed alignment in opt4060_write_ev_period(...).
- Fixed alignment in opt4060_read_ev_period(...).
- Updates state to bool in opt4060_write_event_config(...).
- dt-bindings: Define vdd-supply as required.
- dt-bindings: Removed description of vdd-supply.
- dt-bindings: Removed "Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>"
  due to changes.
- Documentation: Added missing _scale parameters in Documentation/ABI/testing/sysfs-bus-iio
- Documentation: Updated opt4060.rst with description of scaled values without normalization.
- Cover letter: Description adapted to the new implementation of scaled values.
- Link to V6: https://lore.kernel.org/lkml/20241120163247.2791600-1-perdaniel.olsson@axis.com/

Changes in v6:
- Modified the driver to work with any trigger. Verified using iio-trig-sysfs.
- Fixed return in opt4060_trigger_set_state(...).
- Break added in opt4060_read_ev_period(...).
- Struct and variable declaration chnages in opt4060_trigger_handler(...).
- Events changed to modified and not unmodified.
- Moved variable declaration from case statement in opt4060_read_event(...), and
  opt4060_write_event(...), found by test robot.
- Init_completion() moved to a place related to IRQ.
- Documentation: Added opt4060.rst with description of calculations.
- Ducumentation: Added missing _raw parameters in Documentation/ABI/testing/sysfs-bus-iio
- Link to V5: https://lore.kernel.org/lkml/20241106120036.986755-1-perdaniel.olsson@axis.com/

Changes in v5:
- Cover letter: Description adapted to new channel and trigger setup.
- Trigger for threshold removed.
- Channel setup modified according to email discussion.
- Switched to aligned_s64 from linux-next.
- Endianness in buffer changed to IIO_CPU.
- opt4060_read_raw_value(...) changed to avoid endian issue plus early return.
- opt4060_read_chan_value(...) split of in several for new channel setup.
- Improved return values in multiple places.
- The preenable callback removed, functionality moved to set_state.
- Irq setup removed from opt4060_irq_thread(...).
- Flipped logic with early return in opt4060_trigger_one_shot(...).
- devm_add_action_or_reset(...) moved to after opt4060_load_defaults(...).
- Documentation: Added sysfs-bus-iio-light-opt4060 with channel descriptions.
- Added hard coded name indio_dev->name.
- Modified opt4060_volatile_reg(...) to make test robot happy.
- Link to V4: https://lore.kernel.org/lkml/20241016213409.3823162-1-perdaniel.olsson@axis.com/

Changes in v4:
- Fix for a warning found by test robot in opt4060_write_event(...).
- Correction of early return in opt4060_write_event(...) and opt4060_read_event(...),
  missed from review of version 2.
- Correction of timeout for sample conversion.
- Correction of bug when changing integration time with buffer enabled.
- Link to V3: https://lore.kernel.org/lkml/20241015143713.2017626-1-perdaniel.olsson@axis.com/

Changes in v3:
- Cover letter: Removed lux from description.
- OPT_4060_DRV_NAME define removed.
- Corrected alignment for struct opt4060_buffer.
- Added description of the CRC calculation.
- Cleaned variable declaration in several places.
- Added a path for the non-irq case in opt4060_read_chan_value(...).
- Added a description of processed values.
- Use of regmap_clear_bits in opt4060_power_down(...).
- Switched to IIO_INTENSITY instead of IIO_LIGHT.
- Correction of channel index in IIO_UNMOD_EVENT_CODE, found by test robot.
- Added iio_chan_spec for the non-irq case without events.
- Fixed braces in a few if-else statements.
- Refactoring with early returns in a few places to reduce indentation.
- Replaced for_each_set_bit with iio_for_each_active_channel.
- Removed various too obvious comments.
- Fixed various other code style problems.
- Link to V2: https://lore.kernel.org/lkml/20241005165119.3549472-1-perdaniel.olsson@axis.com/

Changes in v2:
- dt-bindings: Removed incorrect allOf.
- dt-bindings: Changed to generic node name.
- Correction in opt4060_trigger_one_shot(...) for continuous mode.
- Correction in opt4060_power_down(...), wrong register was read.
- Corrected usage of active_scan_mask in opt4060_trigger_handler(...).
- Clean-up of various comments.
- Link to V1: https://lore.kernel.org/lkml/20241003164932.1162049-1-perdaniel.olsson@axis.com/

Per-Daniel Olsson (2):
  dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
  iio: light: Add support for TI OPT4060 color sensor

 Documentation/ABI/testing/sysfs-bus-iio       |    7 +
 .../bindings/iio/light/ti,opt4060.yaml        |   51 +
 Documentation/iio/index.rst                   |    1 +
 Documentation/iio/opt4060.rst                 |   58 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/opt4060.c                   | 1289 +++++++++++++++++
 7 files changed, 1420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 Documentation/iio/opt4060.rst
 create mode 100644 drivers/iio/light/opt4060.c

--
2.39.5


