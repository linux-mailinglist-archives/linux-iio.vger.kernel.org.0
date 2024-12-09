Return-Path: <linux-iio+bounces-13290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 428489EA162
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 22:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B31165EBA
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9CD19D098;
	Mon,  9 Dec 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="mbzCTvWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020104.outbound.protection.outlook.com [52.101.191.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39A137776;
	Mon,  9 Dec 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780963; cv=fail; b=oDUMfY4LcnSH+/Kl4JwmyupfkLK62BUlEEHKtXlEMzeXHjL1kTjdKoZAMor4gNOx4rvnu9v8X8je8Bf+MycLJDEyqxCnu1qhZwRagd9Ut4Q3Hm2wA9+Li8wMXT9RZY0ddFF/cusxNdAAcvvrusiebMMLf5KXXHP97WFCMl8LZFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780963; c=relaxed/simple;
	bh=03PLtJ2JweEjh7UhUBNQWCzuBGS85PK4x9YKPLJ83Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I7+2HtgejMjW1n1uvTC9cE+CNEzi5AAcJK95YdD2+AzdfEMnU+RvCrXKQt2YUct6Rp0ykpi393YP63R3xsv/414uiiicO+J9FQ4yH9n1W/gxdX9NQQMc+L8thUe19C827A+BWqRBojAc4XEMgTGcgBjjGTDg8HjUOPClJveok9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=mbzCTvWg; arc=fail smtp.client-ip=52.101.191.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBrIWVWhuRXL3sRMcKlSN+G/nbsE3R3NjfXa+fD+7/Amolwy79ECHrBogkOlTmm/rePEsAtntMQrTHjLbt88Joh0gCuSQy0ggBF9h2kEabfmVUjgMP8JvQKmYDk3IQspni9wumxCxKX5llk85iXF3139o5N086Rt0ixLHpz4HuoAO6Rf/04NcfkXI5fawITbqmr2svG2IcbI3vnUCdSfyiqMzlIvZEiWHPD8Z8HVLUO37pV0AnTw6xEa/svJv5h9ZMHjhNgqDU1w5hNb3a1wX5gspXT80t5ZfEEyUjdO9AXa/BTdrxpljU9st9xD6clDp1DhtuWAbtlrdBxSn+mTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmY94HLkBTbTWQFadyjsYYkENAixPcldTOa+/+UqutE=;
 b=TNHIs+Vre9KH/8Ms8AGc6gyQpWijynJI2aNXmmS9KNCdCRrZ3bA7AMJMos9YxkRa92MimjJ2l324qiLgG8bvu4/cXfsZOg5cca+U0PdqVgwM8aCruc5ilPeKUucAKogasnLNCC0HiOOlqkyJRm8i/dGg2v98E6x5y6znCO4VFemZ+1eKo4YyXAfo3D0XikGJyowBlAKCbbComq76ohrI2RolyBfKDisA+q4IcKLCskSOrH23XVU6d9eABGVBUcPR0mhdR4yaniONjIf8BlLwaAUDhANbcCo0opNAvUo+Gwc1M3tN4Jn8HC54l8An8WRQ218YQqoY2RQR3uzkzaQomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmY94HLkBTbTWQFadyjsYYkENAixPcldTOa+/+UqutE=;
 b=mbzCTvWgfNaH2/ZefNAdJRs8tW45QQiQHWgMMDOjCia/nUMDymzMlz7AM0kb31lWvIlF6FHN+S+f2uzjpjNpNoA4y8dJZDFksBEDmLHMSuMQ0x92Jd5m11oYqsjVY7O8GqAjU2OfbQKaYnRVmqebnk/CFuwaVpO95fy+rkwkGnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YT3PR01MB6148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:69::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Mon, 9 Dec
 2024 21:49:19 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 21:49:19 +0000
Date: Mon, 9 Dec 2024 16:49:12 -0500
From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <Z1dl2C9/BYoeyudu@uva.nl>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
 <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>
 <20241208122038.18cf7db8@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208122038.18cf7db8@jic23-huawei>
