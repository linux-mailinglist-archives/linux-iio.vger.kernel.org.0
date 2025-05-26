Return-Path: <linux-iio+bounces-19939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F02BFAC3DD5
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C71F189429A
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348631F4C96;
	Mon, 26 May 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2n7yzCQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40614C2C9;
	Mon, 26 May 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255223; cv=none; b=m8EsNEG2ttzNb9uJ8J6e5rb47KSwRcCAMz/PVt59XJb7dnApubjQxz2199QSSfbk3pc/Fh2ocj8po24z1jtvH1aF2cnxpVQwCug2b056f4qj7/AEet0fRkSzMTkmCZITibxcvgYRSFU1OU2g5kQyDsH+lm2X7yOVl5s6fGve534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255223; c=relaxed/simple;
	bh=dPuYs8ZY39+Pul95GDrqOBDvqKhfpBvFI4NCSRl5KXA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnt+Q0FQWLaGh9+SqRJCpZEcN2hpEYChWdIF50SZuvrL3YXRkgGU7QqjygL3+tUNdmvWFYBgNtClx8IZI0DeWGh1YGz0CiP83RJYokzU05LtCHNr7WGV5bqWtKCqGJ8321Bv6Q0QVogq8uAZzkKvi8DLAFCHd56sn0p+hAxFSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2n7yzCQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d51dso3159406a12.2;
        Mon, 26 May 2025 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255219; x=1748860019; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tHE0ZJ0TqdsK0fp/lr3eubGhx74JGPnQNFF7VOPckjI=;
        b=l2n7yzCQzJwE1ja7lD1Dq1izITcDoQC4CSeq6/EHPzwmkN0V/BLRn3QkthjiMPMxrw
         9y/KUqrwt6vjjeUFE5kjg1UhVNNhrGjuFgsoU3mIGqGfPXyRuPKDd95fKi2wHN+BfbeU
         LNYLRccry2JsQ/eitpfdJUoX554rcIXWlyib+HGPMR0+BDTjH25IMt9LxvoG4KFurEy2
         Zcc1nnF1eQUrS/i874d7oEuRL4urn8+QUEdFBiZ+CV3r0BZ0o3ri4Ca0kF3KsPffux2W
         tI67nmvxJxx3NSGtzhIpzSqiIffigAc2t597/7sfgmUDViqnbYT3Vj8L7dMbYQkRjnWb
         xbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255219; x=1748860019;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHE0ZJ0TqdsK0fp/lr3eubGhx74JGPnQNFF7VOPckjI=;
        b=WOfjDe8HxsiIXTJBPRcKxTzqYBAIErnZM/qVAUkjfFSV6rsJgXQUX6Pq/DfqYHARPg
         whn1zH19rfnL1rQuSv6x0aOOrb0cwk0nfReQVBK3J9kw/r7B+CeplglIzLIWIAScLSGF
         LeIgnxJfJsGVXAUt3fxRU/4PM3DEJ0fiSy/5FOiCE4xu51FUTiIitC4HDOQaH1/Rc5mV
         x6tFWW9uBWd5IslDXzrgdkhJSSWFK4KiYjv+cSwKKivevsnh7cAciDs5j0g4KQ2YevJf
         kwuj+AXu+k98uZXJ5A4nAiOaELe7m8qADI2xe4qYTUUy1CCTY2eJRUo/BTpbsCI02KpS
         ErSw==
X-Forwarded-Encrypted: i=1; AJvYcCV3rLJl1+0BhTsO40OSzFc/LoiwOAbJB+4lkc85b+CyCy3qyZHtt2G9tWNjVSeVtbSk27jAYZahX9JR@vger.kernel.org, AJvYcCWPBzsBclEHClw+lj/q4wQe8n2gbnoP78NDlD5HT+JbX9xLhs6F4L6eDRpfLHpzEcC/3AK9dJNu5Sw4nQ==@vger.kernel.org, AJvYcCWRvV9xQ9tCHmClbW28z7tBWVWnVoBBPZYdPaPsHrvLAyPYd/IysXVOno8+xiZGV85/y2FspdjGnYfeftoD@vger.kernel.org, AJvYcCWc/8V5zhK92MoSniIPBF6LjVyop9UDNpOz9dbUAj6Q9Nm/hKjpf78CFxMas9E+fMxh2jzrS/HqUKrS@vger.kernel.org
X-Gm-Message-State: AOJu0YwzakUSqOa/i998+z4KTWgkvRgwJO6FxX9ruCJR0aZlL9dHtnah
	LyUWONNWG61nqHT8DLNrSv4hdk6/3ns9Rz+gfiNi2OhocBOnxpLwX3dW
