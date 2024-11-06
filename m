Return-Path: <linux-iio+bounces-11941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14149BE676
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 13:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7132028550E
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620581DE4E9;
	Wed,  6 Nov 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GLgTdk45"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E241C69;
	Wed,  6 Nov 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894450; cv=fail; b=dGOyNQQT5OAqzuAKIRBaXLecbhhSwofPfrhxyfDe0xEglgucpGEc/g1HGq/JKR21cgp/YfF1ILt5poaVY/ZhSqGq3WRuSdgC8v2tfcz8oK/29RXulvJpGmBTZ+39tcT1vDDQ+Lu/Mi3kjXDj+pz7O7OX1xBz1TKYpjq34XIk2SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894450; c=relaxed/simple;
	bh=MFw67YHUJwFlR8MDi0LEQu303oKZyPeemYTG9nVrRO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lx1HO+iZWoI41TtSds6MYPGzgNpVG50iphQycFtyH6T6CLrr4q/lO9yLswfA0SqdBB+SDLyhULYrXlPtPGBAfvQwzEppnhgOAS5r08YjQ1LSevY/iPApq89uDTjsbA2s4edlo6AXuHac6J6p5MbRFfSCmIhQ+HDrp9juHv323ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GLgTdk45; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcvvXKzsuBiRCnxUh8RLCkDfQolLnOdIoIk3BIUyL+pIXgzwVsmzLqnPDaW+vbiBkN7ETdum2zh/zvqSU8MbNfRNWTlc/0xNYVo0brq8gVSNo2wpNqxkZ3t+4CpErRIGaxLJG4hdXH0ahwu/YGe47MaRT9dO0VWeqj2DcxAyumq5JXgt5qhsBp9HOiePD9YubWDmGAkRLJbHaQVvnPcAVLY8z8g1Qd76PMspjvdPMIY9Syhg7+QEM1zdlsF1ImxP7Dgjh7Bv6C0zxrFZ5UTsPdBTreJyTWPxM5xTVC4uNnQ7tD+WRB2Y7i/r9Zi1Td4aZ4ozIAdX00qMWil6tLsIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o45JHGbAm4tb4wgwhT2Emo6JGeMLTQmV4U0lQnIQ9BQ=;
 b=Naa/ZEkOAwkTQDYFmBHzIhtGwSGzkOlHjJ2v4YnmsvNJlJrQyjCG0HpZQ0vm7G67SDw6ponD7f/700hLPj4mR1zAoSbF3glZUQrShuYTImf7HigLgpXP5UJ+lbvU2nfbYzwJiSU/YCO18hWsS6BhIBnHsQMJvYNPykinmAaSk32v0spER8dM1n94i6Wau7GqoQvlXMZJPtr+h4U64srBVrXh801R6y8xQRvEuo3gp+0AZ2/ytE8JH4/ee7Pe4qlvhemi98WBzFEtA+zZ8hnbBRdK5Y7pToOwbywkCAGc55TBT+vPwFQn2oWrRtnUG1m1TubRp0cQ7G9xSOt5H3WC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o45JHGbAm4tb4wgwhT2Emo6JGeMLTQmV4U0lQnIQ9BQ=;
 b=GLgTdk45ZnUIdmgr3CTUrypCa7INMg3BX4DgDzRieXoPj1r+nCDUQmiC+h5zXosNgXOZYN+N+5wVPqDiuFpEM22GwxvgIbvhxWS1F0JytcAoBZUOG5i7G7jxGojFgiWKSxrs2+aghLPKlWJR5isdOvMSCfNh+3YnQtvcJp6gZ2c=
