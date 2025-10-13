Return-Path: <linux-iio+bounces-25038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107BBD5F90
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 21:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B24F2CCC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777025783C;
	Mon, 13 Oct 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BxoVl24R"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1562C21D6;
	Mon, 13 Oct 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384299; cv=fail; b=cF9UiGSvT8aG5Z58NEcFkTNYtNlSoOwba9am1Ph8tVjA+oQFc6wm8heDQEdyJ4i6PGAZHDbEXOHkmYx0PC6Cdq8SVfbbsLAeh+nVOyLY9F9PievGGWf5vUUn2bUzCrSEKTGcpj32mv7xqe8vh+YUnDGSRn3e8iegXd+S9TdjAYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384299; c=relaxed/simple;
	bh=Pk4I/SYHPZB+4AGOrcbN5lSIqkppT/rMGPpWOSAtRrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TObTKEhDTX5iXnwChytniWtDfgV+EzM7gHUps8M+YiAJppGER+S53vwN1JJf1Jl4UjQywqAdkfXgRvcmKd1IRSMjhO4dwOAkDqysNHMum3qnMEWDbs3z4d1s4WwxKnJL2N/yI22lkzhux7BBxxM05ZH0qu9HeZsiVyXFVOI0yu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BxoVl24R; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYUJGKgF8OSjElrQkJLzmR5RPfKCubcn7s70qO5uPi7L/NB+rU+gpZtEMJPx82mQv2AITiZyb7MN/On6Cf/IGGaC02qpa1BD0pVVW0fpID0f4QMPG3wsnmQdLQPDlEFOr/lYQ740YqJvDFYDda5jXn7QH68ubAifL2CWtSWJojcVtRIq6FXW7LPHGE0xbb4v0FqWRiSx8iA4NpkZ5DAZQ3IHls/ybILvEzssNFYEqHwFCk0g8haR5lTcBF4k2gjAdFMyLfqCUL2j4V/8bO6SiK4CDamCA6bE70BESA0lvVRryXmx8vazQ/5+bHJxJW8zZPhm9hiI4n9PewwfDyosGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TvOrfpW2IVeNdp3r2mftQP4n+0YuL0JmC+pkOucmW4=;
 b=MWTnF05ZV54300w+i+N5YYGeVw+P2nFAUy0lqj7Uee1TCGLa7LgF3e8VFAPosWryiorlkKs0+MmXxuP34heABaK5Gpw1DIjSVD+KQk+zubR9ECodzDPOdGakYx2X0qh/AJBVuh/vDuSUjl+7590atmRdiw73hEa1YRjn/yxPF0givx/T/5NnAEs6VnXbmyYzD5xeE8D7TqkXcDqAERf1WIjyE196FGZs+u9jTyW+Wo6okLqOycwp2eji5ExJGT5kFlwEbpAJDkaFBSAhleCCiVS7caAH4Ss7PKQYxZfnWLJiMImvWK7kBBs9uKwgdQMITXglmOka5NqJTbYxUYZR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TvOrfpW2IVeNdp3r2mftQP4n+0YuL0JmC+pkOucmW4=;
 b=BxoVl24RQBSepl+95D3o66Qkq7eXSEKft61BAAKcx5QjlYCU5HoJlDaYIme4atC7w4CE84aoJ0TzYFTK7jdDy37aUryHdcdAs3T3uzoE/PMh8HPZwu8sMCYQirBMW/vlh/N6PPIO9XhxDd0rEjxZoXCgBzGVv3w7OESEUqN8p3SvU6/TsDJye8m3QPZu/mll1zgZu0XdN+rSDJHKhf05dR+5NW6fE9sXHZuSy8L3hc3b5RWRwwhR5xyQMLt2HsoWvdgnxGZJNzzjC44/+bNF68XLvsvR/Dfcrzkk3/vVZxymkcuNDYlzMvKW7l5SeoQrvVZ4RPCKTmRA+NgGWBHnwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM9PR04MB8324.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 19:38:13 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 19:38:13 +0000
Date: Mon, 13 Oct 2025 15:38:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v5 0/5] i3c: Add basic HDR mode support
Message-ID: <aO1VHfHYNxboS3ag@lizhi-Precision-Tower-5810>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
 <20251012180327.5d94dda2@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012180327.5d94dda2@jic23-huawei>
