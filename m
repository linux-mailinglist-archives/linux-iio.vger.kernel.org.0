Return-Path: <linux-iio+bounces-20295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631BAD0E38
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13C516DCF2
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8F1E25E3;
	Sat,  7 Jun 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV1gldYT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A259BA3D;
	Sat,  7 Jun 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749311083; cv=none; b=JrnddMNpfaqiVTJ9nNL9mjrcaSLzGn8BoFL5Dce58myR/BYSVrizoy0lY7SgyoRymZAIIp8KtIgdqzoFP556YYqSqhLMhlQihlgR7GrpYvQLls4IKiCFo8S1boHq5axlPl5nYl0XCZgiHcHv3axoBv+ZYmsExjjaheS0Vb+DQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749311083; c=relaxed/simple;
	bh=8Hgf8UjA55xEC4RTiYbsr75l0/paF8Di6tHJfITn3QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+GCj4nm3MWuVeIl5I36v0/xoAlr0JljvteexVbJYUpdzpLKfMCJOipCrjVSg/cYzps6hPsIk9/w1OgMI0hrEsYSPeGkAdrPcZW8mf/rFsVmBYzZRbmeqkkS8QGqkV7xi+td3heuaHX2XXSAYyYjj4Cuv/oRpfXh2HogJ/v2ZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV1gldYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155C9C4CEE4;
	Sat,  7 Jun 2025 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749311083;
	bh=8Hgf8UjA55xEC4RTiYbsr75l0/paF8Di6tHJfITn3QI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IV1gldYTM2BayDSWKgSDYcxq0pw/6u2tDU32id/Xpxy1I9EjoVtvAMuOU48DxNp9R
	 elorXXDBnX+3or4yy2nH924IewCd+1YPP5wf43cST+0bMxzIsKjtMlUvsiA6gdQnfp
	 q4JHx+lcG5iAnrZd1aWsjZMLXPkmv4aKedV7Zn7qeNrBDaWDcYOt30BjCJutPzNOYy
	 4cemjoqs2c9rBNV0O0e1zlBqBM+XzWy5NAKIHBezyEfabbCuXaI8pSwEoianS99b7y
	 TCJW6tV4x6PCS3ymUnv+5mbdN56S/uWok2zZStjuHr2vXSPhhjf/lU6/ZQLwqQfSSB
	 9pLzb+74wlAww==
Date: Sat, 7 Jun 2025 16:44:28 +0100
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
 <mazziesaccount@gmail.com>, Angelo Dureghello <adureghello@baylibre.com>,
 Guillaume Stols <gstols@baylibre.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Herve Codina <herve.codina@bootlin.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>, =?UTF-8?B?Sm/Do28=?=
 Paulo =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] iio: adc: ad7405: add ad7405 driver
Message-ID: <20250607164428.7a245af5@jic23-huawei>
In-Reply-To: <20250605150948.3091827-6-pop.ioan-daniel@analog.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
	<20250605150948.3091827-6-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Jun 2025 18:09:43 +0300
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order =CE=A3-=CE=94 modulator that conver=
ts an
> analog input signal into a high speed, single-bit data stream.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>

Hi Pop,

Only one comment from me. I can tidy that up whilst applying but
given there were 3 versions and quite a bit of feedback in the last week
I'd like to give others time to take another look before picking this up.

If everyone is happy with it, I'll apply with tweak as below unless
you let me know you will be using different channel types in a follow
up series that you are going to post very soon?

Jonathan

> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..c07b90fbd429
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,259 @@

> +#define AD7405_IIO_CHANNEL {					\
> +	.type =3D IIO_VOLTAGE,					\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.info_mask_shared_by_all =3D IIO_CHAN_INFO_SAMP_FREQ |	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.info_mask_shared_by_all_available =3D			\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.indexed =3D 1,						\
> +	.channel =3D 0,						\
> +	.channel2 =3D 1,						\
> +	.differential =3D 1,					\
> +	.scan_index =3D 0,					\
> +	.scan_type =3D {						\
> +		.sign =3D 'u',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +	},							\
> +}
> +
> +static const struct ad7405_chip_info ad7405_chip_info =3D {
> +	.name =3D "ad7405",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,

Why do we need this .channel element if all instances use the
same one?  If you are are shortly going to add support for more devices
where this will change then this is ok.  If not, just have one
static const channel and use that without looking it up via these
chip_info structures.


> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info =3D {
> +	.name =3D "adum7701",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7702_chip_info =3D {
> +	.name =3D "adum7702",
> +	.full_scale_mv =3D 64,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7703_chip_info =3D {
> +	.name =3D "adum7703",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};


