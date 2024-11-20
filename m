Return-Path: <linux-iio+bounces-12421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F71C9D4058
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DEEB2804D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12CB147C86;
	Wed, 20 Nov 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="lk1KV26W"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90A749C;
	Wed, 20 Nov 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120378; cv=fail; b=ZVDoZ2hEp4OCM1fopkVphNis1DbMrzce1leeUo3u2JEDa2zdL4VVJ190vRqCje3ZusBfsl/hnIgys/Ha13M0Q+WtR/YYigckoOxWLMN9rkcGV38JqdouLVzDxxRo/3Hx494CCF5FKbwWE1g6cMi5fj/yVjZSR7n8wn+U8g7YtcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120378; c=relaxed/simple;
	bh=H6LpUDBygfkMS9zp2BVnXSmciA9LasDLca5c8ig273w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XnAkCSTzhVCcdduYJxdg5v2elD8DkRVHNRLCMAcIcxBgphvE0ZMMt8nts1O1cCV01m6uewNdeaTZDdv0R0m6m3kEA4sCtGsqusOTaAPCKtLCz2fj6Zd/IgBGUk+7rziKZiWW0+56uyQrT3qyG/QdE1xxk8HEByvgrwpxB8WrQd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=lk1KV26W; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/+MRlZdjPB9cFEolVhq6Bv810MQTvjSfpTbSX+kUt5sbEMtullL4fT7HOaNmN7XOcyMUC2pvV/kOHurRVxcWtPT7tQNsYaMJZiYM1fvvFyMBQEZfRfHCbY1rU3udfkabuWB1vUFqlkK016MO0Hc7QhVSyd9UMTPtZpfkQ1tQYNI3AiTVoH65B9XqEj7SdtdNg0tUCPpvdO2YTRBHcEJvkFg9/ObTC+ypqt8qOeZjPTDal7i9hag7dUX9VLVxVu3gyp/SZWu6JaSECIdKDIHzOUOsjnbQhr7sH60uHueP/5+Kud4pq6uFdCIfam8wsPm99lF/p5HLjRLJsNDTBYm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/LUxddudgeISzy0/DOMEmKHjyTo7AnPg0qCENE8VkI=;
 b=geOooHJFSNbl4WACHlSzYYy7HnshhA5nMxe2o1rBCwgpF9FuOrccQQdoIIH/G7UXzyVzDpjM4Pyqm02AxvcCNms4XNOUkPUejrXHo/xdgecF5HA0MOndpSw023P5UYrNmnLU0cHOJzzjQJP29DhUbMtbcuDmKL8EBRTdWSRFjrwldXz2PMEsYnK7wFSLmziitLiSobDcq7YVjaQk2vPIAZO3ELNaE9nAHgTTKE88SSfhaz20S+lIrEWrS1iPU5203FxIlHMGXaMVv9/+1Ng0BL74t3M4/y/PrSH10uB9fpzz+OragjY8esFhfr+ptg/8/Bc1oiVPEqdgBpx6I5no6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/LUxddudgeISzy0/DOMEmKHjyTo7AnPg0qCENE8VkI=;
 b=lk1KV26WPvLqlA/rIKHOIHTnSZ2s2MHcYzwsFBSPAbHJnZi0XXJMugtfAQaqLJRp5QU4WbxwJ5nYI3a/oFKaGH0YishrUd++B6PUvYKs9oJh1ZeMIPfjxNU8H31NmzcqG8np1qq3aQB/jYUlITwC3eQS+8eLsyF/eXFxYuEB1mw=
