Return-Path: <linux-iio+bounces-28026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493BD3BB1D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 00:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F453042FEE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2021AF0AF;
	Mon, 19 Jan 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SxMuCmWo"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D26FC3
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863646; cv=fail; b=MOvPxFu4j1vL3ErNsWuHCoTLeVxoqkOetczcVrP+8t5OhGXlCuPhyRX/rZBCL/kQPNJ5VjkZbf6kM29DlE6E/DEdmGEqcqGrT3orY/14yshkh4KL9N14aJDFTfqK4Dnp3qT0H/YwEPcTJdGYhbpN9+reeFkZl7/I90cBoLmzHRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863646; c=relaxed/simple;
	bh=KYzZ9fMwK2gwhSmOYyF9sVBoifNyG8nMefDITcal1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aqqZC++cspIEtgjFTKK7x8lbtw20xdGqhUZ2Fj8XmB3QMoI6TzOJDLVJR6vG/tCB8/Wmv88SOo+qrd6KAGvon7W2kZpvdwXNVdFVpgJCNuAvM+n91Fiu1j6cVTIK6DXB5j22JTomIucKGX0mqfxu+zFQagGfetELg0HIdK9nSAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SxMuCmWo; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USwO3Ddalr+SSn3EtcYJVmVrCZII9lJGAWmDK9JXgA7GsuCsgwI53p/I9YVMe/J4GnkNjeflb/yHBUBx3xC2htUW4VXggECYBGeyNUNMu5lNqq5uGCeN5xztbx8bTJawtYdSFRa4KT5tidXWDXUcW8I5H6uCknDNrXjjPB29gENEnHQUvQ5zrFh7BLlcSxZQVujZCWwiBnH2bSpDqRS8QysRdRjoj+4tBx26KZE/V0RAkUCOcig+M200J07IZE6njQD40UBRQYkyCFN0tCRJM4SiRz5nwQSASv13t/xAczlla/1nWzeW/KxcGhY2Qfj2Z5bDdFBhfCad2owxQg/jOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfw/HP/ZF2QUYEcZcrlh2+1HopdRgf2W6g8IZsLFJng=;
 b=X0/j++IPsHK/VxMY4yyF5OcAwRvaldkewQLs2NTji+xTrqyfNWPWX+3VBc+215QKSgVf5YNJms7KD1BxGOOHsnLIVW2X5okJ3ZDTfxc9rp2b075xESda4TRAqqMFJqTLDmhAHsZhWcaqEUbKFJUC7muWxZxJ3wxgY0OneIy+JFLT2DweSMKYQLdndldTiaEUlbCeRowBh6TanV8AXjDy5SVupRsawg/WvZFbQ6phSwbcTLFLphz+GNU0T6WTiJAOIJhscj3xCc+33rT9uDErGwpG/W0RC0yasPRiGluKnYFFUit234vAY0ByOKJaOKEce9CDHOHRgg0567AqeSAvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfw/HP/ZF2QUYEcZcrlh2+1HopdRgf2W6g8IZsLFJng=;
 b=SxMuCmWoNrG5yb0WXIZnWc8zQEWsMMFP+WfafQ0dgLEQU9sP6VLLUJ7DGKOnd9ZTkFeXTcJKzWWhBGA5hlcAkNr8/tegyLJNx3UtjAymOFjSzX7Bn6Buw89Spp3FcSzANkUisc6QJQFlHLSeDCmdrtvOs3WjYSJORu+NVnaqusLXryY1gSi/in8OQ6IUGZWo/2XBoJ3/R2Aow3BNiqeDQFJ0+1f4MH7wUuxTvS539VUYBSMIgRDGWhr4NU+7STHaEi3trKG3WoJoCZGH1RTShcDWN5yfYULXaDn1BL36rY+fXjllKgm6hLqwBuRkU9jXORyghRYqXXyHQ5pJnukDdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by PA1PR04MB11381.eurprd04.prod.outlook.com (2603:10a6:102:4f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 23:00:41 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 23:00:40 +0000
Date: Mon, 19 Jan 2026 18:00:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] iio: magn: mmc5633: Fix two build issues
Message-ID: <aW63ku5ucSq/cXMZ@lizhi-Precision-Tower-5810>
References: <20260119221736.804825-1-jic23@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119221736.804825-1-jic23@kernel.org>
X-ClientProxiedBy: PH7PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:510:174::29) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|PA1PR04MB11381:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1a67d6-4e6d-4081-090d-08de57ae915d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3AYvDsCOr+peudMxjK3tJ/14MDxKt+9UJyK+NM+c+qtxjWaCsGXTLNYcBNNv?=
 =?us-ascii?Q?7p1uX6626mBofwos/7XWcxRV8IXQQnE6mmVo9TrqgaqnlOeajchIG8iLdXWM?=
 =?us-ascii?Q?H5KNKt8a+b/hvBADaWLuru1jSw+BaA2bRJCm4uBMWVbcQmWdvH6dxHJv+/SM?=
 =?us-ascii?Q?Kgi53+Lpfi5o4kVz6si7sMME62/extcJeBIECF1RESHp8IX82QtcnKohNwLN?=
 =?us-ascii?Q?ek4kH0w0Uwu1ooQBVkNeklFi418Y1mHjbXO5skjBvt+3i5i2MHLPBTkBi6if?=
 =?us-ascii?Q?NaJJ2Q1IrnxAd01R9ydnwBdBAMA6G5eQnrPlvbWiJ9wMiHKNA/SA4lva6sVS?=
 =?us-ascii?Q?brYWWaeOjgiygbJSpDLcKqe+xhgfHBkzo/33tLeISJuEvfigQ3hHWx6Skk9O?=
 =?us-ascii?Q?C2m9th565KXA0CCi6zUKkzGR07Zv6X1fOeO7oOrnzB80cMhnzSVIe1orMVIj?=
 =?us-ascii?Q?wwzuD3BJBRGUzvPtxDr+ShtMa3XkvQKCboK9NAL854fd+WjwRLurO4+yra0F?=
 =?us-ascii?Q?5+7QjvplsS5SdEEykXypnJ5dsAMnoLPo3RL5j1dhElWXtIqEzdX/N+Ubwity?=
 =?us-ascii?Q?WOnBc7qek42xS9yD/FyfyIORqzl9s2JJRgs24YxDs7x7kvFTsItjbObcGFU0?=
 =?us-ascii?Q?HoUnCOKwdSLRIv0ENylp0hrkdObA9/ug+wW9wJuOvdhMYsV1BWQAaQBcSOrf?=
 =?us-ascii?Q?cpIn2KT5oYSKgZBpugx4TOfAPV/lcl7An6pQ8PPmA4B1oDtFrAscvURT70jn?=
 =?us-ascii?Q?rbULSjuafqBs6UcskN/B94mGILCiO8+uxj/a/ZjWeHSqDSwplvBgibfvbb9w?=
 =?us-ascii?Q?8Jq5orXwP4MScMT4LH2nVTARkIeh96ZmINhgyHu+zuHweUxoT/90X9dyP8iq?=
 =?us-ascii?Q?+7VjOjC2aaJRuBxvDARpsUNk7ogGXt2XMGtA8LGJYFO25/sOu120If/4YfWh?=
 =?us-ascii?Q?My0WyP3cJqTAZC3lHSaQ2SNxYZOQV4MtbDzM92jPXJvtYLRmkE7n0I2suXAi?=
 =?us-ascii?Q?shHD9g1eqJCdASuJx3NMZCHq1t6pSEeCoWnWnl3qYBBlrjkzZ+ymHGZZmGfZ?=
 =?us-ascii?Q?DHu9QUDJzmmMktoBcnV2w8WEpi9djyIA3ItRUIDfO8KrzM7QOrz5qQS6yGsN?=
 =?us-ascii?Q?xjfX1IxjGo8+grNzyBL+hovvM6qrW5imdJfoy1o3CTo45soGBZ8UxgFMSTXS?=
 =?us-ascii?Q?lLrPTcjs2bpCWvEF3pWZ5tDj/IhLXvdGHhCka2LgQVh6ZxWwoD+1IkTKsr9I?=
 =?us-ascii?Q?WyjT/HJKN7rurK37g1Fq8A2xWGrvTcB3QxrXoLJMzJCClIgNNTo/V5LDC2o6?=
 =?us-ascii?Q?vEbXEk7C2dqtMrsu/Qtxe9/a5fZ/OQchB50CKn6ulINnOCZ7qKXTkAsObDN+?=
 =?us-ascii?Q?FgmOC+WtLPHFTTF4fCzce11G+TQzI2Dek3ZTpXALcuXub/UO0mS4FC42C3RA?=
 =?us-ascii?Q?cY9S+Q7ClhkbUwXL6MhBVBqUx1H8t/xBC+KH9msBmRaMYwbT/RYWZRWiuCaK?=
 =?us-ascii?Q?gMqYx92qdRvMhKHXkuuDKVviU/ogQU++UYZklk6aIZVnLBG2C8jmthxY32uI?=
 =?us-ascii?Q?pl+wJ6vrH/XKtM1vxdZV35helm/1Ajy9NPKCeMMdKNrQ47iITVY6K+OVNRUo?=
 =?us-ascii?Q?GYZrIkH0AhNREcqxQEVN4o4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3hN+Ma9QUAX90lBx+Hx0iN/pRpIFEni7c2+wvI4JG2TdEiVeRxmw2IpB7+3?=
 =?us-ascii?Q?OI8E30FCC3y6XWIc8/FsW9Oyi5kHZpnZjHFdcblkwjDKeofLNMx/wQVWXYFc?=
 =?us-ascii?Q?RHAuoP7+wS+RBcy9nLbrFuj/pzlC044KwiyO0trAmxinZkI2N6z/sCMUVAIF?=
 =?us-ascii?Q?Ruwhf5QmCDstHNX34v4dgaKl2b1HgetdRWpa7+/1GuqGZCTGJZ7FK20CX6JU?=
 =?us-ascii?Q?SRKhMj8ZdUiPfiRWthamYm4ohkXBAjZRiIVjlf2M1QLmGHRBWvovq37hi7az?=
 =?us-ascii?Q?lbIbXgwbLxuzt6jy/LeGlAIF9cjiC0uaiRyaZu6jGE5zJT4u9X9fd+jToQ63?=
 =?us-ascii?Q?VGPAMEUYZEFiFGN+xFp9NbT2QUjXKdhZuFEhpMlXLiRMNz3iLstcJyEJ8JJP?=
 =?us-ascii?Q?vW3vi52pP9cXACJVf77ZvBQIgPBEDc1OhZhykrqepN3Hf5dpwThFpr/rLuM9?=
 =?us-ascii?Q?JvMCwZr7VnIw//ZOr6FCr7WPekyS0y1xhsVZ66cbhAC+nFXd4DMGowVGaTQ3?=
 =?us-ascii?Q?ZU/pnqoukOtlWVgl7E2It1wzH66ph9KQxkIeGUUVJBO0qj8Trnu0gaakk0/E?=
 =?us-ascii?Q?0BPIL4ULCxtMDG3zg/bVR6wPzb1By7VbZAAVyaseHI/0jlcpd2QgR5JIiuVQ?=
 =?us-ascii?Q?aKzcqaSRCoCsLzsANFzQMmJ2M76RhO47ttbCvUehWRC+CfsRcbmcZirYZAnE?=
 =?us-ascii?Q?p5s+gZqvEl8OboQB1q7WUHnvJ88puodY9tIsBl8I4oDgSwO+V6keGmzG9LF4?=
 =?us-ascii?Q?WDLT5X/XZdmFFsOy24cRDX+alXCvxwP+SgMrZoGuUA/X9PuWklOm/UtSTuDx?=
 =?us-ascii?Q?pwCTQd7JnWYwmgWJ+tV5FVz/6fmYJiQ46afd+eEXKfd5j3FuabHvnaFmYQMt?=
 =?us-ascii?Q?LDdcfq9CgFMyCkFiYuc66Xxm78Zocnq8p/ed+LwZnOYKCaicNEUujdor+QaS?=
 =?us-ascii?Q?BfNra2Ffxj0/tHM0dxqsVOIQ50QrUiByOe+REl4HEia1+ia2XVovByzZhQDy?=
 =?us-ascii?Q?Ve5aJka2riapijR6+96OMjVf54upGdPHEti4hCwOURO4I7KcgbVsGrNr0d6H?=
 =?us-ascii?Q?PeA0znUegDduIf2uj7lFW88kzrAVj/nYrVHzbtUAFLH6GPXj4N+AzL5lYN4p?=
 =?us-ascii?Q?CSYiXoXWll6Z07njBCa3EYUITrzqd7YQg/nbpzaLpWwdXUaEXERs60CCMc6n?=
 =?us-ascii?Q?ffwK5WxX1hxr6evKRQb0I1HXYfzSTd6MsC8hLOc8gF66Q7FINiQ8Rf7LRPJ4?=
 =?us-ascii?Q?koZ3RlE/ZWbNcJwqNR2cz7NMSNQQqQxNxkh4xBBC5s+B9UHlVJ8uybRhYC+z?=
 =?us-ascii?Q?v88YsE319azJi0jtGc/zHFb94IQ4cZdeUSjSnrmqWDa0hwRL101oQ7QGfm6E?=
 =?us-ascii?Q?6xva0K8ZiDUfDVmRzKOIeVgbd5WmXr+anSf0EEdp2Ve1mBtR7tPypl0sOZ7g?=
 =?us-ascii?Q?43mQyQma7qTAKyP7nKcuYFv0q9ZEsSGXxcPTC3fEtnyyySqwbNhozN7jVm/a?=
 =?us-ascii?Q?x2v9esuG5W1hPzE0l0EE89WoDvxnjGb8CwJ2dJ2rQdK3Lv24auQk7Oz84v2v?=
 =?us-ascii?Q?79tzrY2X0WLSiCVwoVUDM0X4HvBCwI+Ed1Okdlkqj0rKlChkAEH8+G5fr8tW?=
 =?us-ascii?Q?+sRHDAy8pc7mWWjXXCRfPrQn6kaHvS5o9i6Jb/sTIAoLKepWxpAvV2F2Hd7j?=
 =?us-ascii?Q?u9UuSMF1UYhjnFhZoa2Pehds+DC2rVpQkc4kWPkVOx41VH+C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1a67d6-4e6d-4081-090d-08de57ae915d
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 23:00:40.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +52Q7XBB05k9Sv4VKdleMggUaIHENXus7rkn55D5ja2t/A9otdXVcPNOfrLv9rOapX99OuX7HCrbZmhFQVpB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11381

On Mon, Jan 19, 2026 at 10:17:34PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The Kconfig  issue was one I came across whilst testing the second fix
> which has been being reported by the bots for some time. Frank posted the
> full fix for the undefined symbols a while back, but it is merged in
> the middle i3c/for-next making it hard to merge into IIO as well.
> So work around this to get the build issue resolved.
>
> That workaround can be reverted next cycle.
>
> I'll queue these up now but they can have brief 0-day exposure
> before I push them out on the togreg branch to be picked up by
> linux-next. Even after that comments on these ones welcome.
>
> Thanks,
>
> Jonathan
>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Jonathan Cameron (2):
>   iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not build if I2C / I3C is
>     not.
>   iio: magn: mmc5633: Add some ifdef / __maybe_unused until stubs
>     available
>
>  drivers/iio/magnetometer/Kconfig   |  4 ++--
>  drivers/iio/magnetometer/mmc5633.c | 25 +++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> --
> 2.52.0
>

