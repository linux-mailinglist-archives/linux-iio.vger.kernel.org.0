Return-Path: <linux-iio+bounces-24690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA55BB795F
	for <lists+linux-iio@lfdr.de>; Fri, 03 Oct 2025 18:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A885F34727F
	for <lists+linux-iio@lfdr.de>; Fri,  3 Oct 2025 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713992C15A6;
	Fri,  3 Oct 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SrOlX1hG"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA31BA3D
	for <linux-iio@vger.kernel.org>; Fri,  3 Oct 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509703; cv=fail; b=ceCiHIhk7ykw/r/W2afyKfepESV7dFnW5TuHFyeFh8VPnC5KRRvQWNbQ9A0rad7xz/PC0ne5LdiLv0d+qplOtyw33y34wrF8oUhVlNXrmMfYXAyRGstuusSNE1EE1ji1Yd6zBUEE9YkLzxdBEogvuc1+NTNgnmVOAg6FAsOfWrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509703; c=relaxed/simple;
	bh=AJ/3t/EBIVf/OFLEaK/maU8Lu/8g0LBecYVigXXbTbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MoFGZa4SWXqusUmKitwAe+mUNlApthsjQudwC6Dgfiz/dDu7v+M1OH31VrdG/ecgSJJRw3LqgTCpnOLlYSwD7n+dOeFY01rHBRoql0JeZ4jePpviTh9TeQU9nThBvgTvOmm6WSjqOwkJnNRueC6avrF+9kc8EsBkUEH4vrV/kY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SrOlX1hG; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2iOXrbkCd+phUGJT7PgMy9Tmo+p4Mys3897cfWmbj7jqfwOET3YmFfCYIJRbCJNjjoUNZjNP4N2dWj8+qhcDK8GLYKflrL4gSVkDY78TmtF0jK5ntZH5qNA4zVfRh2XZg9m/2iuWAp45mqN/cHygjhYsThmHMbMx0R2V3qTq1sTf6FBCpOV95FT64L+CW3QiLNmfV/86I8XWehTCbEjYMR3o0mEd4qgHyYS1jNrp+63DAvEGTvU4xdYskp7zog666hXxEwRihya2skJWph+8ngALS/vEpmbHr53RC2Hh1eJPz4nbo+pxfBjpVGAZg/Dm4G+mpD3Etmw2vu129qb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWsy1OyF60YYP38E5AJa1JkfOFVh4zeuNTBZsS2Gqr8=;
 b=sD9LebbGEMLaS4v4Emd6q0Jek0O3SCMfkDVLIcs4SGdzIHofaRjLB9RAq3Ag23YwKGUMMJo71g2/ErpSZgyicTw9dHeZ2XmoLCOdICUH/eWqvzmZYeBmN7Q0AmGxoOdFUOogq+cySxQNoQErIZ8wjnsKrkP/AMRvvBhH4u21pSonQIqVtz1Tfxa9HcxftjRM3tr3b6k8OSVSIGlavb99GTxSjsBudtxYW8xRo87F/nSNegxDXn12n7gmh6R9zqFlcx7VTHGwzfRSSH85TvwDnIWB/SEDNBUQZ/lDiwpDKim4TB3jftXr8/im66Wkv1TiAnaDHG4h19M4l+MfJmMzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWsy1OyF60YYP38E5AJa1JkfOFVh4zeuNTBZsS2Gqr8=;
 b=SrOlX1hGkNzfiBlap3X0gItX62VgiZEeOkmwFCQx/8/vjdu4NdSOzHdpIulw0SR1f5Psj+9pxmMz9LCDaAqWdERg3vpfBfKPc99FmpsPDwQtJq3xUo+PnS8svXRi7/u9sfxCxxyQhKetijQeG7OitTfRfEghX7D29/LO0hbBCejhQO/AphR2/9RTP/ZKSWXB8tiYbqGOYjhLyuNTLqBp2nxBCeTNKJ+7BQlRfqcWqLLiNXqyqwwRwXaw4bPvYtyO8Ut05WMAB7SQfj0rd8FncuHB3PHEtcw0YHuJdZPTkO2eypLNvV/wh9unRuwNXq2j2+qLDb3iE9xXrB5C6XSjdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8841.eurprd04.prod.outlook.com (2603:10a6:20b:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.15; Fri, 3 Oct
 2025 16:41:36 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9182.013; Fri, 3 Oct 2025
 16:41:36 +0000
Date: Fri, 3 Oct 2025 12:41:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Adrian Fluturel <fluturel.adrian@gmail.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH] iio: magnetometer: add driver for mmc5603 sensor
Message-ID: <aN/8udCkAqLQsgTV@lizhi-Precision-Tower-5810>
References: <20251003000731.22927-1-fluturel.adrian@gmail.com>
 <20251003145454.00006f53@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003145454.00006f53@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e1110a-6d64-46d3-281b-08de029bb7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXkNyE9+INu+Dykrbo+GMeueQTOsf47YyFnl2qoIztoIu8rFZ95B9mzfmZv4?=
 =?us-ascii?Q?DBkhpTwHkCKKU+vYCn5lNx78hXvKoMnjjio/iH85o4Awz1V2tIZnOq3TyXZn?=
 =?us-ascii?Q?CDTDYiSUBHpNif4ZTpEbcmBLy/P8tVIvtbx4/JJaZNMj7cGpGM0cQbXdBt0n?=
 =?us-ascii?Q?1KbhfrjUAwXAtMxvx2wa5EAwsUrXnkWr6k5XGJd1BcNKZN+y3couYU0tbbtt?=
 =?us-ascii?Q?SBlKjarNjdl7AkHqJF5SqOuyj7SnxIFbMt7CiCyH3WXxpuRopRIk3Q/qwWGo?=
 =?us-ascii?Q?YoF/WsLH5S9Z4VYNBXzbd1agEUjL4qv+Th6VD0RFOedsJU2E36Ius+mME2iE?=
 =?us-ascii?Q?6Kd2LYPhXQtm7AlONlLZ9Sp48EWPPHw7Pu79b8QObr8rLTO+BFizAbv8OxtR?=
 =?us-ascii?Q?b4XNCsJlLRLoTNuX0OilRkzOgZcuWaXDZwBeRK5p0+0i4Z4Sw9s/Ct2sqwTg?=
 =?us-ascii?Q?cyBl1SJlvRAlG6itu7SAXqfREs4OUwzpzioKK8ezzkzSH+lG0xJ+PQ3xLPTF?=
 =?us-ascii?Q?Aleiq5q55lsIlezlwg68v3KgRgaAt3EQwlq/69Ql75KQQdl2LD4vqVF+TbAl?=
 =?us-ascii?Q?5ylma06992YscbaAVt0vnrZr29NrLbd6EYKxArbj+oPO0oBkbAsy5RLXYzFC?=
 =?us-ascii?Q?A6B+KnQtipiowfPtOHRp2Cu2MJt6O44VBe86Eof/44QA6QZ6e1r6BYN+OTUv?=
 =?us-ascii?Q?JHPokIrMcll3cLTIEBGhmHVohYYcfvxDdCm5jkdSIcxczS1fr9+JF1JLKQRP?=
 =?us-ascii?Q?yrwKn7DBSuetkMLUbj9B6nB9GZTGy9ZV8YlVK0ANqUhI65FDi1qvf5vzihtX?=
 =?us-ascii?Q?TRtjN2folkuuJEcRZKHMP66PM11aN2ZxvlAc0Fs2UviXqxHUdD/hb6k8O+K1?=
 =?us-ascii?Q?JNDoQ9IKlpZy5G2l7NvsQVSt2cNyMHtBQUMfnjlkkr90XZgbqqOtnATtOTk2?=
 =?us-ascii?Q?gWScx+e6v9ZUIi51GZyYcFlQclQTP+dG+Jw2WMhrUUtA7rwUB5WFAeqAGU6c?=
 =?us-ascii?Q?Gcws3joeg017eU3X6e2N3JrqZRgftg79lmuOxWacxub8AK7JJHB8UaQXVK7C?=
 =?us-ascii?Q?jOzH8yApDnMAScrXiZLP5Z19Mi6NiNSnxBIxXLJWK4OaBUYQMyGDDM3dS+wh?=
 =?us-ascii?Q?H/7EhlDf5rjw+izdfYnD+ZRbJdlxsMVJdzFXszK71kPIcxjWtvPka2A6Smj+?=
 =?us-ascii?Q?zMLWm5aZVMu6jbcoXpTbvNBWXTPOnz143ETEsmQsr9HJfLuag9YfhggFCFo7?=
 =?us-ascii?Q?zcy7hIpet1/kx4WuO4ziFldzx3bYlHeCbGWuhFKNE5cp1kW0l5iaUF0yjaOo?=
 =?us-ascii?Q?T9cMrR0s9jgSfU9bv7F1417DnIZ6cMj5rpIOxi9qh+eXDBZ376sGFVLOAcI5?=
 =?us-ascii?Q?R9rZyPF1W/GqVuDUqPG5/vxfxEWkGdb5yZeF1myRxQQ1fGDfP9/q+R951v9v?=
 =?us-ascii?Q?3Wj5l5Ivto0kriZtXRk8ufgBvxNcn0ft+GcczNWbvHNQhFMHfZJI33ZvR6bG?=
 =?us-ascii?Q?kl42D0iw6KYWrQtd/1RHgxrnTsZEycb17ECw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSA6Bw4BUghTJnfue28fmL7vCYhntp4OCjPXqq2loaNuPoOr8L3iHgRhXQzS?=
 =?us-ascii?Q?DMHJfs05b/wgdaldpMUBsIt8T1SJ4D1ILGe6tv7Qeej+BdMX7OUiq3lKaQdl?=
 =?us-ascii?Q?CIKYj7fwTmj0oxqdwnnPe5yT7p9zzAr9XNbNGGxN1S1GnpCOLJv+UqTVOr2R?=
 =?us-ascii?Q?61TGi2ZAcgHEQ1cRIIIbPuwHGfh64elRzERLkAH/tUtmbdiTjg/haOMRJEcZ?=
 =?us-ascii?Q?z6QFMM+cYHHxbpuXnL7WV5+THiOsgWHLQUYmpK2l2Rpw9Ccnmz1wQws26qKD?=
 =?us-ascii?Q?1M20bG/OIzIaV8Y/i8TpybE+JAESAShIfN/nrdJ5LzA/ipdYDkF/lxRi5mQN?=
 =?us-ascii?Q?fhGyETGrMjy7Wd3imX8HBrhOjuZMDBFFglyJyO82JvctfH2Pcj7g6DoWPNap?=
 =?us-ascii?Q?FTS78srs+aujkVHePyeF//nWsKsXCm7A4Y39mS47PR826us/UT3xoIc9nsly?=
 =?us-ascii?Q?rcxiYsZ2nnBJqYHnb2F2PCj+C4VqZoHTuf9UF0mTf/oETJ2wKqtB/+vgQaWm?=
 =?us-ascii?Q?1CbeWP90FL4bYliHxwespah79yOqZy8IHk4Yo7Ck22gcOJIA36nGxbLLXDyQ?=
 =?us-ascii?Q?pr957MRMYAxTZIKZkZZRQL/zhNdgskm0ILDA6MRYgM8Z07poZQ2udxsGwM7/?=
 =?us-ascii?Q?UJbZYvQFDzifCH1cJ4QZXIzQ3DbKZc4FHW19bP/uII9Ya1F4FP3OHrbX/+1J?=
 =?us-ascii?Q?FWy4uCBBYieopU8DMxVx4h+WOlkIY/kD5SKBxck+jkugK9JXnIbEVpBRijli?=
 =?us-ascii?Q?5rzVYAqeYXLDujh+tH4Bpkrwr8Z7mxBbqDROl4FafS7kQOrITsB2abxBpgE2?=
 =?us-ascii?Q?52y3wRkFCIhnuy3bTib4H7cZTLjo21YihHq4ZOoReWxncrmQL42qfy8MW/tj?=
 =?us-ascii?Q?PspZwR+qhogpedakQmXr8DEkY5vnvvZFU3uESD1CpfykF7wZq20Fm4miPwta?=
 =?us-ascii?Q?KS1GezI+3DQn1DriyY9QTOgl7xdCnQvTn8XxLytqhCf0w2jzDg9U9IAkPoyG?=
 =?us-ascii?Q?jEPFHErp5xkpKLqXTIDF9nRiczRGba1/+LGxVMxKN+T/H6ygcgWJtqRSPNyS?=
 =?us-ascii?Q?XgIO7GcgQA3+yeJoIh/wKTT5j14hj1GEJHk6XaRRIazxAwIYxxDyeW4XRbYq?=
 =?us-ascii?Q?KagJqvDx03X5YYo02adoPouxTwhcjMOcOnGoc9ThZ+hdHVJ2pPGVkA8XiHjN?=
 =?us-ascii?Q?V0Sg8qznzYgtMnc2KERL65ZudDi4URWn10tPiwRr9Sun45DbKBctL6DRKZeG?=
 =?us-ascii?Q?o+ZcjzO1x/cPQ4GIPMF+SLhstfCFQD+h2x+47v5u7EbHXnFcdP7UID3A8U9c?=
 =?us-ascii?Q?uL/zsY5Qk8y00DuWQyg1h00rKEutxVbCGdV/1GdyIG+ihaU34IPVv7DGmE7q?=
 =?us-ascii?Q?DGwKK7UOtIjcSCizRYw+t1WBJSCTXASGhibqJMLYV3xMvl09xhokmsOyekYI?=
 =?us-ascii?Q?1M5gqXZ39594Am2Bb/yRIuXFPvEF1ZhxeVVu4K9D5wAr0kMMns2/F4j9g8aT?=
 =?us-ascii?Q?3vRQ4b8L3jnapdO54bG/sVb2FrgrZ8rP6c3ZKbG8TChN/Z4Shh+HmXdQkGL1?=
 =?us-ascii?Q?l+5eeBrYKL9/ydPuRJQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e1110a-6d64-46d3-281b-08de029bb7da
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 16:41:36.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFIwz5xA2HIFDyQ51Hz+a3IqmKJV8NzlxOUOI3S1z6NBu4AVrxYYkydzyAerG8rhFLNqpyzXr2taSlosfcXI8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8841

