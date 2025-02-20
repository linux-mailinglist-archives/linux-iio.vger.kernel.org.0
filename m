Return-Path: <linux-iio+bounces-15875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66964A3DE45
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 16:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244351696AD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71501FCFD2;
	Thu, 20 Feb 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyKIJPj9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6D1FC7C1;
	Thu, 20 Feb 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064919; cv=none; b=EzBnl7pyof+d5j8kmQXOlDfHP4F8rGFWITYWHeYVvjRHMEoXriwimYavry4llgP01VxY2PfoSmiOm5KivcRehpC88Aos8r0S66ZAvIE3ncn5SBi9m4SGPBokhhNAlNHuwbKsfqyCshQ9eQY2CCcOAwuoD7ayGkutueWe/DhNTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064919; c=relaxed/simple;
	bh=nNTqAyKgG+EZzWHATYcZ+Glt9nfvQogAY0W8yJhL6Vs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5wxyFqAVTOe2UeOOjMUx5HFGorhBS2lLZIoht+UFnHBnGYVMN/B2wq/KQCvEOXjW3tkXnGCTDhb/S8BanZrHeESluRlHyHZdED0+xbicH8zJdvAxkxcxN4kwIC4eiyitO99QkL3H3F+zVnTQZVD+hGo/85pNGTG8DOieus7uhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyKIJPj9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439a331d981so9214925e9.3;
        Thu, 20 Feb 2025 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740064916; x=1740669716; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Rm5aX4zhdrnBrXtHJ8TM6sXi8yh8D2B4bnsxootaU=;
        b=QyKIJPj9ZEaXC0tj6yeNB4onI5tlj1Rt4H+1EcuvS+ZloesrC5NmXQ1d3ER9JGHo5D
         J81ZX9Zw1quF8+kDc8LMtO4skTqO6uXZnfOXQJnMXPhiro6bUg8zaknVmEnCGxe6D0dJ
         gRd961olu5F2rOt03avPJh7ZSryxOVd7o3uekwGxsdR0/uEQW32DLsgVfLJX9Hd3sgnl
         uocGCb6C+gCF6wVP/1A0Suzk64q6ppH4pFHVFZeZDSsrCEfO98P5YxeuWk9JmmoLZXH9
         See42xZYq9EfwUnpUhF+QNxu9QX191ubb1VuEUW7uhh1FuCsVomRqu3V54JRtYgqrMzG
         aAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064916; x=1740669716;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E+Rm5aX4zhdrnBrXtHJ8TM6sXi8yh8D2B4bnsxootaU=;
        b=Dglqb3zAE740CLWA2rQSAFGqJQf6+JIsnBBfll9SFtcgL57G73emGwG5K7X5qdnFs/
         vN479MA1LJHISd75NIP03oZtbSSdrnyJknTEJpwh71p/v9WlYptyXyR/ntb/OVZI9l8Z
         PKwOCF6Du0Sv7GkTCn1vV+yA6+6ppzAQTL1enk7TvQh1mrYBQDH0r4MA7XzR2c45gbGx
         qR1Q5VheGmdT+1Fuqt7ftUgMvZsrmNo+O0Zxt9VsFMz0CKiftyEUQ4X4bJ07rvXq6KMP
         cuLiiSLy8bO4F8rYY523AgEGzIZm0awwg1JvQFnngksrbSX43tgmi8wum0uRAZ7oBITV
         MMlA==
X-Forwarded-Encrypted: i=1; AJvYcCULhACErMVFmS7lnSv7sAY+pkOJVpXDlGgyehiVL/Dr/6UtKkNQdqU9UFlEL3t/77tkokpsLRHplrxNRx/3@vger.kernel.org, AJvYcCVdQGV279aS9Mt2QlLmIaJOWniCY1bBJIV4jtnoyen3BUzdfWxw0GwMEgII1SuGeDHaKHFO9s0F9bDZ@vger.kernel.org, AJvYcCXTbMTnpbzUSVjuUn6peg9Epg/IUk78HfqiQ9ft20lnlHjSQ2E8ji+kaxBq5ykbe/WB4KHelw1EnJUz@vger.kernel.org
X-Gm-Message-State: AOJu0YxssinwC2dV60HRao9348DjAWFfYtRWZFyCGf5xOTGcnnOACa+1
	KOlyEFAbxzR3nSWpOs3zNudqO7x9Ah40Rnf8ImME4CsoFha3E/nx
X-Gm-Gg: ASbGnct9dQWJ7PU0ESDWZP+7Qa/F2sSJQIFNheiV6ceSqJoD/N0lW9pxz9UpECSPQPR
	Im0UFdotsUaMKh1hXmaiRrdVH4sjWTQdiVizT0O6uKi4/4wCrxbOEeOTFvt6JxzLJgk/FthyjDk
	GOilPGW+XH8HpZXizXcAqjvIZEc8gbkj8UFtFMgfcAhhq3e2joBt457cMkDtjnvPRQySI2rcMkW
	shtSMk9oUWetoARZkCUMynGcFeA3X8QfSFbAIxKfVWJEz6mHI4mNdI+0Vi8zBpbLs8aBk2SMAXd
	cqfvcUUrPfboYekGlw7XNFT810rT0k6QQFhn0ONb6SBurWqz+b3bZnrl4b+3kzM=
X-Google-Smtp-Source: AGHT+IF/VqKhGVSiR+whkph1sTPeWcBBa40BCvOzK6U61/If/7B6SUWJ/+jEqVbg/jBdBzpiYusjiQ==
X-Received: by 2002:a05:6000:712:b0:38f:2766:759f with SMTP id ffacd0b85a97d-38f587ca5c4mr7222109f8f.41.1740064915478;
        Thu, 20 Feb 2025 07:21:55 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c29sm20963921f8f.72.2025.02.20.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:21:55 -0800 (PST)
