Return-Path: <linux-iio+bounces-13081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0BD9E36D4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 10:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23E428526E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90D1A9B5D;
	Wed,  4 Dec 2024 09:41:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3B13AA2E;
	Wed,  4 Dec 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305276; cv=none; b=Ee3XNevBc7SPv1mgNBv3RHRadsbSZr8eL7kB6b6OOoGk8VQBKIKjpYKCOesq43qRQKnJHLbC4aVTYz3jCYo6xne+3wnDtd2DfBAtA/ihkrqzIgRGwEfvtQUkISVznf1tVt7kBJiPs2LsYC0ztP6piOZp8nz1O2yYMkOK6s9kvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305276; c=relaxed/simple;
	bh=tVmbPF2pJpMy5k0c/k1i6rwkCBPV7LEpyNc6zrDcJs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=de7HPw1nn1l3t1UiBT4sk5Py1C6t5pM2fIxfzrl9BB1jkHZ+ZVxnybZbR4gi7GtIjYy6Oxp8z23XrtmPB7By/9QhRNeedfP5mfflhkJQoi7X0xJz/9QLfQwQ+wV1h0WX0qBYgssGpucISRpZC6Fwjc05zVtvtW40ruTAw6wTQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afb23be757so83588137.0;
        Wed, 04 Dec 2024 01:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305271; x=1733910071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I1mx9iMvoMrIftcsdLHcYs1anLKta4hVW8NBR8O1XM=;
        b=NwP09RRo8mVgAC9FGF6a7llfp7NKbERw3lnU9oMEwO4QPumm+B/bny51JFutIkXhFj
         BL98/nJY6KaO0P/BgHmdGKiKK7Av5aVuYL8y0wKlUDS3jFinv3B1fS6ZkPi9mu6RHpbn
         fjO0WkslGqg+FJuxB1uxVMwlLcpAsdRarb8CZLh92+mIHYPwN09oe0/MCDi45oDwpIuW
         uwaQRD/9KqdCwUJbdI6c9jiji4xulynhyu0mU+5rhNQbtKbWX33a8CjUGm+Qi9OelHRJ
         GTsMzN2pbH4xswUV5tRoK5JX47RJskyrB4KCRgFDpBPkOtvRCwd2o2S5caDnub70ax2y
         I91A==
X-Forwarded-Encrypted: i=1; AJvYcCU9uLbaTnHDN6m25IVUdvTArx/LS9omm7lTtBEP9mpDCx1lXwVhleaw8TqtKRoJr0N8SN6EzoH5CUMV@vger.kernel.org, AJvYcCWHMo2tvih24mrhh3PRqkwVIN6nkZS9BRGqAJgRHFPyMmZ6bP5kgeMM+7UaWe52QZ34JQHa3ZYk8Thn@vger.kernel.org, AJvYcCWVNCWVo3i2MrbMRXUOaPpwmGbVH7CzBbDMk2tLVfP/5H7t6ylRCv3UhlT9YK55kexf6eQp1Eg3KMsv9XgL@vger.kernel.org, AJvYcCWpWICwfvmZxwWlaYREgku73cmW2xApSLiLFvdE6XaDRunJUMzOkh/w/NAbTQdmy8xNLup7YZ1gjVpQ@vger.kernel.org, AJvYcCXRP5INpnK7eAc4xHZL77FzskElLlqodIlP7DXh4MJyA9bh1ZXnnR2W2r547kU29YHKBzpW4mZNjNGnUQDL2FQZPGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TXUT75QQMZd5cSyNQFKtvXnPRDNsPezpiIIl/yf5wTUP2uSv
	B8+e7dF0oDroL57gje9TKN9jZ3TSu3jFl8O8An63KyXIff3Lf15/W8gohqT7