X-Gm-Gg: ASbGncsAPJ+Odr73FY4CIyNPKTSSfVW1wvnDFmX2e6R9oFPiJk9E+4ha+wrptR5DqGL
	At8JFjUelr3VviQlKksYrtLzDuq1Phh8XrjWIhFHLz55NdN8iMZn0zHaJxSERGuY2y1HCoCYHss
	Gyn4DESrpvBeoq8YbeOr9x7I2EKdwF0I3qdmSyoFRfT6m22Rz9aNgpIvfk06C0s27sKTFX0NJqv
	m4vmJe8baEN+vmvfyaRfO8X8DTHIdto2+br8VbS51TbfLGdLD55PsJJ3nb0YyxE/yS6ZwO0xokI
	MyF14ZnkfHzoVCwbzAF8rwrk7erlvEi/thNi1ghcYzbTfOZuuzxghejG
X-Google-Smtp-Source: AGHT+IH7cr16I1HNzlBRugMrtVWhxbTsl2cH5hAPpyL+USeIX4OTS7khiNdg6zTIN2LNgUpEbMagFA==
X-Received: by 2002:a17:907:da7:b0:acb:88ac:e30f with SMTP id a640c23a62f3a-ad85b18309bmr789057066b.20.1748255219310;
        Mon, 26 May 2025 03:26:59 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d27192dsm1655720766b.71.2025.05.26.03.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:26:58 -0700 (PDT)
Message-ID: <b198ab8bcae5e9a31164bb565a089d14ff297b81.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] iio: adc: ad4170: Add support for calibration
 bias
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, 	marcelo.schmitt1@gmail.com
Date: Mon, 26 May 2025 11:27:02 +0100
In-Reply-To: <6213d7b7fb913520f1f143e7ccf8fe16b8579d0c.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	 <6213d7b7fb913520f1f143e7ccf8fe16b8579d0c.1747083143.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 09:34 -0300, Marcelo Schmitt wrote:
> Add support for ADC calibration bias/offset configuration.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
> - New patch spun out of the base driver patch.
>=20
> =C2=A0drivers/iio/adc/ad4170.c | 26 ++++++++++++++++++++++++++
> =C2=A01 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 1df214f7fdec..b02fdd25b4c8 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -643,6 +643,7 @@ static const struct iio_chan_spec ad4170_channel_temp=
late
> =3D {
> =C2=A0	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_CALIBBIAS) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_CALIBSCALE),
> =C2=A0	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
> =C2=A0	.scan_type =3D {
> @@ -954,6 +955,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
> =C2=A0		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> =C2=A0		*val =3D chan_info->offset_tbl[pga];
> =C2=A0		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val =3D setup->offset;

same nit...

> +		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_CALIBSCALE:
> =C2=A0		*val =3D setup->gain;
> =C2=A0		return IIO_VAL_INT;
> @@ -1083,6 +1087,25 @@ static int ad4170_set_pga(struct ad4170_state *st,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad4170_set_calib_offset(struct ad4170_state *st,
> +				=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val)
> +{
> +	struct ad4170_chan_info *chan_info =3D &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup =3D &chan_info->setup;
> +	u32 old_offset;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	old_offset =3D setup->offset;
> +	setup->offset =3D val;

Why doing the above dance?

> +
> +	ret =3D ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret)
> +		setup->offset =3D old_offset;
> +

We could update the value in here.

> +	return ret;

I guess ret > 0 is not a thing? I find it more readable:

return 0;

It makes it clear we got success :)

- Nuno S=C3=A1

> +}
> +
> =C2=A0static int ad4170_set_calib_gain(struct ad4170_state *st,
> =C2=A0				 struct iio_chan_spec const *chan, int val)
> =C2=A0{
> @@ -1111,6 +1134,8 @@ static int __ad4170_write_raw(struct iio_dev *indio=
_dev,
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		return ad4170_set_pga(st, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4170_set_calib_offset(st, chan, val);
> =C2=A0	case IIO_CHAN_INFO_CALIBSCALE:
> =C2=A0		return ad4170_set_calib_gain(st, chan, val);
> =C2=A0	default:
> @@ -1139,6 +1164,7 @@ static int ad4170_write_raw_get_fmt(struct iio_dev
> *indio_dev,
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> =C2=A0	case IIO_CHAN_INFO_CALIBSCALE:
> =C2=A0		return IIO_VAL_INT;
> =C2=A0	default:

