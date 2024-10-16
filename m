Return-Path: <linux-iio+bounces-10664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D929A1498
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 23:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F221C21826
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3F1D1F72;
	Wed, 16 Oct 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="cJ8mC289"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B15478E;
	Wed, 16 Oct 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112952; cv=pass; b=aNW4Oi8+8F/n8BQfgAkluC/xbNcPKqCdHcyrD2GdhPCbg5tDuY8NNzAdzuvvaJU8kQtJMYwqpR25d/qILRIUuzfThjFAlp04OolLy+gpbou1KpptvGNsw+5W8Xo/LooVn46yMg86lEYL4fQNUUcR4jPqOMyJrtRzppOUFQ0oCU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112952; c=relaxed/simple;
	bh=0+/gOofFsi9y7W7CR0Vh3GmtxpBEIW2ejcZ6SSgd9u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTHpwWCyFYqE0bpvg0+o16phuV6d7qOyQlFA0iE1TjFJj16EYM1Ww6N7ocmayFHelAaVh4BBtUVfcXGYRTB22EmnBIwZmsPkU0zEVe1bqOK7BkvyIYi304/BxOOW7UNcsCYDWBrEQcCbw7iid4F8RjqTEUQ4TjqFWPYGHDnnroM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=cJ8mC289; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729112918; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P/sQO56NlFMcz8/Wtr3rvXuE3ImE+rn+9KYMixtkTpmiTBuBPgzzl7rWQK7sxKZpcIZNudwDMs3W76fYQxUGAQpZaOiLiNGsZhF1ITQBdVoPL+xZH81MB+XXEm1hyNGM34kACQsc5cnFwUHR5s70BtH7pIzStZy/oXdkvsg1Io4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729112918; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OevVExCd74K4CyzC/2y78MWTRGO9BEZ5ceg9Xn4oW9Q=; 
	b=WA7G/mTI3tuk/+QwbO0vA8BQPiBPfC1q/9aevZC9u6FWz77/O4Ngu3IKDkZPz6o6ljoXz8s0PXz6iqWXVlnSTx9UxPCTh9ept1TjPXcAYplSUcF6zi00vSxYv39TZb2JvvvwS7SItZPQQj+MvoqkuLmW09LPMRnhFsdRoY4me6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729112918;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=OevVExCd74K4CyzC/2y78MWTRGO9BEZ5ceg9Xn4oW9Q=;
	b=cJ8mC289aPpdg4XIj+WzPPSGf3XLikTxs/jUnzQGjbqrAw9mIIXlq1f0JRPYs4fw
	pB1xFcR14rG99ZC7QAwcxJku4dRbWZTXOvXoMgNOy4Qj4uldzD0Vrw1XY2/M8u2/9RM
	uPWrjnz+LwWs43FloZCEWcgtIKSpziCiDzhomeIg=
Received: by mx.zohomail.com with SMTPS id 172911291581182.66214312711384;
	Wed, 16 Oct 2024 14:08:35 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 945E5106044F; Wed, 16 Oct 2024 23:08:30 +0200 (CEST)
Date: Wed, 16 Oct 2024 23:08:30 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, 
	Peter Rosin <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <7qvxz3fuwcjeq2ewv3nterlf72wbymt7np5nnjitzkt6smzh7v@737455c4xapy>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
 <20241015-iio-read-avail-release-v3-2-ac3e08f25cb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="omr3pkjg6x5yc4vn"
Content-Disposition: inline
In-Reply-To: <20241015-iio-read-avail-release-v3-2-ac3e08f25cb3@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/229.70.43
X-ZohoMailClient: External


--omr3pkjg6x5yc4vn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/5] iio: consumers: copy/release available info from
 producer to fix race
MIME-Version: 1.0

Hi,

