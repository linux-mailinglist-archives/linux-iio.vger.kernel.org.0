Return-Path: <linux-iio+bounces-8890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02167965481
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 03:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CD31C221C6
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1C18C22;
	Fri, 30 Aug 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="QD9eF7Nj"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2106.outbound.protection.outlook.com [40.92.23.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624377F6;
	Fri, 30 Aug 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980280; cv=fail; b=daIisXoubTp3TgAAHItK06bSf88mox1NXWr8hVWVEOmyMnQCADEU0ZlR9CZAjdXzjIFim6PETkYPw2eKLAOTQcw296MjXKR3Mc6mcsQBKz+r69i0XZzdHsCvIw9xYddX4KR5YQjDbgUY78m3RwXAUwQMnA9Y29NWjauPqO+DfTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980280; c=relaxed/simple;
	bh=othu0nH5P/JCuMt9u35Om2k+j1BfLNkDMnz7wL3ZLOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQbbaz+NBqlWRWnLrnYQPzds4tpB+6xK3rN2MWcgvOYSd6jEfttsSRMzFhZor0FSfDXhRg9rI7WMaUQ0AuIzAXOUDAzf/a5ACtGnewnm/thImDImcEqeSoja6vF9Cu2rK6kmXdGZeGDsU5AusZhXtmnh1reRoeQysQEMkkJ63o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=QD9eF7Nj; arc=fail smtp.client-ip=40.92.23.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/VXgVedWcPbFMCofA81tkViA+estYsTDaNK2L9bBuDMNCtT6n0GBkXs7tt6s0p69tXWgn1PhPon8Db2P4Qz9fu4/2VKR94v+8jb2c9vs0/wGPMM9ls5trrHNkUUqbYSYcc5dwOT+/KopLWTeu4GDjbcVRlxMwqOhpQluwUq88D5ySAFBumMv1vzqcfand/BORGrb9tyq2GPlsm1e9EcoGCHN7oa5g6JbyfSyIHgaka3I2kapDWkMU66Z0cmfMgSJN19Bcv4LfVyNMIRTOi6mrqzFdR5vCde5OZ9AWvDkfN8jfKYc8+F0uumOArU34udumg6fxYakuQMoFilxxc06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6KCCyeibgdcAix7HRzas7v1BOzU/c2I51qppCkv9Mg=;
 b=JvVx7RxUEf/+ddAR7xK0p5XxpOJa4UYayb+G5BVhsYuYOVkkZXpcSItqNx7p4fAlfd3QJAr9QdqhdX3Ad7HmuGnoPod6WtslES0S0E0s/3Rjbc/QuTGlFy6qbdHTdbB4S1SbVBj7/ZR3NxfZyDAbbCi1AjxNieVEeP3l1UmIJUIhL6GVFbh5QCYiOLz+fN17gaByqzfyNcL1upC1EoL4Fu+bFoVVxefrPoQTq2o8yaoAEr8hty1jvYiM35MFw+QgnWhVBTrG3RCopg8JzLgSnAnH4jKbuarQCxRNJAu3X6oF+C00Gz/c/tyqu08OfxocXu0uIWx4k8E5ZviROGwFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6KCCyeibgdcAix7HRzas7v1BOzU/c2I51qppCkv9Mg=;
 b=QD9eF7Njqbz08WEBxfqY8oqpK5zeBq2291/T4p7GJ7yk0ni1AVs2ARlhEuFlOCIn5wAQdRLs2GFpl3hFWEwVI6INvbljvcOPxT0ZINQ12fse7WkaCEvKvHjp7mcz3zXRNSYmoLyP6pMY/TZXRN3IN00Kbf9fkz5gkVM5UwkHyV+W2t5K+QeQ5pgMgRPMNZNeoZAzb0nU7w105/+nHxN0Vqglb7OC6hlJFu5QJ7pUblFDJqYxyI+h/I5CxYFf/xwHvWayIEmv5Ae5crQ2OWc5MmjAQYiedM/i8awKl1iaxzVy/P97IZYylqUXPf5zNvUkmyJTc0VmHk1lJrrftYtceQ==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by SJ2PR16MB6230.namprd16.prod.outlook.com (2603:10b6:a03:591::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 01:11:16 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7849.019; Fri, 30 Aug 2024
 01:11:14 +0000
Date: Thu, 29 Aug 2024 20:11:09 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com, mripard@kernel.org,
	tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, wens@csie.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
	jic23@kernel.org, jonathan.cameron@huawei.com,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH V4 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID:
 <MN2PR16MB2941BBB5A36AE70195F3D1B2A5972@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-15-macroalpha82@gmail.com>
 <kpcnvalhcfzludd6ifjn4mkeipihkselgr3e4bzog2zfyap4jz@ib7cg2drpd4p>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kpcnvalhcfzludd6ifjn4mkeipihkselgr3e4bzog2zfyap4jz@ib7cg2drpd4p>
X-TMN: [RbBFtMsfLhEFbXB7q0F8CX4AQshfHPvVaisAxv+NLUQ=]
X-ClientProxiedBy: SA0PR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:806:d0::21) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZtEcLex3AuxHKr36@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|SJ2PR16MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e9c491-c098-40bf-f981-08dcc890a40c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|6090799003|8060799006|5072599009|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	FpOyXLOdU+vnS+0A7sxt5hExD+/RFGWYZ3QmvYDEl6R5X8/9/QRf1fdTum4GYVIKX67lVQLnPDdWTt2J9Rnuuwn8ry6N1uEmxcb4f2HGDvf1JKUv8YY6arNHzoYO+abQX0i7YAjWB0bK+7iQoMht5Hg9G05QwXwA/F04x1uIXKWB1iLSBQB1UxtbzAIVyDJtTPXpG598SWZ9oby9GX0Cus6MdvlRtN8QBYN5GJmevsr2vI+yMAVHChiI+pcZk5T2JNj/nWMAEpDlLkKKLAfuyOhKGh6LhiwxdKuW/pCKeiRRL+QZiS+GnhdXyEQYd1RJg45kFTqhep+cWjIa+Qq/wWIP8XEEL4d12+1B5Y6ReEkzEUcqCsbeLYqrdA6WwkyepN3dJdXFGzW+5x0DTzAVHvZCnjUhn0UGMt2pBsOLpVqFfdUhetciN5WLoUqGu7dVKhHbrOqSJYhCFTDEh5yrLfbWzfuqHAkndFLb/xI41i87g78MEtZAZ7c1PmaFhlbJoMcFPzWc7RGpp4WQzHKH+bbIr9vzEeYN1o28XKpM2N2zZWZUp5Km/WvZ4/csLhyDDXc1hhQgbUZjxx+UFrld4pMXtJ7AuvhqhtwwQgGBN9PBQppllJ6SzqYIHrrJ83nfHefIzpwf5uC+rukGnMMxZmUQo+CHGcPb3SA52t/Sewo51n/rvso3UMyvYBjPnaxekmXRiYxPgMUFBH+jWyPeomvu/nsYYlTnkDqm0HdW0vM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ag/OtyAyDHGHtDibDtGewxz4fYqrqi6Z/c2Q1c+E+mx7XL35ys7ZwdPTWRGt?=
 =?us-ascii?Q?KLGinj1d8Wuum9PVVa8X6HGKaYZLRxW/wGMbBxO+ToHcwyCuacqZsQxHydck?=
 =?us-ascii?Q?TfXtWRQoAOH5qeCQ3ks6UT6Iouv5dQyxaZOnfwQc5oaPm5/RZS57hZywl79M?=
 =?us-ascii?Q?ikxWjgzhaBuzTEOr1F7r+xktJ/KdP4tpcyPy6cqFUF544+p2uMAfivJPPXAF?=
 =?us-ascii?Q?GOOSLdtpA28Na0/hyOvWkBqjKXTz3f2vb50ehtw7mmQkGQVShTITpvD374+d?=
 =?us-ascii?Q?gB/sNBQi9MTk6DxOOQfoXeerT1wU44/ETm5Xl/FmnsqzhiXGHx/lBl9OI/Qc?=
 =?us-ascii?Q?TE7nq4Me50D3YtVS6QBYITMHr46kABPs1yVdFrkfklAqreBsX75vSDxcNVee?=
 =?us-ascii?Q?ZMMFkc0z6dPFDEWlGY7dhyiKnS8VzOTyrdaUWmfInQxH/S8vhrlIvC2d9zoK?=
 =?us-ascii?Q?gfCmKb/Qq11XRrBTiApjOnZWXLALwg6gX+Ev2MyLn5dpuszJC5QUlaitHvlM?=
 =?us-ascii?Q?sHOSaPM73OexMq1UBNzy4T0VJnAB3YB+DPIxu80hgoazHdq6TKhZf5Qxx6pu?=
 =?us-ascii?Q?b5lfMXezg/7cK5hlaZ/H9rWV8jsYvqrJc9n6a+UeQOil7wUGx8UJ2T+5LHGn?=
 =?us-ascii?Q?OkfcvvpNklv5Vpig0P9H1DFyX6NcK0W5p5CSQewwKDzYcNY2Fy/Ig88bafDq?=
 =?us-ascii?Q?04MB+RvHWk/qxM8dT3Dynh/Ot0WFkyKVvctLcMPkWbRMb2MqFzf3HMGzE5DN?=
 =?us-ascii?Q?Ce4Ac/OeiTtEsC2aTpLvHKAOIAH2rOJN/wKd1IMydXsNSOpsZ3VuiKStG7Hx?=
 =?us-ascii?Q?IeBn4XeaSyupMIYnq/aKd2Fq/67jsn4INkgBN53TME+XKfY7Il3nKV6hGnbY?=
 =?us-ascii?Q?G+yrq1p1fBZm8QHudNmjH18HvLSt/hLTzldHY4wxICrnS7Ivgt2p10+gG3kB?=
 =?us-ascii?Q?/OGTLw2VS7k++TbrGjDXNpbccV0OjNT3m7g1d2EJYK9j12av3yHE+DEspCvl?=
 =?us-ascii?Q?R+D9meJnPnMLmOrpcA0sJYswJ0FM1liDP0BfSLelmOGz5D86r+jymSOGIeWM?=
 =?us-ascii?Q?u+vU+dbTe9CnbqL2fFUXnPMVJ2j8Ars8hCmOxlAvMsd/mN1RINHsgnQYHYDQ?=
 =?us-ascii?Q?CiZ/g5OlL4I5aPUx0QG6SZI6TgiiT6RpMTWzzlGbU9imhlLON6PZGtDECHLU?=
 =?us-ascii?Q?L5F6qTu52yNzTF5wwFULo1MfVK0E/z5+BEEkklrsfy5XpJ1jFNI/bBEWVLdV?=
 =?us-ascii?Q?rg3DNFnvhGtl0999U4Pg46Dg3dY0HeMIrLYIg/qPOA=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e9c491-c098-40bf-f981-08dcc890a40c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:11:14.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB6230

On Tue, Aug 27, 2024 at 06:24:42PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Aug 21, 2024 at 04:54:55PM GMT, Chris Morgan wrote:
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		ret = iio_read_channel_processed(axp20x_batt->batt_v,
> > +						 &val->intval);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* IIO framework gives mV but Power Supply framework gives uV */
> > +		val->intval *= 1000;
> > +		return 0;
> 
> I see you followed the existing pattern for these two drivers. Can
> you please add another patch, which converts both drivers to the
> following pattern:
> 
> return iio_read_channel_processed_scale(adc_chan, &val->intval, 1000);

Would it be okay if I sent a patch series on top of this one (rather
than rebasing now that some of these are starting to get pulled)?

It's probably a simple enough change so I don't mind.

> 
> [...]
> 
> > +static int axp717_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> > +					  int val)
> > +{
> > +	switch (val) {
> > +	case 4000000:
> > +		val = AXP717_CHRG_CV_4_0V;
> > +		break;
> > +
> > +	case 4100000:
> > +		val = AXP717_CHRG_CV_4_1V;
> > +		break;
> > +
> > +	case 4200000:
> > +		val = AXP717_CHRG_CV_4_2V;
> > +		break;
> > +
> > +	default:
> > +		/*
> > +		 * AXP717 can go up to 4.35, 4.4, and 5.0 volts which
> > +		 * seem too high for lithium batteries, so do not allow.
> > +		 */
> > +		return -EINVAL;
> 
> 4.35V and 4.4V batteries exists. You can find them when you search
> for LiHV (Lithium High Voltage).
> 

Do you think I should add it then? Full disclosure, I basically opted
to not add this because while this series was written more or less
exclusively off of the datasheet I did peek at the BSP implementation
and I think they restricted these voltages. Again, as a fast-follow
once these patches finish getting pulled (I can start work on it now
though).

> [...]
> 
> Otherwise LGTM,
> 
> -- Sebastian

Thank you,
Chris