Message-ID: <be3fc6e363947f938b6705d2304f075cfa116471.camel@gmail.com>
Subject: Re: [PATCH 13/14] iio: adc: ad4080: add driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 15:21:58 +0000
In-Reply-To: <20250220135429.8615-14-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	 <20250220135429.8615-14-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Antoniu,

A first, not in depth, review from my side...

On Thu, 2025-02-20 at 15:54 +0200, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 15 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4080.c | 768 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 784 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4080.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..b198a93c10b7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -47,6 +47,21 @@ config AD4030
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
> +	=C2=A0 converter (ADC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4080.
> +
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
> index 000000000000..71c443965e10
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c
> @@ -0,0 +1,768 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4080 SPI ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */

...

>=20
> +static int ad4080_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	unsigned long s_clk;
> +	int dec_rate =3D 1;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		s_clk =3D clk_round_rate(st->clk, val);
> +
> +		if (st->filter_enabled) {
> +			if (st->filter_mode =3D=3D SINC_5_COMP)
> +				dec_rate =3D ad4080_dec_rate_value[st-
> >dec_rate] * 2;
> +			else
> +				dec_rate =3D ad4080_dec_rate_value[st-
> >dec_rate];
> +		}
> +
> +		s_clk *=3D dec_rate;
> +
> +		if (s_clk < AD4080_MIN_SAMP_FREQ)
> +			s_clk =3D AD4080_MIN_SAMP_FREQ;
> +		if (s_clk > AD4080_MAX_SAMP_FREQ)
> +			s_clk =3D AD4080_MAX_SAMP_FREQ;
> +
> +		return clk_set_rate(st->clk, s_clk);

It seems to me that we could skip the dec_rate attribute. Given the availab=
le
values we have, can't we compute the available sampling frequencies during
.probe() after getting our ref clock?=20
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t ad4080_lvds_sync_write(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	unsigned int timeout =3D 100;
> +	bool sync_en;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	if (st->num_lanes =3D=3D 1)
> +		ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +				=C2=A0=C2=A0 AD4080_INTF_CHK_EN_MSK);
> +	else
> +		ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +				=C2=A0=C2=A0 AD4080_INTF_CHK_EN_MSK |
> +				=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_self_sync_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;

The number of lanes is a DT property so it seems to me that we can do the a=
bove
only once during probe. Otherwise I would expect a comment on why we need t=
o do
this again...


> +
> +	ret =3D iio_backend_bitslip_enable(st->back);
> +	if (ret)
> +		return ret;

AFAIU, bit slip seems to be something very specific to AMD/Xilinx isn't it?=
 It
also looks like this is mostly about adjusting the alignment of incoming da=
ta at
the interface level for data integrity.=C2=A0

So we could maybe rename the API for something more generic like
iio_backend_data_alignment_enable()? I'm open for suggestions here :)

> +
> +	do {
> +		ret =3D iio_backend_sync_status_get(st->back, &sync_en);
> +		if (ret)
> +			return ret;

Since this is about waiting on some alignment/synchronization process to
complete, we could also think on a better name and API for this. I think we
could pass a timeout parameter and do the waiting (with some regmap polling=
) in
the backend returning 0 on success. Thoughts?

> +
> +		if (!sync_en)
> +			dev_info(&st->spi->dev, "Not Locked: Running Bit
> Slip\n");
> +		else
> +			break;
> +	} while (--timeout);
>=20

Now comes my question about this process. This looks like some kind of inte=
rface
calibration or am I completely wrong? I wonder if this is something that re=
ally
needs to be a control that userspace can randomly use? Or is this something=
 we
should only do once during probe? Or every time before buffering? Or everyt=
ime
we change the sampling frequency?=C2=A0

Gut feeling is that we should do this after changing the sampling frequency=
 but
I can be totally wrong.

Other thing that I'm confused about is that during probe we do
iio_backend_self_sync_enable() and we can start buffering without running t=
he
lvds_sync code. My point is that after running lvds_sync we are left with =
=20
iio_backend_bitslip_enable() so I'm wondering how this all should work? Sho=
uld
bitslip be always enabled or only for this process?

The Docs are also a bit confusing:

BITSLIP_ENABLE - Enables the sync process.
SELF_SYNC - Controls if the data capture synchronization is done through CN=
V
signal or bit-slip.

From what I can tell we always set SELF_SYNC to 1 which is not clear what i=
t is?
I guess bit slip?

> +	if (timeout) {
> +		dev_info(&st->spi->dev, "Success: Pattern correct and
> Locked!\n");
> +		if (st->num_lanes =3D=3D 1)
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> +		else
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +					=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> +	} else {
> +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> +		if (st->num_lanes =3D=3D 1)
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> +		else
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +					=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> +		ret =3D -ETIME;

ETIMEDOUT (might have a typo)

> +	}
> +
> +	return ret ? ret : len;
> +}
> +

...

>=20
> +static int ad4080_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev =3D &spi->dev;
> +	struct ad4080_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad4080_power_supplies),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ad4080_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable supplies\n");
> +
> +	st->regmap =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->info =3D &ad4080_iio_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D ad4080_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	st->clk =3D devm_clk_get_enabled(&spi->dev, "adc-clk");
> +	if (IS_ERR(st->clk))
> +		return PTR_ERR(st->clk);

Is this the CNV pin? If so, cnv-clk could be a better name or since we only=
 have
one clock, we don't really need a name...

- Nuno S=C3=A1
>=20


