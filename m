Return-Path: <linux-iio+bounces-24504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E03BA6233
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A40616674B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C572264D6;
	Sat, 27 Sep 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0KaCgcP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBE46B5
	for <linux-iio@vger.kernel.org>; Sat, 27 Sep 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758995799; cv=none; b=KqBHJHZYe/qpcQ/VKtTZKTZ2ppAR/o3bvpamOt+aV8tEV6/X1jftHP2G9z0cjtUnMqwBNQ1BeflH5IJEu4Oud2IjvneXCmOG3e/DB9tL6xGvwmZI4+ZI4Oo1CUGCOKF7oz+YZNWOHwXUjrlUh/dQAnup3JVoHBJuvhUUHSC3PDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758995799; c=relaxed/simple;
	bh=DjN2yn+aPQ1nfA8je2ebU0LkbWlR85J6t+QrNIjvlAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7VuCfTX5fobYthTC3D/J9Ddy25LkfnnX84qjj7bzJ4bcwvkhpHy7Kxz2i4n50PbSKroHnpOH7mumFj1wHrQ22nyH9PAoz/JWmFGVxnwl3WJmW/1vj6s4vJ5qAcLogKhn4kQuHUeqs4+CR6viH5iXlLwcbcQzm9ySzVHpNrNENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0KaCgcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C309DC4CEE7;
	Sat, 27 Sep 2025 17:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758995798;
	bh=DjN2yn+aPQ1nfA8je2ebU0LkbWlR85J6t+QrNIjvlAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M0KaCgcP+5Ue+X9Zh7AJcqiZmPmph9sUe7zuCgl01pOq6iZsZNlrbd3wyMi6mKYiv
	 2tx8g9xJrCryI6i+ZPt16tv9WvIXqWDgKeFvfPxa8efMVI/j1KcA+75vdQi4ZNHMPh
	 5BHjrMN5GhS0ou3IAaXLmfpMo3vCJzDmRhUis3BaTatVeM390pr77WAG11OihtW/94
	 l0plqwB2yuh55AkXutNsw9qd8NURp9tiLxQPTSZMwFwAGA46XRRumjyIbe8YXkKya2
	 nh+OtPDXMkebaKiuWSPXzmT/TA76O6M1Y8y38S/fondrYVx0z107gViCnoIiHABtvt
	 QLGlGm0fOMaiA==
Date: Sat, 27 Sep 2025 18:56:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: ltc2688: use the auto lock API
Message-ID: <20250927185631.1051e315@jic23-huawei>
In-Reply-To: <20250923-dev-ltc2688-minor-v1-2-ef92c441dc42@analog.com>
References: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
	<20250923-dev-ltc2688-minor-v1-2-ef92c441dc42@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Sep 2025 09:41:48 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Make use of the cleanup API so that we can simplify some code paths.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/ltc2688.c | 24 ++++++++++--------------

This enables a few related simplifications that should be in this patch as =
well.

>  static int ltc2688_dac_code_read(struct ltc2688_state *st, u32 chan, u32=
 input,
> @@ -236,15 +234,15 @@ static int ltc2688_dac_code_read(struct ltc2688_sta=
te *st, u32 chan, u32 input,
>  	struct ltc2688_chan *c =3D &st->channels[chan];
>  	int ret;
> =20
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	ret =3D regmap_update_bits(st->regmap, LTC2688_CMD_A_B_SELECT, BIT(chan=
),
>  				 input << chan);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
> =20
>  	ret =3D regmap_read(st->regmap, LTC2688_CMD_CH_CODE(chan), code);
> -out_unlock:
> -	mutex_unlock(&st->lock);
> +	if (ret)
> +		return ret;
> =20
>  	if (!c->toggle_chan && input =3D=3D LTC2688_INPUT_B)
>  		*code =3D FIELD_GET(LTC2688_DITHER_RAW_MASK, *code);

There is a return ret later in this function that can be return 0;

> @@ -359,15 +357,13 @@ static ssize_t ltc2688_dither_toggle_set(struct iio=
_dev *indio_dev,
>  	if (ret)
>  		return ret;
> =20
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	ret =3D regmap_update_bits(st->regmap, LTC2688_CMD_TOGGLE_DITHER_EN,
>  				 BIT(chan->channel), en << chan->channel);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
> =20
>  	c->mode =3D en ? LTC2688_MODE_DITHER_TOGGLE : LTC2688_MODE_DEFAULT;
> -out_unlock:
> -	mutex_unlock(&st->lock);
> =20
>  	return ret ?: len;
return len; as can't get here with non zero ret.

>  }
>=20