On Fri, Oct 03, 2025 at 02:54:54PM +0100, Jonathan Cameron wrote:
> On Fri,  3 Oct 2025 02:07:31 +0200
> Adrian Fluturel <fluturel.adrian@gmail.com> wrote:
>
> > This adds support for the MMC5603 magnetometer.
> > Features:
> > 	- Raw X/Y/Z readout in milligauss
> > 	- Raw temp readout in millicelsius
> >
> > Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
> Hi Adrian
>
> I see you had a discussion with Frank on whether this could be
> integrated with the mmc5633 driver.  What was conclusion of that?

It is quite similar with mmc5633. Let me merge to one.

Frank

>
> I'll give this a quick review anyway.
>
> I'd expect to see a DT binding patch for any new magnetometer driver
> even if very simple.  Or an addition to trivial devices.  If it is
> already documented, then add a note to this patch description to say that.
>
> Thanks,
>
> Jonathan
>
>
> > ---
> >  drivers/iio/magnetometer/Kconfig   |  11 +
> >  drivers/iio/magnetometer/Makefile  |   1 +
> >  drivers/iio/magnetometer/mmc5603.c | 629 +++++++++++++++++++++++++++++
> >  3 files changed, 641 insertions(+)
> >  create mode 100644 drivers/iio/magnetometer/mmc5603.c
> >
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> > index 3debf1320ad1..0895602eb631 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -139,6 +139,17 @@ config MMC35240
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called mmc35240.
> >
> > +config MMC5603
> > +       tristate "MEMSIC MMC5603NJ 3-axis magnetic sensor"
> > +       select REGMAP_I2C
> > +       depends on I2C
> > +       help
> > +	 Say yes here to build support for the MEMSIC MMC5603NJ 3-axis
> > +       	 magnetic sensor.
> Formatting seems to have gone wrong.  Help text should be a tab and 2 spaces
> in. Everything else one tab.
> > +
> > +	 To compile this driver as a module, choose M here: the module
> > +	 will be called mmc5603.
> > +
> >  config IIO_ST_MAGN_3AXIS
> >  	tristate "STMicroelectronics magnetometers 3-Axis Driver"
> >  	depends on (I2C || SPI_MASTER) && SYSFS
>
> > diff --git a/drivers/iio/magnetometer/mmc5603.c b/drivers/iio/magnetometer/mmc5603.c
> > new file mode 100644
> > index 000000000000..4a0a4e97b728
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/mmc5603.c
> > @@ -0,0 +1,629 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MMC5603NJ - MEMSIC 3-axis magnetic sensor
> > + *
> > + * Copyright (c) 2025, Adrian Fluturel.
> > + *
> > + * IIO driver for MMC5603 (7-bit I2C slave address 0x30).
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
>
> Follow include what you use principles a little closer. Should be
> mutex.h and probably various others.
>
> > +#include <linux/init.h>
> > +#include <linux/i2c.h>
> > +#include <linux/delay.h>
> > +#include <linux/regmap.h>
> > +#include <linux/pm.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> This should go with the changes suggested below.
>
> > +
> > +#define MMC5603_DRV_NAME "mmc5603"
> > +#define MMC5603_REGMAP_NAME "mmc5603_regmap"
> Just put that inline.  The define doesn't benefit anyone as
> we look for the name where it is used.  Same for drv name.
>
> > +
> > +/* Registers */
> > +#define MMC5603_REG_XOUT_0 0x00
> > +#define MMC5603_REG_XOUT_1 0x01
> > +#define MMC5603_REG_XOUT_2 0x06
> > +#define MMC5603_REG_YOUT_0 0x02
> > +#define MMC5603_REG_YOUT_1 0x03
> > +#define MMC5603_REG_YOUT_2 0x07
> > +#define MMC5603_REG_ZOUT_0 0x04
> > +#define MMC5603_REG_ZOUT_1 0x05
> > +#define MMC5603_REG_ZOUT_2 0x08
> > +#define MMC5603_REG_TOUT 0x09
> > +
> > +#define MMC5603_REG_STATUS 0x18
> > +#define MMC5603_REG_ODR 0x1A
> > +#define MMC5603_REG_CTRL0 0x1B
> > +#define MMC5603_REG_CTRL1 0x1C
> > +#define MMC5603_REG_CTRL2 0x1D
> > +
> > +#define MMC5603_REG_ID 0x39
> > +
> > +/* STATUS bits */
> The naming makes that clear (which is great). So drop the comments.
> > +#define MMC5603_STATUS_MEAS_M_DONE_BIT BIT(6)
> > +#define MMC5603_STATUS_MEAS_T_DONE_BIT BIT(7)
> > +
> > +/* CONTROL0 bits */
> > +#define MMC5603_CTRL0_TM_M_BIT BIT(0)
> > +#define MMC5603_CTRL0_TM_T_BIT BIT(1)
> > +#define MMC5603_CTRL0_SET_BIT BIT(3)
> > +#define MMC5603_CTRL0_RESET_BIT BIT(4)
> > +#define MMC5603_CTRL0_AUTO_SR_EN BIT(5)
> > +
> > +/* CONTROL1 bits */
> > +#define MMC5603_CTRL1_BW0_BIT BIT(0)
> > +#define MMC5603_CTRL1_BW1_BIT BIT(1)
> > +#define MMC5603_CTRL1_BW_MASK (MMC5603_CTRL1_BW0_BIT | MMC5603_CTRL1_BW1_BIT)
> > +#define MMC5603_CTRL1_BW_SHIFT 0
>
> Seems like a 2 bit field. Use GENMASK(1, 0) and no need for shift or individual
> bit definitions that I can spot.
>
> > +#define MMC5603_CTRL1_SW_RESET_BIT BIT(7)
> > +
> > +/* WAIT TIMES */
> > +#define MMC5603_POWERUP_WAIT_TIME 20000 /* us */
> > +#define MMC5603_SR_WAIT_TIME 1000 /* us */
> > +#define MMC5603_MEAS_WAIT_TIME 6600 /* us */
> rename the define to include the units. Then don't need the comments.
>
> 	WAIT_USECS then you don't need to call out its a time as kind of
> obvious.
> > +
> > +enum mmc5603_resolution {
> > +	MMC5603_16_BITS = 0,
> > +	MMC5603_18_BITS,
> > +	MMC5603_20_BITS,
> > +};
> > +
> > +enum mmc5603_channels {
> > +	AXIS_X = 0,
> > +	AXIS_Y,
> > +	AXIS_Z,
> > +	TEMPERATURE,
> Very generic names that are likely to clash in future. Prefix with device name.
> > +};
> > +
> > +static const struct {
> > +	int sens;
> > +	int nfo;
> > +} mmc5603_props_table[] = {
> > +	/* 16 bits operation */
> > +	{
> > +		1024,
> > +		32768,
> > +	},
> > +	/* 18 bits operation */
> > +	{
> > +		4096,
> > +		131072,
> > +	},
> > +	/* 20 bits operation */
> > +	{
> > +		16384,
> > +		524288,
> > +	}
> > +};
> > +
> > +static const struct {
> > +	int val;
> > +	int val2;
> > +} mmc5603_samp_freq[] = {
> > +	{1, 200000},
> 	{ 1, 200000 },
> etc preferred for IIO. We are slowly standardizing on this.
>
> > +	{2, 0},
> > +	{3, 500000},
> > +	{6, 600000},
> > +};
> > +
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1.2 2 3.5 6.6");
>
> As below, use the callbacks instead of custom attr.
>
> > +
> > +#define MMC5603_CHANNEL(_axis) { \
> > +		.type = IIO_MAGN, \
> > +		.modified = 1, \
> > +		.channel2 = IIO_MOD_ ## _axis, \
> > +		.address = AXIS_ ## _axis, \
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > +			BIT(IIO_CHAN_INFO_SCALE), \
> > +}
> > +
> > +static const struct iio_chan_spec mmc5603_channels[] = {
> > +	MMC5603_CHANNEL(X),
> > +	MMC5603_CHANNEL(Y),
> > +	MMC5603_CHANNEL(Z),
> > +	{
> > +		.type = IIO_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_OFFSET),
> > +		.address = TEMPERATURE,
> > +	},
> > +};
> > +
> > +static struct attribute *mmc5603_attributes[] = {
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>
> Should be able to use the read_avail() callback and the relevant masks
> to implement this.  Eventually I plan to remove the macros that
> make this approach too easy to do.  The reason being that they don't
> allow in kernel accesses.
>
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group mmc5603_attribute_group = {
> > +	.attrs = mmc5603_attributes,
> > +};
> > +
> > +// Private data
>
> Comment not useful, also not C style.
>
> > +struct mmc5603_data {
> > +	struct i2c_client *client;
> > +	struct mutex mutex;
>
> Locks always need a comment to say what data they serialize access to.
> Often that's either a RMW cycle or some case where we need a bunch of
> accesses to occur atomically wrt to other accesses.
> Otherwise the regmap internal locks are sufficent.
>
> > +	struct regmap *regmap;
> > +
> > +	enum mmc5603_resolution res;
> > +};
>
> > +static int mmc5603_sw_reset(struct mmc5603_data *data)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_set_bits(data->regmap, MMC5603_REG_CTRL1,
> > +			      MMC5603_CTRL1_SW_RESET_BIT);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* The datasheet says to wait 20ms after a software reset */
> > +	usleep_range(MMC5603_POWERUP_WAIT_TIME,
> > +		     MMC5603_POWERUP_WAIT_TIME + 100);
> fsleep() for all sleeps where we don't need precision on when they finish.
> That sets standard range values for us so we don't need to justify choices
> at each call.
>
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5603_init(struct mmc5603_data *data)
> > +{
> > +	int ret;
> > +	unsigned int reg_id;
> > +
> > +	usleep_range(MMC5603_POWERUP_WAIT_TIME,
> > +		     MMC5603_POWERUP_WAIT_TIME + 100);
>
> fsleep().  Normally we put this with the regulator enable that's
> related to this rather than in init.
>
> > +
> > +	ret = regmap_read(data->regmap, MMC5603_REG_ID, &reg_id);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error reading product id\n");
> > +		return ret;
> > +	}
> > +
> > +	dev_info(&data->client->dev, "MMC5603 chip id %x\n", reg_id);
>
> Probably too noisy. Use dev_dbg() and rely on dynamic debug if anyone needs to know this.
>
> > +
> > +	/* Do a software reset */
>
> Function name makes that obvious so drop the comment.
>
> > +	ret = mmc5603_sw_reset(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Do a SET-RESET cycle to get more accurate readings */
> > +	ret = mmc5603_set(data, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Wait 1 millisecond after a SET or RESET */
> fsleep()
>
> > +	usleep_range(MMC5603_SR_WAIT_TIME, MMC5603_SR_WAIT_TIME + 1);
> > +
> > +	ret = mmc5603_set(data, false);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	usleep_range(MMC5603_SR_WAIT_TIME, MMC5603_SR_WAIT_TIME + 1);
> > +
> > +	/* Set default sampling frequency */
> > +	ret = regmap_update_bits(data->regmap, MMC5603_REG_CTRL1,
> > +				 MMC5603_CTRL1_BW_MASK, data->res);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Enable automatic periodic SET-RESET */
> > +	ret = regmap_set_bits(data->regmap, MMC5603_REG_CTRL0,
> > +			      MMC5603_CTRL0_AUTO_SR_EN);
> Not checking ret?
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5603_take_magn_measurement(struct mmc5603_data *data)
> > +{
> > +	int ret, tries = 100;
> > +	unsigned int reg_status;
> > +
> > +	ret = regmap_write(data->regmap, MMC5603_REG_CTRL0,
> > +			   MMC5603_CTRL0_TM_M_BIT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	while (tries-- > 0) {
>
> Similar comments to below.
>
> > +		ret = regmap_read(data->regmap, MMC5603_REG_STATUS,
> > +				  &reg_status);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (reg_status & MMC5603_STATUS_MEAS_M_DONE_BIT)
> > +			break;
> > +
> > +		/* Minimum time between measurements */
> > +		usleep_range(MMC5603_MEAS_WAIT_TIME,
> > +			     MMC5603_MEAS_WAIT_TIME + 1);
> > +	}
> > +
> > +	if (tries < 0) {
> > +		dev_err(&data->client->dev, "data not ready");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5603_take_temp_measurement(struct mmc5603_data *data)
> > +{
> > +	int ret, tries = 100;
> > +	unsigned int reg_status;
> > +
> > +	ret = regmap_write(data->regmap, MMC5603_REG_CTRL0,
> > +			   MMC5603_CTRL0_TM_T_BIT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	while (tries-- > 0) {
>
> Add a comment on why retry and why that many times.  Ideally reference
> the datasheet.
>
> > +		ret = regmap_read(data->regmap, MMC5603_REG_STATUS,
> > +				  &reg_status);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (reg_status & MMC5603_STATUS_MEAS_T_DONE_BIT) {
> > +			printk(KERN_INFO "Measurement T done bit is 1\n");
>
> dev_info() if it makes sense. Probably dev_dbg().
>
> > +			break;
> > +		}
> > +
> > +		/* Minimum time between measurements */
> > +		usleep_range(MMC5603_MEAS_WAIT_TIME,
> > +			     MMC5603_MEAS_WAIT_TIME + 1);
> > +	}
> > +
> > +	if (tries < 0) {
> > +		dev_err(&data->client->dev, "data not ready");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5603_read_magn_measurement(struct mmc5603_data *data,
> > +					 u32 ret_data[3])
> > +{
> > +	int ret;
> > +	u8 buf[9];
> > +
> > +	ret = mmc5603_take_magn_measurement(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, MMC5603_REG_XOUT_0, buf,
> > +			       9 * sizeof(u8));
> > +
> > +	// Extract X (registers 0x00, 0x01, 0x06)
> Can see that, so the comment isn't that helpful.
> Looks like you could use a get_unaligned_be16() or similar to help a little.
> I think I commented on this in Frank's driver.
>
> > +	ret_data[AXIS_X] = (buf[0] << 12) | (buf[1] << 4) | (buf[6] >> 4);
> > +
> > +	// Extract Y (registers 0x02, 0x03, 0x07)
> > +	ret_data[AXIS_Y] = (buf[2] << 12) | (buf[3] << 4) | (buf[7] >> 4);
> > +
> > +	// Extract Z (registers 0x04, 0x05, 0x08)
> > +	ret_data[AXIS_Z] = (buf[4] << 12) | (buf[5] << 4) | (buf[8] >> 4);
> > +
> > +	return ret;
> > +}
>
> > +static int mmc5603_read_temperature(struct mmc5603_data *data, int *ret_data)
> > +{
> > +	int ret, raw_temp;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret = mmc5603_read_temp_measurement(data, &raw_temp);
> > +	mutex_unlock(&data->mutex);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* 0.8 degrees Celsius/LSB, 0x00 is -75 degrees Celsius */
> > +	*ret_data = raw_temp * 800 - 75000;
>
> Why are you doing some maths to convert in driver and leaving some scaling
> to userspace?  IIO convention is push everything to userspace if possible.
> There we have floating point to help do the maths nicely.
>
> > +	return 0;
> > +}
> > +
> > +static int mmc5603_raw_to_mgauss(struct mmc5603_data *data, int index,
> > +				 u32 raw[], int *val)
> > +{
> > +	int sens;
> > +	int nfo;
> > +
> > +	sens = mmc5603_props_table[data->res].sens;
> > +	nfo = mmc5603_props_table[data->res].nfo;
> Might as well combine assignment and declaration here.
>
> 	int sens = ...
> etc
>
> > +
> > +	switch (index) {
> > +	case AXIS_X:
> > +		*val = ((int)raw[AXIS_X] - nfo) * 1000 / sens;
> > +		break;
> > +	case AXIS_Y:
> > +		*val = ((int)raw[AXIS_Y] - nfo) * 1000 / sens;
> > +		break;
> > +	case AXIS_Z:
> > +		*val = ((int)raw[AXIS_Z] - nfo) * 1000 / sens;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mmc5603_read_mgauss(struct mmc5603_data *data, int index, int *val)
> > +{
> > +	int ret;
> > +	u32 raw[3];
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret = mmc5603_read_magn_measurement(data, raw);
> > +	mutex_unlock(&data->mutex);
> > +	if (ret < 0)
> > +		return ret;
> > +	ret = mmc5603_raw_to_mgauss(data, index, raw, val);
> > +	return ret;
>
> 	return mmc...
>
> > +}
> > +
> > +static int mmc5603_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct mmc5603_data *data = iio_priv(indio_dev);
> > +	int ret, i;
> > +	unsigned int reg;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->address) {
> > +		case AXIS_X:
> > +		case AXIS_Y:
> > +		case AXIS_Z:
> > +			ret = mmc5603_read_mgauss(data, chan->address, val);
> > +			if (ret < 0)
> > +				return ret;
> > +			return IIO_VAL_INT;
> > +		case TEMPERATURE:
> > +			ret = mmc5603_read_temperature(data, val);
> > +			if (ret < 0)
> > +				return ret;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/* For IIO_TEMP and IIO_MAGN, the result is in milligauss
> > +		   and millicelcius so the scale is the same. */
> Comment slightly confuses me. Is the point that raw values for bother are
> in micro units so we need to divide by 1000 to correct that?
>
> If so a fraction type might be easier to read.
>
> Multiline comment syntax is.
> 		/*
> 		 * For IIO_TEM...
> 		 * and milice...
> 		 */
>
> > +		switch (chan->type) {
> > +		case IIO_MAGN:
> > +		case IIO_TEMP:
> > +			*val = 0;
> > +			*val2 = 1000;
> > +			return IIO_VAL_INT_PLUS_MICRO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		mutex_lock(&data->mutex);
> > +		ret = regmap_read(data->regmap, MMC5603_REG_CTRL1, &reg);
> > +		mutex_unlock(&data->mutex);
> > +
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		i = (reg & MMC5603_CTRL1_BW_MASK);
> > +		if (i < 0 || i >= ARRAY_SIZE(mmc5603_samp_freq))
> > +			return -EINVAL;
> > +
> > +		*val = mmc5603_samp_freq[i].val;
> > +		*val2 = mmc5603_samp_freq[i].val2;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int mmc5603_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int val,
> > +			     int val2, long mask)
> > +{
> > +	struct mmc5603_data *data = iio_priv(indio_dev);
> > +	int i, ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		i = mmc5603_get_samp_freq_index(data, val, val2);
> > +		if (i < 0)
> > +			return -EINVAL;
> > +		mutex_lock(&data->mutex);
> I'd add scope with {} around the whole case block and then use
> 		guard(mutex)(&data->mutex);
>
> make sure to include cleanuph if you aren't already.
>
> The advantage here is that you can then do
> 		return regmap_update_bits...
>
> > +		ret = regmap_update_bits(data->regmap, MMC5603_REG_CTRL1,
> > +					 MMC5603_CTRL1_BW_MASK,
> > +					 i << MMC5603_CTRL1_BW_SHIFT);
> > +		mutex_unlock(&data->mutex);
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info mmc5603_info = {
> > +	.read_raw = mmc5603_read_raw,
> > +	.write_raw = mmc5603_write_raw,
> > +	.attrs = &mmc5603_attribute_group
> > +};
>
> > +
> > +static const struct regmap_config mmc5603_regmap_config = {
> > +	.name = MMC5603_REGMAP_NAME,
> > +
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +
> > +	.max_register = MMC5603_REG_ID,
> > +	.cache_type = REGCACHE_FLAT,
>
> Generally just use the maple tree one unless very strong reason to do
> otherwise.  It's pretty efficient event for dense cases like I guess you
> have here.
>
>
> > +
> > +	.writeable_reg = mmc5603_is_writeable_reg,
> > +	.readable_reg = mmc5603_is_readable_reg,
> > +	.volatile_reg = mmc5603_is_volatile_reg,
> > +
> > +	.reg_defaults = mmc5603_reg_defaults,
> > +	.num_reg_defaults = ARRAY_SIZE(mmc5603_reg_defaults),
> > +};
> > +
> > +static int mmc5603_probe(struct i2c_client *client) {
> > +	struct mmc5603_data *data;
> > +	struct iio_dev *indio_dev;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &mmc5603_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&client->dev, "regmap initialization failed\n");
>
> For all error messages in probe and functions called from probe only use
>
> 		return dev_err_probe(...)
>
> Might be worth
> 	struct device *dev = &client->dev;
> just to shorten a few lines.
>
>
>
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
>
> Is this used?  Normally only needed if we have some pm callbacks around.
>
> > +	data->client = client;
> > +	data->regmap = regmap;
> > +	data->res = MMC5603_20_BITS;
> > +
> > +	mutex_init(&data->mutex);
> For new code I prefer
> 	ret = devm_mutex_init(&data->mutex);
> 	if (ret)
> 		return ret;
>
> Brings only a minor advantage for debugging some use after free conditions
> but it's cheap so why not?
>
> > +
> > +	indio_dev->info = &mmc5603_info;
> > +	indio_dev->name = MMC5603_DRV_NAME;
> > +	indio_dev->channels = mmc5603_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(mmc5603_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = mmc5603_init(data);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "mmc5603 chip init failed\n");
> Another return dev_err_probe()
>
> > +		return ret;
> > +	}
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +// Device tree matching
> As below.
>
> > +static const struct of_device_id mmc5603_of_match[] = {
> > +	{ .compatible = "memsic,mmc5603", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mmc5603_of_match);
> > +
> > +// ACPI matching
> As below.
>
> > +static const struct acpi_device_id mmc5603_acpi_match[] = {
> > +	{"MMC5603", 0},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, mmc5603_acpi_match);
> > +
> > +// Raw I2C matching
> Comment unnecessary and for IIO at least stick to traditional C comments
> except where it's an SPDX tag and slightly different rules apply
>
> /* Raw I2C matching */
>
> > +static const struct i2c_device_id mmc5603_id[] = {
> > +	{ "mmc5603" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mmc5603_id);
> > +
> > +static struct i2c_driver mmc5603_driver = {
> > +	.driver = {
> > +		.name = MMC5603_DRV_NAME,
> > +		.of_match_table = mmc5603_of_match,
> > +		.acpi_match_table = mmc5603_acpi_match,
> > +	},
> > +	.probe = mmc5603_probe,
> > +	.id_table = mmc5603_id,
> > +};
> > +
> > +module_i2c_driver(mmc5603_driver);
> > +
> > +MODULE_AUTHOR("Adrian Fluturel <adrian.fluturel@protonmail.com>");
> > +MODULE_DESCRIPTION("MEMSIC MMC5603 magnetic sensor driver");
> > +MODULE_LICENSE("GPL v2");
>

