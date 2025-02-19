Return-Path: <linux-iio+bounces-15769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD0A3BC4B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B1B7A7B25
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA91BC073;
	Wed, 19 Feb 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya2tc+Gr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E70286291
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962843; cv=none; b=NjLPEgE5sErVY1lAoF5vMjeer9z894v8xkE2QhsKimGsAVbjhoXkbX7MQVu3zDob6lwTmztp3GAin9NkvgdPWOyG7ftesY17/dS1VzcZl/0dCtETq38InTq2zbGXxTONQSbGzULlrN7CWhS8oCuySR2b7XledjsuMGQ4kaevHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962843; c=relaxed/simple;
	bh=F528N1VukOQNed9kEL4hRW9mkU0oUmSZwiO72odX0uI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UoEMYZ/eFpHDKNS1DN/ihTkY8UrKoFZf0uYHld/gIUdUvvDgcFaSKAL6AbTI8hUR+hy+Pscg6Jc+LLfSHgMPsBumCmZkz9F4LRKsgqclE3VFhleDyG9JVyBMmjL0LibXIXQcE25ND8oz0idudHbmm0ca6BGjZc/r6LH6BKYHMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya2tc+Gr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so6060621a12.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962840; x=1740567640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZ09mQhFL8Z9Uwji5cfuZaHHPaiu3wKMJFPGX03DD/M=;
        b=Ya2tc+GrFuYo88QgTIw8CkbClbXGO9llAjSaT49/CqcOyGX1e0UqLvn8GYxc6nSdjN
         u+I8dOhDDKeNXwBycqqAewfhohsH0O1onS4amgJJrYNcbsA/txpq4bZDabrLJ9a1P26T
         a4m6LfOHrPwcwzfgneKU0+PzUHi7QZMWleRXIPc5CDUHVauQ8nEoV3/bVbSryXYGnjrj
         BCtdJGtVb4BUmVmsUfeewsGOOeyKeahJvi57FhNbBBNKsLD7NDlgdVkeyA00hJgtB49z
         xL5lO5qrTlX0x7X/5aTSkTY78xMWG7kZ429veIoVy4P3oQLIdv/Msu8dU3p8vPQoqHDV
         znwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962840; x=1740567640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZ09mQhFL8Z9Uwji5cfuZaHHPaiu3wKMJFPGX03DD/M=;
        b=tcOMJ0VYKEkbIYVVLmp3aI/q1FbQRF8mbT3E9dIXcO1zBIZsPbPDo9L74w1UPTAv5S
         F8lu4bHZJOlA6TNdn/mPvrd1a8zR7zFA2mj6C12bn514/QT55Mw3GRvDZ+vtDV+JP3PF
         h+2IYF57cxMVre3Rs5lP5lBFms9SfunTelnlm2g+yT1Dz1MF4iWt8aZkqRev3SKvhlKV
         tpo1abu7V5KimAfaZmTTeKISM0gTbLf/fcMm9gFZwJqUzR4UAyQ0LapkksTyc7ETxYj0
         rLqpHYNUWrRCu5Kt/BMOMVVa2OfGbRjzJ5Fe/gUOVKUgN3Tn1C689rBKxgy759s/VAS9
         IyYw==
X-Forwarded-Encrypted: i=1; AJvYcCXCqng7b0gTlMrv+YZgkzrjGrvIgbjvdiOqt5gv34SQrYv1XvFzTRQPSlXsyIT6NUQrguNyFCjI1qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyi31HuLmK6pzSjash8ZEn97KQ60kxAcMQMVj1pBnz9LCDVIY+
	/Yic9YOEghe226gJtCpfiZF8ErJgWNMQMheZlrR+M/UeSQ8d5nQb
X-Gm-Gg: ASbGncvuyRmwCbjvAlRv+nzyf0bdF1GlSkKOeANjNnrDLnUspx7aAJW/UJfuZwka36p
	4LV6DZ8NII8gRRtiQXkb1C49SvoQRBC9Uds0aQT5q8LFdRufhHxKDcJteqlISCNFQdN3A6rDhn3
	TDHPZsWWsiXZu4mbkjpWAbPWDpue/z8Ka7jApSMe1fP4eLFzQe/z1dE0lgInLzlLPZAlCGcy6+s
	em4Xum5iJOq/xZlVMOXfw9LhTcyxNLZjwzyXALHy9I0SkrArwlyrX2JI/cYaMjXRLjG+Fig16cV
	mg96paSk8ZQIxJZcjBpQQgJNX1UvKf7UYYcgeO4Ak3GnT6e9mpLQkB5X3VxGTNc=
