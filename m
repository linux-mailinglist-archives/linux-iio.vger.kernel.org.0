Return-Path: <linux-iio+bounces-13190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ACB9E7C1D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 00:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692C616CAE3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22FF1AAA0C;
	Fri,  6 Dec 2024 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G5R+/+SP"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26B20458C;
	Fri,  6 Dec 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526011; cv=fail; b=Ob2poKnmitbt62a3/HE9WtV4uwOcR58PSQMLjj/lHmEu39zi1YcLXdHqpG7o/HI6dfXstP5uOdKjRI7MFKNBR9hG0P6QyANwcRSr4G/0wJW+k0OxjhngnK6vfx1VFwzty6qgARTpk1R/ZnqKgKR+TGDgWReLbdSKjhHmDZpvIj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526011; c=relaxed/simple;
	bh=tQw1/+4/eR+MKauSRNtLaMyBQtQSAVVxon4sUVtiy3Y=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2rKbd9D/k4mouPqhvsgMDeH9fAbBN7NINflvSxjoX9mzMwJZ8wtTDUEeI4BPKxAGuTESCwwd2FoulmwCmhRJsC6g6PbGrK9qkdlxsmbj1VCQ6AeYx+m7ykfyErbhoRqbPf9PzCm5tJ4e6qlzXcR71ITqvH6mWUzGQEpk6Stu10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G5R+/+SP; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXobLHayt6LafLkoW4qbZuvbro2kGSlZZ1FcQ09+jtc/a6gTT2ON0Kl/9t/IFyzBS6VpBNmpJFvP6XJXhiNsedObPhE3dX86LQg8fawB78P+kEC4fOaMgxkTOKtY9FXFRry6pUPvZ5wlbdG4d+8AJV88aqGrHZWf9VVWRDRRUIPNJzIbSuKhH80qT9nkHFz5ESYnYl8MbntS3T3vQwM5Q6VFzcQ6XeNlY5OhKUYxBxBGbxhb550mGtk8wbnXNSRqcbvjCgZYwp9fh4SW/BYDLio22nVXz8lSIazjDCkEqitRrv1cOKFmGGMFI9hI5twdHNggY0WHDK4l6G2MjrD6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vjUPVbX/ie5B/v/GfUu5UtmV6YwcEasvJN7EwaeYRY=;
 b=Be84Fetv746fTiMo/qdZF1JBGIw1BqGc+sFdne6EsDUdFa+2mniI9HhZvcbW1pbIhC4IggNT1idc8yDpgu7fKxD6pYUUtXuO3tNYNcqsE/fxFiphpqetADRXQh0/m/A6wef+YAEMHysNuwAZOn7mC6yLZJgUfq3/a6ofVQ3OxbjW5VTkYcRDEOSmyVaRslXh5bXtc9TTK3jGUpJcz6TTb2o97Qyyzg9rjxRLRGTOIRlx5I4BeggBlXvoAvPxitllk1B59trCweKmsENK0RQECvCJpITLzD9DUenxBcKB7W2uaX2Wcil0Jw+px5paddHIROtd5qjDexChv5pQ5PAv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vjUPVbX/ie5B/v/GfUu5UtmV6YwcEasvJN7EwaeYRY=;
 b=G5R+/+SP6b9sV13ERTl7Cdt1z8Dn2IkWVIKIG7IO07KjbE6Qq/1qsgTWL8nPp61KwZlXxFgE6dFyLyObWSrg0zBlrHV/rInarXq9qkp1wlSom/VDqgs6RB7QSG4EWgy3xGQuDU8jaSxBMEMWO2x4v7pL4SAKJgOQK0JIlhtsdzy/YIjWtXluv7ZZbv1aqU4RvPJSHOj1q1aFklfSaO2wvVE3m6qfh2mJkcLEHLC4DYvRZWmk9lwnSK7Us/HbREMgWfCt/Y/FmVOYTrsGtMxtM+JOYHMFRevcQyKtmxIFGGiM6R/SPMDajMQ/rdn3W7KqWQD6tLrcCQRMUG2EmRyaBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10709.eurprd04.prod.outlook.com (2603:10a6:800:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 23:00:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 23:00:06 +0000
Date: Fri, 6 Dec 2024 17:59:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <linux-iio@vger.kernel.org>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <Z1OB7//w/rnjvHss@lizhi-Precision-Tower-5810>
References: <20241206225624.3744880-1-Frank.Li@nxp.com>
 <20241206225624.3744880-3-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206225624.3744880-3-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10709:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fdd02f-e654-45ea-f5a8-08dd1649b9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZf4P4K6EL4Ix2lLHEKnE/BiFhNnChPzIrd4pje04T9dN+4MG13QNC5d2HOS?=
 =?us-ascii?Q?Yc7oFN5CEzpmtcPGIawUTV0pXiPJwIdh7QoguPfC6IQee7+TV9OjSipsZgNZ?=
 =?us-ascii?Q?RTT85f1E256eQJmQKM7hxbLWkjK/GQdd/lBeVEIm+RllT1+qtsF0MlVipa1T?=
 =?us-ascii?Q?eVdEKNlDeIWdCwA2X3g0LJPd4gDVh22BCpcIBIlZdFnNgYFVbUN9ZlL1aigg?=
 =?us-ascii?Q?kTXJe6jshznL3gWTxlgavXXtm4aBedc/P+DmenHz0Sj/Hf9P5fRTLPGcR6F+?=
 =?us-ascii?Q?QCI8SOQ18DO0Ahys92kE12sBOSysTWTyJIXt3Co187BtHqrO1jq2gYN+TFQC?=
 =?us-ascii?Q?ikn+Mhm+4V7SGFXAr/pWQS8B+GBZqQKZ+sFCh1exEWeN6OaUdzwueFWbf04O?=
 =?us-ascii?Q?HVTFE7PgdR9mHzF5wk0iZO/FfVZC8qF3zyyCnCNwo0VGxwbDMVpqDohfirlb?=
 =?us-ascii?Q?RsoOmIkrXIqNnsHXFs32ZMptmPSwFArO5rpQiM3AgoV6dEqE1z3gGFdynuJh?=
 =?us-ascii?Q?AeSq9F4C5UA3DwdBRtqamZIsoUWHV+Oq9xSjuJyH5JlHG9P3ANHu+3QcCdMS?=
 =?us-ascii?Q?ROzfq3J03+J3unklpZpczBVk/SZB7q1jd+3cgqLCj6a4tBiehME/vXgwbCQy?=
 =?us-ascii?Q?gXG+QAvZvk2YdO7NAGiKcUBAHJr20mZywTG1cBzOd9SDD9Qj2P8nbNkL4p8r?=
 =?us-ascii?Q?ga4UKew/xo8YhMCpV9P0mV6pN4kFIesoP8lSOKLVd3X+5H4Rlmxh1pak/1fU?=
 =?us-ascii?Q?0B194iqhTqQWevGKfBOF92Tv5dEktAffbO/0E6d3On7ofpcR6OJAatvhkCd8?=
 =?us-ascii?Q?8VHLe1iX+sbE6QjuZQmITMMAlBuCNaZrJqG6x9zRTK0kT25mJMQDk3g8x6Vo?=
 =?us-ascii?Q?oOf2mv1JV5CEXUWIr+zrBb7Fod+RwQhFD6boGMgCyPJwKKKmQc3zNDsIPFE4?=
 =?us-ascii?Q?V+lAnnUXvDt24ARjfh5LR1oeIZ28yHxHR1hLUzyyx0Z9SAb9td5J1AxDxfq5?=
 =?us-ascii?Q?ywHlkeKzzuJ/vHqH43Pc9jHOXmWtZwFum/nLgTlyQCkz8KYRBwV90wMoTe6P?=
 =?us-ascii?Q?Z/kcNfYA9LMQCEou0WOK5c4BnlyfT+YME2EDDYfAkdFHMUs/rIr8IgLYnl+L?=
 =?us-ascii?Q?58WGN3GFPUzChu5/6pxaNnzDmE6ZpjH9C/4U8hAmqyQmidcBPh/YiGtYhU3h?=
 =?us-ascii?Q?7hKUjJX9KKjgaQPdWaxc8GLXUEP4O0Z9wZVf6S1r9tvl3dK9BshExcgEsVT5?=
 =?us-ascii?Q?tz6ITn8TqrtLCialxiVYFWmE95atH2ZpBD7/YNLN7y8FsTRLYYpAmm3Nk1eM?=
 =?us-ascii?Q?TSFbSTyIVXTdnKhQW37/yHp5Xc15oXUpKV9QII+8i21jUq/DT+UlBGJKA44K?=
 =?us-ascii?Q?m6YGfxKJDr9bkUTxMDBGsV2nFPIQ3z1oaSUYFcqY0KXyfQkAYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lNWqzJt6p9kQvFYLK5l+YAjlOr83WdDgwahc6mFgvruub/djXUUn0bg/2aNY?=
 =?us-ascii?Q?1i8ccToAezdqx5JBLNjccBqGLJ5i735Ayx2eVirCvAXZ2pzYgzeE/DhEnRFx?=
 =?us-ascii?Q?WyDmCQUYZhfgxOgsITCd+3+8u6FCm5UK3Khx8O5m9b1HwL0YLQIS/xnpfIPr?=
 =?us-ascii?Q?23LNN6elXlVoDs9cH07jgfq5/+Q58le54UzZCkxSRTJyLv3RDBwHFv5GourM?=
 =?us-ascii?Q?Tm4KokNUAxj9rtALNlaNk5T3TO3TEc2TvbiDihSaKkeS+rOZRjiwIaj6NNpY?=
 =?us-ascii?Q?XXPERO789qQrG6lWsoiqvaLLxsZpQ7wgqQKhSzKLj/EJYCr7d1wp+DdSeMXm?=
 =?us-ascii?Q?aIgWs3ylZAg32naph9XRQXXhR7v8DedOCJQY85wPZSEOKacrGvkkFKR4cHD+?=
 =?us-ascii?Q?JHH/ZRrPrGclEbMPya1cxMdKn5QtXILjG5T6UEY4dcESsxcVR45m5P8Cdar8?=
 =?us-ascii?Q?K0jVUZUMp2HQod0TNft5XwF7LENz/ewph6nULpkjmyo7rq+WVxF/XB+XdsA7?=
 =?us-ascii?Q?IzD4xsWMZCDaP7HnWVbm0XSEZdG1CCuKjewHoRC+6D2Qmj105Q2+1raHvv9j?=
 =?us-ascii?Q?NPHsvmv5DQ+Mlv4ynC3B5dGk+TRJINuB1VkK6bAz0KcLraYfz0hMZSfh0g9X?=
 =?us-ascii?Q?2VIzbfhvuFRvG8h9MCM7g0ephc9zfaItT12XumWk5IxTlg6IGiNhu92eNSqe?=
 =?us-ascii?Q?RP/0b36GfHj2tJLn4H7IOHUNFtA6z0AFjNe//muYhqZUeMDRarq4D4/SR+xH?=
 =?us-ascii?Q?qZ7x449DLJhQ/VW5PHHJDyYW/356SS/seEITBijaN4ZhnEthZ43GJdKTSJPl?=
 =?us-ascii?Q?q9CahX6ySvY0rY9zedIfr9M2gYjHaW9RVIccSOlAbUC2KM2LDAXlTqRlcziB?=
 =?us-ascii?Q?Ocs8ackjpWF3VPRkc2vvgajrY8u7avyUBG7C38XGm89VLX5QQCF+/aZmgw3K?=
 =?us-ascii?Q?/+pogKGSb8W0tzD9KN+SAZU3wp8ma3X3TMrLbxFUmFI7rpnKGgEnkrwGLoMM?=
 =?us-ascii?Q?8XRldeFlmvx/mjMZfR7sKD4tTWERDrMaL7Bsm68AmNJWMCbdxX/OI+gy4FnY?=
 =?us-ascii?Q?iuzBMoaZFiZaitXxRRgJ+1FeK2zcsYPVU9F5yrPPWJGIMJyg5qZyqqcAqtJv?=
 =?us-ascii?Q?C9k5hynWddM8x7d/5YyBkxqagwigo3hV2OT38K2fRDDWZZEWlsh3GJ0xJkL7?=
 =?us-ascii?Q?dOL40SQLqtTlzT5iMnNkyANByIPdIvt1O03l4j0ipGPgFwYx8eA083Bo2ucn?=
 =?us-ascii?Q?28Q/Kx4jpwXAwXG5xyA8YSHyv5wqQd1pEwT3NDCDjSFz1ja8zRweUQnQE8at?=
 =?us-ascii?Q?T7BXgwWHaK8z1V/y6oj/c2jNz5nF5iIgQsD/todsf6sXxywEhqLvg2qtTFBC?=
 =?us-ascii?Q?gikkki7cht29NBVGVnVAxxRsYJFMtkiWENVzCcNrGspeTjECcdIqnytX9F2w?=
 =?us-ascii?Q?AGSq9Iy5leT59PJ8WhuWCR3yjPYzr3Nfv90RIXi2ddOkpjx4F/z8kMiPadWo?=
 =?us-ascii?Q?O0NX6SXTeWMEFHalpa7bkxYXHKDW0BoPUSevWQ4fnsSRCHslQS6NQ2J4GVCK?=
 =?us-ascii?Q?N/I7ozv3geT4H1aQo1c8GFiZe/2CcyfVBZ+6Yvo6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fdd02f-e654-45ea-f5a8-08dd1649b9d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 23:00:06.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epIpwWBeT/4kz7K0F7ZDoFJx2CKt86ne7hYkjiR/DsaJ7Pnmv2Zn5D5jym2NR7tFCGeO8hD/Shr/jCHBHumInQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10709

On Fri, Dec 06, 2024 at 05:56:23PM -0500, Frank Li wrote:
> Use devm_* and dev_err_probe() simplify probe function and remove
> vf610_adc_remove().

This patch already in linux-next, send out accidently. please forget it.
sorry for that.

Frank

>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v5 to v6
> - none
>
> Change from v4 to v5
> - Remove vref check in remove action callback
>
> Change from v3 to v4
> - keep vref_uv as u32
> - keep original regulator part and only add
> devm_add_action_or_reset(&pdev->dev, vf610_adc_remove, info)
>
> Change from v2 to v3
> - change vref_uv to int from u32 to fix below warning
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp@intel.com/
> smatch warnings:
> drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.
>
> vim +857 drivers/iio/adc/vf610_adc.c
>
> Change from v1 to v2
> - add Haibo's review tag
> ---
>  drivers/iio/adc/vf610_adc.c | 78 ++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 4d83c12975c53..fb7afa91151f2 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -814,6 +814,13 @@ static const struct of_device_id vf610_adc_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, vf610_adc_match);
>
> +static void vf610_adc_action_remove(void *d)
> +{
> +	struct vf610_adc *info = d;
> +
> +	regulator_disable(info->vref);
> +}
> +
>  static int vf610_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -823,10 +830,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	int ret;
>
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
> -	if (!indio_dev) {
> -		dev_err(&pdev->dev, "Failed allocating iio device\n");
> -		return -ENOMEM;
> -	}
> +	if (!indio_dev)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
>
>  	info = iio_priv(indio_dev);
>  	info->dev = &pdev->dev;
> @@ -842,17 +847,12 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(info->dev, irq,
>  				vf610_adc_isr, 0,
>  				dev_name(&pdev->dev), indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
>
> -	info->clk = devm_clk_get(&pdev->dev, "adc");
> -	if (IS_ERR(info->clk)) {
> -		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
> -						PTR_ERR(info->clk));
> -		return PTR_ERR(info->clk);
> -	}
> +	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
>
>  	info->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(info->vref))
> @@ -862,6 +862,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	ret = devm_add_action_or_reset(&pdev->dev, vf610_adc_action_remove, info);
> +	if (ret)
> +		return ret;
> +
>  	info->vref_uv = regulator_get_voltage(info->vref);
>
>  	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
> @@ -879,52 +883,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = vf610_adc_iio_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
>
> -	ret = clk_prepare_enable(info->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Could not prepare or enable the clock.\n");
> -		goto error_adc_clk_enable;
> -	}
> -
>  	vf610_adc_cfg_init(info);
>  	vf610_adc_hw_init(info);
>
> -	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> -					NULL, &iio_triggered_buffer_setup_ops);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
> -		goto error_iio_device_register;
> -	}
> +	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, &iio_pollfunc_store_time,
> +					      NULL, &iio_triggered_buffer_setup_ops);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Couldn't initialise the buffer\n");
>
>  	mutex_init(&info->lock);
>
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Couldn't register the device.\n");
> -		goto error_adc_buffer_init;
> -	}
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Couldn't register the device.\n");
>
>  	return 0;
> -
> -error_adc_buffer_init:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_iio_device_register:
> -	clk_disable_unprepare(info->clk);
> -error_adc_clk_enable:
> -	regulator_disable(info->vref);
> -
> -	return ret;
> -}
> -
> -static void vf610_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct vf610_adc *info = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	regulator_disable(info->vref);
> -	clk_disable_unprepare(info->clk);
>  }
>
>  static int vf610_adc_suspend(struct device *dev)
> @@ -972,7 +945,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
>
>  static struct platform_driver vf610_adc_driver = {
>  	.probe          = vf610_adc_probe,
> -	.remove         = vf610_adc_remove,
>  	.driver         = {
>  		.name   = DRIVER_NAME,
>  		.of_match_table = vf610_adc_match,
> --
> 2.34.1
>

