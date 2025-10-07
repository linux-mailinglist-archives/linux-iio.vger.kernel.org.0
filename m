Return-Path: <linux-iio+bounces-24833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E31BC295F
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 22:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F83B9E3A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8B22FE0E;
	Tue,  7 Oct 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XK1mJfmc"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437F1A8401;
	Tue,  7 Oct 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867555; cv=fail; b=pDl7rCpKL+yi7wj+tpBAKOPcEkFt+Bw5Lrpqf+2HgX+c+HndVA/om7ZdOziaKPxt2/c32R/aJhGU3rkwEYMd2/+KgoqOZD3vFk7/KAnv4pAdPGFcFrdfK+kHeM3KoWCYH5Qb71xpf3aFmBoq1Hu4Eo9xwFuXPjVmMucf8OqxoRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867555; c=relaxed/simple;
	bh=EjZHAIRLncDGgoSH+QBzCF7FRG0N+wn9jeYud7XlW3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YfBZ3VDZOlUxz6ZdayPTK3m8WZZbXQYS6cfS+gEV3LPL7+/Y7Jc5rFSpnaoQ1deseKlefvzzvTDuRTaujSDgBbonIwVM3ns8Vnh7gty4FslUwrsV2067EBGEeopCT8c3h5f/PNV747dRzUCCbc9Qazd1USir2jXRFRcgy2sbn8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XK1mJfmc; arc=fail smtp.client-ip=52.101.83.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqMYoD9hxiOoBlk5m6xk3eRmw1AjUpnaDH9Jm/BD66tCyAGWQTnyFwA2drdKdf85FWyWDJfjw3QxPl5RWDSNBnAzZYIzpUFaWNL9ieSS6HWxBAieVuyTAMtyE4dKpuzEchlQF9p09i6eWTGEkqIhosJaBmtdvPJj6tNA8pcp6xsLqRJl8FyiQFE9lWCsvV1yHYT+7JgfDi3BhnhkfdgyfOdwwNJg2MYuOwbKkTQa2AtdOWr0q0b3Ycj1BwaYbFU1f+N6UeWSXoeJgZFZtAEzW/tM0/ImllGz6mDjmLSVb7FtJDoMkFALHwBVT99I4OTaDW8mQ+WpyVnjEtAFyf2cTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUNJjhZPXbkkyshVIuCQ4A4kNt8XxgYJzUGJLRd1BJw=;
 b=aI0UpYjdEguVz7RfPlEG5HSN8F/oYCprNYGao4YqcO78D6aOYWTXLjJqyhWNWs+K9l/hJEMVuJgBdu6O7HNJH14CvSrgJvzZCr7TOef9iKT99oWmO5bOQZn8UEBtDwgcasidpaW2zAgWYA++Amt1LY/UGizDVw5ucSmtiDXgasgrLxE8kRxMIZWTkZ1GJOWB2Z4TKcXv7yWfqo9RR83TuXZm8wPQs5CLg02gBIraBkz6URwTQQrnYXQSicLS6pFJ3QwHK0Jz9HekrEP8ZIOJW6CeCN+LMTMaI2pI3ATXFUCp8u0Pr0nzo59ubbzzcXd/NNY5gilCnNBGj0mrWbq3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUNJjhZPXbkkyshVIuCQ4A4kNt8XxgYJzUGJLRd1BJw=;
 b=XK1mJfmc+mcV93AivwXF/DTsqgX0n2hbwDh+WWeq5R+UWPg8mIxNdfodaGpAM4/mT+p6yit6DFJuetfEmUZq/agl+6i3BIBgOD4xuAXz2FxEsG49ryqa8oVmbe6Um8tSb7CqQNdtxttUnBEGOLIUoeJwewUz43/yD0aDXqFx14LJ713F0zTeJGy+OwCTwVr7GULP03EsCdSOZhuINutZrezU+b8777bnIXytV3FWsmSFGarn6vHrb1DS16CRnzP7evnWeeruDg4emmX2aMqsLw7g2w3Xz1JtCpIBwUTqXFy/ROgPQU648dRuItLiDj+J06IX6Hoa7uwKprLHBPa7yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10259.eurprd04.prod.outlook.com (2603:10a6:102:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:05:41 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:05:41 +0000
Date: Tue, 7 Oct 2025 16:05:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-iio@vger.kernel.org,
	joshua.yeong@starfivetech.com, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v4 0/5] i3c: Add basic HDR mode support
Message-ID: <aOVyjARSHcexFyoX@lizhi-Precision-Tower-5810>
References: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-i3c_ddr-v4-0-3afea5105775@nxp.com>
X-ClientProxiedBy: PH8PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10259:EE_
X-MS-Office365-Filtering-Correlation-Id: bc287c7e-9361-4551-cca3-08de05dce420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FE2zl3TP0w0q3o/XjlbBhxkceZuUBuUHw0LkHNVgckfdvU6hyelyTR6G4fu7?=
 =?us-ascii?Q?q9wu3w07HdWgK+9DK96PeM8ud+Z0AYRFotWL8c0ttu9qDw0s5La8TglS4UtX?=
 =?us-ascii?Q?gGfNY8dkzYSoZbzbT4kFnrswivoQjXaMFE4U5KJqtYMnE6ZN5v0cby9VLNFS?=
 =?us-ascii?Q?tEFZbTan+hXRt+3IqVDQneXdyyo/0YkzHCv5k0GW3KAmZ1wiDjpqPdPzNQek?=
 =?us-ascii?Q?z47inAGS8oCNKYE+P9Agxs63o0RgVD3LyaCEbim5noV+2ETt8ziCe7jPRKHz?=
 =?us-ascii?Q?g2FpOYEUdjuxJmg0WeB6DjHUGLtmzW1Gg/kY25pdxRikAIXNb6+cBDk1t4mv?=
 =?us-ascii?Q?jXO365zR1Asr7tpxl/oH95BWwFXl/G46jfbNoE0wQZcZ/HemsP9h9t/hxeya?=
 =?us-ascii?Q?mzCgf+TilVNF55DFAvIsao7u7RraSiWxuojJrHoii640kZKmXYu4NcnLA8Ko?=
 =?us-ascii?Q?akb8PyKnGGbRpnRy0NymVb/89bqxprxksGB8QSgDYsxYN7csZlnzsv+pI9Dx?=
 =?us-ascii?Q?gYOhzuw1K2rLGFba5iQoWIypQ2zQz7g6B4b8iBlW03G0N9OWUOYxzNuvMWX4?=
 =?us-ascii?Q?iqaUg+jlcWvGTR9U7dSpyNY7lfepeRyH5BI77gZNoB1oxR9Ok1cEeQvhf+Wl?=
 =?us-ascii?Q?Sg+3OFJAbpkAFOXQTo5LMNch3tfsnhX/nPnVpP0twWL0mjkCfy/d1gTyFFci?=
 =?us-ascii?Q?gipFPCHsv5VMrtBezDq1dxXnXNXwuu5MayCDicrK2PA2c5094jydTN1lUD7E?=
 =?us-ascii?Q?T+xM1oj7e+67W8WBmomeiGIotIgECVSfws/An+XN3FPxRxz6afoGuZMPaSsu?=
 =?us-ascii?Q?qnN6t2QKElO9hMi35PRbTNRAnFkIJTiBPT4MpTlvRyHJU7zBWox0+M1kzTSC?=
 =?us-ascii?Q?RTa1xsdPKzMCxDUWJqKs2qYCzXVANbrXsfXioj7SCuiQE8SduH1N+iheYBwp?=
 =?us-ascii?Q?avw1EO1aI2vrMgcDCiW8Er+v2W6h6K6VeD6+wt5Z+rOW7waNZCnyfx87oofN?=
 =?us-ascii?Q?ZE5KG9vvDGbG0/+Bd5iAw/xJCp0INx3RS6Z8ji/S51j+nY4n1v2itG0tgcga?=
 =?us-ascii?Q?QM68narzk/7SYSNatznbCc0y95OJkp2/UK5O9BHl+Lg1J5MpZ/EEZmZzLDg/?=
 =?us-ascii?Q?UUMiZVYLX3+x2AfMCHYKo661ggnwIVezNmu8nuJR+4R13fPC9w7s4Cv6M/KG?=
 =?us-ascii?Q?gdNwZvfKtez6Ixlbxh+KBcCbX9EVq9OnW5cp1t3GhG+nIyolxt1e1/tYwbPS?=
 =?us-ascii?Q?UlPyKjnmM4Ej7Z/NzJMifQWYdz1m86dtU4TZG8Ss563TGV2MpVirdiGjb6of?=
 =?us-ascii?Q?DLKffj/zN+/RrukcbAymGd41dwEnLqs1NXmICfZ2KA9ZJb2i+9rbVI385+u5?=
 =?us-ascii?Q?ud7Y2e5lUieoktNNaUdkyBmoGCIRSWTrAczviq5xz6MoYa87/DjRvenBxATd?=
 =?us-ascii?Q?agdaNOrb8H10LAlHR0XGlIxWlhJWlp5I6QujwnwDxxokCeTvh+QNig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XBXfKltBGZuxY4yixnifuAKRqKjDG3byVEQRNFFvLVM4oMU4OCpN8qg978xL?=
 =?us-ascii?Q?1saQAni2HoXGB8ct6W6nedq9MZbVItD71A3XAqOl5dle3R4+j4Ij9aT8QPtA?=
 =?us-ascii?Q?QAQpxUKew1U0lPIrXyWDDdiXEr6JUCy4+Bdv3ZvmGDTTKY371luXjExG1msG?=
 =?us-ascii?Q?F2/zTEy/nI03iYxUnqGtY9s0r597WhdL3agAVl9D8AmZ6pHsqjMO5UfZNvBl?=
 =?us-ascii?Q?KNRp0ydZIJFhPny0aV+b3H3fFL4Z5mPctHn96pWiPbzuNu73l10VZSLCQ8K4?=
 =?us-ascii?Q?l8HPhhHGZpLV4HHaJhvKx34HpZiW867toq7u0J55g9Faja+GS/MOQsVuLShM?=
 =?us-ascii?Q?DtRmjlAstblGqvaVCOpuAju28MH/ErEpAqqy3L63Vg4v53hezlks8841Q5n7?=
 =?us-ascii?Q?RUwjyBahGSZJuMo8w7VJBeZJ5p5oZuWXjMm6qPv+eZzGTswHh2PC2aaYJpZG?=
 =?us-ascii?Q?3t+D8HxphHcyJKgC4/ieev/CrEw3L21ec94EW0ndIh7Wmw7j7eXAqYbOVd0V?=
 =?us-ascii?Q?+QAI+OTDH19eF3FZ2po7h5VUAXnyTIsiHq1DQCb5zQUEVPgxyYDw7EpAyyv5?=
 =?us-ascii?Q?B3uoJTBLAgKPyb61Vqtn8yNG5ynzYAVfKCPLS/3BozPYi433SDWPhBo5L67A?=
 =?us-ascii?Q?LsS0RBGhsDS14UO+CWla+ebxmBail0SHv3oqCU8SGceCVP/o04crPz8oXVqR?=
 =?us-ascii?Q?PgB83VeHQPlfn1cmI6X/2u+jqu6IdBiCwxWA6u1Uxsspuzwc4E2ao+MNVEwr?=
 =?us-ascii?Q?LZE4eieSwrMpWhx/M0cZwS+PNfRRVsRUe+ew3BybEzclg7CDdfJ9LfIoSoUa?=
 =?us-ascii?Q?bgnjOHhomt2z2dpzTa0S0qh90+cNc/sTXrRf/H0a+Sxu1onJFymx4JtNY+/L?=
 =?us-ascii?Q?nty2/dKptHP9FDj0Hgw3VccgE0TS0N3pvNJwX+dcV+ICf0TqMGaZ39FJmtGR?=
 =?us-ascii?Q?KIeUrfh7X+PY0JKZGGuAmE6ONkKTHQhp9hhSpXAVd9LTkD+adkDAYwa+SYmp?=
 =?us-ascii?Q?8mOXyCFHK/8Zre46FYtBwR9J0DG/06+6M+3y8tPowNCFTPskOzoIXA+0XTOx?=
 =?us-ascii?Q?t+Qb94M5mGWCqeGXOdKwuHtm2TKYMlXCDs1qtvqPlKPMiMsKhnV0rwoFuSqM?=
 =?us-ascii?Q?uOvDg92BRPeVrV/CCRViF1WwfC53dd0t2dLqhjvFOHczAJySqdjgjLMt6RT1?=
 =?us-ascii?Q?8t23Pwr67Gg1QMXYvUOrnClGAnS1x1E0bVfvduGhO1Wn3Va13xaPTFL8R9LF?=
 =?us-ascii?Q?eKtwRAi++xUzNEgOhjq2nVMl5Wbbu7SvbY4Vrmql+5bVTUE19kB1Z+hjTB5n?=
 =?us-ascii?Q?dnvtu/bHX7DNrO2dsVAKkvTXN9kDk9CjT5XejXx8GtRrusxoTTzdNOFGgE8S?=
 =?us-ascii?Q?261lE2RwSS5ST9WCHlLNImuQOBHxNEFsFcvJmvtNfDEYNCYr0IFCTKpm4P96?=
 =?us-ascii?Q?DFlt1cJZegASWsAVttGIDs5wJQoSS4nAchKcoBvrCW15h9nePdIWMD632Rby?=
 =?us-ascii?Q?LpxPKoVcmeogjdRlLb8THw3bnTEpym3BU1qj6Zmtd+ysK51bBaSu+rOpzQ0K?=
 =?us-ascii?Q?vZpR35q3egxcIRiBP5pKjm4pR8XrX4S/ox+nYRsT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc287c7e-9361-4551-cca3-08de05dce420
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:05:41.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFuF2F9ipnss7KxVumGaR9BN3gA63lycO0mrakcTQ9CLThevByh+vTflSHUd9rUXKBrp2eP/VImolxKnWjodtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10259