Received: from AM0PR05CA0075.eurprd05.prod.outlook.com (2603:10a6:208:136::15)
 by DB4PR02MB8631.eurprd02.prod.outlook.com (2603:10a6:10:384::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 16:32:52 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:208:136:cafe::73) by AM0PR05CA0075.outlook.office365.com
 (2603:10a6:208:136::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 16:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 16:32:52 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 17:32:51 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Nov 2024 17:32:51 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 5A5A53BB;
	Wed, 20 Nov 2024 17:32:51 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 5655018E1ECB; Wed, 20 Nov 2024 17:32:51 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v6 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Wed, 20 Nov 2024 17:32:45 +0100
Message-ID: <20241120163247.2791600-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|DB4PR02MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: a63e5519-e4aa-4629-53e6-08dd0980fab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/5J//mvhdwnqe1Q26oEe3NnGjqxW9uWw/MhU3lfKEFhcZJH1AMNVwDmcy1q8?=
 =?us-ascii?Q?TE2H9S/rZrQ/KPYHIY8Z8cx18pNWf9zKYn3PGQ4EViRRFxV9+CX5cnlJOIyC?=
 =?us-ascii?Q?u+V40FKbscF82BTZJ2TZ0LsigNBFh9Mm6GHg+2vizsVXlQi8A5c9bpTwLEiX?=
 =?us-ascii?Q?OUXwmRm+m6cpJXuHCxtdeA8+9Ce99gzIqn3O+ki7h/sfox9WTRhUxgzFI0Wd?=
 =?us-ascii?Q?XQshoU1QY7fBy2ygiqD7F0hgA0N4H67VINMtU3CeyWBT8hEKlClY77TAvcEh?=
 =?us-ascii?Q?U26Ug2P+QA5o5cOmppZqtexNl0wcHtnCqt5cqtMFH2msZ4sTtgpROQotYC2F?=
 =?us-ascii?Q?bRic7YvidfIPwmPlfELf1S0wc+pRIplguFnE6cZRjfkFbX2swdCo4/du78Q0?=
 =?us-ascii?Q?jKePswhQutFyNkaPQUU6jI3iRtI8Iy/AKmhI1wtuJiXHdDEEcL7K9LL+9sFB?=
 =?us-ascii?Q?fwIV9EAle0xSnqHiBfOGVxB0DsthuBZrxottXUSpvQTj5YPKkfYTLVGMj9+9?=
 =?us-ascii?Q?fODow9vIrDYtcGikiM6A0XsTIWOKMSbGP1UvE2aQRDSsXl+rYm8TXqNQqDg/?=
 =?us-ascii?Q?w09gJuHs661lWXmHweTjS9cM6+5SxW29i83UDvwcC/GoBfGcbbngtDFijSqi?=
 =?us-ascii?Q?fANd0aojaLr2wNRfWm6p7BxN9i5wPs3Z8mg70CrpbUG7OtDE3lZ0NCobjp0K?=
 =?us-ascii?Q?OhXr9m+mxwC1U3vwdNPGGiiuG2YzjvaGTULo0gnkvlPatC+vJ9wdaIvCVO1g?=
 =?us-ascii?Q?BZmAiWFmjv/2PgKuUsamsVoC8cwCrhOk7h/ZbrDswXhornUW+xSKmIduj4aM?=
 =?us-ascii?Q?f76ObkknK2tFN/qSXFEZoxziJ3ZjB7QN+dKTdlO5EeCNfTiPxu486cbFpZ09?=
 =?us-ascii?Q?NvzjNlrEk0shoo6gM4zPQ0YvQDuvKl8Rf7O7HDpm6BhuE2+PDUxZ+LwHSorg?=
 =?us-ascii?Q?2pH1q8wU4QtK2G6X49Q0bFrEuJuXAOngeFDrTahOa2k2aRp1ErqCRFk6vCLa?=
 =?us-ascii?Q?sHLEEUW2/mi8qeDrvu/nemMC/EA1HM1Cb8AqvherVMvQwvkLYnNv44my8RvQ?=
 =?us-ascii?Q?9g3K983Rx0HmOYfZwbymgJdaTTAs8rsi7jjY2+21Frxrnrc8ySV3NHR1KPVB?=
 =?us-ascii?Q?HmmTr0Y7IEfcz9oEIgRNe572//XemRq+RrqjdC5R7vEajboMfpv8oKIm1Imx?=
 =?us-ascii?Q?lZMxpwKdvRLk0e6kjzvgNfigXzLTtUeYMsVR9ycyIdSvf9CK86MXkFfRv/S0?=
 =?us-ascii?Q?WsMs1Mf87fyXaGFF0zUw9tVKQ67PhifiBOQ4dwy9o94CLssq6cFIWL6a075V?=
 =?us-ascii?Q?z3if94TbFZq++C3wlc0QqhyrQSaWI2jfIX6i/+sJ+nkrNyXvcZmWzamftaTB?=
 =?us-ascii?Q?6TL1hco=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:32:52.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a63e5519-e4aa-4629-53e6-08dd0980fab5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8631

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

 Documentation/ABI/testing/sysfs-bus-iio       |    4 +
 .../bindings/iio/light/ti,opt4060.yaml        |   51 +
 Documentation/iio/index.rst                   |    1 +
 Documentation/iio/opt4060.rst                 |   52 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/opt4060.c                   | 1295 +++++++++++++++++
 7 files changed, 1417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 Documentation/iio/opt4060.rst
 create mode 100644 drivers/iio/light/opt4060.c

--
2.39.5