X-ClientProxiedBy: YQ1P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::14) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YT3PR01MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 88134c13-4540-4dd3-8ffd-08dd189b5576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MeCf5oI7DZQcaHdKJDvpDlrzDe9TsfkefQuhxqNnGkNeh0win0LUFBoafGyS?=
 =?us-ascii?Q?UnnJ+Aucg5tDN7uXQbSnfSG2jpNO39/MicwuHnVFRO0zdOO8h8QKRlQ1Wwcf?=
 =?us-ascii?Q?pDiWHDimrhIsLjvzBWrOEhPano4LHgHyR7v3yLmuTSpq/Zp/U5bkqEnliFPM?=
 =?us-ascii?Q?3zGCMUclJOlyDcXEtsQkGqar8yz/lkv5Df20y83vS7KFAWhOZ6+xzY75XQ1/?=
 =?us-ascii?Q?BzSqSrmfQHTTRF6uluGEUvjbQKqbJ5lT46aX34iXHH10gU0m1o5VwUewXwri?=
 =?us-ascii?Q?MH331MfRDqfvZH6SP7qv0bDRoK/za93kLBxk5HI+cvIUJ8GHnrydyZtCVXJ2?=
 =?us-ascii?Q?Dv3objBSQlChWjE3IZOamokPV9SAYq/SL6ySAmeuDvSIBCKJHSqXYu5l+uyE?=
 =?us-ascii?Q?QRLIIrJnQIaLV8LpIsHWGafQGjN3XzQgzc/z29n9Ljks06lwQqyWm3cOTzx5?=
 =?us-ascii?Q?pG1GrM3Gc1SVb37FL3n9Cp5sFZ4FPB3jVGmO3FaCkngzycDN6MX83SYLm9GV?=
 =?us-ascii?Q?trUGXGCz8GN1YWmR3ZN5c85H0Ump08RswDiMkm1Rk0oGkp5jPyWfuxxJlzGB?=
 =?us-ascii?Q?4/2TnZs/lQKjJ6LQU3TeGaOw/KfPCNRsM82c6yR6uv69WiokYD11wqdGyq7y?=
 =?us-ascii?Q?5g9IiGypzpYCnmcd7TMAdNmraWkxXWlRt3FZydkinqRaqosqcUQbR4mDzGGt?=
 =?us-ascii?Q?+NS+kb2QMlFc/B6g3oOlvy1lJBc/hBa0WbHp9em9tMIJsFQ5QL4b29VMHS1i?=
 =?us-ascii?Q?NkKBnzJWDdBq6Wu1aa2ei52l5NRuyz3XF1TmtCBOsckbrsAQXK/JVGLhAh75?=
 =?us-ascii?Q?k6pJad/ZyRp42wXyTt49v5YuskviPltcGu7GEN8Zc/Qh6+WVqmUXLkKCCIwj?=
 =?us-ascii?Q?zXn9Mwjq+vypsLs690zTnyjKw1PXK2rnNtA69awQHz3pYKl5ablk4ju7/cAE?=
 =?us-ascii?Q?ch41BgY6q2RQp9JsKMJ95+TPZbpfn4AHtTXmkWk3ocvhIMAaix2flwuMuhDv?=
 =?us-ascii?Q?HjOIi5RzLZj6ydHhNpsoNn/AmFL/+Bdp3oFuobSGxbCNqm3L3LzZFvg1AFkb?=
 =?us-ascii?Q?Quz8gdE1Zj/Sb+wVsUs42jKb8aR916vb6ahCbyjbU+CHUr63/IyFMEGr3s/P?=
 =?us-ascii?Q?MOPgg8wdFOYACXUWq9OeI7EL/AWoqqgt2wUklYfn0vzFNkIwPhnXzCbAkpo0?=
 =?us-ascii?Q?YOHXXXt0il05isYlVEZLHr2TsVfWvGRnqLTVtCaTKGpJiI2oQh5yFyto7LN0?=
 =?us-ascii?Q?aKjodgBDjmOGdvNvlwfuNjWgI34ZBLGPpFeuOnFl0PeQIt8T2Bv40ieHVQDM?=
 =?us-ascii?Q?kDGqRDMfHVe2wM1cg42WfShHlP5hjI5CsCUBbivZ97RWWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYLX3qQdyDX6nYOTgU05HOUSWVhiM7/CvCCb2Xc/C1mw+IQiaWcd0T2MkjKR?=
 =?us-ascii?Q?ZOlo010snizRJ+EpOZaaT01fBC4HgUFvVRAEsiwx09kBgQgxRvUDr2fRqTuK?=
 =?us-ascii?Q?Txn06M5eyCp3uQDUQEsV9D4FrPIjflv1zOoY3RmTuySzxy6CiWNqkThvc388?=
 =?us-ascii?Q?Ocq0F7oxMWOv15ge7IgYFW/ZueZbGGkn8DxyZAreJa6JI2mVeYVJphmVq85k?=
 =?us-ascii?Q?mmL1TCnFzHBPpm5r65VmPmRc2J+/AkIHmUQp8+kZTIsISzJYCAx2itkB4MdO?=
 =?us-ascii?Q?LC/VLF/AszKklXwPn+3yxRkA7VOzwEMRbNbCiRDvgiJAvoLKOL/H7eAti9yw?=
 =?us-ascii?Q?XnA6LR7zTcnfahfA9ajSelNY32b+UlAsSk8ZmO1uU/iI9jg39+OP0wKkJhbp?=
 =?us-ascii?Q?COkUeXV3tF6abE1I3dR7ACtF/u2OfbbK5hcifsMGZc4GKzw3erdXkwTV02tA?=
 =?us-ascii?Q?8kJ5FVb38o7io+MGccMpJPH0x9Fhrob1j6Ac9vRdKqlPnIMnstHtB6NwVVWD?=
 =?us-ascii?Q?xwjMEdfx7nsDTXr6n2qcKyx79OYqp5EpdlMd3Fb3UTcjxP2npEcqdknvg1wJ?=
 =?us-ascii?Q?Mx36eFG8gmeQWP0jLn22FBtMhqs7YFFH0SLXWbRvLPwEx+xZJpguTTatnh0P?=
 =?us-ascii?Q?eK3i9HJPEXBdNscSeGah9GP5g1DvFFWOX11xKI8oaY6Q6VgDez/QOqOqFfhY?=
 =?us-ascii?Q?le8cG1Lx0QPcjMbYyprgb8W1104KfeEB9fFCK3nkoQk7GHrW1py+wAd19Eqd?=
 =?us-ascii?Q?bXL7fiQ7WhOfiVjmCbE4dRqp/bRRLpPvxE/KtLKw9WocyYDvItul1vA2GEe6?=
 =?us-ascii?Q?MdbyILOOMWAuFU0sQLJXdvZqCTliesEzhecVbFKfR7/xkfiSbYXsyVuTqzO/?=
 =?us-ascii?Q?Ay+iqCSpJ78i8s9U/4Jx+f3gbSbT9NWF32Nuo3T7UK0nb3uwA3LZreiUsKZ3?=
 =?us-ascii?Q?mDkR49RzYlLqHU4pkLPKxx/o3RuFSqm4o71CfgXc4+9I6wOeuK4KUScU6P6g?=
 =?us-ascii?Q?+2jxALes2YgdRVDmdkokCiig6HmUlL37Mg0ZZBtQ1DtonX6EmLqiPOD5E4gG?=
 =?us-ascii?Q?/el0Y0VQ3aLHb1EVE/pwBk6FYi3o5dyBUWRxBdDfoTtQmPZcooogri0l0sgb?=
 =?us-ascii?Q?H9tVu3oj+uNcKwEJNpC7z3okFhrSZsDPUrcBYeNkUs2WuvkIBHJof/LFU6Zw?=
 =?us-ascii?Q?ulxjwFZVwygt8NAu0/yINU08HXib+TREjddr9H3ik2IfWgNVqU9CE28KhzCl?=
 =?us-ascii?Q?94+Dqrak8KaFr0Zdk5EnW0+90unymIdZrfHPsvtDGhBYQ++EG4sr+nj6oWkr?=
 =?us-ascii?Q?hKnLvYy1vDYItunmmy2s6cy/vXxIIILYQ8owYIEzHzKWEB0s3+NzO9Gs87e0?=
 =?us-ascii?Q?y2AlCxNWmqTFxqbzNYUCsK49ZC0cjVQxhmJO06UlQO7ZDJmH/tn88a6G1t9L?=
 =?us-ascii?Q?RVK2davX5tJdDQIuUIW2Xip28XfnjRyDTFu6ZoTmLlNF56gQDv6w4FsuQLxZ?=
 =?us-ascii?Q?q9VLFQm/0U6hfCd/iDBNXT5xqdZyuKNHTs0M1msgKJbzRzcjT1oE83omXA25?=
 =?us-ascii?Q?12rewf1bnsrSGOe3Egi2sGMmp8mDr6h53dEakO/MVjNS+Z4k8NA7fCl/HB7G?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88134c13-4540-4dd3-8ffd-08dd189b5576
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:49:19.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCbDxCavkkFbnHuxrUuy8NUihLFn4hrJafq7sO66Sce3tgtmdOqqAStyt8hEPdMNcseRLMdfAuYLHnzneLUV5QoU+aFwgekEEsnLGfOX/bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6148

