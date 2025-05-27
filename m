Return-Path: <linux-iio+bounces-19969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F59AC514A
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9359C1557
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E6D2741CD;
	Tue, 27 May 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Oth/xoUG"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBEA17FAC2;
	Tue, 27 May 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357318; cv=fail; b=Nb5Fwa17UJIrz8jMf5XDHzrk6WENM7HAKrA5PLx5vgpb5dqWr/O5XL+BluoD2NJFBgB168rmAOb5AegfKKtLNO1B4hPdr2Dmxg2BbJTQCUy05fGIJzsiD2a69IWJF2o+gbeJ29pMsnR7uc+n9p5KT8x8dxrOlmgFtonlSDdh89Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357318; c=relaxed/simple;
	bh=p2qe+GP4imkOreMDjKJpRvbhwK2wt7qh4dQCecAppGM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZQK558WWRyx0mf7N6a5K0INDN/LqRpKwHValXoJEytD5TYD6po95y/P6Zyzae2bPbdiBFH8SGydkmQenE7+Q+DYENREnGAuptcrlMvjMr9CToO9jwMnJYZt32rPlIHuwKlLPY2kes4vygtnjAmol9b2MNTG38lxCEOLcS+0Slg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Oth/xoUG; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYA9U+KeTRFIGec2Tz5i8jfagEs3vXJ2PJngjTssrOHOrhTd9qA6LKCrgQkA0++TTxS/F9HsYb7zJP2+sOlB255483noNXZ0jtnM1np2BuSvRtbZM0F4w/5VjlhgCpkQZTYLHIXiOVTneNTgFrqjgv6cjsZ0Ja7Za+IPE7cvIZ1t967DVJMKYD7UIL2h8xEh1hYhqD6dbpaRsjFEkCHPBySBLp2mO+Q/Yi+ipVqk7ZO0xv2PI8JCC6VZnnrmF1KS4wt622qAaOlBGbQ/KrB2srpEXRIuyopuP3DKaRN1iNEVp5WchXp46tjlLSPcAr3S6O7rLNHzYZsuXZZR00tPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbdsz/fDQGSRqmy70q/hX6fVtERxJSYSUvfW7/g9ch0=;
 b=Un3vv048eqb1hUqWZaha+B18A/+Fm191v70PcrYNhz6fb0U3YcJ5Y+HMkC7hBDjkIEF92+GGwmMwVQUC+NNqVk2gNz7pNd6ZHUaHdfmuNkup0BRcwLFQKrP0xze+yBwoIOlz9E+BNxMsut6SzsciITKi78HOu0Ocw7Rh/vOEt8d2BM8zmTsqhNlf++gJFelFIJKEcQcv5Mi9hX7CZAciJQkfTYHn8LtBhEJmmqLCnofodWxRo8qoc9YpIqtgtwRAKGA/sPLHJBo8e0M9pe+5nTWMcc1JLZSd0DLbkU7V0J7cRXGY16RgMsLyZLkDbQmbmdjSqaEgXqxLawJQW5TeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbdsz/fDQGSRqmy70q/hX6fVtERxJSYSUvfW7/g9ch0=;
 b=Oth/xoUGV/uyrd37h4hr3c8ER4PxRt2WVTJf6JT5a4Vo7WdBxKtewBK/rsMpPN+5Qc7sdVMdIXIn3B6/0yId0/D94ZYdg7RPl8o9DvaO2m6yvwldLE59JWMU2x/3XvN00hYF/94gunPamP035+yob4e6prVKMmxPtFwhGCmBen0=
