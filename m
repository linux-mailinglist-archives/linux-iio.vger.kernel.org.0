Return-Path: <linux-iio+bounces-22627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FFB22D38
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431BD1882FA6
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9E2F744C;
	Tue, 12 Aug 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fshQXtCm"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A52E9757;
	Tue, 12 Aug 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015417; cv=fail; b=g934v2j8NsSenZjmBXiMOEm6/17F7/rxdeSPoErmjtR6qWi9C/1kAMyvY0kQyetx9P5V2cPPOw17skSAC3lmBzjbSDlVUR/crVFkSh6y2qpbYZ7CLIN4u/BJnapyIDpgweCTWMgfM68pTu0jdjvJu5VDB2YbbJ6VhzfIUSP3Vd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015417; c=relaxed/simple;
	bh=UVQI9QJDIu0NalWJGQhoj36W8E7SzgkNOWC+syEfus8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cLez43I4YXDoXN04uqnXuszhYSC54/+ZQQx7GbzOzmrqUB46W9MPI/PhOk0lyQCGemKtsNabhR6zxC5vvnbnd9RK3sgNLwG7SrcQKBxD+S8QzKIkXOA8JcEz8Ari7LRiljlOD7RM09xTHG7GYDQHyagDfp8QJo+AExPVmpWsUP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fshQXtCm; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCxJixxNUxdWDIpe7wIoSVYFV7vFPiJc5VDfmgn4aJqJTdC3kDjJsCn+H8xnWtA+XNLS7eHfVSe4PUBjKhIy5EJwQwx+QF3mCAR7+sKb/NRGgYm9+JYdaPxLuSem9zsakVuUWhlDtQZPD21lE/vYV1dihlODPoKqGJIYdl4TTaHofIbKV5aPjY5eAHt4bBPtP+Gu9B6bPbaOvUPQ/yqcImU3Ddrfgq5LLxAIRcNTOxmbx3l2r2+V5Y3+SfgyaYy0C2J52NnTrJH2Y651LUqHwz9DBn+wI9ZbHEQ0mSWKBdXYqyMmDjovkUU34oVDcTw20M11B5CpcGwmlqjVxay9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUj+kyuZGxYJ4XigSzcJVbubikG54Y4LhOumcGEr4wg=;
 b=bauazCaOcarby4KCg12//l56o5j67vq+UGrhjMyICy0YpeN3FkVu/LOpiIdX+Y6DrO3oxoKXk2a0mnjpNlTCmf06C2kA+uGeiP6yDaCDdEGxphB/QjtBS3dAXdAnFimwwkeW2gFg0MF8vJClf79UOBZsMiEcEZEgt7AuZnDnOvGgl5tLMg2haePcGDN/tAr2zhFtL6WPehfGyWD3T50/UUIzqo+CwdmG5GvJPcbHRprm9nhiPayCuUhM9gd5uWJOWR1wbja8qSLaSPWK0zxH9BN4Zr+GZroXPEfni4zJm4luxV8QIMdIQZUE8T53Uzj2k3PxAyUak7h61RjUpcofXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUj+kyuZGxYJ4XigSzcJVbubikG54Y4LhOumcGEr4wg=;
 b=fshQXtCmgm/aI4VDBvTAwGizpA8zxoSo61hTZKJjLaM56UE+E0bbGejV6clp0f7au1KOISENNx+ivIVKp1Wvbm4s6+KOSyNm7fATDwTiNFesIEb1r5P5e+BPF9BrubHQHNUftlNyTCvqrXxoyoN3DxfMTdH2zpYkXvKtReplC9PlrSfKp8DxYPFF1sqbxkdsQIm0eWOxY0dGS1HXubLnQgfn9FElI9buxaGtnoN0NpPy6YijQE27zPhkC/CwilHLGkcNw2jgJsG9h9DvPwD5T0ivZ9vPjLEbeu3cqYsr1eiYN8JSYhEnkhwDPRaf+fzmFGbW8Ixh3gBWDBVR+ePS2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 16:16:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 16:16:53 +0000
