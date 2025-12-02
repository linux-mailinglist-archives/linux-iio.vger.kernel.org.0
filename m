Return-Path: <linux-iio+bounces-26654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C3C9D15E
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 22:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7B4F4E4068
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169BD2F9C2A;
	Tue,  2 Dec 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXVsryoy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17F2F8BD2
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710840; cv=none; b=BqKpJYi1Hg+pfsvHIvbIivhSeQ4AX0GDiwBvh12iqL9iEGAFq1OnbgTasTNnYN4Tz1xcQVs70a8fY2/9YFuc87YSc0zJXT1KX1koQTyUJbqDt/S2A5T2hTHgRN4+XKAjAjZWuh0mDzPpmloq/Ru/efET1qag8chl3a8WAlRih5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710840; c=relaxed/simple;
	bh=IF4JIJy9AebTLa+7WBComoEINwMkvEmXkt0dVcdjLmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeAkH+V6rq4qa9Ndxk2N1pBEhLytBpJx3w/IHLAqoa6mInDuImMp3/lQIWOzFo7rRN5GRWjbfcaQZNgGdUFpmlU1KJaimtU0Q9DhvOKCnfn6G7tM6I6FEjhiDH4kNLhp22bjICEerlb3BwB0TN/x6E3yqgUFNIgqOTHbP602RYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXVsryoy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so9238522a12.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764710837; x=1765315637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izHpBo4KfWQtDeefh6EvIJ4kME03b+71gsYy+yYHuR4=;
        b=CXVsryoyJi2HlOkTMwa9LOcPick8gz1teoSTDd703cR8EgyKjBOeaLkMNuXPkW6je3
         /jUUdKHQkjsKniuaezTATRxqWs2uDrS1A9oTWjaEO3faUTVrDTc/Z3y92Gj3ZvTfQdHK
         PHZR3ENJGhfg3EL2JqFDnR7ZP/iaymyTdO00Y67QZStn3BS6RkOX1wXn989cn2waopDz
         EMBWQA3TXpHOdDdpb142wfNuKBQLZJ9EAaFufqstJBadFulqoW1TUYJBdC7ILtGKLs62
         uHn0Jv6YknnznhbC25VYCkRLbmUjfHNT4DvmhRTQj9Ew/DmMKoQCcMRk1MXvkxCuUF/K
         rkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710837; x=1765315637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izHpBo4KfWQtDeefh6EvIJ4kME03b+71gsYy+yYHuR4=;
        b=LUhmjtukK5c0voUdwVWK4w47WjJlD+uENXaLt0BIbZs2DCA5W9UgV0wzXcCrGwcbKE
         H2dSesQ2XqdZ+df+CqwhpOpfQfUR1iveaod73PnGCHLXrMZodN2bYucTDGGxPhVYUdjM
         n9cfnkMjFHLfZnq7WxQnjHub1E8sdQc8w6tx5cwv9yeuAFy8YANpL0GrlmpwWqlyurFW
         m45BmA945Me5+9sKzt1YMwraU9dG2v3Ld5aPWtYGYIksAEwOg5kfyBo6nHzGGg9O9Se+
         KYmPwgRtNzw3YVxUJPbrokIrMkb9A++WbYwsKY9Ez6EoN2oGfMQFHrseQYgdH5e0cNJL
         9SiQ==
X-Gm-Message-State: AOJu0Yz9YTdjaSI1I5/BI/DUUzLlOYKuSnpNARGoRW1l03hn6BN2/P47
	4qD55FnsNLEj6bgxJ1oaWfLaSHzpkPr6eFEF2oyEWnBXV1F+VrE0hXWMH6Q74soWL5YiDcoiIQY
	etylOtugUnURDw0TEDoRVTlYA1CFMudk=
X-Gm-Gg: ASbGnctRfzH+bBIFQFV/ibVkfxsshZkDyXc6r5boHNzMvkssMGHQbrmh1c1FG6pRXve
	XFWUTVkYafvJR/f/2SVXm141x1PRk15tePuSgw4AE0V6pLEiGEDjwip4d8OSo7kf8cH3IMk/8r3
	B8KJNeWxPLS90xp3dzWBJJtyNE2m/QtWsWkVTywBkLeQmQJ4jY33zpglYqAdPp2cODvVNcKaamq
	E4zq11yJNWjcP4I1/y+MKTthAvNG0nAm5EJ45+GpjgwUaJhjsXLxayN8G5JnRhFbSEsh+QbpWFm
	tItJT3eXiQfasFMoN7mol52hldLksf4wdjBk45NV19P1v4ZXF/T0+7l/nhzXThtN3UG7ZqypgkC
	QQhyA4g==
X-Google-Smtp-Source: AGHT+IFi4VqAeQ6ylauCI6SfoeNuTHJk9Yg/0Yr9DgMxNTCiwD+q5tOWVzR64YvQJS5zYnsWgG+Guc5cp8GP5risKAY=
X-Received: by 2002:a17:907:7fa2:b0:b70:b3cb:3b30 with SMTP id
 a640c23a62f3a-b76c5595bb8mr3560613866b.59.1764710837088; Tue, 02 Dec 2025
 13:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764708608.git.marcelo.schmitt@analog.com> <c189c25b1c46f406c3f7942e5ac4cdb0b964ee52.1764708608.git.marcelo.schmitt@analog.com>