On Sun, Dec 08, 2024 at 12:20:38PM +0000, Jonathan Cameron wrote:
> On Fri, 06 Dec 2024 11:09:57 -0500
> Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> 
> > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > 
> > APDS9160 is a combination of ALS and proximity sensors.
> > 
> > This patch add supports for:
> >     - Intensity clear data and illuminance data
> >     - Proximity data
> >     - Gain control, rate control
> >     - Event thresholds
> > 
> > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> 
> Hi Mikael,
> 
> As the bots noted, the maintainers entry has the wrong vendor prefix,
> or the binding does.
> 
> Also the issue with missing include of linux/bitfield.h
> 
> Unused gain table is less obvious. Not sure what intent was on that one.
> 
> Given the discussion with Matti about how to do the gain control, please add
> some description here of the outcome.  The control scheme is not particularly
> obvious and is the key bit we should be reviewing.  It feels like you've
> applied the feedback on v1 to the light channel but it is equally applicable
> to proximity channels when they are just measures of reflected light intensity.
> 
> Various other minor things inline.
> 
> Thanks,
> 
> 
> Jonathan

Hi Jonathan,

I will fix the warnings the bots noted and other inline comments for v3, sorry about that.
Regarding gain control for ALS, I kept the non-linear table provided in the datasheet.
The user can adjust the integration time and the available scales will update
depending on the value.
For example, at 100ms, you have possible scales of 0.819, 0.269, 0.131, etc. (lux/count).
The hardware gain and other relevant registers gets adjusted by the driver depending on selected scale.
The attribute is kept as read-only as Matti suggested.

Now, for proximity, again I'm confused. Please bear with me a little.
The only "scale" I see in the datasheet is that the proximity sensor is for a short distance of under 70mm.
There's nothing provided in the datasheet to convert the proximity ADC count to a distance or to anything meaningful like standard units.
I don't feel like this is really precise and the intended use case is probably like mine where you can use this to detect
if there's something covering the sensor or not.

I took a look at other light/proximity sensors, again, it's not clear for me how to handle this.
It seems that some drivers just directly control the hardware gain register with the scale even if it's not really a scale.

What should I do?

Best regards,
Mikael

