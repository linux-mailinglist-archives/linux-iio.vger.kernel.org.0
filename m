Return-Path: <linux-iio+bounces-15762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF6FA3BC1F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67575188AE5A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E371DE4D4;
	Wed, 19 Feb 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeNBhmNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880E1C4A20
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962464; cv=none; b=ZbNzAgOGUFnn4h9fIRJJrNXFrxlR8mnZnPz2EoCjw6eu6HajJoLxSJBj/GseP/6K1cDoWa2AXhdoVmF5s5xKFM/vuEjHVETOggfyKctYUMKpYh9m4TOifpzRVxRLTuJjcRojMaq/v/Sc5VOk092rzcEkHl2FEvDRngsXpkgFoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962464; c=relaxed/simple;
	bh=mZ8SenvGvxvg76KS1ERdrWzPW5GlhVCkaKJoSG1tmx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3RFBQX0nDbCdxoRe3AmIl+Zt6JPXj3aAdMFD9ZE0b8+oOM8vD6meiXOME+JvhLhYm4M0bz6jUah7G1eey+2LODKyogA8btM82m2TZSiLClLAwtNweAiyYPlE344j2H5taBg1sA0JFD/mNnarrInI7xp0SaD1yMN0818ORhWGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeNBhmNo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso49378625e9.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962461; x=1740567261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CmUvqIuOo7zTzlI1ILswi8leYxf5pSBlOAviDz2Yo4=;
        b=EeNBhmNokMIYgJbaHlxWmErlld6uowxO9x6R/pFYDzSlxGUluOG5/zzc3dZ/lKt39Z
         GGvGOO4PacUchQQX6+2/raxR2Sioc5tMQsW/ZfHBXfsFXGgqgSjCKcYglynQrZp1x9RS
         fsrGyMIRzjQyaIJKg6J4JNDoY2c1/udf6ngRIxyaXG8DC04CKwTMEuuMGw43Z4RHHkHZ
         LbHgLjje90b5oHm6aQeo1hk0A/s5qQACCf2yPTvLZ4bAkSPtgWEPmSsAFxeRSOTQv1El
         rw79BDka1qSQVDmkcOnaPo4NzaTV785lHBvN4Wze1jhzFWSIBjhEsnZ1gaeTAnemWstX
         gupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962461; x=1740567261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CmUvqIuOo7zTzlI1ILswi8leYxf5pSBlOAviDz2Yo4=;
        b=jejUzZdEh1Uc2Pirdo6SbzpT9FiSzTbh/wi+U9IHoU2P+c/k5XiqcpaQ1wYOekM512
         Xa/wlwjQvvyuv31ZrqHiWqorKuyKG0yhUDA+u8feSleyQSge6KMviN6Hj91wZ/ZIhKCI
         3beN386LTGZtsnEJFjYdALe+5u2iawoxqgJhKSWGIuwePbX/WaYDhAni6rzGcm1ByxyB
         mDl2vYeB69Ia6Ho7ZpDdsLlpN0JQlKgYoVhHXXi4n8pf49ZhV7x4kc6H0LZJPbhuhune
         Nfu35upxbDTlWsOYNsHdUMTaW7IQtOQxOzIvF20D7Tvwwm1c22hzKaIJ+1I3Kt+3A+0p
         e1hg==
X-Forwarded-Encrypted: i=1; AJvYcCX5aJGapExNwsWz0eDEA9kbyerVCKkFbogzNizOFuHsnAPFn9fwIuP+1QRrwJs+5J9Xkk33Yg5Ibco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35wT80n9LTiAH4YEPIgzu6cGwebnXUn2Zq5vkCizLqyTlrp5Q
	HVCBMdHvDyJ39uwgYJABSFuHGm4Is0PNxH0gdHpnbHUA6XsGBy2z
X-Gm-Gg: ASbGnctidTYTES8YBuFXx6JNRP4uT+INMD2W1YKql980QrIau7BWIOVU+mCXxkHsLcf
	Ro37kAZMDkFJWa4EIjSbXPEXPZViP9Id/bymKmMsVDLSZ/OSwapx7RiRTrpogSBBrg84N2/meWh
	E9p/93y6OUTbGBFj4KFK8XxJr+o1fwo1AxdDg+1Y8NvvQdkQOn3OCO0FqNJHHFjeojkifxxqNVE
	Jt0TS9I5wnop4ihqKKwkDUyeA6V/VdABiGsIwWhidnwP6+bDtSDPG16SaI2f1W49Enl5Q3jXlLM
	tQulBJLhZnLqMJsWCdjkqhZd43xa4pXDRJNzHkxybbt4tum7v8rtupKzexNDL5M=
X-Google-Smtp-Source: AGHT+IGLoYAEZiwKx/iDIx8H69IxPsEfzRmFDVKqBp3ejXS10wzj2gMv2UWtj9gpNQ5XXnunSaps5A==
X-Received: by 2002:a05:600c:5124:b0:439:5da7:8e0 with SMTP id 5b1f17b1804b1-43999da82bbmr32623935e9.16.1739962460731;
        Wed, 19 Feb 2025 02:54:20 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f23asm207464735e9.7.2025.02.19.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:54:20 -0800 (PST)
Message-ID: <95065698b7526d5cc7428d561576f31ce48b97bd.camel@gmail.com>
Subject: Re: [PATCH 10/29] iio: adc: ad7192: Factor out core of
 ad7192_write_raw() to simplify error handling.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 10:54:24 +0000
