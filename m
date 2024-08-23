Return-Path: <linux-iio+bounces-8737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8CF95D601
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE341F22D98
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C091922FD;
	Fri, 23 Aug 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwv38XcE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C018592E;
	Fri, 23 Aug 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440762; cv=none; b=qhr7qU5GQEKDTjckgMUJhgZ/vAXFmc6apvkL+ccUoZgFWBOGUgo+PpdtaLEOiFF0hwQAtVc+9UL37YIHE7GiSwBNS70Bs1x6o6caeOsqv18gOYonMgKnaL27xK6xNj4FhdPo8wWreZcxOsUycR/uIs+ek8CzBjRGR0hGsRgG4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440762; c=relaxed/simple;
	bh=RbGqazl7YKAeTpEJJ80ong+xPNKwnei0GOQGoLCf5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHDqrWLzBzA1Zp1znTIqYyzch/oifXCKbYBAXWwHYz/rfg3l/hbucEGTkG+iusvGQv7IRD1pkIsi27R6vwxiCpxfQu30bADxAY4lGjTROTz5NshC17DT+PZRJCAhXkqn99j+mqpESO5BDHdUX149YA/Jg9KSfEO2GVt3NTU5JjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwv38XcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7DC32786;
	Fri, 23 Aug 2024 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724440761;
	bh=RbGqazl7YKAeTpEJJ80ong+xPNKwnei0GOQGoLCf5TQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rwv38XcEbVeSkRTN8TuW94mP+kgGA6MUqWxTQnfxdTfqotynofwEw5/nqKesQY+gB
	 1wRD4JGTX7HhdcFUbLo0VOH4piINa1Sd10k0SlYLiSns/XuoZjYtrvYO8r3udJ0GeW
	 5hcM9alwbbAUl1rEElrWbzzA/K6v6XACsYlVcOZV8UtfgD35CtRlc+vjV1tUPxFC/S
	 es+0qPJKEgXzk7yQzWCCxM0V0pv+cqUqFx/3BFh9Ninrpt2DLPvbLo9lQAOglIPAJC
	 gZ6DrLDB1Sm0z5ue3PdDMy+CnkFCl7JyDu4RL7inSF0Xz+s3kDe2A6DYSNsdXremxA
	 55Phphkt9sxyA==
Date: Fri, 23 Aug 2024 20:19:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH 7/7] iio: adc: ad7606: add support for AD7606C-{16,18}
 parts
Message-ID: <20240823201913.5bded18f@jic23-huawei>
In-Reply-To: <20240819064721.91494-8-aardelean@baylibre.com>
References: <20240819064721.91494-1-aardelean@baylibre.com>
	<20240819064721.91494-8-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Aug 2024 09:47:17 +0300
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
> And the AD7606C-18 variant offers 18-bit precision. The unfortunate effect
> of this 18-bit sample size, is that there is no simple/neat way to get the
> samples into a 32-bit array without having to do a home-brewed bit-buffer.
> The ADC must read all samples (from all 8 channels) in order to get the
> N-th sample (this could be reworked to do up-to-N-th sample for scan-dire=
ct).
> There doesn't seem to be any quick-trick to be usable to pad the samples
> up to at least 24 bits.
> Even the optional status-header is 8-bits, which would mean 26-bits of da=
ta
> per sample.
> That means that when using a simple SPI controller (which can usually read
> 8 bit multiples) a simple bit-buffer trick is required.
>=20
> Datasheet links:
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7=
606c-16.pdf
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7=
606c-18.pdf
>=20
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>

A few minor things. If we can just start with 18 bit word spi controllers o=
nly
maybe that's worth doing to make things simpler.

