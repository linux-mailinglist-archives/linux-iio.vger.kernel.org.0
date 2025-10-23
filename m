Return-Path: <linux-iio+bounces-25400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA312C03E0A
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 01:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B9B3A5B23
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3EE2E5B32;
	Thu, 23 Oct 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B0lwP9Me"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BA2D97A0;
	Thu, 23 Oct 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263110; cv=fail; b=BJtHoSepb2/SxgiPVgBzPJ0Dj/iaPUgiAPAFUQapkeA+IJjYnuHZjopj/7W6w+YZs3oXRXw5dI+Ku4CB5b6TvGwRC2ln+w8fi9tFg/Y6O0DOpptUFk8cYs2C2trx7Qg68F9gAGRhO9pIiGFXo6xFsDOw6MgjN66Qa/H8S+XbF0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263110; c=relaxed/simple;
	bh=rOFdvSdjx3BcqQwOzdqXk/AOwBLwbJ+Lxo/s1KVjlqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z65mdjGoxQRQIIWoCeICh9BwDhgYYqmIruSJpIeIlbJbH3Uw7IEv2V9hAGvXk7hoFLildbPRWyopjXdUygZFkNn0oWfoGjh8qsdtm0D+zkOf63/fpC1bwoboRxTgbvT65x3xW2q+pEpTmFsnDbyKOPoQ2hJShUdhhPxwNmkxgIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B0lwP9Me; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrS2b4za1sosDzLtNW7XN8E5fS0u3Gq1PqEmXUx1YbLynkp1afUfAXXm3d17Pn17y7rtnqzjPORK+aJTCg4l9+BWYAeSa4vGjmdp1usTUosPCyDPT2evSaMgQIU00nNu1kC53n9Q8brgYsyCLIFNJOLKvy1ResUt/f80BGA4DcpB4KfAlR+xLj0dVrHX2PhC6XvG4pMa/hy0Foa3I7FjzWme5dG8e0NtTQzZLODKOHvRgnTeJfD/bFX9P3IWQIusneaE5m5qhrkQzfxZWQrW2Gj9Azx9VPG3IfFuA55AhEz2rs3aj+fRcAspUqrAMF785q2j8CvOEgEl81DDtOmEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ShB/wKuXeZ47FD1wfHLlh80/MSeySzgy095V/BvGlg=;
 b=Y+2K2s5HmKqv6WE7/y+lZt5aissiW89Qk2mJplzrZr5vH64daUlfD7gAvx2UG3C8UxgQgleb5zP5uKTFmP9Nz2uK2CixX80sB8igJpaFXEYIU9fQmM3L4v6B4LhpnXCjHZatf78QuzBvrDvF/QljVKSPeVczHzt/s0hPcHl8eSXeNDawWBRDjoefKUKdxwQSM0NsgGbA0lTGnhL+UisXsRj2Rxxcs92EsjhaC89Ck3jkLE9PW3KLz9c7IhPcyyErDI7e6dAtRfcMXQqWtqb2TDUQG0IomVVA9pCeyLtf8CWx8GLec/0SWLx+TFlTgUlm86NO8pDDpcVEbnu+0s31Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ShB/wKuXeZ47FD1wfHLlh80/MSeySzgy095V/BvGlg=;
 b=B0lwP9Me2/iLJZ6FlD9lZLHkFwc9T9lg5tIv80IGDN84ZD7kPmdNkkcf5hQQBuZEgbF1Oy1ygOSP0n9/uPB9xX5YLtz0vWjck/S01IeRZWmoDGWAGpFzEHKupD1EMC+iEyhWy5GcRf4DtgwszupmiyA5xw+x0vIf1DPDL/qAWV59aUgiy3ToPlMlIWR/c1UqOvEf8AkqxalKKH1634fjrIB3PIQjcYMnyx5Uwohf3r3sIbpN/Jragbk2SyOrU7aQKQfxI7z9m/k4cAkjhE8Xdc5pZNmTm9eCufVDyqMHwWiYtkA/IlN/gROhzpH5n7L3jYZBWobtF+ksiwXxPgcHGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8413.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 23:45:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:45:02 +0000
Date: Thu, 23 Oct 2025 19:44:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>
Subject: Re: [PATCH v6 3/5] i3c: master: svc: Add basic HDR mode support
Message-ID: <aPq99UduYHYOdlgq@lizhi-Precision-Tower-5810>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-3-3afe49773107@nxp.com>
 <aPnngQdwEqHgPc7R@smile.fi.intel.com>
 <aPpIkqjeWsi7xAAn@lizhi-Precision-Tower-5810>
 <aPpy_FNh0DB_1x-w@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPpy_FNh0DB_1x-w@smile.fi.intel.com>
