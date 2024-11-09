Return-Path: <linux-iio+bounces-12091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E29C2E2C
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D131C20CCF
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71BB1991A5;
	Sat,  9 Nov 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGYBB6o8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820576E2BE;
	Sat,  9 Nov 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165885; cv=none; b=uqZ8oDByfl5Ep4DmkBxQosesHvGn+9ciF+SWnY9s3tIUKWnAfepJejznBcgA5ua3PWdyXdSsOSOgj6qZMe0XVWcMYPyej3gVt37/gqzRMm1PCiazcLI+sdq5gcsQmcgwu3nTm7nQQLW855sTuaYG1hFZUXWZNc4bWsP3ElKPqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165885; c=relaxed/simple;
	bh=L+h15+A5fyghSoJgKxEEP8ui0ELpN/bVPJgv1ITqXqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1HtBrufx8tigPug5pNieYs9C3XjhwdJSbstfRQFFRKE8Aqwm1TIeLPCeRfV9IT4rI6JkYr1y8aiCvab0iVnB5FM0n0CSzbA0b6CGQ0zjwjuFBthhGVheCjFXoqeNnCjOO//O8Af+P4WrmlGjsgJYNwD03EC0Q1XydKQYaTx3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGYBB6o8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A836C4CECE;
	Sat,  9 Nov 2024 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731165885;
	bh=L+h15+A5fyghSoJgKxEEP8ui0ELpN/bVPJgv1ITqXqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tGYBB6o8qMeN8R22+aZYFW9bTEvfBn9GMAFrwQcdk0TI49tLTv96nWqq8LUdCWs0b
	 K0mzkfxOrAw5pxSYQk2deHW5av5yiHqsSfUzg6JrNeEytigLFFGkrLc+GaUM+fO1iR
	 vnSu24onnfWjNzsLWDJpcae6b7Dtw2+ovYJAxdmPa2uJZADS6UC6P0GuEKK1WlbTvc
	 NkHHUZ1CnjePGN45W3EobZWDgFOoozleyk2BYn9jj8etx0cuhU7wLDHeC5weaFaf+V
	 utHVPOolmG6jc51ShZDw2wvhEgHREBiieYY2klhsc+9TkrwbdXXuA5Gdq4rhsg27lh
	 Xn20r7TY0VK/g==
Date: Sat, 9 Nov 2024 15:24:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Guillaume Ranquet <granquet@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: Disable all channels at probe time
Message-ID: <20241109152438.0135f0c2@jic23-huawei>
In-Reply-To: <20241104101905.845737-2-u.kleine-koenig@baylibre.com>
References: <20241104101905.845737-2-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  4 Nov 2024 11:19:04 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> When during a measurement two channels are enabled, two measurements are
> done that are reported sequencially in the DATA register. As the code
> triggered by reading one of the sysfs properties expects that only one
> channel is enabled it only reads the first data set which might or might
> not belong to the intended channel.
>=20
> To prevent this situation disable all channels during probe. This fixes
> a problem in practise because the reset default for channel 0 is
> enabled. So all measurements before the first measurement on channel 0
> (which disables channel 0 at the end) might report wrong values.
>=20
> Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>=20
> this patch was part of a series before. The remaining patches are still
> under discussion. As this is a fix orthogonal to the other patches of
> the series (apart from the other relevant change there also being
> necessary to make the ad7124 work for me) it IMHO makes sense to apply
> this one already now. There are machines that don't suffer from the
> other issue (i.e. the device irq becoming pending by spi traffic), so
> this fix is also valuable stand alone. It's IMHO good enough to go in
> before v6.12.
>=20
> The previous submission is available at
> https://lore.kernel.org/linux-iio/20241028160748.489596-10-u.kleine-koeni=
g@baylibre.com/
>=20
> b4 ignored Nuno's Reviewed-by tag with
>=20
> 	NOTE: some trailers ignored due to from/email mismatches:
> 	    ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 	     Msg From: Nuno S=C3=A1 <noname.nuno@gmail.com>
>=20
> I wonder if other maintainers use b4 apply's -S by default, because I
> often run into this issue but don't see others mentioning that.
I only use -S when Nuno has given a tag.  It tends to be a bit too generous
on applying tags in general.

Thanks for picking it up here.

Sadly this has probably missed 6.12, but I have queued it up as a fix
for early next cycle and marked it for stable.

Thanks,

Jonathan

> I added the tag here anyhow.
>=20
>  drivers/iio/adc/ad7124.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index a5d91933f505..749304d38415 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -917,6 +917,9 @@ static int ad7124_setup(struct ad7124_state *st)
>  		 * set all channels to this default value.
>  		 */
>  		ad7124_set_channel_odr(st, i, 10);
> +
> +		/* Disable all channels to prevent unintended conversions. */
> +		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
>  	}
> =20
>  	ret =3D ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control=
);
>=20
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc


