Return-Path: <linux-iio+bounces-18820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780ECAA060B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5A8168AB4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD481F416A;
	Tue, 29 Apr 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX9eKUrP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C03EA63;
	Tue, 29 Apr 2025 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916371; cv=none; b=mGMvE64ELNCFOyae4KwqFUclaRH6rAgpejIV/CV3S/GgtmEd+b2GUmOT8P2D57IK4DhiLhSoZvey0yLLNOZK/dtJ+gb5VUyqsPq+NcgBdwQftyHN1PZse0LH4THa2JWTuIfvGqNjNiImGuhkv6G0XNkp/MTOP3SrNh2nKHsKdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916371; c=relaxed/simple;
	bh=pYjNVAUGHA0bjOnA85DzBJ+ZOcEvFbSr5f1SW1As7Mw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2LT81XNBi78nJ4I0Yan+M6f5hq01XzKIYDJgR1rOfhb8WSO2B1lEFyVkJptEz8s2bzc2+Hm3DldhF/zlkj15WfhdxNqG/rdm8ohoTqs9hOJ9/huq7bwhtSTISCQEUKLURENQTMDnuh422UlHGF+11Xp6lhAAGFvnoAWY0vQ3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX9eKUrP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so36050705e9.0;
        Tue, 29 Apr 2025 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745916367; x=1746521167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLZz0t3nUw+rXk8L9b1F6NFzfbzYlHns2D3c61C+DMU=;
        b=FX9eKUrPnakUgwdzpIpnIqI9/NE0ESKr5uvZf/thbTJgchHhf5AfjmWhWAjcqAzx+B
         yk8P5wRafV+2WJn2a+113xnB0EnEDZQ4bPRVqoc6MnOw62NvVewh8pIXrdv74RIjwaSi
         abhErKZ7AmvZ3Quoubd/f77KdR57MEL+og+Sa1g/sH48JYz4b8cKW4A6SSh+r467EKpv
         nqhfhuhxwCJpff07N8t8FcsUgnkOEGdhdx9MKiOWN/mOwm6im6IMgI7+SpquIoICBHad
         KPoBwLL3MewdCqIClGPMvszu5ShhM4ska7Ehl+RQxLqqwn0754QxKxmG/J6u6BDCC/No
         X/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916367; x=1746521167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLZz0t3nUw+rXk8L9b1F6NFzfbzYlHns2D3c61C+DMU=;
        b=dilEzFM3VrnPFqWBoCD9LrawL581wNKZ5TaayZB1Ofx7cCY4d4AC/fFYetbhDXaYa4
         vwQJ/Gpqs95tyePPaSFVRXMoUi8QOGhA3FbM7oPcdLnGxNIntSF3IxknV0KrZfd0Lmax
         cBAGXWT9LZEr63H7Be6lcxMCXv0ht9Yqq9IvDCPYBAif9qz1JtZH1AmxjcTnEzQ/PDRE
         9/LbjFveQ3cnPyyh3m07B4wDj9Th1FKCucKW1fVUB1Do1BFh6fjsUF1lF8fG3CDSyQIl
         6vm5fecUiWgcvxYjkEFCn0Z1R1n9534c2PsWEvmN4B3vDlheVMZ5baRJOANnWFV4kdAs
         dFTA==
X-Forwarded-Encrypted: i=1; AJvYcCUgM63SNZshHDwGtP06ivzfJzCD0/K67Zbn3wuO5HdTzkMIqI9t5CAHp/lNBuKNJR5NzlmktB0zVvNCNNb0@vger.kernel.org, AJvYcCV2Jv9y2ddQH1/jZYPEoqvhprwdvA6ErBwNva2IRb69SHQYr7Bboo3QT8ey3T6l/X0t3pxqXp+Zyw9Q@vger.kernel.org, AJvYcCWjMyDHculXBBLVnDNJV+XCEsQlTuvrj2/2T4NgPaP4gSavsvTBoJn5LnenWGsc1xG6f2N4wvt4pAfH@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdLTbS6BidCDtojdLHEjQxTt4FsSkvzXSuKMYCuZ7S0uE1OLP
	oM00iAghYHy5BHoMy7ZuIhn5SLcqBecUOWYVVypfXJ/ILKM+MX5Gr3V3fTk/cuU=
X-Gm-Gg: ASbGnctI0jX6cjEo6lK3UKxinw7pR5+DKN1d4BTzcaGCqbvxqXOLs2Nj6EBARhrnmNW
	fi/6FiXIAAYuVNjmstCAZLqP5I0FvaxdZYMHa7rTUHuRtTBb51zjmgIeC/+MxG3AUU4t/Y+g8Dn
	C7qDj/q8fa90QJpG6dvUzwvqkvpt6aRqEp4UAnftWk+Mx3e+W/aDLB0Zbiwf03O7UuZQ3oBsQHV
	/nrgozv+tBxT5paQsvXSpZ38+pmbck7svwRQssSZafonHwuC7SasndXWmfyzyJf0yseX238C/R+
	MGkRH2dksKFUWQKM9qcbmb+rCoBkk1uyaptR7jOrACNAgtJJB/VJO3q3Eycd9FyYE+p3DlO62yH
	eB01rvsjbBDoV
X-Google-Smtp-Source: AGHT+IEZSP3Yn/cVDHAU3aGK/vw2chUH9hWpEJxbBwaW2v1rOiaHcXaWWI8POFmiD1BQvwkv8ALFQw==
X-Received: by 2002:a05:600c:1d8d:b0:440:59eb:bfc with SMTP id 5b1f17b1804b1-440ab848458mr105138555e9.23.1745916366976;
        Tue, 29 Apr 2025 01:46:06 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a016sm148192385e9.25.2025.04.29.01.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:46:06 -0700 (PDT)