X-ClientProxiedBy: PH7P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f32461-e339-4f6e-3c9e-08de128e2f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfYcLQ9Dwy6KubScHk5AseSNZHjH9PhVHs3TX0ishUP50L0WUiSzyCjRfOQ+?=
 =?us-ascii?Q?a9K+HMSnFmzowRz7/OT3zorbgepIFC8GSgpKiQJ2TzWGM3XBaOYBwbI8YzE4?=
 =?us-ascii?Q?6Qky1QcDTmoUNEDfvDdiCh9e5gZRgt9qVOeXeK8LyTbziCBsmDwRE0PVTwZn?=
 =?us-ascii?Q?oUAwmAZGDvBMMhGvBbfRW4GFn8u+1NomnTcJNTQMwq7ceORzW36+jjJ47+wF?=
 =?us-ascii?Q?irPXkmZN1P513NAUEjpOf/t99Tz/I4FA0fAoYIy0/vmcLaiBL/FK+yfd6yJL?=
 =?us-ascii?Q?TDjGpKINO7PdEIF6tYA/PMYWVrk2/AV17ZFwrkLlC55EHDCQ6/XXIL4lDySq?=
 =?us-ascii?Q?2LWgfhocjNX9ct4bwTF3Ayd/p6EzcsMR0TFu/GmyqQ88q+tMshlrA7YLsY3s?=
 =?us-ascii?Q?WfqAniEL7Y2QRFceTc/r2EdMm5u5x+IKuF0kQtu6roOaf5X6YLzciOYglQMv?=
 =?us-ascii?Q?H5d4brsfiR+W2gaojREX87r3v3f4Kb2XgggrqpEygueUCKjBLt+zZOOPDk1k?=
 =?us-ascii?Q?9JW+gE9TDusrK58CEuhtZ88DCfhdZJZgUOmpv9LFj5fM9JlPsNuqdwKLMrbY?=
 =?us-ascii?Q?NA9Sv4FHM1WAaBqaUJJMMLHt+UIx7egy0XquVQxk4518t8m5cnrZyMW/XMt9?=
 =?us-ascii?Q?wi3lOeDvsgmEWSafykoz81pcccRwZM313Y/VPwaIJ1wJbn0r/R2OchdIfTPp?=
 =?us-ascii?Q?9SPDB/vL6+M78CT4Ct2rLBwWxLYplcAGLw4eA7cgs8pkRcjko39rJ85a5YF5?=
 =?us-ascii?Q?QtXiWrhbmMq+gGZJmEgPQKwUUccsI9GIR6+kbsuzdsSuIjopqyhWxomeA8QD?=
 =?us-ascii?Q?KKLzEy0vs14j8kDTV3ZPcPvVZGTp44fvL+kwcCiGxb2B9MK8suJx/d2nnfCC?=
 =?us-ascii?Q?zkJh2VccAw+BdyXiW+0uOgxLWYIKy3ePTm3j/2rJBHGhxuzEzlXWU5QX0vl+?=
 =?us-ascii?Q?taHzeuE95EWa5XNxIV1Rg1fyS4tLvnC1VOUQiogFoEAB5kx/ta8wZe/8AnZY?=
 =?us-ascii?Q?NvoQ6ATmsepBh3gBdyOn3OGZipDbKG66/PY/6kNPKs5iR1KB9ZRmMvyTtTI3?=
 =?us-ascii?Q?bOFKDkEBYVTS5HEt974GOtsDOHLVTBO5WIS6rzkH5BwH+DRkV4w0seuNynjQ?=
 =?us-ascii?Q?CuUtStkecxtjrr3NZsD+8W2vyK3ytAhRNJpBi3+X5rdQyvn1t3pJAjWiYQjV?=
 =?us-ascii?Q?VwSWELzW7TTCzSkzMj+dD+sH9eMwBGrcIQ05KW2PWVzupLKu+eSKT65CoNRu?=
 =?us-ascii?Q?fgTrEnRl95JfbrWs08yST+k4ytSnvyb3l74uik1AHEwmyLyoLg1Lwzt763aR?=
 =?us-ascii?Q?xC2UngH5neTF9Oli4AoZoLB4Upf18WUYdY75ePka9euaRae+EjLpgKI0bDSV?=
 =?us-ascii?Q?tDBvVtQZtBTzI880aZrnGjdwDqF7GBWEeuORKq/3CHBKAQ6PPAOTyPhNvTpn?=
 =?us-ascii?Q?/oNQkcd/Xb5FgYU3SnCCQLsS8/4wykoTldgXWrWGu6Ub/CZpna3KUTBkuTn1?=
 =?us-ascii?Q?wEEfza4ENT4yb4vc7eNmid2pm/TFO4g97H9P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IT7M/GFSRkzavajMJHQpxB7m+eJqi4cIHyU6eut3ldb+md6/pLmEofnbJGeR?=
 =?us-ascii?Q?vc6Q+DCyUeB8y4k6gVOELO5/FFxRA2V3cm+lsJLs8S8old7VC6buuFXRBVg3?=
 =?us-ascii?Q?ZtgW1uAnZxHqRVWKsCGNOUVZpB/33vt17PM2UUDgsQC4sCAHR530fVTosDjQ?=
 =?us-ascii?Q?rXOJt7sCj7yIYfjnOVU7K1+BRIACpD8IeEv9oUXnp6bZFaKgprxZURxPfA8u?=
 =?us-ascii?Q?Za98M5FAumeonIYyBFOhN9fmnval6WoCuqanbNIHwMwyyHQm57lQfWVG4kAL?=
 =?us-ascii?Q?CUGxoawQtlSGnOFshZ8IE9Ntry20jeG8Bd2xo5VkHboHVE/gmz//uI0Whmag?=
 =?us-ascii?Q?kjdWHPzjawzRflyi8szsKxjNtye7rKgEDe2DgXGliUt5MhKkv/XReFR4hex8?=
 =?us-ascii?Q?Wa5/OcUsEPwgczdruBBgXakIV5Sh81L3b2tsESmVhe8LXf0LpmFyZGniDRj9?=
 =?us-ascii?Q?YpolceA7tffTEjLu5RR0dtPtJMzIAILYhPrCgg5GRuwtqPYR2h0UqVYKTIug?=
 =?us-ascii?Q?3Lu8n8l3XKd4RMZMCg5tYXNtOlxenQi/9mlo1sCTCUVtzw2UoxV1kSHYl1f2?=
 =?us-ascii?Q?5U62uiTxQWEf1t1jiZymRE14FgxqWMAExTULCtL857EtS0oHJGichhC0YYqT?=
 =?us-ascii?Q?CqvUxK1fvp6u8lhxVR9dfQFbiSkrX+J2fPuIKzkUKjtYWplxbKjMSGoGgCm3?=
 =?us-ascii?Q?hlAu/Noy+Z5Zb9YdEeM+W+12Mc3KMQcnRpl9zUQ62yqxtjL/+HBbRp9Fl/XH?=
 =?us-ascii?Q?a5ZhVvjf6w2nwmdYjBI/wOplC9lhkkw46RSFrmk0q0ICkUajD4htYAxPhjbi?=
 =?us-ascii?Q?8u/IuyqjdEXbb2DDbxVWAPF02eCzjDGxTf1F8asShLYOdagVR+rW41a2oLkF?=
 =?us-ascii?Q?s4g+kWoLc2242TH5ypNsrdS3p4YMApr9zEy4f/j4JepoicxD8K9IDYyBI0zs?=
 =?us-ascii?Q?UJIWPT403YrM1aEt7SWU2QdD9FRuSwWcItDADqm6/taZd+aTTuqXRr61OGba?=
 =?us-ascii?Q?d8NWFwDNSrhkTwpfLVCz69T/1lHnf5LeFkFL+VsH9l6IxmMSfgJlViGXNXiH?=
 =?us-ascii?Q?dCvR8wMWEhuJXmhPh/ALWxvT/wMhfR6QPX8YNm2Q7EL7pzL4NkZHIXCv1IUP?=
 =?us-ascii?Q?WmcPLPL6CHxnEr6qOWrRSTwhUGGIQs3X8u6NaIrrAsJnAWJqL0XhnrzNqCm5?=
 =?us-ascii?Q?gk1Rp0T0TETeKrrTawgWQ0W+0ynwCOedRR+t9myE4Nu0WO+1oiwkYqBDFmK/?=
 =?us-ascii?Q?kyv1AzSmLULB2LkB3w+6obsi0228mtNLaIDs+bf7PHqkfrvTfA+8WTFRSDE9?=
 =?us-ascii?Q?xmz+qGCzDnN1MJkq+gAtWequBwAvoUEwoQXOXHXLoZ4f/AyxteMd8XVwJId1?=
 =?us-ascii?Q?cE1dFMOyUSV0rnDXfzBZtUIlvOMx39/3XYN1IFj0y2v65Wm0layuZ4uDvyZN?=
 =?us-ascii?Q?AOU4SD/qAJMVOtYfAivqoGMVXgW5OnN7n+3ihK6lrCR5gLDimtEypfoEJTpk?=
 =?us-ascii?Q?o9GoQogo1PMqKSEtEoa09keq/gikl0pOcscAyaHuTp5eoJavs6o6cjjnuYng?=
 =?us-ascii?Q?x1t8NXN89QTpxwIWH8srE0/It9GEv/eBqxQAa6FF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f32461-e339-4f6e-3c9e-08de128e2f3e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:45:02.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dXR4/WybPKqzGplTa46V3E9RTuALzJ5bRr1OaWzra6Yip/DnTGwGoi8KrFZ6Euj1bHLdW6O/7+35APV7F6i/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8413

On Thu, Oct 23, 2025 at 09:25:00PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 23, 2025 at 11:24:02AM -0400, Frank Li wrote:
> > On Thu, Oct 23, 2025 at 11:29:53AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 14, 2025 at 12:40:02PM -0400, Frank Li wrote:
>
> ...
>
> > > > +	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> > > > +			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
> > >
> > > No error checks? Why is it okay?
> > > Why is the first parameter 0 while it's not an _atomic() call?
> > >
> > > > +	udelay(1);
> > >
> > > No explanations given. Also is it really need to be atomic? If not, use
> > > fsleep() and it will choose the best suitable API under the hood.
> >
> > It is in atomic context. I will add comments.
>
> Not only, the call that's used in the code from iopoll.h is wrong in such a
> case. Haven't you tested this with debug atomic context?

not enable debug atomic, but I think it should be
readl_poll_timeout_atomic ().

Frank
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

