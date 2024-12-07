Return-Path: <linux-iio+bounces-13198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A19E8143
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACA118846B3
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541F7149DF7;
	Sat,  7 Dec 2024 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAryukcp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12921494AD;
	Sat,  7 Dec 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593064; cv=none; b=f2X6bV/68v22ivs08KKP/AE0CRxyxE+WT4IcJ0jIJpXO5VGVZQrlSD2+5zam9/J0nnCE70Gz2sA+6yOpPW94Y3dwqyFJkn81IEm79gJOn/z0inDctcUFcbAeWHQehBmdiJswviFTI9cEGFGUTCv3r6QZWVrdmKTgfriYz5BUpy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593064; c=relaxed/simple;
	bh=ox1B8to36A/KHcuaMZ8cKSQ7KleVJ/upW6RNLQBXHCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ds6qGEJo9EebrzRfYOsyNzZokzp2Mcyw/4ML6vn82/HkO4VzXZ7K/aCNGNnZpghBn+E4HLdtRbsNArU/AowOK0b4dDGPHS/yKz5nMg6cFeUAc76cEQizXkCUXi8udlTZg390WDeAXmC4jGOOrkKSQPtLxsmWFBTLr/o1QC2kNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAryukcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28863C4CECD;
	Sat,  7 Dec 2024 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733593063;
	bh=ox1B8to36A/KHcuaMZ8cKSQ7KleVJ/upW6RNLQBXHCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LAryukcphYBSkaUrTHag+XyG8cjAF4kRY4aayo7dZwPzeY7AwtVCKmgGneWBw4XvT
	 g/+yOHZfURmVzejw95Bru6ZU3uxh2CrVMNGIzZcJfJxo8YvZKDW4MIk8E3ux9xsqQI
	 DOiU4xbUp2bnRoa2TAUUU43cXFRa4SQDZvBpuppFNv4rkl0OKPr0LfNVNkf2MwYIhj
	 VaCbsWvqrTsX0cZzasapxH7DnS5Xz5p604vsAGIBwh75NRFbAPaema06r/9K9LyvfH
	 eJAR4VedFHdsOBIIyen4OteZEaxNaftD+Oe81KsAvj5tqpxrzXxOhW9CVS7hSQ1+/b
	 XxzRZOtIgunUg==
Date: Sat, 7 Dec 2024 17:37:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
 magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 08/14] iio: adc: rzg2l_adc: Prepare for the addition of
 RZ/G3S support
Message-ID: <20241207173731.523ce96b@jic23-huawei>
In-Reply-To: <CAMuHMdVGXqn2AMfEmTHfOc2pYWs3KB9cJoCEW3gV8d1zsCqg_w@mail.gmail.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-9-claudiu.beznea.uj@bp.renesas.com>
	<20241203200941.03ec9ea3@jic23-huawei>
	<CAMuHMdVGXqn2AMfEmTHfOc2pYWs3KB9cJoCEW3gV8d1zsCqg_w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 10:40:58 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Jonathan,
