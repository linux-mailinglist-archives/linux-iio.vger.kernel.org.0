Return-Path: <linux-iio+bounces-11396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC49B1D79
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 12:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0719281971
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204F61531C1;
	Sun, 27 Oct 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly9NocAJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB53F9D2;
	Sun, 27 Oct 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730029357; cv=none; b=bhiMf2bweJhvMcOvp7Pn6d9fq1uPOyZ9zGmE+yX580RY9kd4c6+IJ4+FeIu53n0w5XIf+TZxJnBVtZNpHdFYZf7XvXXQSgViWol+bmE5VCFi4baIaRE6cIwfI+KXoXIXOCf4n3Z4PDfZQD6MUzU2e6UZhqve9DxrNFMph2RLCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730029357; c=relaxed/simple;
	bh=Nn2mF7gvOERyi5f3gjbRWSLp2aZhycO455b8573WBz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqUVDRn40llw/IIIp1+TtoARsIA+89eoN6wIX/599Ya+Im+3zEIpqZXC4ls+uW3Ma5o7RiZ6ILYri8jBHcrspHJ8qo3HgYMhNFbnHt2v3F84bCAqrhj6tMhrk8ck1ePFIzdcRCpJhTcIrJSfAD/jl230KLOd3LWQMLrMR79QW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly9NocAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7577BC4CEE4;
	Sun, 27 Oct 2024 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730029357;
	bh=Nn2mF7gvOERyi5f3gjbRWSLp2aZhycO455b8573WBz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ly9NocAJ8M/GknjwcZPV0hn88OKm4OoAQXl1fTsMp3hbXraY0Bah2DpgVTSx5u/s+
	 43rT6gxD1nj5C3C9KWQP+Ay7Ahpu4VmhqaSS0H+yWyK/npdI3hjb6rH9O8yQhdCm/L
	 zFa/EiDXHBUjCrVOAR5UDY2ouGWjNG0dFheTKZWj+bKxJiuMhpDJ6ish/hkl9hY4zH
	 iMR+mp9gPYKwh9gA8spOt0nDvvn7WQeAsJyuX7oDyXWJS2Ywt7vBYQC+9RlOj9u6Nn
	 NA+Tsk2urokJ2GiieWBGsMZikJNpD0O8Y0qAltdHXOgcYZx5OnXqynqs9EewnhwwFb
	 U3tKsCju1tp3A==
Date: Sun, 27 Oct 2024 11:42:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Dumitru
 Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7124: Disable all channels at probe
 time
Message-ID: <20241027114228.5e418341@jic23-huawei>
In-Reply-To: <20241024171703.201436-8-u.kleine-koenig@baylibre.com>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
	<20241024171703.201436-8-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 19:17:05 +0200
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
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Makes sense in general, but one comment inline.

> ---
>  drivers/iio/adc/ad7124.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index a5d91933f505..912ba6592560 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -917,6 +917,9 @@ static int ad7124_setup(struct ad7124_state *st)
>  		 * set all channels to this default value.
>  		 */
>  		ad7124_set_channel_odr(st, i, 10);
> +
> +		/* Disable all channels to prevent unintended conversions. */
> +		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0x0001);
Why 1?  Build that default up from the register definitions rather than a m=
agic
constant.


>  	}
> =20
>  	ret =3D ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control=
);