On Tue, Oct 07, 2025 at 11:22:14AM -0400, Frank Li wrote:
> Add basic HDR mode support, only support private transfer, not support
> CCC command.

Please forget this version because I just find miss CC devices tree mail
list. I will repost at V5.

Frank

>
> Update i3c framework API to allow pass down mode and extend driver callback
> function.
>
> Implement HDR transfer in svc i3c master driver.
>
> Simplifed HDR flow is (ref i3c spec line 5514) Figure 129
>
> <--              SDR            ---> | <--- HDR
> START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)
>
>                                     ----> |
> HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT
>
> Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
> read/write command.
>
> svc hardware can auto issue SDR part.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v4:
> - use master's hdr_cap to check HDR cap.
> - add mmc5603 support.
> - Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com
>
> Changes in v3:
> - Add new patch for change rnw to union for svc.
> - Detial changes see each patch's change log.
> - Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com
>
> Changes in v2:
> - Add sensor driver, which use HDR mode read/write data.
> - change priv_xfer to i3c_xfer.
> - Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com
>
> ---
> Frank Li (5):
>       i3c: Add HDR API support
>       i3c: master: svc: Replace bool rnw with union for HDR support
>       i3c: master: svc: Add basic HDR mode support
>       dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
>       iio: magnetometer: Add mmc5633 sensor
>
>  .../devicetree/bindings/trivial-devices.yaml       |   4 +
>  drivers/i3c/device.c                               |  27 +-
>  drivers/i3c/internals.h                            |   6 +-
>  drivers/i3c/master.c                               |  19 +-
>  drivers/i3c/master/svc-i3c-master.c                |  96 +++-
>  drivers/iio/magnetometer/Kconfig                   |  12 +
>  drivers/iio/magnetometer/Makefile                  |   1 +
>  drivers/iio/magnetometer/mmc5633.c                 | 579 +++++++++++++++++++++
>  include/linux/i3c/device.h                         |  34 +-
>  include/linux/i3c/master.h                         |   4 +
>  10 files changed, 745 insertions(+), 37 deletions(-)
> ---
> base-commit: 5248ab97a6dd1dc6856422f6b1595baaf4fa85ce
> change-id: 20250129-i3c_ddr-b15488901eb8
>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>

