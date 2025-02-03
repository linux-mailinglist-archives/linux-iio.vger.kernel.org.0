Return-Path: <linux-iio+bounces-14926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323A8A25BEE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 15:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A23188326E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5952C205E0A;
	Mon,  3 Feb 2025 14:11:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0088.outbound.protection.office365.us [23.103.208.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37263205ADA;
	Mon,  3 Feb 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.208.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591877; cv=fail; b=tXru1+3eE8ZB8VylbxzzLLDfxgsJjKyK8Qn8PL8sMgWi95X0PMH9y5ZtDmrCl0g/eSFYa5RKkYmcYQ0xym6V3o3uSe9PvhcQpp7FWNHBAqq8p8Zfm50lHDn9ZxtiI803eEhFIKWY/t4ai3Jxdf7nsMSVcydHixbaoalSi7kRHWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591877; c=relaxed/simple;
	bh=L0lHwMWECcG0or0FbzASlo3XuWh7+xvBWvM0NPLm+ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWMZE0GsD04D7jaxZGz9CLpiCTm779FYcrh0tPB1Lj0sx7CA8b30WKPxZ2PFTe7uEfM7u4tN0W+svtRF72E2QwcxE3YkLbRIxEabtoTttGAHgnfooI7XlUnRFrf1MyLqAdtx/6UvTrqGwk3Ae2dW8ZvCrEAAXNWEoSSBrk2/olU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org; spf=pass smtp.mailfrom=arka.org; arc=fail smtp.client-ip=23.103.208.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arka.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arka.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=I1106Btn96P4TPbsPRhjinXxFMKX7qGJrQUFkDgxpRLRAnHyOzXZiEFeiOFl6IO5zqlcsNnJsZA+K+k8O+CtDzQzswd0m1v3pFmhN6RRIKi8FpDjWG/evUolJuSvCUiLC9hLJyXDgwSthfyu+Go6AEfUcTXQQosgpbonRDsijyt7m08AnbrAZ96or9oPoj7/goYJA85CuJ1d+Fx+2rc1dvcCyU+KWBekHXZM+buk1DOc3GLcqyMIHK9Bd6ZmCyl0g296+F3i9N5qNMlc1jIsyOlB9FcLOY/bWEGozNb1zVIDL7hdKZbhGXfQEx89ycabGHkGguDzA+EdaWVEhJnTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMR3UFECi993RKEh+JKw/FErIDnrsNuVWGXnMmSdGtM=;
 b=NxJSfTxgzvBMR1BiTGgV2ng3smJX+aXLjK00ZP4b6Pd7u27X0hR+R25PG+xqR3OFMt2IHAUKu43CCT/G5ZzhN2BaT/E2S6ulrn1ledr9HK+7k26/NMnUB2Uk2oUXNve1HD0w9tySLUbRE9M9y98Fv9SK7ehvtkn5V9SpdF1TZvU0iIA0Zf3gzZZlS7PIPYhfcz2U7s0+fe0sDErMmMRpR8QKApX54SB+Pxb7/qxH0fW/WMDGLaWNK/CVZKufLanM4ulKTECB0t+OVZwDOuUao4U4oU4pv8bP7Pn8IaYd6nRjUnsS2V27BCfr4Yld0duNgaUw55zl0Czx/aQNdR9sDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arka.org; dmarc=pass action=none header.from=arka.org;
 dkim=pass header.d=arka.org; arc=none
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::5)
 by SA1P110MB1909.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:1aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Mon, 3 Feb
 2025 13:37:43 +0000
Received: from SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8]) by SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fd7b:b16a:a9df:78e8%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 13:37:43 +0000
From: Sam Winchenbach <swinchenbach@arka.org>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>
Subject: Re: Re: [PATCH v2] iio: filter: admv8818: Force initialization of SDO
Thread-Topic: Re: [PATCH v2] iio: filter: admv8818: Force initialization of
 SDO
Thread-Index: AQHbdkDNbOpQ3gzYq0y2FuiTU/nq9A==
Date: Mon, 3 Feb 2025 13:37:43 +0000
Message-ID:
 <SA1P110MB106984EC5057B1B7F4DC594ABCF5A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References:
 <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
	<20250201111813.6b8cbf5b@jic23-huawei>
	<SA1P110MB1069C9854F796B755E5E24C7BCEBA@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
 <20250202151526.457eab08@jic23-huawei>
