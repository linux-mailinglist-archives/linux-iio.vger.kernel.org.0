Return-Path: <linux-iio+bounces-23689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F11B4260D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A76F1890664
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D4299A85;
	Wed,  3 Sep 2025 15:57:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31351288C34;
	Wed,  3 Sep 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915024; cv=none; b=gVK47UgM3eYK/3xlBljLM9o9mcn2mA8jkJnhGGgCRJjgfeX69g2Nl73H7cK+5bwlPvcKGEDKlmjscfKsECX+wV8d1UiNBTvBAuapn7ez8Xosf8Yo886mUkw/rmDCd8vPJtnKAfb73V6eZlGPbRn2PnMuhVrlGXkj5swH6Rca9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915024; c=relaxed/simple;
	bh=xgruJY70XCMa147iGgxAQGJXOf5yGwR93Wdz3hxbdi8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thWlXeZM+uc61SyzZ/yW4E4+QbsOsvihvyA7Otc3b5iW4Ck+8aYibkpBYrFgClfxCzlNRbcaPNZs5WmN/eckM3ONaMakGrIgDG5p0Sx2Y2dI9UnWWohT4Rhs2+mUZwHfQNB34jcEB0l9yAnn1rLhy4sYpp4qHwatL3vhNvNzhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cH6J52WPsz6HJbP;
	Wed,  3 Sep 2025 23:40:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B9D87140275;
	Wed,  3 Sep 2025 23:41:14 +0800 (CST)
Received: from localhost (10.202.227.251) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 3 Sep
 2025 17:41:13 +0200
Date: Wed, 3 Sep 2025 16:41:11 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <s32@nxp.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <chester62515@gmail.com>, <mbrugger@suse.com>,
	<ghennadi.procopciuc@oss.nxp.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20250903164111.00004bc6@huawei.com>
In-Reply-To: <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
	<20250903102756.1748596-3-daniel.lezcano@linaro.org>
	<eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 03 Sep 2025 12:20:39 +0100
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
> > From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> >=20
> > The NXP S32G2 and S32G3 platforms integrate a successive approximation
> > register (SAR) ADC. Two instances are available, each providing 8
> > multiplexed input channels with 12-bit resolution. The conversion rate
> > is up to 1 Msps depending on the configuration and sampling window.
> >=20
> > The SAR ADC supports raw, buffer, and trigger modes. It can operate
> > in both single-shot and continuous conversion modes, with optional
> > hardware triggering through the cross-trigger unit (CTU) or external
> > events. An internal prescaler allows adjusting the sampling clock,
> > while per-channel programmable sampling times provide fine-grained
> > trade-offs between accuracy and latency. Automatic calibration is
> > performed at probe time to minimize offset and gain errors.
> >=20
> > The driver is derived from the BSP implementation and has been partly
> > rewritten to comply with upstream requirements. For this reason, all
> > contributors are listed as co-developers, while the author refers to
> > the initial BSP driver file creator.
> >=20
> > All modes have been validated on the S32G274-RDB2 platform using an
> > externally generated square wave captured by the ADC. Tests covered
> > buffered streaming via IIO, trigger synchronization, and accuracy
> > verification against a precision laboratory signal source.
> >=20
> > Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp=
.com>
> > Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.c=
om>
> > Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> > Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> > Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> > Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > --- =20
>=20
> Hi David,
>=20
> Just some minor review for now...
A couple of follow ups (ignoring the DMA buf as others are better
than I am to comment on that!)

> > +/*
> > + * The documentation describes the reset values for the
> > + * registers. However some registers do not have these values after a
> > + * reset. It is a not desirable situation. In some other SoC family
> > + * documentation NXP recommend to not assume the default values are
> > + * set and to initialize the registers conforming to the documentation
> > + * reset information to prevent this situation. Assume the same rule
> > + * applies here as there is a discrepancy between what is read from
> > + * the registers at reset time and the documentation.
> > + */
> > +static void nxp_sar_adc_set_default_values(struct nxp_sar_adc *info)
> > +{
> > +	const u32 mcr_default	=3D 0x00003901;
> > +	const u32 msr_default	=3D 0x00000001;
> > +	const u32 ctr_default	=3D 0x00000014;
> > +	const u32 cimr_default	=3D 0x00000000;
> > +	const u32 ncmr_default	=3D 0x00000000;
> > + =20
>=20
> const does not really bring much here. I would rather have them as #defin=
es.

Unless they can be broken down into meaningful fields I'd
not bother with defines. Just put the values in the writel()
as their meaning is clear from what is being registered.

>=20
> > +	writel(mcr_default, REG_ADC_MCR(info->regs));
> > +	writel(msr_default, REG_ADC_MSR(info->regs));
> > +	writel(ctr_default, REG_ADC_CTR0(info->regs));
> > +	writel(ctr_default, REG_ADC_CTR1(info->regs));
> > +	writel(cimr_default, REG_ADC_CIMR0(info->regs));
> > +	writel(cimr_default, REG_ADC_CIMR1(info->regs));
> > +	writel(ncmr_default, REG_ADC_NCMR0(info->regs));
> > +	writel(ncmr_default, REG_ADC_NCMR1(info->regs));
> > +}

> > +};
> > +MODULE_DEVICE_TABLE(of, nxp_sar_adc_match);
> > +
> > +static struct platform_driver nxp_sar_adc_driver =3D {
> > +	.probe=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D nxp_sar_adc_probe,
> > +	.remove=A0=A0=A0=A0=A0=A0=A0=A0 =3D nxp_sar_adc_remove,
> > +	.driver=A0=A0=A0=A0=A0=A0=A0=A0 =3D {
> > +		.name=A0=A0 =3D DRIVER_NAME,
> > +		.of_match_table =3D nxp_sar_adc_match,
> > +#ifdef CONFIG_PM_SLEEP =20
>=20
> You should not need the above. Look at pm_ptr() and friends.

Further to that, DEFINE_SIMPLE_DEV_PM_OPS() and drop the guards
around the functions.  The trick here is that it exposes
the functions to the compiler but lets it figure out they aren't
actually used and drop them.  All with out ifdef or __maybe_unused
etc.

>=20
> > +		.pm=A0=A0=A0=A0 =3D &nxp_sar_adc_pm_ops,
> > +#endif
> > +	},
> > +};
> > +
> > +module_platform_driver(nxp_sar_adc_driver);
> > +
> > +MODULE_AUTHOR("NXP");
> > +MODULE_DESCRIPTION("NXP SAR-ADC driver");
> > +MODULE_LICENSE("GPL"); =20
>=20