Received: from AM0PR04CA0079.eurprd04.prod.outlook.com (2603:10a6:208:be::20)
 by AS2PR02MB10196.eurprd02.prod.outlook.com (2603:10a6:20b:62d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 14:48:31 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:208:be:cafe::48) by AM0PR04CA0079.outlook.office365.com
 (2603:10a6:208:be::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Tue,
 27 May 2025 14:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 14:48:31 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 16:48:31 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250525103019.3773be94@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 25 May 2025 10:30:19 +0100")
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei> <pndldqwiihi.fsf@axis.com>
	<20250518183852.7e9afdac@jic23-huawei> <pndo6vnfrnp.fsf@axis.com>
	<20250525103019.3773be94@jic23-huawei>
User-Agent: a.out
Date: Tue, 27 May 2025 16:48:30 +0200
Message-ID: <pndecwa85z5.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|AS2PR02MB10196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be81010-9b91-4ab1-70f9-08dd9d2d8cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQJq48crAGPU5zrwrrLwVO0E/b3QRozIXp8HPCtJia7jrrFHDvb/3XfzMNVp?=
 =?us-ascii?Q?/bXt5kwNy8HzdHsfzDcA2DsEgajTl387KIN6mcfEVRghtAhsbTCWxJBwspRm?=
 =?us-ascii?Q?Z1g3KTaFXMsUofapiOmUWwdqCTT66bf6oY8nF1oeinqIa0vBP6ske7cVHO7t?=
 =?us-ascii?Q?yCSgbclw0rqMXAtictHMAs4qFP0/vmtPzYH9xFpGEF2RochEPGDjJmuRJ4PD?=
 =?us-ascii?Q?FVpFkIZdy7OyGYu7bycSTNVD/oAVxxIlylACRN8EpunIKeNkRPWnnIkO6ejn?=
 =?us-ascii?Q?4iYg1ixp/rCaXJ9sw+327X1Ur63kSfofbJzFyzIvZtek5J3aEe3nQZMvRSvh?=
 =?us-ascii?Q?Jhdt8LTcq2eqndptmcetyesZ4ykyhJm0gnuOGTTAXalq7Dh2tqRbSABlpLnb?=
 =?us-ascii?Q?MudzWbJW3HBiTvSNNk6TR68D3u7UCe3+e0DneXclry7S3Iw9zkoDMal0ClWh?=
 =?us-ascii?Q?KY7A2t3Lwctl8e7fb98EOGOobYijU5wpLGGF2ozXpSU8xIqC9pkACfuKO53T?=
 =?us-ascii?Q?T8eKwBRZ8haXlkzYUNX0vPKAsapSiYwR9X1EACHx74T+UU0cqyVc1TqpaCph?=
 =?us-ascii?Q?Tl00ssY9HMGraiEOa32nZ7a2dPSIlO/WfIUV34LMP2+qUeyDcdJvvcYFCyHq?=
 =?us-ascii?Q?Tgk+/Y+9hwinmZ6HcP0STNUcvfjiNpJHzb1L134wFsP6uB2Dqx+aN1FfuvIY?=
 =?us-ascii?Q?LhEcwIDD41CCRskk5kujBigVmsLeOHj4tSpoZIMHIqfpLrWW57xVX12sAApO?=
 =?us-ascii?Q?iO/DQoeq/QwpgQuwVu+ZDnu+9LYSNfxHLQZsPn/larHCZ7A47LBd56Qu8mte?=
 =?us-ascii?Q?cLMlNQGX5bRfpHuFj4mypaj6J0yosP4G2o/0bik5gXbFLri+UjP6oVY4cUJq?=
 =?us-ascii?Q?x+wejEM2IHUfTaHV6JnfLNn/HTNzFPCC4snd1Q2VGHrmQN9c2bvd389tt4GZ?=
 =?us-ascii?Q?n+V8GMn8LJZCmFTEVhWQyK+SKde1woRaGFQ+peyWoBZViaJikZ6dlvNvovRM?=
 =?us-ascii?Q?UvgwsEZJkCVP+0R1EuKV8CHguU4dlcWgw9O3zZC1Tk9ubhTpcT9oqwAQym6n?=
 =?us-ascii?Q?5swrNsSDaKiXsBJf7fywv55YVR4xkf1owcnOGiRqD11D8fuYzh5Hg4i0lCJQ?=
 =?us-ascii?Q?DjFbj8Nyyl3s/ye0OLiWZG9+R59JzKM844bU9B/5pa3FBf3mdakZo5BMyL4q?=
 =?us-ascii?Q?1eKcttv3yUNOLyq2uv/pwT3zKhPuq60D0tfkz8u+uDd+zetnFgm/3UJRUnPB?=
 =?us-ascii?Q?wN3oWKrGhqrZ1aQV84PzDwasJXsec2IpV7iNviKEwp5qE01m4DQRClM4KB8J?=
 =?us-ascii?Q?GYhMfe/tOjKH3s9P9wdIQlrWiieTardtume82Z80Gu4XVIuqkMO+y1Q2z2te?=
 =?us-ascii?Q?Xda/d3+kGiqLWy4YE/kzCHDN6mIAlq6vWz/qae16v0FjtVyYMWIL7JxUZQju?=
 =?us-ascii?Q?TMjocHRROlYPbrEW0apGuOIWR7zBPjJ8UQs/bCVwT2ivj7n72WMScJ0VrYGC?=
 =?us-ascii?Q?A8A12USV4TO4aqlKjZa78/rPghkXobaSho7U?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:48:31.8004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be81010-9b91-4ab1-70f9-08dd9d2d8cd6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10196

On Sun, May 25, 2025 at 10:30 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 20 May 2025 13:27:54 +0200
> Waqar Hameed <waqar.hameed@axis.com> wrote:
>
>> On Sun, May 18, 2025 at 18:38 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
>> 
>> >> >> +#define D3323AA_DRV_NAME "d3323aa"    
>> >> >
>> >> > Put that inline where used.  A define like this both implies that various values
>> >> > must be the same when they need not be and means that we have to go find the
>> >> > define to fine out what they are set to.  Just setting the strings directly
>> >> > tends to end up more readable.    
>> >> 
>> >> Sure, we can do that. (There are a bunch of IIO-drivers doing this, so I
>> >> just thought that was the "convention".)  
>> >
>> > I'm sometimes in less fussy mood.  One day I might just clean those up
>> > so there is nothing to copy into new drivers!  
>> 
>> A quick search tells that there are (at least) 105 of those:
>> 
>>   rgrep -A 30 "\.driver" drivers/iio/ | grep "\.name" | grep -v '"'
>>   
>> I was just about to write a small Python script to fix those, but just
>> wanted to confirm with you before spending more time on this. So if you
>> don't want to do this yourself, I can help your here :)
>
> It's probably not worth the churn on the ones that have the string repeated
> multiple times.  However, perhaps any that are only using it for .name would
> be good to tidy up?  Those are less a case of it being 'taste' vs it being silly
> to have a define!

I think if you use it in multiple places, it should definitively be a
macro definition. I just sent some patches for those that only used it
once (I didn't include those with `KBUILD_MODNAME`. We can discuss if we
should also address those in that thread).

However, there are a bunch of drivers that _only_ use a macro definition
in `.name` and `indio_dev->name`, including this one. That _is_ more
than one place, so we should actually leave it? Or do you still think we
should have the same string literal in both places, as you originally
commented above?