In-Reply-To: <20250202151526.457eab08@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arka.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1069:EE_|SA1P110MB1909:EE_
x-ms-office365-filtering-correlation-id: 2a9785da-bf85-45d3-aeb6-08dd4457efef
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Pjzfl0WA88IQcMwY63ysQuDNlB7ttdyQU9ZHejsdsqg/VFirBHLxdxzunnJ5?=
 =?us-ascii?Q?ZJZjJe3GdtufO+cqxlSp1bCZYrN35hcL3eb2b1BZoJbFAZgD4WXreXRDyrRT?=
 =?us-ascii?Q?hCTK1eyDefTyjQNznL8uitLsmd2ruiFtMdY3sxQqGvoesWUUv+5OexYXNl4V?=
 =?us-ascii?Q?+ORjgETygY9a/K8MlkBgBHkyw2Nw1mLxJgzgcB+MSZUMCVswSbAss5unhnzL?=
 =?us-ascii?Q?rvzzUJYLJ31qf5+uTly8ef1bRcqJcs6Wn5QuX/NBcvvTg4rdJ9Qo6zk9yCU9?=
 =?us-ascii?Q?1ijLQ1iDpGHvxXbFJ37hP8xfsYrjyFgYj55hlypgZW28892bRmPBk1qRW1zv?=
 =?us-ascii?Q?PLtba9ddnhJuIBQqFlOBd1iLI9eXmuEJTWHPN/S15hOFMBMtH/glBAVFmsAa?=
 =?us-ascii?Q?fq1Fom6C8f/KCsPDOVfodlUh/Sdr6SXiqAcKD9/mVK82djMvl7IdB8uTxQ3D?=
 =?us-ascii?Q?qxwu6zn0GkVayB9OKChIybabdkEWax4eblAQLeJHKXDc/MRFryDF4uDjCDTu?=
 =?us-ascii?Q?s4+tIIdFAa53T60vlt9VTVzTECbIP2/dpz+Q4S4XJf7itZ4hzyHVlqr0NXSX?=
 =?us-ascii?Q?tN8WflnTAJJ3pXqDL8q8guxn/N4ONaEFkY35iQFroirDZ/M7WUbGSQTYYbAQ?=
 =?us-ascii?Q?leMA4y2DpUhAYNUcmVlhc+1O+3ET4AefDpQnBoGrgwZOEfb9zeVzF7zvZ9JH?=
 =?us-ascii?Q?Q+6WnUe/OFWN87Fjr8lj4/UA3u4u3swjrYUKvK5xo+Hvd7ZUQlak8c2Zrz3N?=
 =?us-ascii?Q?iEkSTRvzkm9kV2keJWtAWTKWsGYGTCE4jnxcgyO6tbIjPeWw/x/N9DNSutua?=
 =?us-ascii?Q?Di/F6qVoetUMVHb7w9uGdlCMah4QMX/5GGwGBABQSgUPpi40LoNR2Kr5Nlct?=
 =?us-ascii?Q?LiEE2XrhAI1rBaFu39XYhzu6luq+ni3OowdwqGoMcKEmPOhRJTngmXa3/+NG?=
 =?us-ascii?Q?Cq017Q3E55mQHZqohb8sfJyGz6lqA1KDNmfhOlmYcR4TwXFHvH9+zld+G8CW?=
 =?us-ascii?Q?l35ZV4ujfCplzsconl6jHbsNJGWgAtFDn11mEeY5nO9ZRzfkqdF0BHqwlO2x?=
 =?us-ascii?Q?E8rYifhTGuZODtyaXcuworFKN5z9+RBQOS1tjE9uU+9y0dAuHbXr+Oun+LOT?=
 =?us-ascii?Q?ZPSxmCDQlZnItDWBxOc4XuKXHlHRxHLmPSd/sjg2MAOEWZgj4M6k82cApPfw?=
 =?us-ascii?Q?WG3MW8y69jouKtpl2ew3L9A7GXbqc136zXlEUhM0Aohlrx5RT9xwMz6bWlES?=
 =?us-ascii?Q?vVtHNMoB1pUYgtQ5CYz1r7uC7XyoQ2tMCq/syaWEXcQZPK147mfGCG3Q6967?=
 =?us-ascii?Q?wd4Hlhsh0axKi4UREp2CG8oKc2mTrHVxYYM64kd7613M6mbKKt3BwXAA9rTG?=
 =?us-ascii?Q?LSFIfC1ceXSJL708+/n3IaNECff0Jd66VX/2QTgE5iMzZhHU5HMUGbdd9/k1?=
 =?us-ascii?Q?zU4bOUFvpYInRzrhVmbbosme7kjF5U4t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?64iz/ObWw68O1Y3gQ/GudZzXiiISinW5yHgNvCjdxB33tKyOL/QEuehVlf3W?=
 =?us-ascii?Q?D67tSk7Tmc43qyrFVtk37OJF1gKbkaKLR/LHbBiwb6UJ0nCzu3R2+bheozS9?=
 =?us-ascii?Q?XkXRBB7Q5zMQx7CZpLeipVuYG51hzfWzcUlruVnnGICQlJ7e6P/ZCJI94ekm?=
 =?us-ascii?Q?DsXSJgT6X/BwKZIXN4N6RmmVyO+a1ocxu55v658EI/poSxHVWAMi69rMC4q6?=
 =?us-ascii?Q?3jz+L7qXEe7qpBVsK6Q/Z9FlKU7ZYn5keytR7sGMvykX2hJLw6uZweusBN1L?=
 =?us-ascii?Q?t61UPK5gu7WrJa0fu93AMGCDiITybP+yF4lelzHUuboti0qdIzQPgxaWhqbW?=
 =?us-ascii?Q?n8jEYMmIRcyxg7ZB1YM8lsOhVcmlTzvbeCHKcLJdGLu77ezSOuPk3efpbvXk?=
 =?us-ascii?Q?NzF8jHZ23jYydnVOdp05/bidBkUt55jBnew8kdPRhzJxpC2N6TvZHuXxoCGm?=
 =?us-ascii?Q?t26f1WpYS6N/+4ynYfR0VMqEDgHXy+jSGqfRqX0RYZXROgJiXD18ECi6LobV?=
 =?us-ascii?Q?onr7mjlxiRO9YXEsR8V6reRmBUWA8eHTBA7Y3RGGgynMvtgV+BVyIOoSq3Ez?=
 =?us-ascii?Q?JB9PdBno2vXxQEw//QV7bUXp/vGPW1qbLQGZtQ3uwiAnXfmIUyBmClrWEBj3?=
 =?us-ascii?Q?JQ5/r6UxJmlnZPiJNzcFqsFxuFJajAh1oSMkruv9Zg7qQcRTAh1xth4JGsMN?=
 =?us-ascii?Q?ri9xQfNlvGXM0GDOEcDxsyg3Jducess48KhJS+iCb2NlEjHnxoulv92QGKY3?=
 =?us-ascii?Q?AbBurgd6oI9czWDxIXkg9zoYzjwPRk52XZLnSbyOQQvM3jhFFTdJsD3cvajr?=
 =?us-ascii?Q?RxpVkzjawrTbEwul5LmCQ/lmTXJQPq7ZwET2myICgrkqxidsuRgrjcBYu5cZ?=
 =?us-ascii?Q?6Qzzi0pAYIbDEUSs1BkSs3JsFbqgmZohMeW1ytmBRyWe10+3loZuUkm/glXV?=
 =?us-ascii?Q?pl12R8wBCkuh0fWRMxJDlcSDX/LDiWzRR9hGumpVGh8dreqe6y/32zyIh/Nv?=
 =?us-ascii?Q?rSq2jlhGJa+XaOcLkHDunRL7gKMaM0QGL/G/X59e7rMDx5nkgzxTl0TXBQjg?=
 =?us-ascii?Q?Y+2Qo6IQEXhR3TjovVLbrBOlBHlj8CwtqlK3A1IqeF0kzmEUaYTDwnLZCDLo?=
 =?us-ascii?Q?fLR120GTQiK8Rkvvxt/Y3XruUccGyon0Q46cBgf7y7Di5pNYQJ4VNinf4K8Z?=
 =?us-ascii?Q?XZZ2REen5vqTG7BW2MnyiVA+0TD4TfSYFhuI3adjZsfBhK40k47PaeD6F6A4?=
 =?us-ascii?Q?TJE6GjZrMnqS7AubNVAImTcjLJXjcZIRId86jFkZ8IAc6dKXcwqP+ewTC9PI?=
 =?us-ascii?Q?tI9N4/3h/VMHRt25/Sg6ItxKRasIT/RnT/BKY28S5rPwsNGDRyx7ioQGxr2f?=
 =?us-ascii?Q?AP6Fid65CPWWHlnn96hOdHdKGCfdtR2NlVlAOCiGZWcFQQRIFKop/MM8gLRl?=
 =?us-ascii?Q?aa7T1y2W+SyfvSVKIs8wJ5ut3NYihAlOF5Y1gVkXhkCgiYIe0FchlKnc23LR?=
 =?us-ascii?Q?EF/UycTKigwss5basFTarQJjZrscdH2NS376?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arka.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9785da-bf85-45d3-aeb6-08dd4457efef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 13:37:43.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 71928351-9f62-452c-b7f4-40bd09a22e1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1909

