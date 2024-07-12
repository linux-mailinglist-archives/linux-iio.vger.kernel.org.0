Return-Path: <linux-iio+bounces-7532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD892F9B2
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01F91F21F6A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78381161939;
	Fri, 12 Jul 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NvxPBt4p"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582431411E0;
	Fri, 12 Jul 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720784975; cv=fail; b=gFrzPLs1hoP0/sFjhq97q2IanozvgfWnQJYwFnPihVc/BkjxnIm98YgeuKwc0q3I/xLLFgAd3pVTOJegmlMOo1VSZdUHj+5XSOvy2bPhmXXZzubo3ZA/Fx5HsfKKgh/Mpxrt5/R5SNQhBKL1ciKsUy8cgaPqK9enuqv2P9TCjnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720784975; c=relaxed/simple;
	bh=sIdValDDH2yXBJi3rRXzBUktxlnBaIxT9GL6T07WWyo=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nm+XQN2kUVI8sWGTwaVJ3d6NPd1C0o3cJ0iOpnH4YVqq0PoptzzH0rjLbYe9qmWQpbCehj59FJpkV7ZCzOYBZ4b7nWv/DWpwAGwLxcTv9Unma4o9vLlO2MJ5+wkP2wduOgfTlLuN64IznDIzpcoLqJOYs/uHWlmG75XiZb3MNbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NvxPBt4p; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZSOm5yQ5nUHI2ss3i9IwicTjPtbAHLNv91ceHvO6Ae7dLfsS2gJQ4Mp1iMqpicPFocmG3pdt0AWW8GuxpKDhNIqEpUZKiP30jtZcj/b/MfyMJNHsu3eXIRH18IA8Q0EtUgDTa5fxsqpbq15qa2JlltMK4fZbqOt0CHCRscN/7VnePmVGv8f2ZN1stmUTxibTodsaFR4z464RD6bdeAHfesnMg1otOMlGY2IikWHqk6AOCIeTPH+Eixzw0WExiW8zDM8wAVTPgB8S+OzbulRT2X6Yr4Ouv88UjlRRpyVZin7L8YJWCPE4/5tEXZusUKBf/i+FmQlpm80VRbfkemdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpvbjznTxLZ+DpHkub5e8gFHZM/ZA+67WcC0Z3yHSkE=;
 b=M7qMI/sPWoGHcXiZPzYbjXemnLkxCyAP93VlXVKiXdc3oyBl/siWd5hyYMHWQ5Q7Rzx/P8KXmbYUC8hqbja4ynCMVNNQ6oprBUl0HhQOxpWFspJYtphGFyPKDAuEHpWBJDrahcpTd9TZNMBFTiftR0h0qbP3qcH4MUoVu+tz2IxYKC0+VsHiIhuavN5XUXPuZT2J4R1/I2VyVmY0QD84tNipe6W9U2+xVWRu1BxMGUdLOwcyv+KJLqBFe5j1Hznnr6UFmjIOJUb4lfqjCeIT1Ak6Ncf8p6ybh293y0XMdCHGOG5CTzPGRNMCkochCW8v7xwmToGnSWY2KHF9pA6L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=awinic.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpvbjznTxLZ+DpHkub5e8gFHZM/ZA+67WcC0Z3yHSkE=;
 b=NvxPBt4p25ZYxmIG8NllNnuza4VrjuU3SADQ8RaNdqLWh8B/yvdhJmAGasKOCwe0y54igMVmUbum0X+R/Gcps90vQaoEBeY/UviFlyrwcFdZx4jP7DfP7EBKHaw0eJHQI/tdLSSWQVTFZdaEWhBJAoHuRrNAUE/gnm/mRMoEhKw=