X-Gm-Gg: ASbGncvgKonKJSlYKg2uMuyKh9zfMpe5ldnHy9H3S/jCqRPAQDYEzdzixUwxX5m1Fs9
	Jebqfi/LPDF8+3GCDtHw09dflrIUqGybc1hYT7FDhvtnwudsOPJvSPBugwc0TlIvgJiYVlPH96L
	s3/Ex63wUcARX1gH8ERtkUPGKX7qggxd86KLq2v8C0+2XAybUb3Owwg2gsQujzoWJzc2hPUSgW0
	vd2zkTknQEEztdCSY7DIynCCSzcWksii9THe3Hk1EIfOk5UC7g2DScnET1VgcSLLzKZuYDQpiqH
	ZbJvbdCsOC/P
X-Google-Smtp-Source: AGHT+IHQUITYODpk38lmOSp76al6jYxknEGib6bMTxU6siSDzku1pIV2UkJWxBfAu3z1f/D7rZNrXA==
X-Received: by 2002:a05:6102:548a:b0:4a4:8346:186d with SMTP id ada2fe7eead31-4af9731606cmr8190089137.26.1733305271273;
        Wed, 04 Dec 2024 01:41:11 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af592352b8sm2384145137.27.2024.12.04.01.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:41:10 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85bad9e0214so979142241.3;
        Wed, 04 Dec 2024 01:41:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNe99KEpT2QNSLRZMACFKz8nQyB12pkWdVqX8RP/e4ewCXYdcQbwImV4bzgpIqbSHmxMthgyWJkc5LZHSg@vger.kernel.org, AJvYcCW6quHemLO4plfEo/FTNPtW2zgeMUIsxNeTYs6Tob8WrOPByH9FBR9oTinZjVTEs4BBz6M+vZHdUVh1@vger.kernel.org, AJvYcCWQm0fvt+Kdrs1dKsK4HKyo63BHxwuUbvdSrB9Y4BGQbTqUZqnYpwha8MMPe3BueosyhRPHQABnBbbf@vger.kernel.org, AJvYcCWrjAbTk6HWlCPVN7FicfldGiYKweuRI7UaIMYFA7YEafH9ve9XeA64xj1WTH6l7ZrKbMZte2dMO+F6bHN8FN++DPk=@vger.kernel.org, AJvYcCWtGrw43U3nVqTDgrOMQ7V7b30LIwKFo/BRGd1neKXu8TyflqUNpVdg8AKyUYHKC3agZ95xlzxF4k0W@vger.kernel.org
X-Received: by 2002:a05:6102:2929:b0:4af:5f93:3557 with SMTP id
 ada2fe7eead31-4af97183aa1mr6835274137.5.1733305269874; Wed, 04 Dec 2024
 01:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-9-claudiu.beznea.uj@bp.renesas.com> <20241203200941.03ec9ea3@jic23-huawei>
In-Reply-To: <20241203200941.03ec9ea3@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Dec 2024 10:40:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVGXqn2AMfEmTHfOc2pYWs3KB9cJoCEW3gV8d1zsCqg_w@mail.gmail.com>
Message-ID: <CAMuHMdVGXqn2AMfEmTHfOc2pYWs3KB9cJoCEW3gV8d1zsCqg_w@mail.gmail.com>
Subject: Re: [PATCH 08/14] iio: adc: rzg2l_adc: Prepare for the addition of
 RZ/G3S support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Tue, Dec 3, 2024 at 9:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Tue,  3 Dec 2024 13:13:08 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > The ADC IP available on the RZ/G3S differs slightly from the one found =
on
> > the RZ/G2L. The identified differences are as follows:
> > - different number of channels (one being used for temperature conversi=
on);
> >   consequently, various registers differ
> > - different default sampling periods
> > - the RZ/G3S variant lacks the ADVIC register.
> >
> > To accommodate these differences, the rzg2l_adc driver has been updated=
 by
