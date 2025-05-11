Return-Path: <linux-iio+bounces-19434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A02AB2947
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41331898713
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B7F25A658;
	Sun, 11 May 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LANzWq5f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1D645;
	Sun, 11 May 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746975769; cv=none; b=jPAmKZbydn8iBGDGhiDaEBgkUwC0wFJKOWvsKUuauCbHahSYJBwVUHfFXWku8fDdspyMP7clc0HkG0YRZWNKZzwc+mtXTNw1X4iCqoD2SMlrsBjRkw4vQlCYDRUty3qjEjAfnuxQ7VMTdccu6GAufcmReW/+2DqXljqxU/62Z74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746975769; c=relaxed/simple;
	bh=1AD6Utpfn440il0PbmRGJ99ClfY2SGfEe5WQyr4P4sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVP2hzaGIy4FfZkNdcKDyo0ppKPbyOOE6czvS8VFOjD94fpd8mVFpivjS3ss1Yg8jL92uu33cnHpUx3iYNULejU8hdd4Llty8qc/Y3gxIuo2POijIo6ajEMc/iTVNvYCB4psjD1w20/IUUvEp9A3f/ttNnO7VKydpquP03tpPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LANzWq5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2638C4CEE4;
	Sun, 11 May 2025 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746975768;
	bh=1AD6Utpfn440il0PbmRGJ99ClfY2SGfEe5WQyr4P4sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LANzWq5fyWVy0NMl0vOcvg5hh8GR/Ms12Tu5500tirIwAOdDn9DoB0PtMtUiL48b+
	 Ny/04Jsh4Mmh24q5lzfLYoy8pAwQa8zkNxQ5NP637bZSXAxd6mM8chWuBB875QtSFy
	 J0zTwhmIJ2D/U5B0Xmgg2M9HWVZktmo/E4jYcvchSTjT5VhjMB0AQf1flXzWzAGoaT
	 xKChCEaAK0nt0xwtQ87gxMfgL4PSztzL7vsXHyTfaN+MicT9Kq7fYoQSSdBqusz28J
	 ARcJAynfQK/CTIHhKv/A/PxP9Ommrg4O904uZOHtjtb/1t2efSF8xp8FroHbWJuY9H
	 toeUF8xvM/ltQ==
Date: Sun, 11 May 2025 16:02:33 +0100
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
 Alisa-Dariana Roman <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7405: add ad7405 driver
Message-ID: <20250511160233.66bd8e71@jic23-huawei>
In-Reply-To: <20250508123107.3797042-5-pop.ioan-daniel@analog.com>
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
	<20250508123107.3797042-5-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 May 2025 15:30:57 +0300
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order =CE=A3-=CE=94 modulator that conver=
ts an
> analog input signal into a high speed, single-bit data stream.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Hi,

Just a few comments inline.  In particular I'd avoid the gcc specific
behaviour unless we have it documented somewhere in the kernel that
static flexible array instantiation is allowed.

Doesn't make sense here anyway just make it 1 element.

Jonathan

> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..5fe36ce61819
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,264 @@

> +
> +struct ad7405_chip_info {
> +	const char *name;
> +	unsigned int max_rate;
> +	struct iio_chan_spec channel[];
See below.

> +};

> +static int ad7405_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad7405_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +			*vals =3D st->sample_frequency_tbl;
1 tab only.
> +			*length =3D ARRAY_SIZE(st->sample_frequency_tbl);
> +			*type =3D IIO_VAL_INT;
> +			return IIO_AVAIL_LIST;
> +	default:
> +			return -EINVAL;
> +	}
> +}

> +
> +static const struct ad7405_chip_info ad7405_chip_info =3D {
> +		.name =3D "AD7405",
> +		.channel =3D {
> +			AD7405_IIO_CHANNEL,
> +		},
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info =3D {
> +		.name =3D "ADUM7701",

Convention here is 1 tab indent only.

> +		.channel =3D {
This will look nicer without the array of 1 thing going on.

Interesting corner of the c spec to use a flexible array member
for this. Definitely don't do that as I hate reading that spec to
check corners like this.  On this occasion I looked and could
not find an answer.  There is a gcc extension that makes this work
though.

> +			AD7405_IIO_CHANNEL,
> +		},
> +};

