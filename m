Return-Path: <linux-iio+bounces-13330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADED9ECDF3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 15:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC59281FCC
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8523692B;
	Wed, 11 Dec 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IC5bz2qy"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E9233690;
	Wed, 11 Dec 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925867; cv=fail; b=Ek9mfAQvLZT6ctyBPveXOLz5jpBiyIGyW1SnfHTw87099UcA7+XksUyVF9ZuUncurZOExMDjg8W0v2RzHeeJVJc0LrVYM2xlCmHnkqmIgs6aTJV3srupe9mka2CkgD+jPX6pXFH1vsLpoGhT7NrNOBFgjL7aj0gMOe4CFY0Zftk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925867; c=relaxed/simple;
	bh=qeobj27iIGckPAY7QBuq3sla2AZ6+godykvv4UDFf+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FB6PPAyBfdge6Lk7nZ8by+eM50JedmLxb9dRjeukkiza/pgpVDbt7UR8cbDmnb8HsiCRYVpliov0N1GqHQ0IR1mHLH9Nutg/gYE3ppng5e7mfMyFrFrv9gal3n5sLtRQkUdXr+j4ZaaNtIQWZVlk6fhIFQvGmJtxpmEY6gWoPcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IC5bz2qy; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7HWCdnhyYtSF9k1SUpZq4NSUgMxYEh7p1izS/siOFKllXlla6IED+VaLdpcDKxAQ39J6fUkAaXvtrpfEJ9oFkvWg6GrUUnd6sPk0L6so9Te68S3lvRPw7JryRrUe5IZvJd4CIgKHHIGiSh9jdPCHttw25PGb/dmAkpuoL+jnq/QWpnXk7ESPzMQq1kAmWl6gveszrMSkOXUQKpHwufMidi0Hh3iF328jmVjeCJzxK8JYZ7FsC5mS1vyLfIMO17V7nXgGWi44X/yDSqam5fEvRHhoyrBXvtH2z3g14V6jHbu1frN+wOFLl03NKQAESo6Z7CLAGQocHJWBCbFQQVpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjSpY8CzbYuxR4/VM0jESHN8z8N3EbHAfA+fgLQsYr8=;
 b=sDR1xfYwetHuKa5YXkaRG5A0lbf/SHPUhGWk080QZ3KXItibFMgM5zjfj5XWNOoo2QivPOpdY6IyIaFvVcclqCPmpbMO62f17uXc0o4j06wPMKAFWdWWsDrarP07rQCU0gjsN/DQe00V5RV+jpdTzrwn6DpzYjWCfNAr3GdMojxYeLKFtGvZdEEvknaCyg8e05WRnc2+f/fY51DpFnt1Xv+UZjfKrGbZ/nt5Ikawizy5q2VvvjdoZD3Fec3iFphEJxfngDIHofW2pILwtzT97QI7SI7Mro1xkpTFBloEfs7fk9YKGc7ImSKpP/EfliQNxZkWJQiAoU2YnAj96TxSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjSpY8CzbYuxR4/VM0jESHN8z8N3EbHAfA+fgLQsYr8=;
 b=IC5bz2qyMlsxaHZRhazCBLRnf7t7vRInn2P91nqCKQNtLgtpZVi+4KDxuSJU1+thRBtt7kgyqTg3fSuCmVjCzKfUHdfUYg4H8Vrnogsw/7eWSMP8j6GIgbtxqMhy8GJeVwojS7d8SZgAFMODSTueVSuBjHQR0/sXRusDHnLf+U0=