>=20
> On Tue, Dec 3, 2024 at 9:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> > On Tue,  3 Dec 2024 13:13:08 +0200
> > Claudiu <claudiu.beznea@tuxon.dev> wrote: =20
> > > The ADC IP available on the RZ/G3S differs slightly from the one foun=
d on
> > > the RZ/G2L. The identified differences are as follows:
> > > - different number of channels (one being used for temperature conver=
sion);
> > >   consequently, various registers differ
> > > - different default sampling periods
> > > - the RZ/G3S variant lacks the ADVIC register.
> > >
> > > To accommodate these differences, the rzg2l_adc driver has been updat=
ed by
> > > introducing the struct rzg2l_adc_hw_params, which encapsulates the
> > > hardware-specific differences between the IP variants. A pointer to an
> > > object of type struct rzg2l_adc_hw_params is embedded in
> > > struct rzg2l_adc_data.
> > >
> > > Additionally, the completion member of struct rzg2l_adc_data was relo=
cated
> > > to avoid potential padding, if any.
> > >
> > > The code has been adjusted to utilize hardware-specific parameters st=
ored
> > > in the new structure instead of relying on plain macros.
> > >
> > > The check of chan->channel in rzg2l_adc_read_raw() function, against =
the
> > > driver specific mask was removed as the subsystem should have already
> > > been done this before reaching the rzg2l_adc_read_raw() function.
> > >
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > ---
> > >  drivers/iio/adc/rzg2l_adc.c | 92 ++++++++++++++++++++++++++---------=
--
> > >  1 file changed, 64 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > > index fda8b42ded81..aff41152ebf8 100644
> > > --- a/drivers/iio/adc/rzg2l_adc.c
> > > +++ b/drivers/iio/adc/rzg2l_adc.c
> > > @@ -32,20 +32,15 @@
> > >  #define RZG2L_ADM1_MS                        BIT(2)
> > >  #define RZG2L_ADM1_BS                        BIT(4)
> > >  #define RZG2L_ADM1_EGA_MASK          GENMASK(13, 12)
> > > -#define RZG2L_ADM2_CHSEL_MASK                GENMASK(7, 0)
> > >  #define RZG2L_ADM3_ADIL_MASK         GENMASK(31, 24)
> > >  #define RZG2L_ADM3_ADCMP_MASK                GENMASK(23, 16)
> > > -#define RZG2L_ADM3_ADCMP_E           FIELD_PREP(RZG2L_ADM3_ADCMP_MAS=
K, 0xe)
> > > -#define RZG2L_ADM3_ADSMP_MASK                GENMASK(15, 0)
> > >
> > >  #define RZG2L_ADINT                  0x20
> > > -#define RZG2L_ADINT_INTEN_MASK               GENMASK(7, 0)
> > >  #define RZG2L_ADINT_CSEEN            BIT(16)
> > >  #define RZG2L_ADINT_INTS             BIT(31)
> > >
> > >  #define RZG2L_ADSTS                  0x24
> > >  #define RZG2L_ADSTS_CSEST            BIT(16)
> > > -#define RZG2L_ADSTS_INTST_MASK               GENMASK(7, 0)
> > >
> > >  #define RZG2L_ADIVC                  0x28
> > >  #define RZG2L_ADIVC_DIVADC_MASK              GENMASK(8, 0)
> > > @@ -56,12 +51,26 @@
> > >  #define RZG2L_ADCR(n)                        (0x30 + ((n) * 0x4))
> > >  #define RZG2L_ADCR_AD_MASK           GENMASK(11, 0)
> > >
> > > -#define RZG2L_ADSMP_DEFAULT_SAMPLING 0x578
> > > -
> > > -#define RZG2L_ADC_MAX_CHANNELS               8
> > > -#define RZG2L_ADC_CHN_MASK           0x7
> > >  #define RZG2L_ADC_TIMEOUT            usecs_to_jiffies(1 * 4)
> > >
> > > +/**
> > > + * struct rzg2l_adc_hw_params - ADC hardware specific parameters
> > > + * @default_adsmp: default ADC sampling period (see ADM3 register)
> > > + * @adsmp_mask: ADC sampling period mask (see ADM3 register)
> > > + * @adint_inten_mask: conversion end interrupt mask (see ADINT regis=
ter)
> > > + * @default_adcmp: default ADC cmp (see ADM3 register)
> > > + * @num_channels: number of supported channels
> > > + * @adivc: specifies if ADVIC register is available
> > > + */
> > > +struct rzg2l_adc_hw_params {
> > > +     u16 default_adsmp;
> > > +     u16 adsmp_mask;
> > > +     u16 adint_inten_mask;
> > > +     u8 default_adcmp;
> > > +     u8 num_channels;
> > > +     bool adivc;
> > > +};
> > > +
> > >  struct rzg2l_adc_data {
> > >       const struct iio_chan_spec *channels;
> > >       u8 num_channels;
> > > @@ -71,10 +80,11 @@ struct rzg2l_adc {
> > >       void __iomem *base;
> > >       struct reset_control *presetn;
> > >       struct reset_control *adrstn;
> > > -     struct completion completion;
> > >       const struct rzg2l_adc_data *data;
> > > +     const struct rzg2l_adc_hw_params *hw_params;
> > > +     u16 *last_val;
> > > +     struct completion completion;
> > >       struct mutex lock;
> > > -     u16 last_val[RZG2L_ADC_MAX_CHANNELS]; =20
> >
> > Just make this big enough for the max device.  Chances are it will make=
 little or
> > no difference to this allocation and nice to avoid the dynamic part.
> >
> > Feel free to add a runtime check to make sure this is big enough to avo=
id any
> > future problems with forgetting to update it. =20
>=20
> Flexible array member and the new __counted_by() attribute?
Messy as it's embedded in iio_dev via a rather round about route.
It happens to be at the end of that structure but that's an implementation =
detail.

So in this particular case I'd go with no for flexible array and __counted_=
by.
It is very unlikely the difference in size will actually result in a bigger=
 allocation
as it's a substantial allocation however big this is.

Jonathan

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20


