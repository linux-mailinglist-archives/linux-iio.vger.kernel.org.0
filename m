Return-Path: <linux-iio+bounces-10633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB89A99EFB3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9671F22046
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66A91C07D4;
	Tue, 15 Oct 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rpTJ2N2t"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2074.outbound.protection.outlook.com [40.107.103.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4D1FC7D6;
	Tue, 15 Oct 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003049; cv=fail; b=bBfae/1gjDw4MmM4+EMoauD7YbjJltt7zlzJnyQpx4Oym0RYEFoBy7keldOVwYrrKknMC2IzRKKib4mc9kEmC2x9UCgrPGIv3FePkUtwsF5EeDfGUmwhSKBXC6stFuYl3CTooie2fmjgy2wcZJ1GK4MuT+ao+TO2BlOg0YIs1+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003049; c=relaxed/simple;
	bh=c513S76t2xZtO7orkEqLONELqr7e2Jhozw6d1aV5Flg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jl1LE+mSXZS5ahGi5jq1Pfcxjz8+d4TozwpTvCnZ2sKJuhceAGs2JeqdtOaAow7Vj7A8csi8yLORkVTx0dkHez2hykKzIs2UxB27ujiaOaNFFo4comts+z6GMowg/JcDJ9bhlL90MhqTCjLeuqnOCFJJHB8kPURGv67SY7xw9DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rpTJ2N2t; arc=fail smtp.client-ip=40.107.103.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhchBajFN8LF8ZF9Uai+LzGf2MSPi4KDan5aOg0ouD3H17OwBImO1WGeAQ1EniSDuGAI5ayPnKRbRYbYd5LDy7hu3E2Qgqrh035hZD74AfVbp8+/gAgsCliG1Ggza8BNiBmyoHmXtiTxzGNykc+mlgq/kDiGpShcZ2gBHjA1ryz76Ma7OKgZKYhkx+zNvTlvt8pTAenAxQRYkNqQ/C6iXbsJTMXUNog2czwmdnJZJMqx1mbvQDOu1RzAwcW6cqCtV7I/rnPOGAnNLvOUq49fkVC985snk5r41PBvVzVhRrxP3wliSrc9eCEQ2ueMmF3wJktuXhi1cyZNdY/4UD/Zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1of2NTzEL262vgM+sfWxvgS3fw3t8OAI26dOcdc8WA=;
 b=XEoBQ4meQGd6+H1E3Kg9nynbxNBvS1y3uIFguOfNDMcGoZJrU6TC1McHLqK89xvOev2diPHa9VWMt3cb3wKOH7qORzAiuXU98crlW+gVxzJO4515SqpVlvyMWotvfLU8Pj4cxvx6eCVDBy3Gr3a05Imcy4xP9/QpR6tTN4cCna9/tX+8UzxolQwt2YAT2JTbC7qrz7PCPj9CU7AoDcNDdsEIBVAiQcLmnkvzYUhzPm7Gc0eUD3RVBhXaS2Eya6+in59cF6JkoDn+bR8olometemBillfaNbTRZAHmafgLlkQZfqfXxUK+tPhoMZfFG9HWT5t+9jEvBqf50F2vsPK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1of2NTzEL262vgM+sfWxvgS3fw3t8OAI26dOcdc8WA=;
 b=rpTJ2N2tv0enICNgwQKWjV/jtldmrQYJjuxUVLIfxvrQ/3rXyVO0BMK6Q7mrJJcmNw8J/UHZDBAGHaGlowmh8M5IbG/1N96odC/tcDi6dfrnyVfBCrY4NRfTONNXHQPjQCuaoxzntPSZG7X5B5qdK6yVkK0YIDG5ysfqv+d6enQ=