Received: from AS9PR06CA0628.eurprd06.prod.outlook.com (2603:10a6:20b:46e::32)
 by AS8PR02MB7141.eurprd02.prod.outlook.com (2603:10a6:20b:2ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Wed, 11 Dec
 2024 14:04:15 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::5d) by AS9PR06CA0628.outlook.office365.com
 (2603:10a6:20b:46e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 14:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 14:04:15 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 15:04:14 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 15:04:14 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 39B0E1A1;
	Wed, 11 Dec 2024 15:04:14 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 35A1318E1EC0; Wed, 11 Dec 2024 15:04:14 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v9 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Wed, 11 Dec 2024 15:04:07 +0100
Message-ID: <20241211140409.1619910-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|AS8PR02MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f9bad8-796b-4008-d9a4-08dd19ecb283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lBAKB+ziL1WMIz9Vm0DBLiuip87twkACNaMohk7wO6/ifsDPWMUGY/ufjSPc?=
 =?us-ascii?Q?fhmRTgkYQX3BHzZkDeHAJhit3X47kNuz3lcuJS9EQJfdVw1t8O0kMHLnvRq9?=
 =?us-ascii?Q?oiufpO2MZjaVduohOPh8Z3M3iZjxjwYc1nfCcwFk4TD7pdz42JwQhvI9Zfj4?=
 =?us-ascii?Q?tJw6cKojuKzFWmzNAA9HVoMEY3Sgqp0Zkxbxxh4/bP2Tf2G+hEEGQW/EdT2G?=
 =?us-ascii?Q?LMLwQAj4ejsHewueumP0xNDBM3mxHVtxxz3hRVUUYEz9TQ7zs7T8tNtjtT52?=
 =?us-ascii?Q?Y19zwTXJZ1rdjbywboL6n3XWZ+LqIaVZORgRru3gkKEAo0shpWrmEGh3qisf?=
 =?us-ascii?Q?ddYSUSXh6IWpoeBqE2X+7YXN6eLms9hGRrokJ9xSrHFsiHIpWoYrrtoEIYM/?=
 =?us-ascii?Q?Gqi9xh25yfYl7okXgItfh/Ch9Vry+36r266DBEoZUlp4k2HM5h7/q2sopoMV?=
 =?us-ascii?Q?fBHxZaNpdr9Ir3xCenu80z5QEgcIe/bFn1VA1iIFvwsZjt103OMzGe7IeLO6?=
 =?us-ascii?Q?EBsOPR1WYbcx6UYsGDkmAhpQoMjOmH5p82+abosmi4rkvJrW4yxOsTaZHhm5?=
 =?us-ascii?Q?7HHsv4pDwIGg/PB6zFWgFGL4NxPkALkiur9I0Kj9fPSZogkU7Yg1a9sgZS+n?=
 =?us-ascii?Q?oYdyJbREEYKg+BzsulbWB2XaJgBqOXhHUC6xYhI0YAY54vUAyxlLDmCtn7O4?=
 =?us-ascii?Q?AD5ekW7uUdTWvoP7SDMng2KLGRjzNAhFRiDGZmqqQaJwYra90xVQYH2ECUsF?=
 =?us-ascii?Q?ak/R+p4RcmJ+ANO2361ojrR5rJt7IN565GmbXIla2jI6wEsT9hknVlRX2ov3?=
 =?us-ascii?Q?yAsk8HBATmm4dbO3l5qbJh+fL//nIBXynG/Yjvuur2MGYe29hnbpFYLXnJ9C?=
 =?us-ascii?Q?MlJ8Y++Vd10By1flTJZ1eMQmEplgCvROvaeBYQ4yiwJ3wJoAbFSMWciJ1+xS?=
 =?us-ascii?Q?eivTejDZu2esrTr4HO6P6llo54PZpj3GtUaEWXyt0GXbGSlwTRDyBs0/lPt2?=
 =?us-ascii?Q?xGUvqWO5VuMSB/sLz9n930DjfitNSt4N7XXK43y2LmusGukfoAcWRQn5cvlD?=
 =?us-ascii?Q?3m6X0TaqFuVuNDO6mYuqZvS3uiZjudViG3+YIqQzrEMCh3XnArBX/Qg0yC+N?=
 =?us-ascii?Q?iUkvvlJNLAs8yXmxRBqvX5my9Ope5teB2P7oYlkXEbUutvK0kcNvnevEbewI?=
 =?us-ascii?Q?QO/XWgWumJHd3yc99xp4UwzNva9N0c0spni9ajyLabdPKmtWdz/ser04zBWs?=
 =?us-ascii?Q?KSz61V4g9X/9ejsZ+Cgk5oryKElnM9LN/fN78p1HlLEZnZKnYwuMhWF1VHs1?=
 =?us-ascii?Q?TkHxuGHs93qWoUNQ2lxzNeVFKMvWtwwtFXz2I/AG8HUQh+PzrMiAy7BPicW5?=
 =?us-ascii?Q?+5W7UsoNEds6rVktAST8namuBcz3nrNRXTGc/DGoRhYJ2y7gzHnGill0AX+k?=
 =?us-ascii?Q?PLIzLqAYqSDiqEy1nxkcCd8lwTzws9x8?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:04:15.4127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f9bad8-796b-4008-d9a4-08dd19ecb283
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7141

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
 drivers/iio/light/opt4060.c                   | 1306 +++++++++++++++++
 7 files changed, 1440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 Documentation/iio/opt4060.rst
 create mode 100644 drivers/iio/light/opt4060.c

--
2.39.5


