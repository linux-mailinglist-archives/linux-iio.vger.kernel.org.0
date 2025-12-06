Return-Path: <linux-iio+bounces-26819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A16CAA0A5
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 05:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848C8315113D
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 04:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC52325EF9C;
	Sat,  6 Dec 2025 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoFcgeeo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E721767A;
	Sat,  6 Dec 2025 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764995059; cv=none; b=UOCOmZIWulpbdZ17RZVXASo5MpVY6Znob5Z3xaAODZA+KFRcW/bwO2kPzc09Q9qECUzxqRbPLf0T7uEoB8XFWlhwy9A2EbIXAcEASmKEb4Y4eYezPjvOYB/moP1N9cFQuVZwO1dpICJ5eaQmgiOjSNjAf7vAlMITRcK5Vf2Ixa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764995059; c=relaxed/simple;
	bh=kJ3TGUL3SANRkGMPCi9jeyzNrPwCNiyxvYMF2hZXIpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm/cg+ePwrFOWbXCTUX3hzSHlnRSs0mFwE4k47Q5UX6wDgDl9hL0ZsETH0Wnm3yLdnWL06tD17quzztBqPMyIZn8eQ5pJbk0HfzuQ5cO8YW0sOUCg2Sjl8leLuswXT11rjmgJayRGnI8fg7ZsWa2EqGrsxSKozf9cIMCxQSTohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoFcgeeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD4EC4CEF5;
	Sat,  6 Dec 2025 04:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764995059;
	bh=kJ3TGUL3SANRkGMPCi9jeyzNrPwCNiyxvYMF2hZXIpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoFcgeeobAS//9hGRjhzgKRtdn27B3hOqCOWj54gxl/gjevkwGYVcOadLcv56aaDi
	 KQHOf2/w+UkNYpv2MAwXPQCT2Gf6qGV6kpu2Mxnlqbv2lZRCuB0yNgBpGQ15GNaeAi
	 sLur7vVa8XN76x6pWjquLQ5lqu1rWz0cHXgvgRvUCyCvzr1hGf7FDnU5okY15axcvj
	 iHOuEnbP1yTCdOIP2F5yM3z4wVLWKCdVt84uiZ5fp4WgrbRmpuK7uxttnB3750rnwd
	 tYNllJWLnBjHoSauTf7rS2XtfQFSw3rWUhJf+yWXfynlKx7iWic4fBT3pCNKtwrCoU
	 eKBX7BDfOB7Mw==
Date: Sat, 6 Dec 2025 13:24:16 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Fix incorrect return value in IRQ
 handler
Message-ID: <aTOv8GxTcWRR39y7@emerald>
References: <tQ6gupeNR5WXy61K0UZmDNzA2jlqAjibu-EqYV_XRtlg9D0x97yhFy6HUvzN7vLm6DePuDcSVd_qZ_lqin6_8Q==@protonmail.internalid>
 <20251202083952.1975-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iArf0UCF4CFtSq80"
Content-Disposition: inline
In-Reply-To: <20251202083952.1975-1-vulab@iscas.ac.cn>


--iArf0UCF4CFtSq80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 04:39:52PM +0800, Haotian Zhang wrote:
> quad8_irq_handler() should return irqreturn_t enum values, but it
> directly returns negative errno codes from regmap operations on error.
>=20
> Return IRQ_NONE instead of raw errno codes on regmap operation failures.
>=20
> Fixes: 98ffe0252911 ("counter: 104-quad-8: Migrate to the regmap API")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/counter/104-quad-8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index ce81fc4e1ae7..17f4da6c24af 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1201,7 +1201,7 @@ static irqreturn_t quad8_irq_handler(int irq, void =
*private)
>=20
>  	ret =3D regmap_read(priv->map, QUAD8_INTERRUPT_STATUS, &status);
>  	if (ret)
> -		return ret;
> +		return IRQ_NONE;
>  	if (!status)
>  		return IRQ_NONE;
>=20
> @@ -1233,7 +1233,7 @@ static irqreturn_t quad8_irq_handler(int irq, void =
*private)
>=20
>  	ret =3D regmap_write(priv->map, QUAD8_CHANNEL_OPERATION, CLEAR_PENDING_=
INTERRUPTS);
>  	if (ret)
> -		return ret;
> +		return IRQ_NONE;
>=20
>  	return IRQ_HANDLED;
>  }

Hello Haotian,

You are correct, we should return a value of irqreturn_t and not raw
errno codes. However, it would be nice to indicate to users why the IRQ
was left unserviced before return IRQ_NONE. Is there a way to indicate
the regmap_read failure, perhaps via WARN_ONCE() or similar? Is
regmap_read actually capable of failing in this context, or should we
just remove the conditional check entirely?

William Breathitt Gray

--iArf0UCF4CFtSq80
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaTOv8AAKCRC1SFbKvhIj
K6n9AQCZeWnO9o/Wro2aPSGJICd88CcmRRAek+Phe9s3micvxAD/QEULQMnTtwBF
7+J9PZ8XQ+R12HG7L7eP0juShcgf4Qw=
=hbip
-----END PGP SIGNATURE-----

--iArf0UCF4CFtSq80--

