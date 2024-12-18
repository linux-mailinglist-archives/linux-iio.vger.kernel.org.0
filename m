Return-Path: <linux-iio+bounces-13609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29F9F63BF
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 11:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138FD1894164
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F83199FB2;
	Wed, 18 Dec 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ogrt14yU"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBA136671;
	Wed, 18 Dec 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518926; cv=fail; b=eIp3+Qu8NBFxmIsgJuCznaQkNr3Ukh23oVxsUdpBpcHZPdRQ7+QJrzwF1dIfAGkYSEu2zv3Sjs46vRfxddZBK35xuwDPKvF0FAbHPCBH4GtlF2mXzCOwwtESsIZs3nTBARGknv5E9ZDOZP7ywdJbVxAX1bcnptcAgqcjoGYH+Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518926; c=relaxed/simple;
	bh=ENoZETrr7mluiq+EKe6/vEtA0Vb7OyrsIDmIeZNd2LY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7BkfjoyBy/0hrrV3AduCW3TS0Eg5tu2CCHBtHp5pPcm+tE+EQczec+W5hPtobOpJcZMlklfFizeEMYTVej/yr8IbVt/lPE2cc6y/XGSjqN2ZLLEX7MkXpry3LuXdeyCu8H29YoWwEuCrRfr5cjk+RY/BN/IHtRb5pFjP6iz2vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ogrt14yU; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvLCP5VEpBFRnINFxuh2isMsrXueMx4aG/DIqC+EArWaAHXJNz5QMZ0Vj/KYvGiah0JfZyOgTsrPU1yYrI+anfwlu2BfqSI5FUXvQr04Lc+j6YVy86b93Toy1DiQ1NfvGiI0yZdywoufonm4K8e4hxfcWNvWXmcYYEl7QJJcQObHTEW/+IDFy+uogMIcw/dYf8DJb0KerU5EjiRPXLHA/eIAdis6vty1pgfZn+tYkP+MKHAPdPEJ4wb1UupI78I9BW4RbOi3VXOvR4pJhi7OKCvnMMA0g02FpA2WvHagJBgkNLFv5Y72HCAsjqtadrRW6pKF0SrCJ0WcI0Ws3AsExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlX2iHZtcBHSSQlIGUQzq/mNMcF6lNPdcrmW2cY/3M0=;
 b=TijvHIOoxhVKjrpLtmw0KJWCsD+rOZ3fMM0i036SDRoY6yJZ3NYoomuYePvNhEvRJFM/GNveJuQbmw6Zz6+4vSNB6VB1CnVDq12wNbv7YIuG9hq4UHT6P/yPaWB7kOmk47Lr4K3V3tmhbG2kRzR8x21G3z9fFswH0/nHEmNyiy6F++7z12JqOjumrrnadEFbTPxh4ks/ne4h+s2t30EBonrcMvxQNUHgS2R0NCK1aEtbdAeArIxh5C78+3w83+IsZnuuCfsh3x90iDBwx9b/Rt6fS6ldSvqoEQONhYK8ySsFd2A5I6YCJvywj+r/nJ4x5cgaNieSgtp6zcuPwmJWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlX2iHZtcBHSSQlIGUQzq/mNMcF6lNPdcrmW2cY/3M0=;
 b=ogrt14yUWB4XWM88rbA5RN/EegHnWLzqZrhwIPMDPqXcRC7eJ/q+/rW6dk1aduznsDzyoKCfDgwCqznO87RjjoqsU2Xp4p75VBJoslTzt+f22rZ0DBxekSiGQPeTIvrpYYfsdvU5H0bZjUE03q2PH/cfnWsb/X5Ye4Xb2xStT+8=
