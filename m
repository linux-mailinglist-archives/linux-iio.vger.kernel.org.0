Return-Path: <linux-iio+bounces-12887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19279DF2B6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A24281282
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131821A76B2;
	Sat, 30 Nov 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYAffwYa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6317BD3
	for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993197; cv=none; b=chOdLvDSZDBIz/I0jJLw/FuVS5wUTV+6Y6pc/5qAcifNvABrHd6btMIx9EG9pjsE/mekmSd51Hmx1Xqroinp2zIhgjkacMGwwhGduRFGp/vl/CRD66D67WIDSjDOEXiVoAVvZAXUjbZJx7WWV/nze1y83dLy3WnusgefH1Ig08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993197; c=relaxed/simple;
	bh=Qs1UyRcrvBZ6H4ClHnUX2TJAJjFDdE0EhAij/LUYLWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhGwBi3EO8N2TFuKXRDRUZ6/bj0PiEsOAKzYdWFbuX3yA2lAb7TqU2Ioizv4Km3q2CZPH/3cif2FEx0UzBCPlDH1UjpvJyZV7hLPmG0+1s2+DM6Wm2YWV535A9lHRYv1fayrUovQZTgx3aamrwcRhM2Viz6wtTtUQl179Q6rL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYAffwYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14571C4CECC;
	Sat, 30 Nov 2024 18:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732993197;
	bh=Qs1UyRcrvBZ6H4ClHnUX2TJAJjFDdE0EhAij/LUYLWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYAffwYaucKfFeIUCp63rJKrpV9S2PcaxrU4KiLIbfmhvnxw2NKyiF0yA/K4qV07Z
	 ni17xdi/TDSiM9AM+v6cIhivMOhIXFrSTkrEw9K2TgHeR0Idvffis5tBJ/AM8jF72w
	 7z5rboMzmCwI4RTcf2D4kcvPgv8PLeaq0lAPbHXaYugzqMWZ1SIdQGRssXYjqnFB7Z
	 lpwJmd3XkSASsf5qDJ+fEVEBlMqIKBxUuoRrQl7/c+eoyqrBVf92XqiuTp7w15/OOj
	 9bnFs6L3aaMVvnDp1Wtj8YykMkC+QWFkjKTAJL5NioJDA0LB6Af5M8/GkIO8uh79Kv
	 S/Mg1NgnM7E3Q==
Date: Sat, 30 Nov 2024 18:59:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v4 10/10] iio: adc: ad7124: Implement temperature
 measurement
Message-ID: <20241130185948.300b94c4@jic23-huawei>
In-Reply-To: <20241127145929.679408-22-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
	<20241127145929.679408-22-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2024 15:59:39 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> If the maximal count of channels the driver supports isn't fully
> utilized, add an attribute providing the internal temperature.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
LGTM

For the whole series, I would ideally like an additional review from someon=
e more
familiar with these parts than I am.

Thanks,

Jonathan


> @@ -902,6 +941,37 @@ static int ad7124_parse_channel_config(struct iio_de=
v *indio_dev,
>  		chan[channel].channel2 =3D ain[1];
>  	}
> =20
> +	if (num_channels < AD7124_MAX_CHANNELS) {
> +		st->channels[num_channels] =3D (struct ad7124_channel) {
> +			.nr =3D num_channels,
> +			.ain =3D AD7124_CHANNEL_AINP(AD7124_INPUT_TEMPSENSOR) |
> +				AD7124_CHANNEL_AINM(AD7124_INPUT_AVSS),
> +			.cfg =3D {
> +				.bipolar =3D true,
> +			},
> +		};
> +
> +		chan[num_channels] =3D (struct iio_chan_spec) {
> +			.type =3D IIO_TEMP,
> +			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +			.scan_type =3D {
> +				/*
> +				 * You might find it strange that a bipolar
> +				 * measurement yields an unsigned value, but
> +				 * this matches the device's manual.

I did indeed ;)  So good comment.

> +				 */
> +				.sign =3D 'u',
> +				.realbits =3D 24,
> +				.storagebits =3D 32,
> +				.endianness =3D IIO_BE,
> +			},
> +			.address =3D num_channels,
> +			.scan_index =3D num_channels,
> +		};
> +	};
> +
>  	return 0;
>  }
> =20


