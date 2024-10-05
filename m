Return-Path: <linux-iio+bounces-10181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F199187A
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED0B2829A6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B5158527;
	Sat,  5 Oct 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GSyYGotU"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE48F70;
	Sat,  5 Oct 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147092; cv=fail; b=kqWDy+knIYRIlGH8AcD0epHmxypzA/mPA4e5PE45uryzmBo/QHhtxLHodeXkas5BZvyYf85FzK94kBgFKVxEOojuDACY0DSARnvK4OlofmO5jl5MJ1BjzBz3dD9i7iyG3BK7tCDaYJSb0eJIklrM2SRK+bE6kZw5A3ptUNMVQJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147092; c=relaxed/simple;
	bh=r+Hdv5xdleF2/1gxYAwehQCX4YsWMAm/wsbdWFZL+qk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXHM9gfbkE6xn1Sp2uhmPq9EjII9uFDXeW2D8xStg9jQaYiDgneXnniq5IK78ckAtuflocDVD0y5LEsu17rDTlpZLH81uLYVch0au7kmIW2LxN7FMJRSWGfo1mccQPZeyzU/aG5sgWS8hGOuZQQHAysP40gdNN1usvlhV+Vo7Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GSyYGotU; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX8St6lgaTzP/3KUuc7tv0HkF+FvFBq6pWvIf/EFaHQ8Sxwj0zm3nQRs4zkN9oOfLIr1SDdPxDddQs1gJ5+zy8o0rtK2yGi1vIOhnqx93ZIu+5Iu4cO3XcvJRzVkohmeZ26RaF5000/NPhmY4iicJL6wmEvTCipUfJeMAND4KaarLy/FP8yCZuliWyvrfjt7vNBrVHtJ9VIXHPLRJfpYB2OaCSIxAeolNbWmE0kL/4Gl4jUs6DSvc1/VHijMN7ol6zTbpfMqBLrqsmPQqnQowbxI1+RgJCaWEFskKKlV4GQeGo082RNmTh0JSmBNJmwQXij9XSRghOrR/LVHPphQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8DK6RFwJuZsrudzcj7VGbm0WGuObUUUre2EUS8iKbM=;
 b=h2J25BjRTVBuq6MlADQWBPwk0VQ0eX6z1qzB5BmhbIk1gvg9zdzoe3obUMRpqf86IkJ+jNPS4e6U9/HTc8w6OdN9W7urnRFbVQUVBQEolXdtWYYMnDct/VpQVW00YuOVHp44z8meFZ7dRLbzyWahEwzA+KVQBB1SXgouW6eOqNshn4PxMXSN+LpICtdZ1JSzh/9V+17RIPGBkTmN5n6XKkktn/vxPJwT8F5nyjXVAqbfWEaQ2HabXYjRou/7lVPpWOMvT1yAn+9v05XJ5xm3TGYXQrFxbsK4jWuH3f2uO8uBRnqQs3WW4yKNbNJdU4qMmRE9My57x6XP8EFPJtnVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8DK6RFwJuZsrudzcj7VGbm0WGuObUUUre2EUS8iKbM=;
 b=GSyYGotUiDRRW/KOkENtkvSWY3l1vjNheYNSRW2nyiavLvVFbappxO5Hgvo8JzZ8vcsiC6uycIZWulWWMMO39ElEODtYaosIPJaQkBBX+PlDV9ReRaHw0ZEijnGvGZoJ1gXoGCxBZbfUmVttn/sh7Zl644DIOjT8cqMEYRpFHYQ=