In-Reply-To: <20250217141630.897334-11-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-11-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Factor out everything under the lock, use guard() for the mutex to
> avoid need to manually unlock, and switch sense of matching checks
> in loops to reduce indent.
>=20
> There are some functional changes in here as well as the code
> no longer updates the filter_freq_available if no change has
> been made to the oversampling ratio.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7192.c | 111 ++++++++++++++++++++----------------=
---
> =C2=A01 file changed, 57 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index e96a5ae92375..785429900da8 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -7,6 +7,7 @@
> =C2=A0
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/clk-provider.h>
> =C2=A0#include <linux/device.h>
> @@ -945,80 +946,82 @@ static int ad7192_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> -static int ad7192_write_raw(struct iio_dev *indio_dev,
> -			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> -			=C2=A0=C2=A0=C2=A0 int val,
> -			=C2=A0=C2=A0=C2=A0 int val2,
> -			=C2=A0=C2=A0=C2=A0 long mask)
> +static int __ad7192_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val2,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> =C2=A0{
> =C2=A0	struct ad7192_state *st =3D iio_priv(indio_dev);
> -	int ret, i, div;
> +	int i, div;
> =C2=A0	unsigned int tmp;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> -		ret =3D -EINVAL;
> -		for (i =3D 0; i < ARRAY_SIZE(st->scale_avail); i++)
> -			if (val2 =3D=3D st->scale_avail[i][1]) {
> -				ret =3D 0;
> -				tmp =3D st->conf;
> -				st->conf &=3D ~AD7192_CONF_GAIN_MASK;
> -				st->conf |=3D FIELD_PREP(AD7192_CONF_GAIN_MASK,
> i);
> -				if (tmp =3D=3D st->conf)
> -					break;
> -				ad_sd_write_reg(&st->sd, AD7192_REG_CONF,
> -						3, st->conf);
> -				ad7192_calibrate_all(st);
> -				break;
> -			}
> -		break;
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (!val) {
> -			ret =3D -EINVAL;
> -			break;
> +		for (i =3D 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> +			if (val2 !=3D st->scale_avail[i][1])
> +				continue;
> +
> +			tmp =3D st->conf;
> +			st->conf &=3D ~AD7192_CONF_GAIN_MASK;
> +			st->conf |=3D FIELD_PREP(AD7192_CONF_GAIN_MASK, i);
> +			if (tmp =3D=3D st->conf)
> +				return 0;
> +			ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st-
> >conf);
> +			ad7192_calibrate_all(st);
> +			return 0;
> =C2=A0		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!val)
> +			return -EINVAL;
> =C2=A0
> =C2=A0		div =3D st->fclk / (val * ad7192_get_f_order(st) * 1024);
> -		if (div < 1 || div > 1023) {
> -			ret =3D -EINVAL;
> -			break;
> -		}
> +		if (div < 1 || div > 1023)
> +			return -EINVAL;
> =C2=A0
> =C2=A0		st->mode &=3D ~AD7192_MODE_RATE_MASK;
> =C2=A0		st->mode |=3D FIELD_PREP(AD7192_MODE_RATE_MASK, div);
> =C2=A0		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> =C2=A0		ad7192_update_filter_freq_avail(st);
> -		break;
> +		return 0;
> =C2=A0	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		ret =3D ad7192_set_3db_filter_freq(st, val, val2 / 1000);
> -		break;
> +		return ad7192_set_3db_filter_freq(st, val, val2 / 1000);
> =C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		ret =3D -EINVAL;
> -		for (i =3D 0; i < ARRAY_SIZE(st->oversampling_ratio_avail);
> i++)
> -			if (val =3D=3D st->oversampling_ratio_avail[i]) {
> -				ret =3D 0;
> -				tmp =3D st->mode;
> -				st->mode &=3D ~AD7192_MODE_AVG_MASK;
> -				st->mode |=3D FIELD_PREP(AD7192_MODE_AVG_MASK,
> i);
> -				if (tmp =3D=3D st->mode)
> -					break;
> -				ad_sd_write_reg(&st->sd, AD7192_REG_MODE,
> -						3, st->mode);
> -				break;
> -			}
> -		ad7192_update_filter_freq_avail(st);
> -		break;
> +		for (i =3D 0; i < ARRAY_SIZE(st->oversampling_ratio_avail);
> i++) {
> +			if (val !=3D st->oversampling_ratio_avail[i])
> +				continue;
> +
> +			tmp =3D st->mode;
> +			st->mode &=3D ~AD7192_MODE_AVG_MASK;
> +			st->mode |=3D FIELD_PREP(AD7192_MODE_AVG_MASK, i);
> +			if (tmp =3D=3D st->mode)
> +				return 0;
> +			ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st-
> >mode);
> +			ad7192_update_filter_freq_avail(st);
> +			return 0;
> +		}
> +		return -EINVAL;
> =C2=A0	default:
> -		ret =3D -EINVAL;
> +		return -EINVAL;
> =C2=A0	}
> +}
> +
> +static int ad7192_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val,
> +			=C2=A0=C2=A0=C2=A0 int val2,
> +			=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> =C2=A0
> -	mutex_unlock(&st->lock);
> +	ret =3D __ad7192_write_raw(indio_dev, chan, val, val2, mask);
> =C2=A0
> =C2=A0	iio_device_release_direct_mode(indio_dev);
> =C2=A0


