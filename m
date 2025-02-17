Return-Path: <linux-iio+bounces-15634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC6A380E5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3C41891533
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3C2185A0;
	Mon, 17 Feb 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZfNXDDL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22C218EBD
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789716; cv=none; b=ipuSAoSyfLQgKbiicV11QV7rKQBmCj2JJ0Ms6w59P2G/MFBOiyJmzeKIHjFthHeKlggEf3BoZOrHI7BmCn/IavOINDq4S4IxmJB5jhyNDW2v5l8p5sDVjn5S4n0qY0Gh/qFnd60YfRbldz5q1+MwvxA0g4/cH9DCMMVEdEKMmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789716; c=relaxed/simple;
	bh=1ke2Q5xUsbGCbzNyb09hs0FGh+tz13nCVpC8Vc+Tpk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcQuGvwMhjK8IPCPI6apOFoqvpXot6iODxXw5ol+0rKDobcM6q35mqDhKy5BKoAaHJokleBQOLNJeCz11/Je30FTk7YGJ/E0NUvDYv/wx6jJTGco2bdR8ylsPY8AY2Gpt9jVWigmN29JNP77udIZV7748GPmeFaeu5oNKXtzg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZfNXDDL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4398738217aso5405115e9.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789712; x=1740394512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LMzOtP4Dhl/WDJ9bczCH/8pWV1uw616N35VKmi2hhYs=;
        b=hZfNXDDLadYYAMmgAXX08OcK/ra0Fx0PJiqpEKBD+b/EjkvQprdXI1WwrwV97xZmHJ
         9C8uIt5mbjcyGs7Zh/+OhA08BivrQMMn7nIIWwCu5VVDyZidKv5mfLObMBbOjLGrAzQ5
         H7+ABZUGl3S7u39YrdO7/kXl5nI6BVllks47/tqtZRrBRFcKMCtzJtqhOjKW4/bMYTKP
         64f4ZVXW8LZbnkI0VkLi2sv4w9CrNmSPLQvq/Wdm5TIfKSVUwSdn4V6mj7Ha9TFvtkXP
         aeqn9TaSpSKgoGRf4cz1OXfiDSd3U8lF9+mdmQlKo2/erndqVMsgjbfvzfGFyCyk/Y32
         hRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789712; x=1740394512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMzOtP4Dhl/WDJ9bczCH/8pWV1uw616N35VKmi2hhYs=;
        b=t9z4gqzE6UzqLKYm4okRJr1rmWURfTCSdS37NCMO5KuB2foQ09jtr/BKDXJvKbAjKp
         /ZTgiU6aSHVNDYAEOHrQr/gVcc/IeMei9A90Ik7nU4GJ/Oa73yuwQha2UVW2nh4kBJQW
         Soh8cza1nWpT9HBpx3aPYFBirbIA977yTuvBsezbesYpXKZnb7+KqtLrjIWdIiO7cOub
         h+9Ou0Yd2Ns/BDwu0kzldKRsw/KkoMvYTdiWrKnf475Y4kd2LP0k/eGKSnTxAJEY9gOt
         zOQOrLgKo5vlPztRClVcX2HgWSa+QsS52aCkrQZS2uFdJb2MjmIaDDRaMaeXzWB730WY
         GZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Q4cAyHNytyDEkTZlB9o7qwTl0uhRLiq7akXWAu2DDs2hQ0lB1VnF9DCqpJx0QUSRk2Zpj8L59nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcsVWGoBQrlT6vNh7T9IN8x/pgBFZpyXfOJjYT8GMAfM8ChYQ
	Xa9lV1/yMh6fm2CAsm8laELbrlsq0LHWEAoqiWU6Ux4dGlFKN+3C
X-Gm-Gg: ASbGncuu3D4xYUFkiHc2OOZMBrS4BG0so3u5rvXPosIzqeR/2dO7nkMUJwWTEO+I3MU
	oSWKofu7TZj9AX/8AQhcRnfTgprldKK5eCwuB2i3erw0YBIdS0NfMhP7+jFkuuKZD7tT8ix/RTP
	dGbPFboWK9qYIhl5ZojMdPKOHuWEVXq4BTtt5EDAgpGT5sQY7OJJ7l86hjUNCyQ4w2B4A3NBROh
	kE1JScdi8AI0nJSVEnXO+jNoIOub8iW5h6n8Pdro8+HBMGq3noG2sZrtdZv9dKRCBDvXVTgbPfd
	ttwglo+B8P2iDIPSZY40QBEHuhslf7kTKIT4XiAAqnyEHcZSbu/OxHcyQvjhXZ8=
