Return-Path: <linux-iio+bounces-23434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2609B3C8F9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 09:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194B81C24BB6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4D2848B1;
	Sat, 30 Aug 2025 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0gJBgbE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF31E5710;
	Sat, 30 Aug 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756540666; cv=none; b=NJIVWuRl+2wGiVm8uCNlKvnyH/A7pKRFwW9DR6twGFazwmQA3Q91TatnnBqPtpmtvrZMcK1X+KyxQWv+ndtsScP5yj2FEwzv/y9QUt73T3g1/sk4BuytPXWsoVtWpEocHpQCINZ8/z2aSTuAxiv4fdnWm72ed1Y/57rwXUILmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756540666; c=relaxed/simple;
	bh=+2+Gj1nNHKpL+N9u8qZn9hF2ACrmy8ud9G7KUHU3RQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiU3jh6L91BDn5VLIbfofygmEJpA3b3XXON6y8BvZUK+TFOwiiXTvf82mhGLQjLkMEGPtWrsLP5PMM0eHRsJ3DL5JluoYmytYt82jrEbxgHhYMWjn1eO4NiFOjYFFxdX6oXuIcntMcorq9shT+jmnUtaxbHyUM7Th/sCQ034I/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0gJBgbE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aff0775410eso180564466b.0;
        Sat, 30 Aug 2025 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756540663; x=1757145463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xzYpIPBYEfD30svdRD/8XJR3PeRfEwoaHDcvFNvN3Q=;
        b=X0gJBgbEOMwlVvKqNelyu6lL+R2SjWnRhl/doU3FjZzwAKiFEg0uZw4nqUvV4zT2r2
         L1wdLZdTF9ooD236N3qmPi+Kvv4JwyYUD1fVWjO2zrEyKKrvnyl1iIEVje8qtNTh0CRt
         NwBKwrXhFY2R9LH8fdigNlqVJSb18S7Y5rOvYWi8M8GCiBVhSPsmjJ9D5YLrhsdu4zZY
         m0cXw9NGrNMEsxLDLftDG+2u2HVaIJaT3g94NLqGN8qUnwzpOe6U6CFxnnPz6u5oLp5B
         yRk55CgIEZlTXOgt9CY3rTqLB3Jbamv3O9pS4px5jhgUyfmxoO/qCtMKQut2uSUtmJnQ
         YCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756540663; x=1757145463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xzYpIPBYEfD30svdRD/8XJR3PeRfEwoaHDcvFNvN3Q=;
        b=GZwC+E7xNIeb2xKLh43SvohY7MwWXFMJyUlVgsFTYWV0tPNwo1y4OIF9sHiK+E7IcJ
         UvhhADJ3jrcERseogTtKqLo14GDrAQY/77IWZWmTdNMGRrR0iHaM69oseuuhG0gTtMhe
         kKrKS5cWjZsNYlFW3DnlMiaT1TEuVzR02el/hh6KC9lE0y+kJyctTYt2nOqY84C6gDPB
         O7fxhP+moCDoISAjXMdvcJAdAbua17ACh8n75M5v0oIDF1zW8UQ9NXOCSZyi7lBBqGX9
         M8pXyWMkBP+ufXOoYzOvSB5nsL8rZ4ul040q12VjQcHDNQnbYl00UQZS4OoJFv05gRVo
         ovbg==
X-Forwarded-Encrypted: i=1; AJvYcCURnHWjaXsaEkHs/hHfTDXfv1pgdfQWNluj5j88rwL0BeFo6k+pDVM93kMXW9n/XJ+l7UPuGLHAruw8XIKP@vger.kernel.org, AJvYcCUfkAzfavoqIjIo3IGzlV9p+KjdAhteYkba5iX5AM++aCwX9Q9elXiWyEGIyrfy8ORiafaP0dMNdEU1@vger.kernel.org, AJvYcCWtBcUbVPJffoPe/WL8fAElWEth2fvqRy+iB2ylp9+rdB/5xnInJsuKS2Pwxh8ri46Jj8I199znAFsP@vger.kernel.org, AJvYcCXZx3J0Nbw3aIulmPADvMmBXsiLcp1FIkHZe6EyQp7jty7wZ5NEPZlkoxbsxjPgzg70IOeJ8tQEi07H@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2PuxoOIlLh8OD1oltmo2nq8qU2rZvzHSrQu3MSIUfbCAD3x6
	DZ+3uSZRYoJidMwFmHTadGfHmatcXBxuPnavH4vt0LHor8yjtF9kfu3Z8uFtfk3pDMICXUgVW6r
	lD8Xv2cofmPU+sLoTjrbcUI82ijw/qzfQutF+g/0=
