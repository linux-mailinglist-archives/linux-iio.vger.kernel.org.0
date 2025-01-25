Return-Path: <linux-iio+bounces-14580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96210A1C3D4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC285165883
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DFE225D6;
	Sat, 25 Jan 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npZEv+Z8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D435951
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816516; cv=none; b=aMVRt0pVnMGsXxwXsHJGRxLpSOxPFGx6tY0oFjPWNVA31rIszEndlhy3bUzWwpg+3pplnuHF9t+YQzrNm0wxZ505TmlTxdfztVUeG4bvx4ZKJ3w0PrNxt4IyczhPucZpmakILRidkn81miQGWU6HT0AZ8uAWPdBTTc3w+GDsZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816516; c=relaxed/simple;
	bh=1Mbbu/JB0Pc3URGp4GdD/vTA+3z0XRsPc6oUZWPWc98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ak1tcxPWycPzPTJ+JOsMblKAPtUv8yGWDOXD7/kbni0Qs/Ug4fFtw7vcyC/YGcROUWu7D8HMEJPUqSHoK6RxdKcTXa6A+MKPZpUtb2sorqb+sz439TAAxA4IaN2/BaOUIn+lNfh/3acVS/7IQpRw+JAUtDIkU2xw6iDLKdYqPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npZEv+Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F46C4CED6;
	Sat, 25 Jan 2025 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737816515;
	bh=1Mbbu/JB0Pc3URGp4GdD/vTA+3z0XRsPc6oUZWPWc98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=npZEv+Z8QiWxAv5+2nvvew0ND+S4b7tVrr7LeJSvRWIyDYa22cHDSlc4xBJZf4mk8
	 J5+DS4EMslghkFvtqYMRGBPW7fNJ8znYT6dYGevTxvSuAXJ+tcUuIeNzVMpeN2UXWQ
	 Ctmleq5SGMnQVLvsVXY0a/ZAuI5KxoFT1mI2BwP/pXYLznkpuvVUYze3N3hjpvmBak
	 TBrO5FyY7ge6pykomCC1pPHDe3x1tpPlysHLqqSLn+KqMyaxrdQEGdmFyJcBRw3wIc
	 687LkZCRajyJ2YgfGQ/ENe9kopeJKw/smTTzDAs/HadPVdh3nfUhzf0bMJHd9DIBJe
	 wrlHSb69QMeQg==
Date: Sat, 25 Jan 2025 14:48:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: Fix comparison of channel configs
Message-ID: <20250125144828.1518a7f3@jic23-huawei>
In-Reply-To: <20250124160124.435520-2-u.kleine-koenig@baylibre.com>
References: <20250124160124.435520-2-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 17:01:23 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Checking the binary representation of two structs (of the same type)
> for equality doesn't have the same semantic as comparing all members for
> equality. The former might find a difference where the latter doesn't in
> the presence of padding or when ambiguous types like float or bool are
> involved. (Floats typically have different representations for single
> values, like -0.0 vs +0.0, or 0.5 * 2=C2=B2 vs 0.25 * 2=C2=B3. The type b=
ool has
> at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
> true, but memcmp finds a difference.)
>=20
> When searching for a channel that already has the configuration we need,
> the comparison by member is the one that is needed.
>=20
> Convert the comparison accordingly to compare the members one after
> another. Also add a BUILD_BUG guard to (somewhat) ensure that when
> struct ad7124_channel_config::config_props is expanded, the comparison
> is adapted, too.
>=20
> Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Hi Uwe,

Fully agree the change makes sense.  Though the floating point example
is unlikely to bite us in kernel!=20

Did you see an actual failure to match?  If not I'd be tempted
to take this for next cycle rather than as a fix to rush in.
I'd be surprised if current code doesn't happen to work.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 6ae27cdd3250..5eb8ced416ba 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -338,15 +338,38 @@ static struct ad7124_channel_config *ad7124_find_si=
milar_live_cfg(struct ad7124_
>  								  struct ad7124_channel_config *cfg)
>  {
>  	struct ad7124_channel_config *cfg_aux;
> -	ptrdiff_t cmp_size;
>  	int i;
> =20
> -	cmp_size =3D sizeof_field(struct ad7124_channel_config, config_props);
> +	/*
> +	 * This is just to make sure that the comparison is adapted after
> +	 * struct ad7124_channel_config was changed.
> +	 */
> +	BUILD_BUG_ON(sizeof_field(struct ad7124_channel_config, config_props) !=
=3D
> +		     sizeof(struct {
> +			    enum ad7124_ref_sel refsel;
> +			    bool bipolar;
> +			    bool buf_positive;
> +			    bool buf_negative;
> +			    unsigned int vref_mv;
> +			    unsigned int pga_bits;
> +			    unsigned int odr;
> +			    unsigned int odr_sel_bits;
> +			    unsigned int filter_type;
> +		     }));
> +
>  	for (i =3D 0; i < st->num_channels; i++) {
>  		cfg_aux =3D &st->channels[i].cfg;
> =20
>  		if (cfg_aux->live &&
> -		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
> +		    cfg->refsel =3D=3D cfg_aux->refsel &&
> +		    cfg->bipolar =3D=3D cfg_aux->bipolar &&
> +		    cfg->buf_positive =3D=3D cfg_aux->buf_positive &&
> +		    cfg->buf_negative =3D=3D cfg_aux->buf_negative &&
> +		    cfg->vref_mv =3D=3D cfg_aux->vref_mv &&
> +		    cfg->pga_bits =3D=3D cfg_aux->pga_bits &&
> +		    cfg->odr =3D=3D cfg_aux->odr &&
> +		    cfg->odr_sel_bits =3D=3D cfg_aux->odr_sel_bits &&
> +		    cfg->filter_type =3D=3D cfg_aux->filter_type)
>  			return cfg_aux;
>  	}
> =20
>=20
> base-commit: 5ffa57f6eecefababb8cbe327222ef171943b183


