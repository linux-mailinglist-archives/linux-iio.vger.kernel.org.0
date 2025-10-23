Return-Path: <linux-iio+bounces-25377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F0C0217C
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749373A2DEF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1769E333736;
	Thu, 23 Oct 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9UOhvMm"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A1333724;
	Thu, 23 Oct 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232732; cv=fail; b=PcsUBM0OaRnhutmKxOtqMoG8a1cu5PS+xlo1jJeCVapbqD8MoeW5DyhTyFwnxdX4QMW654wBNWBIj5TiLXn87eSzpAfuJSrSCk/8854ftsKCUWC78qgXrhegwZzAJE4MSYSIAg+srPg5SwvFqtyluyG5D3yKpdADBweGT4C7sOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232732; c=relaxed/simple;
	bh=dA5ORzx2X1tIDj9fYAdFWwMkCoHY+cbChpbjd4hAC7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SmzcNJOkjS3lfTMeRiD+h3UE87RxRle2tFZWlA5awa02v/ODUFeVg/p2Y7ZKWh+eubP37ZSZeoc3ZXBv2bHIgCnAw/LJFTvPQI295eS61pJe2Hy72/mVTO/s4oYFrENTHDfe+0L68s28mUblV/5CPFiOwDRulOYDKEklZchXRR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A9UOhvMm; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUlu/vunRoIKP4zjaE7gqbpTYHPzBbKPnNm97C5nsQEUUddUVpKfI6WoVNBBi3TtEck4O1fbY3sWYa2JPymPIznN1Ly/Rqr3ZGiILybu8Jy7TZ5Jy10KzNmg8MkHjI+v20Cf3JtAdege93OO6QYnwnhlcigoMimSlcRQ942Auyxqz8GviRryFjyJd0LDbkyn4yekkYR+E6P1iJUQT8Qi80XDY4iRMqrSl/ULKplQkOACX25iN6hH3Cl/NIQGN4JEAFdMnHWFLn9S2kO8eyO8xPL6i3U5g/EdByPLY0r1/ojjEVCGaIw2IAf9YmHPt9YhiMlpo6ht3/10oNUOegkIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tBuAFVlPQGEF9LCPPhiXoCwvBQTpr82cCfi1vhrXGk=;
 b=isc1t5+GHCtqHXsft+2n13QDBgElukhIv26oRibE1oxpwqu+K8X+khOe2qw/n8xUMi/2CepUnN8HqPQheDfbeKUArz+LP2CYNDW5aKJaze2yI/WYn9k54Q+qOy3yIWGFuOL9L8jEM75mGXNoBdrm9qr+jcfe+GCWMV0jxXDrweuV35pUkBgUVJtT32E66T1aTh4qu+wfmf0y9lcQVKBlEi5YLwEdihOIm9eouclcUzMbUuf1NjKHbdhYWPETP4JxsYeDv8eZhi8lUxEztf1lTts/UzoKFWR2iJAxs3UJQuGW3n/XIgmFiraoHempCKmSu4CHq/qoozoZZnqLmhf6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tBuAFVlPQGEF9LCPPhiXoCwvBQTpr82cCfi1vhrXGk=;
 b=A9UOhvMmQniB2b/2neAA8Mtz+Wcjz1FmgMh/46I0B6PWABJK7ZelbFIfoIc9fp+rIKPaWSGAhtwPiWdo9eFR7MJLwqvnRmlepGeA0ogVs7/U10wJllBmr5VZK1Cpe6QO3tJaYy+fbRUvLDtR8FPsVORpRdWUkhkxWPklAOAPb/WA/7zHNaTJkN0vlFsxQMHtpmxswSUkDRc6wNg+fRXomFNJjOuat44nuxdgDyCMYUgPJRAcGN3N4f0D9PGgMOIAgIRdo9hRYv3Kf7xEGsQesPvYJ0MXuvVb1ReN/TlscB7/xbUrQrSvugd+6ciZJxTe/uPFBT9KUq78834qJmWQEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:18:47 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:18:47 +0000
