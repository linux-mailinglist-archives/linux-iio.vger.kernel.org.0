Return-Path: <linux-iio+bounces-12685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400E19D9AB0
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1631281807
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838821D63F6;
	Tue, 26 Nov 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="lYfe1/2M"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA441D45F0;
	Tue, 26 Nov 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636402; cv=fail; b=qpQ8xL+XwU79rrXFIEJGfG0n4aJsScw86ND4kiRF3LKeht5lI/Gbbrd8nOTnZ431uTesSCU+yuQWeii1cJpgfnd96Ue3G2mUqsPee0r8sNpwa9PoWmdkjb4NJS+y0iozSL4J+Vj3FapjtEJm2VD2vEygDmBcTqCn0GGHkB0qFLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636402; c=relaxed/simple;
	bh=MKYpswTk4yBwO0JCWynVFLeS0/1+N/ewdteHPCTjJCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sThg87e1NJZURuIwL3O0+H6uxFtKveDp8+VwazNE0V5OgMx6D1+nVcW5CCwgi/3jJ0jmpDsaa3tVqav1OphzdAZ/mVG0NmwXD9Uz9xEqwKHrTnJw6FLQ2og+tCSykVXgX4dFXK+vfQGtG4dCDEz01hh+zypikbEvNlXmXvk0J0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=lYfe1/2M; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJM8re/M4Kk/POAUVm5W8NBYYs0hEKLQgfgu/DwuJI+7TjHMQL2HQC7bANRltwxd3rWNMdoBsq1MLyNWNw76vLHamTy+4JU9lFRI1uAFWlBqpk/qcTinQ+fkHxkroDTsQH5LLsZoc+jpXB86XbzOD0GYc+TnxqLxs6+o8q2ZbhCGZTRJJtpk/M7uUbRAk0ei2RdiztqkZ7sGJ3nsvIlXypsgrfL7uV/78Ijxrlz90Jlilwrlt8OvG3ZRMPJz5zU3RJd7Gh/rngz7NRebtVxAWxm7Axn+T0L8MXYE6nSazZ3I8L92BduiguE84TCchY1XoZiXfY3bb73M/rV9pDAvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ3EWYa14z+DC9HisHpwBfy2WON79h0m+F2vWi7NE1g=;
 b=s2cfUaphI7HmdUoU5OuKapXcxKrByyuw202FbLsCTIGoek+Wjmw62rqtp9fexK/eq9yNvI/7DtaH6O7B9hzY7HZ2C2OXEkGp4HT8FzuzX/TJLQyJrkiKu6cb830DCv+vCBst0DeH+oeB0SLAlOuNTvKNoCUurdWiJdwjeYzYCNyeHMi7xJvx99oMADnraWZJARdvPG2RhZITGwJgCdsojKz116kZzGy24Rt8ISTd3uX88ufq8bzTaX1WNmr4SwX0wIEJVMzruLWKE5s6M48xEmN1mX5aypTBbt9kG3ESMLXOg3hZTTXXchWdcO5WavRTOc6oqAsskjVs4UGjKTkjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ3EWYa14z+DC9HisHpwBfy2WON79h0m+F2vWi7NE1g=;
 b=lYfe1/2MLUkDNi1EQCWz1QM1VTL98wYXzNgtDrOhg37DpzH8ARO+411Li2BgnXkdlAsJq8aAoUgBQuiYJG9bqfiMv6mD04jaoH0JNCoXqlodB/IFWjx5RsanfCwjGfiZMot2aF9JJvXIiX6vavOOUGS+sJUxoy9pzP4HxTcVs+M=