On Tue, Oct 15, 2024 at 01:06:35PM +0200, Matteo Martelli wrote:
> Consumers need to call the producer's read_avail_release_resource()
> callback after reading producer's available info. To avoid a race
> condition with the producer unregistration, change inkern
> iio_channel_read_avail() so that it copies the available info from the
> producer and immediately calls its release callback with info_exists
> locked.
>=20
> Also, modify the users of iio_read_avail_channel_raw() and
> iio_read_avail_channel_attribute() to free the copied available buffers
> after calling these functions.
>=20
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
> diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/suppl=
y/ingenic-battery.c
> index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..3db000d9fff9a7a6819631314=
547b3d16db7f967 100644
> --- a/drivers/power/supply/ingenic-battery.c
> +++ b/drivers/power/supply/ingenic-battery.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/property.h>
> +#include <linux/slab.h>
> =20
>  struct ingenic_battery {
>  	struct device *dev;
> @@ -79,8 +80,10 @@ static int ingenic_battery_set_scale(struct ingenic_ba=
ttery *bat)
>  		dev_err(bat->dev, "Unable to read channel avail scale\n");
>  		return ret;
>  	}
> -	if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D IIO_VAL_FRACTIONAL_LOG2)
> -		return -EINVAL;
> +	if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D IIO_VAL_FRACTIONAL_LOG2)=
 {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> =20
>  	max_mV =3D bat->info->voltage_max_design_uv / 1000;
> =20
> @@ -99,7 +102,8 @@ static int ingenic_battery_set_scale(struct ingenic_ba=
ttery *bat)
> =20
>  	if (best_idx < 0) {
>  		dev_err(bat->dev, "Unable to find matching voltage scale\n");
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto out;
>  	}
> =20
>  	/* Only set scale if there is more than one (fractional) entry */
> @@ -109,10 +113,13 @@ static int ingenic_battery_set_scale(struct ingenic=
_battery *bat)
>  						  scale_raw[best_idx + 1],
>  						  IIO_CHAN_INFO_SCALE);
>  		if (ret)
> -			return ret;
> +			goto out;
>  	}
> =20
> -	return 0;
> +	ret =3D 0;
> +out:
> +	kfree(scale_raw);
> +	return ret;
>  }
> =20
>  static enum power_supply_property ingenic_battery_properties[] =3D {

It should be enough to declare scale_raw like this at the beginning
of the function and otherwise keep it as is when you include
<linux/cleanup.h>:

const int *scale_raw __free(kfree) =3D NULL;

Greetings,

-- Sebastian

--omr3pkjg6x5yc4vn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcQK0sACgkQ2O7X88g7
+pqmyg//aywh/aS9OiaC40xG03DJKnIbmtOS2ex1ddHCFNbiFgbDE/ASfF4VixQa
LSLQVi1QZysDaJ6a8+ri67OxQNagQjPeKersbuHUnXGSo4JZQl7ANVu/soO69xR/
PXngBjlP6goz0qUHgUOhMLhWxEJ+djUniI2+ZBbRAJVxVPPEPklHBya+eDwo4/W8
r+fLQhyO3few3Hk31BTSwyyjX8Qz2YPrU3XxsR5irRaCbcYS2vI9TFaXsAdmnNct
u5F8SjyesppgHLv/OLH6kUTLFhF5zfswv0FblOJEoJCvCCsge/kIAh+qDYMJe2rk
nmi9Ie/eMyOuiqLb2GseoXdN9p2zDavDm5yKgg5e5I89vPz/+3BkPp4saTATnkzJ
uiML1GgSAPxwCUzk/UqcQlfNK1vbIlI/0zYlK+HnedGrV21ysmsfL8OUWmXTU4Ji
1nDInw/Umf+bUzdXZCAZ4nNU0ewf5vC6ZlWX7t2XKQmbn9cF0BtWtdOawm4xBlcy
93yY+xw9LSsmYMOSnwuTNK2YUNHvNm9UaL8zgDhg2QrSXqP857vi4BaH1u7PonyB
lol4EBdsVwHzaG0ngpPKvLitgd+S8HlOOzN6aLgdEoEcDiY1WdhXpEtsa8Vu6Yo+
2Qd9oAyIE71i8UdnF+WjKPPpXJEyIVgZHLlGF5NeIXf/mFTHpDM=
=I+0p
-----END PGP SIGNATURE-----

--omr3pkjg6x5yc4vn--

