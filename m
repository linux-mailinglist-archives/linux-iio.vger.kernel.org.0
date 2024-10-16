Return-Path: <linux-iio+bounces-10666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3649A14DB
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 23:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CEE1C22182
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 21:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281F1D2226;
	Wed, 16 Oct 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="cQaMy5Lu"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9211D221C;
	Wed, 16 Oct 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114513; cv=fail; b=o/9Vqp/J1OG2dUBJNVADyIhdEivBHmquHSKsMUXAn7u1EEDSeyz4F70xa2uIvKojYdjRHMDrsQXefjkBppfd912YlTGYdEJJSLjrDcWhxxYNGBNUbtnS8nNIJt48e02h1LIgd08lXiQBFK/DVJsjbnHZOWh1sb4PDu+lOTftnrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114513; c=relaxed/simple;
	bh=X157ld7E2bHRE7fllLRVD8JYvrqBBoNWU6okcllOP4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BCJrDIkSbJEJkfwRzNzpN8gX+gNRSfKzg9D1izjTu2V5PoR6kxnFGemQLa5MMdJbZvBuXZE+oGyhntTCY7mfj4KUQhRzr171kXBehafirWC3F63lD7veXb2kMzWoo1L36oo8+FgtMab3FXh7a3XIrezuJCp36ZT5qeKGJFfNN3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=cQaMy5Lu; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyHg5F34jRiu7WOSk5zjGVZ4y4TOtSWdN6sPbq1TyRQialtigN/OLwsjN5uuUz75JJHr1nbxVHAAvAzBpHBWbXxHjnypHFpmBQONRaAZMaOvy49RrNDMTVAWN74QKhc413WCy0y6wozfSwTogOVEQWmNVFe0vAC7wEFvvH2l8cNZ5Ykum6Y8a91ZCCVsXVWOU+fLnr9FQ1EYedStO8ip334kG0C1NxkN0R1Z/OL5f6HTKYyd83POTg6PQu49MlSGHdX6J0r7Vv1M0OvW6XXfCGx85OfFRE8/owwxBO4kZE1OigqNP02KH0P3itMMWFVmRBp9qmZkQlgoQI4hM5glrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzVPsWtE9zE4K5fQlayis2M7a4RlfNHAb4oYNzqvLpw=;
 b=HIu+1UV92cMXHSKM2QeiRaHjR4Kvf6SIfUAZgar2Tz1nan0h0rE1+dFHJ3A9mmlzXrdPbjlGwxrK2KaQSCHoMKQcuSaE40OpLpIBbbl1Ai+Jn1b8MketWdNeSIKUxZUDollcq9JAz37qN2KwhPjN9cJ9P+biARtkssuh2nG7a/wOaEdTEAIlldZJdRZm0tAHNE5fs0ycnATUnuCP/NYLFymdRLl+84xssNb/PCJTR+qRA1JKdTUW1vwGwd8DnHpe+4PYVjc7u7I25lNRVERtL6BqPflA5rAxLA8seC4UudeBALQXUtkNtzpzD5OSlk5XesQwPU7OlxnCnDEaT/1+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzVPsWtE9zE4K5fQlayis2M7a4RlfNHAb4oYNzqvLpw=;
 b=cQaMy5Lu2NAAmPpZ6JNdEnOGH+Qvme+D1uVg6kBwzrdY9IThBq6Jz7Pzl7ESv5yu3wt96pqKgjnjm81tSI2VLf4XqMtcgKFXJC+E0z+vzz6us8T7zX81DGTH1RP/NRJb/gHjz5EoIUUVr4+QHlfepTPTVVV+AUrQE6XTM0GPpyI=
