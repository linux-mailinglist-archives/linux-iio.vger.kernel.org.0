Return-Path: <linux-iio+bounces-10820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D819F9A544A
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803BD1F21343
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A5192B71;
	Sun, 20 Oct 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhIrt7jQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A516B674;
	Sun, 20 Oct 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430322; cv=none; b=QdtZjs9PQFGkKx1PVBYc+u9XaYv1VJ3ucjqP9oSMJB6Pid9MobTyV8Xktkn6EIU3HDy4MKuigcxa3ur8HhYU3p4AFZ/RZz+HFtFEe43fhM9KWBQrvaYP60vCAQUnwvHzC5wQIqGg9c/tImCjOp/Y+47MzqAgD3i1PtXFASGUUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430322; c=relaxed/simple;
	bh=iL/Ek5v1qO0439rNg97jARZMtI4jHtmnyjuD8Uz295w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfaH47+e3LiwxCAz6zKkO+0bdLTr+ZS0V549MpWOcXzmGnfJcKgkEbetqCVBEwxj2m6Nu3+hz6aXojprXdDN2szHm24uG1n/3Niof5SRJQm4OybCUIr+V/ED1J/uGHeh0FGQTa23b6IZZ57SPhOTB1A5xYik81+KH8vW8QuV39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhIrt7jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F6C4CEC6;
	Sun, 20 Oct 2024 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729430321;
	bh=iL/Ek5v1qO0439rNg97jARZMtI4jHtmnyjuD8Uz295w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VhIrt7jQoC1to0wb9L5aoNuq1862+O112l2HHgbQkHxkajC3j5E7v/U8OfOSbcGJ5
	 4lPlX91jZc7DEHwL3cnBJ6nxca0om2iR/10ocmTcol0zqXa5gH23E+CbK9kNf6T8Zk
	 5rQmo7IW9hrGi4Em4AE3I+8WLOqBzFgYg/tP43L63nP5TBXglPfH3OVysCufP96aHs
	 qOv/HVlVnfnte+e1B/hgSDQcnI5gG7wmeNffNdVhH6F5jvXLEj+fLJ0TdvXZUfbgo1
	 3iiFJ+wwj5wRbh97ay1A9ZtF7GNvGWfmPl9jGlBXV4S86NUdD1XYi+m8FHq9CqWCQk
	 q6V8bbY2bmp0Q==
Date: Sun, 20 Oct 2024 14:18:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] iio: adc: ad7380: add support for adaq4370-4
 and adaq4380-4
Message-ID: <20241020141832.2299459e@jic23-huawei>
In-Reply-To: <20241015-ad7380-add-adaq4380-4-support-v1-3-d2e1a95fb248@baylibre.com>
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
	<20241015-ad7380-add-adaq4380-4-support-v1-3-d2e1a95fb248@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 11:09:08 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
> acquisition signal chain =CE=BCModule solutions compatible with the ad738x
> family, with the following differences:
>=20
> - configurable gain in front of each 4 adc
> - internal reference is 3V derived from refin-supply (5V)
> - additional supplies
>=20
> This implies that IIO_CHAN_INFO_SCALE can not be shared by type.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Not that much code, so I'll give it a quick review even though I know
you posted it for that one specific dt binding question.

Main thing here is I'd drop the scale from dt bindings and make it writable
via write_raw.  You'll also need to compute the appropriate _available
stuff so userspace knows what scales it can use.

Jonathan

> @@ -876,8 +933,15 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  		 *    * (2 =C3=97 VREF) / 2^N, for differential chips
>  		 *    * VREF / 2^N, for pseudo-differential chips
>  		 * where N is the ADC resolution (i.e realbits)
> +		 *
> +		 * The gain is stored as a fraction of 1000 and, as we need to
> +		 * divide vref_mv by the gain, we invert the gain/1000 fraction.
>  		 */
> -		*val =3D st->vref_mv;
> +		if (st->chip_info->has_hardware_gain)
> +			*val =3D mult_frac(st->vref_mv, MILLI,
> +					 st->gain_milli[chan->scan_index]);
> +		else
> +			*val =3D st->vref_mv;
>  		*val2 =3D scan_type->realbits - chan->differential;
> =20
>  		return IIO_VAL_FRACTIONAL_LOG2;
> @@ -1058,7 +1122,19 @@ static int ad7380_probe(struct spi_device *spi)
>  				     "Failed to enable power supplies\n");
>  	msleep(T_POWERUP_MS);
> =20
> -	if (st->chip_info->external_ref_only) {
> +	if (st->chip_info->adaq_internal_ref_only) {
> +		/*
> +		 * ADAQ chips use fixed internal reference but still
> +		 * require an external reference supply to power it.
I'd just go with
		 * require a specific external supply to power it.

Reference kind of implies it is a quality supply. This is 4.5-5.5V=20
so not so much ;)

> +		 * "refin" is already enabled with other power supplies
> +		 * in bulk_get_enable().
> +		 */
> +
> +		st->vref_mv =3D ADAQ4380_INTERNAL_REF_MV;
> +
> +		/* these chips don't have a register bit for this */
> +		external_ref_en =3D false;
> +	} else if (st->chip_info->external_ref_only) {
>  		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
>  							     "refin");
>  		if (ret < 0)
> @@ -1104,6 +1180,34 @@ static int ad7380_probe(struct spi_device *spi)
>  		st->vcm_mv[i] =3D ret / 1000;
>  	}
> =20
> +	for (i =3D 0; i < MAX_NUM_CHANNELS; i++)
> +		st->gain_milli[i] =3D AD7380_DEFAULT_GAIN_MILLI;
> +
> +	if (st->chip_info->has_hardware_gain) {

Why is this a DT thing rather than exposed to userspace?
Mostly we only control ranges in DT for output devices (where there is a ch=
ance
of burning things if we let them be controlled from userspace.).
For ADC amplifiers we tend to just expose them as controllable _SCALE.


> +		device_for_each_child_node_scoped(&spi->dev, node) {
> +			unsigned int channel, gain;
> +
> +			ret =3D fwnode_property_read_u32(node, "reg", &channel);
> +			if (ret)
> +				return dev_err_probe(&spi->dev, ret,
> +						     "Failed to read reg property\n");
> +
> +			if (channel >=3D st->chip_info->num_channels - 1)
> +				return dev_err_probe(&spi->dev, -EINVAL,
> +						     "Invalid channel number %i\n",
> +						     channel);
> +
> +			ret =3D fwnode_property_read_u32(node, "adi,gain-milli",
> +						       &gain);
> +			if (ret && ret !=3D -EINVAL)
> +				return dev_err_probe(&spi->dev, ret,
> +						     "Failed to read gain for channel %i\n",
> +						     channel);
> +			if (ret !=3D -EINVAL)
> +				st->gain_milli[channel] =3D gain;
> +		}
> +	}

