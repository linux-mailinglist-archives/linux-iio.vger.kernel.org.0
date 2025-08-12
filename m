Return-Path: <linux-iio+bounces-22626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61DB22D13
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A95B188A032
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F22F7478;
	Tue, 12 Aug 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R2O+1igX"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FD2E9757;
	Tue, 12 Aug 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015311; cv=fail; b=lm1zbTAKTkqFuPJbPG56S4u3guWPLnizaC9XJUdQbuWxbF/FD5Hc2qOTwCUqLdTRPYor+a8SVx9Wq7MdoV1wvveucdRwwLotI0Elby9EDOY/Ql6kF6Pzpc+Um++mHtCTwufoJOZTqvSb0Zs/v1/ZibDpJkjkRTR/0BCsiUCqGrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015311; c=relaxed/simple;
	bh=YYTup6vTIQtW1F0aD1nBEE0/TmdF0qLH3C/FgNMqhb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mYSo9sc0dC2jUzlczZxmn0/0+swIxnxrEXZIS2CCl8rVhVj55kw9mxdaHwBmXN6ESobpOaLS2atj7tFQ6iBicje4ThWaUdkpDhMNHOMog1ipdcud+0bQopVAxkWOqtnCNGeGoRFd8iGPbpmJqIg1nrONcvRzOVju+JfuNpctbfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R2O+1igX; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h72JtcBJUQLXgzhfhjoN9pPM0mInJOKBsUwbexzzp24BDJmdC4QxIFgApyPL37htx5Evw+dJekpC0+5sV5wAO6eKodoOpiej061oFAOqnm8NzYsm1zmE/F+4bKB4VLWbAKiIAv60+nuDb5yJbxMp2dxIqSgsVS6aKdXHWx+KAFG2YDKLNNHB3wBD47xhkApG+7ZLwbu5r8Cj9Zy+ZK0nYmtY/kxKHQ5YBuTMOWOJwiDyyTAPubT0tFywujAr5sQpUXc0P+ybeD5xGw1hhIPeS1zpRB3Wgc/oXz3KvlPOUKgA7V6+upc+qIpIcT+sq01Z/cXaCoBRGkyRCZLZLESpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsaDm9HIz03XvXke8Jhb2MTaFm/GUiRPTi2Ez2K3z54=;
 b=I6nHeTBXQwcLpvJ3CZA2vFCGXJGeSD8fK7vGU1sA/+IbaMhxFpUTBuu15s/lq1vYPzoZ9ogdH6BUpvuUu/TlH4h/o+f7KnG/FVE2Sb/PJJ+sKmytflZkLivJAT75ucxCvxeU3eIowTP5TuNqts9ls5RM1mIJd4yp1h1GKj6epVJv1Fx3niOVxCF87vFh23q29fxpGvf26r7aPWRX3LDslMMtUHTKpdgOs0sgVwQd9dvWdTHE20C4HfXzc9wgXG5dkp9TtrqzquwlaVneywnPZJaB7ZSr5H3hJqZmkzuovXhQ/Q3pbyd95b36zJc1CoXXq9PMS2hNgUIfFXiA/CzfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsaDm9HIz03XvXke8Jhb2MTaFm/GUiRPTi2Ez2K3z54=;
 b=R2O+1igXllXy25XrfJd0WDTmx3NhliCPQCeqKsmq7zp5xYMWOfu9PJ7h/6D0vZ62ChGNfCDgChRzjLpRu8YRK3R3WwezwttBpkS5jT7s9Cid+cgqGkdPhoKsVLhqo58YdPRzxCniEAAvcCnIqEZFR9L2OQHI8W3Oq7ib//Mx5XeH2BIxUh+OPLzFoUEfCfoo+VPlht3ydlfpavRWKVwTsIrLItljiAfqBEKd8rDPN5B/VbhdAa8CH9vPEVQ3ki04ijArER0IFBHw8jzvSbW/98jJRjL9t2vl7f5EqPt8L+PDzIRXUCCTmRT1a6O7aup9l0J25bbh8aL/xfCaNf+itQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 16:15:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 16:15:06 +0000
Date: Tue, 12 Aug 2025 12:14:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, primoz.fiser@norik.com,
	linux-iio@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: imx93_adc: keep one style of the hex
 values
