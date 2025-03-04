Return-Path: <linux-iio+bounces-16316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E1A4D548
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 08:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A2D7A3D2D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC621F7914;
	Tue,  4 Mar 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmsQrcb7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581541F63F5;
	Tue,  4 Mar 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074460; cv=none; b=rlsm0M/1rcFHd7nHP441b+o/G5wlpdXmAyABUdq04Bec6Te6YTT0ri6fnb3h8iGEG68VwevM6grZ8mI4EESzTqI5TgQ8UlR5awAlUiYs1YlkUVZhOlV1nsVve1JuruUyPIJ/4oyvg5PUm8lS3twALqsMxl1XLVcVMB5wGrjBXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074460; c=relaxed/simple;
	bh=AFZWbQeLdmlscWJGirRlHWpxaH/09ugu2ZcjrkguJhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBZQh3LQyWupunD1J+EViWSR7Xh9rqU8ahWT/kOsY3aSnOw/APUUGYmgeRMzXL06GjDyulSbIpHc+Qe77f3yfPBCxWXMFapIakJDUu7WRVWkqS8kmGWMjd3BmwueW+0BDH5GW+yQOf5EBdFlgg59p6VPX8XlcULpJ3jip0tr210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmsQrcb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499D4C4CEE8;
	Tue,  4 Mar 2025 07:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741074460;
	bh=AFZWbQeLdmlscWJGirRlHWpxaH/09ugu2ZcjrkguJhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmsQrcb7ldMif9AB4P8WWXFrZuHD/4pz0dW/6kBzZ2di7u33yb5XNq8m+Edxpjbue
	 t1cgcLKAZmjKQpGIjMJBBPNQ8eXfpCoY5dvYXuEARGZ6jOQQxtFmdnMGMpwNDZHxzM
	 w/9DD8QsNsqFtubcoj1pdMRVJg0p7FGrOd0WFI8MuxdVj2pBpoPNBDQJ6H6Cb1Ejke
	 RkMED8G1vDf+UuWDXEkgJqRDONQ1OXXKE4GzvChTKYhYV/8HfudKhgkleMW3FX9vD+
	 VRrDoFv+awSTVONgpGrfK1b9m+9pREyedrzkFBr2/6ZDpwbJBLONHfOAxO7UMzq0kv
	 RFoQYwj6wwyTQ==
Date: Tue, 4 Mar 2025 16:47:36 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v6 3/3] counter: microchip-tcb-capture: Add capture
 extensions for registers RA/RB
Message-ID: <Z8awGBW8obpG1QPN@ishi>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmbU7YrIDFXv6vYx"
Content-Disposition: inline
In-Reply-To: <20250227144023.64530-4-csokas.bence@prolan.hu>


--fmbU7YrIDFXv6vYx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 03:40:20PM +0100, Bence Cs=F3k=E1s wrote:
> +static int mchp_tc_count_cap_read(struct counter_device *counter,
> +				  struct counter_count *count, size_t idx, u64 *val)
> +{
> +	struct mchp_tc_data *const priv =3D counter_priv(counter);
> +	u32 cnt;
> +	int ret;
> +
> +	switch (idx) {
> +	case COUNTER_MCHP_EXCAP_RA:
> +		ret =3D regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RA), =
&cnt);
> +		break;
> +	case COUNTER_MCHP_EXCAP_RB:
> +		ret =3D regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RB), =
&cnt);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!ret)
> +		*val =3D cnt;
> +
> +	return ret;
> +}

It's cleaner to exit early on an error than to carry it to the end.
Instead of if (!ret), perform an if (ret) return ret to exit early on an
error, then simply return 0 at the end of the funtion.

> diff --git a/include/uapi/linux/counter/microchip-tcb-capture.h b/include=
/uapi/linux/counter/microchip-tcb-capture.h
> index ee72f1463594..5c015fafe42c 100644
> --- a/include/uapi/linux/counter/microchip-tcb-capture.h
> +++ b/include/uapi/linux/counter/microchip-tcb-capture.h
> @@ -12,6 +12,9 @@
>   * Count 0
>   * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
>   * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
> + * \__  Extension capture0    (RA register)
> + * \__  Extension capture1    (RB register)
> + * \__  Extension capture2    (RC register)

The capture2 extension doesn't exist in this patch so remove this
comment line.

> @@ -30,6 +33,12 @@ enum counter_mchp_signals {
>  	COUNTER_MCHP_SIG_TIOB,
>  };
> =20
> +enum counter_mchp_capture_extensions {
> +	COUNTER_MCHP_EXCAP_RA,
> +	COUNTER_MCHP_EXCAP_RB,
> +	COUNTER_MCHP_EXCAP_RC,
> +};

Remove COUNTER_MCHP_EXCAP_RC for the same reason as above.

Also, I would argue for these to be preprocessor defines rather than
enum for the same reasons as in my other review[^1].

One final comment: is RA/RB the best way to differentiate these? One of
the benefits of abstraction layers is that users won't need to be
concerned about the hardware details, and naming the capture values
after their respective general register hardware names feels somewhat
antithetic to that end.

I imagine there are better ways to refer to these that would communicate
their relationship better, such as "primary capture" and "secondary
capture". However at that point capture0 and capture1 would seem
obvious enough, in which case you might not even need to expose these to
userspace at all.

William Breathitt Gray

[^1] https://lore.kernel.org/all/Z8alaOTjZeRuXnUI@ishi/

--fmbU7YrIDFXv6vYx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8awGAAKCRC1SFbKvhIj
K+peAP0dCAA2g9OAlpFDPmbqoOmnwi+yDLF2hYMVY72oMo8RqAEAt6QoAGB5MLHi
Wb5E+EiJBEq2j9Hh1/bUvs7Xzsm4dws=
=jTwQ
-----END PGP SIGNATURE-----

--fmbU7YrIDFXv6vYx--

