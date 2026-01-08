Return-Path: <linux-iio+bounces-27562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A1D048E0
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6AD30BD6A4
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFDC2DB785;
	Thu,  8 Jan 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RaefIwf/"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257402D3231;
	Thu,  8 Jan 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890498; cv=fail; b=oe7BppXO+Nsz5ZRvFjyMNL171M+iQDu9c06d+0JPAmLDsLmTF9TVi+gFsNw9YvuqoldNv8VpCtE7DqDwkIAKqTUIAn6S10Pzes/stoff3QgwCsCdweUvEX8Oabkyl8yoe3NhYP76QeLYED3awspmqvb/QTPAebwpioWe7OfSwm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890498; c=relaxed/simple;
	bh=nBQjjDBi54G6CSeCVOU67YT6ykhzjHRhtJXMG3taNxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PWRF5VwdWY0uGHJLXtbqxuF8CxRbUjtVbI0i43vBFh+/7nhjfHKxlfK9HIc8/5Pe7ck227Rikx7cupN3FP9MxRgafrIphDyCSK623V6nFzWuPwoFLHOsIoJ/zw9u/9radfEef3EQP3gtFcQnM64SL1ltGjO0t0t88ySjRGNqSMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RaefIwf/; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+KvefBuCOqhl0uxYuxdm4jVinAeesbYI4F+AJEa6YXUjJMwuL33isrTVf+eCMh4tg6IyrgYNLCIczLvbp4pxUo02iTXdy+TT/gZl+7cvbXUAwMTmBppDrPLeepgmvXLZt3B5Ao3ZhLkws4UejTSBJe/j/U4ylRtrK/K0YgrLQ/8z3LHr5D77e6IofZZftnl/FQVMvx8azICDQHLAQ+gCnPBBSkgIbj/6C6lJPMM59djCPVLtw+5h2GXVQGo+oIbgmJnPlJFWeUgOXJUAwme5XLZuSo03Mxc8QpUayhs4xjkPr+ZG8qnYeSgXQX5pH9JiOHSkVrRUo/W6XwNtmLgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sRzl8KtQbRDalcktMRTCAiLGHuWKX2pU4wDOybYGD8=;
 b=tXHMvEm86OO2GSwdZiaa7rdgKgV6S1ok4dUhHUUNz7tjKaT+4Rixl86MldpS5l32xR57KQeYq9pq/caQ3Bk/OjYN5JGEzQEaccamrN7tiV52Uasyy95267I1hkREXgG2vQUOhUYSdjGPFBDYKAmAZnmTjIbSE+YekrLS8SBKXaYiipLw4dzisv6Ln50AYenehiml7ZBhAZmsf55szlfLQ+lsduTVxOhrKSBBI2viHrt906qVfmrjqdgeEQ3bC5u+WQ7VUDpdGxSIaJ1a7dS/ZQiVbJKvOTB2ubAq1562lvUZo0Or6/j3li33JggYENO44R80040khIAsXvgRhTVfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sRzl8KtQbRDalcktMRTCAiLGHuWKX2pU4wDOybYGD8=;
 b=RaefIwf/0zd2iPCCDAEHR4OIp6pLpZP8d+6C0HW9nPLoGLpMi3CcTg4xNooo2EKBBia6dCI5yG9B1pXUWUHepe4EYsWsXjH22dF6h8C/knAoeOGotyHw6km5TCVph9UVetlF0ScpmCtxTC+0H/yWl2BJ+Ak/GC/FT2EagzZe6lJ5pnJh/+M5FaPCHbI9wIGvmXWo4Fv61UqNuKJ62iDnzb1SFzDYI7A1lTC8o9n9NNKBm8/mYAx6w8MPL65oOzXWDLhNkPxQFw55rOu2UzBxN4Jj1q4g7s1jgtBEEljSbC6XzBdNtHcYuOGe/tSftCQ+4q1YK3FdweyTKr8D52iSyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by AM8PR04MB7204.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 16:41:33 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:41:33 +0000
Date: Thu, 8 Jan 2026 11:41:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: wbg@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, s32@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/3] counter: Add STM based counter
Message-ID: <aV/eLFO57v567Fwa@lizhi-Precision-Tower-5810>
References: <20260107133953.2094015-1-daniel.lezcano@linaro.org>
 <20260107133953.2094015-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107133953.2094015-4-daniel.lezcano@linaro.org>