> > introducing the struct rzg2l_adc_hw_params, which encapsulates the
> > hardware-specific differences between the IP variants. A pointer to an
> > object of type struct rzg2l_adc_hw_params is embedded in
> > struct rzg2l_adc_data.
> >
> > Additionally, the completion member of struct rzg2l_adc_data was reloca=
ted
> > to avoid potential padding, if any.
> >
> > The code has been adjusted to utilize hardware-specific parameters stor=
ed
> > in the new structure instead of relying on plain macros.
> >
> > The check of chan->channel in rzg2l_adc_read_raw() function, against th=
e
> > driver specific mask was removed as the subsystem should have already
> > been done this before reaching the rzg2l_adc_read_raw() function.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 92 ++++++++++++++++++++++++++-----------
> >  1 file changed, 64 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index fda8b42ded81..aff41152ebf8 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -32,20 +32,15 @@
> >  #define RZG2L_ADM1_MS                        BIT(2)
> >  #define RZG2L_ADM1_BS                        BIT(4)
> >  #define RZG2L_ADM1_EGA_MASK          GENMASK(13, 12)
> > -#define RZG2L_ADM2_CHSEL_MASK                GENMASK(7, 0)
> >  #define RZG2L_ADM3_ADIL_MASK         GENMASK(31, 24)
> >  #define RZG2L_ADM3_ADCMP_MASK                GENMASK(23, 16)
> > -#define RZG2L_ADM3_ADCMP_E           FIELD_PREP(RZG2L_ADM3_ADCMP_MASK,=
 0xe)
> > -#define RZG2L_ADM3_ADSMP_MASK                GENMASK(15, 0)
> >
> >  #define RZG2L_ADINT                  0x20
> > -#define RZG2L_ADINT_INTEN_MASK               GENMASK(7, 0)
> >  #define RZG2L_ADINT_CSEEN            BIT(16)
> >  #define RZG2L_ADINT_INTS             BIT(31)
> >
> >  #define RZG2L_ADSTS                  0x24
> >  #define RZG2L_ADSTS_CSEST            BIT(16)
> > -#define RZG2L_ADSTS_INTST_MASK               GENMASK(7, 0)
> >
> >  #define RZG2L_ADIVC                  0x28
> >  #define RZG2L_ADIVC_DIVADC_MASK              GENMASK(8, 0)
> > @@ -56,12 +51,26 @@
> >  #define RZG2L_ADCR(n)                        (0x30 + ((n) * 0x4))
> >  #define RZG2L_ADCR_AD_MASK           GENMASK(11, 0)
> >
> > -#define RZG2L_ADSMP_DEFAULT_SAMPLING 0x578
> > -
> > -#define RZG2L_ADC_MAX_CHANNELS               8
> > -#define RZG2L_ADC_CHN_MASK           0x7
> >  #define RZG2L_ADC_TIMEOUT            usecs_to_jiffies(1 * 4)
> >
> > +/**
> > + * struct rzg2l_adc_hw_params - ADC hardware specific parameters
> > + * @default_adsmp: default ADC sampling period (see ADM3 register)
> > + * @adsmp_mask: ADC sampling period mask (see ADM3 register)
> > + * @adint_inten_mask: conversion end interrupt mask (see ADINT registe=
r)
> > + * @default_adcmp: default ADC cmp (see ADM3 register)
> > + * @num_channels: number of supported channels
> > + * @adivc: specifies if ADVIC register is available
> > + */
> > +struct rzg2l_adc_hw_params {
> > +     u16 default_adsmp;
> > +     u16 adsmp_mask;
> > +     u16 adint_inten_mask;
> > +     u8 default_adcmp;
> > +     u8 num_channels;
> > +     bool adivc;
> > +};
> > +
> >  struct rzg2l_adc_data {
> >       const struct iio_chan_spec *channels;
> >       u8 num_channels;
> > @@ -71,10 +80,11 @@ struct rzg2l_adc {
> >       void __iomem *base;
> >       struct reset_control *presetn;
> >       struct reset_control *adrstn;
> > -     struct completion completion;
> >       const struct rzg2l_adc_data *data;
> > +     const struct rzg2l_adc_hw_params *hw_params;
> > +     u16 *last_val;
> > +     struct completion completion;
> >       struct mutex lock;
> > -     u16 last_val[RZG2L_ADC_MAX_CHANNELS];
>
> Just make this big enough for the max device.  Chances are it will make l=
ittle or
> no difference to this allocation and nice to avoid the dynamic part.
>
> Feel free to add a runtime check to make sure this is big enough to avoid=
 any
> future problems with forgetting to update it.

Flexible array member and the new __counted_by() attribute?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