X-Google-Smtp-Source: AGHT+IHessyvdyvA4Tj2xRue04Ov1CfTi4HoXAQwMsIgrm37SFgFN5Srkg7tygAwPoZOF47RJLgmTg==
X-Received: by 2002:a05:6402:254a:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5e036174763mr41375548a12.30.1739962840193;
        Wed, 19 Feb 2025 03:00:40 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba19bd1dbsm508421166b.30.2025.02.19.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:00:39 -0800 (PST)
Message-ID: <fe8be83a35aaa3d6abf4ccb32155dcc265554587.camel@gmail.com>
Subject: Re: [PATCH 17/29] iio: adc: ad7793: Factor out core of
 ad7793_write_raw() to simplify error handling
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
Date: Wed, 19 Feb 2025 11:00:43 +0000
In-Reply-To: <20250217141630.897334-18-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-18-jic23@kernel.org>
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
> Factor out everything under the direct mode claim allowing direct returns
> in error paths.=C2=A0 Switch sense of matching in the loop and use a cont=
inue
> to reduce code indent and improve readability.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7793.c | 79 +++++++++++++++++++++----------------=
---
> =C2=A01 file changed, 42 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 1b50d9643a63..861a3e44e5ad 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -462,64 +462,69 @@ static int ad7793_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> -static int ad7793_write_raw(struct iio_dev *indio_dev,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan=
,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val2,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +static int __ad7793_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> =C2=A0{
> =C2=A0	struct ad7793_state *st =3D iio_priv(indio_dev);
> -	int ret, i;
> +	int i;
> =C2=A0	unsigned int tmp;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> -		ret =3D -EINVAL;
> -		for (i =3D 0; i < ARRAY_SIZE(st->scale_avail); i++)
> -			if (val2 =3D=3D st->scale_avail[i][1]) {
> -				ret =3D 0;
> -				tmp =3D st->conf;
> -				st->conf &=3D ~AD7793_CONF_GAIN(-1);
> -				st->conf |=3D AD7793_CONF_GAIN(i);
> -
> -				if (tmp =3D=3D st->conf)
> -					break;
> -
> -				ad_sd_write_reg(&st->sd, AD7793_REG_CONF,
> -						sizeof(st->conf), st->conf);
> -				ad7793_calibrate_all(st);
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
> +			st->conf &=3D ~AD7793_CONF_GAIN(-1);
> +			st->conf |=3D AD7793_CONF_GAIN(i);
> +
> +			if (tmp =3D=3D st->conf)
> +				return 0;
> +
> +			ad_sd_write_reg(&st->sd, AD7793_REG_CONF,
> +					sizeof(st->conf), st->conf);
> +			ad7793_calibrate_all(st);
> +
> +			return 0;
> =C2=A0		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!val)
> +			return -EINVAL;
> =C2=A0
> =C2=A0		for (i =3D 0; i < 16; i++)
> =C2=A0			if (val =3D=3D st->chip_info->sample_freq_avail[i])
> =C2=A0				break;
> =C2=A0
> -		if (i =3D=3D 16) {
> -			ret =3D -EINVAL;
> -			break;
> -		}
> +		if (i =3D=3D 16)
> +			return -EINVAL;
> =C2=A0
> =C2=A0		st->mode &=3D ~AD7793_MODE_RATE(-1);
> =C2=A0		st->mode |=3D AD7793_MODE_RATE(i);
> =C2=A0		ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode),
> =C2=A0				st->mode);
> -		break;
> +		return 0;
> =C2=A0	default:
> -		ret =3D -EINVAL;
> +		return -EINVAL;
> =C2=A0	}
> +}
> +
> +static int ad7793_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __ad7793_write_raw(indio_dev, chan, val, val2, mask);
> =C2=A0
> =C2=A0	iio_device_release_direct_mode(indio_dev);
> +
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0