Received: from DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) by PAXPR02MB8223.eurprd02.prod.outlook.com
 (2603:10a6:102:242::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 21:35:07 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::63) by DUZPR01CA0220.outlook.office365.com
 (2603:10a6:10:4b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 21:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 21:35:05 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 23:35:03 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Oct 2024 23:35:03 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 954E570;
	Wed, 16 Oct 2024 23:35:03 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 9026E18E1ECB; Wed, 16 Oct 2024 23:35:03 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v4 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Wed, 16 Oct 2024 23:34:07 +0200
Message-ID: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|PAXPR02MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e594f9-5b74-4625-30dd-08dcee2a66a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfgI8L9b3edBrU8ETNaN+wcXceunYl/IF8bU/2W79GVoxU4SKgYZf2m9xVJf?=
 =?us-ascii?Q?aPbTtSleOSjvLmpUsFSIc+vVKDhcgOMNNuH0fbSNvlQcZdtuyjrDczmM2cik?=
 =?us-ascii?Q?hvJVEEM8GwXSU/Jng9wYo29YB7WGigh6a+iWw79bLcRp+8QIAQcPV8yexpZG?=
 =?us-ascii?Q?L8YhWZwxCBUcSGeGXBOncUzC3zZsDF9sMzIPKyNWUqWViLp1JC+KaLjXhHW+?=
 =?us-ascii?Q?tMm5qYfC9ACbz53AKwl+/girlAXM9jiy5lYuogvXa6yUctjiuE0BjKqUBRr7?=
 =?us-ascii?Q?vrDniVm0M6n9sSeeKxfL3lhe5snP1ErhVYRgnXscHkHEISu8OAky0VPVh3AF?=
 =?us-ascii?Q?rtdOhsrV6OsoCQR/5GMhlPUz5O9ZGCWpmftoQ0T3CDgXBLgmzJggQwjylmn8?=
 =?us-ascii?Q?9He5M5Dqky0cLRExi317gfbn92y3hSXfu4182RZYl99YW5speWEuEr4ptTQp?=
 =?us-ascii?Q?h5H1zPddcfn9OCNCiCZxXJ02wpAPt9L6RocIkoH1jFxrrGoC4hoPyYd34842?=
 =?us-ascii?Q?f7jxvj9xNB9Jg3VkRZG7KFDoLRC3kaAldRZhM21c8NqtWclbXQ8b60Ye0Ee/?=
 =?us-ascii?Q?t3LtaVldbz/lUmV8xCtdpFviV5C/daFxhuQDr7GeZVyTqWqTfxdfv+TiaOtl?=
 =?us-ascii?Q?0GgOciahZ31ffZQveJ+x/0agWEJ/BcB/IaQcRWF2gjS2SyFv705Hy2qL98hS?=
 =?us-ascii?Q?/AG9cHb+VYsIfDuyQ9WzLf0WsfjUqSo1mo9yA2MohRBbGsjSldvA1GEejJEb?=
 =?us-ascii?Q?9oUjdNZuHCPEjcixjZbTAcLvtFvSlf2ncTCPUnTRJggHjOJU6rn0iWFXNeTj?=
 =?us-ascii?Q?AZBH9OemM/3vfMVzn4wm2GEa96Qkn3tIClUe402zek36o3LiQJutOtL4rlGM?=
 =?us-ascii?Q?pQZMQLFbye7zfS4EbJ6f5S93Zv80zSNfmEyyw1mSnjZuN2kMyZwJGm23X7d3?=
 =?us-ascii?Q?9n4MLtXt4Ppfx1ZvtdtwRaqIXAgWr1zw+ZCrODC1tsAX13X/wYiH+p7Ks5Uj?=
 =?us-ascii?Q?raVZ8wsjQZ2NMwwXYIjaHrJdBMxSO+TZxANLaZcCh2w3GWwnc3yTh0JaRUEn?=
 =?us-ascii?Q?iM2+rAiz0FTTITFTBc9VjHTAQrb874ReT2hXm6O6nrJE+w3h3dWbpnvaIotA?=
 =?us-ascii?Q?Qrmp8G95cLwxVx1KKDFEbli4e5fCkYKC1s2FdqGHolmx0G5uP/CaiJVRXF/m?=
 =?us-ascii?Q?Uc85kVsqoPsGuOWDmG2MJYv7bxWvxbrSLpNEHScciAavhjvYlLnYSrdlQGmz?=
 =?us-ascii?Q?zZQQ0MsMg1s3zwlvsR9dXmekV/IrL0mv8RkO+rlv338ymtDrt7uxnFCPVpVz?=
 =?us-ascii?Q?09oVMEAhJCWYX1e1iXJb69MvTK/JoMVqMMcG/3Z31Xfz1gqYBOs9Xr9tuAAx?=
 =?us-ascii?Q?vSHVdhhrnswY3wGVjqRG5Aa1nEwvs9jgzv2ZeEUxNbIXmhunSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 21:35:05.7281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e594f9-5b74-4625-30dd-08dcee2a66a5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB8223

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

 .../bindings/iio/light/ti,opt4060.yaml        |   51 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/opt4060.c                   | 1259 +++++++++++++++++
 4 files changed, 1324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 drivers/iio/light/opt4060.c


base-commit: c964ced7726294d40913f2127c3f185a92cb4a41
--
2.39.5