X-ClientProxiedBy: BYAPR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::35) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|AM8PR04MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0b7c8a-0458-4e47-5e1b-08de4ed4c289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mIkKwlvkGBQfEzpp0p5HowLD1xIML5twICsTRywSgPTk1BTEeNVbVrdxLtTJ?=
 =?us-ascii?Q?H180NINf+ltmQmkiPGvuMTLUd9PZlIXT1671TpG9axraShOmvVGbS4XrIM5W?=
 =?us-ascii?Q?VNU6DmofvxB0O0pjeLrXwyQWCH4X3WZ0e1RLGiu7WH30/xzJHnNsn+HacfFl?=
 =?us-ascii?Q?6tG+Dp39dMgkfGxnKIH/KM6E9pWH5FHDWtVvNNH39tJELdwzlw1iyblLmzH9?=
 =?us-ascii?Q?TxwWvTIXbzAwH838kt6hR7jA5Sb/FaPlTbFi+HCZk8C3KJipb2wwGZUytkHs?=
 =?us-ascii?Q?GB3hyGCfBIowS/WqZtnR69OKJDrs8uYS4qVBuKIxJWn99g4Wh73cr2NP7RZD?=
 =?us-ascii?Q?5xxrugwzlxMvBxa33cc5hocVqymlX8cQrJPkbQ+1vYDEYoMGdbJGq9Oj6HnS?=
 =?us-ascii?Q?7+CJ2E+yHjSz/KhouDNdt2FAADA5yQEdincLTGjaApJ2o2u3rZFDZbBskBWJ?=
 =?us-ascii?Q?oVwnQ6t0lprL3Utxxv9bX2gMsj9THWD9Ofk3Ar6Vyh3QwJDRdqSbLrj3qHVD?=
 =?us-ascii?Q?Tldtywr0Tr87Fotl23dXvnwJSrvjy/NcBvyOl/porZtw+bj/drhe/5JKzllg?=
 =?us-ascii?Q?nuO2PxD+/M4QjuLC/1szuHLqCs2vl8XxWykYtx5Jbzfc+zxHe+1SA3SzQSXZ?=
 =?us-ascii?Q?aEPsqxij9MVQcZBevqDeVGL9A06rMKD2FdNUWIsc6vgkWadLv7CV7sHzyuXy?=
 =?us-ascii?Q?pSGnteMHi5RnnE5P0Fyc8QQaAzRDfDJYQnHI8MVPmNSifgaHVKX2FnrT4Acv?=
 =?us-ascii?Q?eq4YnEg7Lj4ggpIZCHN7lxAqz7mP8E3oZiOYKgZqxZcDLzHda2nZGmp+CgsM?=
 =?us-ascii?Q?JXdKvntI3c82lqtMvl+/6vx80RQnCpiUwIL2Bz1hFFowcvKRoOSrbFQc2Ncq?=
 =?us-ascii?Q?L8+hM9QxWUN3prRhhNHG9l8BgAKXkKwpyGCqXQCmlv+28znIMe0ssBPBLXKL?=
 =?us-ascii?Q?Rjf8sED24CPhULF4V+IZNU4p/8qiNHIROAImCq2NvD4aAIEB2a1puZXOtCTM?=
 =?us-ascii?Q?YmHwGLQ5vvLDgA+hATjAuHi7XoZyNrseRZ/b7eFwbvH2ja9j1OtSIR7U2kxN?=
 =?us-ascii?Q?dz9om+qPc+LUccpBbUglN5fMwQXzO8roQ+9HVwIbuQOHkP/w6si4K/VZy5wZ?=
 =?us-ascii?Q?kK0faxAmYTQouAYVy1NkA1rMJf2xUuT71Gtn/CTCoZiyvMRvh18E6puVbFD8?=
 =?us-ascii?Q?0pPu3yYKcHLKgLO7wYoVll4wSp+QDKkb85JfMbS3Kpp0GCBIuTnHt3eQgRqn?=
 =?us-ascii?Q?P+k/lhghWVnh3aqFanaYlklSlE2DGi/2mQfdNCFqHb9jP6KCqYvPpMriSFF1?=
 =?us-ascii?Q?6ccSiP5J9nJhKf0wwBTjc2oevEgz9g/EVt8mRTj8iizUf+TVQ5xaw4PbmqXu?=
 =?us-ascii?Q?qMCfPVvpdUXXm5vqRYKABBvD3J1nJ0A3eLOBMD3TqDIYwboBobI8lgj9+i/w?=
 =?us-ascii?Q?aIl2DK8shlA+Ok4S/O8cJHkIylpDzJZdR6JSkm/+HqEVlLc32bjGrjYIhfa2?=
 =?us-ascii?Q?LUkbtMyRJgVW/QFH+imGBW6zjF9Yy7raF1CG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/5PMGR+XAcfpmvj8o6uDltxJQ+jbV2r77UhdKbWimcs/TKCGv6gL4VbxzGO?=
 =?us-ascii?Q?prWiANCz5rJYgcDt8+/ZjIxV8QY3kPTqm0+VZXw44TH/2wShlez5cYUVC+hT?=
 =?us-ascii?Q?LtPVBs2bUc0hPj5vU8HEoJPQuPa7/xp5UsA/cGKQgbW8mn0O+838YUxNgKK7?=
 =?us-ascii?Q?+SgrhdsZndQN4LPBq5WQl6+E+i+IqWxmaRCbAr2BUea91GMIktcqVT0mzxga?=
 =?us-ascii?Q?oRxX0nvw4fqlxQ/thcLPCdz6SM53GuQGon7EpgbXBWQGKkDi7MlL+aBAvAkB?=
 =?us-ascii?Q?vwuUAq3opOLn7Tw5zAtPvfjjJABBxUNh1unkRPFf5R+hfTbpq2ybKG6yF1M/?=
 =?us-ascii?Q?FfCwOMmmWzU5hf7NsqIQDhqsNQ6AK3hb+NPN5v99c1d1Uf6pnS5VCcYdHLb0?=
 =?us-ascii?Q?CA7sC165xHA9eT8YwQzYkKKtbvOUHUJrQQVcV515ETZSG26pMWrYgntUBgNj?=
 =?us-ascii?Q?b20eJ9/bXfBrs3oBobSLp1+cww4/HmtfElS+XXQZ804tl55uBPrGu7EZH0Tc?=
 =?us-ascii?Q?nBytunUtP8/hSIA2nJzhZIP37HYS9nye20x8wZICJncbEREC67nlseqZ09oG?=
 =?us-ascii?Q?Yz0DavBvOrzTNCOhCH3KqaFBUv2/83Y/dmpecxQpXuzFTf7zm6X6niaFDQk7?=
 =?us-ascii?Q?6svDItj4setnmwKc665sfRKYhzPUC9+xGUSGRmYCDjT4blTyB2q/Qh4tefKw?=
 =?us-ascii?Q?0Ry+wWSU3Md42bNwoI6wc9ypVKu6YdEWpNIxubK6qjSeBulLt/XCpSDYuvas?=
 =?us-ascii?Q?wpr/s4ftJPF3ArGaARCNRyLyXrXr7c9Nu7gBaRvxJJK3PmVqgX2eLjT1ze2n?=
 =?us-ascii?Q?a5xGYZnw+gFeMv0eEgGCbf3AO2GzmPGzYK++F1hniV4at9Fxlon46nQn/IRv?=
 =?us-ascii?Q?YHNEYLZnYpdYFKGbCGjE0lqRSdPGl6HnXZlP/ki9TTdGiWg1KVXnVeubKzLe?=
 =?us-ascii?Q?KFK+a45Je09xGZvDJBSnLkmVPVF1WAAEvdLPUgWrl1jZT+0IF6371sNXD6Jv?=
 =?us-ascii?Q?ssdqa1GBs5D1El5Wdd5pAxrpJm1x/nDO8/9S5YhUpY5AjgYO0o0yYSdmlh7d?=
 =?us-ascii?Q?RgGbCsGmtIRyotBadNTPCVW1NKHXH5IxvULt6Aa8TDUtLLLFgOByDK+lX5sE?=
 =?us-ascii?Q?6/hbz4qpDzM0DjMXMO5AfA+9j9zO/QAGic4ILPaGZbCG5J3T5aXDYiCROY/t?=
 =?us-ascii?Q?So4+yeRFaVfrnbqmje9m8ZIS+K8lW9t4pbVWdD4ie1y2FeZx2G6hYwDQ57NH?=
 =?us-ascii?Q?WE3UWulKDjq1Ct/MgnEJXOHnnAc8WDZ87Nd7g4WjB2syhRlN17V37vofrhYm?=
 =?us-ascii?Q?PEwItZD8+Qcv5f1UljbBpIlhx9EJwRYtOJcc4u34ohKxWmLMhcA0jLYxhy42?=
 =?us-ascii?Q?zhS6vRiSRDhkz4YkqRM9LY8gaLwetquKSMg52XDfvaeUU8wPpm7KKbjFeOwH?=
 =?us-ascii?Q?3BhBJAOV8t2dUO/0N/QjdeAXvGZVh/KTdy9xIc7o3Pz/AJs4ZJoN9lAIWWpH?=
 =?us-ascii?Q?zv9UFqpo2s23nntg2vK8xs5t580pyfuEaOA8NUwGZ2IwbOPeurh8y8hMmoG6?=
 =?us-ascii?Q?3M+edSQBRrhahfBINqIftQab8cf5Qi3qwn7UgVklxdo5EFExCwrfCQCqDZql?=
 =?us-ascii?Q?Az5bxlsD6YAr/mPMXyt3A5ssGNFeOEMTaHHjzJHwMN21Pery7z6oeNrw/GtR?=
 =?us-ascii?Q?zicD5F8Xk7CT8tT35h2bJBTH+PSN7yEQAj3jJObGtD9Z4p/p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0b7c8a-0458-4e47-5e1b-08de4ed4c289
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:41:33.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbP1Q9GDsnwVy9YkddjZZcyrrFkIdx+5iE5Q0cCiFV3l9XRXe2YaW+zSOuCjVTJ4FQAN84b2mtzoYVELdNF5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7204

