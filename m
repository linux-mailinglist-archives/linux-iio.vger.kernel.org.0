Return-Path: <linux-iio+bounces-9287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264D9702E5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360CF1C217F4
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00D415C13B;
	Sat,  7 Sep 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCpRlgkA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67668134B1;
	Sat,  7 Sep 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725722440; cv=none; b=gsctSJuSOrC6U0XJ0e0ftn6Zj5E23T53zMAgcibI3WJfYAMDs88JoCP76GvdU8PPQBk1ALliKd6Leze9WQym+nitHPIjpBB9vRMG63AiXqSRGtxUtXOitdvZUEk7gSmhLMACJkneK8rCOG6rwyuS1k8vK7pvEIm9LmdpYiwZI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725722440; c=relaxed/simple;
	bh=9nQXR/rPe1X+biEun+Z0YdaucIHSi8blyuiK/ARCKmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZPijx6Yr1zuj+Z3ozN+lYGDZZ1kJ+cIEF/u0SGWzC2eT/o2J46MJSuLlkRFnakWIqQq3FKS7az99iihTaMmep7R65kXPTLNYB/rDIrYLBDozsN23lbVzdXkFDUgITvXuMPq5GlpdTI0w+rARlm4lR9cs6ZMbKAzbv/LCXjU8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCpRlgkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E13C4CEC2;
	Sat,  7 Sep 2024 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725722439;
	bh=9nQXR/rPe1X+biEun+Z0YdaucIHSi8blyuiK/ARCKmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FCpRlgkAZDYp/cU3p/XNjiuFfTT4IdTtUpBr8cwKZ9nKWrOVkmtQllXdfci3vuaAy
	 X6eWFdQk+DYtDEppbaymCurpclub+m7prpD5ZGT0PK2pJrb6l2HLo+h0zOAp/gZA2N
	 kULIM2lz0ygfaOfGgj5jqJbbI9WZcJBNkecP8w/05Lg9L92zvZY5XMcPDmSjr1Xbcu
	 b9NAxYDvXKT7lpZYiKFZuZSw/xKtbGCF6wsYPWk7n1zzZ/oZXGHxW1oYO6tWnbrGJb
	 E+Oc+z/mmgftRDdw4es1dFPcEADclomiWKLUNbSe3ehXk7UAFbkwxs2jd8moHWpXec
	 pNSYYwisU1KYA==
Date: Sat, 7 Sep 2024 16:20:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v5 9/9] iio: adc: ad7606: add support for
 AD7606C-{16,18} parts
Message-ID: <20240907162032.3cca0a17@jic23-huawei>
In-Reply-To: <20240907065043.771364-10-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
	<20240907065043.771364-10-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat,  7 Sep 2024 09:50:42 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
> The main difference between AD7606C-16 & AD7606C-18 is the precision in
> bits (16 vs 18).
> Because of that, some scales need to be defined for the 18-bit variants, =
as
> they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).
>=20
> Because the AD7606C-16,18 also supports bipolar & differential channels,
> for SW-mode, the default range of 10 V or =C2=B110V should be set at prob=
e.
> On reset, the default range (in the registers) is set to value 0x3 which
> corresponds to '=C2=B110 V single-ended range', regardless of bipolar or
> differential configuration.
>=20
> Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.
>=20
> The AD7606C-18 variant offers 18-bit precision. Because of this, the
> requirement to use this chip is that the SPI controller supports padding
> of 18-bit sequences to 32-bit arrays.
>=20
> Datasheet links:
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7=
606c-16.pdf
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7=
606c-18.pdf
>=20

Keep automation happy and make these official tags.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad7606c-16.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad7606c-18.pdf
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>

A few other things inline.

Jonathan

> ---
>  drivers/iio/adc/ad7606.c     | 237 ++++++++++++++++++++++++++++++++---
>  drivers/iio/adc/ad7606.h     |  13 +-
>  drivers/iio/adc/ad7606_spi.c |  55 ++++++++
>  3 files changed, 284 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 364f16fb96bf..67bac6c97fff 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c

