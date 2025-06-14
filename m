Return-Path: <linux-iio+bounces-20677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0781ADA02B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 00:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE5018937E3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B776200B9F;
	Sat, 14 Jun 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="UTz2qv+S"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7DB42A87;
	Sat, 14 Jun 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749939004; cv=fail; b=DKUoRjmrhFSXwAYzFXqg5n0VqjKlZB681iv8mnxQQeYNKh/+/rlQe206rptZdQUFPw7PuYpvwmoKqKhB+Itb8a6IK9rEECBZO4rOqfV7hppuP9NLw2v+2MJ0MI6wGuykQayjnNis8wayVaD+PztupU68Nz/ewuyPXglaSTJJVX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749939004; c=relaxed/simple;
	bh=i7Y6TBW6ar2HiwSNnqjh2pTBpAX1NKZBAtAXpXV3YlY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EddaSalZ5wTIp4B0Wv39snG1jqiS1+PypNHyFwpWYLBEW3rFE3WBdqdjROgB2JWU5qtrPkjqwWtcs1CZ+Eiwou+hHV0+g+RaAaaoa5+OgPuLPblXBP4n8VcgDtNdpFW+6UoCMVHkN8eB6W0rK89OeDoVc1hcAQGIapY4zm0MJBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=UTz2qv+S; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDv7dsD7VM5WXRVw6I9ffvwp0evnoBiB3x4dC2683qb6x/rzfToMcnBWZI2iLj61ltf7PtBfRhiKFOm+Ay+KhYWN+SX0T8tC/lIXGY7Je4lw8fAx2SNWhSiB+nVL6W0P4uO9yQMDSGk+FGEHdeRp0owr7kzvL8z7ELul5qEU7Wj8Q5EiICrtFseJOb28W/o0PmMGXh8qDSdpj3rYwNpH7DC5CoNM29upELXS5D2YK2mVW+yP/uWLADaDksuok0egDmdW8BRNmroTrVxEcagrPqs0iAdaljkhXba8Azk+sK/REsCY4TmO9VEl6hQpaXgvaLmwdSt8nEeACRUUO7wjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afvy8nLIFtYrGIRggD6vzIXabrIf+tcR3fj/FLG5LlE=;
 b=HZLO2sundeYf/Lfpb/KYHxUZZ1A5hmqh2Dpd8nTVYtyGjzolxjTVOLTQVw1sK2uCT7MyL4R4V43/EMwr8L2rWb4Y3oIxl3NMF7LC8SmBtcKXygdmPIQtlNv6gkBevFz56bu1h0zM6idinzzZMuTvdMCaPg16p+/yXdJBhiHA7BLw3k0zyp2qZghEYB+gh6o+M5AwHAuS12V1ab5MfuHBAQNuCV5JrixEV9yngW1TpIYR0OrJwiv6cZ0EOQXBKOrWU/ymFwxVvg3P+5c2JIPKN/lx0TWex66l3+gTF5eR6tdzrbJt5W7AhoMJ1QC9WrcIuER0Mabsp4UUVtyrdq3dDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afvy8nLIFtYrGIRggD6vzIXabrIf+tcR3fj/FLG5LlE=;
 b=UTz2qv+SDORzi0t9kRuGqUwuV9iYywMO/y5EC+DV089yzzJoAIpDfCY6WZh3TAI2d6uhYhCrKot3O5XFLgvbAaj9FZyyLhFdYjNYHc+8H5pZpu1uP9icGMsM3zMZN9O5vo0cwY0bs7CEsHvw6m43pt8nIazA1Xr3Vg0Udjm3x5s=
