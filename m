Return-Path: <linux-iio+bounces-19630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF93BABB0D8
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E863B83E0
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370E21A449;
	Sun, 18 May 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z92W3h2u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B47FD;
	Sun, 18 May 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747586037; cv=none; b=Bw4lgF9eILlnxx+/mKoZyhKlvEJWAiKDsDPzAgkSxv4D5W9frVhv+wnpkK0YbodvrY7iYz/TK6MrIUVlwL4ddtAjBDjNbwm5NF4j3hMWgG0H5E2Ohwm/bLQ1AZF/qeCn/440Z52FaD0RSOkavo23FRXMgAfBucNgXuHLHUoO4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747586037; c=relaxed/simple;
	bh=AIdifPYCgNitnQmkjwa6oXqFv5d8J/QYu38GR+hWbh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSGLRvTM5cPv9/OZ08xUSXaL9lCQVW+cr4gXGhr+NQ54I7cej+ZHwDiXxXq5No3VAKTDJTeAPNKf5bISO4fQyVsczziCPj3tSggul8oIRuWC+PnXncZZNrvndOcxzmB59n8cLTCDuPAWPR6N4Lv3kvwzFgONEeap2ICBEsjd98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z92W3h2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE21C4CEE7;
	Sun, 18 May 2025 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747586036;
	bh=AIdifPYCgNitnQmkjwa6oXqFv5d8J/QYu38GR+hWbh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z92W3h2ueIH28d89Q769h0doFHIvdADv67w2UBtHkjaCHIOdGajyzA1ApsV5t8a0c
	 GCq1NjNOWXp2HMLPEzedJ78absoI8bafRC4Mbut1ePea0wmUCZVvgS7ukM58MB4QlT
	 fyblXpRnRAApNk0wSD5I66EUverNNpDVCmcNGpklDGZHllE8RAaMh8ijytjOlYcWVB
	 l7ma0/tAsVhOGHWoXBKQWp3nQgmk6jJ9b2LHPUnBkTVOCqwvqdJVG22SVHtqgKeiQZ
	 T7NweNdqstECbpUWdD/sOeBCv5rnwd5vE/YDVN26clWeUCCg3RnVJnasopOb3tNoFx
	 sCZBmURQESTRA==
Date: Sun, 18 May 2025 17:33:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, "Dragos Bogdan" <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Esteban Blanc <eblanc@baylibre.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] iio: adc: ad7405: add ad7405 driver
Message-ID: <20250518173345.338050e4@jic23-huawei>
In-Reply-To: <20250516105810.3028541-5-pop.ioan-daniel@analog.com>
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
	<20250516105810.3028541-5-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 May 2025 13:58:04 +0300
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order =CE=A3-=CE=94 modulator that conver=
ts an
> analog input signal into a high speed, single-bit data stream.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
More or less just one question to add to David's review.

It's around whether the clock is a separate thing or part of the backend
(which here kind of incorporates the bus controller).

We wouldn't bother specifying a clock line explicitly for SPI or PCIe so
why do we need one for this?

> ---
> changes in v3:
>  - edit ad7405_chip_info struct instances
>  - remove lock
>  - add implementation for IIO_CHAN_INFO_SCALE
>  - use IIO_CHAN_INFO_OVERSAMPLING_RATIO for controlling the decimation ra=
te
>  - use IIO_CHAN_INFO_SAMP_FREQ for read-only
>  - remove dem_clk_get_enabled() function
>  - remove chip_info variable from probe function
>  - fix indentation
>  - remove max_rate
>  - rename ad7405_set_sampling_rate in ad7405_det_dec_rate
> add adum7702 and adum7703 chip_info
>  drivers/iio/adc/Kconfig  |  10 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7405.c | 276 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7405.c

> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..1a96a283ab01
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/util_macros.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +static const unsigned int ad7405_scale_table[][2] =3D {
> +	{640, 0},
> +};
> +
> +static const unsigned int adum7702_scale_table[][2] =3D {
> +	{128, 0},

	{ 128, 0 },

Assuming you keep these (see David's feedback)

> +};

> +static int ad7405_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7405_state *st;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	st->info =3D device_get_match_data(dev);
> +	if (!st->info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_sup=
plies),
> +					     ad7405_power_supplies);
> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get and enable supplies");
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	st->ref_frequency =3D clk_get_rate(clk);

Perhaps an odd question but for a clocked lvds bus like this
is the clock actually something we should represent as part of
the bus (so iio_backend interfaces) or separately like this?


> +	if (!st->ref_frequency)
> +		return -EINVAL;
> +
> +	ad7405_fill_samp_freq_table(st);
> +
> +	indio_dev->dev.parent =3D dev;
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D &st->info->channel;
> +	indio_dev->num_channels =3D 1;
> +	indio_dev->info =3D &ad7405_iio_info;
> +
> +	st->back =3D devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get IIO backend");
> +
> +	ret =3D iio_backend_chan_enable(st->back, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad7405_set_dec_rate(indio_dev, &indio_dev->channels[0], 256);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