X-Google-Smtp-Source: AGHT+IF1RVSA0qxpUyO10wFUomsbl0WDBy6V4Ci64tp42baSekRnGQxJsKYU0eXV28lE988fMSJyeA==
X-Received: by 2002:a05:600c:510d:b0:439:5a37:814b with SMTP id 5b1f17b1804b1-4396e710db7mr73645155e9.20.1739789712339;
        Mon, 17 Feb 2025 02:55:12 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267eesm58499675e9.0.2025.02.17.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:55:11 -0800 (PST)
Message-ID: <99aad0592bbf0f9049edb2e03a759dfffe662a27.camel@gmail.com>
Subject: Re: [PATCH v2 24/27] iio: dummy: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:55:15 +0000
In-Reply-To: <20250209180624.701140-25-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-25-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context. Introduce two new utility functions
> to allow for direct returns with claim and release of direct mode
> in the caller.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dummy/iio_simple_dummy.c | 119 ++++++++++++++++--------=
---
> =C2=A01 file changed, 70 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c
> b/drivers/iio/dummy/iio_simple_dummy.c
> index 09efacaf8f78..8575d4a08963 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -267,6 +267,65 @@ static const struct iio_chan_spec iio_dummy_channels=
[] =3D
> {
> =C2=A0	},
> =C2=A0};
> =C2=A0
> +static int __iio_dummy_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val)
> +{
> +	struct iio_dummy_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		if (chan->output) {
> +			/* Set integer part to cached value */
> +			*val =3D st->dac_val;
> +			return IIO_VAL_INT;
> +		} else if (chan->differential) {
> +			if (chan->channel =3D=3D 1)
> +				*val =3D st->differential_adc_val[0];
> +			else
> +				*val =3D st->differential_adc_val[1];
> +			return IIO_VAL_INT;
> +		} else {
> +			*val =3D st->single_ended_adc_val;
> +			return IIO_VAL_INT;
> +		}
> +
> +	case IIO_ACCEL:
> +		*val =3D st->accel_val;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int __iio_dummy_read_processed(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val)
> +{
> +	struct iio_dummy_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +	switch (chan->type) {
> +	case IIO_STEPS:
> +		*val =3D st->steps;
> +		return IIO_VAL_INT;
> +	case IIO_ACTIVITY:
> +		switch (chan->channel2) {
> +		case IIO_MOD_RUNNING:
> +			*val =3D st->activity_running;
> +			return IIO_VAL_INT;
> +		case IIO_MOD_WALKING:
> +			*val =3D st->activity_walking;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> =C2=A0/**
> =C2=A0 * iio_dummy_read_raw() - data read function.
> =C2=A0 * @indio_dev:	the struct iio_dev associated with this device insta=
nce
> @@ -283,59 +342,21 @@ static int iio_dummy_read_raw(struct iio_dev *indio=
_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> =C2=A0{
> =C2=A0	struct iio_dummy_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			guard(mutex)(&st->lock);
> -			switch (chan->type) {
> -			case IIO_VOLTAGE:
> -				if (chan->output) {
> -					/* Set integer part to cached value
> */
> -					*val =3D st->dac_val;
> -					return IIO_VAL_INT;
> -				} else if (chan->differential) {
> -					if (chan->channel =3D=3D 1)
> -						*val =3D st-
> >differential_adc_val[0];
> -					else
> -						*val =3D st-
> >differential_adc_val[1];
> -					return IIO_VAL_INT;
> -				} else {
> -					*val =3D st->single_ended_adc_val;
> -					return IIO_VAL_INT;
> -				}
> -
> -			case IIO_ACCEL:
> -				*val =3D st->accel_val;
> -				return IIO_VAL_INT;
> -			default:
> -				return -EINVAL;
> -			}
> -		}
> -		unreachable();
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D __iio_dummy_read_raw(indio_dev, chan, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	case IIO_CHAN_INFO_PROCESSED:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			guard(mutex)(&st->lock);
> -			switch (chan->type) {
> -			case IIO_STEPS:
> -				*val =3D st->steps;
> -				return IIO_VAL_INT;
> -			case IIO_ACTIVITY:
> -				switch (chan->channel2) {
> -				case IIO_MOD_RUNNING:
> -					*val =3D st->activity_running;
> -					return IIO_VAL_INT;
> -				case IIO_MOD_WALKING:
> -					*val =3D st->activity_walking;
> -					return IIO_VAL_INT;
> -				default:
> -					return -EINVAL;
> -				}
> -			default:
> -				return -EINVAL;
> -			}
> -		}
> -		unreachable();
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D __iio_dummy_read_processed(indio_dev, chan, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	case IIO_CHAN_INFO_OFFSET:
> =C2=A0		/* only single ended adc -> 7 */
> =C2=A0		*val =3D 7;


