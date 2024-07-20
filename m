Return-Path: <linux-iio+bounces-7736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B21938174
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0422B281CB0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ABD12C559;
	Sat, 20 Jul 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkzyogSS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2028EB
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482176; cv=none; b=BjiPPfo3iEbp6h0NpVQDhw0S+aUVGP67zVRrTcJesz0et6ItxTvQDMOKdZsthXdPhPc+fH3ZYi1qNSQdkY2cyyABdmiLpyoD9np+vU1vbb2d9XsIhO7cJJvX4EsCRjq7BEHrVN1jFGp6KAXd2+E5SfRxUsa854t5w0+OIWm++kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482176; c=relaxed/simple;
	bh=KNIudMoJwEU0ayOMpgXCNxHxiHntQbIFwJoXm39tGNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdqwMMr43AETa3PdoGsCOCyliMSk022jFSLzuae25Dkh37+TTazXDf24y1+jCXCAuCkj53PUT+7WTiBrwnmcjDpUStoLJsjq0wRO8EsAuEetmdQ7z2NhF1I8lu9/hEBmpaPkaXZH79dqLGcezdtahiMl4bP4L7DBEAU/ohN3a7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkzyogSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8FEC2BD10;
	Sat, 20 Jul 2024 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721482175;
	bh=KNIudMoJwEU0ayOMpgXCNxHxiHntQbIFwJoXm39tGNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tkzyogSSqRj8+iNFRnDYuaHPVoSsvYSeY+6Oji2scah8maMp9ppgp8Dq+9bETLYCw
	 F16W2QfQ1YJ9RDGbNRmqsg0GloqzV07OEDGNwHWZpLVi+WLCDGEt7pH1f6ZvVBXDNx
	 kIWMw+Qo13xV5Ea85eclPpJX9G3vqF9872BlYdmMWSMUJdbbeT/pPK+7dNPieAoKTN
	 Dk/wVtvq3WO4GK32O564/7+r8Tjzv7dUwiQR13e1/atV/Ts40J0Steb8YBEseMZfYd
	 x1UxYqhBEui4M1q7eQYMyvVrPjBdw0shxu2CvgTZIg3MqsT2EV6G00RKBtV9OenmJP
	 +fgHI9Q/CwwCw==
Date: Sat, 20 Jul 2024 14:29:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] iio: light: noa1305: Simplify noa1305_read_raw()
Message-ID: <20240720142928.7a913229@jic23-huawei>
In-Reply-To: <20240715183120.143417-1-marex@denx.de>
References: <20240715183120.143417-1-marex@denx.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jul 2024 20:28:55 +0200
Marek Vasut <marex@denx.de> wrote:

> The only channel this hardware supports is IIO_LIGHT, if the channel
> is anything else, exit right away. The 'ret' variable is now always
> only assigned by noa1305_measure(), do not initialize it anymore.
> Update function parameter indent. No functional change.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
Hi Marek,

One minor thing - please use a cover letter.
Provides an obvious place for me to reply when picking things up and
gives the whole series a meaningful title in patchwork.

Anyhow, looks straight forward to me so I'll apply it to my current testing
tree. Not that will get rebased on rc1 once available.
If anyone has additional feedback in the meantime I'm happy to rebase
until this gets pushed out as togreg so can add tags or make other changes.

Thanks,

Jonathan

> ---
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/light/noa1305.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> index 596cc48c4c341..a76f158bb50e5 100644
> --- a/drivers/iio/light/noa1305.c
> +++ b/drivers/iio/light/noa1305.c
> @@ -125,38 +125,27 @@ static const struct iio_chan_spec noa1305_channels[=
] =3D {
>  };
> =20
>  static int noa1305_read_raw(struct iio_dev *indio_dev,
> -				struct iio_chan_spec const *chan,
> -				int *val, int *val2, long mask)
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
>  {
> -	int ret =3D -EINVAL;
>  	struct noa1305_priv *priv =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type !=3D IIO_LIGHT)
> +		return -EINVAL;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		switch (chan->type) {
> -		case IIO_LIGHT:
> -			ret =3D noa1305_measure(priv);
> -			if (ret < 0)
> -				return ret;
> -			*val =3D ret;
> -			return IIO_VAL_INT;
> -		default:
> -			break;
> -		}
> -		break;
> +		ret =3D noa1305_measure(priv);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D ret;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_LIGHT:
> -			return noa1305_scale(priv, val, val2);
> -		default:
> -			break;
> -		}
> -		break;
> +		return noa1305_scale(priv, val, val2);
>  	default:
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
> =20
>  static const struct iio_info noa1305_info =3D {


