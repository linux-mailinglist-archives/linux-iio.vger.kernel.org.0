Return-Path: <linux-iio+bounces-18704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0356A9DBD7
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE149466999
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C101F4720;
	Sat, 26 Apr 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImiiHGC9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2B374EA
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681463; cv=none; b=ssChJbADGzl+8Rl0SyAflIDm3DjMSFTgmbxGs0FyxH8OfXsrEmwDOKpvXkvsNGzWWSOqdOYkYMINzIIJkWEeOm9NS0wIDmiBEuPFj5xffSpu2M44IHzLJMrwnUGU4YjG1VJDkS6VOuJpIjXdgSHlK0SAAtRgxDbfiC5TLaeQQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681463; c=relaxed/simple;
	bh=L28JNgmnTk3FQ2iIonumj1+rvkgfhfYGOHmF0n1cp4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkxNNyROVTJ2xahcywYZBBnQvw2tsm2705eSeutpcY9DK9UFeDyhekYBEL9th3OB++gZgm8UCViBhpncmT7GFl040kQlS5/GmJxU+rpfR7RmTjcrsIv5v/vRNWBaFLxGz5ClbbwGCCOuQ6w0sQ7h2fT5LL4D0+W+zdKvihlo+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImiiHGC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA98C4CEE2;
	Sat, 26 Apr 2025 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745681462;
	bh=L28JNgmnTk3FQ2iIonumj1+rvkgfhfYGOHmF0n1cp4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ImiiHGC9JyOF02VYuExqOUZo44TDFs2dkeS8pe2bCixSuCeYTKKq7PTHgR0oqdcAC
	 LjFV86uUTZXUXAudkInivblmsUTF1tyZ36a7d25/fthHI/y5Ps6XiGR65hiMAp1LA4
	 BzuMx+fCYmaQGgz0VEZZQBuC9PA3nLaQNACgWSMkXMbZi6/xGvKdft0MhQgxmHiyUZ
	 PBngQJfmYPQm6NUCB9jvPqpwNMREowNHBF6o322bh1b/z6oPXbxALfUE0pp/4SaQFJ
	 lqkh0bhIMf259WRiECGmODIDWYk4Web0ILxKv+MUoiencrF9//4i6Nvqps4QKNeiqA
	 EyJEiEjjlTnMA==
Date: Sat, 26 Apr 2025 16:30:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur-Prince <r2.arthur.prince@gmail.com>
Cc: linux-iio@vger.kernel.org, arthur.prince@ime.usp.br, Mariana
 =?UTF-8?B?VmFsw6lyaW8=?= <mariana.valerio2@hotmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1298: Add safe usage guarantee for
 device communication
Message-ID: <20250426163056.5e174f86@jic23-huawei>
In-Reply-To: <20250423185208.752080-2-r2.arthur.prince@gmail.com>
References: <20250423185208.752080-1-r2.arthur.prince@gmail.com>
	<20250423185208.752080-2-r2.arthur.prince@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2025 15:46:25 -0300
Arthur-Prince <r2.arthur.prince@gmail.com> wrote:

> Add safe usage guarantee for device communication in=20
> ads1298_reg_access/ ads1298_write_raw (ti-ads1298) that=20
> prevent simultaneous read/write operations.
>=20
> Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
> Co-developed-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
> Signed-off-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
Two different things seem to be going on in here...

> ---
>  drivers/iio/adc/ti-ads1298.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 03f762415fa5..438bcc3c74da 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -355,9 +355,19 @@ static int ads1298_write_raw(struct iio_dev *indio_d=
ev,
>  {
>  	struct ads1298_private *priv =3D iio_priv(indio_dev);
> =20
> +	int ret;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return ads1298_set_samp_freq(priv, val);
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ads1298_set_samp_freq(priv, val);
> +
> +		iio_device_release_direct_mode(indio_dev);
This prevents changing the sampling frequency.  Some drivers prevent this
whilst in buffered mode, but why is that necessary here?

> +
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -417,10 +427,17 @@ static int ads1298_reg_access(struct iio_dev *indio=
_dev, unsigned int reg,
>  {
>  	struct ads1298_private *priv =3D iio_priv(indio_dev);
> =20
> +	int ret;
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
For this one it's a debug interface. If the issue is people shooting themse=
lves in the
foot then we don't normally prevent that for these.

If there is something fundamental about regmap implementation
that makes these accesses have side effects unconnected to what is being
written then that needs calling out.

> +	if (ret)
> +		return ret;
>  	if (readval)
> -		return regmap_read(priv->regmap, reg, readval);
> -
> -	return regmap_write(priv->regmap, reg, writeval);
> +		ret =3D regmap_read(priv->regmap, reg, readval);
> +	else
> +		ret =3D regmap_write(priv->regmap, reg, writeval);
> +=09
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
>  }
> =20
>  static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)