> +static int ad7606c_sw_mode_setup_channels(struct iio_dev *indio_dev,
> +					  ad7606c_chan_setup_cb_t chan_setup_cb)
> +{
> +	unsigned int num_channels =3D indio_dev->num_channels - 1;
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	bool chan_configured[AD760X_MAX_CHANNELS] =3D {};
Maybe use a bitmap as then...
> +	struct device *dev =3D st->dev;
> +	int ret;
> +	u32 ch;
> +
> +	/* We call this first, so that the proper SW scales get assigned */
> +	ret =3D st->bops->sw_mode_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		bool bipolar, differential;
> +		u32 pins[2];
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			continue;
> +
> +		/* channel number (here) is from 1 to num_channels */
> +		if (ch =3D=3D 0 || ch > num_channels) {
> +			dev_warn(st->dev,
> +				 "Invalid channel number (ignoring): %d\n", ch);
> +			continue;
> +		}
> +
> +		bipolar =3D fwnode_property_read_bool(child, "bipolar");
> +
> +		ret =3D fwnode_property_read_u32_array(child, "diff-channels",
> +						     pins, ARRAY_SIZE(pins));
> +		/* Channel is differential, if pins are the same as 'reg' */
> +		if (ret =3D=3D 0 && (pins[0] !=3D ch || pins[1] !=3D ch)) {
> +			dev_err(st->dev,
> +				"Differential pins must be the same as 'reg'");
> +			return -EINVAL;
> +		}
> +
> +		differential =3D (ret =3D=3D 0);
> +
> +		ch--;
> +
> +		chan_setup_cb(st, ch, bipolar, differential);
> +		chan_configured[ch] =3D true;
> +	}
> +
> +	/* Apply default configuration to unconfigured (via DT) channels */
> +	for (ch =3D 0; ch < num_channels; ch++) {
this can be for_each_clear_bit()

> +		if (!chan_configured[ch])
> +			chan_setup_cb(st, ch, false, false);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7606_sw_mode_setup(struct iio_dev *indio_dev, unsigned int =
id)
>  {
>  	unsigned int num_channels =3D indio_dev->num_channels - 1;
>  	struct ad7606_state *st =3D iio_priv(indio_dev);
> @@ -572,17 +751,30 @@ static int ad7606_sw_mode_setup(struct iio_dev *ind=
io_dev)
> =20
>  	indio_dev->info =3D &ad7606_info_sw_mode;
> =20
> -	/* Scale of 0.076293 is only available in sw mode */
> -	/* After reset, in software mode, =C2=B110 V is set by default */
> -	for (ch =3D 0; ch < num_channels; ch++) {
> -		struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
> +	switch (id) {
> +	case ID_AD7606C_18:
> +		ret =3D ad7606c_sw_mode_setup_channels(indio_dev,
> +						     ad7606c_18_chan_setup);

As below, a callback in chip info that can be called directly=20
would be preferable here.

> +		break;
> +	case ID_AD7606C_16:
> +		ret =3D ad7606c_sw_mode_setup_channels(indio_dev,
> +						     ad7606c_16_chan_setup);
> +		break;
> +	default:
> +		/* Scale of 0.076293 is only available in sw mode */
> +		/* After reset, in software mode, =C2=B110 V is set by default */
> +		for (ch =3D 0; ch < num_channels; ch++) {
> +			struct ad7606_chan_scale *cs =3D &st->chan_scales[ch];
> +
> +			cs->scale_avail =3D ad7616_sw_scale_avail;
> +			cs->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> +			cs->range =3D 2;
> +		}
> =20
> -		cs->scale_avail =3D ad7616_sw_scale_avail;
> -		cs->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> -		cs->range =3D 2;
> +		ret =3D st->bops->sw_mode_config(indio_dev);
> +		break;
>  	}
> =20
> -	ret =3D st->bops->sw_mode_config(indio_dev);
>  	if (ret)
>  		return ret;
> =20
> @@ -631,9 +823,16 @@ int ad7606_probe(struct device *dev, int irq, void _=
_iomem *base_address,
>  	st->oversampling =3D 1;
> =20
>  	cs =3D &st->chan_scales[0];
> -	cs->range =3D 0;
> -	cs->scale_avail =3D ad7606_scale_avail;
> -	cs->num_scales =3D ARRAY_SIZE(ad7606_scale_avail);
> +	switch (id) {
> +	case ID_AD7606C_18:
> +		cs->scale_avail =3D ad7606_18bit_hw_scale_avail;

Can we push this into the chip_info structure?
Ideally we'd get away form any ID based code selection but if there is
some already in the driver that can be for another day.
Let's not make it worse though.

> +		cs->num_scales =3D ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
> +		break;
> +	default:
> +		cs->scale_avail =3D ad7606_16bit_hw_scale_avail;
> +		cs->num_scales =3D ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
> +		break;
> +	}

> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index fa175cff256c..c2cb536ecef1 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h


>  /**
> @@ -151,9 +154,13 @@ struct ad7606_state {
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
> -	 * 16 * 16-bit samples + 64-bit timestamp
> +	 * 16 * 16-bit samples + 64-bit timestamp - for AD7616
> +	 * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and similar)
>  	 */
> -	unsigned short			data[20] __aligned(IIO_DMA_MINALIGN);
> +	union {
> +		unsigned short d16[20];
> +		unsigned int d32[10];

Can we use fixed sizes for these?
u16 and u32 for instance?

> +	} data __aligned(IIO_DMA_MINALIGN);
>  	__be16				d16[2];
That's odd.  You have a d16 inside the union and another one right next to =
it.
Maybe rename the new one?  The other is a bounce buffer used in the spi
paths I think.

>  };