X-Gm-Gg: ASbGncu1bCbHwr5Qoo/AZzlVSf5ppn3PuY3Vm+dsB44UfrdHGwasQdtg+DHmetVYjwV
	AJApRCjRaaQxO8vluSPvx9Uud4Y6JxAkAWuXTEVQVpsb3Y4MhNjWy1Ml8GUka+MIm23t+W53Auo
	SRKUVV56q/+XhFkJpih8F1dTBrx9werQ0YrErwvcQhCtB5jc8i0XborqG+cov29lFoPIzncq42o
	UpB/d0=
X-Google-Smtp-Source: AGHT+IFLFaJZMNtcY4bSeieEVUiOrD9u71emls8SkXMWkt+Cd9A3UVgZvQN5+DgDo/fD1simHs+bT5eet1sbhBXtbNA=
X-Received: by 2002:a17:907:8694:b0:aff:1586:14c2 with SMTP id
 a640c23a62f3a-b01d8a58373mr129215966b.4.1756540662463; Sat, 30 Aug 2025
 00:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <006ac88a667ce0d2c751946b562af83d0f27a44f.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 10:57:06 +0300
X-Gm-Features: Ac12FXyTcea0WOAjGBKoJRyBZ-wQfLv5c18Ob1a_Rdr7ObF9Kvv_OchzjH_ruYw
Message-ID: <CAHp75VdeSqwVecJHx+jXn9++zgN+CBH56OGUYX5kBbdc0AFKSA@mail.gmail.com>
Subject: Re: [PATCH 15/15] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, jic23@kernel.org, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com, 
	andy@kernel.org, corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, Jonathan.Cameron@huawei.com, 
	andriy.shevchenko@linux.intel.com, ahaslam@baylibre.com, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:46=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> that scales the analog input signal prior to it reaching the ADC. The PGA
> is controlled through a pair of pins (A0 and A1) whose state define the
> gain that is applied to the input signal.
>
> Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> through the IIO device channel scale available interface and enable contr=
ol
> of the PGA through the channel scale interface.

...

>  /* Datasheet says 9.8ns, so use the closest integer value */
>  #define AD4030_TQUIET_CNV_DELAY_NS     10

You already used that in one of the previous patches, can you move
there this one and use instead of magic +=3D 10?


> +/* HARDWARE_GAIN */
> +#define ADAQ4616_PGA_PINS              2
> +#define ADAQ4616_GAIN_MAX_NANO         6666666667

Can we use calculus instead (people can't count properly after 3 :-)?
Something like this

(NANO * 2 / 3) // whoever in the above it's 20 and this puzzles me how
something with _NANO can be so big :-)

...

> +/*
> + * Gains computed as fractions of 1000 so they can be expressed by integ=
ers.
> + */
> +static const int ad4030_hw_gains[] =3D {
> +       333, 556, 2222, 6667,

Again, instead of comment (or in addition to) this can be written as

1000 / 3, 5000 / 9, 20000 / 9, 20000 / 3,

Let the compiler do its job.

> +};
> +
> +static const int ad4030_hw_gains_frac[4][2] =3D {

Drop 4

> +       { 1, 3 },  /* 1/3 gain */
> +       { 5, 9 },  /* 5/9 gain */
> +       { 20, 9 }, /* 20/9 gain */
> +       { 20, 3 }, /* 20/3 gain */
> +};

...

> +static int ad4030_write_raw_get_fmt(struct iio_dev *indio_dev,
> +                                   struct iio_chan_spec const *chan, lon=
g mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }

> +       return -EINVAL;

What's the point of this return?

> +}

...

> +static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_de=
v,
> +                           struct ad4030_state *st)
> +{
> +       unsigned int i;
> +       int pga_value;
> +       int ret;
> +
> +       ret =3D device_property_read_u32(dev, "adi,pga-value", &pga_value=
);
> +       if (ret && ret !=3D -EINVAL)
> +               return dev_err_probe(dev, ret, "Failed to get PGA value.\=
n"
> +
> +       if (ret =3D=3D -EINVAL) {

This can be done differently, i.e. check for EINVAL first and in
'else' branch check for other ret !=3D 0. This will deduplicate the
EINVAL check.

> +               /* Setup GPIOs for PGA control */
> +               st->pga_gpios =3D devm_gpiod_get_array(dev, "pga", GPIOD_=
OUT_LOW);
> +               if (IS_ERR(st->pga_gpios))
> +                       return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +                                            "Failed to get PGA gpios.\n"=
);
> +
> +               if (st->pga_gpios->ndescs !=3D 2)
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "Expected 2 GPIOs for PGA co=
ntrol.\n");
> +
> +               st->scale_avail_size =3D ARRAY_SIZE(ad4030_hw_gains);
> +               st->pga_index =3D 0;
> +               return ad4030_set_pga_gain(st);
> +       }

...

> +       .max_sample_rate_hz =3D 2 * MEGA,

HZ_PER_MHZ

...

> +       .max_sample_rate_hz =3D 2 * MEGA,

Ditto.

--=20
With Best Regards,
Andy Shevchenko