Received: from PAZP264CA0077.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::15)
 by AS8PR02MB8827.eurprd02.prod.outlook.com (2603:10a6:20b:53c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 10:48:41 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:102:1fa:cafe::ac) by PAZP264CA0077.outlook.office365.com
 (2603:10a6:102:1fa::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 10:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 10:48:41 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 18 Dec
 2024 11:48:40 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 18 Dec 2024 11:48:40 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7FFE0173;
	Wed, 18 Dec 2024 11:48:40 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 7CF0818E1EC0; Wed, 18 Dec 2024 11:48:40 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v10 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Wed, 18 Dec 2024 11:48:34 +0100
Message-ID: <20241218104836.2784523-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|AS8PR02MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: cde13488-c035-45f0-7bad-08dd1f518971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1nJlLFzayOC2DcOOW5AQg522bMhsa+Pb0Z/sVZARkBk+1B+oSfx45mXx+dzv?=
 =?us-ascii?Q?o2erFeD8XYwoVhih2ljLPaWbeYqKeeDv9n/UP6OFezmQwD8yrN36MRM+hEhM?=
 =?us-ascii?Q?yHSOafXjhVaQUQO9Qj+5rtK/be8iW/hKlORu696fyu//wHkopB9MRDzXK/0i?=
 =?us-ascii?Q?43GU0ruXUQt1YWHb8ZX1c6ZtYEJgIT2RPUydud/VtAI56SZxr5P6XKsE9+V0?=
 =?us-ascii?Q?Kxl37SFW/AMRzqcIcaPEs78kdjjro1ONedXKXJBVPdM6CFKhbpMX2R/nhKXk?=
 =?us-ascii?Q?/cOysV2ljlllXUxzO73n2sfk68VTArUeG3SSb2c3tIJ9gFHyskzVR93+dXCV?=
 =?us-ascii?Q?LmE3a+QQbl8kPyJl2g9tEH5LPZM0tKS3nWzLPuRWsXutlDNdzJ5Zts+HqKc8?=
 =?us-ascii?Q?gnpvzDAvgf2+7qzX78+LZTeDFqS8c0d7nkrRxsq4vEQsB2iR/SIqtxYSR44J?=
 =?us-ascii?Q?kV94KNuQNlKpmRQ+QHfa67e6rzuKTI4myjqXfkib8Dhz8jMDKr/36L/8kJC7?=
 =?us-ascii?Q?NzEijRhoaTvOsADFQkGjNAYWnY6HCcTE+7Bj/td5OJCjFZnd6PgL1iGedoJm?=
 =?us-ascii?Q?fsilLI2zqeYIjodhl9EKRMhfxq4g3T2WfHy1eWwCtHlG87Y6CRswAACnGP3b?=
 =?us-ascii?Q?7HebREABr7b11vFhxVpYnQ1HGYgcwGxoYBo82DTAYibSHsPlh/T0LiUIAnmD?=
 =?us-ascii?Q?Z48SLrCd7eoVLgAKZAuWtqUuDKIPgsHPFjBXAvQm/pF7KpfNGGqzDQGc671O?=
 =?us-ascii?Q?KN0T/1Dz/rjG6L5h6Xc6wnxalS9Veg4gFqM5ZX/ZJ7HDWhuv6xEm7nsPdDsl?=
 =?us-ascii?Q?pngbCutEhMyPtmeKHByjVqWBXrjsFgQ1ToEToKg9eib+4CW0LmD3OBqVSh/N?=
 =?us-ascii?Q?zlq8h+vpj7y6Ab+vK6cbrZtUn4mEeiU6DucoDwLrpEvTuYMFyEdjf3ieTjUg?=
 =?us-ascii?Q?fvMAc9tbmdrluf1ysdy5WAxDqzkTbODA5QzjvnojGk/1cQmQP0ZtwsqWs9tN?=
 =?us-ascii?Q?d/PU9xVXpUNctn+zVSXv5zYmvAnJcKNQPyyNpQ+UdyrdEdhxl3+tQZeS1ZY0?=
 =?us-ascii?Q?ILJfhb/eJmIbKtYb4ynROx6oYseJAjUyYy2dNeMuEFpovjJyZAAESGvxE1B1?=
 =?us-ascii?Q?/K2O0H2no/+LN48EWx3dhOnrf9UfJnRCx40OBgGfnLJBohBzVhVr5lXztUBa?=
 =?us-ascii?Q?CO7EBnBWugrdu7uabv7u5bswWKO+TTJrdQ6P+OTpGyL38rpBBd/+UI97JzWd?=
 =?us-ascii?Q?Ez0IQUMUi+MIVjMBopk4ojbCRsVHI0RovCtK1FaNeQtFMY78v/iC4Oa/JxY/?=
 =?us-ascii?Q?JA8BqbppvNNhSRFKEIv3rc16UiPROPmJm7/SmvVpD8UgJFxZKaGDpqW/OqmY?=
 =?us-ascii?Q?LjVrhbbOMG+RsU4q9IfbvxyWWPCyBCBg1Ief+16zY3SoviyKvZ2Ow6ks7ioP?=
 =?us-ascii?Q?CV+S5CUvjg0=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 10:48:41.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde13488-c035-45f0-7bad-08dd1f518971
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8827

This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
using the i2c interface.

The driver exposes raw adc values for red, green, blue and clear. The
illuminance is exposed as a calculated value in lux, the calculation uses the
wide spectrum green channel as base. The driver supports scale values for red,
green and blue. The raw values are scaled so that for a particular test light
source, typically white, the measurement intensity is the same across the
different color channels. Integration time can be configured through sysfs as
well. The OPT4060 sensor supports both rising and falling threshold interrupts.
These interrupts are exposed as IIO events. The driver also implements an IIO
triggered buffer with a trigger for conversion ready interrupts.

Changes in v10:
- Comments added for mutexes.
- Mutex handling implemented using guard instead of mutex_lock/unlock in various places.
- A guard has been added to opt4060_write_event_config() to prevent races.
- opt4060_set_continuous_mode() renamed to opt4060_set_sampling_mode().
- Better comments in opt4060_set_sampling_mode() to explain usage of regmap_write.
- Procedure added to claim either buffer mode or direct mode in opt4060_set_driver_state().
- Improved comments in various places.
- Added a separate struct iio_info without events for the case without interrupts.
- Removed the incorrect IRQF_TRIGGER_RISING from devm_request_threaded_irq().
- Replaced mutex_init with devm_mutex_init.
- Link to V9: https://lore.kernel.org/lkml/20241211140409.1619910-1-perdaniel.olsson@axis.com/

Changes in v9:
- Implemented mitigation for race conditions between buffers, sysfs read and events.
This resulted in fairly big changes around opt4060_trigger_one_shot(...),
opt4060_trigger_set_state(...) and opt4060_event_set_state(...). Some functions
are renamed and moved within the file. The general concept is that direct mode
has to be claimed for removing continuous sampling and irq.
- Fixed some typos.
- Changed in_intensity_xxx_scale to return factors instead of scaled raw values.
- Documentation: Adapted opt4060.rst to scaled factors instead of scaled raw values.
- Link to V8: https://lore.kernel.org/lkml/20241126155312.1660271-1-perdaniel.olsson@axis.com/

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
 Documentation/iio/opt4060.rst                 |   61 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/opt4060.c                   | 1343 +++++++++++++++++
 7 files changed, 1477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 Documentation/iio/opt4060.rst
 create mode 100644 drivers/iio/light/opt4060.c

--
2.39.5