> > > > When a weak pull-up is present on the SDO line, regmap_update_bits=
=20
> > > > fails to write both the SOFTRESET and SDOACTIVE bits because it=20
> > > > incorrectly reads them as already set.
> > >
> > > I can see this as a valid micro optimization but I'm struggling a bit=
 on how you can use the device if the pull up is weak enough that you can't=
 read data back from it. Does the reset in some way solve that?
> > >
> > > Having asked for the fixes tag, I'm less sure on whether this is a fi=
x.
> > >
> > > Antoniu, I'd also like your input on this one!
> > >
> >
> > On power-up the device is configured without SDO enabled. This, alone, =
makes the read-modify-write during initialization incorrect - It is not pos=
sible to read from the device seeing it is not driving the output.
> >
> > If the SPI bus, like in our situation, has a weak pull-up the situation=
 is compounded. When the device initializes it reads backs all 1's as part =
of the read-modify-write sequence, falsely determines that the soft-reset b=
it is already set and skips resetting the device. The next step is to enabl=
e the SDO line. It reads back all 1's, falsely determines that the SDO is e=
nabled and then skips writing to enable it. This leaves the device in a non=
-functioning state.
> >
> > By writing directly to register it will always perform the reset, and i=
t will always enable SDO regardless of the invalid values read back during =
initialization.
> Ah ok.  So it's a bug with or without appropriate pull up.
> Just happens to be worse if that is missing.
> >
> > > >
> > > > Since the soft reset disables the SDO line, performing a=20
> > > > read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO=20
> > > > line doesn't make sense. This change directly writes to the=20
> > > > register instead of using regmap_update_bits.
> > > >
> > > > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for=20
> > > > ADMV8818")
> > > >
> > >
> > > No blank line here.  Fixes is part of the tags block that various scr=
ipts scan.
> >
> > Is this the blank line after the fixes? I need to do some research to u=
nderstand the tag block.
> Yes - The block of all tags needs to be contiguous. No blank lines.
>=20
> Greg has a script that moans about this, not sure if it also runs on linu=
x-next