Received: from DB9PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:10:1db::18)
 by AS8PR02MB10244.eurprd02.prod.outlook.com (2603:10a6:20b:628::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 15:53:16 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::4) by DB9PR06CA0013.outlook.office365.com
 (2603:10a6:10:1db::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Tue,
 26 Nov 2024 15:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 15:53:16 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 16:53:15 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 16:53:14 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Nov 2024 16:53:14 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id C75DA281;
	Tue, 26 Nov 2024 16:53:14 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id AD6B818E1ECB; Tue, 26 Nov 2024 16:53:14 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v8 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Tue, 26 Nov 2024 16:53:10 +0100
Message-ID: <20241126155312.1660271-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9A:EE_|AS8PR02MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a7854e-4e3a-4dc6-e568-08dd0e3270f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKnH2MvCNWCuPLR63kEqc4TFsmQ893Y7VLmpO0bTLfb08iIRVKpdrOP4rdCZ?=
 =?us-ascii?Q?5up90Q90zoY4NODkFxXXXSUV7BySHfYN9wI1O8a1IHZllhl5h4LMoEdIGp93?=
 =?us-ascii?Q?x9e5/qkBE0Q7Ejl9hSpxnqBJ3KolFB7beswbi8e7ST0NYJ4dcObOFZBbqWJ8?=
 =?us-ascii?Q?nLpOcJpFrDKYwGgMm0Kfs04aqfOZIbor/udyDH0/smTwSRyaGCcJoJrEkTM5?=
 =?us-ascii?Q?PO2rKTCFog0zgM4aHc1TPxWtDDKXBQPsb5Pzyd4fYq4OiWoBYFgdpHNqFEOb?=
 =?us-ascii?Q?YjGkvwkRqf6dGhKQm95lJggkDYm7/jvBYLRC8uN+jSBJY30FcTtDiI3CGMxq?=
 =?us-ascii?Q?uLJSvdYpYbwLJfI+r8lo0Upwy8DMiVic3l2hO5jXJf/rgxUcGlTLd9rP7hQ0?=
 =?us-ascii?Q?lGeR6u7evqyR1lOuzTTgspzCHc3VgE8q5EQTxSv0Vs5XwcMyyKRBP8Flo5eE?=
 =?us-ascii?Q?lgluE4sWlpsXgoca7TOl8HEaf6iGdMERN5C2Guax4sxxFlhTvYwSwbr4XkXg?=
 =?us-ascii?Q?40g/5qcZ/3jEhxXrQ1ugr9W/G3xyKEGgzI7L6dfnB7K2xOC/181oUCSHmq+m?=
 =?us-ascii?Q?yd/nlSC2P4rfYm76/b+6Z6fjRq2m+6EZC3kE9wzCVZAVrqZAs6h09hq1y26h?=
 =?us-ascii?Q?+5kLtoTsqeIWztNDc2yoXWIAUl+SSSo5vgA0idiPxMs67CCZc9P4G7ptlR04?=
 =?us-ascii?Q?fXHi8yhgawIvv+MstOmaKhUIwVQsIIT9oVqSbWpSjoCZg823n5tZl2NDRhUz?=
 =?us-ascii?Q?lDmUeZv+8zqqpgmnBNV2+w8a5T8lqLObkkf4kDZoYNDnnLOd7+Gvu1y2IQvI?=
 =?us-ascii?Q?nCiGBFxRi55TvnCdNd4FIRDEk2lFZ97eNN/mejij5m4vkVzpULx6BcQzq13g?=
 =?us-ascii?Q?B0+YLSLFs9Y8JGJv+fYRW4S7Q6syy7x0JG2WvOlMgmxyULdZihbeJtgn4NLV?=
 =?us-ascii?Q?TOOju5fbOhxaqkDnau2wMRdz0m8MfBYFdEkDgAsN3XaCJLkfb8O+GGBjKS0A?=
 =?us-ascii?Q?aVtM59Wpu7g5hdabqVXbPqJQaCODO+kCaNUJ9s3icsi138s/C21eRv9vMHFm?=
 =?us-ascii?Q?cUaRsDOt97tOkFNbUNAC3V3RxU038QuMwOJaWD/V7I2SqnBl6Ii3V9qDskIS?=
 =?us-ascii?Q?BeCveU4kIx+13IXw01oN/sq36RkVc4WFUDjJY25sNHmRUKDQmchIYK5IAKOA?=
 =?us-ascii?Q?4y5ufMHVPSNWS9MhyvUnURtO2ySKv8X6P8oSO3iQ4bIC8JFoAfhwR4rQK1IR?=
 =?us-ascii?Q?WMMeyoxGp1S3KHVfX8G8c3VVhnJJFuZ4TcicCw3fjT6SxgX2vYjjVQcClGen?=
 =?us-ascii?Q?YNhCSbkKpQy5KzWtPdeaQIEsYPpkn1he37FCmGkCBZeLVGBQ0E+g0cZIDxEB?=
 =?us-ascii?Q?BdhgenmJ6M2kZNpbRStKsH0K94T6TDO40Afm3KaxXQ8fTnQihKc1OkuLEV1C?=
 =?us-ascii?Q?F0ND3FuFbKh2gKDngXNsPVSeZ3FpeQXC?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 15:53:16.2235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a7854e-4e3a-4dc6-e568-08dd0e3270f6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10244

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

Changes in v8:
- Documentation: Fixed new line warning in opt4060.rst
- dt-bindings: Re-added "Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>"
- Link to V7: https://lore.kernel.org/lkml/20241126140002.1564564-1-perdaniel.olsson@axis.com/

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