Message-ID: <aJtogj3ifWz5q1mN@lizhi-Precision-Tower-5810>
References: <20250812-adc-v2-0-0260833f13b8@nxp.com>
 <20250812-adc-v2-1-0260833f13b8@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-adc-v2-1-0260833f13b8@nxp.com>
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 555a70da-7120-4578-04a3-08ddd9bb668f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9AB2Z8+WyqSfbyilS4iHWTJq79BNMptMYW19GwKtvBpy8f/qqggnqyEcnC6e?=
 =?us-ascii?Q?KXsKG727XyqOUyfZCMvD0nWggNfxbFMQgP+SLNp6MXYT4ZXmLvuQ2BtgPorN?=
 =?us-ascii?Q?UZcYGvy7/YDUDtE01O1wdPKFVzO7yjzk48rfBSxACko094eI0I2Sw4XOCfgJ?=
 =?us-ascii?Q?AcyTndotsYD7XwFqQgZdhdB31bgx3DYQqbTVs4KGj/8SaIeITN5WgRzH538q?=
 =?us-ascii?Q?1crJR+DHbtohIP9EdRc9K0YpJpilzZl3XolYenyTJI9HfpkGu636v5WClQW1?=
 =?us-ascii?Q?/rpzKRTiQ7l0yRi5dbVQaYU1uy0Y3iibfrW0BSZLN+mh+C8+UK7woc74morc?=
 =?us-ascii?Q?98v0EW1DRZwloEMMDQFpmSztzMLC6zVo62DEpi+tO2X8CQiwPtinTXJVvat5?=
 =?us-ascii?Q?EqYzpHFz+493E+wxeOdGGNqwRUcS9+axR+JDkw+7L9sj0X9SBB9JifeLl/49?=
 =?us-ascii?Q?jYwajjrJtpRaMQIxTrjBvTq62X7XUgma2hY6fZxXEkl6RLegY80zOt7nG6CE?=
 =?us-ascii?Q?RJKjPjPc9KvlK8Y4CJnsfyMkt6t4VgOWZ3ak7Wp8XdwtKv+lLySQRIZ7daNy?=
 =?us-ascii?Q?8cCJiVbraZftabY14/AALC9SJm2tQ+0jdxbfWlmRkgix0ODbfyAsa4y7lTcx?=
 =?us-ascii?Q?PD1Vm9F6xZSyCpj2tPt1uVETK4dEOb3PqKHh7mnbXim20kVqz6QSGwZqIKXv?=
 =?us-ascii?Q?bVZsmYJg7c78gNakRX1cvjOV+WR7GT8GJjXU7bu+eB6huCD3J1kyWj35njr/?=
 =?us-ascii?Q?pTOmGxT406x1ZR/8qC8LHR3zHiMVHIW+3gSgoVEd1qT684F7bR4A8XY4sGuN?=
 =?us-ascii?Q?EXzYKSu26iubuq0zK+3eSdZ2lZ8kG4xTRrC+BcabRQR2U956b3gMGd6dK+Q/?=
 =?us-ascii?Q?nsZpjX0I4TPy3ocr10rkWaCG7yVpT4xx6xNFgoCLJUY6cvAl61xvAINTWIrk?=
 =?us-ascii?Q?KA6/v6L3ysjTbhDUmH3D7vlHOuoa/CROFj8dgkYf5ctNQN8q2N1o+BJUByde?=
 =?us-ascii?Q?cWkjHZfgcVoRG+86CD3WGTVMo6Lcks7+mY7j2mcbIXHASWE5s4BIL68oEPf5?=
 =?us-ascii?Q?vBo9u+tj0Rm1foif2d/KMC16C3E9vEn7YuzJSJp8ZLl78LbFQ5xSP8mBhOBT?=
 =?us-ascii?Q?HAmUdvdzsdkKUoRR8UWPYkwMzkAJf9BjZ0lTTIc3UX9LCkSSdXhPbtiZ8RjM?=
 =?us-ascii?Q?b+FE5JCEMe0uSfyXkR3zI5ifkMOYhLedr7sYFhuLkM6SMFW0Sh54x0kqvcvW?=
 =?us-ascii?Q?cyCz2Wt48CNt+leHTNsf8IN33ZPNCe44wlmZmxB2deD3Jr8ZMYWxnL2EEX/j?=
 =?us-ascii?Q?OYTMc7xrixayogXaLBsdfGFN4ncyJLb2I8+G6ASIJUx/UqNj4ChxH4HDdfWz?=
 =?us-ascii?Q?4A6SxmXNdD2J0Sik1/1bCakqk/m4FYx/9BNNbxCqKhaD9vzxct/GSFOtCWKD?=
 =?us-ascii?Q?U2zCgp+WR6kWBHDrIUMCaDHdk/DhvYpAiHERCWT7FeOkD+4tU8/++w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94c4PTaUcxuhf5nlRmvnpG7flqT9JfJz8l4Wof+UUfdSOEZbdgXWW3vCnWwZ?=
 =?us-ascii?Q?ynTWIyypIPaFFX+EopOe784vCAgC+lP9If5PzbOOxMWR5QXEvjACFbrilnWr?=
 =?us-ascii?Q?dq5R0E6QpI1seOJaiLnrag3WV10GCc/1KVwxzBQCyeZHHMPAEaZDYkKT2oo1?=
 =?us-ascii?Q?VizVgNLLsIvoV5A9wMwKs2pi1AeczXeut/sryalzvjCmSE73WmLkHn3SoYEh?=
 =?us-ascii?Q?jvCdbCwEXsKVEMZM5rn2HOTr8SChhJw+n1q6WrbwZaDWhiRrak+tCg5WYOLk?=
 =?us-ascii?Q?NPSXeyV1nCOVH9/GJGqj+lGlhUWR9V4/LSoPgjFic7dn0ZDKoOpsFQ8w//ho?=
 =?us-ascii?Q?D7OYs+72OHz1OE6csp/8Rs/BH3UI94GVjVDq75mQNG7DyRLZF0uT655PvqtZ?=
 =?us-ascii?Q?WmxEwtGuy3fgDt5iiQo4hWFvdM6pV0TswkdXxT4yK+wCu1lbTgXmaoKBsH9i?=
 =?us-ascii?Q?pe5cEfjxnmPqZQ1nQG32KQ93H9iNgSEkh0acWYaiPYHHbxFSp0ZPdCKkcJbs?=
 =?us-ascii?Q?P6uyhTluKb0dlPNYd6q5YRd736N0DTitaGIX4FsJKd70i+LD8Openm3wOffE?=
 =?us-ascii?Q?BOKjED1jW6p+YscdmvBMhvsaiig4ROD2dnegL3xv13Jkkw4RRnIP2d/HiYJn?=
 =?us-ascii?Q?TfZy/vCSon01HCFkqXVGeRb76Rpi994qN0Gi0BFCy89Si5yQsos8IFURxQGa?=
 =?us-ascii?Q?zAWvFS58NZZGAIf4L415Ko4f5vBP4gf6EOFKD/CakoVLWt3IdI7Svb/kl2R4?=
 =?us-ascii?Q?ps30ZBd9Sf2GnVUUo5T6rG5leyZE5DMqgc3zh+Qlb1FBUlFI+9G4NexAI2ob?=
 =?us-ascii?Q?7CiTwq2k/iXpx5P8nwPXeLzMMpzNVMONKU7VX8ebKbb/Hgp9THAPruxNZyDN?=
 =?us-ascii?Q?unASbP9edOjL12YcZKzD1K3crFrE8VcKiCklDaWKTxlpgPGYEdWZuuTwhI1C?=
 =?us-ascii?Q?6l1vbopPXtOE+pdt+PLbqMFdzaT4CpI7baGxPFqEJzrqBjMk7XPrsm/skoae?=
 =?us-ascii?Q?v1GNqTDx1ImllQBtDKUKaCUvrl9Y6CjIWBvlA0mNP1taxcis54LgnPwL4NWJ?=
 =?us-ascii?Q?q1kikhl4Nn21q674pPSdrzgwFksGQkpxJQYxEBOoWaxcG88xCNyYDs27oIyG?=
 =?us-ascii?Q?Unvzjxw95K0C6F9fmdjnwZsKzkVqMrAusuIZV+GRkxU2Val4YYKbjFeAcmf4?=
 =?us-ascii?Q?zad3rbVqQR7W4yUYfLaXczRxxhDLUKrTMBbXD8yePQu22Cn6ho88d6QeijcT?=
 =?us-ascii?Q?dZxSGq8hmfBm3/3/+ALEJdC+VI/EubruUPXcZJCFY4CDCaxqQ7QQ0rBGiQdP?=
 =?us-ascii?Q?MOJvIQwIz/pd4mF4DyEzYMUIMOo9dqUJP1FvuVUIkZ7Bl15i687Wz8s7919L?=
 =?us-ascii?Q?iF5P7oLjbtO29CZd4cS4UBzb5pf2o0zGeZSK3zTiayRpdiPNvtaTiS5xR0VE?=
 =?us-ascii?Q?vcRnc1+MKQ0Dv8R6xmTjFrRW2BDh6jtjGE32AdNsLUC4nfYMLmKk6AA8ieoq?=
 =?us-ascii?Q?KageovJof1WNpyn0DKAX63Y66vrO2kIgwen1hKULMWHjTknHgRUuxte4CSny?=
 =?us-ascii?Q?evhdW88OBmtmV+VFSUJVawc4cq/j70EjfOv0uBMK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555a70da-7120-4578-04a3-08ddd9bb668f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:15:06.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UubKy+TIa8dGNqnw2676Zp7xNm5fiXKU4I3WWXK8Ajry9kj4xv/rA0M7aLmIGaGNPaoMkCreREx+JkT0T0WVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051

On Tue, Aug 12, 2025 at 04:04:22PM +0800, Haibo Chen wrote:
> Use capital letters consistently for hex values.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/iio/adc/imx93_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> index 7feaafd2316f246bd0c32fea99309900b5c65099..8471737ac04a2bac0417a6397f20865f6a2c01ca 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -32,11 +32,11 @@
>  #define IMX93_ADC_PCDR0		0x100
>  #define IMX93_ADC_PCDR1		0x104
>  #define IMX93_ADC_PCDR2		0x108
> -#define IMX93_ADC_PCDR3		0x10c
> +#define IMX93_ADC_PCDR3		0x10C
>  #define IMX93_ADC_PCDR4		0x110
>  #define IMX93_ADC_PCDR5		0x114
>  #define IMX93_ADC_PCDR6		0x118
> -#define IMX93_ADC_PCDR7		0x11c
> +#define IMX93_ADC_PCDR7		0x11C
>  #define IMX93_ADC_CALSTAT	0x39C
>
>  /* ADC bit shift */
>
> --
> 2.34.1
>