Received: from AS9PR06CA0258.eurprd06.prod.outlook.com (2603:10a6:20b:45f::30)
 by VI1PR02MB6432.eurprd02.prod.outlook.com (2603:10a6:800:197::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 11:49:29 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:45f:cafe::e4) by AS9PR06CA0258.outlook.office365.com
 (2603:10a6:20b:45f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 11:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 11:49:28 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 13:49:28 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: <wangshuaijie@awinic.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liweilei@awinic.com>, <kangjiajun@awinic.com>
Subject: Re: [PATCH V3 0/2] Add support for Awinic SAR sensor
In-Reply-To: <20240712113200.2468249-1-wangshuaijie@awinic.com>
	(wangshuaijie@awinic.com's message of "Fri, 12 Jul 2024 11:31:58 +0000")
References: <20240712113200.2468249-1-wangshuaijie@awinic.com>
Date: Fri, 12 Jul 2024 13:49:28 +0200
Message-ID: <pndbk32vnhz.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|VI1PR02MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4be820-941f-4b75-7a3f-08dca268afb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FyXLmMnXdhvaLfmZFZNW2DkVNoweCkUAK4Q/z3++n3dScJh/bwX6stA5VHYt?=
 =?us-ascii?Q?qnGV/LvG/cXVE+o08GUUu/D4K/FeJza0u2ZrAYO3rRXaCdUlU5uRvU/76w0e?=
 =?us-ascii?Q?IHKyGM/kF8naCaoFxZeZ3klxv98xJt2DhJgLhHLLePWkVOmzIDI5b8mqd9zE?=
 =?us-ascii?Q?hM7HyW1sHvxh6CSqdbaXJHq9URuHgv77lq+OyYg4PNSKSEgS8HqHStWfoiHE?=
 =?us-ascii?Q?DkQRRNVHL67/8xJawvFHghz8KtzoDWZjps1p1MiF5RPpUqcY82YMiDTy+rvv?=
 =?us-ascii?Q?z0zQp09uVOuftrTgntkfFZHM9HuWCsEi6XfE/DS5kOjxLMiG4GzkdN5IR23f?=
 =?us-ascii?Q?hgNNG6ZBrNMi7IKwIq3BXTuN19bq5O8b9ocCQPx5j6U+JzbzIttrS5rLpPtg?=
 =?us-ascii?Q?mSpqDU2HcCOt70C0t/UR6GX1NuVKOSelzQT55IsFkS9PPNvB1LgptA26ztod?=
 =?us-ascii?Q?O+1aef6AH4u0s4tDdrQaOE1HhoMCJK71sUAECHxUnHXiPA4Ja3XcRG0h1zOD?=
 =?us-ascii?Q?6PYG2Z8O95ulq39TS9vXvOnLS3v3hr9gKMSAWA5zaegEKCQBwZbsyRXupLh4?=
 =?us-ascii?Q?wwPHudoxiHIQpEi2QmfvGJSpCI8OI/TyXcMwVf3JO9tlP3Amh+Ya0unq636k?=
 =?us-ascii?Q?VQvOoOXOvZc0RGPci8Z+HNR+O71fFu/Wcjb75KyEDulCTCpkcJcN2vp3kvas?=
 =?us-ascii?Q?svUetd5l0lvZB67H1Qs0tG9O11qs6TwlexVFATaz5dIwVz0psSQtPUu9nI7F?=
 =?us-ascii?Q?RkQzaH6r0WWUJ0gMFPkboEh2tnHk8mV6MeADxWcPLdzLRsRnkneje/7JvkOU?=
 =?us-ascii?Q?Bke8OHUYB6Fxdxtq1k3/7m3QuYDELD24WxAbgklmrIPxOfK882esRfdddr8A?=
 =?us-ascii?Q?kZJ1X1hHx8vKKl81kwY/MmINQRX/1sYFsuQsbWTn4IRL2cBzXj34BYmjEpkU?=
 =?us-ascii?Q?3fg6HIcdWH+GUccH8UGlNXz3LfD/UMFp7tASccEqXAS47BERCCFmF/zdoaLN?=
 =?us-ascii?Q?Q9OOjqrFhudsnjzzjQVXZb04t9H87Q7wbG3tGHyZKsLPBuxM6O3S59WDL2V0?=
 =?us-ascii?Q?knb0yupFwRfoT1uHaSL9649XCzFfqtilT2vMSCv5AlO8SdLjXKx9PCa3LKL6?=
 =?us-ascii?Q?CqSkA9S4LRUyfoQvBkycq9QKyLywmywjXjqv0+14vdbp/JI3j337g65XPGLA?=
 =?us-ascii?Q?CA2xOQAY8x7L9K7QvvSBwsVoEcUXTlK4GyWymI8qofPfTlTYj/y2w1Bc7GC/?=
 =?us-ascii?Q?xfafZPe1Le69qjg9pw5UL592NkQbuNt90PsMrmjrIYJW5qDVpCdpiuGBHAcO?=
 =?us-ascii?Q?ET1J0u0+MCpUct5aIrwsFu2jtDOZ+T1gi7lfiqYKUOPilZt9cJeZLkWFoRaB?=
 =?us-ascii?Q?eqUTFsWizXeT9q5rDVs/NZH97FXRnVF0HvUp7VKxo/QyDb5gbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 11:49:28.7634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4be820-941f-4b75-7a3f-08dca268afb7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6432

On Fri, Jul 12, 2024 at 11:31 +0000 wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
>
> Add drivers that support Awinic SAR (Specific Absorption Rate)
> sensors to the Linux kernel.
>
> The AW9610X series and AW963XX series are high-sensitivity
> capacitive proximity detection sensors.
>
> This device detects human proximity and assists electronic devices
> in reducing SAR to pass SAR related certifications.
>
> The device reduces RF power and reduces harm when detecting human proximity.
> Increase power and improve signal quality when the human body is far away.
>
> This patch implements device initialization, registration,
> I/O operation handling and interrupt handling, and passed basic testing.
>
> shuaijie wang (2):
>   dt-bindings: iio: Add YAML to Awinic proximity sensor
>   Add support for Awinic proximity sensor
>
>  .../iio/proximity/awinic,aw96xxx.yaml         |  127 ++
>  drivers/iio/proximity/Kconfig                 |   10 +
>  drivers/iio/proximity/Makefile                |    2 +
>  drivers/iio/proximity/aw9610x.c               | 1150 ++++++++++
>  drivers/iio/proximity/aw963xx.c               | 1371 ++++++++++++
>  drivers/iio/proximity/aw_sar.c                | 1850 +++++++++++++++++
>  drivers/iio/proximity/aw_sar.h                |   23 +
>  drivers/iio/proximity/aw_sar_comm_interface.c |  550 +++++
>  drivers/iio/proximity/aw_sar_comm_interface.h |  172 ++
>  drivers/iio/proximity/aw_sar_type.h           |  371 ++++
>  10 files changed, 5626 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
>  create mode 100644 drivers/iio/proximity/aw9610x.c
>  create mode 100644 drivers/iio/proximity/aw963xx.c
>  create mode 100644 drivers/iio/proximity/aw_sar.c
>  create mode 100644 drivers/iio/proximity/aw_sar.h
>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.c
>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.h
>  create mode 100644 drivers/iio/proximity/aw_sar_type.h
>
>
> base-commit: 43db1e03c086ed20cc75808d3f45e780ec4ca26e

This is version 3, but I cannot see a description of the incremental
changes between the versions (or links) in this cover letter. It will
therefore make it harder to review...

It also looks like the _actual_ commit messages in the patch series have
some kind of description of the changes from previous versions. That is
also not correct. Please read
https://docs.kernel.org/process/submitting-patches.html#respond-to-review-comments
and
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format