Date: Thu, 23 Oct 2025 11:18:37 -0400
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/5] i3c: Add HDR API support
Message-ID: <aPpHTej/vKfiN68k@lizhi-Precision-Tower-5810>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
 <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
X-ClientProxiedBy: PH8P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3f93a3-8b2b-42b1-e300-08de12477688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XiOVZyY8bH1AivaIIZWbnrGnfdHTBJjD8jPuNJfgjSYHSEeKUvoAUUBueoIl?=
 =?us-ascii?Q?ORGWn08MchBZnawvsWFSMr9zAL1kE9C1jQsA+b/lhH0doHliZAgYsvFc3m2J?=
 =?us-ascii?Q?SsYWLQP1fuiwWXaXZmslKf8W/ClyjMixClVsWDPT+889pNnucSIskFluUCXY?=
 =?us-ascii?Q?WaZ08HVq8Ul1daQLvsqs9NZRuPm2iMQ3B4WwaSYedunG6roNn7iLIQ3yi+kT?=
 =?us-ascii?Q?9jXb+BvG1uY8qvIc8WWETKdSuUICZVw2Owy0bcx1Xhx40KaJwIzrYXFJmO1j?=
 =?us-ascii?Q?R0k+TKvPK8EONzMCg5G0uB1bPrSuSGQpc0KN20K9eWtvL0ydN1Hq0hfkEMbe?=
 =?us-ascii?Q?nePL0bx7Jj7JXGx92miCFwWyxgW7eDmMvklG2457PXNfzXm7yhbiVx8yHuc4?=
 =?us-ascii?Q?qat4DGEMJPOKRriYIGxhtgfu6T83H3zVBTRMVMM+Y3QSDSdskl9AJUypS91r?=
 =?us-ascii?Q?5oxRSTIA3wciudGUTTmqnD7Vw9BTBOq0Mvcwv5pX7h/hZLQ3XCJy9KaX8tpI?=
 =?us-ascii?Q?pVMBMOIIXjU9oOGqMQWcKr1qQRMog4i5x8wPAy574VZnMMVJH6WblX7NKTwA?=
 =?us-ascii?Q?tvmV6N/agceeE9tN/AI/5+UeXNrPxdPqapcoXm/vO7Yme53hU6LwTQ/z25eq?=
 =?us-ascii?Q?sT1GFdRUMNMhyxXCbRUTYCrVq0FMvxp1JE++sXENF25P28Z/SCAJM/nkPXyV?=
 =?us-ascii?Q?LP9fOsVISjpdBkCOQWoTZkvN35aI5gDhZm2Eanx9g7Kw3tDfO1oatkB2jjBy?=
 =?us-ascii?Q?Ib9RblzcMEs7qSMANwaek+xqksUc43m/LwmTp1nLpumymL+plK9XzdlQJTVG?=
 =?us-ascii?Q?YIaXBWNQhV5jvn42ROWL9mdrAHLaHO7ygLec4oaFLXIvk8V4Po8xoDjKkwk+?=
 =?us-ascii?Q?iXefaqDg/pDJRgi+hCMsYNS71KZkHRzPLbAAT9xhn+HSlqhd35nz2t6hCrnq?=
 =?us-ascii?Q?AkZfGWuFN3To4XOa72rkwXV8KbWdtYY1hML+cWljgshhYsK9CWaQNvgDe50C?=
 =?us-ascii?Q?CELpkwSlYEYO/pt8teFuo3SX4jjHRO8HJJSMtGnKKNk5qBx03DC6SIQJziXt?=
 =?us-ascii?Q?3LDy5FuXNYWJtsqChZmpdQSgkU/XbylaRDcZ9CyO1KDziD8PNp83JB/e5zEm?=
 =?us-ascii?Q?X2xISPlFkiQCRPNusOq4IP57KpkNSF2aPTarzpteR+tPaczAfbz5pCX9eqjp?=
 =?us-ascii?Q?01m9kwhNS/8iNE8IFIFaxXx4/PON4bjhmPiYqSgelKHnknITi/J88dPJ3Tvk?=
 =?us-ascii?Q?I1BFqaGL6KyuEIFUYEZFpYZFsGWK+/FdywqG/JvgDPRuPR1NFQYKvI+rSJuE?=
 =?us-ascii?Q?29lHtRyw4SNV/V9TSsEe8um3TvO4ITBCa3ZYFItAX5eVNC2WCrxpWMnt+mru?=
 =?us-ascii?Q?gpkBjBrt+ftyeIE8qhIc9r1eB/Y8rSqIegOjjiT8F8RKgnLuqTjFvNNBhCog?=
 =?us-ascii?Q?bqnRjSGjkwG97EnvSME0CpUVlOPfhLA272QZzYnKyxxFpAypxx6SMqL7pW5d?=
 =?us-ascii?Q?CWBX7pBdtW04cN457YH99hNigjs3Wt9HvbJz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+CAfuHPojpejzcF/jq2TWCKElhmvZVPzZJ7PIF2tHdna3/bklFkWiB9enWl?=
 =?us-ascii?Q?sGrb2WwZPQ2/e4kHJoDNm7PYz2XftHGVmpWmH41kLupZbCq6zBzCz3OXUhEF?=
 =?us-ascii?Q?BPdrA3qHr2GULfaEZe074rxm9kwFrSxcszZepUr8FOdcxP12ectJClEzARGx?=
 =?us-ascii?Q?h/V3Ezg99+/XgHajqmqOeq19xugTeXnPLbORuamd4c3d7i8+4HLimWY7pC9r?=
 =?us-ascii?Q?Nd6aZUtT3JCdTyeVIOAc7uJCzQ0t0LCjJUyH2p1TCIVjXixlCLbVlIRyrgA8?=
 =?us-ascii?Q?VSBsOY3yXiRhbczl9tE/J4AeuevcWZOmFVVum/hN9oBKicqL5Ibxvtzaer7w?=
 =?us-ascii?Q?BozOBqm7IuCeGzlU9hHqg51MLXUBl53cTkyfaWn3mD5wDQxOOsfCWYn4FK6h?=
 =?us-ascii?Q?PDYtlinT5fnjiV0ZyIYA+8mHlgPcOVcAuQLtd0mc7/BTwq9bvABzdXOLihmR?=
 =?us-ascii?Q?TQ5Bn/chJukOBgP3FR70vWy71L9gGrxySU59sH5/xTZbbKK0yGVYKrWdCFXQ?=
 =?us-ascii?Q?LEwimRtMWPV7bU4RS9XUyvAZlONgadTBYElb7UPIOtXiq9QQJn40O4Ih1oQn?=
 =?us-ascii?Q?DifTJUJOVGGc8NM+zi+b4ZYhiYgLxqZlwxKc866Oeg+lwd2cgqgYv4zzUPf+?=
 =?us-ascii?Q?BWETbDyCsy0r8mUjbmURHnT396Vj7E6zTE+f5irfZrhOTSnIffEESSmGmKgv?=
 =?us-ascii?Q?KWlNygk6tUculqswe5TYn+KlVcowXrKqDIi2rXJ+6X24Nc/d3Uj4TGnzo3Bc?=
 =?us-ascii?Q?A9rxAYPDpyYgFu3jmqZcCm/o5AXuUpXClUtHoAZldqU0PEa9DuyQIXqiMHSG?=
 =?us-ascii?Q?/VmUZ4td/gQspj5aFLcbp2jutFodomcK2ORF4F+88bzHItodkmYjmeXEled4?=
 =?us-ascii?Q?PKrJgOrrdjtciX/UX96pT4pArfgkxOcXlEQY2sO8pM9Lh58kuXpzZez82SZR?=
 =?us-ascii?Q?/zLc9exhYHgh43i6m1HdDmTTMBzpvftTWCOnzIXAKTe1qfgRNcNAsZKvsDJh?=
 =?us-ascii?Q?YSrtoIYdPJ4R5KnCTlE2oknlWp5f6PYOsKPJScudTkSyPIJYrRF3p0xM4neb?=
 =?us-ascii?Q?A/rvvdFStPTJJv21k2LcLVt0Hb7eTE/thz5iziiypo9CYO+C2lRmXlGbZmZe?=
 =?us-ascii?Q?10pl+TKNUI78sNff5JSkIQLPO7YPqvPzdTzlJN7SCMckR/J9ToEkt9jciI6m?=
 =?us-ascii?Q?2ToAxv2UwV2dQKM9R/kNCrRre0QDho9qOkTrzNVJKyqeQFiIINi5dU74oHn9?=
 =?us-ascii?Q?F/UFPznK8Io81NH6jaqjou9clZG1TZiJVSFsi86kZ2TVCUNcDSCTxfRU66Iw?=
 =?us-ascii?Q?psc8gM5DQDB4ntvQirG4dWL2Pc38kPVOqAEbmtMN3i7HCwnDXDUb9Y3emK94?=
 =?us-ascii?Q?4w4JM8gWQAURgyGfCyt8nxrX1n+fowpS9vOaXWL/5qWC46kS9zy+rMvfQIiL?=
 =?us-ascii?Q?b2DVhBg/zvNsQCW++niXF1LJy+ys2w0G56UA+LO/VLoASSd6RWFKFrnv1Tgz?=
 =?us-ascii?Q?p2S2cM4qWFn+XIeksS2t41JgL4YTkWb0pnTobQ7OhlGw7nsLxmd9uXMtNWDz?=
 =?us-ascii?Q?jiT5bPGhNdf7T7suJL8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3f93a3-8b2b-42b1-e300-08de12477688
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:18:47.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/CvyAMDs2JNNnJ1lW8KJqihwKaBEWNoHZVNcZC3yb6Dcq+uwupO0a64ZbTs7uB2CtwLXVUip1AHQipmHHS1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