On Wed, Jan 07, 2026 at 02:39:52PM +0100, Daniel Lezcano wrote:
> The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
> three Cortex-M7 cores, along with a large number of timers and
> counters. These hardware blocks can be used as clocksources or
> clockevents, or as timestamp counters shared across the various
> subsystems running alongside the Linux kernel, such as firmware
> components. Their actual usage depends on the overall platform
> software design.
>
> In a Linux-based system, the kernel controls the counter, which is a
> read-only shared resource for the other subsystems. One of its primary
> purposes is to act as a common timestamp source for messages or
> traces, allowing correlation of events occurring in different
> operating system contexts.
>
> These changes introduce a basic counter driver that can start, stop,
> and reset the counter. It also handles overflow accounting and
> configures the prescaler value.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/counter/Kconfig       |  10 +
>  drivers/counter/Makefile      |   1 +
>  drivers/counter/nxp-stm-cnt.c | 433 ++++++++++++++++++++++++++++++++++
>  3 files changed, 444 insertions(+)
>  create mode 100644 drivers/counter/nxp-stm-cnt.c
>
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index d30d22dfe577..bf5b281f194c 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -90,6 +90,16 @@ config MICROCHIP_TCB_CAPTURE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called microchip-tcb-capture.
>
> +config NXP_STM_CNT
> +	tristate "NXP System Timer Module Counter driver"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	help
> +	  Select this option to enable the NXP System Timer Module
> +	  Counter driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called nxp_stm_cnt.
> +
>  config RZ_MTU3_CNT
>  	tristate "Renesas RZ/G2L MTU3a counter driver"
>  	depends on RZ_MTU3
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 40e644948e7a..196b3c216875 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_I8254)			+= i8254.o
>  obj-$(CONFIG_INTEL_QEP)			+= intel-qep.o
>  obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
>  obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
> +obj-$(CONFIG_NXP_STM_CNT)		+= nxp-stm-cnt.o
>  obj-$(CONFIG_RZ_MTU3_CNT)		+= rz-mtu3-cnt.o
>  obj-$(CONFIG_STM32_TIMER_CNT)		+= stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)		+= stm32-lptimer-cnt.o
> diff --git a/drivers/counter/nxp-stm-cnt.c b/drivers/counter/nxp-stm-cnt.c
> new file mode 100644
> index 000000000000..9f2edd2161c8
> --- /dev/null
> +++ b/drivers/counter/nxp-stm-cnt.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018,2021-2025 NXP
> + * Copyright 2025 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * NXP S32G System Timer Module counters:
> + *
> + *  STM supports commonly required system and application software
> + *  timing functions. STM includes a 32-bit count-up timer and four
> + *  32-bit compare channels with a separate interrupt source for each
> + *  channel. The timer is driven by the STM module clock divided by an
> + *  8-bit prescale value (1 to 256). It has ability to stop the timer
> + *  in Debug mode
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/counter.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define STM_CR(__base)		(__base)
> +#define STM_CR_TEN		BIT(0)
> +#define STM_CR_FRZ		BIT(1)
> +#define STM_CR_CPS_MASK         GENMASK(15, 8)
> +
> +#define STM_CCR0(__base)	((__base) + 0x10)
> +#define STM_CCR_CEN		BIT(0)
> +
> +#define STM_CIR0(__base)	((__base) + 0x14)
> +#define STM_CIR_CIF		BIT(0)
> +
> +#define STM_CMP0(__base)	((__base) + 0x18)
> +
> +#define STM_CNT(__base)		((__base) + 0x04)
> +
> +#define STM_ENABLE_MASK	(STM_CR_FRZ | STM_CR_TEN)
> +
> +struct nxp_stm_context {
> +	u32 counter;
> +	u8 prescaler;
> +	bool is_started;
> +};
> +
> +struct nxp_stm_cnt {
> +	spinlock_t lock; /* Protects counter */
> +	void __iomem *base;
> +	u64 counter;
> +	struct nxp_stm_context context;
> +};
> +
> +static void nxp_stm_cnt_enable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	reg |= STM_ENABLE_MASK;
> +
> +	writel(reg, STM_CR(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_disable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	reg &= ~STM_ENABLE_MASK;
> +
> +	writel(reg, STM_CR(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_ccr_disable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	writel(0, STM_CCR0(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_ccr_enable(struct nxp_stm_cnt *stm_cnt)
> +{
> +	writel(STM_CCR_CEN, STM_CCR0(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_cfg_overflow(struct nxp_stm_cnt *stm_cnt)
> +{
> +	/*
> +	 * The STM does not have a dedicated interrupt when the
> +	 * counter wraps. We need to use the comparator to check if it
> +	 * wrapped or not.
> +	 */
> +	writel(0, STM_CMP0(stm_cnt->base));
> +}
> +
> +static u32 nxp_stm_cnt_get_counter(struct nxp_stm_cnt *stm_cnt)
> +{
> +	return readl(STM_CNT(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_set_counter(struct nxp_stm_cnt *stm_cnt, u32 counter)
> +{
> +	writel(counter, STM_CNT(stm_cnt->base));
> +}
> +
> +static void nxp_stm_cnt_set_prescaler(struct nxp_stm_cnt *stm_cnt, u8 prescaler)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	FIELD_MODIFY(STM_CR_CPS_MASK, &reg, prescaler);
> +
> +	writel(reg, STM_CR(stm_cnt->base));
> +}
> +
> +static u8 nxp_stm_cnt_get_prescaler(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg = readl(STM_CR(stm_cnt->base));
> +
> +	return FIELD_GET(STM_CR_CPS_MASK, reg);
> +}
> +
> +static bool nxp_stm_cnt_is_started(struct nxp_stm_cnt *stm_cnt)
> +{
> +	u32 reg;
> +
> +	reg = readl(STM_CR(stm_cnt->base));
> +
> +	return !!FIELD_GET(STM_CR_TEN, reg);
> +}
> +
> +static void nxp_stm_cnt_irq_ack(struct nxp_stm_cnt *stm_cnt)
> +{
> +	writel(STM_CIR_CIF, STM_CIR0(stm_cnt->base));
> +}
> +
> +static irqreturn_t nxp_stm_cnt_irq(int irq, void *dev_id)
> +{
> +	struct counter_device *counter = dev_id;
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	nxp_stm_cnt_irq_ack(stm_cnt);
> +
> +	counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
> +
> +	spin_lock(&stm_cnt->lock);
> +	stm_cnt->counter += U32_MAX;
> +	spin_unlock(&stm_cnt->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void nxp_stm_cnt_start(struct nxp_stm_cnt *stm_cnt)
> +{
> +	nxp_stm_cnt_cfg_overflow(stm_cnt);
> +	nxp_stm_cnt_enable(stm_cnt);
> +	nxp_stm_cnt_ccr_enable(stm_cnt);
> +}
> +
> +static void nxp_stm_cnt_stop(struct nxp_stm_cnt *stm_cnt)
> +{
> +	nxp_stm_cnt_disable(stm_cnt);
> +	nxp_stm_cnt_irq_ack(stm_cnt);
> +	nxp_stm_cnt_ccr_disable(stm_cnt);
> +}
> +
> +static int nxp_stm_cnt_prescaler_read(struct counter_device *counter,
> +				      struct counter_count *count, u8 *val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	*val = nxp_stm_cnt_get_prescaler(stm_cnt);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_prescaler_write(struct counter_device *counter,
> +				       struct counter_count *count, u8 val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	nxp_stm_cnt_set_prescaler(stm_cnt, val);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_enable_write(struct counter_device *counter,
> +					  struct counter_count *count, u8 enable)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	if (enable)
> +		nxp_stm_cnt_start(stm_cnt);
> +	else
> +		nxp_stm_cnt_stop(stm_cnt);
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_enable_read(struct counter_device *counter,
> +					 struct counter_count *count, u8 *enable)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
> +
> +	*enable = nxp_stm_cnt_is_started(stm_cnt);
> +
> +	return 0;
> +}
> +
> +static struct counter_comp stm_cnt_count_ext[] = {
> +	COUNTER_COMP_COUNT_U8("prescaler", nxp_stm_cnt_prescaler_read, nxp_stm_cnt_prescaler_write),
> +	COUNTER_COMP_ENABLE(nxp_stm_cnt_count_enable_read, nxp_stm_cnt_count_enable_write),
> +};
> +
> +static int nxp_stm_cnt_action_read(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   struct counter_synapse *synapse,
> +				   enum counter_synapse_action *action)
> +{
> +	*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_read(struct counter_device *dev,
> +				  struct counter_count *count, u64 *val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&stm_cnt->lock, irqflags);
> +	*val = stm_cnt->counter + nxp_stm_cnt_get_counter(stm_cnt);
> +	spin_unlock_irqrestore(&stm_cnt->lock, irqflags);

It think there are still rise condition here.

cpu 0                                            cpu 1
1:  nxp_stm_cnt_get_counter(stm_cnt); (0)
2: 						 irq_handle()
					         counter += INT_MAX;
3:

when wrap happen, nxp_stm_cnt_get_counter() return 0, but, irq still not
handle yet.

so nxp_stm_cnt_count_read() return 0 at 1.

it return INT_MAX at 3 suddently.

Frank
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_count_write(struct counter_device *dev,
> +				   struct counter_count *count, u64 val)
> +{
> +	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&stm_cnt->lock, irqflags);
> +	stm_cnt->counter = 0;
> +	nxp_stm_cnt_set_counter(stm_cnt, 0);
> +	spin_unlock_irqrestore(&stm_cnt->lock, irqflags);
> +
> +	return 0;
> +}
> +
> +static const enum counter_function nxp_stm_cnt_functions[] = {
> +	COUNTER_FUNCTION_INCREASE,
> +};
> +
> +static int nxp_stm_cnt_function_read(struct counter_device *counter,
> +				     struct counter_count *count,
> +				     enum counter_function *function)
> +{
> +	*function = COUNTER_FUNCTION_INCREASE;
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_watch_validate(struct counter_device *counter,
> +				      const struct counter_watch *watch)
> +{
> +	switch (watch->event) {
> +	case COUNTER_EVENT_OVERFLOW:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct counter_ops nxp_stm_cnt_counter_ops = {
> +	.action_read = nxp_stm_cnt_action_read,
> +	.count_read  = nxp_stm_cnt_count_read,
> +	.count_write = nxp_stm_cnt_count_write,
> +	.function_read = nxp_stm_cnt_function_read,
> +	.watch_validate = nxp_stm_cnt_watch_validate,
> +};
> +
> +static const enum counter_synapse_action nxp_stm_cnt_synapse_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +};
> +
> +static struct counter_signal nxp_stm_cnt_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Counter wrap signal"
> +	},
> +};
> +
> +static struct counter_synapse nxp_stm_cnt_synapses[] = {
> +	{
> +		.actions_list = nxp_stm_cnt_synapse_actions,
> +		.num_actions = ARRAY_SIZE(nxp_stm_cnt_synapse_actions),
> +		.signal = &nxp_stm_cnt_signals[0],
> +	},
> +};
> +
> +static struct counter_count nxp_stm_cnt_counts[] = {
> +	{
> +		.id = 0,
> +		.name = "System Timer Module Counter",
> +		.synapses = nxp_stm_cnt_synapses,
> +		.num_synapses = ARRAY_SIZE(nxp_stm_cnt_synapses),
> +		.ext = stm_cnt_count_ext,
> +		.num_ext = ARRAY_SIZE(stm_cnt_count_ext),
> +	},
> +};
> +
> +static int nxp_stm_cnt_suspend(struct device *dev)
> +{
> +	struct nxp_stm_cnt *stm_cnt = dev_get_drvdata(dev);
> +
> +	stm_cnt->context.is_started = nxp_stm_cnt_is_started(stm_cnt);
> +
> +	if (stm_cnt->context.is_started) {
> +		nxp_stm_cnt_stop(stm_cnt);
> +		stm_cnt->context.prescaler = nxp_stm_cnt_get_prescaler(stm_cnt);
> +		stm_cnt->context.counter = nxp_stm_cnt_get_counter(stm_cnt);
> +	}
> +
> +	return 0;
> +}
> +
> +static int nxp_stm_cnt_resume(struct device *dev)
> +{
> +	struct nxp_stm_cnt *stm_cnt = dev_get_drvdata(dev);
> +
> +	if (stm_cnt->context.is_started) {
> +		nxp_stm_cnt_set_counter(stm_cnt, stm_cnt->context.counter);
> +		nxp_stm_cnt_set_prescaler(stm_cnt, stm_cnt->context.prescaler);
> +		nxp_stm_cnt_start(stm_cnt);
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(nxp_stm_cnt_pm_ops, nxp_stm_cnt_suspend,
> +				nxp_stm_cnt_resume);
> +
> +static int nxp_stm_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct counter_device *counter;
> +	struct nxp_stm_cnt *stm_cnt;
> +	struct clk *clk;
> +	void __iomem *base;
> +	int irq, ret;
> +
> +	base = devm_of_iomap(dev, np, 0, NULL);
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base), "Failed to iomap %pOFn\n", np);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Clock not found\n");
> +
> +	counter = devm_counter_alloc(dev, sizeof(*stm_cnt));
> +	if (!counter)
> +		return -ENOMEM;
> +
> +	stm_cnt = counter_priv(counter);
> +
> +	stm_cnt->base = base;
> +	stm_cnt->counter = 0;
> +	spin_lock_init(&stm_cnt->lock);
> +
> +	counter->name       = "stm_counter";
> +	counter->parent     = &pdev->dev;
> +	counter->ops        = &nxp_stm_cnt_counter_ops;
> +	counter->counts     = nxp_stm_cnt_counts;
> +	counter->num_counts = ARRAY_SIZE(nxp_stm_cnt_counts);
> +
> +	ret = devm_request_irq(dev, irq, nxp_stm_cnt_irq, IRQF_TIMER | IRQF_NOBALANCING,
> +			       dev_name(&counter->dev), counter);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to allocate interrupt line\n");
> +
> +	ret = devm_counter_add(dev, counter);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register counter\n");
> +
> +	platform_set_drvdata(pdev, stm_cnt);
> +
> +	return 0;
> +}
> +
> +static void nxp_stm_cnt_remove(struct platform_device *pdev)
> +{
> +	struct nxp_stm_cnt *stm_cnt = platform_get_drvdata(pdev);
> +
> +	if (nxp_stm_cnt_is_started(stm_cnt))
> +		nxp_stm_cnt_stop(stm_cnt);
> +}
> +
> +static const struct of_device_id nxp_stm_cnt_of_match[] = {
> +	{ .compatible = "nxp,s32g2-stm-cnt", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_stm_cnt_of_match);
> +
> +static struct platform_driver nxp_stm_cnt_driver = {
> +	.probe  = nxp_stm_cnt_probe,
> +	.remove = nxp_stm_cnt_remove,
> +	.driver = {
> +		.name           = "nxp-stm-cnt",
> +		.pm		= pm_sleep_ptr(&nxp_stm_cnt_pm_ops),
> +		.of_match_table = nxp_stm_cnt_of_match,
> +	},
> +};
> +module_platform_driver(nxp_stm_cnt_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Daniel Lezcano");
> +MODULE_DESCRIPTION("NXP System Timer Module counter driver");
> +MODULE_IMPORT_NS("COUNTER");
> --
> 2.43.0
>