Message-ID: <599074b26d59134f4697d6440ab82b7d6a855fe4.camel@gmail.com>
Subject: Re: [PATCH v3 11/11] iio: adc: ad4080: add driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 09:46:10 +0100
In-Reply-To: <20250425112538.59792-12-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	 <20250425112538.59792-12-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Antoniu,

On Fri, 2025-04-25 at 14:25 +0300, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
> =C2=A0- name the defines to make associacion with register name.
> =C2=A0- drop redundant defines.
> =C2=A0- add trailing comma when needed.
> =C2=A0- drop explicit masking and use field_prep instead
> =C2=A0- add fsleep during sync process.
> =C2=A0- do not wrap where 80 chars is not exceeded.
> =C2=A0- use space for { }
> =C2=A0- drop channel definition macro
> =C2=A0- return dev_info on chip id mismatch.
> =C2=A0- flip expression to `if (!st->lvds_cnv_en)`
> =C2=A0- rework num_lanes property parse.
> =C2=A0- update the driver based on the new edits on the backend interface=
 related
> to
> =C2=A0=C2=A0 this part and the last disscussions in v2.
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 14 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4080.c | 618 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 633 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4080.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..17df328f5322 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -47,6 +47,20 @@ config AD4030
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will
> be
> =C2=A0	=C2=A0 called ad4030.
> =C2=A0
> +config AD4080
> +	tristate "Analog Devices AD4080 high speed ADC"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4080
> +	=C2=A0 high speed, low noise, low distortion, 20-bit, Easy Drive,
> +	=C2=A0 successive approximation register (SAR) analog-to-digital
> +	=C2=A0 converter (ADC). Supports iio_backended devices for AD4080.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4080.
> +
> =C2=A0config AD4130
> =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9f26d5eca822..e6efed5b4e7a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4030) +=3D ad4030.o
> +obj-$(CONFIG_AD4080) +=3D ad4080.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> =C2=A0obj-$(CONFIG_AD4851) +=3D ad4851.o
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..b51893253941
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c
> @@ -0,0 +1,618 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4080 SPI ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
>=20

...

> +
> +static int ad4080_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long m)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	int dec_rate;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4080_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (st->filter_type =3D=3D SINC_5_COMP)
> +			dec_rate =3D st->dec_rate * 2;
> +		else
> +			dec_rate =3D st->dec_rate;
> +		if (st->filter_type)
> +			*val =3D DIV_ROUND_CLOSEST(clk_get_rate(st->clk),
> dec_rate);
> +		else
> +			*val =3D clk_get_rate(st->clk);

Kind of a nit comment (and likely personal preference) but I would rather g=
et
the clock rate during probe. Most of the times, the clock never changes so =
I
rather prefer doing the above when actually needed. Or is this one those ca=
ses
were it actually changes?

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D ad4080_get_dec_rate(indio_dev, chan);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return -EINVAL;

Why not handle this in 'default'?

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4080_set_dec_rate(indio_dev, chan, val);

IIRC, you mentioned at some point that after changing the sampling frequenc=
y we
should align the interface again. Isn't this setting affecting it?

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +{
> +	unsigned int timeout =3D 100;
> +	bool sync_en;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	if (st->num_lanes =3D=3D 1)
> +		ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +				=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK);
> +	else
> +		ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +				=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN_MSK |
> +				=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_data_alignment_enable(st->back);
> +	if (ret)
> +		return ret;

So it looks like you never disable the internal alignment. Is that on purpo=
se? I
also failed to reply to your comments in the previous version so I'll bring=
 them
back:

"In this particular case, yes, one backend would fit for the sync process. =
But
taking into account that these two features are part also from the common c=
ore
of the AXI ADC, in other cases they might be used separately."

Not sure if that is true... I guess these are in the default register map b=
ut
are they always implemented for all the designs? They might just be no-ops =
for
some designs. Example, I do not think bitslip is always implemented. But ev=
en in
that case, the goal here is to align the interface for data sampling. So,
really, something like:

iio_backend_interface_data_align(st->back, u32 timeout);

looks fairly generic to me (given that the process is for the complete inte=
rface
at once. IOW, there's no specific timing points or stuff like that that we =
need
to probe independently)... So doing the polling on the backend side seems
reasonable to me (and there you can use regmap_poll APIs).

And as Jonathan puts it, this is all in kernel APIs so we can easily change=
 it
afterwards :)

"The CNV signal is mainly used for sampling (an input pin according to the
datasheet -=20
conversion is initiated on the rising edge of the convert signal).
We use it only for determining the sampling frequency."

Ok, from your previous versions I got the impression this pin could also be=
 used
for aligning the interface.

> +
> +	do {
> +		ret =3D iio_backend_sync_status_get(st->back, &sync_en);
> +		if (ret)
> +			return ret;
> +
> +		if (!sync_en)
> +			dev_dbg(&st->spi->dev, "Not Locked: Running Bit
> Slip\n");
> +
> +		fsleep(500);
> +	} while (--timeout && !sync_en);
> +
> +	if (timeout) {
> +		dev_info(&st->spi->dev, "Success: Pattern correct and
> Locked!\n");
> +		if (st->num_lanes =3D=3D 1)
> +			return regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK);
> +		else
> +			return regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +					=C2=A0=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);

redundant else

> +	} else {
> +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> +		if (st->num_lanes =3D=3D 1) {
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A_MSK |
> +					=C2=A0=C2=A0
> AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES_MSK);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return -ETIMEDOUT;
> +	}
> +}
>=20