Received: from DB7PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:10:52::46)
 by PAXPR02MB7279.eurprd02.prod.outlook.com (2603:10a6:102:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Sat, 5 Oct
 2024 16:51:26 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::49) by DB7PR02CA0033.outlook.office365.com
 (2603:10a6:10:52::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Sat, 5 Oct 2024 16:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Sat, 5 Oct 2024 16:51:25 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 5 Oct
 2024 18:51:24 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 5 Oct 2024 18:51:24 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 837BF21B;
	Sat,  5 Oct 2024 18:51:24 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 7F42F18E1EC0; Sat,  5 Oct 2024 18:51:24 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v2 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Sat, 5 Oct 2024 18:51:17 +0200
Message-ID: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|PAXPR02MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: c641df31-a616-49d6-5f70-08dce55df372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VpFR5z0XSQQDtBiwdZ2RGLvBiLEA1MI3dN4HkJNZNvIPPFZWbneumY9n1B7e?=
 =?us-ascii?Q?yKwmyuAnBntnDsak36utc9l/BIrPPlpb83DsfAJJsNGx/iyc14RB9vDhJpa8?=
 =?us-ascii?Q?YYcLqrp7MfSCq1HHtx2Z2SLWUWuqBsUBFAyj6CffVfnsaYqbt3Yww25LrRy6?=
 =?us-ascii?Q?SxsS5VLGhegicvVxj9bXS4xxDvdrY4PYSYW83waCGChVh40EctgC1W5VT1JM?=
 =?us-ascii?Q?WCLGiax2Ipdk0GyaSTemAJpFU/YPrn9xV8YTDlZR1/RTsp0iOrIki9j9vNfH?=
 =?us-ascii?Q?b6nyGpba+1aUeFuSDu5IlRLaXtgXiErMFtAt+cKM1wv8VqgvH75KNAtQhMS/?=
 =?us-ascii?Q?rBx7aEvMyarhUkV6buEnerIcrZcj3sjz/9tUSNVSJbMlpOZM92pEhni5o8MS?=
 =?us-ascii?Q?frIcgI8YrGEkCFB7pi2jkxRceNgk3K2yktXFi9SyzbjJa9rVvVLV/jy3nb7O?=
 =?us-ascii?Q?NEk818hVuWF2dmknSEPAR2yiIM6haWIDu8281wxfeiP5FD9v6LOdfJ2zFDsC?=
 =?us-ascii?Q?U9KtEcFGq1QL2jQDSoySwkaqLtJc3363wN0bN6Yo5IkkCCJJao+sKhRv2Hq3?=
 =?us-ascii?Q?pycjOcck7dumPKo7S40C5xWKVM6X0+aCMLUWgzxSLEHhhMCMaqRQ72HKuJtY?=
 =?us-ascii?Q?9AHzD4Yvho7xIc55iTFw7p1jlAbvVXkGWFlXug9pi4jtDliImEk5RW6RfTS2?=
 =?us-ascii?Q?OmL+NBGlMyFNK9NnNFPik5XYUvpfmupnfmwAOkQRUyaOsQQ9HdB8Al+06vrP?=
 =?us-ascii?Q?2iFiZw9kvNpF7FdJlC+ZOKykyEL841BCWKp46zkkVRDGUFgzs0KqOgerRZZH?=
 =?us-ascii?Q?RpKZDSg92znicR1GFtDONuV5zpDX5DPMQlTUF1ccDC0lhLx84RNFSGE7Dh0A?=
 =?us-ascii?Q?VDbJcGaL1TBDs8ShZEJ5B0g2flvtp+jGrYw/Jsy24C7E5AWmn0JK/Ikiu1Gp?=
 =?us-ascii?Q?QnmiM4fwDyOKuvoz0Robfkvm7NFWbFoFZe5gsE0aUpHKObSTs6CW8jj1PH1/?=
 =?us-ascii?Q?V/TiOgWlZJvku0kR4WAiyuu3/3MH7L5JqjXBVZ5wZOqhKRxw5/2CS/YdrCSs?=
 =?us-ascii?Q?Nkk45bhTjJgJqO7Ece1fc41o/veSoMLlupFwQG1VPWfMcTNkfbS02cxCKcyy?=
 =?us-ascii?Q?/Jm+uy59GAdhBvx/cHIi+hgAsGWVj5/naZY+rFIl/ENAGp5+aYOVTThpFFQV?=
 =?us-ascii?Q?Y1mqgQAq8bDEqyG+q2ZJa13zbZ2Q+smsvivAJ3OqJz5E298rKIy3HcLaSTYf?=
 =?us-ascii?Q?maGUQm42eq3nO8A855DxIHp/TsEVULAz78TbthTw3h8jkj/3AfOH9r+6LNIT?=
 =?us-ascii?Q?NRLuS8twcq3U/zATp9tAnTskRRv1vTGY1uGKMaBzc+BqHPIriyDklFweJoTa?=
 =?us-ascii?Q?MlxRJWD4oaa75GMxLGUoFQsY6Fh1?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 16:51:25.8221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c641df31-a616-49d6-5f70-08dce55df372
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7279

This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
using the i2c interface.

The driver exposes both raw adc values and calculated lux values though sysfs.
Integration time can be configured though sysfs as well. The OPT4060 sensor
supports both rising and falling threshold interrupts. These interrupts are
exposed as IIO events. The driver also implements an IIO triggered buffer with
two triggers, one trigger for conversion ready interrupts and one trigger for
threshold interrupts. The typical use case for this is to define a threshold and
listen for the events, and at the same time enable the triggered buffer with the
threshold trigger. Once the application gets the threshold event, the values
from the time of the event will be available in the triggered buffer. This
limits the number of interrupts between sensor and host and also the the usage
of sysfs for reading values after events.

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
 drivers/iio/light/opt4060.c                   | 1216 +++++++++++++++++
 4 files changed, 1281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 drivers/iio/light/opt4060.c


base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5
-- 
2.39.5