Received: from DU7P195CA0030.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::17)
 by GV1PR02MB10742.eurprd02.prod.outlook.com (2603:10a6:150:15d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 12:00:42 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::4e) by DU7P195CA0030.outlook.office365.com
 (2603:10a6:10:54d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Wed, 6 Nov 2024 12:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 12:00:42 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 13:00:40 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 13:00:40 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 6 Nov 2024 13:00:40 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id A0A2B871;
	Wed,  6 Nov 2024 13:00:40 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 9BFA418E1ECB; Wed,  6 Nov 2024 13:00:40 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v5 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Wed, 6 Nov 2024 13:00:34 +0100
Message-ID: <20241106120036.986755-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|GV1PR02MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: bf067984-af3a-4918-a762-08dcfe5aa376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1eRPuMbTF2QhfdaTSKg0rQmyILpy5dVnbMrpy6bxmRQC2McHdI+NFPkDECc?=
 =?us-ascii?Q?VxJHTC+07msoqIxaNOaR6xqeRxoG9L9S592rkyrSP1d54fRuzBqjYbBQrDWZ?=
 =?us-ascii?Q?gg4xHOR91NcM4rSCCTeJfZiKPQf8thjBB2JrS4y6LJv8bKzK2nH+vHtSVbOg?=
 =?us-ascii?Q?O2/pc1RSNjJH1S1mqMXJq1FHwsWuWM6fkVvgfekLDl4gd1hRHos/3tArRI4d?=
 =?us-ascii?Q?O8mlxcSQ/RNvRT+XNcuXdwnnLbMKN3KrEETd1uZfe0N2Zrs5MZyD+ld3QaVJ?=
 =?us-ascii?Q?KrBMiTJkqPJM+a8lrLUwxQ2RWyyE+li8P4SKaoixYArnsoEUIfsvBLkjwmcl?=
 =?us-ascii?Q?Dl8VX1rllDag/uratlOwy2dfwajX/9LZzEHzfSgMpLFbAhMn2fd2mpgOkWQW?=
 =?us-ascii?Q?rE/DsSElfgxRpg0EwO4YhS44Qe/OUi4qiQOImcynLHcrhmOHjebvsak+BN6l?=
 =?us-ascii?Q?8AVQed9VlwedKCgpRFwd+nYYAqJVghvDU1ReMjyPUgDPoE1A1mpWFan55H5h?=
 =?us-ascii?Q?rzLqodxZrt9yk4jYWjrCMAiktVGfGow0LRBIEx8MIdioFvkbhYt/OCkAagY5?=
 =?us-ascii?Q?mMzpV9LuIJTuyTRMr/Pq7EBHYVODJqQB5VVzIdbzJnJjhhIde9mU+ceEWrRb?=
 =?us-ascii?Q?0lfah6jA7e+2b+SglwTWYI67ppyUdVF3F39gtmdirOy3D8mbhnk2CZmRN+Ri?=
 =?us-ascii?Q?GcxTswKgH70SP5KqTiF6cB7401Z8u+OU1m1JeKYPFDm03T+VSvc55X++nMpR?=
 =?us-ascii?Q?R+1o6vVOrAebOU7sx+lRiNfjq3McZ1ayeTx5z5dpbQGhMKgETnYv8vtqXoUb?=
 =?us-ascii?Q?fhdqdubGLJCgXpCbcKLMOskM7qL6gzxS4PhojPNqHKWrNS4jTH161+UEUM2O?=
 =?us-ascii?Q?Q5Vua9L/hEpBYxE1NwBg8g9PpXZK4y/FykDnT5+OjaXW0gLjyKRP9OJknSn9?=
 =?us-ascii?Q?j/n7U8fSy0oH0evh0fubOvQ2u8P1hxKZU0oewbAMiaq9p4O8DqCdPkfDWB60?=
 =?us-ascii?Q?dQET+OEjYlJmkkYPnnB/+BbD1utl5qO0bZA4gIWD2yeavz9b+W5Zy2jBA4HV?=
 =?us-ascii?Q?QRdWJ2dMlSDvKnUvsA0VWLP8xs2UlmEdz/lHuEpqxWHAkBVha/NZ7XpEs0bH?=
 =?us-ascii?Q?bi5XCu21FdUYbMCUg8erd0GuJ7JBbV+7hRpTTRJE9sUFhqkD/B621VO0i673?=
 =?us-ascii?Q?cUkaJVwb3odoTEsjIF5Sx/UC3sgvts+ksu1MwRteNaabi5/6l3gyYEpiBs84?=
 =?us-ascii?Q?M6x/mB/5s4GLBgVH7bRNbvWHUB0sTEQTx5B+MV/FUXPMKZLlHqJsqueNlv+n?=
 =?us-ascii?Q?wFxsEPXJQ8vFnoodF8seFeHnUvDVkG5XTPrGBIQchFc/pxI0Iy2e2Z9+MV3/?=
 =?us-ascii?Q?YAZLYwsPDAtnNxa8waxsERaQRJGGHCXBbkPFzdxSAlb3wXJSQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 12:00:42.1960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf067984-af3a-4918-a762-08dcfe5aa376
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10742

This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
using the i2c interface.

The driver exposes raw adc values for red, green, blue and clear. The
illuminance is exposed as a calculated value in lux, the calculation uses the
wide spectrum green channel as base. The relative normalized color components
for red, green and blue are exposed as scaled values. Those values give the
relative colors independently of the light intensity. Integration time can be
configured through sysfs as well. The OPT4060 sensor supports both rising and
falling threshold interrupts. These interrupts are exposed as IIO events. The
driver also implements an IIO triggered buffer with a trigger for conversion
ready interrupts.

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

 .../ABI/testing/sysfs-bus-iio-light-opt4060   |   66 +
 .../bindings/iio/light/ti,opt4060.yaml        |   51 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/opt4060.c                   | 1282 +++++++++++++++++
 5 files changed, 1413 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 drivers/iio/light/opt4060.c

--
2.39.5