In-Reply-To: <c189c25b1c46f406c3f7942e5ac4cdb0b964ee52.1764708608.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Dec 2025 23:26:38 +0200
X-Gm-Features: AWmQ_blOI9-8RPZg0XCvO-iUC7cg8_MvPG-sGlHea2wNFEI3gTFMs76_JdYkyUY
Message-ID: <CAHp75Vf7p=aPy2ofC_zVz1PURA3R9i0WZCG63-dCEXO=xKJ0FA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Initial support for AD4134
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:55=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> analog-to-digital converter (ADC). The device can be managed through SPI =
or
> direct control of pin logical levels (pin control mode). The AD4134 desig=
n
> also features a dedicated bus for ADC sample data output. Though, this
> initial driver for AD4134 only supports usual SPI connections.
>
> Add basic support for AD4134 that enables single-shot ADC sample read.

...

> I tried using the reset-gpio driver to handle AD4134 reset GPIO. I had ch=
anged
> the device tree to set a reset-controller node and had referenced that fr=
om the
> ADC node. I also updated the ad4134 driver to use a reset controller to h=
andle
> its reset GPIO. Though, after those changes, the AD4134 driver would defe=
r
> device initialization forever because it missed a reset-controller. To ma=
ke the
> reset-gpio driver probe and instantiate a reset controller, it would take=
 a
> platform device to be set within a machine-specific, hardcoded platform d=
ata.
> AD4134 is not bound to any specific platform, so it doesn't make much sen=
se to
> have a reset-gpio platform device for that. Thanks for mentioning reset-g=
pio. It
> was interesting looking into the reset-gpio driver and the reset framewor=
k. It
> looks cool. But I don't think the reset-gpio driver suits the AD4134 rese=
t use
> case.

Bart converted it to be an aux driver and it should work. Please, give
a try after v6.19-rc1 is out.

...

> +       /*
> +        * To be able to read data from all 4 channels through a single l=
ine, we
> +        * set DOUTx output format to 0 in the digital interface config r=
egister
> +        * (0x12). With that, data from all four channels is serialized a=
nd
> +        * output on DOUT0. During probe, we also set SDO_PIN_SRC_SEL in

During the probe

> +        * DEVICE_CONFIG_1 register to duplicate DOUT0 on the SDO pin. Co=
mbined,
> +        * those configurations enable ADC data read through a convention=
al SPI
> +        * interface. Now we read data from all channels but keep only th=
e bits
> +        * from the requested one.
> +        */
> +       for (i =3D 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
> +               ret =3D spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
> +                                         BITS_TO_BYTES(AD4134_CHAN_PRECI=
SION_BITS));
> +               if (ret)
> +                       return ret;
> +
> +               if (i !=3D AD4134_VREG_CH(reg))
> +                       continue;
> +               *val =3D get_unaligned_be24(st->rx_buf);

Hmm...

In this case it might be better to  use

  if (i =3D=3D ...)
    *val =3D ...

but it's still unclear on how many times the conditional can be true
in the loop.

> +       }

...

> +static int ad4134_clock_select(struct ad4134_state *st)
> +{
> +       struct device *dev =3D &st->spi->dev;
> +       struct clk *sys_clk;
> +
> +       /*
> +        * AD4134 requires one external clock source and only one externa=
l clock
> +        * source can be provided at a time. Try get a crystal provided c=
lock.
> +        * If that fails, try to get a CMOS clock.
> +        */
> +       sys_clk =3D devm_clk_get_optional_enabled(dev, "xtal1-xtal2");
> +       if (IS_ERR_OR_NULL(sys_clk)) {
> +               if (PTR_ERR(sys_clk) =3D=3D -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;

But this will ignore other errors when clock _is_ available.

This should be as simple as

sys_clk =3D devm_clk_get_...(...);
if (!sys_clk)
  sys_clk =3D devm_clk_get_enabled(...);
if (IS_ERR(...))
  return dev_err_probe(..., PTR_ERR(...), ...);

See how other drivers do in the similar situation (IIRC 8250_dw does this).

> +               /* Try the CMOS clock */
> +               sys_clk =3D devm_clk_get_enabled(dev, "clkin");
> +               if (IS_ERR(sys_clk)) {
> +                       if (PTR_ERR(sys_clk) =3D=3D -EPROBE_DEFER)
> +                               return -EPROBE_DEFER;
> +
> +                       return dev_err_probe(dev, PTR_ERR(sys_clk),
> +                                            "failed to get external cloc=
k\n");
> +               }
> +       }
> +
> +       st->sys_clk_hz =3D clk_get_rate(sys_clk);
> +       if (st->sys_clk_hz !=3D AD4134_EXT_CLOCK_MHZ)
> +               dev_warn(dev, "invalid external clock frequency %lu\n",
> +                        st->sys_clk_hz);
> +
> +       return 0;
> +}

...

> +       reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> +       if (IS_ERR(reset_gpio))
> +               return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +                                    "failed to find reset GPIO\n");
> +
> +       if (reset_gpio) {
> +               fsleep(AD4134_RESET_TIME_US);
> +               gpiod_set_value_cansleep(reset_gpio, 0);
> +       }

I still think that reset-gpio driver is the right way to go (after
Bart's changes, which should be part of v6.19-rc1).

...

The rest LGTM.

--=20
With Best Regards,
Andy Shevchenko

