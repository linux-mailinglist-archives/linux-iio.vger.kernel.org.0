Return-Path: <linux-iio+bounces-8552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B776C955877
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B171C20C15
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E891E519;
	Sat, 17 Aug 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzlxxNs7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4179D26D;
	Sat, 17 Aug 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723906720; cv=none; b=LWLIl0uMYMEEACnIW/SPP0trIzwD2NaUtMGeqS7RQYxOYMt/Fr2sB4gQoXF0DhWqxQwjjy+AQYpH9o0aNEdclBVZgomAvEI0QxYrekzTjrYTUaHEsNEDxTJbDS7o+TOPoDrcRHXYvjIqB2biQXh4xAiBotQ+3G+8/9TUgacZqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723906720; c=relaxed/simple;
	bh=lP/gXH59tE6iYDas8OZ7e8FvTSLg9EsvnONZAQHDfws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvJQ8Eqd6rrugrDHkiFGwdWi9NIx8eMCi4RTjdWPlivolhr2WEWSj4FGVKBe2ZVQCloQO3dJgEghTSKqeVSqNw+bgj7YxhXG4ub3QIF6LQhZZCEX3M9CyHnWUkRsH/24FusI/ZPfZRM9mNlvUqJCVGznpUY17PTrueqQfBv8kQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzlxxNs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF033C116B1;
	Sat, 17 Aug 2024 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723906719;
	bh=lP/gXH59tE6iYDas8OZ7e8FvTSLg9EsvnONZAQHDfws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bzlxxNs7+t8GbFu/RCA9O+gKDZHD8lVIKFkW+VqEqhai/p4hpdqTqIzG3nKCC8nlw
	 WT3dhqKRbXqpHpt4jOqaSlH5t49KdMVqRkMYLjtBvXm+PG2j59Fa3eWvlHwoo/LFiR
	 40PqnioCeNrLguYEFpKQZBLFMDtrz58iEf1D+FFdzaqwuvwgTAPQKEqsIU9zrHXT0E
	 +paZVXE3w/m4rQGb2d6xZraSxoKr1/Yw8BF1LlHobul3MBeiBrErVVgyu1Hji+Jj00
	 DPtwoA5RymyssF2DEedQbVb9vzrd9GEnXZyZMeXErI247fnuhh8grud35CtsStmgbI
	 GrWafpnjo6jUA==
Date: Sat, 17 Aug 2024 15:58:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael.Hennerich@analog.com, lars@metafoo.de, gstols@baylibre.com
Subject: Re: [PATCH] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from
 probe
Message-ID: <20240817155833.4dcc3004@jic23-huawei>
In-Reply-To: <20240817144216.16569-1-aardelean@baylibre.com>
References: <20240817144216.16569-1-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Aug 2024 17:42:15 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> This change moves the logic for setting up SW mode (during probe) into it=
's
> own function.
>=20
> With the addition of some newer parts, the SW-mode part can get a little
> more complicated.
> So it's a bit better to have a separate function for this.
This looks fine but put it on the start of the series that makes it more
complex.  I may pick it off that series before the bulk of the code
but if it's sent in such a series the link tags etc will let people
see 'why' it is a good idea.

Jonathan

>=20
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 43 ++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 68481e97e50a..192b9cd56b45 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -545,6 +545,29 @@ static const struct iio_trigger_ops ad7606_trigger_o=
ps =3D {
>  	.validate_device =3D iio_trigger_validate_own_device,
>  };
> =20
> +static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	if (!st->bops->sw_mode_config)
> +		return 0;
> +
> +	st->sw_mode_en =3D device_property_present(st->dev, "adi,sw-mode");
> +	if (!st->sw_mode_en)
> +		return 0;
> +
> +	indio_dev->info =3D &ad7606_info_os_range_and_debug;
> +
> +	/* Scale of 0.076293 is only available in sw mode */
> +	st->scale_avail =3D ad7616_sw_scale_avail;
> +	st->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> +
> +	/* After reset, in software mode, =C2=B110 V is set by default */
> +	memset32(st->range, 2, ARRAY_SIZE(st->range));
> +
> +	return st->bops->sw_mode_config(indio_dev);
> +}
> +
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops)
> @@ -617,23 +640,9 @@ int ad7606_probe(struct device *dev, int irq, void _=
_iomem *base_address,
>  	st->write_scale =3D ad7606_write_scale_hw;
>  	st->write_os =3D ad7606_write_os_hw;
> =20
> -	if (st->bops->sw_mode_config)
> -		st->sw_mode_en =3D device_property_present(st->dev,
> -							 "adi,sw-mode");
> -
> -	if (st->sw_mode_en) {
> -		/* Scale of 0.076293 is only available in sw mode */
> -		st->scale_avail =3D ad7616_sw_scale_avail;
> -		st->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> -
> -		/* After reset, in software mode, =C2=B110 V is set by default */
> -		memset32(st->range, 2, ARRAY_SIZE(st->range));
> -		indio_dev->info =3D &ad7606_info_os_range_and_debug;
> -
> -		ret =3D st->bops->sw_mode_config(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret =3D ad7606_sw_mode_setup(indio_dev);
> +	if (ret)
> +		return ret;
> =20
>  	st->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
>  					  indio_dev->name,