Received: from DB8PR03CA0036.eurprd03.prod.outlook.com (2603:10a6:10:be::49)
 by AM9PR02MB6690.eurprd02.prod.outlook.com (2603:10a6:20b:2c3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 14:37:18 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::8e) by DB8PR03CA0036.outlook.office365.com
 (2603:10a6:10:be::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 14:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 14:37:18 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:17 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 16:37:17 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 622371C3;
	Tue, 15 Oct 2024 16:37:17 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 5D49418E1ECB; Tue, 15 Oct 2024 16:37:17 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v3 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Tue, 15 Oct 2024 16:37:11 +0200
Message-ID: <20241015143713.2017626-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C2:EE_|AM9PR02MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: de0c5287-ed29-440d-b859-08dced26df22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyWoeooNxeXx9BoWs88cOOKphs8qLwhHILgtm1H4lOsVHBW/EdoUg5eJ+YCO?=
 =?us-ascii?Q?hMiDN/HeZsPZfx7tSZVuta4TWM9wabibuVjvlTbXFhu3+O4jqvy1izkQcLwy?=
 =?us-ascii?Q?vcupKfst24ihspVbrth8nkJszY5sim1cRKKHomUAz11yrwP7ywyTaCiw50iu?=
 =?us-ascii?Q?Ut+b04IUB7qzOnyVFXaWJwduXBTqYbOLy0RFnlElVnLzRODYMqPkFeF3cV03?=
 =?us-ascii?Q?c1K9LvvgRYU37ZWjdNMT+keAQX6ssYd7FaPJmJq3QTfeYQ2gwAyt3dhxINfo?=
 =?us-ascii?Q?t1AiMsWrTDKvCrOlYgOR3Nc+WLQ5TLkejshhJr4ikQ/G2ezNS2CJNW/c877R?=
 =?us-ascii?Q?cjPnS/i9I8gdE4LLmJ8vihuK3QLexk9cntmBRQvBGrE6PV3+NRmfucJuwPn/?=
 =?us-ascii?Q?vEiBGM+2/XE9FGzXd/wHibXgS4L5d17AEncjfpk2q/C35LNhv2cOS/bosl0C?=
 =?us-ascii?Q?jFcv/WbqDmswncakVhiN2CdMrOIL/pTT0Dgk7zPZByTS23u7Mqf5QkEYZooY?=
 =?us-ascii?Q?DgwsUpe/g8o6p5qmTkHYMngDC9LpH0rDnb9snhAB9mBgLCNSuEodUnZEsyk2?=
 =?us-ascii?Q?qWrNp693Bu+VBCYF+lDfD5NEKs+qePEKqvuwACYN160i3z4nIjBEVJreGkZv?=
 =?us-ascii?Q?Ja+MXMqH95TBWgRxcRPFy3D+q/OgDcgIouvzH5Zn8fs8MxZocXtdFsbrz0k4?=
 =?us-ascii?Q?R1MqFAjo5tGUBUb0mgtOVY0SZru4BzuEkj31mVAEvVmxbwsoAWN0vt3HGpB0?=
 =?us-ascii?Q?SJWMndS8my8yp1lapDwxHRz4ZwFmKlA+lP1tft83oDKNC3KpjgnmCSkJUYGx?=
 =?us-ascii?Q?tBsI+jF4Tb2URJl248RDMfbII7m5rv/fPwHMsYz6laDFKDgE47Z7Wzw7u/FS?=
 =?us-ascii?Q?lP10Zr4wETCaKautMIeLhHg73IEs6Ipycf4PRGaqjC871kwoyUiLeyATvadu?=
 =?us-ascii?Q?EsI0pVrUhe2jQffC9soZ/o/ok0lhpbqbs0ujrEksZJTf9Ze5p4ILA4HoOgqf?=
 =?us-ascii?Q?tX4w6PVA5g1nOSq8n1XWvTfJ3QIz8RwKIaRgxwYn2bvxU861gAOdqzA3e9br?=
 =?us-ascii?Q?57HiE4Jk8ulFXjHF4lDLMnH/XNwB5zs0u6LrgQGULAfIEZ1rj9CSBJN1pOTv?=
 =?us-ascii?Q?htDq6td1N0Vu1tBe9QLWwH0/n0WxyPNTLDneSVaTjDoERGW1zXjOnrE4C72x?=
 =?us-ascii?Q?zuNgEC6ozS+TYRAs/zamzv+iWshk+6MJ9JbhNl0B2MDQ+WMAe1v6PAilx4Vd?=
 =?us-ascii?Q?DNtmiKLxBuZEIfPMwM9pm8pMD7FfpYmpHEol38O2krHxOJsUr4cshKR1Stfs?=
 =?us-ascii?Q?/xdUb+6KYvYnZSOzuO6l7T8/79qEAi/+SNuoFWXEA60W0rwU/soHhuxpjidV?=
 =?us-ascii?Q?6rhhmhAbvURyTKjMiFHEyp08W0qY?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 14:37:18.7121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0c5287-ed29-440d-b859-08dced26df22
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6690

This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
using the i2c interface.

The driver exposes both raw adc values and sensor compensated values through
sysfs. Integration time can be configured through sysfs as well. The OPT4060
sensor supports both rising and falling threshold interrupts. These interrupts
are exposed as IIO events. The driver also implements an IIO triggered buffer
with two triggers, one trigger for conversion ready interrupts and one trigger
for threshold interrupts. The typical use case for this is to define a threshold
and listen for the events, and at the same time enable the triggered buffer with
the threshold trigger. Once the application gets the threshold event, the values
from the time of the event will be available in the triggered buffer. This
limits the number of interrupts between sensor and host and also the the usage
of sysfs for reading values after events.

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

 .../bindings/iio/light/ti,opt4060.yaml        |   51 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/opt4060.c                   | 1243 +++++++++++++++++
 4 files changed, 1308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 drivers/iio/light/opt4060.c


base-commit: eca631b8fe808748d7585059c4307005ca5c5820
--
2.39.5