Received: from AM9P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::26)
 by DU5PR02MB10908.eurprd02.prod.outlook.com (2603:10a6:10:51d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Sat, 14 Jun
 2025 22:09:58 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:21f:cafe::ba) by AM9P195CA0021.outlook.office365.com
 (2603:10a6:20b:21f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Sat,
 14 Jun 2025 22:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 22:09:58 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sun, 15 Jun
 2025 00:09:57 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <cover.1749937579.git.waqar.hameed@axis.com> (Waqar Hameed's
	message of "Sat, 14 Jun 2025 23:56:41 +0200")
References: <cover.1749937579.git.waqar.hameed@axis.com>
User-Agent: a.out
Date: Sun, 15 Jun 2025 00:09:57 +0200
Message-ID: <pnd1prmnfey.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004C:EE_|DU5PR02MB10908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c93a2d3-61da-4948-8a19-08ddab9033a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UU48uwc/5zrfGy+o48i3TRTg9MR8qnMi1pQGoL+YKoCsUC5rLZ2iUnW+JjuA?=
 =?us-ascii?Q?oPOzK3DntJwqYnYPDmf1U1TvU1uAV6aI9cLotgK+qUE6P/hUdp1saIyXH9tZ?=
 =?us-ascii?Q?F4x0jFJqAr2M6/T8ENiEMo6OrhKE6cBQWZYojUEwdQxDfnprmwf4C4rfNIxo?=
 =?us-ascii?Q?kocI31NGDcuzIxWOeRIK/zJh8fdHGAaNo5N+OCFsw4Dahbr8fzgRnwbS0Fak?=
 =?us-ascii?Q?PQ9oKhkDPpaQ+rxnh8Im7eyVA0GUvk+J64ZTtX8DjBiFsEv58ivetSBhVqOw?=
 =?us-ascii?Q?Wb4RL2sEBDrr15VpOS1+kh8H/fm0OctwTL4Uje6GN+x6NCjrXnon1HITtptn?=
 =?us-ascii?Q?MpTzATlWBc69CEB2j4P7pWr6Mw0FS18kNFz+A086WOxdytvueTz4NwEmzmDM?=
 =?us-ascii?Q?Ew4DpnAIxi37QrOcehr/J4L3cSMnbgqvTsJdT+PTYgWWPfEwIbI9dnGnX0Bv?=
 =?us-ascii?Q?6JdvLyLEsb4Wt09gUMmmU1se/X6Zpz4z+ZFFhfALlkqRcIA8/tvrG6ib4dG7?=
 =?us-ascii?Q?AMF8ZsjPfs1rSNvVSUXfxSlCfgAhn6QFsNkGGHddmxpqg+Gm/jfwW3ObQxEn?=
 =?us-ascii?Q?RpsbS1sAEisvepH0fdKpierYsl2lc60B2/Dl56d/mK43G3sgdvpWlYQ2vFtq?=
 =?us-ascii?Q?TFZ+QxlHAWCzLEyEGxJGXu5SyqT+yumY/+QVUI4+vXn0pWve0kUrOFQgY3it?=
 =?us-ascii?Q?sZqdmt4KUEvQfa9rPzLcD4Dvuy14Wrfcdiie+03FoV6IEy7lDgIUmnGimc56?=
 =?us-ascii?Q?piyM1X3Rd7cNj7Ex7aNiLZK4y9OG3GzlbcOnT56b9WuWG9HuxgUFDMOExkVA?=
 =?us-ascii?Q?9VX7bF/Wt4Ovmt4iHrJEP+ZF+GCoSwe5UMCfowuZJQWNbpCf9ihElooVe4y4?=
 =?us-ascii?Q?dDHmSJkH06UzbAmD7me9IlP/ggUHgfmVcMYfJGcLa7iaRXW8ClzNZue3Y0jQ?=
 =?us-ascii?Q?ea2COtvUYwFGbnJudlrqtQwKV/Kir1OUL0haQTLZsMAT5wLoocXxP9Ad8bQ+?=
 =?us-ascii?Q?W3YhbEdMbGqaBkGpYIjw1frArOLGeRPVTc6ESrgbK3M7XOLt6dBFn2oPPdqG?=
 =?us-ascii?Q?r5NQnGgcCFoGzIJjYfUizMtjZIlt1Syj6Ju3drcE910XbJRgn4bB8596crw9?=
 =?us-ascii?Q?HTgboie6fa69B445OjHiB/VDNujdOJsx1HV+BcuC0pav7TkykIMwayVlBHI1?=
 =?us-ascii?Q?IpfstheBiFseWpO1LLsBnoNekEx469dBWL6Qz610Blo9DHvSHT8w9fu+oN6c?=
 =?us-ascii?Q?9Rpmkcn5dHMTv2IfUAUUdvY3c4YAI3p7bH5jcVhgeV/S9TOMMNOOtLcCijZm?=
 =?us-ascii?Q?HLKuKUgAaKU2BxCpcO7sehxhNvVDVw6+L/aNE3SjRLbcpj8D3Z0YKmlPIeAV?=
 =?us-ascii?Q?wdzfk3B1leOS1hnE/O4rJ4rrcclllBFcheF1ACiTLXkDsmsVsSv15lWX04tk?=
 =?us-ascii?Q?n1FAVs/XsH105aLZ1+hHyVV2SPRDrHHOthzTXGnbZOZXRQChV2S82Hspn5xV?=
 =?us-ascii?Q?gMriQuGtK6uGNaer3LZUFiJfuMeMJO72hn4S?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 22:09:58.5987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c93a2d3-61da-4948-8a19-08ddab9033a2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10908

On Sat, Jun 14, 2025 at 23:56 +0200 Waqar Hameed <waqar.hameed@axis.com> wrote:

[...]

> Changes in v2:
>
> [dt-bindings]
> * Convert `vdd-gpio` to a `vdd-supply`.
> * Rename `clk-vout-gpio` to `vout-clk-gpios`.
> * Add description for `data-gpios` explaining the rename to a more
>   descriptive name.
> * Drop all references to driver.
> * Remove unused gpio include in examples.
> * Re-phrase commit message to only describe the hardware.
>
> [iio]
> * Add newline after variable definitions inside the for-loop in
>   `d3323aa_set_lp_filter_freq()`.
> * Remove error code in string in `dev_err_probe()`.
> * Remove driver name macro and use it inline instead.
> * Format filter gain arrays into one line.
> * Drop structure comment in `probe()`.
> * Format sentinel value in `of_device_id` with a space.
> * Rename `gpiod_clk_vout` to `gpiod_clkin_detectout`.
> * Request `vout-clk` GPIO to match rename in dt-bindings.
> * Use the regulator framework for supply voltage.
> * Use only one IRQ handler for both reset and detection.
> * Reword comment about Vout/CLK ramp-up behavior (it's because of VDD charging
>   up).
> * Add comment for why we have both `IRQF_TRIGGER_RISING` and
>   `IRQF_TRIGGER_FALLING`.
> * Rename `regmap` to `regbitmap` to not confuse with the `regmap`-framework.
> * Move `d3323aa_setup()` into the set-functions.
> * Use state variables in `d3323aa_data` instead of bitmap and move bitmap
>   handling to read/write settings functions.
> * Pad bitmap with compulsory end pattern in `d3323aa_write_settings()`.
> * Add `d3323aa_set_hp_filter_freq()` and allow userspace to set it.
>
> Link to v1: https://lore.kernel.org/lkml/cover.1746802541.git.waqar.hameed@axis.com/

Sigh, forgot to mark the subject as v2... Resending it...