On Thu, Oct 23, 2025 at 11:23:39AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 14, 2025 at 12:40:00PM -0400, Frank Li wrote:
> > Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
> > I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
> > Technical Overview.
> >
> > i3c_xfer will be used for both SDR and HDR.
> >
> > Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
> > CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.
> >
> > Add i3c_device_do_xfers() with an xfer mode argument, while keeping
> > i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
> > with I3C_SDR for backward compatibility.
> >
> > Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
> > 'rnw', since HDR mode uses read/write commands instead of the SDR address
> > bit.
> >
> > Add .i3c_xfers() callback for master controllers. If not implemented, fall
> > back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
> > all controllers switch to .i3c_xfers().
> >
> > Add 'mode_mask' bitmask to advertise controller capability.
>
> ...
>
> >  static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
> >  {
> > -	if (!ops || !ops->bus_init || !ops->priv_xfers ||
> > +	if (!ops || !ops->bus_init ||
> >  	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
> >  		return -EINVAL;
> >
> > +	if (!ops->priv_xfers && !ops->i3c_xfers)
> > +		return -EINVAL;
>
> I would find the logically coupled proto-based xfers:
>
> 	if (!ops->i2c_xfers && !ops->i3c_xfers)
> 		return -EINVAL;

Not exactly, priv_xfers is old API, which supported now. I plan remove it
after remove all from i3c master controller driver after this patch merged.

i2c_xfers: must be no NULL

priv_xfers and i3c_xfers, one of both should be no NULL.

i2c_xfer is NULL, should be return -EINVAL, but you logic may success if
i3c_xfers is not NULL.

>
>
> >  	if (ops->request_ibi &&
> >  	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
> >  	     !ops->recycle_ibi_slot))
>
> >  }
>
> ...
>
> > -enum i3c_hdr_mode {
> > +enum i3c_xfer_mode {
> > +	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
> >  	I3C_HDR_DDR,
> >  	I3C_HDR_TSP,
> >  	I3C_HDR_TSL,
> > +	/* Use for default SDR transfer mode */
> > +	I3C_SDR = 0x31,
>
> Why has this a specific value, while the rest have not? If it's HW mandated,
> the all of them has to be assigned properly to avoid potential bugs.
>
> >  };
>
> ...
>
> >  /**
> > - * struct i3c_priv_xfer - I3C SDR private transfer
> > + * struct i3c_xfer - I3C data transfer
> >   * @rnw: encodes the transfer direction. true for a read, false for a write
> > + * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
> >   * @len: transfer length in bytes of the transfer
> >   * @actual_len: actual length in bytes are transferred by the controller
> >   * @data: input/output buffer
>
> >   * @data.out: output buffer. Must point to a DMA-able buffer
> >   * @err: I3C error code
> >   */
> > -struct i3c_priv_xfer {
> > -	u8 rnw;
> > +struct i3c_xfer {
> > +	union {
> > +		u8 rnw;
> > +		u8 cmd;
> > +	};
>
> What field is used to distinguish the union member in current use?
> In another word, union must be accompanied with a selector.

This struct use only for i3c_device_do_xfers(), which pass i3c_xfer_mode
informaiton. argument 'mode' will distrigiush rnw/cmd.

i3c_xfer[] array don't allow switch transfer mode during whole i3c
transcation. So doesn't put mode in here.

>
> >  	u16 len;
> >  	u16 actual_len;
> >  	union {
>
> >  	enum i3c_error_code err;
> >  };
>
> ...
>
> > +/* keep back compatible */
> > +#define i3c_priv_xfer i3c_xfer
>
> How many of the current users do this? Can't we just rename treewide?

git grep -r priv_xfer drivers/
drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[] = {
drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 1);
drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[2];
drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 2);
drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
drivers/hwmon/lm75.c:   ret = i3c_device_do_priv_xfers(i3cdev, xfers, 2);
drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
drivers/hwmon/lm75.c:   return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
drivers/i3c/device.c:int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
drivers/i3c/master.c:   if (!ops->priv_xfers && !ops->i3c_xfers)
drivers/i3c/master.c:   if (!master->ops->priv_xfers)
drivers/i3c/master.c:   return master->ops->priv_xfers(dev, xfers, nxfers);
drivers/i3c/master/dw-i3c-master.c:static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
drivers/i3c/master/dw-i3c-master.c:                                 struct i3c_priv_xfer *i3c_xfers,
drivers/i3c/master/dw-i3c-master.c:     .priv_xfers = dw_i3c_master_priv_xfers,
drivers/i3c/master/i3c-master-cdns.c:static int cdns_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
drivers/i3c/master/i3c-master-cdns.c:                                 struct i3c_priv_xfer *xfers,
drivers/i3c/master/i3c-master-cdns.c:   .priv_xfers = cdns_i3c_master_priv_xfers,
drivers/i3c/master/mipi-i3c-hci/core.c:static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
drivers/i3c/master/mipi-i3c-hci/core.c:                       struct i3c_priv_xfer *i3c_xfers,
drivers/i3c/master/mipi-i3c-hci/core.c: .priv_xfers             = i3c_hci_priv_xfers,
drivers/i3c/master/renesas-i3c.c:static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
drivers/i3c/master/renesas-i3c.c:       .priv_xfers = renesas_i3c_priv_xfers,
drivers/i3c/master/svc-i3c-master.c:    struct i3c_priv_xfer *xfer;
drivers/i3c/master/svc-i3c-master.c:     * at svc_i3c_master_priv_xfers().
drivers/i3c/master/svc-i3c-master.c:static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = false };
drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);

After this patch merged, I can clean up it at difference subsytem. After
all cleanup done, we can safely remove this define.

Frank
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