Date: Tue, 12 Aug 2025 12:16:44 -0400
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
Subject: Re: [PATCH v2 2/2] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Message-ID: <aJto7EJhmkURzJaF@lizhi-Precision-Tower-5810>
References: <20250812-adc-v2-0-0260833f13b8@nxp.com>
 <20250812-adc-v2-2-0260833f13b8@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-adc-v2-2-0260833f13b8@nxp.com>
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 247861e7-7299-409d-5a66-08ddd9bba648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NVINNfIHlxLUKUw7co2HpXMUChZpsLM06DLYYta3WL5v5b2/1KI5zDVrzK3a?=
 =?us-ascii?Q?IBtejaE04U+aXOLh2P2iuKaUkf8lAq3bJClPlv3o7MLodQu4SM+a9lBMl2ov?=
 =?us-ascii?Q?5ly7gnPeuEVisY9BB5Tauz5X7dPpZBnoL+czf73Ab6pQhYEbr7CRtj+guXp0?=
 =?us-ascii?Q?GoCajJXJLUeliQly9tYs3fAqye3jBzIUmczsz26KGdyw5tRjyYhu3cq2zz1A?=
 =?us-ascii?Q?9uVqrhQE6pl46Mx6FnO+MC1wlC3vJv9F4RXSj9K1hltvz6QUERxm9CyDN2Zq?=
 =?us-ascii?Q?DKnmmo7vBs7x6tr7cMmd7tQ8UebTv1InFSaKW9yPFqsmSZIYGlYmUOV2GjB/?=
 =?us-ascii?Q?8XxxD+Alwo2aw4Ps7N2hKgP+mA+tGMN2WQdeV/Ooi4eE9P/d9YZCavNOdY4R?=
 =?us-ascii?Q?34capQ4TTDufmbVL8jkuSziBxJzAYXbs4at/Ir6XSaNBwTvAPAB1GxjC2KCs?=
 =?us-ascii?Q?DTCvrOVbKQVvc1QMdzvG7u2YE1azc01pfe72ct5HcGzY7GHLUYuntAjjFheq?=
 =?us-ascii?Q?/zbIr/RWVx/H2Gi+0ZYbaTUVTR6zuceXLGXi0GOr9aBFf1x3dprOQSRLgnGT?=
 =?us-ascii?Q?mFcsNWfRIwD7yw/L07IcjhgeXH8Hi8D3p8aNHx9kWi+SeCGxWt+8qgzS4jIJ?=
 =?us-ascii?Q?Y4IBHC4n77ETryCX3eW3DANjcxVxjyNvjZokzGsHuqqmHKHfbGrg3JOllfnp?=
 =?us-ascii?Q?JOmTteIN6B+ticv7FXbKO8gmk/Ki5cwhKrc8EaBKtWdypXRfYqq4x6LlyVl1?=
 =?us-ascii?Q?gx+nJhcl2yOjTLuUcpdwXEA2u+tP5yzvlmSBhbBqWRf1y3xPr44jJEmRko4U?=
 =?us-ascii?Q?kdaWIhxhMWft50n5Fla1E5rdJiF7B4MMMQTGX2wfYEazjFOhIoQhXB+hxrBN?=
 =?us-ascii?Q?wtLkgqYQV0TgXgKJRYff1GEpKQO0LzbevCbEcjEU8+H23omV9afpetjx3TuK?=
 =?us-ascii?Q?6fqRymWN2X7Uiulm4hEWLuLNdYXixSvLvIPO7R4CSjWr5beewDZZGtVOSAee?=
 =?us-ascii?Q?UW3hx1sQW3SmJbC71jWTRb2YqWjtIxUHT3tGVUFsvblsWMozkoilV6hFAScD?=
 =?us-ascii?Q?YClLpYPjTxgPZeIvTndggOLbv8zb64aQmLSMHIeaqcA0fi0tkMgzOK9N7nxE?=
 =?us-ascii?Q?zxu9M9VzF/EhFH4Dwc+0m/ADX9x2d2pOJpYvJKshqjI3WoszNLF/l0TfxUk/?=
 =?us-ascii?Q?6ct1aj5Z/6wRTsbd2uGcMGEOX1cthTXIP02wdBygEzJZ0qKs0z94W+S/KOWb?=
 =?us-ascii?Q?heNrzRfqhCzIGXcKq6jo3IlbFNt0lWGHyrrrgdrCUiSPU9qkIalm5ewGhmML?=
 =?us-ascii?Q?4+Vod9qXkDFfKF/+q00Y9opB7syBzfmwuAKw45oZ7uQnVl1mHgqoWv3sOSYO?=
 =?us-ascii?Q?IrJf4oI+1T7sgdWbHY1JSpZGtJldX0G9Pdo2tN10cAowN815Ay2nKuzZEsFd?=
 =?us-ascii?Q?QZGYzeX1HgoF/RzdxT5z4+E+Y8dOofZqbgF7uNa8XZCTcCf/fxNfZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MSjlhvr3Kg/7kKs3AtHdWcI0HCtjeD/Op9pxkI9QDNYbbwcOw99kK6HqS17K?=
 =?us-ascii?Q?0pRHuwnQqQGDgvzWO8IaXaxYthScEMTEDPVEBgE+uOI5dlNYePwtnmClas19?=
 =?us-ascii?Q?9+zvg2ognE/s6AUcC8ftjjDBDK/ZQ1GpG0qxrzer8lOlPI/NfO+5oc3wVTA/?=
 =?us-ascii?Q?JWhsN1h5ykwbpMfS2wP8PNt0X9qr6mn7j6tAC/v+1q8zrbphJaaClS4H5F3y?=
 =?us-ascii?Q?oZg/oPiBMIyQnMrPWsFumWlI2dFrkBOK+4hhD9Z/38obRrJGIz9+mAHWFGNa?=
 =?us-ascii?Q?gFsPVVmDAzMeHIJdQTkU8qeSRvIX7lIMBD0hlzTk60X/7IYy6RVDG4Z5Coj5?=
 =?us-ascii?Q?Gira2WETJslAXq64+AdH5yU8gRm+en0kTXiqdgUdmB9GbfrWPSm+3+0M0uxa?=
 =?us-ascii?Q?kSeSCZO5GwuvL3S3RhNsTxdAhmeP2IgvLevgHpIis3Xur0T9W8WZvfeCuwXW?=
 =?us-ascii?Q?nfdAtLH0aBEuRA5dfmtvfsONYcDfp0yBrYUr4ajzYrEax2K+inhUIHmwNb9B?=
 =?us-ascii?Q?cngfE2tWWNMkwlFyVDBz3rLLnCvDYwAAGs7YcLsBYLjVrEGDliyafIF5b+mP?=
 =?us-ascii?Q?8IujIJsgihqFeNJlvdW4/QK4rrfj6P/717Ycyhj26ckbQelaP7tEBoX4N9ZJ?=
 =?us-ascii?Q?2am3WRVDCyxwvfS84PVJxpYu0n0gC5uyFs8mFCE8c7RCWn7ZqmcLbsQ1CiMw?=
 =?us-ascii?Q?DTHEsYTvycdOmGD0TdS3Jb8hgnShjOePzxwlA/Ij8tIg17SIv5nWjkKHMg92?=
 =?us-ascii?Q?KGG4N4RSBRw1l6GBdT+wZFalZ9CThOrG/e3zBQu6GCssV72KTs/gcun4LPzQ?=
 =?us-ascii?Q?+kFXazp3r+KEHalxIQeEo9wJ5aR9eXBr88xmNig3TGjMmUFoGJdIyoTdEkKG?=
 =?us-ascii?Q?rHmcKIlPFyQCxbZBIgQIXKxTBFMdpiMlrRPrK4LFMpuDGLgffWb0ee3YINDy?=
 =?us-ascii?Q?OvrINwKp2XoJEAUw9mox/jP83mhJ8k9s8FNI5uMT3M6Zadexd1J60FWxl9wD?=
 =?us-ascii?Q?JieVYGOXbPcz49/SlzTkVcKtlcrstVDpHemkbGSaJoJ5BSdagv+9IejSedAo?=
 =?us-ascii?Q?frAELr9BBhU+LtOQTBgBnkkQFC5y98q6CXq+cE6h1qgyG8MT3OWaavesKu1R?=
 =?us-ascii?Q?3I0ZOeUzdCce67bklDmgsedLx2kH2Zmg9IapR/irCvSrupP2YZcAjpTCBP4o?=
 =?us-ascii?Q?izy2VllJTuIFm6mTuPWskg1/K6prgPwNs8fNz27XFHwf4gFciT97MLTr/cDQ?=
 =?us-ascii?Q?qYRStwF8AqWUrx+C+wdNNLe2+kXPK3KIkcqdOavvcSHBbb0kTwQ0yoJrYyFg?=
 =?us-ascii?Q?t73Bx8MyYhK8S9MO1ceyj2qY1AG2xDgn8hxxWX9BOZKrOcA9HMz/rOrkcylL?=
 =?us-ascii?Q?b4LjJeT30LaZcz3YKpug/VJnOrRPYbgOmesIEDbKEStdneLLf12tW7ssknAv?=
 =?us-ascii?Q?9e8l6nLaYlKBKsjcoLvF8E9X00iDhjbqwQ5bPq7uihXzPi3Mb11B+oyC8m5+?=
 =?us-ascii?Q?MO6yFaeAgVVpHQRekY69y6gbIfSHzF9UFZXK/UUda4rfejWEXpl0YrkcH6e6?=
 =?us-ascii?Q?gnFXuyzQG6TCdVD9PTSl+m8bJOlMkAOxaglimni1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247861e7-7299-409d-5a66-08ddd9bba648
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:16:53.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7LZ7XsossFAVt8jR9Bb1xXNQmsp1PaTIIJMcDfiWncfmQzzLq1mX1JlY2Z73K2QFvd+ZDKPTiGglr+ISGXejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051