Okay. I submitted v3 with this fix. I also setup mutt/send-email so the nex=
t time I submit a patch it won't be quite so painful.
Thank you for the guidance.

>=20
> Jonathan
> >
> > >
> > > > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > > > ---
> > > >  drivers/iio/filter/admv8818.c | 14 ++++----------
> > > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/filter/admv8818.c=20
> > > > b/drivers/iio/filter/admv8818.c index 195e58bc4..9cd1eee84 100644
> > > > --- a/drivers/iio/filter/admv8818.c
> > > > +++ b/drivers/iio/filter/admv8818.c
> > > > @@ -577,21 +577,15 @@ static int admv8818_init(struct admv8818_stat=
e *st)
> > > >       struct spi_device *spi =3D st->spi;
> > > >       unsigned int chip_id;
> > > >
> > > > -     ret =3D regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFI=
G_A,
> > > > -                              ADMV8818_SOFTRESET_N_MSK |
> > > > -                              ADMV8818_SOFTRESET_MSK,
> > > > -                              FIELD_PREP(ADMV8818_SOFTRESET_N_MSK,=
 1) |
> > > > -                              FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1=
));
> > > > +     ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > > > +                        ADMV8818_SOFTRESET_N_MSK |=20
> > > > + ADMV8818_SOFTRESET_MSK);
> > > >       if (ret) {
> > > >               dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
> > > >               return ret;
> > > >       }
> > > >
> > > > -     ret =3D regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFI=
G_A,
> > > > -                              ADMV8818_SDOACTIVE_N_MSK |
> > > > -                              ADMV8818_SDOACTIVE_MSK,
> > > > -                              FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK,=
 1) |
> > > > -                              FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1=
));
> > > > +     ret =3D regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> > > > +                        ADMV8818_SDOACTIVE_N_MSK |=20
> > > > + ADMV8818_SDOACTIVE_MSK);
> > > >       if (ret) {
> > > >               dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
> > > >               return ret;

