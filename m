Return-Path: <linux-iio+bounces-23244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E092B34448
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61FE1674EC
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8ED2FD7A5;
	Mon, 25 Aug 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJdKUiAY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AAC2FB987;
	Mon, 25 Aug 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132508; cv=none; b=imCsML/GsiJQbCR1S8yYZt8m67F/cU1S/FxnJGxO16+Gxkg0d/1FYYENAN9AZyRi8QV+o/rLS/RJ/uoy6seBKF3FuuAA8P1iop4JfIb1lOEni+klAe/S0H+kTKzToJLg7RkJ1zwVTGetuEbU/CEBRLVagewifIecM2L5j9RKO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132508; c=relaxed/simple;
	bh=3snOTNTnBVzm/Wq0dYUe0DK+V1Yn9vByQ4fFZ9yqbQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy37OUUh50qj/YGmfeQ97jFOZ8Q8lGTzZcFiwERK3yGqaoM3SnL6aB+vPgOd+R7FVPOYUxFe27rLyCznIIaLiSgFfGNSOcf0JW1FE6uo4nF3H7LFZdEG5B+rJ1epuqjJIm6iW11Z7kzC6YGYIyTp53wV/B49dO8ddWETXLST5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJdKUiAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5967CC4CEF4;
	Mon, 25 Aug 2025 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756132507;
	bh=3snOTNTnBVzm/Wq0dYUe0DK+V1Yn9vByQ4fFZ9yqbQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJdKUiAYVljjP/ILKpLivdMPyNwqunWBQoILJZLcj/721BQsBnwEGuiPTSn8mDANG
	 p1A4NJCGmLlyf1+Yig5eabFJFlbLcu73IWX701MNOqoiUTDDTeocmDtBhkZ1lEZWbD
	 N+/54wEQnqzUP6LlInVx90E9HM8HK5nOMTHIofweGn00u3r6AzyS5RMjQs6tupW268
	 QY4BOTHRNZbA6dO7YoXidlL3o8gINk6edJ4+ZfF0uZBWbxOVwsBatyWjRQy0O1CkcX
	 SlDno4ukj1+mGlRybenyjQVV4jmejiOac04434m5G3IFaXWcFl7CIh/ABc8BcBccat
	 SuJahravPt7FA==
Date: Mon, 25 Aug 2025 15:35:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad7768-1: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20250825153500.66c658b0@jic23-huawei>
In-Reply-To: <20250824041003.9727-1-Jonathan.Santos@analog.com>
References: <20250824041003.9727-1-Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Aug 2025 01:10:03 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Use devm_regulator_get_enable_read_voltage() function as a standard and
> concise way of reading the voltage from the regulator and keep the
> regulator enabled. Replace the regulator descriptor with the direct
> voltage value in the device struct.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

This makes sense even without the rest of the series, so to reduce
what you have to deal with in v3, applied to the togreg branch of iio.git

thanks,

Jonathan

> ---
> v2 Changes:
> * Removed regulator value check (already done in probe).
> * Fixed commit message and description as requested.
> ---
>  drivers/iio/adc/ad7768-1.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 83b0907b068d..51562367a9d4 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -224,7 +224,7 @@ struct ad7768_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	struct regmap *regmap24;
> -	struct regulator *vref;
> +	int vref_uv;
>  	struct regulator_dev *vcm_rdev;
>  	unsigned int vcm_output_sel;
>  	struct clk *mclk;
> @@ -787,7 +787,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad7768_state *st =3D iio_priv(indio_dev);
>  	const struct iio_scan_type *scan_type;
> -	int scale_uv, ret, temp;
> +	int ret, temp;
> =20
>  	scan_type =3D iio_get_current_scan_type(indio_dev, chan);
>  	if (IS_ERR(scan_type))
> @@ -808,11 +808,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv =3D regulator_get_voltage(st->vref);
> -		if (scale_uv < 0)
> -			return scale_uv;
> -
> -		*val =3D (scale_uv * 2) / 1000;
> +		*val =3D (st->vref_uv * 2) / 1000;
>  		*val2 =3D scan_type->realbits;
> =20
>  		return IIO_VAL_FRACTIONAL_LOG2;
> @@ -1145,13 +1141,6 @@ static const struct iio_trigger_ops ad7768_trigger=
_ops =3D {
>  	.validate_device =3D iio_trigger_validate_own_device,
>  };
> =20
> -static void ad7768_regulator_disable(void *data)
> -{
> -	struct ad7768_state *st =3D data;
> -
> -	regulator_disable(st->vref);
> -}
> -
>  static int ad7768_set_channel_label(struct iio_dev *indio_dev,
>  						int num_channels)
>  {
> @@ -1395,19 +1384,11 @@ static int ad7768_probe(struct spi_device *spi)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap24),
>  				     "Failed to initialize regmap24");
> =20
> -	st->vref =3D devm_regulator_get(&spi->dev, "vref");
> -	if (IS_ERR(st->vref))
> -		return PTR_ERR(st->vref);
> -
> -	ret =3D regulator_enable(st->vref);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified vref supply\n");
> -		return ret;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7768_regulator_disable, s=
t);
> -	if (ret)
> -		return ret;
> +	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get VREF voltage\n");
> +	st->vref_uv =3D ret;
> =20
>  	st->mclk =3D devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))


