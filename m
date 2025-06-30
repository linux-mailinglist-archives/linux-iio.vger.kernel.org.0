Return-Path: <linux-iio+bounces-21171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA20AEE9CA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 23:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2723B7A7D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 21:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535F02367B2;
	Mon, 30 Jun 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NaOouEle"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAF1EBA0D;
	Mon, 30 Jun 2025 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320643; cv=fail; b=CuKV2oEwOzp/eCULgH7xAFFHPpRqbl3m4Mu7+765Og+XYsDveWzNASuw3HL2ws+RnjDqzf6Q02wPyOIGL2kOQ8sIRCXiCItnxdUK7//w6pP+RR2jLdqxUcMQ5Q47XdIGupesaTwolFsSmsOqPuBLHQugXLOUxrAWO3kzH/xy4tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320643; c=relaxed/simple;
	bh=Tfrs51a4eGwLqB7i421A/JzCsuCwI1lXyiJtwkN07WE=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jkxszGLiTVLk618titQXDcWiTzHJFPhwWP7o/DI+lh0h3njcdsmumMJsBEPxxnQzRtltxI7xJHiM+R8pmtF/OmIgLJaiE+UzIfcJBEG/kOnu4y26DMyOYJjz14P08cOA00sBwk3s5YJ5sM5+kWTV+yeTg/yEKkw8rpUcE7j8IZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NaOouEle; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWtWFW/81bQ/DRCHwhvFdY3dyQLAAq9i+SDu4Kp1/IseWYbtneW/Z2JWFJqhroa+w8Q1O1qMtNbiiG/qtwu4S9EtNrBIW6/ux4Eu7o+cDWDUsE5p5p8on8LfxSgPWInkn3gkLMDxx7bOHM5+Kju+lQZsyK7jISH4aD7EphOPHIUm/OvP6Hm7WCbv3rNKv+pX8n8fRe7+q8OyC9hZBnwmPHwAmi9ZeYYSxuyCn7o+OV8dShrc2uQYUOKePPVrrcNOuwlBxKbviK1MyWm7r+ZEBIy8XgakN7WHJX6M2RyeYIhjfV4YJ1kI4izgnS11hwARc6LUg/K9meJjFTzuC5CouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvI5SdHZ2vH6uXPl4tOz/jOYKolnwNoA5iV63jTLY0o=;
 b=XsqSZl5e/pUIHa/aQYKD9sLDR4U2D/kWlgRyFPU+c6QrE0eU4JOvWlJNnEH+jdAxA+p/vBW+x4NNZzs15vmkHuOA3Es7HQT8DcP4hDDo38l7LPSddk2mIOzxTdoxhSnrKoNSWuFWvpLiMz4VnGwT3OTt5FMiAAb+N1coVsHoxq0MRcZa0CPp6g5h1wGm71kjjEQ/qpvzNMgXiFSw0Js73uaq6bYVIMj6p0jtOSizdQ9ZPQleSiiCnkOvDhkiLn4jv2ircjnWq//uHiX+VYFKPkiC0Zhh/0GUjcP5HYXXIv7p2+mpTKphdeUjNvztqsuMakhjn6yj0I6xkX7O0cWh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvI5SdHZ2vH6uXPl4tOz/jOYKolnwNoA5iV63jTLY0o=;
 b=NaOouEleQSEHjwvThvsbcvJQlKDx5oaHKCnNBuUvZ2iRrDGx3TUaPvIpSLpqCRZ4PHIeuMYVJE4mBYgqcU8YR6ju8eKQie5oh+1O44xSznYTpcMLP11LYlax8UdGOVpZicijOz7/mFyaEkdPwlbM5YCACc3RaH87hNRxsR274nU=