> +static int ad7606c_sw_mode_setup_channels(struct iio_dev *indio_dev,
> +					  ad7606c_chan_setup_cb_t chan_setup_cb)
> +{
> +	unsigned int num_channels =3D indio_dev->num_channels - 1;
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	bool chan_configured[AD760X_MAX_CHANNELS];
=3D {};
and drop the memset.

> +	struct device *dev =3D st->dev;
> +	int ret;
> +	u32 ch;
> +
> +	/* We need to hook this first */
> +	ret =3D st->bops->sw_mode_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info =3D &ad7606c_info_sw_mode;
> +
> +	memset(chan_configured, 0, sizeof(chan_configured));
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		bool bipolar, differential;
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			continue;
> +
> +		if (ch >=3D num_channels) {
> +			dev_warn(st->dev,
> +				 "Invalid channel number (ignoring): %d\n", ch);
> +			continue;
> +		}
> +
> +		bipolar =3D fwnode_property_present(child, "bipolar");
> +		differential =3D fwnode_property_present(child, "diff-channel");
> +
> +		chan_setup_cb(st, ch, bipolar, differential);
> +		chan_configured[ch] =3D true;
> +	}
> +
> +	/* Apply default configuration to unconfigured (via DT) channels */
> +	for (ch =3D 0; ch < num_channels; ch++) {
> +		struct ad7606_chan_scale *cs;
> +		unsigned int *scale_avail_show;
> +		int i;
> +
> +		if (!chan_configured[ch])
> +			chan_setup_cb(st, ch, false, false);
> +
> +		/* AD7606C supports different scales per channel */
> +		cs =3D &st->chan_scales[ch];
> +
> +		scale_avail_show =3D devm_kcalloc(st->dev, cs->num_scales * 2,
> +						sizeof(*scale_avail_show),
> +						GFP_KERNEL);

Maybe just make it big enough for worst case and stick it in st always?
How big can it get?



> +		if (!scale_avail_show)
> +			return -ENOMEM;
> +
> +		/* Generate a scale_avail list for showing to userspace */
> +		for (i =3D 0; i < cs->num_scales; i++) {
> +			scale_avail_show[i * 2] =3D 0;
> +			scale_avail_show[i * 2 + 1] =3D cs->scale_avail[i];
> +		}
> +
> +		cs->scale_avail_show =3D scale_avail_show;
> +	}
> +
> +	return 0;
> +}
>

> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index dd0075c97c24..73a7b0007bf8 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -45,6 +45,8 @@

> =20
> +static int ad7606_spi_read_block18to32(struct device *dev,
> +				       int count, void *buf)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	u32 i, bit_buffer, buf_size, bit_buf_size;
> +	u32 *data =3D buf;
> +	u8 *bdata =3D buf;
> +	int j, ret;
> +
> +	/**
Not kernel doc.  /*
> +	 * With the 18 bit ADC variants (here) is that we can't assume that all
> +	 * SPI controllers will pad 18-bit sequences into 32-bit arrays,
> +	 * so we need to do a bit of buffer magic here.
> +	 * Alternatively, we can have a variant of this function that works
> +	 * for SPI controllers that can pad 18-bit samples into 32-bit arrays.
> +	 */
> +
> +	/* Write 'count' bytes to the right, to not overwrite samples */
> +	bdata +=3D count;
> +
> +	/* Read 24 bits only, as we'll only get samples of 18 bits each */
> +	buf_size =3D count * 3;
> +	ret =3D spi_read(spi, bdata, buf_size);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "SPI read error\n");
> +		return ret;
> +	}
> +
> +	bit_buffer =3D 0;
> +	bit_buf_size =3D 0;
> +	for (j =3D 0, i =3D 0; i < buf_size; i++) {
> +		u32 sample;
> +
> +		bit_buffer =3D (bit_buffer << 8) | bdata[i];
> +		bit_buf_size +=3D 8;
> +
> +		if (bit_buf_size < 18)
> +			continue;
> +
> +		bit_buf_size -=3D 18;
> +		sample =3D (bit_buffer >> bit_buf_size) & AD7606C_18_SAMPLE_MASK;
> +		data[j++] =3D sign_extend32(sample, 17);
> +
> +		if (j =3D=3D count)
> +			break;
> +	}
> +
> +	return 0;
> +}


