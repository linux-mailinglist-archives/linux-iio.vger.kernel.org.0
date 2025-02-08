Return-Path: <linux-iio+bounces-15169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1937A2D6D6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF767A1DD4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6E1A317F;
	Sat,  8 Feb 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbcM02D/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0B17597
	for <linux-iio@vger.kernel.org>; Sat,  8 Feb 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739027912; cv=none; b=V+PF+uld78AOyDOiiZEbVsdOoldkr1SfW5Txc/UPuygdvdCsfmboyhLmdyeC0q3WauWukUkUNFT7p/AZwFKOBf60AZtoCCycCC9EiJvyqGNXa6IXDMw9gWeAjz6A6meamO8oKfaiMIDJb60qtupyIif+38IcGsJF/5Fk+EikWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739027912; c=relaxed/simple;
	bh=ECCydZmhG6TEdw6FIafV/ureeZSHOdhxqYpu+mSmI7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbLy6ApGgmdz2XwX/fjgMSvk/FAm9hLe9QdKj7PgFBJm+Br9wWYA9r1LxPbJAN6CCi9kTxCLZCHMfvGVQGFxPTUlYa9ro0XnVIavcju6hXgOmI4h1RVyifDQG+AOBAsPOguJMOnnTN4jlr55EiZs+y3bavsIfgZdd3IU6CHZr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbcM02D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B54EC4CED6;
	Sat,  8 Feb 2025 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739027911;
	bh=ECCydZmhG6TEdw6FIafV/ureeZSHOdhxqYpu+mSmI7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SbcM02D/Awh+2RP3qP+05/alNZ1puAcTJnxtgAj0S1goK5XNRlpGl2rFQFBT+jBtm
	 yBVdY+WFGrKb5ZUyEL3ojRAOTFNvEnI34uza0AE0zMMcFmBfAQEpaMBm47A71uUQwk
	 Y4eu8qwRDzCQnK7KJ47Hk1YN5w1Uthn+5TeV5v5DE+SPizrGSHFzOGpPz1XM5s0HZh
	 QTEUrTit/4etUAdDvrQE2RrnetBuUO9H9ntMQpgzdpEUg38P7Oz6lW9y9mPcyKIOwO
	 aI7Ka9au3UR9sXtDCJdTm+SyMZxT/2FvgIjonZ05dlqN8IF0JsiCWcPwJC3mc7TxoS
	 PHfo2EZF2BVpw==
Date: Sat, 8 Feb 2025 15:18:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: adc: ad7124: Really disable all channels at probe
 time
Message-ID: <20250208151824.6433a876@jic23-huawei>
In-Reply-To: <20250204115023.265813-2-u.kleine-koenig@baylibre.com>
References: <20250204115023.265813-2-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  4 Feb 2025 12:50:23 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> If one or more of the 16 channels are enabled and the driver is not
> aware of that, unexpected things happen because different channels are
> used than intended. To prevent that, all channels should be disabled at
> probe time. In Commit 4be339af334c ("iio: adc: ad7124: Disable all
> channels at probe time") I intended do that, however only the channels
> that are potentially used by the driver and not all channels are
> disabled since then. So disable all 16 channels and not only the used
> ones.
>=20
> Also fix the same issue in the .disable_all() callback.
>=20
> Fixes: 4be339af334c ("iio: adc: ad7124: Disable all channels at probe tim=
e")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

I've applied this on the togreg branch of iio.git but you may need
to do a manual backport of the fix to get it on 6.14 once that's
released.

Jonathan


> ---
> Hello,
>=20
> this patch is based on v6.14-rc1 + the patch "iio: adc: ad7124: Micro-opt=
imize
> channel disabling"
> (https://lore.kernel.org/linux-iio/20250120140708.1093655-2-u.kleine-koen=
ig@baylibre.com)
> that Jonathan claimed to have taken already.
>=20
> Best regards
> Uwe
>=20
>  drivers/iio/adc/ad7124.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 2fdeb3247952..6bc418d38820 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -550,11 +550,10 @@ static int ad7124_disable_one(struct ad_sigma_delta=
 *sd, unsigned int chan)
> =20
>  static int ad7124_disable_all(struct ad_sigma_delta *sd)
>  {
> -	struct ad7124_state *st =3D container_of(sd, struct ad7124_state, sd);
>  	int ret;
>  	int i;
> =20
> -	for (i =3D 0; i < st->num_channels; i++) {
> +	for (i =3D 0; i < 16; i++) {
>  		ret =3D ad7124_disable_one(sd, i);
>  		if (ret < 0)
>  			return ret;
> @@ -1017,11 +1016,10 @@ static int ad7124_setup(struct ad7124_state *st)
>  		 * set all channels to this default value.
>  		 */
>  		ad7124_set_channel_odr(st, i, 10);
> -
> -		/* Disable all channels to prevent unintended conversions. */
> -		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
>  	}
> =20
> +	ad7124_disable_all(&st->sd);
> +
>  	ret =3D ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control=
);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to setup CONTROL register\n");
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> prerequisite-patch-id: c8d3727852b9c3bb4dcd2f16508bebbd093a3768


