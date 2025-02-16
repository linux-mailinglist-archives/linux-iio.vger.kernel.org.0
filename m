Return-Path: <linux-iio+bounces-15588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017FDA375D4
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D141E188AD4C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DD199EB0;
	Sun, 16 Feb 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aptDiueP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917518024
	for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723767; cv=none; b=mqu2u/MsjZFmDYqesKj2Y+ASgxYCVfCK6x7tRsFnYCloHZ1s0t+iANGZdcgoijDQP3GsUiG/w3wbFLwBVKYOpurRvgAPWQhXOPPrvFcFUVpT4JWcJY+PStajQUw0px79ldzp8zuI6MjeLzxNaQuU4k6+CPfqtEZddROg+bQjGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723767; c=relaxed/simple;
	bh=G5Y4LCD1obPlkF5dTWrxGhlVwuFNAyhD4tNtfzYYCEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3RdsEQiu3ox72G+lvra8+tkcTnYVi+rZXAM03WfDRCIb1yfYrZMkmcAliQHNkQwHYKKcneFxPMgL0nwviZcfeGfKMEe20epTsONhGAKIE979S4FndvwgG05WZh7eKOvJzCf2QNvGvsBhdYJUMSIsvyIn2Xr6Xa+meNe8V/enWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aptDiueP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A278C4CEDD;
	Sun, 16 Feb 2025 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739723767;
	bh=G5Y4LCD1obPlkF5dTWrxGhlVwuFNAyhD4tNtfzYYCEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aptDiuePzVsCKKVuPuRvUx4D7ZKijkFB6k5lZ3dLSbRp9FmtIf3vJS2yfhOAfNwDc
	 7FqD7OqWwE/p2M+IvebQUpd++6UAEYfhVdA/+IO22SFC0RN9q3HVJy3YnZK0pSSLto
	 Wh3ai10E1gNglI3mm3Ja/j2zK4B0gNBJvZbiuvqBw70lmHYbhLWEqoPF0ITk2pjMH+
	 EeD0FA4vU8kjSvmBXAQ2rE7JspW9Spn2iaEpxhdhxR4jOGu1CxKmmtZdJulMU/wfLr
	 7eSpzxxKTRMqR9C9P6il86+lXmPqF3O5HmWjRx49hDM6bfKQnFwV4V3o9PnGoymUX3
	 6MBU3RJtcXGqQ==
Date: Sun, 16 Feb 2025 16:36:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: adc: ad_sigma_delta: Disable channel after
 calibration
Message-ID: <20250216163600.42211c3d@jic23-huawei>
In-Reply-To: <20250212105322.10243-7-u.kleine-koenig@baylibre.com>
References: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
	<20250212105322.10243-7-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2025 11:53:23 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> The function ad_sd_calibrate() enables the channel to calibrate at
> function entry but doesn't disable it on exit. This is problematic
> because if two (or more) channels are calibrated in a row, the second
> calibration isn't executed as intended as the first (still enabled)
> channel is recalibrated and after the first irq (i.e. when the
> calibration of the first channel completed) the calibration is aborted.
>=20
> To fix this, disable the calibrated channel after calibration.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Whilst you said don't look in reply to patch 3 I ignored you. ;)

This feels like it deserves a fixes tag.

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index 10e635fc4fa4..fbe241b90f37 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -339,6 +339,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delt=
a,
>  out:
>  	sigma_delta->keep_cs_asserted =3D false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> +	ad_sigma_delta_disable_one(sigma_delta, channel);
>  	sigma_delta->bus_locked =3D false;
>  	spi_bus_unlock(sigma_delta->spi->controller);
> =20