Received: from DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) by AM9PR02MB7347.eurprd02.prod.outlook.com
 (2603:10a6:20b:3ea::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 21:57:17 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::1e) by DUZPR01CA0007.outlook.office365.com
 (2603:10a6:10:3c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 21:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 21:57:17 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 23:57:16 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250628181129.08f55227@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 28 Jun 2025 18:11:29 +0100")
References: <cover.1749938844.git.waqar.hameed@axis.com>
	<5d12fcd6faae86f7280e753f887ea60513b22ea9.1749938844.git.waqar.hameed@axis.com>
	<20250622120756.3865fc4b@jic23-huawei> <pndtt45aq6m.fsf@axis.com>
	<20250628181129.08f55227@jic23-huawei>
User-Agent: a.out
Date: Mon, 30 Jun 2025 23:57:16 +0200
Message-ID: <pndqzz07v0j.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|AM9PR02MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 328cd627-b722-448e-6072-08ddb8211473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yRMUYH7DaaxOB3RBQhwkSz9lcii561cTns+6x9SV7WJPeIdd1QBuwbCN50N5?=
 =?us-ascii?Q?Pu3aakmNuy1y3sz1/DiVEn74R3jg6sesy7YUdk7XhmpaPhYYpTwSmb3QBEby?=
 =?us-ascii?Q?RHQ+9+RyjJE7YZrJwNwPLeeyuRqaSX8OTNqyxzg26Ty/cvQe74QPvdY/CQmX?=
 =?us-ascii?Q?BSfGNYi7y59NGF0AI4mbOzjfQSnWG60WruwywLVWCIYXeVVt2PIm4BbK3C0P?=
 =?us-ascii?Q?Kb1vAlQl3TLH+EKkgDWR64x1bKzI1NjRZwOfNUVau0PCwVKcmsHUgB8+0ysr?=
 =?us-ascii?Q?MBx8Ka5Puw0Ex5bcCaFRyHIYiweHvtZ+pX2jNJ2mrl4z5ZneAkFsk9817v3E?=
 =?us-ascii?Q?jhMgX69dLEkoJNjebXy7yW/Zw6/PZHWxu+B4LFE9PUYZxjVG9fna4mXGVXQy?=
 =?us-ascii?Q?ZA9/3eoYVrT63ItcZoou156vWJOnCw3qI8Bm/VP65rjbGrzK9Ba9/AZaaNj/?=
 =?us-ascii?Q?Vvk+bsdqrRGmwkuwflOLodUWq4+4aazD+oiRxMcjn/tUOGPu0j9G5XUvMwC3?=
 =?us-ascii?Q?7MiRqQSWPQHo+dPbMGZ0IVizMQpvX1QQxNxZcxRRV4i+vRrMP8KcpdbXeIee?=
 =?us-ascii?Q?K+b5XU+4WlrdUUNn2bCoMzD4iATKY0N4NbkdTqwkbU65J1qGEGNd7CtePsrw?=
 =?us-ascii?Q?dHBcCWegjh8kfLACwSPW2FNhBmBYocDDG8cgK7qPPkuUOmFA/PYzVoInb2DW?=
 =?us-ascii?Q?yi2/DFAW77eMyp2O+WddAvbpkYpkw7EhAl7Tw1fqMqjG98MLx+s8fmhXuYpV?=
 =?us-ascii?Q?qhvIjcSHY0GFU0B8GbAObNd8/A26p31Jgdj2JqsyqoEJaxKf3++uVR3UyFpy?=
 =?us-ascii?Q?SknNWPmAHMrp1rln3M8imyEBcpgkn/sirCe4n6eXksHEt3y8PSZDMc81wNuE?=
 =?us-ascii?Q?ZuB0Y+40CMSKhIxX7XPKT15N3DFA3DwzXqua1sLtRu32hi11gLeHshmsyC5N?=
 =?us-ascii?Q?5ziAyz+G0wnjw3+rLtcMuXVO8T2Smf2AFz3MkAIE0RHJEFKccVwig/4rQejt?=
 =?us-ascii?Q?Fpvnfp5PO7qT02GRCKX+ExFr+RlnoxbKmAFWFFTS02NZyoZro9dukNr9m+SZ?=
 =?us-ascii?Q?+W05NoCGxUEVKx+3A1x8pQc+2bxHoLbuskPwXfP1d2ngvLL0IwLgeEY2ZxAJ?=
 =?us-ascii?Q?VY46IFXjTcogvO/KlI7OHV11dEQYVXuhn9178aOln+98CpZOH2BmQ5DJwgJZ?=
 =?us-ascii?Q?I6oeHdwcUZMa8qaKbpLJ4mZeCezpGzMzc7x8XD8u1ZGubeKPpgVDRigZMskY?=
 =?us-ascii?Q?ldpr7ck4VnhAryaXWh7q8M5FyDEfOnpirGNpTlPlKCve5C6GlkDUzDYyHpLv?=
 =?us-ascii?Q?Wa+qT6D3aEo4AHJuEYhHnyCHPf67QMcrj6FGQGHPGqSbNilyal86TjwDXAQk?=
 =?us-ascii?Q?gZdRf+TRRY4Bor9eVrkQseuFDc7X8d8KGe0chV2XVl4I/TRnd0GGMhyacBNK?=
 =?us-ascii?Q?0EYjW6cVAzNVkr4LP2fF83TLCwVIzPNm9rIuERsxAve2zeO6PgnECQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 21:57:17.2512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328cd627-b722-448e-6072-08ddb8211473
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7347

On Sat, Jun 28, 2025 at 18:11 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

>> >> +static int d3323aa_set_lp_filter_freq(struct iio_dev *indio_dev, const int val,
>> >> +				      int val2)
>> >> +{
>> >> +	struct d3323aa_data *data = iio_priv(indio_dev);
>> >> +	size_t idx;
>> >> +
>> >> +	/* Truncate fractional part to one digit. */
>> >> +	val2 /= 100000;
>> >> +
>> >> +	for (idx = 0; idx < ARRAY_SIZE(d3323aa_lp_filter_freq); ++idx) {
>> >> +		int integer = d3323aa_lp_filter_freq[idx][0] /
>> >> +			      d3323aa_lp_filter_freq[idx][1];
>> >> +		int fract = d3323aa_lp_filter_freq[idx][0] %
>> >> +			    d3323aa_lp_filter_freq[idx][1];
>> >> +
>> >> +		if (val == integer && val2 == fract)
>> >> +			break;
>> >> +	}
>> >> +
>> >> +	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
>> >> +		return -ERANGE;  
>> >
>> > It's a patch not a range check, so -EINVAL may make more sense as
>> > a return value.  
>> 
>> Hm, `ERANGE`s message does say "*Numerical result* out of range...",
>> which I can see is not really applicable here (strictly speaking, we are
>> really not "calculating" anything...). However, isn't `EDOM` actually
>> the better alternative here? Consider the following
>> 
>>   echo a > in_proximity_hardwaregain
>>   sh: write error: Invalid argument
>> 
>>   echo 1234 > in_proximity_hardwaregain
>>   sh: write error: Numerical argument out of domain
>
> I'd still stick to -EINVAL as correct if not that informative simply
> because EDOM is very rarely used (wasn't one I even knew existed
> until today ;)

Alright, I don't really have any strong opinions on this. Let's use
`-EINVAL`.

>> >> +				       data);
>> >> +	if (ret)
>> >> +		return dev_err_probe(
>> >> +			data->dev, ret,
>> >> +			"Could not add disable regulator action\n");  
>> > Odd formatting.
>> >
>> > 		return dev_err_probe(dev, ret,
>> > 				     "Could not add disable regulator action\n");
>> >
>> > It's fine to go a little over 80 chars if it helps readability and here I think
>> > it does. However it is vanishingly unlikely this would fail (as it basically means
>> > memory allocation is failing in which case not much is going to work) so
>> > common practice is not to bother with prints for failed devm_add_action_or_reset().
>> > Those prints do make sense for devm calls that are doing something more complex
>> > though so keep the rest.
>> >
>> > 	if (ret)
>> > 		return ret;
>> >
>> > is fine here.  
>> 
>> `clang-format` trying its best here. Let's just remove the print then.
>> 
>> There are a bunch drivers in iio that are printing in this
>> devm_add_action_or_reset()-error-path (though it looks like the majority
>> are not doing that). Probably not really worth changing those; in case
>> someone would really "miss" the (very unlikely) prints.
>
> If they are doing dev_err_probe() it won't print anyway as that only 
> returns -ENOMEM which dev_err_probe() doesn't print on simply because
> you get lots of info if a memory allocation fails anyway.
>
> https://elixir.bootlin.com/linux/v6.15.3/source/drivers/base/core.c#L5017
>
> So on that basis it would be a sensible I think to do a cleanup patch set
> to drop that particular devm_add_action_or_reset() / dev_err_probe()
> combination.  If it were just a case of unlikely (rather than impossible)
> I'd agree that it wasn't worth the churn!

Right, I'll send a clean-up patch for those then.