On Tue, Aug 12, 2025 at 04:04:23PM +0800, Haibo Chen wrote:
> ADC calibration might fail because of the noise on reference voltage.
> To avoid calibration fail, need to meet the following requirement:
>     ADC reference voltage Noise < 1.8V * 1/2^ENOB
>
> For the case which the ADC reference voltage on board do not meet
> the requirement, still load the calibrated values, so ADC can also
> work but maybe not that accurate.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/iio/adc/imx93_adc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> index 8471737ac04a2bac0417a6397f20865f6a2c01ca..17b0a2548b0a3614ac537b01e28bc3144d17d6fc 100644
> --- a/drivers/iio/adc/imx93_adc.c
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -38,6 +38,7 @@
>  #define IMX93_ADC_PCDR6		0x118
>  #define IMX93_ADC_PCDR7		0x11C
>  #define IMX93_ADC_CALSTAT	0x39C
> +#define IMX93_ADC_CALCFG0	0x3A0
>
>  /* ADC bit shift */
>  #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
> @@ -58,6 +59,8 @@
>  #define IMX93_ADC_IMR_ECH_MASK			BIT(0)
>  #define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
>
> +#define IMX93_ADC_CALCFG0_LDFAIL_MASK		BIT(4)
> +
>  /* ADC status */
>  #define IMX93_ADC_MSR_ADCSTATUS_IDLE			0
>  #define IMX93_ADC_MSR_ADCSTATUS_POWER_DOWN		1
> @@ -145,7 +148,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
>
>  static int imx93_adc_calibration(struct imx93_adc *adc)
>  {
> -	u32 mcr, msr;
> +	u32 mcr, msr, calcfg;
>  	int ret;
>
>  	/* make sure ADC in power down mode */
> @@ -158,6 +161,11 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
>
>  	imx93_adc_power_up(adc);
>
> +	/* Enable loading of calibrated values even in fail condition */
> +	calcfg = readl(adc->regs + IMX93_ADC_CALCFG0);
> +	calcfg |= IMX93_ADC_CALCFG0_LDFAIL_MASK;
> +	writel(calcfg, adc->regs + IMX93_ADC_CALCFG0);
> +
>  	/*
>  	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
>  	 * can add the setting of these bit if need in future.
> @@ -180,9 +188,13 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
>  	/* check whether calbration is success or not */
>  	msr = readl(adc->regs + IMX93_ADC_MSR);
>  	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
> +		/*
> +		 * Only give warning here, this means the noise of the
> +		 * reference voltage do not meet the requirement:
> +		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
> +		 * And the resault of ADC is not that accurate.
> +		 */
>  		dev_warn(adc->dev, "ADC calibration failed!\n");
> -		imx93_adc_power_down(adc);
> -		return -EAGAIN;
>  	}
>
>  	return 0;
>
> --
> 2.34.1
>

