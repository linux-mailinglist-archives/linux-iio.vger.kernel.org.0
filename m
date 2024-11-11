Return-Path: <linux-iio+bounces-12132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EBA9C4185
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 16:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1ED1C22074
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8491A08C1;
	Mon, 11 Nov 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kQbl2yV5"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702325777;
	Mon, 11 Nov 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337707; cv=fail; b=MQxlkqsBodOvam8XBootMjpBEA4+WoZFyBfRDc2CDib3Lz9qbReKQI/wyy9x7l/NsXEyGsmcefFwUtkaWXV2188BljqMeRDqB0DOeHBNBlYGC2oDQ1+mvZxlT6GvVeXouHtrdWRyhXgnUTyWrP2UL91/ed/nW0L4iAm16ADOTqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337707; c=relaxed/simple;
	bh=rmSj9XK3k59JWdIszW0ki9eAqXNfHcNkCvH8WB4mmp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TqFtWlKWik1jpIx+gfzTfQ2BI6HLoDUgr43M1XkVLTJLQtq5pR1Z+L0JF/Mt8W38QF1p2ELZmr32vc5TYYxlkDvOTqFYdTpT0hYDwbcyvJRWAOqzY3xr5jqkAbnjE8G85WBR5IvfqnYgdoyilW/X/njjjckhaYu5OwPBicqgums=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kQbl2yV5; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BA5PJskPv3bOOiuFs6F96TbcUsuBaSkAh8FJWoV8y93a43GuzEVYrqJ2wWmZCTOHc7F9xQTxIG2q5zVtEjeuOSeUru7LJY/L0QBeYEJl+M5KX937eTNvu01+sJgpXDpy35ume8UJSZ8vL0TwOteg0doFHVwshzD6NQo/Jx1Qtnfzgq2Dw+zoMuTEctQjxzgpcniCMyP5pyNEUH5chyGz4SKT7p2E91UeHGzG2R+RPq5uVTxWLc+3gUFPG7oH3D1d3wqNrATZkMh/yW0YVMhFJxtRHahBhnry/7ERyWGDGxGKs8y/YZmRqj6R6TFBTr5hRLIzb/+twDTdXzLVMx5RrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI2Z0FgW3NRNnl4fNgyXHk0QHdY4Hr8gm8qPc5hNtuw=;
 b=wqLiR2PnJumGapyYv+CKtVYX25SMF7RGPlkyXUX9NujguRJVOaekmy0/Hj2N9JQ/3w2YEfThlqW5oGjwW/n5LDMtZhHCZYj46Jh3shE9A9XakYEMlOZv4Z0ZgZd4wrJtVpVoVsq50waFCA08vwioYPHnK34VkQUn72Buzn/xmgB5qPn0UvOuZlHO0SXxYDiennKFxt0y/iYljO8PN1Yemi5ErVW8j09VmCvrrOpq1tK8LM9sNHk/2DaT5p5ZyTgEyp5ydG6IjPmF8uXGYDlr7DvUVj82tjrsh0F1wy2QM3gQZNbTCq4VFDC+uJcx6ZfwBzNgkSkJhUPnKui1BUfcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI2Z0FgW3NRNnl4fNgyXHk0QHdY4Hr8gm8qPc5hNtuw=;
 b=kQbl2yV58PXTnlnLHxKA4RBqVDQ6A2mV/BoXHdponkh5I1ry5hNBRFjpJjY4XF5IKQI3CFiDAErUGVYdxwrc31JDHm647DzP8he54Ycd0yUTPoobBxtEnQzXYyz6ztVU/lavuB9xhmJagPPsK/iHyHGWtO0sb1tL+aOs0/Heh9IalIbyquS09Wf4ua+A9Q/cJdAFQ7d8+vD7mB1adZA3jmRRlGEJhZr0Vkli0TpiiDFinf9cjgNayTL/sufRUKqPnDgUCVCSbcXLKT80z/mzcUiBmY77m90emJf5ITtH7S/T6+8yvAJUizQGZbYPvcWYanlPPqMR/tfwTngqa410JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS5PR04MB9921.eurprd04.prod.outlook.com (2603:10a6:20b:678::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 15:08:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 15:08:21 +0000
Date: Mon, 11 Nov 2024 10:08:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hwmon: tmp108: Add support for I3C device
Message-ID: <ZzId2/UyzMz+NIbk@lizhi-Precision-Tower-5810>
References: <20241108-p3t1085-v2-0-6a8990a59efd@nxp.com>
 <20241108-p3t1085-v2-3-6a8990a59efd@nxp.com>
 <20241109131604.5d8b701a@jic23-huawei>
 <014410fc-8a4c-440f-a6eb-1fafccc444a6@roeck-us.net>
 <20241109151531.37ac4226@jic23-huawei>
 <76b6051e-fed5-4566-83da-9cbd198c237c@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b6051e-fed5-4566-83da-9cbd198c237c@roeck-us.net>
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS5PR04MB9921:EE_
X-MS-Office365-Filtering-Correlation-Id: 36740d40-4433-4ee5-c0ab-08dd0262ae5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/mmzTeCFkLMd9IZ72WWPeC5bCJXG/MN827bBLubGqKHKcEEWNsxaTsIlxieo?=
 =?us-ascii?Q?VvmgLiP/Yc/tcvXEitOvrfuJcT2a3HEZisyiQxq8E79YqlF5uvmaRyuNKbOl?=
 =?us-ascii?Q?nVOsIfnKNH9DXfoNHuJdPeZwfbG4L6rj7p3ECzYFpWNM+oAc8Tw0tQH2W98d?=
 =?us-ascii?Q?fPLKGMHHIZvpdUIo3FRhUcVJfZcUfLnxiHP0KyLlcFYIuxLRr64ibU7M32Xb?=
 =?us-ascii?Q?W3IldJQ18S/OU06vWlAAgKn3hkqdD4BMfpahc28c0eHdDBlxjF35HreofObN?=
 =?us-ascii?Q?+6b21NzPnLSiTpKWjjLGgg/mAl5LVaceC8OjYG28JpUKFp9mi8f7Wqm4KjJs?=
 =?us-ascii?Q?KiU8ehsYR70pMmxsbr5BVxzeFxqO5yUC3la/C5h9eIB9+PAVaH4ojbSTtdl3?=
 =?us-ascii?Q?ar7ojOx8xBUq4HE8jyIZ9wc33h41/qc9S05mzDpmclYLBoL/q4twfkz+cEst?=
 =?us-ascii?Q?3OHtbrT3rHnJHPIBpRtgYcdycxCo2bz97ZlsrlGfRVP/3M35Q0RA6YhRidBL?=
 =?us-ascii?Q?WKl3q+Jl+xxgPZDPOf8cUTH48zrOOd7jRpkzTRQ8oD4euxFlgumr1WtIoUvm?=
 =?us-ascii?Q?8++IO/XH0UqNGBmdcTABL8DcPjnwMjdgP+Nb9982rnVF2tgdSUL5d7r35HYP?=
 =?us-ascii?Q?MGLmqm/vHPgtZxrtkt1JhiY+lEN5ONOK5ls98FcwQqn22OlpBcNdZVeCrfoi?=
 =?us-ascii?Q?cHavge6BvaqclBcAOZuFe4Cc96sGn/MK3u2BwhvasQ4zobih7xtz98/eo2QY?=
 =?us-ascii?Q?ZrXUfo5qUYYgNovcRDPwGTkWgNveb2zUD6ed4KSe2criB7VtmEJs0CV51SK0?=
 =?us-ascii?Q?i65IxA7upyxP1nECayh1XddFWx1g1LzUYmgtK1IcGxv5PIMdfXNurh650YX4?=
 =?us-ascii?Q?Dtm08gq4nUxhdn+rtbSNOqOwLZ+Ev8LIIQlQ7Ye4EJ7L2wse/aUqVvrQNDvT?=
 =?us-ascii?Q?WWonMKnFf4YJz+jw7ZNhwivYcBCFI70vF+wLjw7KHAru/np2/M/jMmQNWNXd?=
 =?us-ascii?Q?RGlnDaQMr43J/3RksJUre6/kwJHtl+fqEDeKwuJQfkqH9jGJonaxHZEi4jrU?=
 =?us-ascii?Q?9nqqts4/ayW2xgI2F6JUCH3j7QLLJEd9B5dya+rNM8BPCoEAPyGTJ55YKXbm?=
 =?us-ascii?Q?KteaQbYb7Ssjd46gctCpbuMbtQQ2sU/gXElK+nbk+Sx9lbhyO0CLy8CKDIeB?=
 =?us-ascii?Q?xXx3X5CgB0wav6sR2I6HAur3BcQQzy37I6z6o60KbqpnH6n2Ed6FHL0ipV/q?=
 =?us-ascii?Q?ReWEdEsPLdnpqv+m9tfzHKPDOgXkUTK2cIU9/TpCRyln5uJhyvHKZ9O+fiz1?=
 =?us-ascii?Q?UrwJkfH2IZ9B3GjbSALCTiJQMTZBKlJ8XZFOT+Kx+Pf6ZouO5rvvCHh4sPVr?=
 =?us-ascii?Q?k2ML3T7fUI2w+KbvS+c5541w6cVa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vSpc2IV9mMQA2G7nzfpSZv2s9XtHLMJ62zSxmN6zQ+WswAuszGQF+e4Mpvum?=
 =?us-ascii?Q?xrqcqtZO8hVcKP+B0fhGn506/h7DKyTiijPfNjl7z3fCnpCoG5c2/+PRD1hB?=
 =?us-ascii?Q?LlD5kkzdQSGokClFFhg+y09dnK2MW1gGvF8I+ESMDKtuuNuDbrTjrJHnlirj?=
 =?us-ascii?Q?y7k36gYJW13rZPWyezA1JDfhBfoELz9UiOxy5S16YbqKBxSeGtxiBBsZg+zv?=
 =?us-ascii?Q?ySXlWvZl+MSHcn8j9snY6mTbPsn2HGYcFfcUo2O0vQjE2j+mK1waYCW22rtc?=
 =?us-ascii?Q?HXJiYVQC2vRzIWToXLtYn6/XnYeXly2MESkNApgGLhpnR/82LgzPPDGkZvfi?=
 =?us-ascii?Q?egIuifgtXFfpQFHfNRzDCK5roJDU2MK+OiA0VUuuqUmU5R6aTT6HfyYOofAS?=
 =?us-ascii?Q?oBQl6AggvkGJhBF1krG8Or/Soy5VepMDZE7zJlN9+9j0qNd4ajavkoWGzjFx?=
 =?us-ascii?Q?nCLyOtBd/ILr7VV2k/a8faEZ3XTiT57uZoB4vDjhfw+AqmbAfb720nY1oBM8?=
 =?us-ascii?Q?wgn5zz9wW9wuA+tGBz+8jh38lingzY4bCuJS9Jt6BhHOvsJP1uTVZYSorJjG?=
 =?us-ascii?Q?4Fg7tObmRJ0ZruFildUaMe7SB+FSlGBZLZcPDMALrxDAyJpyCMqTvTUKxkEo?=
 =?us-ascii?Q?adL6VhNochCjx3LX5Fv1OJpeiIDvqcvZnRRG6TBHNs8bPnqrpL1yUVMUbkzM?=
 =?us-ascii?Q?I+Hl2LAp4uaTvYHl4bvmLLLudcyN99isFJFLQbWVDgPIZaq6SIl3Eih6pjK3?=
 =?us-ascii?Q?do/Tq9icb7InRzZ2OqzFkI6o+M5Op6Gz/YoZSbnhJO+6M46Z8holiw3T1TGD?=
 =?us-ascii?Q?magYYTUiSf11ubQHzScyZMB5a7caAH4gd+AMEqsBNRFAbLNWs4p7ojjGsEKj?=
 =?us-ascii?Q?aYVSkzdeKO7lvAd6e4ShvQIiedNyZTyrjGMEh588lTWLHg9A5L7957ALkeLz?=
 =?us-ascii?Q?qXC4tD6BtJcEVqt29CtL96hUsf1jc/PlIjm2mH/KtETmIihhUoutRmJHo68f?=
 =?us-ascii?Q?LWjRCLFg1b4Hr3H1qNTawICOWEhFgm0jW69hz10hFjKTWTlceUIMABWNxe7b?=
 =?us-ascii?Q?mcbmDzwTgXodZXMqM+GDk/6J+atDMOhDLDN0tIYswTt/fPpQ1YjCFS0EYdLF?=
 =?us-ascii?Q?3PxkYdYsFR9lTv790Mn6BeDOKa4e9+Tx0oFwUTVWJA9+YfsvFJ1g8KsKAMIJ?=
 =?us-ascii?Q?XrVuXxsSS/T4HO2TseH9v9xgWvbTp1PqQrRYF47cbB4e/tTtz9kPFJyA4an6?=
 =?us-ascii?Q?os89Qlnr44FCQlU/GFY9ylYX8gFN6UieSN/h9Vcmc+hIjKYglWprbG54Bw9l?=
 =?us-ascii?Q?mH3TAeVGcH/0MHit9PpJhPPhUyd4s7bN8wwT8LP+On01r/vmBdjzIKiiw0mr?=
 =?us-ascii?Q?JitpSblRGxr7jFFJdpZOvnAyQ5ABUep4ohVgRziduo8bmGrcWqm9/6Ogo4t8?=
 =?us-ascii?Q?r7uNVXpiJ+JsWqwwsGXKxfR6zdmQykzkZiG4s+dK9m0JOI95M/wgmu+a4kFV?=
 =?us-ascii?Q?XYjnU85IVxUOPP3B86Sk3bmPmhHp9YQdZxqHcoktedUgJbR46fh2AHsbdw6P?=
 =?us-ascii?Q?AGlztiTkgEvTcUmfqwYokzEVneNji4iuiIzbmMx1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36740d40-4433-4ee5-c0ab-08dd0262ae5f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 15:08:21.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyGUwjuYmgIgKfH40PTm9fydks1gs75SONk9xYXnVqO+5IIAgMOrm0lXzP5JAdCF+x1Yvc/naTRexrU5N2Le7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9921

On Sat, Nov 09, 2024 at 08:18:13AM -0800, Guenter Roeck wrote:
> On 11/9/24 07:15, Jonathan Cameron wrote:
> > On Sat, 9 Nov 2024 06:53:28 -0800
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > On 11/9/24 05:16, Jonathan Cameron wrote:
> > > > On Fri, 08 Nov 2024 17:26:57 -0500
> > > > Frank Li <Frank.Li@nxp.com> wrote:
> > > > > Add support for I3C device in the tmp108 driver to handle the P3T1085
> > > > > sensor. Register the I3C device driver to enable I3C functionality for the
> > > > > sensor.
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >    drivers/hwmon/tmp108.c | 31 +++++++++++++++++++++++++++++++
> > > > >    1 file changed, 31 insertions(+)
> > > > >
> > > > > diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> > > > > index bfbea6349a95f..83d6847cb542c 100644
> > > > > --- a/drivers/hwmon/tmp108.c
> > > > > +++ b/drivers/hwmon/tmp108.c
> > > > > @@ -13,6 +13,8 @@
> > > > >    #include <linux/mutex.h>
> > > > >    #include <linux/of.h>
> > > > >    #include <linux/i2c.h>
> > > > > +#include <linux/i3c/device.h>
> > > > > +#include <linux/i3c/master.h>
> > > >
> > > > Seems odd you need master.h in a device driver.
> > > > I'll guess that's because you should be using i3cdev_to_device()
> > >
> > > I assume you mean i3cdev_to_dev() ?
> > >
> > Indeed! :(
> >
> > > Good point, but there are not many examples to draw from. The one
> > > existing iio driver (st_lsm6dsx) doesn't use it either. I'll send
> > > a patch shortly to fix that to prevent others from making the same
> > > mistake.
> > Excellent.
>
> In this context, are you by any chance aware of an USB<->I3C adapter
> wit decent price point ? With more I3C devices becoming available, I'd
> like to be able to test at least some of the code with real hardware.
> For I2C I use the Devantech USB-ISS adapter, but I have not yet found
> anything comparable for I3C, at least nothing that is affordable.

I have not find usb->i3c adapter yet. you may try our qsb board
https://www.nxp.com/design/design-center/software/development-software/i-mx-93-quick-start-evaluation-kit:IMX93QSB

There are DIP header for it, SCL, SDA, GND and POWER.

About $311

Frank

>
> Thanks,
> Guenter
>

