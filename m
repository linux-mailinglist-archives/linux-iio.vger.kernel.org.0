Return-Path: <linux-iio+bounces-10049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C490C98F475
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDB02820C5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358C1A704D;
	Thu,  3 Oct 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AtDLwU6b"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823C1527B4;
	Thu,  3 Oct 2024 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974186; cv=fail; b=eD1hOfGyxrVemqPFLSn59MTbXI15cHB8EW7M05c/Fr5SazxkDJGYzynfgynoRs16paIJJ9U6Srlv74ai2kEKXIrD3GBuM1RntWKTiCabTWdO3QV5+N7eojvcix7UkCxPCyhYj383o72zC3QvGKag9bkT/6c9xslQDyCX4w1lONs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974186; c=relaxed/simple;
	bh=BAsofhwenL2vjqA4+tN6B14qebZ3O4oqlSUfompa2Y4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMqDkNg3tUFqT12hCEwE7jLQS78AO6IwM4FS210O7I8O9ucot5flKQ6qlMi84IM0wL0d9jdE0q/Ldeuuus+0m9h6qih5RHcRjV0gmrPxNLbBUPY6X6dBEPxdvPPrlHEO1oH/yR4ULJKmTpRKhlsIqwn0vIzUwjFoNQV8Ms33Zes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AtDLwU6b; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv3+HM/F0oyOaJoifjqEOxEScWtqk1LhJibgfCMvBENdMVEqa5euW3jFtGWc3YxbxR88RkpmbMfNVUZ83dj6QPs+q+KlEFJNB43ptavWrABsdubmhGtgd+lUnxjjVTIogTklhoYNZViIxHuasZUTNdxyOqrzQUzgeDXW+mcPy4XqHCIt/2suTGYy+RJon7tBU+5W+JM5LTxHvZv8RVPCD/Fmp7NGQFG1sx4BfBdkoyQBUJcI5I4Wh9nsDPjSxqOldf7ai7VWNgTf/xH3owuKzChsyPVEqKOpFdaY1pOYh9CxTAoL+9/loZnKrQ/QeS7X+v109LpV8GdznkunUKYrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Hcq82+/E7KPsHgaihb/Oqk+DV821ZzN0BETTisnhxc=;
 b=AHOg5PDymenlFL0yd9AH1t+h8DBSKVvlgH3GOXREU64H7hmTnqpZGr/WLdom/YjdoImu4ce5ZvOkMDCsO8zWDRi2tAXw3UYYeJKdddPqjh6XFDVbU5NSFvyrQHByP4ZS0B/lyIUuU6jCdFnCxwWFfitv49Z6tTzlhxBXYgxLJZy+bT7iTisqIR0n+duB16jRNpMqJbxk0Z1F0C4fA+BrF6mV4fg+s2LtGRC3FBTqVHUd5dmlCRlJO0oUXrM+uwmKrRGttZAdqHHeB0dmVpc4+hPVbLpIycjKvGZO3SVknIMI4znQ0WYIJZqr7knqtoYoZu8Efv/X86iaRrohFgvQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Hcq82+/E7KPsHgaihb/Oqk+DV821ZzN0BETTisnhxc=;
 b=AtDLwU6blT5EPEQGrXehNTlIdPrK90Vpwpk7pJx1zKcX13uvVDxSc2x1Z7Z8Uum5ElkiFZQXqGO4TOnukAesD2rsH/sC99HqQrG9KEgSQhdATGBWM+w5IVS5rnf2vM7WmeWpoM7Kupmyk/6XvmIDY9nKatuhTgYdiAiSFIeztks=
Received: from DUZPR01CA0249.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::10) by DB4PR02MB8437.eurprd02.prod.outlook.com
 (2603:10a6:10:37b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:49:39 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::30) by DUZPR01CA0249.outlook.office365.com
 (2603:10a6:10:4b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Thu, 3 Oct 2024 16:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 16:49:39 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:49:38 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 18:49:38 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 9435E23C;
	Thu,  3 Oct 2024 18:49:38 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 8E02618E1EC0; Thu,  3 Oct 2024 18:49:38 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH 0/2] Support for Texas Instruments OPT4060 RGBW Color sensor.