X-ClientProxiedBy: PH7PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:510:23d::17) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM9PR04MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f0403a-79a2-47d9-9abb-08de0a900c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mtv93t2dKveLTp3SPet2tufMomTzhNzyQem9tMzJSi/SsV9+9KUjqWiyOesC?=
 =?us-ascii?Q?kZQolRRP8/pwmsHSz3LwDT2ybIHDAroULtV0WGQFh4k6Z1aRsD3CJ46a7EZG?=
 =?us-ascii?Q?HzTrQls5vKYNg9Js2K3/dCysTGgEvhjPjwpMoZHj1c5t2Q0HQogEYF/sAKuv?=
 =?us-ascii?Q?yQHxFhxmmCJCWEoGmt/sUt3TWzQBt3z15yNkAmOG5KvgPSbjUYgzsWBARTX7?=
 =?us-ascii?Q?DHDbo05IdDvBv4mW5PWi2HO24eks4VHAZF6M6zFbGtUEoOSyScdtmAgzNB7t?=
 =?us-ascii?Q?Zwe7Ln+yB/nREcEYE5ZVyoeuEoayki4CcBSUSCMuXXX+1z9IYk5KYpFDIZzk?=
 =?us-ascii?Q?MBhUzjMO/A4bfRXfLTEBgU/iGLiKn/lwrveimFSQXuVG370W1WOpFuxrvA7H?=
 =?us-ascii?Q?irBKrHsgtW6AtPbsmBHaGihVOSJaQw4N/24RyZyAdxeCDnJUT6wfG/mfkIoL?=
 =?us-ascii?Q?HUo/NwrkLToxCP8lIT3AIEfkq0y8Fh/I40AQ/mvsoKeaJtBcwUqv8LWe7GHD?=
 =?us-ascii?Q?aygVdLQJvIYOlh/CR1lNL7/9qgxXb5XFgMiYFe5rDM69l7FN3GfBQFPGiCg3?=
 =?us-ascii?Q?5mRq7UjFRz23PMeZ7FxkwETvhsWzAcofxGx8QMZdyuewaxXtxOMA5VKelYPz?=
 =?us-ascii?Q?wGVh5MV3DDxUfOgDh6E3KSmFL4/MaECH+Zjrtai37i5knd9Cd15Kbj9FaXwd?=
 =?us-ascii?Q?xPg3S92C2cChyDhAsIh+59xz2ddVVJAOIW9xr7AWU6mk5mcFMT6vba2D66Lh?=
 =?us-ascii?Q?3F08lourgNUae53C6WXmG9Ej3J3i3WR+jLkpVssB395MhdExrPUD4bRCmFSo?=
 =?us-ascii?Q?fyKhaF11FRpYCj36nAwC93+Mw0//8FKggJslJTH9brNf1LFn65akNJfFgNnN?=
 =?us-ascii?Q?YPn2cmnS82XQ3ujqN/9WP24whr1VdXPQg/bn4BjWjA3Y+e7wUKpyRvri53P8?=
 =?us-ascii?Q?6LMhyabCy/IRA5RGd9tnI0DvX/AuXPAaoKvjp8TiY+65edlt1lj1aanVtTAk?=
 =?us-ascii?Q?PfLgUGAq3g4wMjCJlyjuoxGGUWZAriZMDh2A/xnOiXSUvuNFsItbWRdnOvcL?=
 =?us-ascii?Q?5QbHeHKNTvXlb8NudZp0Px6clnmyGgFqZLNT4/ftvLh9yEF0sI6rXFJjFeh4?=
 =?us-ascii?Q?kbO3ZOLxgrAr/ZX/JnfG+4mGb0FBK1rGRVdpBJctcflOQXXFmNvBaau1dozc?=
 =?us-ascii?Q?O8x14y7oCZoZ6X74ozHaXwc574ayQFU3KZoaqhGK9/qV2olU8iXLXd06Lwgf?=
 =?us-ascii?Q?jKSVvObnIOOmK6P1n+p4qeVRa4bTVN7+5qQt2gkqgfX3mebVY+yUdlpvWLal?=
 =?us-ascii?Q?AXAjwepK/sVFHGvahKGFTmZSOwYU97jPqkMpfY/Yb2yBJ0iOtVLy9UXShrXo?=
 =?us-ascii?Q?gcxgIPOklA7By7NK0STIyTrx1MlJhYjrUcGOjLJj8lwUwTaRK/060kNh80Rs?=
 =?us-ascii?Q?heDRKpfmp17/XVWhIPT9zqUFJKZJ4Kfd6NV507B//wXJgstIGikGish0jMTF?=
 =?us-ascii?Q?+Gebxe078u2yywZzD3GQYrp2kdtFInPagL88?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERV0ERV7WiKDS5Dx3814/ywUsG+b11fvjWEaqaCMufsgMWE5jxCp/KE574sl?=
 =?us-ascii?Q?bkFVInUQlXK+zLNv8OVQICjyGOVBx6au2hcKwhzSHmPCSdApsfN5+pSnKN9O?=
 =?us-ascii?Q?dPzjKjRbeTLMQBkZp4kL/CbPHi+JP5X+Ghzga9ShjboQSP5L0CQWfhHxFmSB?=
 =?us-ascii?Q?JmJTwdgBoif6zjTH/NGmeUJ83p3mGnsb2Ykxv8E7gNWq5uKmeK3PxE1gqQPE?=
 =?us-ascii?Q?veQXmPof2cUP2OC8fAaz/GMKu39wl3B94SXvd8j8tCHtT1siJrdj4YcbJKwe?=
 =?us-ascii?Q?JNGUXCFVddtZHmMHAEfzfCj+bt5DGQyrb2O7HL4nVzpEWhm0BW4VoD4IBoKJ?=
 =?us-ascii?Q?FM5jiaolZAlchfu2V+86QAPPrNwai5+xg1UgiuVYOIwNMyniXB73EXG4M7YZ?=
 =?us-ascii?Q?VhtHdyzWybS1S37or+m2hrZ//oynYWmrOPg5g63cAaWkSIj2WIBfzkQblUhr?=
 =?us-ascii?Q?M6ciWa5HkJH681MWeU+exRusIZidcwmi4Sdxy/c9JaB6i+wgJLYvrJvea1Pw?=
 =?us-ascii?Q?y8rqEqufqR3oKqIZ+TCWsDAqzLZ3KV+9SjHhMuG6lhS7iluJWsBtsaznr0ST?=
 =?us-ascii?Q?kOZMs+k+8oDAW7h6AY7we36zTs+aswJ7QvJc2c8ZD61FwmavW7k6nRWwxC+e?=
 =?us-ascii?Q?RPozU4pCS9xEANl+XQ6KiREzxqAZH2koeNxdeBy2xVPMlayJFg6g2y92i44P?=
 =?us-ascii?Q?JNNcoPiCUrLLhaCEJudAhwfUfmywXj1YKSjjhj5HMJ4jI9V1Z2WtWzNA/wWw?=
 =?us-ascii?Q?gBL0VcrIS0OfSXmrLl8Yx6uMb6eiANQMdgX3y5iF8FmqG9PmI1NkKGH94ZRW?=
 =?us-ascii?Q?4XLgwR5LYQ81zVYOl47TJOXb9KaCdfJmzFrHc3NL0ChFu6Tu9BMnSlz89Mjn?=
 =?us-ascii?Q?r8oyROsaewdXZI9CQTXVYOlfHI7YFYHr1Cg4XOxHdqA3YRqsaC9cOwWrA7QV?=
 =?us-ascii?Q?OsdTi4bPLfbaKKjx+9V8NBC0V6pNmd9LblwQbr0gMm2YQiLeDHMYR7XfqT6Z?=
 =?us-ascii?Q?/WlG/co4qVPUSL8MWDjF5k8nWwsch2FCnc8REEGoRdYWjoMJ2V2fcNJUfSBm?=
 =?us-ascii?Q?PKQEMQELhVWmztUKqsF6cRoP7SQVAhOv1I62cbToaUI1de9zp9wBmann9NQ0?=
 =?us-ascii?Q?Sk17Mr+LX6/bzk0OiQTCTJ0sQy0rrVlnrFdx58aLIbFwhA8T+4ziGKUHEDWz?=
 =?us-ascii?Q?tbYKjwXoXMEjhmTU4FlQm4sjZXhrwth+0YOFBLmvxgOVxAp8Gutue0IDHkee?=
 =?us-ascii?Q?QnjrZOhWsSCJJ2anQRu/TmxWi8JmC42HjEKFezal7Eg5f1A3oeL+dl5L0yNh?=
 =?us-ascii?Q?ZX1Ya7pWmdyywVQ9+2+U11geQTH0Ko+QwdItlmHBIKguOFw12xwZbX/B6/55?=
 =?us-ascii?Q?o7w560caJAgGIoValHv4AjySfurwDvwD+Hcd4eTE4mS6JrCRtAak52kYGMTe?=
 =?us-ascii?Q?wYI8Ln3r3WqdpvgssdJFiBrZs593dvAepXFGBgMRjCRfg/eYIMceFFF0zbw/?=
 =?us-ascii?Q?pCMurkooymHxQSqMMAo4JF7UC9lDorLwRPKchWtolBL+EKt5XxKfLY+gZF3p?=
 =?us-ascii?Q?e+sgSQ1g+VihF7AAyji0f6z/soKUT6XcKDvK2HYv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f0403a-79a2-47d9-9abb-08de0a900c92
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:38:13.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMPTpL6OvUESku2O43UvQDbUBGBPeGOjKGUbWrAFDSD7FZaqGz6U2x72qSxqW+Ymk/BhjOoeawvsQijhMdxWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8324

On Sun, Oct 12, 2025 at 06:03:27PM +0100, Jonathan Cameron wrote:
> On Tue, 07 Oct 2025 16:06:12 -0400
> Frank Li <Frank.Li@nxp.com> wrote:
>
> > Add basic HDR mode support, only support private transfer, not support
> > CCC command.
> >
> > Update i3c framework API to allow pass down mode and extend driver callback
> > function.
> >
> > Implement HDR transfer in svc i3c master driver.
> >
> > Simplifed HDR flow is (ref i3c spec line 5514) Figure 129
> >
> > <--              SDR            ---> | <--- HDR
> > START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)
> >
> >                                     ----> |
> > HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT
> >
> > Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
> > read/write command.
> >
> > svc hardware can auto issue SDR part.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Whilst there will probably have to be a v6 for the ACPI ID issue in patch 5,
> I'd like to ask the question of how are we planning to merge this?
>
> Maybe an immutable branch either in IIO or I3C trees that the other one picks up?
>
> It's a new driver so could gamble on taking the IIO driver the I3C tree but even
> then I'd like a topic / immutable branch in case any IIO wide refactors or similar
> hit this cycle.

It is up to Alexandre Belloni.

Frank
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes in v5:
> > - Just realized missed CC mail list devicetree@vger.kernel.org and resend
> > - Link to v4: https://lore.kernel.org/r/20251007-i3c_ddr-v4-0-3afea5105775@nxp.com
> >
> > Changes in v4:
> > - use master's hdr_cap to check HDR cap.
> > - add mmc5603 support.
> > - Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com
> >
> > Changes in v3:
> > - Add new patch for change rnw to union for svc.
> > - Detial changes see each patch's change log.
> > - Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com
> >
> > Changes in v2:
> > - Add sensor driver, which use HDR mode read/write data.
> > - change priv_xfer to i3c_xfer.
> > - Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com
> >
> > ---
> > Frank Li (5):
> >       i3c: Add HDR API support
> >       i3c: master: svc: Replace bool rnw with union for HDR support
> >       i3c: master: svc: Add basic HDR mode support
> >       dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
> >       iio: magnetometer: Add mmc5633 sensor
> >
> >  .../devicetree/bindings/trivial-devices.yaml       |   4 +
> >  drivers/i3c/device.c                               |  27 +-
> >  drivers/i3c/internals.h                            |   6 +-
> >  drivers/i3c/master.c                               |  19 +-
> >  drivers/i3c/master/svc-i3c-master.c                |  96 +++-
> >  drivers/iio/magnetometer/Kconfig                   |  12 +
> >  drivers/iio/magnetometer/Makefile                  |   1 +
> >  drivers/iio/magnetometer/mmc5633.c                 | 579 +++++++++++++++++++++
> >  include/linux/i3c/device.h                         |  34 +-
> >  include/linux/i3c/master.h                         |   4 +
> >  10 files changed, 745 insertions(+), 37 deletions(-)
> > ---
> > base-commit: 5248ab97a6dd1dc6856422f6b1595baaf4fa85ce
> > change-id: 20250129-i3c_ddr-b15488901eb8
> >
> > Best regards,
> > --
> > Frank Li <Frank.Li@nxp.com>
> >
>