Date: Thu, 3 Oct 2024 18:49:30 +0200
Message-ID: <20241003164932.1162049-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B620:EE_|DB4PR02MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b6f6eb-bff5-4dad-e7dd-08dce3cb5f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UoYc8NEDRw/Sazvo27VUp97LQQuikrrrx/7PccT8h76Y8fKIO6zKbo7lRvZY?=
 =?us-ascii?Q?0G/hTAVfgCmNLwguGSCGyczXBZa69vt29cppYiKclyyKdIDHPqpoMnJuzueT?=
 =?us-ascii?Q?o7URHglGMGOpC7pou/WhY1FUsyCkUKB+LkIt7iezXI6VxqXNGOwIqRRQEuV4?=
 =?us-ascii?Q?0P1ti+9YBMKFxBLVLtnj1O61Pdg0BFrk4etIfm5PdSlKwRxQkk1xe+5XN6oT?=
 =?us-ascii?Q?21+WyyA/t49XfvPtTecs8FH5zITuoVJ1dXlC5Ds3TClrsgaMySbUolm344fd?=
 =?us-ascii?Q?TQVRrkQf4tM/3qcvaOHQ2BC49I1g97MTzdmqUosYB5RB9oq+KSjgLulOlQYh?=
 =?us-ascii?Q?iIwsJRQsSrv8MsDT26Lqun64LpWis65Q84hNp6tmRDX7ehdwyayu5OmuJgMG?=
 =?us-ascii?Q?ho1D9x8vMXywihY/QU7QCxDDuqlmWzqs+3HbwwgBr5gp2qBSAJURmQKiNrTZ?=
 =?us-ascii?Q?CU5vJq40qkfia2ty6BS7EIxOBA7VomtfiiA3em5+LnoaUbbU4Jl6rtoiaYyD?=
 =?us-ascii?Q?brAsqNR9pJX+lNfFYa+LHmdbk7RO7Y0P3trFw6B3SD+50LN9YFwEEXFto0Y1?=
 =?us-ascii?Q?SGo55+01F6VlBE63xJwUhx8dZLeWs+/kzeTUkzDAdOOheOhIjL0uSUVwEd2Z?=
 =?us-ascii?Q?LNsUhIQblmYV2uZYm0+V7zo51vYfFvR5N3y7fHtovd2no9CR1qqNIfDmsiGs?=
 =?us-ascii?Q?A2K2eLqMdyLwAlL80mG7JQJ6L/HtX60rl6t5abQonOwyc2vFlnttHPj/UW1g?=
 =?us-ascii?Q?VbGTSnQkT0iuu9eNlAWWIj+yZT/FxpG+6bJuRkc4Euw25LjfqiyncK5B4PYC?=
 =?us-ascii?Q?J/EN4PWhF4glScYL7lg/g5HgUFXmPzp42Erz+3nIaFlfZTX8yN1OMsjun7UF?=
 =?us-ascii?Q?IxcFZyMDRMcCysl2A0IKMKFvAJQ76NAw4GQlHfNsgk298s+VZjNUxIc7Hb/t?=
 =?us-ascii?Q?/TdXqeLPcpXOB+LDSDIvwYrdaOcBwFO6wVdEsmSjxVVVOqdsHj9vB8zOxNcT?=
 =?us-ascii?Q?WOW1SgqeRXKSbH7/7+7fodkJ0ptP+3VhRTf07EuDvWGZkT6+t2QnaF5hzYdt?=
 =?us-ascii?Q?oymUEb6FgZZpRgt9v3zJjuyFl3AQPKqQTeEodLTW5DILYNOwKy40VR9ftvQv?=
 =?us-ascii?Q?vnWz+iyCUxV9RJLUa+TIdEClWClRt4YWHh71w+3q5QtxTTYQ0Q+EDs3vA+fN?=
 =?us-ascii?Q?O3En6enXW1ekZedJ62DrPrzmAaYFLogi/J/2pv5aZ8z9eX2I52UEcraFxnPd?=
 =?us-ascii?Q?FX4pqWjMI+Oo1piqsZFWdf4xNDVz4QiiVfdewf3O1UTeAvO42U+BN6Hp5rlo?=
 =?us-ascii?Q?u/iO/6dbYWvK+Zct4I/Uflr0pHodCIdpfx6uh024dcJIzFzLQbejk5DpFYMo?=
 =?us-ascii?Q?9y1did/e5JNn+FDBkivzeQGr/5Xj?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:49:39.7916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6f6eb-bff5-4dad-e7dd-08dce3cb5f6b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8437

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

Per-Daniel Olsson (2):
  dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
  iio: light: Add support for TI OPT4060 color sensor

 .../bindings/iio/light/ti,opt4060.yaml        |   65 +
 drivers/iio/light/Kconfig                     |   13 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/opt4060.c                   | 1204 +++++++++++++++++
 4 files changed, 1283 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
 create mode 100644 drivers/iio/light/opt4060.c


base-commit: 7ec462100ef9142344ddbf86f2c3008b97acddbe
--
2.39.5


